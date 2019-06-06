? gc.log
? mcs-doc-20041015.diff
? mcs-testing.xml
? old-patches
? profile-gen-doc.txt
? profile-no-doc.txt
? profile-with-doc.txt
Index: ChangeLog
===================================================================
RCS file: /cvs/public/mcs/mcs/ChangeLog,v
retrieving revision 1.1767
diff -u -r1.1767 ChangeLog
--- ChangeLog	13 Oct 2004 09:06:16 -0000	1.1767
+++ ChangeLog	15 Oct 2004 20:57:21 -0000
@@ -1,3 +1,29 @@
+2004-10-13  Atsushi Enomoto  <atsushi@ximian.com>
+
+	all things are for /doc support:
+
+	* driver.cs:
+	  Handle /doc command line option.
+	  Report error 2006 instead of 5 for missing file name for /doc.
+	  Added call to RootContext.FixupDocument() after type definition.
+	* rootcontext.cs :
+	  Added NeedDocument and XmlDocumentation (values are passed only 
+	  when /doc was specified).
+	  Added StoredDocuments() to cache <include>d xml comment documents.
+	  Added static FixupDocument().
+	* decl.cs:
+	  Added Documentation field and FixupDocument() to MemberCore.
+	* class.cs:
+	  Added FixupDocument() on TypeContainer, MethodCore and Operator.
+	* cs-parser.jay:
+	  Added lines to fill Documentation element for field, constant,
+	  property, indexer, method, constructor, destructor, operator, event
+	  and class, struct, interface, delegate, enum.
+	  Added lines to warn incorrect comment (it is far from complete).
+	* cs-tokenizer.cs:
+	  Added support for picking up documentation.
+	  (for ///, and roughly for /** .. */)
+
 2004-10-13  Raja R Harinath  <rharinath@novell.com>
 
 	Fix #65816.
@@ -16851,4 +16877,3 @@
 	falseStatements always have valid values. 
 
 	* cs-parser.jay: Use System.CodeDOM now.
-
Index: class.cs
===================================================================
RCS file: /cvs/public/mcs/mcs/class.cs,v
retrieving revision 1.519
diff -u -r1.519 class.cs
--- class.cs	13 Oct 2004 09:06:16 -0000	1.519
+++ class.cs	15 Oct 2004 20:57:21 -0000
@@ -37,6 +37,7 @@
 using System.Runtime.CompilerServices;
 using System.Runtime.InteropServices;
 using System.Text;
+using System.Xml;
 
 using Mono.CompilerServices.SymbolWriter;
 
@@ -2402,6 +2403,51 @@
 			return FindMembers (mt, bf | BindingFlags.DeclaredOnly, null, null);
 		}
 
