Index: ChangeLog
===================================================================
RCS file: /cvs/public/mcs/mcs/ChangeLog,v
retrieving revision 1.1604
diff -u -r1.1604 ChangeLog
--- ChangeLog	2 Jul 2004 10:06:01 -0000	1.1604
+++ ChangeLog	6 Jul 2004 18:10:20 -0000
@@ -1,3 +1,30 @@
+2004-07-07  Atsushi Enomoto  <atsushi@ximian.com>
+
+	all things are for /doc support:
+
+	* driver.cs:
+	  Added command line option --document (same as /doc).
+	  Report error 2006 instead of 5 for missing file name for /doc.
+	  Added call to RootContext.FixupDocument() after its tree resolution.
+	* rootcontext.cs :
+	  Added NeedDocument and XmlDocumentation (values are passed only 
+	  when /doc or --document was specified).
+	  Added static FixupDocument().
+	* decl.cs: Added Documentation element field for MemberCore.
+	* class.cs:
+	  Added virtual DeclSpace.FixupDocument().
+	  Added overriden FixupDocument() for TypeContainer.
+	  Added virtual MemberBase.FixupDocument().
+	  Added overriden FixupDocument() for MethodCore and Operator.
+	* cs-parser.jay:
+	  Added lines to fill Documentation element for field, constant,
+	  property, indexer, method, constructor, destructor, operator, event
+	  and class, struct, interface, delegate, enum.
+	  Added lines to warn incorrect comment (it is far from complete).
+	* cs-tokenizer.cs:
+	  Added support for picking up documentation.
+	  (for ///, and roughly for /** .. */)
+
 2004-07-02  Raja R Harinath  <rharinath@novell.com>
 
 	* ecore.cs (DoSimpleNameResolve): Expand CS0038 check to all names
Index: class.cs
===================================================================
RCS file: /cvs/public/mcs/mcs/class.cs,v
retrieving revision 1.466
diff -u -r1.466 class.cs
--- class.cs	24 Jun 2004 06:58:00 -0000	1.466
+++ class.cs	6 Jul 2004 18:10:21 -0000
@@ -2324,8 +2324,38 @@
 							"not override Object.GetHashCode ()");
 			}
 		}
-		
-		
+
+		public override void FixupDocument ()
+		{
+			if (default_static_constructor != null)
+				default_static_constructor.FixupDocument (this);
+			
+			if (methods != null)
+				foreach (Method m in methods)
+					m.FixupDocument (this);
+
+			if (operators != null)
+				foreach (Operator o in operators)
+					o.FixupDocument (this);
+
+			if (properties != null)
+				foreach (Property p in properties)
+					p.FixupDocument (this);
+
+			if (indexers != null){
+				foreach (Indexer ix in indexers)
+					ix.FixupDocument (this);
+			}
+			
+			if (fields != null)
+				foreach (Field f in fields)
+					f.FixupDocument (this);
+
+			if (events != null){
+				foreach (Event e in Events)
+					e.FixupDocument (this);
+			}
+		}
 	}
 
 	public class ClassOrStruct : TypeContainer {
@@ -2686,6 +2716,26 @@
 			return cc;
 		}
 
+		public override void FixupDocument (TypeContainer container)
+		{
+			if (Documentation != null) {
+				string paramSpec = null;
+				Parameter [] plist = Parameters.FixedParameters;
+				if (plist != null) {
+					foreach (Parameter p in plist)
+						paramSpec += (paramSpec != null ? "," : "(") + container.ResolveType (p.TypeName, false, Location).FullName;
+				}
+
+				if (paramSpec != null)
+					paramSpec += ")";
+				string head = this is PropertyBase ? "P:" : "M:";
+				string name = this is Constructor ? "#ctor" : Name;
+				Documentation.SetAttribute ("name", head + container.Name + "." + name + paramSpec);
+
+				Documentation = null; // release the reference
+			}
+		}
+
 		protected override void VerifyObsoleteAttribute()
 		{
 			base.VerifyObsoleteAttribute ();
@@ -4424,6 +4474,15 @@
 			return false;
 		}
 
