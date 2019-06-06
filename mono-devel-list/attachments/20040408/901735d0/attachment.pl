? gc.log
? mcs.sh
? xml-documentation-0403.patch
? xml-documentation-0407.patch
? xml-documentation.patch
Index: ChangeLog
===================================================================
RCS file: /cvs/public/mcs/mcs/ChangeLog,v
retrieving revision 1.1417
diff -u -r1.1417 ChangeLog
--- ChangeLog	7 Apr 2004 05:47:31 -0000	1.1417
+++ ChangeLog	8 Apr 2004 05:37:41 -0000
@@ -1,3 +1,23 @@
+2004-04-07  Atsushi Enomoto  <atsushi@ximian.com>
+
+	all things are for /doc support:
+
+	* decl.cs: Added Documentation element field for MemberCore.
+	* class.cs:
+	  Added MethodCore.Emit() just for documentation fixup.
+	  Added documentation fixup logic in Operator.Emit().
+	* cs-parser.jay:
+	  Added lines to fill Documentation element for field, constant,
+	  property, indexer, method, constructor, destructor, operator, event
+	  and class, struct, interface, delegate, enum.
+	  Added lines to warn incorrect comment (it is incomplete).
+	* cs-tokenizer.cs:
+	  Added support for picking up documentation.
+	  (both for /// and roughly for /** .. */)
+	* driver.cs:
+	  Added command line option --document (same as /doc).
+	  Report error 2006 instead of 5 for missing file name for /doc.
+
 2004-04-07  Miguel de Icaza  <miguel@ximian.com>
 
 	* rootcontext.cs: Add new types to the boot resolution.
Index: class.cs
===================================================================
RCS file: /cvs/public/mcs/mcs/class.cs,v
retrieving revision 1.419
diff -u -r1.419 class.cs
--- class.cs	6 Apr 2004 02:54:57 -0000	1.419
+++ class.cs	8 Apr 2004 05:37:42 -0000
@@ -2666,6 +2666,18 @@
 				}
 			}
 		}
+
+		public override void Emit (TypeContainer container)
+		{
+
+			if (Documentation != null) {
+				string paramSpec = null;
+				foreach (Type t in ParameterTypes)
+					paramSpec += (paramSpec != null ? "," : "(") + t.FullName;
+				string head = this is PropertyBase ? "P:" : "M:";
+				Documentation.SetAttribute ("name", head + container.Name + "." + Name + (paramSpec != null ? paramSpec + ")" : null));
+			}
+		}
 	}
 
 	public class Method : MethodCore, IIteratorContainer {
@@ -2910,6 +2922,7 @@
 			MethodData.Emit (container, Block, this);
 			base.Emit (container);
 			Block = null;
+
 			MethodData = null;
 		}
 
@@ -5610,6 +5623,12 @@
 		
 		public override void Emit (TypeContainer container)
 		{
+			if (Documentation != null) {
+				string para1 = container.ResolveType (FirstArgType, false, Location).FullName;
+				string para2 = SecondArgType == null ? null : container.ResolveType (SecondArgType, false, Location).FullName;
+				Documentation.SetAttribute ("name", "M:" + container.Name + "." + Name + "(" + para1 + (para2 != null ? "," + para2 : null) + ")");
+			}
+
 			//
 			// abstract or extern methods have no bodies
 			//
Index: cs-parser.jay
===================================================================
RCS file: /cvs/public/mcs/mcs/cs-parser.jay,v
retrieving revision 1.289
diff -u -r1.289 cs-parser.jay
--- cs-parser.jay	30 Mar 2004 16:58:56 -0000	1.289
+++ cs-parser.jay	8 Apr 2004 05:37:42 -0000
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
 %}
 
 %token EOF
@@ -332,6 +339,9 @@
 namespace_declaration
 	: opt_attributes NAMESPACE namespace_or_type_name
 	{
+		if (Lexer.XmlComment.Length > 0)
+			WarnIncorrectXmlComment ("namespace declaration");
+
 		Attributes attrs = (Attributes) $1;
 
 		if (attrs != null) {
@@ -684,6 +694,9 @@
 					 (int) $2, (Attributes) $1, lexer.Location);
 		current_container = new_struct;
 		RootContext.Tree.RecordDecl (full_struct_name, new_struct);
+
+		if (Lexer.XmlComment.Length > 0)
+			new_struct.Documentation = CreateMemberComment ("T:" + full_struct_name);
 	  }
 	  opt_class_base
 	  struct_body