+		/// <summary>
+		/// Handles fixup of member names on those xml doc comments.
+		/// </summary>
+		public override void FixupDocument (DeclSpace ds)
+		{
+			base.FixupDocument (ds);
+
+			if (default_static_constructor != null)
+				default_static_constructor.FixupDocument (this);
+
+			if (Enums != null)
+				foreach (Enum en in Enums)
+					en.FixupDocument (this);
+
+			if (Types != null)
+				foreach (TypeContainer tc in Types)
+					tc.FixupDocument (this);
+
+			if (Methods != null)
+				foreach (Method m in Methods)
+					m.FixupDocument (this);
+
+			if (Operators != null)
+				foreach (Operator o in Operators)
+					o.FixupDocument (this);
+
+			if (Properties != null)
+				foreach (Property p in Properties)
+					p.FixupDocument (this);
+
+			if (Indexers != null){
+				foreach (Indexer ix in Indexers)
+					ix.FixupDocument (this);
+			}
+			
+			if (Fields != null)
+				foreach (Field f in Fields)
+					f.FixupDocument (this);
+
+			if (Events != null){
+				foreach (Event e in Events)
+					e.FixupDocument (this);
+			}
+		}
+
 		public virtual IMemberContainer ParentContainer {
 			get {
 				return parent_container;
@@ -3267,6 +3313,48 @@
 			return true;
 		}
 
+		public override void FixupDocument (DeclSpace ds)
+		{
+			if (Documentation != null) {
+				Hashtable paramTags = new Hashtable ();
+				foreach (XmlElement pelem in Documentation.SelectNodes ("param")) {
+					int i;
+					string xname = pelem.GetAttribute ("name");
+					if (xname == "")
+						continue; // really? but MS looks doing so
+					if (xname != "" && Parameters.GetParameterByName (xname, out i) == null)
+						Report.Warning (1572, 2, Location, "XML comment on '{0}' has a 'param' tag for '{1}', but there is no such parameter.", Name, xname);
+					else if (paramTags [xname] != null)
+						Report.Warning (1571, 2, Location, "XML comment on '{0}' has a duplicate param tag for '{1}'", Name, xname);
+					paramTags [xname] = pelem;
+				}
+				Parameter [] plist = Parameters.FixedParameters;
+				Parameter parr = Parameters.ArrayParameter;
+				string paramSpec = String.Empty;
+				if (plist != null) {
+					StringBuilder psb = new StringBuilder ();
+					foreach (Parameter p in plist) {
+						psb.Append (psb.Length != 0 ? "," : "(");
+						psb.Append (p.ParameterType.FullName.Replace ("+", "."));
+						if (paramTags.Count > 0 && paramTags [p.Name] == null)
+							Report.Warning (1573, 4, Location, "Parameter '{0}' has no matching param tag in the XML comment for '{1}' (but other parameters do)", Name, p.Name);
+					}
+					psb.Append (")");
+					paramSpec = psb.ToString ();
+				}
+				else if (parr != null)
+					paramSpec = String.Concat (
+						"(",
+						parr.ParameterType.FullName.Replace ("+", "."),
+						")");
+
+				string head = this is PropertyBase ? "P:" : "M:";
+				string name = this is Constructor ? "#ctor" : Name;
+				Documentation.SetAttribute ("name", String.Concat (head, ds.Name, ".", name, paramSpec));
+			}
+			base.FixupDocument (ds);
+		}
+
 		protected override void VerifyObsoleteAttribute()
 		{
 			base.VerifyObsoleteAttribute ();
@@ -6913,6 +7001,21 @@
 			
 			OperatorMethod.Emit ();
 			Block = null;
+		}
+
+		/// <summary>
+		/// Filles fullname on the xml doc comments if exists.
+		/// </summary>
+		public override void FixupDocument (DeclSpace ds)
+		{
+			if (Documentation != null) {
+//				string para1 = container.ResolveType (FirstArgType, false, Location).FullName;
+//				string para2 = SecondArgType == null ? null : container.ResolveType (SecondArgType, false, Location).FullName;
+				string para1 = parameter_types [0].FullName;
+				string para2 = parameter_types.Length > 1 ? parameter_types [1].FullName : null;
+				Documentation.SetAttribute ("name", String.Concat ("M:", ds.Name, ".", Name, "(", para1, (para2 != null ? "," + para2 : null), ")"));
+			}
+			CheckDocumentation (ds);
 		}
 
 		// Operator cannot be override
Index: cs-parser.jay
===================================================================
RCS file: /cvs/public/mcs/mcs/cs-parser.jay,v
retrieving revision 1.334
diff -u -r1.334 cs-parser.jay
--- cs-parser.jay	12 Oct 2004 23:00:29 -0000	1.334
+++ cs-parser.jay	15 Oct 2004 20:57:21 -0000
@@ -18,6 +18,7 @@
 //   Run memory profiler with parsing only, and consider dropping 
 //   arraylists where not needed.   Some pieces can use linked lists.
 //
+using System.Xml;
 using System.Text;
 using System.IO;
 using System;
@@ -87,6 +88,12 @@
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
@@ -338,6 +345,9 @@
 namespace_declaration
 	: opt_attributes NAMESPACE namespace_or_type_name
 	{
+		if (Lexer.xml_comment_buffer.Length > 0)
+			WarnIncorrectXmlComment ("namespace declaration");
+
 		if ($1 != null) {
 			Report.Error(1518, Lexer.Location, "Attributes cannot be applied to namespaces."
 					+ " Expected class, delegate, enum, interface, or struct");
@@ -740,6 +750,8 @@
 			current_container = current_class;
 			RootContext.Tree.RecordDecl (name.GetName (true), current_class);
 		}
+		if (Lexer.xml_comment_buffer.Length > 0)
+			current_class.Documentation = CreateMemberComment ("T:" + name);
 	  }
 	  opt_class_base
 	  {
@@ -814,6 +826,8 @@
 				(Expression) constant.expression_or_array_initializer, modflags, 
 				(Attributes) $1, l);
 
+			if (Lexer.xml_comment_buffer.Length > 0)
+				c.Documentation = CreateMemberComment ("F:" + MakeName (c.MemberName));
 			current_container.AddConstant (c);
 		}
 	  }