+		/// <summary>
+		///   Fixups XML documentation type references
+		/// </summary>
+		public virtual void FixupDocument (TypeContainer container)
+		{
+			if (Documentation != null)
+				Documentation = null; // release the reference
+		}
+
 		protected override void VerifyObsoleteAttribute()
 		{
 			CheckUsageOfObsoleteAttribute (MemberType);
@@ -6353,6 +6412,17 @@
 			
 			OperatorMethod.Emit (container);
 			Block = null;
+		}
+
+		public override void FixupDocument (TypeContainer container)
+		{
+			if (Documentation != null) {
+				string para1 = container.ResolveType (FirstArgType, false, Location).FullName;
+				string para2 = SecondArgType == null ? null : container.ResolveType (SecondArgType, false, Location).FullName;
+				Documentation.SetAttribute ("name", "M:" + container.Name + "." + Name + "(" + para1 + (para2 != null ? "," + para2 : null) + ")");
+
+				Documentation = null; // release the reference
+			}
 		}
 
 		public static string GetName (OpType ot)
Index: cs-parser.jay
===================================================================
RCS file: /cvs/public/mcs/mcs/cs-parser.jay,v
retrieving revision 1.303
diff -u -r1.303 cs-parser.jay
--- cs-parser.jay	24 Jun 2004 08:09:25 -0000	1.303
+++ cs-parser.jay	6 Jul 2004 18:10:21 -0000
@@ -18,6 +18,7 @@
 //   Run memory profiler with parsing only, and consider dropping 
 //   arraylists where not needed.   Some pieces can use linked lists.
 //
+using System.Xml;
 using System.Text;
 using System.IO;
 using System;
@@ -90,6 +91,12 @@
 		/// The current file.
 		///
 		SourceFile file;
+
+		///
+		/// Temporary Xml documentation cache
+		///
+		XmlElement tmpComment;
+
 		
 		
 		/// Current attribute target
@@ -340,6 +347,9 @@
 namespace_declaration
 	: opt_attributes NAMESPACE namespace_or_type_name
 	{
+		if (Lexer.xml_comment_buffer.Length > 0)
+			WarnIncorrectXmlComment ("namespace declaration");
+
 		if ($1 != null) {
 			Report.Error(1518, Lexer.Location, "Attributes cannot be applied to namespaces."
 					+ " Expected class, delegate, enum, interface, or struct");
@@ -718,6 +728,9 @@
 					 (int) $2, (Attributes) $1, lexer.Location);
 		current_container = new_struct;
 		RootContext.Tree.RecordDecl (full_struct_name, new_struct);
+
+		if (Lexer.xml_comment_buffer.Length > 0)
+			new_struct.Documentation = CreateMemberComment ("T:" + full_struct_name);
 	  }
 	  opt_class_base
 	  struct_body
@@ -786,6 +799,9 @@
 				(Attributes) $1, l);
 
 			CheckDef (current_container.AddConstant (c), c.Name, l);
+
+			if (Lexer.xml_comment_buffer.Length > 0)
+				c.Documentation = CreateMemberComment ("F:" + MakeName (c.Name));
 		}
 	  }
 	;
@@ -838,6 +854,8 @@
 						 (Attributes) $1, l);
 
 			CheckDef (current_container.AddField (field), field.Name, l);
+			if (Lexer.xml_comment_buffer.Length > 0)
+				field.Documentation = CreateMemberComment ("F:" + MakeName (field.Name));
 		}
 	  }
 	| opt_attributes
@@ -954,6 +972,9 @@
 
 		current_local_parameters = (Parameters) $6;
 