@@ -752,6 +765,10 @@
 				(Attributes) $1, l);
 
 			CheckDef (current_container.AddConstant (c), c.Name, l);
+
+			string fullname = MakeName (c.Name);
+			if (Lexer.XmlComment.Length > 0)
+				c.Documentation = CreateMemberComment ("F:" + fullname);
 		}
 	  }
 	;
@@ -796,6 +813,9 @@
 						 (Attributes) $1, l);
 
 			CheckDef (current_container.AddField (field), field.Name, l);
+			string fullname = MakeName (field.Name);
+			if (Lexer.XmlComment.Length > 0)
+				field.Documentation = CreateMemberComment ("F:" + fullname);
 		}
 	  }
 	| opt_attributes
@@ -912,6 +932,9 @@
 
 		current_local_parameters = (Parameters) $6;
 
+		if (Lexer.XmlComment.Length > 0)
+			method.Documentation = CreateMemberComment ("M:" + MakeName ((string) $4));
+
 		$$ = method;
 	  }
 	| opt_attributes
@@ -925,6 +948,10 @@
 					    (Attributes) $1, lexer.Location);
 
 		current_local_parameters = (Parameters) $6;
+
+		if (Lexer.XmlComment.Length > 0)
+			method.Documentation = CreateMemberComment ("M:" + MakeName ((string) $4));
+
 		$$ = method;
 	  }
 	| opt_attributes
@@ -1052,6 +1079,10 @@
 		$$ = lexer.Location;
 
 		iterator_container = SimpleIteratorContainer.GetSimple ();
+
+		string fullname = MakeName ((string) $4);
+		if (Lexer.XmlComment.Length > 0)
+			tmpComment = CreateMemberComment ("P:" + fullname);
 	  }
 	  accessor_declarations 
 	  {
@@ -1069,10 +1100,14 @@
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
+		if (Lexer.XmlComment.Length > 0)
+			WarnIncorrectXmlComment ("property definition body");
 	  }
 	;
 
@@ -1175,6 +1210,8 @@
 		current_interface = new_interface;
 		current_container = new_interface;
 		RootContext.Tree.RecordDecl (full_interface_name, new_interface);
+		if (Lexer.XmlComment.Length > 0)
+			new_interface.Documentation = CreateMemberComment ("T:" + full_interface_name);
 	  }
 	  opt_class_base
 	  interface_body opt_semicolon
@@ -1330,9 +1367,11 @@
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
 
@@ -1347,6 +1386,7 @@
 		
 		Operator op = new Operator (decl.optype, decl.ret_type, (int) $2, decl.arg1type, decl.arg1name,
 					    decl.arg2type, decl.arg2name, (Block) $5, (Attributes) $1, decl.location);
+		op.Documentation = tmpComment;
 
 		if (SimpleIteratorContainer.Simple.Yields)
 			op.SetYields ();
@@ -1377,12 +1417,16 @@
 			op = Operator.OpType.UnaryNegation;
 
 		Parameter [] pars = new Parameter [1];
+		Expression type = (Expression) $5;
 
-		pars [0] = new Parameter ((Expression) $5, (string) $6, Parameter.Modifier.NONE, null);
+		pars [0] = new Parameter (type, (string) $6, Parameter.Modifier.NONE, null);
 
 		current_local_parameters = new Parameters (pars, null, lexer.Location);
 
-		$$ = new OperatorDeclaration (op, (Expression) $1, (Expression) $5, (string) $6,
+		if (Lexer.XmlComment.Length > 0)
+			tmpComment = CreateMemberComment ("M:" + MakeName ("op_" + op) + "(" + type +")");
+
+		$$ = new OperatorDeclaration (op, (Expression) $1, type, (string) $6,
 					      null, null, lexer.Location);
 	}
 	| type OPERATOR overloadable_operator