@@ -866,6 +880,8 @@
 						 var.expression_or_array_initializer, 
 						 (Attributes) $1, l);
 
+			if (Lexer.xml_comment_buffer.Length > 0)
+				field.Documentation = CreateMemberComment ("F:" + MakeName (field.MemberName));
 			current_container.AddField (field);
 		}
 	  }
@@ -984,6 +1000,9 @@
 
 		current_local_parameters = (Parameters) $6;
 
+		if (Lexer.xml_comment_buffer.Length > 0)
+			method.Documentation = CreateMemberComment ("M:" + MakeName (method.MemberName));
+
 		$$ = method;
 	  }
 	| opt_attributes
@@ -998,6 +1017,10 @@
 					    (Attributes) $1, lexer.Location);
 
 		current_local_parameters = (Parameters) $6;
+
+		if (Lexer.xml_comment_buffer.Length > 0)
+			method.Documentation = CreateMemberComment ("M:" + MakeName (method.MemberName));
+
 		$$ = method;
 	  }
 	| opt_attributes
@@ -1171,6 +1194,9 @@
 		Location loc = (Location) $6;
 		MemberName name = (MemberName) $4;
 
+		if (Lexer.xml_comment_buffer.Length > 0)
+			tmpComment = CreateMemberComment ("P:" + MakeName (name));
+
 		prop = new Property (current_class, (Expression) $3, (int) $2, false,
 				     name, (Attributes) $1, get_block, set_block, loc);
 		if (SimpleIteratorContainer.Simple.Yields)
@@ -1179,6 +1205,11 @@
 		current_container.AddProperty (prop);
 		implicit_value_parameter_type = null;
 		iterator_container = null;
+
+		prop.Documentation = tmpComment;
+
+		if (Lexer.xml_comment_buffer.Length > 0)
+			WarnIncorrectXmlComment ("property definition body");
 	  }
 	;
 
@@ -1288,6 +1319,8 @@
 			current_container = current_class;
 			RootContext.Tree.RecordDecl (name.GetName (true), current_class);
 		}
+		if (Lexer.xml_comment_buffer.Length > 0)
+			current_class.Documentation = CreateMemberComment ("T:" + name);
 	  }
 	  opt_class_base
 	  {
@@ -1451,6 +1484,7 @@
 				  new MemberName (TypeContainer.DefaultIndexerName),
 				  (int) $2, true, (Parameters) $6, (Attributes) $1,
 				  info.Get, info.Set, lexer.Location);
+		((Indexer) $$).Documentation = tmpComment;
 	  }
 	;
 
@@ -1474,6 +1508,8 @@
 			new Parameters (param_list, null, decl.location),
 			(Block) $5, (Attributes) $1, decl.location);
 
+		op.Documentation = tmpComment;
+
 		if (SimpleIteratorContainer.Simple.Yields)
 			op.SetYields ();
 
@@ -1503,12 +1539,16 @@
 			op = Operator.OpType.UnaryNegation;
 
 		Parameter [] pars = new Parameter [1];
+		Expression type = (Expression) $5;
 
-		pars [0] = new Parameter ((Expression) $5, (string) $6, Parameter.Modifier.NONE, null);
+		pars [0] = new Parameter (type, (string) $6, Parameter.Modifier.NONE, null);
 
 		current_local_parameters = new Parameters (pars, null, lexer.Location);
 
-		$$ = new OperatorDeclaration (op, (Expression) $1, (Expression) $5, (string) $6,
+		if (Lexer.xml_comment_buffer.Length > 0)
+			tmpComment = CreateMemberComment ("M:dummy_comment");
+
+		$$ = new OperatorDeclaration (op, (Expression) $1, type, (string) $6,
 					      null, null, lexer.Location);
 	}
 	| type OPERATOR overloadable_operator