+		if (Lexer.xml_comment_buffer.Length > 0)
+			method.Documentation = CreateMemberComment ("M:" + MakeName ((string) $4));
+
 		$$ = method;
 	  }
 	| opt_attributes
@@ -967,6 +988,10 @@
 					    (Attributes) $1, lexer.Location);
 
 		current_local_parameters = (Parameters) $6;
+
+		if (Lexer.xml_comment_buffer.Length > 0)
+			method.Documentation = CreateMemberComment ("M:" + MakeName ((string) $4));
+
 		$$ = method;
 	  }
 	| opt_attributes
@@ -1107,6 +1132,9 @@
 		$$ = lexer.Location;
 
 		iterator_container = SimpleIteratorContainer.GetSimple ();
+
+		if (Lexer.xml_comment_buffer.Length > 0)
+			tmpComment = CreateMemberComment ("P:" + MakeName ((string) $4));
 	  }
 	  accessor_declarations 
 	  {
@@ -1124,10 +1152,14 @@
 				     (string) $4, (Attributes) $1, get_block, set_block, loc);
 		if (SimpleIteratorContainer.Simple.Yields)
 			prop.SetYields ();
-		
 		CheckDef (current_container.AddProperty (prop), prop.Name, loc);
 		implicit_value_parameter_type = null;
 		iterator_container = null;
+
+		prop.Documentation = tmpComment;
+
+		if (Lexer.xml_comment_buffer.Length > 0)
+			WarnIncorrectXmlComment ("property definition body");
 	  }
 	;
 
@@ -1230,6 +1262,8 @@
 		current_interface = new_interface;
 		current_container = new_interface;
 		RootContext.Tree.RecordDecl (full_interface_name, new_interface);
+		if (Lexer.xml_comment_buffer.Length > 0)
+			new_interface.Documentation = CreateMemberComment ("T:" + full_interface_name);
 	  }
 	  opt_class_base
 	  interface_body opt_semicolon