@@ -1391,14 +1435,22 @@
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
+		if (Lexer.XmlComment.Length > 0)
+			tmpComment = CreateMemberComment ("M:" + MakeName ("op_" + op) + "(" + MakeName (typeL.ToString ()) +"," + MakeName (typeR.ToString ()) + ")");
 	       
 	       $$ = new OperatorDeclaration ((Operator.OpType) $3, (Expression) $1, 
 					     (Expression) $5, (string) $6,
@@ -1479,6 +1531,9 @@
 		c.OptAttributes = (Attributes) $1;
 		c.ModFlags = (int) $2;
 	
+		if (Lexer.XmlComment.Length > 0)
+			c.Documentation = CreateMemberComment ("M:" + MakeName ("#ctor"));
+
 		if (c.Name == current_container.Basename){
 			if ((c.ModFlags & Modifiers.STATIC) != 0){
 				if ((c.ModFlags & Modifiers.Accessibility) != 0){
@@ -1589,6 +1644,8 @@
 			Method d = new Destructor (
 				current_container, TypeManager.system_void_expr, m, "Finalize", 
 				new Parameters (null, null, l), (Attributes) $1, l);
+			if (Lexer.XmlComment.Length > 0)
+				d.Documentation = CreateMemberComment ("M:" + MakeName ("Finalize"));
 		  
 			d.Block = (Block) $7;
 			CheckDef (current_container.AddMethod (d), d.Name, d.Location);
@@ -1609,6 +1666,8 @@
 
 			CheckDef (current_container.AddEvent (e), e.Name, e.Location);
 				       
+			if (Lexer.XmlComment.Length > 0)
+				e.Documentation = CreateMemberComment ("E:" + MakeName (e.Name));
 		}
 	  }
 	| opt_attributes
@@ -1644,6 +1703,9 @@
 			Event e = new Event ((Expression) $4, (int) $2, false, (string) $5,
 					     null, (Attributes) $1, add_accessor, rem_accessor,
 					     loc);
+
+			if (Lexer.XmlComment.Length > 0)
+				e.Documentation = CreateMemberComment ("E:" + MakeName ((string) $5));
 			
 			CheckDef (current_container.AddEvent (e), e.Name, loc);
 			implicit_value_parameter_type = null;
@@ -1656,6 +1718,10 @@
 			Report.Error (71, lexer.Location, "Explicit implementation of events requires property syntax");
 		else 
 			Report.Error (71, lexer.Location, "Event declaration should use property syntax");
+
+		// FIXME: where to attach? (or is it allowed?)
+		if (Lexer.XmlComment.Length > 0)
+			CreateMemberComment ("E:" + MakeName ((string) $5));
 	  }
 	;
 
@@ -1753,6 +1819,7 @@
 		indexer = new Indexer (current_container, decl.type, decl.interface_type,
 				       (int) $2, false, decl.param_list, (Attributes) $1,
 				       get_block, set_block, loc);
+		indexer.Documentation = tmpComment;
 
 		// Note that there is no equivalent of CheckDef for this case
 		// We shall handle this in semantic analysis
@@ -1774,6 +1841,17 @@
 			Report.Error (1551, lexer.Location, "Indexers must have at least one parameter");
 		}
 
+		string argTypes = null;
+		if (pars.ArrayParameter != null)
+			argTypes = pars.ArrayParameter.TypeName.ToString ();
+		else if (pars.FixedParameters != null) {
+			foreach (Parameter p in pars.FixedParameters)
+				argTypes += (argTypes == null ? "" : ",") + p.TypeName.ToString ();
+		}
+
+		if (Lexer.XmlComment.Length > 0)
+			tmpComment = CreateMemberComment ("P:" + MakeName ("Item") + "(" + argTypes + ")");
+
 		$$ = new IndexerDeclaration ((Expression) $1, null, pars);
 	  }
 	| type namespace_or_type_name DOT THIS OPEN_BRACKET opt_formal_parameter_list CLOSE_BRACKET
@@ -1783,6 +1861,10 @@
 		if (pars.FixedParameters == null && pars.ArrayParameter == null){
 			Report.Error (1551, lexer.Location, "Indexers must have at least one parameter");
 		}
+
+		if (Lexer.XmlComment.Length > 0)
+			tmpComment = CreateMemberComment ("P:" + MakeName ("Item"));
+
 		$$ = new IndexerDeclaration ((Expression) $1, $2.ToString (), pars);
 	  }
 	;
@@ -1801,6 +1883,9 @@
 		Enum e = new Enum (current_namespace, current_container, (Expression) $5, (int) $2,
 				   full_name, (Attributes) $1, enum_location);
 		
