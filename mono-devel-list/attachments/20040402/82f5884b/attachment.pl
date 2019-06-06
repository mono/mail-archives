Index: cs-parser.jay
===================================================================
RCS file: /cvs/public/mcs/mcs/cs-parser.jay,v
retrieving revision 1.289
diff -u -r1.289 cs-parser.jay
--- cs-parser.jay	30 Mar 2004 16:58:56 -0000	1.289
+++ cs-parser.jay	2 Apr 2004 07:06:46 -0000
@@ -18,6 +18,7 @@
 //   Run memory profiler with parsing only, and consider dropping 
 //   arraylists where not needed.   Some pieces can use linked lists.
 //
+using System.Xml;
 using System.Text;
 using System.IO;
 using System;
@@ -332,6 +333,9 @@
 namespace_declaration
 	: opt_attributes NAMESPACE namespace_or_type_name
 	{
+		if (Lexer.XmlComment.Length > 0)
+			WarnIncorrectXmlComment ("namespace declaration");
+
 		Attributes attrs = (Attributes) $1;
 
 		if (attrs != null) {
@@ -684,6 +688,9 @@
 					 (int) $2, (Attributes) $1, lexer.Location);
 		current_container = new_struct;
 		RootContext.Tree.RecordDecl (full_struct_name, new_struct);
+
+		if (Lexer.XmlComment.Length > 0)
+			WriteMemberComment ("T:" + full_struct_name);
 	  }
 	  opt_class_base
 	  struct_body
@@ -752,6 +759,10 @@
 				(Attributes) $1, l);
 
 			CheckDef (current_container.AddConstant (c), c.Name, l);
+
+			string fullname = MakeName (c.Name);
+			if (Lexer.XmlComment.Length > 0)
+				WriteMemberComment ("F:" + fullname);
 		}
 	  }
 	;
@@ -796,6 +807,9 @@
 						 (Attributes) $1, l);
 
 			CheckDef (current_container.AddField (field), field.Name, l);
+			string fullname = MakeName (field.Name);
+			if (Lexer.XmlComment.Length > 0)
+				WriteMemberComment ("F:" + fullname);
 		}
 	  }
 	| opt_attributes
@@ -912,6 +926,9 @@
 
 		current_local_parameters = (Parameters) $6;
 
+		if (Lexer.XmlComment.Length > 0)
+			WriteMemberComment ("M:" + MakeName ((string) $4));
+
 		$$ = method;
 	  }
 	| opt_attributes
@@ -925,6 +942,10 @@
 					    (Attributes) $1, lexer.Location);
 
 		current_local_parameters = (Parameters) $6;
+
+		if (Lexer.XmlComment.Length > 0)
+			WriteMemberComment ("M:" + MakeName ((string) $4));
+
 		$$ = method;
 	  }
 	| opt_attributes
@@ -1052,6 +1073,10 @@
 		$$ = lexer.Location;
 
 		iterator_container = SimpleIteratorContainer.GetSimple ();
+
+		string fullname = MakeName ((string) $4);
+		if (Lexer.XmlComment.Length > 0)
+			WriteMemberComment ("P:" + fullname);
 	  }
 	  accessor_declarations 
 	  {
@@ -1073,6 +1098,9 @@
 		CheckDef (current_container.AddProperty (prop), prop.Name, loc);
 		implicit_value_parameter_type = null;
 		iterator_container = null;
+
+		if (Lexer.XmlComment.Length > 0)
+			WarnIncorrectXmlComment ("property definition body");
 	  }
 	;
 
@@ -1175,6 +1203,8 @@
 		current_interface = new_interface;
 		current_container = new_interface;
 		RootContext.Tree.RecordDecl (full_interface_name, new_interface);
+		if (Lexer.XmlComment.Length > 0)
+			WriteMemberComment ("T:" + full_interface_name);
 	  }
 	  opt_class_base
 	  interface_body opt_semicolon
@@ -1377,11 +1407,16 @@
 			op = Operator.OpType.UnaryNegation;
 
 		Parameter [] pars = new Parameter [1];
+		Expression type = (Expression) $5;
 
-		pars [0] = new Parameter ((Expression) $5, (string) $6, Parameter.Modifier.NONE, null);
+		pars [0] = new Parameter (type, (string) $6, Parameter.Modifier.NONE, null);
 
 		current_local_parameters = new Parameters (pars, null, lexer.Location);
 