@@ -1517,14 +1557,22 @@
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
+			tmpComment = CreateMemberComment ("M:dummy_comment");
 	       
 	       $$ = new OperatorDeclaration ((Operator.OpType) $3, (Expression) $1, 
 					     (Expression) $5, (string) $6,
@@ -1605,6 +1653,9 @@
 		c.OptAttributes = (Attributes) $1;
 		c.ModFlags = (int) $2;
 	
+		if (Lexer.xml_comment_buffer.Length > 0)
+			c.Documentation = CreateMemberComment ("M:#ctor");
+
 		if (c.Name == current_container.Basename){
 			if ((c.ModFlags & Modifiers.STATIC) != 0){
 				if ((c.ModFlags & Modifiers.Accessibility) != 0){
@@ -1715,6 +1766,8 @@
 			Method d = new Destructor (
 				current_class, TypeManager.system_void_expr, m, "Finalize", 
 				new Parameters (null, null, l), (Attributes) $1, l);
+			if (Lexer.xml_comment_buffer.Length > 0)
+				d.Documentation = CreateMemberComment ("M:Finalize");
 		  
 			d.Block = (Block) $7;
 			current_container.AddMethod (d);
@@ -1738,6 +1791,8 @@
 
 			current_container.AddEvent (e);
 				       
+			if (Lexer.xml_comment_buffer.Length > 0)
+				e.Documentation = CreateMemberComment ("E:" + MakeName (e.MemberName));
 		}
 	  }
 	| opt_attributes
@@ -1769,6 +1824,8 @@
 				current_class, (Expression) $4, (int) $2, false, name, null,
 				(Attributes) $1, (Accessor) pair.First, (Accessor) pair.Second,
 				loc);
+			if (Lexer.xml_comment_buffer.Length > 0)
+				e.Documentation = CreateMemberComment ("E:" + MakeName (e.MemberName));
 			
 			current_container.AddEvent (e);
 			implicit_value_parameter_type = null;
@@ -1781,6 +1838,10 @@
 			Report.Error (71, lexer.Location, "Explicit implementation of events requires property syntax");
 		else 
 			Report.Error (71, lexer.Location, "Event declaration should use property syntax");
+
+		// FIXME: where to attach? (or is it allowed?)
+		if (Lexer.xml_comment_buffer.Length > 0)
+			CreateMemberComment ("E:" + MakeName ((MemberName) $5));
 	  }
 	;
 
@@ -1885,6 +1946,7 @@
 		indexer = new Indexer (current_class, decl.type, name,
 				       (int) $2, false, decl.param_list, (Attributes) $1,
 				       get_block, set_block, loc);
+		indexer.Documentation = tmpComment;
 
 		current_container.AddIndexer (indexer);
 		
@@ -1904,6 +1966,10 @@
 		} else if (pars.FixedParameters == null && pars.ArrayParameter == null){
 			Report.Error (1551, lexer.Location, "Indexers must have at least one parameter");
 		}
+		// Parameters will be fixed up after RootContext.ResolveType
+		if (Lexer.xml_comment_buffer.Length > 0)
+			// missing arglist is going to be filled later
+			tmpComment = CreateMemberComment ("P:Item");
 
 		$$ = new IndexerDeclaration ((Expression) $1, null, pars);
 	  }
@@ -1917,8 +1983,13 @@
 		} else if (pars.FixedParameters == null && pars.ArrayParameter == null){
 			Report.Error (1551, lexer.Location, "Indexers must have at least one parameter");
 		}
+
 		MemberName name = (MemberName) $2;
 		$$ = new IndexerDeclaration ((Expression) $1, name, pars);
+
+		if (Lexer.xml_comment_buffer.Length > 0)
+			tmpComment = CreateMemberComment ("P:" + MakeName (name));
+
 	  }
 	;
 
@@ -1936,6 +2007,9 @@
 		Enum e = new Enum (current_namespace, current_container, (Expression) $5, (int) $2,
 				   full_name, (Attributes) $1, enum_location);
 		