@@ -1385,9 +1419,11 @@
 	  {
 		InterfaceAccessorInfo info = (InterfaceAccessorInfo) $10;
 
-		$$ = new Indexer (current_container, (Expression) $3, null, (int) $2, true,
+		Indexer indexer = new Indexer (current_container, (Expression) $3, null, (int) $2, true,
 				  (Parameters) $6, (Attributes) $1, info.Get, info.Set,
 				  lexer.Location);
+		indexer.Documentation = tmpComment;
+		$$ = indexer;
 	  }
 	;
 
@@ -1402,6 +1438,7 @@
 		
 		Operator op = new Operator (decl.optype, decl.ret_type, (int) $2, decl.arg1type, decl.arg1name,
 					    decl.arg2type, decl.arg2name, (Block) $5, (Attributes) $1, decl.location);
+		op.Documentation = tmpComment;
 
 		if (SimpleIteratorContainer.Simple.Yields)
 			op.SetYields ();
@@ -1432,12 +1469,16 @@
 			op = Operator.OpType.UnaryNegation;
 
 		Parameter [] pars = new Parameter [1];
+		Expression type = (Expression) $5;
 
-		pars [0] = new Parameter ((Expression) $5, (string) $6, Parameter.Modifier.NONE, null);
+		pars [0] = new Parameter (type, (string) $6, Parameter.Modifier.NONE, null);
 
 		current_local_parameters = new Parameters (pars, null, lexer.Location);
 
-		$$ = new OperatorDeclaration (op, (Expression) $1, (Expression) $5, (string) $6,
+		if (Lexer.xml_comment_buffer.Length > 0)
+			tmpComment = CreateMemberComment ("M:" + MakeName ("op_" + op) + "(" + type +")");
+
+		$$ = new OperatorDeclaration (op, (Expression) $1, type, (string) $6,
 					      null, null, lexer.Location);
 	}
 	| type OPERATOR overloadable_operator
@@ -1446,14 +1487,22 @@
 	  	type IDENTIFIER 
 	  CLOSE_PARENS
         {
-	       CheckBinaryOperator ((Operator.OpType) $3);
+		Operator.OpType op = (Operator.OpType) $3;
+
+	       CheckBinaryOperator (op);
 
 	       Parameter [] pars = new Parameter [2];
 
-	       pars [0] = new Parameter ((Expression) $5, (string) $6, Parameter.Modifier.NONE, null);
-	       pars [1] = new Parameter ((Expression) $8, (string) $9, Parameter.Modifier.NONE, null);
+		Expression typeL = (Expression) $5;
+		Expression typeR = (Expression) $8;
+
+	       pars [0] = new Parameter (typeL, (string) $6, Parameter.Modifier.NONE, null);
+	       pars [1] = new Parameter (typeR, (string) $9, Parameter.Modifier.NONE, null);
 
 	       current_local_parameters = new Parameters (pars, null, lexer.Location);
+
+		if (Lexer.xml_comment_buffer.Length > 0)
+			tmpComment = CreateMemberComment ("M:" + MakeName ("op_" + op) + "(" + MakeName (typeL.ToString ()) +"," + MakeName (typeR.ToString ()) + ")");
 	       
 	       $$ = new OperatorDeclaration ((Operator.OpType) $3, (Expression) $1, 
 					     (Expression) $5, (string) $6,
@@ -1534,6 +1583,9 @@
 		c.OptAttributes = (Attributes) $1;
 		c.ModFlags = (int) $2;
 	
+		if (Lexer.xml_comment_buffer.Length > 0)
+			c.Documentation = CreateMemberComment ("M:" + MakeName ("#ctor"));
+
 		if (c.Name == current_container.Basename){
 			if ((c.ModFlags & Modifiers.STATIC) != 0){
 				if ((c.ModFlags & Modifiers.Accessibility) != 0){
@@ -1644,6 +1696,8 @@
 			Method d = new Destructor (
 				current_container, TypeManager.system_void_expr, m, "Finalize", 
 				new Parameters (null, null, l), (Attributes) $1, l);
+			if (Lexer.xml_comment_buffer.Length > 0)
+				d.Documentation = CreateMemberComment ("M:" + MakeName ("Finalize"));
 		  
 			d.Block = (Block) $7;
 			CheckDef (current_container.AddMethod (d), d.Name, d.Location);
@@ -1664,6 +1718,8 @@
 
 			CheckDef (current_container.AddEvent (e), e.Name, e.Location);
 				       
+			if (Lexer.xml_comment_buffer.Length > 0)
+				e.Documentation = CreateMemberComment ("E:" + MakeName (e.Name));
 		}
 	  }
 	| opt_attributes
@@ -1692,6 +1748,9 @@
 			Event e = new EventProperty (current_container, (Expression) $4, (int) $2, false, (string) $5,
 					     null, (Attributes) $1, (Accessor) pair.First, (Accessor) pair.Second,
 					     loc);
+
+			if (Lexer.xml_comment_buffer.Length > 0)
+				e.Documentation = CreateMemberComment ("E:" + MakeName ((string) $5));
 			
 			CheckDef (current_container.AddEvent (e), e.Name, loc);
 			implicit_value_parameter_type = null;
@@ -1704,6 +1763,10 @@
 			Report.Error (71, lexer.Location, "Explicit implementation of events requires property syntax");
 		else 
 			Report.Error (71, lexer.Location, "Event declaration should use property syntax");
+
+		// FIXME: where to attach? (or is it allowed?)
+		if (Lexer.xml_comment_buffer.Length > 0)
+			CreateMemberComment ("E:" + MakeName ((string) $5));
 	  }
 	;
 
@@ -1801,6 +1864,7 @@
 		indexer = new Indexer (current_container, decl.type, decl.interface_type,
 				       (int) $2, false, decl.param_list, (Attributes) $1,
 				       get_block, set_block, loc);
+		indexer.Documentation = tmpComment;
 
 		// Note that there is no equivalent of CheckDef for this case
 		// We shall handle this in semantic analysis
@@ -1823,6 +1887,10 @@
 		} else if (pars.FixedParameters == null && pars.ArrayParameter == null){
 			Report.Error (1551, lexer.Location, "Indexers must have at least one parameter");
 		}
+		// Parameters will be fixed up after RootContext.ResolveType
+		if (Lexer.xml_comment_buffer.Length > 0)
+			// missing arglist is going to be filled later
+			tmpComment = CreateMemberComment ("P:" + MakeName ("Item"));
 
 		$$ = new IndexerDeclaration ((Expression) $1, null, pars);
 	  }
@@ -1836,6 +1904,10 @@
 		} else if (pars.FixedParameters == null && pars.ArrayParameter == null){
 			Report.Error (1551, lexer.Location, "Indexers must have at least one parameter");
 		}