+		if (Lexer.XmlComment.Length > 0)
+			e.Documentation = CreateMemberComment ("T:" + full_name);
+
 		foreach (VariableDeclaration ev in (ArrayList) $6) {
 			Location loc = (Location) ev.Location;
 
@@ -1876,9 +1961,14 @@
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
+		if (Lexer.XmlComment.Length > 0)
+			del.Documentation = CreateMemberComment ("T:" + full_delegate_name);
 		  
 		CheckDef (current_container.AddDelegate (del), del.Name, l);
 	  }	
@@ -1891,11 +1981,16 @@
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
 
+		if (Lexer.XmlComment.Length > 0)
+			del.Documentation = CreateMemberComment ("T:" + full_delegate_name);
+
 		CheckDef (current_container.AddDelegate (del), del.Name, l);
 	  }
 	;
@@ -2836,6 +2931,9 @@
 				       (Attributes) $1, lexer.Location);
 		current_container = new_class;
 		RootContext.Tree.RecordDecl (name, new_class);
+
+		if (Lexer.XmlComment.Length > 0)
+			new_class.Documentation = CreateMemberComment ("T:" + name);
 	  }
 	  opt_class_base
 	  class_body 
@@ -4277,6 +4375,29 @@
 void CheckIdentifierToken (int yyToken)
 {
 	CheckToken (1041, yyToken, "Identifier expected");
+}
+
+XmlElement CreateMemberComment (string fullyQualifiedName)
+{
+	XmlDocument doc = Driver.XmlDocumentation;
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
retrieving revision 1.108
diff -u -r1.108 cs-tokenizer.cs
--- cs-tokenizer.cs	30 Mar 2004 02:38:39 -0000	1.108
+++ cs-tokenizer.cs	8 Apr 2004 05:37:42 -0000
@@ -40,6 +40,8 @@
 		bool handle_get_set = false;
 		bool handle_remove_add = false;
 		bool handle_assembly = false;
+		StringBuilder xml_comment_buffer;
+		int xmlCommentSavePoint;
 
 		//
 		// Whether tokens have been seen on this line
@@ -132,7 +134,27 @@
 				handle_remove_add = value;
 			}
 		}
-		
+
+		public StringBuilder XmlComment {
+			get {
+				return xml_comment_buffer;
+			}
+		}
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
@@ -359,6 +381,8 @@
 					define (def);
 			}
 
+			xml_comment_buffer = new StringBuilder ();
+
 			//
 			// FIXME: This could be `Location.Push' but we have to
 			// find out why the MS compiler allows this