+		if (Lexer.xml_comment_buffer.Length > 0)
+			e.Documentation = CreateMemberComment ("T:" + full_name);
+
 		foreach (VariableDeclaration ev in (ArrayList) $6) {
 			e.AddEnumMember (ev.identifier, 
 					 (Expression) ev.expression_or_array_initializer,
@@ -2011,6 +2085,9 @@
 		Delegate del = new Delegate (current_namespace, current_container, (Expression) $4,
 					     (int) $2, name, (Parameters) $7, (Attributes) $1, l);
 
+		if (Lexer.xml_comment_buffer.Length > 0)
+			del.Documentation = CreateMemberComment ("T:" + name);
+
 		current_container.AddDelegate (del);
 		RootContext.Tree.RecordDecl (name.GetName (true), del);
 	  }	
@@ -2027,6 +2104,9 @@
 			TypeManager.system_void_expr, (int) $2, name,
 			(Parameters) $7, (Attributes) $1, l);
 
+		if (Lexer.xml_comment_buffer.Length > 0)
+			del.Documentation = CreateMemberComment ("T:" + name);
+
 		current_container.AddDelegate (del);
 		RootContext.Tree.RecordDecl (name.GetName (true), del);
 	  }
@@ -3002,6 +3082,8 @@
 			current_container = current_class;
 			RootContext.Tree.RecordDecl (name.GetName (true), current_class);
 		}
+		if (Lexer.xml_comment_buffer.Length > 0)
+			current_class.Documentation = CreateMemberComment ("T:" + name);
 	  }
 	  opt_class_base
 	  {
@@ -4430,6 +4512,29 @@
 void CheckIdentifierToken (int yyToken)
 {
 	CheckToken (1041, yyToken, "Identifier expected");
+}
+
+XmlElement CreateMemberComment (string fullyQualifiedName)
+{
+	XmlDocument doc = RootContext.XmlDocumentation;
+	XmlElement el = null;
+	try {
+		el = doc.CreateElement ("member");
+		el.InnerXml = Lexer.ConsumeXmlComment ();
+		el.SetAttribute ("name", fullyQualifiedName);
+		doc.DocumentElement.LastChild.AppendChild (el);
+	} catch (XmlException ex) {
+		Report.Warning (1570, 1, Lexer.Location, "XML comment on '{0}' has non-well-formed XML ({1}).", fullyQualifiedName, ex.Message);
+		XmlComment com = doc.CreateComment ("FIXME: Invalid documentation markup was found for member " + fullyQualifiedName);
+		doc.DocumentElement.LastChild.AppendChild (com);
+	}
+	return el;
+}
+
+void WarnIncorrectXmlComment (string token_type)
+{
+	Report.Warning (1587, 2, Lexer.Location, "XML comment is placed on '{0}' language element which can not accept it.", token_type);
+	Lexer.ConsumeXmlComment ();
 }
 
 /* end end end */
Index: cs-tokenizer.cs
===================================================================
RCS file: /cvs/public/mcs/mcs/cs-tokenizer.cs,v
retrieving revision 1.121
diff -u -r1.121 cs-tokenizer.cs
--- cs-tokenizer.cs	24 Sep 2004 08:15:03 -0000	1.121
+++ cs-tokenizer.cs	15 Oct 2004 20:57:21 -0000
@@ -40,6 +40,8 @@
 		bool handle_get_set = false;
 		bool handle_remove_add = false;
 		bool handle_assembly = false;
+		public StringBuilder xml_comment_buffer;
+		int xmlCommentSavePoint;
 
 		//
 		// Whether tokens have been seen on this line
@@ -132,6 +134,25 @@
 				handle_remove_add = value;
 			}
 		}
+
+		//
+		// Consumes the saved xml comment lines (if any)
+		// as for current target member or type.
+		//
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
@@ -362,6 +383,8 @@
 					define (def);
 			}
 
+			xml_comment_buffer = new StringBuilder ();
+
 			//
 			// FIXME: This could be `Location.Push' but we have to
 			// find out why the MS compiler allows this