+
+		if (Lexer.xml_comment_buffer.Length > 0)
+			tmpComment = CreateMemberComment ("P:" + MakeName ("Item"));
+
 		$$ = new IndexerDeclaration ((Expression) $1, $2.ToString (), pars);
 	  }
 	;
@@ -1854,6 +1926,9 @@
 		Enum e = new Enum (current_namespace, current_container, (Expression) $5, (int) $2,
 				   full_name, (Attributes) $1, enum_location);
 		
+		if (Lexer.xml_comment_buffer.Length > 0)
+			e.Documentation = CreateMemberComment ("T:" + full_name);
+
 		foreach (VariableDeclaration ev in (ArrayList) $6) {
 			Location loc = (Location) ev.Location;
 
@@ -1929,9 +2004,14 @@
 	  SEMICOLON
 	  {
 		Location l = lexer.Location;
+		string full_delegate_name = MakeName ((string) $5);
+
 		Delegate del = new Delegate (current_namespace, current_container, (Expression) $4,
-					     (int) $2, MakeName ((string) $5), (Parameters) $7, 
+					     (int) $2, full_delegate_name, (Parameters) $7, 
 					     (Attributes) $1, l);
+
+		if (Lexer.xml_comment_buffer.Length > 0)
+			del.Documentation = CreateMemberComment ("T:" + full_delegate_name);
 		  
 		CheckDef (current_container.AddDelegate (del), del.Name, l);
 	  }	
@@ -1944,11 +2024,16 @@
 	  SEMICOLON
 	  {
 		Location l = lexer.Location;
+		string full_delegate_name = MakeName ((string) $5);
+
 		Delegate del = new Delegate (
 			current_namespace, current_container,
-			TypeManager.system_void_expr, (int) $2, MakeName ((string) $5), 
+			TypeManager.system_void_expr, (int) $2, full_delegate_name, 
 			(Parameters) $7, (Attributes) $1, l);
 
+		if (Lexer.xml_comment_buffer.Length > 0)
+			del.Documentation = CreateMemberComment ("T:" + full_delegate_name);
+
 		CheckDef (current_container.AddDelegate (del), del.Name, l);
 	  }
 	;
@@ -2907,6 +2992,9 @@
 				       (Attributes) $1, lexer.Location);
 		current_container = new_class;
 		RootContext.Tree.RecordDecl (name, new_class);
+
+		if (Lexer.xml_comment_buffer.Length > 0)
+			new_class.Documentation = CreateMemberComment ("T:" + name);
 	  }
 	  opt_class_base
 	  class_body 