@@ -1688,8 +1712,18 @@
 			//
 			if (s >= 'a'){
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
@@ -1754,6 +1788,10 @@
 				
 					if (d == '/'){
 						getChar ();
+						if (Driver.OutputDocument && peekChar () == '/') {
+							getChar ();
+							handle_xml_comment ();
+						}
 						while ((d = getChar ()) != -1 && (d != '\n') && d != '\r')
 							col++;
 						if (d == '\n'){
@@ -1766,6 +1804,11 @@
 						continue;
 					} else if (d == '*'){
 						getChar ();
+						bool docAppend = false;
+						if (Driver.OutputDocument && peekChar () == '*') {
+							getChar ();
+							docAppend = true;
+						}
 
 						while ((d = getChar ()) != -1){
 							if (d == '*' && peekChar () == '/'){
@@ -1773,6 +1816,9 @@
 								col++;
 								break;
 							}
+							if (docAppend)
+								xml_comment_buffer.Append ((char) d);
+							
 							if (d == '\n'){
 								line++;
 								ref_line++;
@@ -1927,6 +1973,24 @@
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
+				Console.Error.WriteLine ("WARNING!! Comments are not consumed for previous target. Current comment is " + XmlComment);
+#endif
+			xmlCommentSavePoint = XmlComment.Length;
 		}
 
 		public void cleanup ()
Index: decl.cs
===================================================================
RCS file: /cvs/public/mcs/mcs/decl.cs,v
retrieving revision 1.100
diff -u -r1.100 decl.cs
--- decl.cs	1 Apr 2004 18:32:01 -0000	1.100
+++ decl.cs	8 Apr 2004 05:37:42 -0000
@@ -14,6 +14,7 @@
 using System.Collections;
 using System.Reflection.Emit;
 using System.Reflection;
+using System.Xml;
 
 namespace Mono.CSharp {
 
@@ -38,6 +39,11 @@
 		public readonly Location Location;
 
 		/// <summary>
+		///   XML documentation comment
+		/// </summary>
+		public XmlElement Documentation;
+
+		/// <summary>
 		///   Attributes for this type
 		/// </summary>
  		Attributes attributes;
@@ -291,7 +297,7 @@
 		///   This variable tracks whether we have Closed the type
 		/// </summary>
 		public bool Created = false;
-		
+
 		//
 		// This is the namespace in which this typecontainer
 		// was declared.  We use this to resolve names.
Index: driver.cs
===================================================================
RCS file: /cvs/public/mcs/mcs/driver.cs,v
retrieving revision 1.181
diff -u -r1.181 driver.cs
--- driver.cs	1 Apr 2004 18:32:01 -0000	1.181
+++ driver.cs	8 Apr 2004 05:37:42 -0000
@@ -17,6 +17,7 @@
 	using System.IO;
 	using System.Text;
 	using System.Globalization;
+	using System.Xml;
 	using Mono.Languages;
 
 	public enum Target {
@@ -101,6 +102,12 @@
 		static Encoding encoding;
 
 		//
+		// XML Comment documentation
+		//
+		static XmlDocument xml_documentation;
+		static string xml_documentation_file;
+
+		//
 		// Whether the user has specified a different encoder manually
 		//
 		static bool using_default_encoder = true;
@@ -210,6 +217,7 @@
 				"   -nostdlib[+|-]     Does not load core libraries\n" +
 				"   -nowarn:W1[,W2]    Disables one or more warnings\n" + 
 				"   -out:FNAME         Specifies output file\n" +
+				"   -doc:XMLFILE         Generates xml documentation into specified file\n" +
 				"   --parse            Only parses the source file\n" +
 				"   --expect-error X   Expect that error X will be encountered\n" +
 				"   -recurse:SPEC      Recursively compiles the files in SPEC ([dir]/file)\n" + 
@@ -715,6 +723,15 @@
 				SetOutputFile (args [++i]);
 				return true;
 				
+			case "--document":
+				int docNameStart = args [i].IndexOf (':') + 1;
+				if (docNameStart == 0){
+					Report.Error (2006, "Missing ':<filename>' to --document");
+					Environment.Exit (1);
+				}
+				xml_documentation_file = args [i].Substring (docNameStart);
+				return true;
+				
 			case "--checked":
 				RootContext.Checked = true;
 				return true;
@@ -1045,10 +1062,10 @@
 			}
 			case "/doc": {
 				if (value == ""){
-					Report.Error (5, arg + " requires an argument");
+					Report.Error (2006, arg + " requires an argument");
 					Environment.Exit (1);
 				}
-				// TODO handle the /doc argument to generate xml doc
+				xml_documentation_file = value;
 				return true;
 			}
 			case "/lib": {
@@ -1594,6 +1611,17 @@
 				define_icon.Invoke (CodeGen.Assembly.Builder, new object [] { win32IconFile });
 			}
 
+			if (xml_documentation_file != null) {
+				XmlElement el = xml_documentation.CreateElement ("assembly");
+				string asmName = Path.ChangeExtension (output_file, null);
+				el.InnerXml = "<name>" + asmName + "</name>";
+				xml_documentation.DocumentElement.InsertAfter (el, null);
+				XmlTextWriter w = new XmlTextWriter (xml_documentation_file, encoding);
+				w.Formatting = Formatting.Indented;
+				xml_documentation.Save (w);
+				w.Close ();
+			}
+
 			if (Report.Errors > 0)
 				return false;
 			
@@ -1629,6 +1657,22 @@
 			return (Report.Errors == 0);
 		}
 
+		public static bool OutputDocument {
+			get { return xml_documentation_file != null; }
+		}
+
+		public static XmlDocument XmlDocumentation {
+			get {
+				if (xml_documentation == null) {
+					XmlDocument doc = new XmlDocument ();
+					doc.AppendChild (doc.CreateXmlDeclaration ("1.0", encoding != null ? encoding.WebName : null, null));
+					doc.AppendChild (doc.CreateElement ("doc"));
+					doc.DocumentElement.AppendChild (doc.CreateElement ("members"));
+					xml_documentation = doc;
+				}
+				return xml_documentation;
+			}
+		}
 	}
 
 	//