+		// FIXME: How to obtain parameter type fullname from Expression?
+		if (Lexer.XmlComment.Length > 0)
+			WriteMemberComment ("M:" + MakeName ("op_" + op) + "(" + type +")");
+
 		$$ = new OperatorDeclaration (op, (Expression) $1, (Expression) $5, (string) $6,
 					      null, null, lexer.Location);
 	}
@@ -1391,14 +1426,23 @@
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
+		// FIXME: How to obtain parameter type fullname from Expression?
+		if (Lexer.XmlComment.Length > 0)
+			WriteMemberComment ("M:" + MakeName ("op_" + op) + "(" + typeL +"," + typeR + ")");
 	       
 	       $$ = new OperatorDeclaration ((Operator.OpType) $3, (Expression) $1, 
 					     (Expression) $5, (string) $6,
@@ -1479,6 +1523,9 @@
 		c.OptAttributes = (Attributes) $1;
 		c.ModFlags = (int) $2;
 	
+		if (Lexer.XmlComment.Length > 0)
+			WriteMemberComment ("M:" + MakeName ("#ctor"));
+
 		if (c.Name == current_container.Basename){
 			if ((c.ModFlags & Modifiers.STATIC) != 0){
 				if ((c.ModFlags & Modifiers.Accessibility) != 0){
@@ -1565,6 +1612,9 @@
 destructor_declaration
 	: opt_attributes opt_finalizer TILDE IDENTIFIER OPEN_PARENS CLOSE_PARENS block
 	  {
+		if (Lexer.XmlComment.Length > 0)
+			WriteMemberComment ("M:" + MakeName ("Finalize"));
+
 		if ((string) $4 != current_container.Basename){
 			Report.Error (574, lexer.Location, "Name of destructor must match name of class");
 		} else if (!(current_container is Class)){
@@ -1619,6 +1669,9 @@
 		implicit_value_parameter_type = (Expression) $4;  
 		lexer.EventParsing = true;
 		oob_stack.Push (lexer.Location);
+
+		if (Lexer.XmlComment.Length > 0)
+			WriteMemberComment ("E:" + MakeName ((string) $5));
 	  }
 	  event_accessor_declarations
 	  {
@@ -1656,6 +1709,9 @@
 			Report.Error (71, lexer.Location, "Explicit implementation of events requires property syntax");
 		else 
 			Report.Error (71, lexer.Location, "Event declaration should use property syntax");
+
+		if (Lexer.XmlComment.Length > 0)
+			WriteMemberComment ("E:" + MakeName ((string) $5));
 	  }
 	;
 
@@ -1774,6 +1830,17 @@
 			Report.Error (1551, lexer.Location, "Indexers must have at least one parameter");
 		}
 
+		string argTypes = null;
+		if (pars.ArrayParameter != null)
+			argTypes = pars.ArrayParameter.TypeName.ToString ();
+		else if (pars.FixedParameters != null) {
+			foreach (Parameter p in pars.FixedParameters)
+				argTypes += (argTypes == null ? "" : ",") + p.TypeName;
+		}
+
+		if (Lexer.XmlComment.Length > 0)
+			WriteMemberComment ("P:" + MakeName ("Item") + "(" + argTypes + ")");
+
 		$$ = new IndexerDeclaration ((Expression) $1, null, pars);
 	  }
 	| type namespace_or_type_name DOT THIS OPEN_BRACKET opt_formal_parameter_list CLOSE_BRACKET
@@ -1801,6 +1868,9 @@
 		Enum e = new Enum (current_namespace, current_container, (Expression) $5, (int) $2,
 				   full_name, (Attributes) $1, enum_location);
 		
+		if (Lexer.XmlComment.Length > 0)
+			WriteMemberComment ("T:" + full_name);
+
 		foreach (VariableDeclaration ev in (ArrayList) $6) {
 			Location loc = (Location) ev.Location;
 
@@ -1876,8 +1946,13 @@
 	  SEMICOLON
 	  {
 		Location l = lexer.Location;
+		string full_delegate_name = MakeName ((string) $5);
+
+		if (Lexer.XmlComment.Length > 0)
+			WriteMemberComment ("T:" + full_delegate_name);
+
 		Delegate del = new Delegate (current_namespace, current_container, (Expression) $4,
-					     (int) $2, MakeName ((string) $5), (Parameters) $7, 
+					     (int) $2, full_delegate_name, (Parameters) $7, 
 					     (Attributes) $1, l);
 		  
 		CheckDef (current_container.AddDelegate (del), del.Name, l);
@@ -1891,9 +1966,15 @@
 	  SEMICOLON
 	  {
 		Location l = lexer.Location;
+		string full_delegate_name = MakeName ((string) $5);
+
+Console.Error.WriteLine ("Delegate found.2" + full_delegate_name + Lexer.XmlComment);
+		if (Lexer.XmlComment.Length > 0)
+			WriteMemberComment ("T:" + full_delegate_name);
+
 		Delegate del = new Delegate (
 			current_namespace, current_container,
-			TypeManager.system_void_expr, (int) $2, MakeName ((string) $5), 
+			TypeManager.system_void_expr, (int) $2, full_delegate_name, 
 			(Parameters) $7, (Attributes) $1, l);
 
 		CheckDef (current_container.AddDelegate (del), del.Name, l);
@@ -2836,6 +2917,9 @@
 				       (Attributes) $1, lexer.Location);
 		current_container = new_class;
 		RootContext.Tree.RecordDecl (name, new_class);
+
+		if (Lexer.XmlComment.Length > 0)
+			WriteMemberComment ("T:" + name);
 	  }
 	  opt_class_base
 	  class_body 
@@ -4277,6 +4361,28 @@
 void CheckIdentifierToken (int yyToken)
 {
 	CheckToken (1041, yyToken, "Identifier expected");
+}
+
+void WriteMemberComment (string fullyQualifiedName)
+{
+	XmlDocument doc = Driver.XmlDocumentation;
+	try {
+		XmlElement el = doc.CreateElement ("member");
+		el.InnerXml = Lexer.XmlComment.ToString ();
+		el.SetAttribute ("name", fullyQualifiedName);
+		doc.DocumentElement.LastChild.AppendChild (el);
+	} catch (XmlException ex) {
+		Report.Warning (1570, Lexer.Location, "XML comment is not well-formed: " + ex.Message);
+		XmlComment com = doc.CreateComment ("FIXME: Invalid documentation markup was found for member " + fullyQualifiedName);
+		doc.DocumentElement.LastChild.AppendChild (com);
+	}
+	Lexer.XmlComment.Length = 0;
+}
+
+void WarnIncorrectXmlComment (string token_type)
+{
+	Report.Warning (1587, Lexer.Location, "XML comment is not acceptable on  " + token_type);
+	Lexer.XmlComment.Length = 0;
 }
 
 /* end end end */
Index: cs-tokenizer.cs
===================================================================
RCS file: /cvs/public/mcs/mcs/cs-tokenizer.cs,v
retrieving revision 1.108
diff -u -r1.108 cs-tokenizer.cs
--- cs-tokenizer.cs	30 Mar 2004 02:38:39 -0000	1.108
+++ cs-tokenizer.cs	2 Apr 2004 07:06:46 -0000
@@ -40,6 +40,7 @@
 		bool handle_get_set = false;
 		bool handle_remove_add = false;
 		bool handle_assembly = false;
+		StringBuilder xml_comment_buffer;
 
 		//
 		// Whether tokens have been seen on this line
@@ -132,7 +133,13 @@
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
 		//
 		// Class variables
 		// 
@@ -359,6 +366,8 @@
 					define (def);
 			}
 
+			xml_comment_buffer = new StringBuilder ();
+
 			//
 			// FIXME: This could be `Location.Push' but we have to
 			// find out why the MS compiler allows this
@@ -1754,6 +1763,10 @@
 				
 					if (d == '/'){
 						getChar ();
+						if (Driver.OutputDocument && peekChar () == '/') {
+							getChar ();
+							handle_xml_comment ();
+						}
 						while ((d = getChar ()) != -1 && (d != '\n') && d != '\r')
 							col++;
 						if (d == '\n'){
@@ -1927,6 +1940,15 @@
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
 		}
 
 		public void cleanup ()
Index: driver.cs
===================================================================
RCS file: /cvs/public/mcs/mcs/driver.cs,v
retrieving revision 1.181
diff -u -r1.181 driver.cs
--- driver.cs	1 Apr 2004 18:32:01 -0000	1.181
+++ driver.cs	2 Apr 2004 07:06:46 -0000
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
@@ -1594,6 +1611,9 @@
 				define_icon.Invoke (CodeGen.Assembly.Builder, new object [] { win32IconFile });
 			}
 
+			if (xml_documentation_file != null)
+				xml_documentation.Save (xml_documentation_file);
+
 			if (Report.Errors > 0)
 				return false;
 			
@@ -1629,6 +1649,22 @@
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
+					doc.DocumentElement.InnerXml = "<assembly><name>" + Path.ChangeExtension (output_file, "") + "</name></assembly><members/>";
+					xml_documentation = doc;
+				}
+				return xml_documentation;
+			}
+		}
 	}
 
 	//