@@ -4356,6 +4444,34 @@
 void CheckIdentifierToken (int yyToken)
 {
 	CheckToken (1041, yyToken, "Identifier expected");
+}
+
+XmlElement CreateMemberComment (string fullyQualifiedName)
+{
+	XmlDocument doc = RootContext.XmlDocumentation;
+	if (doc == null) {
+		RootContext.XmlDocumentation = doc = new XmlDocument ();
+		doc.AppendChild (doc.CreateElement ("doc"));
+		doc.DocumentElement.AppendChild (doc.CreateElement ("members"));
+	}
+	XmlElement el = null;
+	try {
+		el = doc.CreateElement ("member");
+		el.InnerXml = Lexer.ConsumeXmlComment ();
+		el.SetAttribute ("name", fullyQualifiedName);
+		doc.DocumentElement.LastChild.AppendChild (el);
+	} catch (XmlException ex) {
+		Report.Warning (1570, Lexer.Location, "XML comment is not well-formed: " + ex.Message);
+		XmlComment com = doc.CreateComment ("FIXME: Invalid documentation markup was found for member " + fullyQualifiedName);
+		doc.DocumentElement.LastChild.AppendChild (com);
+	}
+	return el;
+}
+
+void WarnIncorrectXmlComment (string token_type)
+{
+	Report.Warning (1587, Lexer.Location, "XML comment is not acceptable on  " + token_type);
+	Lexer.ConsumeXmlComment ();
 }
 
 /* end end end */
Index: cs-tokenizer.cs
===================================================================
RCS file: /cvs/public/mcs/mcs/cs-tokenizer.cs,v
retrieving revision 1.111
diff -u -r1.111 cs-tokenizer.cs
--- cs-tokenizer.cs	10 Jun 2004 18:11:31 -0000	1.111
+++ cs-tokenizer.cs	6 Jul 2004 18:10:21 -0000
@@ -41,6 +41,8 @@
 		bool handle_get_set = false;
 		bool handle_remove_add = false;
 		bool handle_assembly = false;
+		public StringBuilder xml_comment_buffer;
+		int xmlCommentSavePoint;
 
 		//
 		// Whether tokens have been seen on this line
@@ -133,7 +135,21 @@
 				handle_remove_add = value;
 			}
 		}
-		
+
+		public string ConsumeXmlComment ()
+		{
+			string ret = null;
+			if (xmlCommentSavePoint > 0) {
+				ret = xml_comment_buffer.ToString (0, xmlCommentSavePoint);
+				xml_comment_buffer.Remove (0, xmlCommentSavePoint);
+			} else {
+				ret = xml_comment_buffer.ToString ();
+				xml_comment_buffer.Length = 0;
+			}
+			xmlCommentSavePoint = 0;
+			return ret;
+		}
+
 		//
 		// Class variables
 		// 
@@ -361,6 +377,8 @@
 					define (def);
 			}
 
+			xml_comment_buffer = new StringBuilder ();
+
 			//
 			// FIXME: This could be `Location.Push' but we have to
 			// find out why the MS compiler allows this