@@ -1796,8 +1819,18 @@
 			//
 			if (!quoted && (s >= 'a' || s == '_')){
 				int keyword = GetKeyword (id_builder, pos);
-				if (keyword != -1)
+				if (keyword != -1) {
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
@@ -1862,6 +1895,10 @@
 				
 					if (d == '/'){
 						getChar ();
+						if (RootContext.NeedDocument && peekChar () == '/') {
+							getChar ();
+							handle_xml_comment ();
+						}
 						while ((d = getChar ()) != -1 && (d != '\n') && d != '\r')
 							col++;
 						if (d == '\n'){
@@ -1874,6 +1911,16 @@
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
@@ -1881,6 +1928,9 @@
 								col++;
 								break;
 							}
+							if (docAppend)
+								xml_comment_buffer.Append ((char) d);
+							
 							if (d == '\n'){
 								line++;
 								ref_line++;
@@ -2035,6 +2085,24 @@
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
retrieving revision 1.147
diff -u -r1.147 decl.cs
--- decl.cs	7 Oct 2004 07:34:27 -0000	1.147
+++ decl.cs	15 Oct 2004 20:57:21 -0000
@@ -16,6 +16,7 @@
 using System.Globalization;
 using System.Reflection.Emit;
 using System.Reflection;
+using System.Xml;
 
 namespace Mono.CSharp {
 
@@ -131,6 +132,11 @@
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
@@ -357,6 +363,68 @@
 
 		protected abstract void VerifyObsoleteAttribute ();
 
+		// Handles fixup of type/member names on xml doc comments.
+		public virtual void FixupDocument (DeclSpace ds)
+		{
+			CheckDocumentation (ds);
+		}
+		
+		internal void CheckDocumentation (DeclSpace ds)
+		{
+			if (Documentation != null) {
+				foreach (XmlElement el in Documentation.SelectNodes (".//include"))
+					HandleInclude (el);
+				Documentation = null; // release the reference
+			}
+			else if (RootContext.NeedDocument &&
+				IsExposedFromAssembly (ds) &&
+				// There are no warnings when the container also
+				// misses documentations.
+				(ds == null || ds.Documentation != null)) {
+				string name = MemberName.GetFullName ();
+				if (ds != null)
+					name = String.Concat (ds.MemberName.GetTypeName (), ".", name);
+				Report.Warning (1591, 4, Location,
+					"Missing XML comment for publicly visible type or member '{0}'", name);
+			}
+		}
+
+		private void HandleInclude (XmlElement el)
+		{
+			string file = el.GetAttribute ("file");
+			string path = el.GetAttribute ("path");
+			if (file == "")
+				Report.Warning (1590, 1, Location, "Invalid XML 'include' element; Missing 'file' attribute.");
+			else if (path == "")
+				Report.Warning (1590, 1, Location, "Invalid XML 'include' element; Missing 'path' attribute.");
+			else {
+				XmlDocument doc = RootContext.StoredDocuments [file] as XmlDocument;
+				if (doc == null) {
+					try {
+						doc = new XmlDocument ();
+						doc.Load (file);
+						RootContext.StoredDocuments.Add (file, doc);
+					} catch (Exception ex) {
+						el.ParentNode.InsertBefore (el.OwnerDocument.CreateComment (" Include tag is invalid "), el);
+						Report.Warning (1592, 1, Location, "Badly formed XML in included comments file -- '{0}'", file);
+					}
+				}
+				if (doc != null) {
+					try {
+						XmlNodeList nl = doc.SelectNodes (path);
+						if (nl.Count == 0)
+							el.ParentNode.InsertBefore (el.OwnerDocument.CreateComment (" No matching elements were found for the include tag embedded here. "), el);
+					
+						foreach (XmlNode n in nl)
+							el.ParentNode.InsertBefore (el.OwnerDocument.ImportNode (n, true), el);
+					} catch (Exception ex) {
+						el.ParentNode.InsertBefore (el.OwnerDocument.CreateComment (" Failed to insert some or all of included XML "), el);
+						Report.Warning (1589, 1, Location, "Unable to include XML fragment '{0}' of file {1} -- {2}.", path, file, ex.Message);
+					}
+				}
+				el.ParentNode.RemoveChild (el);
+			}
+		}
 	}
 
 	/// <summary>
Index: driver.cs
===================================================================
RCS file: /cvs/public/mcs/mcs/driver.cs,v
retrieving revision 1.205
diff -u -r1.205 driver.cs
--- driver.cs	19 Sep 2004 03:59:03 -0000	1.205
+++ driver.cs	15 Oct 2004 20:57:21 -0000
@@ -17,6 +17,7 @@
 	using System.IO;
 	using System.Text;
 	using System.Globalization;
+	using System.Xml;
 	using System.Diagnostics;
 
 	public enum Target {
@@ -101,6 +102,11 @@
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
@@ -224,6 +230,7 @@
 				"   -nostdlib[+|-]     Does not load core libraries\n" +
 				"   -nowarn:W1[,W2]    Disables one or more warnings\n" + 
 				"   -out:FNAME         Specifies output file\n" +
+				"   -doc:XMLFILE         Generates xml documentation into specified file\n" +
 				"   -pkg:P1[,Pn]       References packages P1..Pn\n" + 
 				"   --expect-error X   Expect that error X will be encountered\n" +
 				"   -recurse:SPEC      Recursively compiles the files in SPEC ([dir]/file)\n" + 
@@ -1109,10 +1116,15 @@
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
+				XmlDocument doc = new XmlDocument ();
+				doc.AppendChild (doc.CreateElement ("doc"));
+				doc.DocumentElement.AppendChild (doc.CreateElement ("members"));
+				RootContext.XmlDocumentation = doc;
 				return true;
 			}
 			case "/lib": {
@@ -1544,6 +1556,7 @@
 			if (timestamps)
 				ShowTime ("Resolving tree");
 			RootContext.ResolveTree ();
+
 			if (Report.Errors > 0)
 				return false;
 			if (timestamps)
@@ -1554,6 +1567,31 @@
 			RootContext.PopulateTypes ();
 			RootContext.DefineTypes ();
 			
+			if (RootContext.NeedDocument) {
+				RootContext.FixupDocument ();
+
+				XmlDocument doc = RootContext.XmlDocumentation;
+				XmlElement el = doc.CreateElement ("assembly");
+				string asmName = Path.ChangeExtension (output_file, null);
+				el.InnerXml = "<name>" + asmName + "</name>";
+				doc.DocumentElement.InsertAfter (el, null);
+
+				XmlTextWriter w = null;
+				try {
+					w = new XmlTextWriter (xml_documentation_file, encoding);
+					w.Formatting = Formatting.Indented;
+					doc.Save (w);
+					w.Close ();
+				} catch (Exception ex) {
+					Report.Error (1569, "Error generating XML documentation file '{0}' ('{1}')", xml_documentation_file, ex.Message);
+					return false;
+				} finally {
+					if (w != null)
+						w.Close ();
+					RootContext.XmlDocumentation = null;
+				}
+			}
+
 			TypeManager.InitCodeHelpers ();
 
 			//
@@ -1743,7 +1781,6 @@
 #endif
 			return (Report.Errors == 0);
 		}
-
 	}
 
 	//
Index: rootcontext.cs
===================================================================
RCS file: /cvs/public/mcs/mcs/rootcontext.cs,v
retrieving revision 1.155
diff -u -r1.155 rootcontext.cs
--- rootcontext.cs	24 Sep 2004 10:29:39 -0000	1.155
+++ rootcontext.cs	15 Oct 2004 20:57:21 -0000
@@ -13,6 +13,7 @@
 using System.Reflection;
 using System.Reflection.Emit;
 using System.Diagnostics;
+using System.Xml;
 
 namespace Mono.CSharp {
 
@@ -79,6 +80,11 @@
 		public static string StrongNameKeyContainer;
 		public static bool StrongNameDelaySign = false;
 
+		// If set, enable XML documentation generation
+		public static bool NeedDocument = false;
+		public static XmlDocument XmlDocumentation;
+		public static Hashtable StoredDocuments = new Hashtable ();
+
 		//
 		// Constructor
 		//
@@ -172,6 +178,29 @@
 			if (root.Enums != null)
 				foreach (Enum e in root.Enums)
 					e.DefineType ();
+		}
+
+		/// <summary>
+		/// Fixes full type name of each documented types/members up.
+		/// </summary>
+		static public void FixupDocument ()
+		{
+			TypeContainer root = Tree.Types;
+
+			if (root.Interfaces != null)
+				foreach (Interface i in root.Interfaces) 
+					i.FixupDocument (null);
+
+			foreach (TypeContainer tc in root.Types)
+				tc.FixupDocument (null);
+
+			if (root.Delegates != null)
+				foreach (Delegate d in root.Delegates) 
+					d.FixupDocument (null);
+
+			if (root.Enums != null)
+				foreach (Enum e in root.Enums)
+					e.FixupDocument (null);
 		}
 
 		static void Error_TypeConflict (string name, Location loc)