@@ -662,7 +680,7 @@
 			if (c != -1){
 				bool scanning = true;
 				do {
-					switch (c){
+					switch ((char) c){
 					case 'U': case 'u':
 						if (is_unsigned)
 							scanning = false;
@@ -1705,8 +1723,18 @@
 			//
 			if (s >= 'a' || s == '_'){
 				int keyword = GetKeyword (id_builder, pos);
-				if (keyword != -1 && !quoted)
+				if (keyword != -1 && !quoted) {
+					switch (keyword) {
+					case Token.CLASS:
+					case Token.STRUCT:
+					case Token.INTERFACE:
+					case Token.ENUM:
+					case Token.DELEGATE:
+						push_xml_comment ();
+						break;
+					}
 					return keyword;
+				}
 			}
 
 			//
@@ -1771,6 +1799,10 @@
 				
 					if (d == '/'){
 						getChar ();
+						if (RootContext.NeedDocument && peekChar () == '/') {
+							getChar ();
+							handle_xml_comment ();
+						}
 						while ((d = getChar ()) != -1 && (d != '\n') && d != '\r')
 							col++;
 						if (d == '\n'){
@@ -1783,6 +1815,16 @@
 						continue;
 					} else if (d == '*'){
 						getChar ();
+						bool docAppend = false;
+						if (RootContext.NeedDocument && peekChar () == '*') {
+							getChar ();
+							// But when it is /**/, just do nothing.
+							if (peekChar () == '/') {
+								getChar ();
+								continue;
+							}
+							docAppend = true;
+						}
 
 						while ((d = getChar ()) != -1){
 							if (d == '*' && peekChar () == '/'){
@@ -1790,6 +1832,9 @@
 								col++;
 								break;
 							}
+							if (docAppend)
+								xml_comment_buffer.Append ((char) d);
+							
 							if (d == '\n'){
 								line++;
 								ref_line++;
@@ -1944,6 +1989,24 @@
 			}
 
 			return Token.EOF;
+		}
+
+		private void handle_xml_comment ()
+		{
+			int c;
+			while ((c = peekChar ()) != -1 && (c != '\n') && c != '\r') {
+				col++;
+				xml_comment_buffer.Append ((char) getChar ());
+			}
+		}
+
+		private void push_xml_comment ()
+		{
+#if DEBUG
+			if (xmlCommentSavePoint > 0)
+				Console.Error.WriteLine ("WARNING!! Comments are not consumed for previous target. Current comment is " + xml_comment_buffer);
+#endif
+			xmlCommentSavePoint = xml_comment_buffer.Length;
 		}
 
 		public void cleanup ()
Index: decl.cs
===================================================================
RCS file: /cvs/public/mcs/mcs/decl.cs,v
retrieving revision 1.125
diff -u -r1.125 decl.cs
--- decl.cs	7 Jun 2004 19:09:51 -0000	1.125
+++ decl.cs	6 Jul 2004 18:10:21 -0000
@@ -16,6 +16,7 @@
 using System.Globalization;
 using System.Reflection.Emit;
 using System.Reflection;
+using System.Xml;
 
 namespace Mono.CSharp {
 
@@ -39,6 +40,11 @@
 		/// </summary>
 		public readonly Location Location;
 
+		/// <summary>
+		///   XML documentation comment
+		/// </summary>
+		public XmlElement Documentation;
+
 		[Flags]
 		public enum Flags {
 			Obsolete_Undetected = 1,		// Obsolete attribute has not been detected yet
@@ -1125,6 +1131,12 @@
 			}
 
 			return true;
+		}
+		
+		public virtual void FixupDocument ()
+		{
+			if (Documentation != null)
+				Documentation = null; // release the reference
 		}
 
 		protected override string[] ValidAttributeTargets {
Index: driver.cs
===================================================================
RCS file: /cvs/public/mcs/mcs/driver.cs,v
retrieving revision 1.195
diff -u -r1.195 driver.cs
--- driver.cs	22 Jun 2004 15:06:48 -0000	1.195
+++ driver.cs	6 Jul 2004 18:10:22 -0000
@@ -17,6 +17,7 @@
 	using System.IO;
 	using System.Text;
 	using System.Globalization;
+	using System.Xml;
 	using System.Diagnostics;
 	using Mono.Languages;
 
@@ -102,6 +103,11 @@
 		static Encoding encoding;
 
 		//
+		// XML Comment documentation
+		//
+		static string xml_documentation_file;
+
+		//
 		// Whether the user has specified a different encoder manually
 		//
 		static bool using_default_encoder = true;
@@ -229,6 +235,8 @@
 				"   -nostdlib[+|-]     Does not load core libraries\n" +
 				"   -nowarn:W1[,W2]    Disables one or more warnings\n" + 
 				"   -out:FNAME         Specifies output file\n" +
+				"   -doc:XMLFILE         Generates xml documentation into specified file\n" +
+				"   --parse            Only parses the source file\n" +
 				"   -pkg:P1[,Pn]       References packages P1..Pn\n" + 
 				"   --expect-error X   Expect that error X will be encountered\n" +
 				"   -recurse:SPEC      Recursively compiles the files in SPEC ([dir]/file)\n" + 
@@ -733,6 +741,16 @@
 				SetOutputFile (args [++i]);
 				return true;
 				
+			case "--document":
+				int docNameStart = args [i].IndexOf (':') + 1;
+				if (docNameStart == 0){
+					Report.Error (2006, "Missing ':<filename>' to --document");
+					Environment.Exit (1);
+				}
+				xml_documentation_file = args [i].Substring (docNameStart);
+				RootContext.NeedDocument = true;
+				return true;
+				
 			case "--checked":
 				RootContext.Checked = true;
 				return true;
@@ -1106,10 +1124,11 @@
 			}
 			case "/doc": {
 				if (value == ""){
-					Report.Error (5, arg + " requires an argument");
+					Report.Error (2006, arg + " requires an argument");
 					Environment.Exit (1);
 				}
-				// TODO handle the /doc argument to generate xml doc
+				xml_documentation_file = value;
+				RootContext.NeedDocument = true;
 				return true;
 			}
 			case "/lib": {
@@ -1525,6 +1544,22 @@
 			if (timestamps)
 				ShowTime ("Resolving tree");
 			RootContext.ResolveTree ();
+			if (RootContext.NeedDocument) {
+				RootContext.FixupDocument ();
+
+				XmlDocument doc = RootContext.XmlDocumentation;
+				XmlElement el = doc.CreateElement ("assembly");
+				string asmName = Path.ChangeExtension (output_file, null);
+				el.InnerXml = "<name>" + asmName + "</name>";
+				doc.DocumentElement.InsertAfter (el, null);
+
+				XmlTextWriter w = new XmlTextWriter (xml_documentation_file, encoding);
+				w.Formatting = Formatting.Indented;
+				doc.Save (w);
+				w.Close ();
+				RootContext.XmlDocumentation = null;
+			}
+
 			if (Report.Errors > 0)
 				return false;
 			if (timestamps)
@@ -1723,7 +1758,6 @@
 #endif
 			return (Report.Errors == 0);
 		}
-
 	}
 
 	//
Index: rootcontext.cs
===================================================================
RCS file: /cvs/public/mcs/mcs/rootcontext.cs,v
retrieving revision 1.140
diff -u -r1.140 rootcontext.cs
--- rootcontext.cs	14 Jun 2004 14:34:12 -0000	1.140
+++ rootcontext.cs	6 Jul 2004 18:10:22 -0000
@@ -13,6 +13,7 @@
 using System.Reflection;
 using System.Reflection.Emit;
 using System.Diagnostics;
+using System.Xml;
 
 namespace Mono.CSharp {
 
@@ -77,6 +78,10 @@
 		public static string StrongNameKeyContainer;
 		public static bool StrongNameDelaySign = false;
 
+		// If set, enable XML documentation generation
+		public static bool NeedDocument = false;
+		public static XmlDocument XmlDocumentation;
+
 		//
 		// Constructor
 		//
@@ -176,6 +181,28 @@
 			if (root.Enums != null)
 				foreach (Enum e in root.Enums)
 					e.DefineType ();
+		}
+
+		static public void FixupDocument ()
+		{
+			TypeContainer root = Tree.Types;
+
+			ArrayList ifaces = root.Interfaces;
+			if (ifaces != null){
+				foreach (Interface i in ifaces) 
+					i.FixupDocument ();
+			}
+
+			foreach (TypeContainer tc in root.Types)
+				tc.FixupDocument ();
+
+			if (root.Delegates != null)
+				foreach (Delegate d in root.Delegates) 
+					d.FixupDocument ();
+
+			if (root.Enums != null)
+				foreach (Enum e in root.Enums)
+					e.FixupDocument ();
 		}
 
 		static void Error_TypeConflict (string name, Location loc)