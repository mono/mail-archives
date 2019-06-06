Index: cs-tokenizer.cs
===================================================================
--- cs-tokenizer.cs	(revision 36909)
+++ cs-tokenizer.cs	(working copy)
@@ -7,6 +7,7 @@
 // Licensed under the terms of the GNU GPL
 //
 // (C) 2001, 2002 Ximian, Inc (http://www.ximian.com)
+// (C) 2004 Novell, Inc
 //
 
 /*
@@ -42,6 +43,17 @@
 		bool handle_assembly = false;
 
 		//
+		// XML documentation buffer. The save point is used to divide
+		// comments on types and comments on members.
+		//
+		StringBuilder xml_comment_buffer;
+
+		//
+		// See comment on XmlCommentState enumeration.
+		//
+		XmlCommentState xmlDocState = XmlCommentState.Allowed;
+
+		//
 		// Whether tokens have been seen on this line
 		//
 		bool tokens_seen = false;
@@ -132,6 +144,18 @@
 				handle_remove_add = value;
 			}
 		}
+
+		public XmlCommentState doc_state {
+			get { return xmlDocState; }
+			set {
+				if (value == XmlCommentState.Allowed) {
+					check_incorrect_doc_comment ();
+					consume_doc_comment ();
+				}
+				xmlDocState = value;
+			}
+		}
+
 		
 		//
 		// Class variables
@@ -362,6 +386,8 @@
 					define (def);
 			}
 
+			xml_comment_buffer = new StringBuilder ();
+
 			//
 			// FIXME: This could be `Location.Push' but we have to
 			// find out why the MS compiler allows this
@@ -411,6 +437,9 @@
 			case '}':
 				return Token.CLOSE_BRACE;
 			case '[':
+				// To block doccomment inside attribute declaration.
+				if (doc_state == XmlCommentState.Allowed)
+					doc_state = XmlCommentState.NotAllowed;
 				return Token.OPEN_BRACKET;
 			case ']':
 				return Token.CLOSE_BRACKET;
@@ -1741,6 +1770,15 @@
 		{
 			int res = consume_identifier (s, false);
 
+			if (doc_state == XmlCommentState.Allowed)
+				doc_state = XmlCommentState.NotAllowed;
+			switch (res) {
+			case Token.USING:
+			case Token.NAMESPACE:
+				check_incorrect_doc_comment ();
+				break;
+			}
+
 			if (res == Token.PARTIAL) {
 				// Save current position and parse next token.
 				int old = reader.Position;
@@ -1862,6 +1900,13 @@
 				
 					if (d == '/'){
 						getChar ();
+						if (RootContext.Documentation != null && peekChar () == '/') {
+							getChar ();
+							if (doc_state == XmlCommentState.Allowed)
+								handle_one_line_xml_comment ();
+							else if (doc_state == XmlCommentState.NotAllowed)
+								warn_incorrect_doc_comment ();
+						}
 						while ((d = getChar ()) != -1 && (d != '\n') && d != '\r')
 							col++;
 						if (d == '\n'){
@@ -1874,13 +1919,35 @@
 						continue;
 					} else if (d == '*'){
 						getChar ();
+						bool docAppend = false;
+						if (RootContext.Documentation != null && peekChar () == '*') {
+							getChar ();
+							// But when it is /**/, just do nothing.
+							if (peekChar () == '/') {
+								getChar ();
+								continue;
+							}
+							if (doc_state == XmlCommentState.Allowed)
+								docAppend = true;
+							else if (doc_state == XmlCommentState.NotAllowed)
+								warn_incorrect_doc_comment ();
+						}
 
+						int currentCommentStart = 0;
+						if (docAppend) {
+							currentCommentStart = xml_comment_buffer.Length;
+							xml_comment_buffer.Append (Environment.NewLine);
+						}
+
 						while ((d = getChar ()) != -1){
 							if (d == '*' && peekChar () == '/'){
 								getChar ();
 								col++;
 								break;
 							}
+							if (docAppend)
+								xml_comment_buffer.Append ((char) d);
+							
 							if (d == '\n'){
 								line++;
 								ref_line++;
@@ -1889,6 +1956,8 @@
 								tokens_seen = false;
 							}
 						}
+						if (docAppend)
+							update_formatted_doc_comment (currentCommentStart);
 						continue;
 					}
 					goto is_punct_label;
@@ -2037,6 +2106,91 @@
 			return Token.EOF;
 		}
 
+		//
+		// Handles one line xml comment
+		//
+		private void handle_one_line_xml_comment ()
+		{
+			int c;
+			while ((c = peekChar ()) == ' ')
+				getChar (); // skip heading whitespaces.
+			while ((c = peekChar ()) != -1 && c != '\n' && c != '\r') {
+				col++;
+				xml_comment_buffer.Append ((char) getChar ());
+			}
+			if (c == '\r' || c == '\n')
+				xml_comment_buffer.Append (Environment.NewLine);
+		}
+
+		//
+		// Remove heading "*" in Javadoc-like xml documentation.
+		//
+		private void update_formatted_doc_comment (int currentCommentStart)
+		{
+			int length = xml_comment_buffer.Length - currentCommentStart;
+			string [] lines = xml_comment_buffer.ToString (
+				currentCommentStart,
+				length).Replace ("\r", "").Split ('\n');
+			// The first line starts with /**, thus it is not target
+			// for the format check.
+			for (int i = 1; i < lines.Length; i++) {
+				string s = lines [i];
+				int idx = s.IndexOf ('*');
+				string head = null;
+				if (idx < 0) {
+					if (i < lines.Length - 1)
+						return;
+					head = s;
+				}
+				else
+					head = s.Substring (0, idx);
+				foreach (char c in head)
+					if (c != ' ')
+						return;
+				lines [i] = s.Substring (idx + 1);
+			}
+			xml_comment_buffer.Remove (currentCommentStart, length);
+			xml_comment_buffer.Insert (
+				currentCommentStart,
+				String.Join (Environment.NewLine, lines));
+		}
+
+		//
+		// Checks if there was incorrect doc comments and raise
+		// warnings.
+		//
+		public void check_incorrect_doc_comment ()
+		{
+			if (xml_comment_buffer.Length > 0)
+				warn_incorrect_doc_comment ();
+		}
+
+		//
+		// Raises a warning when tokenizer found incorrect doccomment
+		// markup.
+		//
+		private void warn_incorrect_doc_comment ()
+		{
+			doc_state = XmlCommentState.Error;
+			// in csc, it is 'XML comment is not placed on a valid 
+			// language element'. But that does not make sense.
+			Report.Warning (1587, 2, Location, "XML comment is placed on an invalid language element which can not accept it.");
+		}
+
+		//
+		// Consumes the saved xml comment lines (if any)
+		// as for current target member or type.
+		//
+		public string consume_doc_comment ()
+		{
+			if (xml_comment_buffer.Length > 0) {
+				string ret = xml_comment_buffer.ToString ();
+				xml_comment_buffer.Length = 0;
+				return ret;
+			}
+			return null;
+		}
+
 		public void cleanup ()
 		{
 			if (ifstack != null && ifstack.Count >= 1) {
@@ -2049,4 +2203,18 @@
 				
 		}
 	}
+
+	//
+	// Indicates whether it accepts XML documentation or not.
+	//
+	public enum XmlCommentState {
+		// comment is allowed in this state.
+		Allowed,
+		// comment is not allowed in this state.
+		NotAllowed,
+		// once comments appeared when it is NotAllowed, then the
+		// state is changed to it, until the state is changed to
+		// .Allowed.
+		Error
+	}
 }
Index: mcs.exe.sources
===================================================================
--- mcs.exe.sources	(revision 36909)
+++ mcs.exe.sources	(working copy)
@@ -12,6 +12,7 @@
 convert.cs
 decl.cs
 delegate.cs
+doc.cs
 enum.cs
 ecore.cs
 expression.cs
Index: rootcontext.cs
===================================================================
--- rootcontext.cs	(revision 36909)
+++ rootcontext.cs	(working copy)
@@ -7,12 +7,14 @@
 // Licensed under the terms of the GNU GPL
 //
 // (C) 2001 Ximian, Inc (http://www.ximian.com)
+// (C) 2004 Novell, Inc
 
 using System;
 using System.Collections;
 using System.Reflection;
 using System.Reflection.Emit;
 using System.Diagnostics;
+using System.Xml;
 
 namespace Mono.CSharp {
 
@@ -80,6 +82,11 @@
 		public static bool StrongNameDelaySign = false;
 
 		//
+		// If set, enable XML documentation generation
+		//
+		public static Documentation Documentation;
+
+		//
 		// Constructor
 		//
 		static RootContext ()
Index: class.cs
===================================================================
--- class.cs	(revision 36909)
+++ class.cs	(working copy)
@@ -8,6 +8,7 @@
 // Licensed under the terms of the GNU GPL
 //
 // (C) 2001, 2002, 2003 Ximian, Inc (http://www.ximian.com)
+// (C) 2004 Novell, Inc
 //
 //
 //  2002-10-11  Miguel de Icaza  <miguel@ximian.com>
@@ -40,6 +41,7 @@
 using System.Security;
 using System.Security.Permissions;
 using System.Text;
+using System.Xml;
 
 using Mono.CompilerServices.SymbolWriter;
 
@@ -2265,6 +2267,10 @@
 			}
 		}
 
+		public Constructor DefaultStaticConstructor {
+			get { return default_static_constructor; }
+		}
+
 		protected override bool VerifyClsCompliance (DeclSpace ds)
 		{
 			if (!base.VerifyClsCompliance (ds))
@@ -2396,6 +2402,19 @@
 			return FindMembers (mt, bf | BindingFlags.DeclaredOnly, null, null);
 		}
 
+		//
+		// Generates xml doc comments (if any), and if required,
+		// handle warning report.
+		//
+		internal override void GenerateDocComment (DeclSpace ds)
+		{
+			DocUtil.GenerateTypeDocComment (this, ds);
+		}
+
+		public override string DocCommentHeader {
+			get { return "T:"; }
+		}
+
 		public virtual MemberCache ParentCache {
 			get {
 				return parent_cache;
@@ -3296,6 +3315,34 @@
 			return true;
 		}
 
+		//
+		// Returns a string that represents the signature for this 
+		// member which should be used in XML documentation.
+		//
+		public override string GetDocCommentName (DeclSpace ds)
+		{
+			return DocUtil.GetMethodDocCommentName (this, ds);
+		}
+
+		//
+		// Raised (and passed an XmlElement that contains the comment)
+		// when GenerateDocComment is writing documentation expectedly.
+		//
+		// FIXME: with a few effort, it could be done with XmlReader,
+		// that means removal of DOM use.
+		//
+		internal override void OnGenerateDocComment (DeclSpace ds, XmlElement el)
+		{
+			DocUtil.OnMethodGenerateDocComment (this, ds, el);
+		}
+
+		//
+		//   Represents header string for documentation comment.
+		//
+		public override string DocCommentHeader {
+			get { return "M:"; }
+		}
+
 		protected override void VerifyObsoleteAttribute()
 		{
 			base.VerifyObsoleteAttribute ();
@@ -5224,6 +5271,13 @@
 
 			base.Emit ();
 		}
+
+		//
+		//   Represents header string for documentation comment.
+		//
+		public override string DocCommentHeader {
+			get { return "F:"; }
+		}
 	}
 
 	//
@@ -5532,6 +5586,13 @@
 			}
 		}
 
+		//
+		//   Represents header string for documentation comment.
+		//
+		public override string DocCommentHeader {
+			get { throw new InvalidOperationException ("Unexpected attempt to get doc comment from " + this.GetType () + "."); }
+		}
+
 		protected override void VerifyObsoleteAttribute()
 		{
 		}
@@ -5982,6 +6043,13 @@
 				return attribute_targets;
 			}
 		}
+
+		//
+		//   Represents header string for documentation comment.
+		//
+		public override string DocCommentHeader {
+			get { return "P:"; }
+		}
 	}
 			
 	public class Property : PropertyBase, IIteratorContainer {
@@ -6626,6 +6694,13 @@
 
 			return TypeManager.GetFullNameSignature (EventBuilder);
 		}
+
+		//
+		//   Represents header string for documentation comment.
+		//
+		public override string DocCommentHeader {
+			get { return "E:"; }
+		}
 	}
 
 
Index: decl.cs
===================================================================
--- decl.cs	(revision 36909)
+++ decl.cs	(working copy)
@@ -7,6 +7,7 @@
 // Licensed under the terms of the GNU GPL
 //
 // (C) 2001 Ximian, Inc (http://www.ximian.com)
+// (C) 2004 Novell, Inc
 //
 // TODO: Move the method verification stuff from the class.cs and interface.cs here
 //
@@ -16,6 +17,7 @@
 using System.Globalization;
 using System.Reflection.Emit;
 using System.Reflection;
+using System.Xml;
 
 namespace Mono.CSharp {
 
@@ -138,6 +140,17 @@
 		/// </summary>
 		public readonly Location Location;
 
+		/// <summary>
+		///   XML documentation comment
+		/// </summary>
+		public string DocComment;
+
+		/// <summary>
+		///   Represents header string for documentation comment 
+		///   for each member types.
+		/// </summary>
+		public abstract string DocCommentHeader { get; }
+
 		[Flags]
 		public enum Flags {
 			Obsolete_Undetected = 1,		// Obsolete attribute has not been detected yet
@@ -292,7 +305,7 @@
 		/// <summary>
 		/// Returns true when MemberCore is exposed from assembly.
 		/// </summary>
-		protected bool IsExposedFromAssembly (DeclSpace ds)
+		public bool IsExposedFromAssembly (DeclSpace ds)
 		{
 			if ((ModFlags & (Modifiers.PUBLIC | Modifiers.PROTECTED)) == 0)
 				return false;
@@ -364,6 +377,34 @@
 
 		protected abstract void VerifyObsoleteAttribute ();
 
+		//
+		// Raised (and passed an XmlElement that contains the comment)
+		// when GenerateDocComment is writing documentation expectedly.
+		//
+		internal virtual void OnGenerateDocComment (DeclSpace ds, XmlElement intermediateNode)
+		{
+		}
+
+		//
+		// Returns a string that represents the signature for this 
+		// member which should be used in XML documentation.
+		//
+		public virtual string GetDocCommentName (DeclSpace ds)
+		{
+			if (ds == null || this is DeclSpace)
+				return DocCommentHeader + Name;
+			else
+				return String.Concat (DocCommentHeader, ds.Name, ".", Name);
+		}
+
+		//
+		// Generates xml doc comments (if any), and if required,
+		// handle warning report.
+		//
+		internal virtual void GenerateDocComment (DeclSpace ds)
+		{
+			DocUtil.GenerateDocComment (this, ds);
+		}
 	}
 
 	/// <summary>
@@ -1326,7 +1367,7 @@
 			IDictionaryEnumerator it = parent.member_hash.GetEnumerator ();
 			while (it.MoveNext ()) {
 				hash [it.Key] = ((ArrayList) it.Value).Clone ();
-                        }
+			 }
                                 
 			return hash;
 		}
Index: delegate.cs
===================================================================
--- delegate.cs	(revision 36909)
+++ delegate.cs	(working copy)
@@ -643,6 +643,13 @@
 			}
 		}
 
+		//
+		//   Represents header string for documentation comment.
+		//
+		public override string DocCommentHeader {
+			get { return "T:"; }
+		}
+
 		protected override void VerifyObsoleteAttribute()
 		{
 			CheckUsageOfObsoleteAttribute (ret_type);
Index: cs-parser.jay
===================================================================
--- cs-parser.jay	(revision 36909)
+++ cs-parser.jay	(working copy)
@@ -8,6 +8,7 @@
 // Licensed under the terms of the GNU GPL
 //
 // (C) 2001 Ximian, Inc (http://www.ximian.com)
+// (C) 2004 Novell, Inc
 //
 // TODO:
 //   (1) Figure out why error productions dont work.  `type-declaration' is a
@@ -81,6 +82,14 @@
 		/// The current file.
 		///
 		SourceFile file;
+
+		///
+		/// Temporary Xml documentation cache.
+		/// For enum types, we need one more temporary store.
+		///
+		string tmpComment;
+		string enumTypeComment;
+
 		
 		
 		/// Current attribute target
@@ -284,7 +293,13 @@
 	
 opt_EOF
 	: /* empty */
+	{
+		Lexer.check_incorrect_doc_comment ();
+	}
 	| EOF
+	{
+		Lexer.check_incorrect_doc_comment ();
+	}
 	;
 
 outer_declarations
@@ -304,7 +319,15 @@
 
 using_directive
 	: using_alias_directive
+	{
+		if (RootContext.Documentation != null)
+			Lexer.doc_state = XmlCommentState.Allowed;
+	}
 	| using_namespace_directive
+	{
+		if (RootContext.Documentation != null)
+			Lexer.doc_state = XmlCommentState.Allowed;
+	}
 	;
 
 using_alias_directive
@@ -375,6 +398,10 @@
 
 namespace_body
 	: OPEN_BRACE
+	  {
+		if (RootContext.Documentation != null)
+			Lexer.doc_state = XmlCommentState.Allowed;
+	  }
 	  opt_using_directives
 	  opt_namespace_member_declarations
 	  CLOSE_BRACE
@@ -491,6 +518,13 @@
 			} else {
 				$$ = new Attributes (sect);
 			}
+			if ($$ == null) {
+				if (RootContext.Documentation != null) {
+					Lexer.check_incorrect_doc_comment ();
+					Lexer.doc_state =
+						XmlCommentState.Allowed;
+				}
+			}
 		} else {
 			$$ = new Attributes (sect);
 		}		
@@ -746,9 +780,16 @@
 		if ($7 != null)
 			current_class.Bases = (ArrayList) $7;
 
+		if (RootContext.Documentation != null)
+			current_class.DocComment = Lexer.consume_doc_comment ();
+
 		current_class.Register ();
 	  }
 	  struct_body
+	  {
+		if (RootContext.Documentation != null)
+			Lexer.doc_state = XmlCommentState.Allowed;
+	  }
 	  opt_semicolon
 	  {
 		$$ = current_class;
@@ -762,7 +803,12 @@
 	;
 
 struct_body
-	: OPEN_BRACE opt_struct_member_declarations CLOSE_BRACE
+	: OPEN_BRACE
+	  {
+		if (RootContext.Documentation != null)
+			Lexer.doc_state = XmlCommentState.Allowed;
+	  }
+	  opt_struct_member_declarations CLOSE_BRACE
 	;
 
 opt_struct_member_declarations
@@ -814,6 +860,10 @@
 				(Expression) constant.expression_or_array_initializer, modflags, 
 				(Attributes) $1, l);
 
+			if (RootContext.Documentation != null) {
+				c.DocComment = Lexer.consume_doc_comment ();
+				Lexer.doc_state = XmlCommentState.Allowed;
+			}
 			current_container.AddConstant (c);
 		}
 	  }
@@ -866,6 +916,10 @@
 						 var.expression_or_array_initializer, 
 						 (Attributes) $1, l);
 
+			if (RootContext.Documentation != null) {
+				field.DocComment = Lexer.consume_doc_comment ();
+				Lexer.doc_state = XmlCommentState.Allowed;
+			}
 			current_container.AddField (field);
 		}
 	  }
@@ -927,6 +981,8 @@
 method_declaration
 	: method_header {
 		iterator_container = (IIteratorContainer) $1;
+		if (RootContext.Documentation != null)
+			Lexer.doc_state = XmlCommentState.NotAllowed;
 	  }
 	  method_body
 	  {
@@ -953,6 +1009,9 @@
 
 		current_local_parameters = null;
 		iterator_container = null;
+
+		if (RootContext.Documentation != null)
+			Lexer.doc_state = XmlCommentState.Allowed;
 	  }
 	;
 
@@ -989,6 +1048,9 @@
 
 		current_local_parameters = (Parameters) $6;
 
+		if (RootContext.Documentation != null)
+			method.DocComment = Lexer.consume_doc_comment ();
+
 		$$ = method;
 	  }
 	| opt_attributes
@@ -1003,6 +1065,10 @@
 					    (Attributes) $1, lexer.Location);
 
 		current_local_parameters = (Parameters) $6;
+
+		if (RootContext.Documentation != null)
+			method.DocComment = Lexer.consume_doc_comment ();
+
 		$$ = method;
 	  }
 	| opt_attributes
@@ -1020,6 +1086,10 @@
 					    lexer.Location);
 
 		current_local_parameters = (Parameters) $7;
+
+		if (RootContext.Documentation != null)
+			method.DocComment = Lexer.consume_doc_comment ();
+
 		$$ = method;
 	  }
 	;
@@ -1163,7 +1233,12 @@
 property_declaration
 	: opt_attributes
 	  opt_modifiers
-	  type namespace_or_type_name
+	  type
+	  namespace_or_type_name
+	  {
+		if (RootContext.Documentation != null)
+			tmpComment = Lexer.consume_doc_comment ();
+	  }
 	  OPEN_BRACE 
 	  {
 		implicit_value_parameter_type = (Expression) $3;
@@ -1181,11 +1256,11 @@
 	  CLOSE_BRACE
 	  { 
 		Property prop;
-		Pair pair = (Pair) $7;
+		Pair pair = (Pair) $8;
 		Accessor get_block = (Accessor) pair.First;
 		Accessor set_block = (Accessor) pair.Second;
 
-		Location loc = (Location) $6;
+		Location loc = (Location) $7;
 		MemberName name = (MemberName) $4;
 
 		prop = new Property (current_class, (Expression) $3, (int) $2, false,
@@ -1196,6 +1271,10 @@
 		current_container.AddProperty (prop);
 		implicit_value_parameter_type = null;
 		iterator_container = null;
+
+		if (RootContext.Documentation != null)
+			prop.DocComment = ConsumeStoredComment ();
+
 	  }
 	;
 
@@ -1236,6 +1315,10 @@
 		$$ = new Accessor ((ToplevelBlock) $5, (int) $2, (Attributes) $1, lexer.Location);
 		current_local_parameters = null;
 		lexer.PropertyParsing = true;
+
+		if (RootContext.Documentation != null)
+			if (Lexer.doc_state == XmlCommentState.Error)
+				Lexer.doc_state = XmlCommentState.NotAllowed;
 	  }
 	;
 
@@ -1273,6 +1356,10 @@
 		$$ = new Accessor ((ToplevelBlock) $5, (int) $2, (Attributes) $1, lexer.Location);
 		current_local_parameters = null;
 		lexer.PropertyParsing = true;
+
+		if (RootContext.Documentation != null
+			&& Lexer.doc_state == XmlCommentState.Error)
+			Lexer.doc_state = XmlCommentState.NotAllowed;
 	  }
 	;
 
@@ -1310,9 +1397,18 @@
 	  {
 		current_class.Bases = (ArrayList) $7;
 
+		if (RootContext.Documentation != null) {
+			current_class.DocComment = Lexer.consume_doc_comment ();
+			Lexer.doc_state = XmlCommentState.Allowed;
+		}
+
 		current_class.Register ();
 	  }
 	  interface_body 
+	  {
+		if (RootContext.Documentation != null)
+			Lexer.doc_state = XmlCommentState.Allowed;
+	  }
 	  opt_semicolon 
 	  {
 		$$ = current_class;
@@ -1347,12 +1443,18 @@
 		Method m = (Method) $1;
 
 		current_container.AddMethod (m);
+
+		if (RootContext.Documentation != null)
+			Lexer.doc_state = XmlCommentState.Allowed;
 	  }
 	| interface_property_declaration	
 	  { 
 		Property p = (Property) $1;
 
 		current_container.AddProperty (p);
+
+		if (RootContext.Documentation != null)
+			Lexer.doc_state = XmlCommentState.Allowed;
        }
 	| interface_event_declaration 
           { 
@@ -1360,12 +1462,18 @@
 			Event e = (Event) $1;
 			current_container.AddEvent (e);
 		}
+
+		if (RootContext.Documentation != null)
+			Lexer.doc_state = XmlCommentState.Allowed;
 	  }
 	| interface_indexer_declaration
 	  { 
 		Indexer i = (Indexer) $1;
 
 		current_container.AddIndexer (i);
+
+		if (RootContext.Documentation != null)
+			Lexer.doc_state = XmlCommentState.Allowed;
 	  }
 	;
 
@@ -1387,6 +1495,8 @@
 
 		$$ = new Method (current_class, (Expression) $3, (int) $2, true,
 				 name, (Parameters) $6, (Attributes) $1, lexer.Location);
+		if (RootContext.Documentation != null)
+			((Method) $$).DocComment = Lexer.consume_doc_comment ();
 	  }
 	| opt_attributes opt_new VOID namespace_or_type_name
 	  OPEN_PARENS opt_formal_parameter_list CLOSE_PARENS
@@ -1396,6 +1506,8 @@
 
 		$$ = new Method (current_class, TypeManager.system_void_expr, (int) $2,
 				 true, name, (Parameters) $6,  (Attributes) $1, lexer.Location);
+		if (RootContext.Documentation != null)
+			((Method) $$).DocComment = Lexer.consume_doc_comment ();
 	  }
 	;
 
@@ -1414,6 +1526,8 @@
 		$$ = new Property (current_class, (Expression) $3, (int) $2, true,
 				   new MemberName ((string) $4), (Attributes) $1,
 				   pinfo.Get, pinfo.Set, lexer.Location);
+		if (RootContext.Documentation != null)
+			((Property) $$).DocComment = Lexer.consume_doc_comment ();
 	  }
 	| opt_attributes
 	  opt_new
@@ -1440,6 +1554,8 @@
 		$$ = new EventField (current_class, (Expression) $4, (int) $2, true,
 				     new MemberName ((string) $5), null,
 				     (Attributes) $1, lexer.Location);
+		if (RootContext.Documentation != null)
+			((EventField) $$).DocComment = Lexer.consume_doc_comment ();
 	  }
 	| opt_attributes opt_new EVENT type error {
 		CheckIdentifierToken (yyToken);
@@ -1470,6 +1586,8 @@
 				  new MemberName (TypeContainer.DefaultIndexerName),
 				  (int) $2, true, (Parameters) $6, (Attributes) $1,
 				  info.Get, info.Set, lexer.Location);
+		if (RootContext.Documentation != null)
+			((Indexer) $$).DocComment = ConsumeStoredComment ();
 	  }
 	;
 
@@ -1493,6 +1611,9 @@
 			new Parameters (param_list, null, decl.location),
 			(ToplevelBlock) $5, (Attributes) $1, decl.location);
 
+		if (RootContext.Documentation != null)
+			op.DocComment = ConsumeStoredComment ();
+
 		if (SimpleIteratorContainer.Simple.Yields)
 			op.SetYields ();
 
@@ -1522,12 +1643,18 @@
 			op = Operator.OpType.UnaryNegation;
 
 		Parameter [] pars = new Parameter [1];
+		Expression type = (Expression) $5;
 
-		pars [0] = new Parameter ((Expression) $5, (string) $6, Parameter.Modifier.NONE, null);
+		pars [0] = new Parameter (type, (string) $6, Parameter.Modifier.NONE, null);
 
 		current_local_parameters = new Parameters (pars, null, lexer.Location);
 
-		$$ = new OperatorDeclaration (op, (Expression) $1, (Expression) $5, (string) $6,
+		if (RootContext.Documentation != null) {
+			tmpComment = Lexer.consume_doc_comment ();
+			Lexer.doc_state = XmlCommentState.Allowed;
+		}
+
+		$$ = new OperatorDeclaration (op, (Expression) $1, type, (string) $6,
 					      null, null, lexer.Location);
 	}
 	| type OPERATOR overloadable_operator
@@ -1536,18 +1663,26 @@
 	  	type IDENTIFIER 
 	  CLOSE_PARENS
         {
-	       CheckBinaryOperator ((Operator.OpType) $3);
+		CheckBinaryOperator ((Operator.OpType) $3);
 
-	       Parameter [] pars = new Parameter [2];
+		Parameter [] pars = new Parameter [2];
 
-	       pars [0] = new Parameter ((Expression) $5, (string) $6, Parameter.Modifier.NONE, null);
-	       pars [1] = new Parameter ((Expression) $8, (string) $9, Parameter.Modifier.NONE, null);
+		Expression typeL = (Expression) $5;
+		Expression typeR = (Expression) $8;
 
+	       pars [0] = new Parameter (typeL, (string) $6, Parameter.Modifier.NONE, null);
+	       pars [1] = new Parameter (typeR, (string) $9, Parameter.Modifier.NONE, null);
+
 	       current_local_parameters = new Parameters (pars, null, lexer.Location);
+
+		if (RootContext.Documentation != null) {
+			tmpComment = Lexer.consume_doc_comment ();
+			Lexer.doc_state = XmlCommentState.Allowed;
+		}
 	       
 	       $$ = new OperatorDeclaration ((Operator.OpType) $3, (Expression) $1, 
-					     (Expression) $5, (string) $6,
-					     (Expression) $8, (string) $9, lexer.Location);
+					     typeL, (string) $6,
+					     typeR, (string) $9, lexer.Location);
         }
 	| conversion_operator_declarator
 	;
@@ -1624,6 +1759,9 @@
 		c.OptAttributes = (Attributes) $1;
 		c.ModFlags = (int) $2;
 	
+		if (RootContext.Documentation != null)
+			c.DocComment = ConsumeStoredComment ();
+
 		if (c.Name == current_container.Basename){
 			if ((c.ModFlags & Modifiers.STATIC) != 0){
 				if ((c.ModFlags & Modifiers.Accessibility) != 0){
@@ -1657,22 +1795,30 @@
 		current_container.AddConstructor (c);
 
 		current_local_parameters = null;
+		if (RootContext.Documentation != null)
+			Lexer.doc_state = XmlCommentState.Allowed;
 	  }
 	;
 
 constructor_declarator
-	: IDENTIFIER 
+	: IDENTIFIER
+	  {
+		if (RootContext.Documentation != null) {
+			tmpComment = Lexer.consume_doc_comment ();
+			Lexer.doc_state = XmlCommentState.Allowed;
+		}
+	  }
 	  OPEN_PARENS opt_formal_parameter_list CLOSE_PARENS 
 	  {
 		oob_stack.Push (lexer.Location);
 
-		current_local_parameters = (Parameters) $3;
+		current_local_parameters = (Parameters) $4;
 	  }
 	  opt_constructor_initializer
 	  {
 		Location l = (Location) oob_stack.Pop ();
-		$$ = new Constructor (current_class, (string) $1, 0, (Parameters) $3,
-				      (ConstructorInitializer) $6, l);
+		$$ = new Constructor (current_class, (string) $1, 0, (Parameters) $4,
+				      (ConstructorInitializer) $7, l);
 	  }
 	;
 
@@ -1708,9 +1854,16 @@
         ;
         
 destructor_declaration
-	: opt_attributes opt_finalizer TILDE IDENTIFIER OPEN_PARENS CLOSE_PARENS block
+	: opt_attributes opt_finalizer TILDE 
 	  {
-		if ((string) $4 != current_container.Basename){
+		if (RootContext.Documentation != null) {
+			tmpComment = Lexer.consume_doc_comment ();
+			Lexer.doc_state = XmlCommentState.NotAllowed;
+		}
+	  }
+	  IDENTIFIER OPEN_PARENS CLOSE_PARENS block
+	  {
+		if ((string) $5 != current_container.Basename){
 			Report.Error (574, lexer.Location, "Name of destructor must match name of class");
 		} else if (!(current_container is Class)){
 			Report.Error (575, lexer.Location, "Destructors are only allowed in class types");
@@ -1734,8 +1887,10 @@
 			Method d = new Destructor (
 				current_class, TypeManager.system_void_expr, m, "Finalize", 
 				new Parameters (null, null, l), (Attributes) $1, l);
+			if (RootContext.Documentation != null)
+				d.DocComment = ConsumeStoredComment ();
 		  
-			d.Block = (ToplevelBlock) $7;
+			d.Block = (ToplevelBlock) $8;
 			current_container.AddMethod (d);
 		}
 	  }
@@ -1756,7 +1911,11 @@
 				lexer.Location);
 
 			current_container.AddEvent (e);
-				       
+
+			if (RootContext.Documentation != null) {
+				e.DocComment = Lexer.consume_doc_comment ();
+				Lexer.doc_state = XmlCommentState.Allowed;
+			}
 		}
 	  }
 	| opt_attributes
@@ -1788,7 +1947,11 @@
 				current_class, (Expression) $4, (int) $2, false, name, null,
 				(Attributes) $1, (Accessor) pair.First, (Accessor) pair.Second,
 				loc);
-			
+			if (RootContext.Documentation != null) {
+				e.DocComment = Lexer.consume_doc_comment ();
+				Lexer.doc_state = XmlCommentState.Allowed;
+			}
+
 			current_container.AddEvent (e);
 			implicit_value_parameter_type = null;
 		}
@@ -1800,6 +1963,9 @@
 			Report.Error (71, lexer.Location, "Explicit implementation of events requires property syntax");
 		else 
 			Report.Error (71, lexer.Location, "Event declaration should use property syntax");
+
+		if (RootContext.Documentation != null)
+			Lexer.doc_state = XmlCommentState.Allowed;
 	  }
 	;
 
@@ -1910,6 +2076,8 @@
 		indexer = new Indexer (current_class, decl.type, name,
 				       (int) $2, false, decl.param_list, (Attributes) $1,
 				       get_block, set_block, loc);
+		if (RootContext.Documentation != null)
+			indexer.DocComment = ConsumeStoredComment ();
 
 		current_container.AddIndexer (indexer);
 		
@@ -1929,6 +2097,10 @@
 		} else if (pars.FixedParameters == null && pars.ArrayParameter == null){
 			Report.Error (1551, lexer.Location, "Indexers must have at least one parameter");
 		}
+		if (RootContext.Documentation != null) {
+			tmpComment = Lexer.consume_doc_comment ();
+			Lexer.doc_state = XmlCommentState.Allowed;
+		}
 
 		$$ = new IndexerDeclaration ((Expression) $1, null, pars);
 	  }
@@ -1942,8 +2114,14 @@
 		} else if (pars.FixedParameters == null && pars.ArrayParameter == null){
 			Report.Error (1551, lexer.Location, "Indexers must have at least one parameter");
 		}
+
 		MemberName name = (MemberName) $2;
 		$$ = new IndexerDeclaration ((Expression) $1, name, pars);
+
+		if (RootContext.Documentation != null) {
+			tmpComment = Lexer.consume_doc_comment ();
+			Lexer.doc_state = XmlCommentState.Allowed;
+		}
 	  }
 	;
 
@@ -1951,7 +2129,10 @@
 	: opt_attributes
 	  opt_modifiers
 	  ENUM IDENTIFIER 
-	  opt_enum_base
+	  opt_enum_base {
+		if (RootContext.Documentation != null)
+			enumTypeComment = Lexer.consume_doc_comment ();
+	  }
 	  enum_body
 	  opt_semicolon
 	  { 
@@ -1961,10 +2142,14 @@
 		Enum e = new Enum (current_namespace, current_container, (Expression) $5, (int) $2,
 				   full_name, (Attributes) $1, enum_location);
 		
-		foreach (VariableDeclaration ev in (ArrayList) $6) {
+		if (RootContext.Documentation != null)
+			e.DocComment = enumTypeComment;
+
+		foreach (VariableDeclaration ev in (ArrayList) $7) {
 			e.AddEnumMember (ev.identifier, 
 					 (Expression) ev.expression_or_array_initializer,
-					 ev.Location, ev.OptAttributes);
+					 ev.Location, ev.OptAttributes,
+					 ev.DocComment);
 		}
 
 		string name = full_name.GetName ();
@@ -1980,10 +2165,21 @@
 	;
 
 enum_body
-	: OPEN_BRACE opt_enum_member_declarations CLOSE_BRACE
+	: OPEN_BRACE
 	  {
-		$$ = $2;
+		if (RootContext.Documentation != null)
+			Lexer.doc_state = XmlCommentState.Allowed;
 	  }
+	  opt_enum_member_declarations
+	  {
+	  	// here will be evaluated after CLOSE_BLACE is consumed.
+		if (RootContext.Documentation != null)
+			Lexer.doc_state = XmlCommentState.Allowed;
+	  }
+	  CLOSE_BRACE
+	  {
+		$$ = $3;
+	  }
 	;
 
 opt_enum_member_declarations
@@ -2012,15 +2208,31 @@
 enum_member_declaration
 	: opt_attributes IDENTIFIER 
 	  {
-		$$ = new VariableDeclaration ((string) $2, null, lexer.Location, (Attributes) $1);
+		VariableDeclaration vd = new VariableDeclaration ((string) $2, null, lexer.Location, (Attributes) $1);
+
+		if (RootContext.Documentation != null) {
+			vd.DocComment = Lexer.consume_doc_comment ();
+			Lexer.doc_state = XmlCommentState.Allowed;
+		}
+
+		$$ = vd;
 	  }
 	| opt_attributes IDENTIFIER
 	  {
-		  $$ = lexer.Location;
+		$$ = lexer.Location;
+		if (RootContext.Documentation != null) {
+			tmpComment = Lexer.consume_doc_comment ();
+			Lexer.doc_state = XmlCommentState.NotAllowed;
+		}
 	  }
           ASSIGN expression
 	  { 
-		$$ = new VariableDeclaration ((string) $2, $5, lexer.Location, (Attributes) $1);
+		VariableDeclaration vd = new VariableDeclaration ((string) $2, $5, lexer.Location, (Attributes) $1);
+
+		if (RootContext.Documentation != null)
+			vd.DocComment = ConsumeStoredComment ();
+
+		$$ = vd;
 	  }
 	;
 
@@ -2036,6 +2248,11 @@
 		Delegate del = new Delegate (current_namespace, current_container, (Expression) $4,
 					     (int) $2, name, (Parameters) $7, (Attributes) $1, l);
 
+		if (RootContext.Documentation != null) {
+			del.DocComment = Lexer.consume_doc_comment ();
+			Lexer.doc_state = XmlCommentState.Allowed;
+		}
+
 		current_container.AddDelegate (del);
 		RootContext.Tree.RecordDecl (name.GetName (true), del);
 	  }	
@@ -2052,6 +2269,11 @@
 			TypeManager.system_void_expr, (int) $2, name,
 			(Parameters) $7, (Attributes) $1, l);
 
+		if (RootContext.Documentation != null) {
+			del.DocComment = Lexer.consume_doc_comment ();
+			Lexer.doc_state = XmlCommentState.Allowed;
+		}
+
 		current_container.AddDelegate (del);
 		RootContext.Tree.RecordDecl (name.GetName (true), del);
 	  }
@@ -3055,9 +3277,18 @@
 			current_class.Bases = (ArrayList) $7;
 		}
 
+		if (RootContext.Documentation != null) {
+			current_class.DocComment = Lexer.consume_doc_comment ();
+			Lexer.doc_state = XmlCommentState.Allowed;
+		}
+
 		current_class.Register ();
 	  }
-	  class_body 
+	  class_body
+	  {
+		if (RootContext.Documentation != null)
+			Lexer.doc_state = XmlCommentState.Allowed;
+	  }
 	  opt_semicolon 
 	  {
 		$$ = current_class;
@@ -4138,6 +4369,7 @@
 	public object expression_or_array_initializer;
 	public Location Location;
 	public Attributes OptAttributes;
+	public string DocComment;
 
 	public VariableDeclaration (string id, object eoai, Location l, Attributes opt_attrs)
 	{
@@ -4482,5 +4714,13 @@
 	CheckToken (1041, yyToken, "Identifier expected");
 }
 
+string ConsumeStoredComment ()
+{
+	string s = tmpComment;
+	tmpComment = null;
+	Lexer.doc_state = XmlCommentState.Allowed;
+	return s;
+}
+
 /* end end end */
 }
Index: ChangeLog
===================================================================
--- ChangeLog	(revision 36909)
+++ ChangeLog	(working copy)
@@ -1,3 +1,34 @@
+2004-12-02  Atsushi Enomoto  <atsushi@ximian.com>
+
+	all things are for /doc support:
+
+	* doc.cs: new file that supports XML documentation generation.
+	* mcs.exe.sources: added doc.cs.
+	* driver.cs:
+	  Handle /doc command line option.
+	  Report error 2006 instead of 5 for missing file name for /doc.
+	  Generate XML documentation when required, after type resolution.
+	* cs-tokenizer.cs:
+	  Added support for picking up documentation (/// and /** ... */),
+	  including a new XmlCommentState enumeration.
+	* cs-parser.jay:
+	  Added lines to fill Documentation element for field, constant,
+	  property, indexer, method, constructor, destructor, operator, event
+	  and class, struct, interface, delegate, enum.
+	  Added lines to warn incorrect comment.
+	* rootcontext.cs :
+	  Added Documentation field (passed only when /doc was specified).
+	* decl.cs:
+	  Added DocComment, DocCommentHeader, GenerateDocComment() and
+	  OnGenerateDocComment() and some supporting private members for
+	  /doc feature to MemberCore.
+	* class.cs:
+	  Added GenerateDocComment() on TypeContainer, MethodCore and Operator.
+	* delegate.cs:
+	  Added overriden DocCommentHeader.
+	* enum.cs:
+	  Added overriden DocCommentHeader and GenerateDocComment().
+
 2004-12-01  Raja R Harinath  <rharinath@novell.com>
 
 	* attribute.cs (Attribute.CheckAttributeType): Remove complain flag.
Index: driver.cs
===================================================================
--- driver.cs	(revision 36909)
+++ driver.cs	(working copy)
@@ -6,6 +6,7 @@
 // Licensed under the terms of the GNU GPL
 //
 // (C) 2001, 2002, 2003 Ximian, Inc (http://www.ximian.com)
+// (C) 2004 Novell, Inc
 //
 
 namespace Mono.CSharp
@@ -17,6 +18,7 @@
 	using System.IO;
 	using System.Text;
 	using System.Globalization;
+	using System.Xml;
 	using System.Diagnostics;
 
 	public enum Target {
@@ -220,6 +222,7 @@
 				"   -nostdlib[+|-]     Does not load core libraries\n" +
 				"   -nowarn:W1[,W2]    Disables one or more warnings\n" + 
 				"   -out:FNAME         Specifies output file\n" +
+				"   -doc:XMLFILE         Generates xml documentation into specified file\n" +
 				"   -pkg:P1[,Pn]       References packages P1..Pn\n" + 
 				"   --expect-error X   Expect that error X will be encountered\n" +
 				"   -recurse:SPEC      Recursively compiles the files in SPEC ([dir]/file)\n" + 
@@ -1101,10 +1104,10 @@
 			}
 			case "/doc": {
 				if (value == ""){
-					Report.Error (5, arg + " requires an argument");
+					Report.Error (2006, arg + " requires an argument");
 					Environment.Exit (1);
 				}
-				// TODO handle the /doc argument to generate xml doc
+				RootContext.Documentation = new Documentation (value);
 				return true;
 			}
 			case "/lib": {
@@ -1536,6 +1539,7 @@
 			if (timestamps)
 				ShowTime ("Resolving tree");
 			RootContext.ResolveTree ();
+
 			if (Report.Errors > 0)
 				return false;
 			if (timestamps)
@@ -1546,6 +1550,11 @@
 			RootContext.PopulateTypes ();
 			RootContext.DefineTypes ();
 			
+			if (RootContext.Documentation != null &&
+				!RootContext.Documentation.OutputDocComment (
+					output_file))
+				return false;
+
 			TypeManager.InitCodeHelpers ();
 
 			//
@@ -1735,7 +1744,6 @@
 #endif
 			return (Report.Errors == 0);
 		}
-
 	}
 
 	//
Index: enum.cs
===================================================================
--- enum.cs	(revision 36909)
+++ enum.cs	(working copy)
@@ -14,6 +14,7 @@
 using System.Reflection;
 using System.Reflection.Emit;
 using System.Globalization;
+using System.Xml;
 
 namespace Mono.CSharp {
 
@@ -100,13 +101,17 @@
 		protected override void VerifyObsoleteAttribute()
 		{
 		}
+
+		public override string DocCommentHeader {
+			get { return "F:"; }
+		}
 	}
 
 	/// <summary>
 	///   Enumeration container
 	/// </summary>
 	public class Enum : DeclSpace {
-		ArrayList ordered_enums;
+		public ArrayList ordered_enums;
 		
 		public Expression BaseType;
 		
@@ -152,7 +157,7 @@
 		///   Adds @name to the enumeration space, with @expr
 		///   being its definition.  
 		/// </summary>
-		public void AddEnumMember (string name, Expression expr, Location loc, Attributes opt_attrs)
+		public void AddEnumMember (string name, Expression expr, Location loc, Attributes opt_attrs, string documentation)
 		{
 			if (name == "value__") {
 				Report.Error (76, loc, "An item in an enumeration can't have an identifier `value__'");
@@ -160,6 +165,7 @@
 			}
 
 			EnumMember em = new EnumMember (this, expr, name, loc, opt_attrs);
+			em.DocComment = documentation;
 			if (!AddToContainer (em, false, name, ""))
 				return;
 
@@ -784,5 +790,21 @@
 		{
 			// UnderlyingType is never obsolete
 		}
+
+		//
+		// Generates xml doc comments (if any), and if required,
+		// handle warning report.
+		//
+		internal override void GenerateDocComment (DeclSpace ds)
+		{
+			DocUtil.GenerateEnumDocComment (this, ds);
+		}
+
+		//
+		//   Represents header string for documentation comment.
+		//
+		public override string DocCommentHeader {
+			get { return "T:"; }
+		}
 	}
 }
Index: doc.cs
===================================================================
--- doc.cs	(revision 0)
+++ doc.cs	(revision 0)
@@ -0,0 +1,743 @@
+//
+// doc.cs: Support for XML documentation comment.
+//
+// Author:
+//	Atsushi Enomoto <atsushi@ximian.com>
+//
+// Licensed under the terms of the GNU GPL
+//
+// (C) 2004 Novell, Inc.
+//
+//
+using System;
+using System.Collections;
+using System.Collections.Specialized;
+using System.IO;
+using System.Reflection;
+using System.Reflection.Emit;
+using System.Runtime.CompilerServices;
+using System.Runtime.InteropServices;
+using System.Security;
+using System.Security.Permissions;
+using System.Text;
+using System.Xml;
+
+using Mono.CompilerServices.SymbolWriter;
+
+namespace Mono.CSharp {
+
+	//
+	// Support class for XML documentation.
+	//
+	public class DocUtil
+	{
+		// TypeContainer
+
+		//
+		// Generates xml doc comments (if any), and if required,
+		// handle warning report.
+		//
+		internal static void GenerateTypeDocComment (TypeContainer t,
+			DeclSpace ds)
+		{
+			GenerateDocComment (t, ds);
+
+			if (t.DefaultStaticConstructor != null)
+				t.DefaultStaticConstructor.GenerateDocComment (t);
+
+			if (t.InstanceConstructors != null)
+				foreach (Constructor c in t.InstanceConstructors)
+					c.GenerateDocComment (t);
+
+			if (t.Types != null)
+				foreach (TypeContainer tc in t.Types)
+					tc.GenerateDocComment (t);
+
+			if (t.Parts != null) {
+				IDictionary comments = RootContext.Documentation.PartialComments;
+				foreach (ClassPart cp in t.Parts) {
+					if (cp.DocComment == null)
+						continue;
+					comments [cp] = cp;
+				}
+			}
+
+			if (t.Enums != null)
+				foreach (Enum en in t.Enums)
+					en.GenerateDocComment (t);
+
+			if (t.Constants != null)
+				foreach (Const c in t.Constants)
+					c.GenerateDocComment (t);
+
+			if (t.Fields != null)
+				foreach (Field f in t.Fields)
+					f.GenerateDocComment (t);
+
+			if (t.Events != null)
+				foreach (Event e in t.Events)
+					e.GenerateDocComment (t);
+
+			if (t.Indexers != null)
+				foreach (Indexer ix in t.Indexers)
+					ix.GenerateDocComment (t);
+
+			if (t.Properties != null)
+				foreach (Property p in t.Properties)
+					p.GenerateDocComment (t);
+
+			if (t.Methods != null)
+				foreach (Method m in t.Methods)
+					m.GenerateDocComment (t);
+
+			if (t.Operators != null)
+				foreach (Operator o in t.Operators)
+					o.GenerateDocComment (t);
+		}
+
+		// MemberCore
+		private static readonly string lineHead =
+			Environment.NewLine + "            ";
+
+		private static XmlNode GetDocCommentNode (MemberCore mc,
+			string name)
+		{
+			// FIXME: It could be even optimizable as not
+			// to use XmlDocument. But anyways the nodes
+			// are not kept in memory.
+			XmlDocument doc = RootContext.Documentation.XmlDocumentation;
+			try {
+				XmlElement el = doc.CreateElement ("member");
+				el.SetAttribute ("name", name);
+				string normalized = mc.DocComment;
+				el.InnerXml = normalized;
+				// csc keeps lines as written in the sources
+				// and inserts formatting indentation (which 
+				// is different from XmlTextWriter.Formatting
+				// one), but when a start tag contains an 
+				// endline, it joins the next line. We don't
+				// have to follow such a hacky behavior.
+				string [] split =
+					normalized.Split ('\n');
+				int j = 0;
+				for (int i = 0; i < split.Length; i++) {
+					string s = split [i].TrimEnd ();
+					if (s.Length > 0)
+						split [j++] = s;
+				}
+				el.InnerXml = lineHead + String.Join (
+					lineHead, split, 0, j);
+				return el;
+			} catch (XmlException ex) {
+				Report.Warning (1570, 1, mc.Location, "XML comment on '{0}' has non-well-formed XML ({1}).", name, ex.Message);
+				XmlComment com = doc.CreateComment (String.Format ("FIXME: Invalid documentation markup was found for member {0}", name));
+				return com;
+			}
+		}
+
+		//
+		// Generates xml doc comments (if any), and if required,
+		// handle warning report.
+		//
+		internal static void GenerateDocComment (MemberCore mc,
+			DeclSpace ds)
+		{
+			if (mc.DocComment != null) {
+				string name = mc.GetDocCommentName (ds);
+
+				XmlNode n = GetDocCommentNode (mc, name);
+
+				XmlElement el = n as XmlElement;
+				if (el != null) {
+					mc.OnGenerateDocComment (ds, el);
+
+					// FIXME: it could be done with XmlReader
+					foreach (XmlElement inc in n.SelectNodes (".//include"))
+						HandleInclude (mc, inc);
+
+					// FIXME: it could be done with XmlReader
+					DeclSpace dsTarget = mc as DeclSpace;
+					if (dsTarget == null)
+						dsTarget = ds;
+
+					foreach (XmlElement see in n.SelectNodes (".//see"))
+						HandleSee (mc, dsTarget, name, see);
+					foreach (XmlElement seealso in n.SelectNodes (".//seealso"))
+						HandleSeeAlso (mc, dsTarget, name, seealso);
+				}
+
+				n.WriteTo (RootContext.Documentation.XmlCommentOutput);
+			}
+			else if (mc.IsExposedFromAssembly (ds) &&
+				// There are no warnings when the container also
+				// misses documentations.
+				(ds == null || ds.DocComment != null))
+			{
+				Report.Warning (1591, 4, mc.Location,
+					"Missing XML comment for publicly visible type or member '{0}'", mc.GetSignatureForError ());
+			}
+		}
+
+		//
+		// Processes "include" element. Check included file and
+		// embed the document content inside this documentation node.
+		//
+		private static void HandleInclude (MemberCore mc, XmlElement el)
+		{
+			string file = el.GetAttribute ("file");
+			string path = el.GetAttribute ("path");
+			if (file == "") {
+				Report.Warning (1590, 1, mc.Location, "Invalid XML 'include' element; Missing 'file' attribute.");
+				el.ParentNode.InsertBefore (el.OwnerDocument.CreateComment (" Include tag is invalid "), el);
+			}
+			else if (path == "") {
+				Report.Warning (1590, 1, mc.Location, "Invalid XML 'include' element; Missing 'path' attribute.");
+				el.ParentNode.InsertBefore (el.OwnerDocument.CreateComment (" Include tag is invalid "), el);
+			}
+			else {
+				XmlDocument doc = RootContext.Documentation.StoredDocuments [file] as XmlDocument;
+				if (doc == null) {
+					try {
+						doc = new XmlDocument ();
+						doc.Load (file);
+						RootContext.Documentation.StoredDocuments.Add (file, doc);
+					} catch (Exception) {
+						el.ParentNode.InsertBefore (el.OwnerDocument.CreateComment (String.Format (" Badly formed XML in at comment file '{0}': cannot be included ", file)), el);
+						Report.Warning (1592, 1, mc.Location, "Badly formed XML in included comments file -- '{0}'", file);
+					}
+				}
+				bool keepIncludeNode = false;
+				if (doc != null) {
+					try {
+						XmlNodeList nl = doc.SelectNodes (path);
+						if (nl.Count == 0) {
+							el.ParentNode.InsertBefore (el.OwnerDocument.CreateComment (" No matching elements were found for the include tag embedded here. "), el);
+					
+							keepIncludeNode = true;
+						}
+						foreach (XmlNode n in nl)
+							el.ParentNode.InsertBefore (el.OwnerDocument.ImportNode (n, true), el);
+					} catch (Exception ex) {
+						el.ParentNode.InsertBefore (el.OwnerDocument.CreateComment (" Failed to insert some or all of included XML "), el);
+						Report.Warning (1589, 1, mc.Location, "Unable to include XML fragment '{0}' of file {1} -- {2}.", path, file, ex.Message);
+					}
+				}
+				if (!keepIncludeNode)
+					el.ParentNode.RemoveChild (el);
+			}
+		}
+
+		//
+		// Handles <see> elements.
+		//
+		private static void HandleSee (MemberCore mc,
+			DeclSpace ds, string name, XmlElement see)
+		{
+			HandleXrefCommon (mc, ds, name, see);
+		}
+
+		//
+		// Handles <seealso> elements.
+		//
+		private static void HandleSeeAlso (MemberCore mc,
+			DeclSpace ds, string name, XmlElement seealso)
+		{
+			HandleXrefCommon (mc, ds, name, seealso);
+		}
+
+		static readonly char [] wsChars =
+			new char [] {' ', '\t', '\n', '\r'};
+
+		//
+		// returns a full runtime type name from a name which might
+		// be C# specific type name.
+		//
+		private static Type FindDocumentedType (MemberCore mc,
+			string identifier, DeclSpace ds)
+		{
+			switch (identifier) {
+			case "int":
+				return typeof (int);
+			case "uint":
+				return typeof (uint);
+			case "short":
+				return typeof (short);
+			case "ushort":
+				return typeof (ushort);
+			case "long":
+				return typeof (long);
+			case "ulong":
+				return typeof (ulong);
+			case "float":
+				return typeof (float);
+			case "double":
+				return typeof (double);
+			case "char":
+				return typeof (char);
+			case "decimal":
+				return typeof (decimal);
+			case "byte":
+				return typeof (byte);
+			case "sbyte":
+				return typeof (sbyte);
+			case "object":
+				return typeof (object);
+			case "bool":
+				return typeof (bool);
+			case "string":
+				return typeof (string);
+			case "void":
+				return typeof (void);
+			}
+			return ds.FindType (mc.Location, identifier);
+		}
+
+		//
+		// Returns a MemberInfo that is referenced in XML documentation
+		// (by "see" or "seealso" elements).
+		//
+		private static MemberInfo FindDocumentedMember (MemberCore mc,
+			Type type, string memberName, Type [] paramList, 
+			DeclSpace ds, out int warningType, string cref)
+		{
+			warningType = 0;
+			MethodSignature msig = new MethodSignature (memberName, null, paramList);
+			MemberInfo [] mis = type.FindMembers (
+				MemberTypes.All,
+				BindingFlags.Public | BindingFlags.NonPublic | BindingFlags.Static | BindingFlags.Instance,
+				MethodSignature.method_signature_filter,
+				msig);
+			if (mis.Length > 0)
+				return mis [0];
+
+			if (paramList.Length == 0) {
+				// search for fields/events etc.
+				mis = type.FindMembers (
+					MemberTypes.All,
+					BindingFlags.Public | BindingFlags.NonPublic | BindingFlags.Static | BindingFlags.Instance,
+					Type.FilterName,
+					memberName);
+				return (mis.Length > 0) ? mis [0] : null;
+			}
+
+			// search for operators (whose parameters exactly
+			// matches with the list) and possibly report CS1581.
+			string oper = null;
+			string returnTypeName = null;
+			if (memberName.StartsWith ("implicit operator ")) {
+				oper = "op_Implicit";
+				returnTypeName = memberName.Substring (18).Trim (wsChars);
+			}
+			else if (memberName.StartsWith ("explicit operator ")) {
+				oper = "op_Explicit";
+				returnTypeName = memberName.Substring (18).Trim (wsChars);
+			}
+			else if (memberName.StartsWith ("operator ")) {
+				oper = memberName.Substring (9).Trim (wsChars);
+				switch (oper) {
+				// either unary or binary
+				case "+":
+					oper = paramList.Length == 2 ?
+						Binary.oper_names [(int) Binary.Operator.Addition] :
+						Unary.oper_names [(int) Unary.Operator.UnaryPlus];
+					break;
+				case "-":
+					oper = paramList.Length == 2 ?
+						Binary.oper_names [(int) Binary.Operator.Subtraction] :
+						Unary.oper_names [(int) Unary.Operator.UnaryNegation];
+					break;
+				// unary
+				case "!":
+					oper = Unary.oper_names [(int) Unary.Operator.LogicalNot]; break;
+				case "~":
+					oper = Unary.oper_names [(int) Unary.Operator.OnesComplement]; break;
+					
+				case "++":
+					oper = "op_Increment"; break;
+				case "--":
+					oper = "op_Decrement"; break;
+				case "true":
+					oper = "op_True"; break;
+				case "false":
+					oper = "op_False"; break;
+				// binary
+				case "*":
+					oper = Binary.oper_names [(int) Binary.Operator.Multiply]; break;
+				case "/":
+					oper = Binary.oper_names [(int) Binary.Operator.Division]; break;
+				case "%":
+					oper = Binary.oper_names [(int) Binary.Operator.Modulus]; break;
+				case "&":
+					oper = Binary.oper_names [(int) Binary.Operator.BitwiseAnd]; break;
+				case "|":
+					oper = Binary.oper_names [(int) Binary.Operator.BitwiseOr]; break;
+				case "^":
+					oper = Binary.oper_names [(int) Binary.Operator.ExclusiveOr]; break;
+				case "<<":
+					oper = Binary.oper_names [(int) Binary.Operator.LeftShift]; break;
+				case ">>":
+					oper = Binary.oper_names [(int) Binary.Operator.RightShift]; break;
+				case "==":
+					oper = Binary.oper_names [(int) Binary.Operator.Equality]; break;
+				case "!=":
+					oper = Binary.oper_names [(int) Binary.Operator.Inequality]; break;
+				case "<":
+					oper = Binary.oper_names [(int) Binary.Operator.LessThan]; break;
+				case ">":
+					oper = Binary.oper_names [(int) Binary.Operator.GreaterThan]; break;
+				case "<=":
+					oper = Binary.oper_names [(int) Binary.Operator.LessThanOrEqual]; break;
+				case ">=":
+					oper = Binary.oper_names [(int) Binary.Operator.GreaterThanOrEqual]; break;
+				default:
+					warningType = 1584;
+					Report.Warning (1020, 1, mc.Location, "Overloadable {0} operator is expected", paramList.Length == 2 ? "binary" : "unary");
+					Report.Warning (1584, 1, mc.Location, "XML comment on '{0}' has syntactically incorrect attribute '{1}'", mc.GetSignatureForError (), cref);
+					return null;
+				}
+			}
+			// here we still does not consider return type (to
+			// detect CS1581 or CS1002+CS1584).
+			msig = new MethodSignature (oper, null, paramList);
+			mis = type.FindMembers (
+				MemberTypes.Method,
+				BindingFlags.Public | BindingFlags.NonPublic | BindingFlags.Static,
+				MethodSignature.method_signature_filter,
+				msig);
+			if (mis.Length == 0)
+				return null; // CS1574
+			MemberInfo mi = mis [0];
+			Type expected = mi is MethodInfo ?
+				((MethodInfo) mi).ReturnType :
+				mi is PropertyInfo ?
+				((PropertyInfo) mi).PropertyType :
+				null;
+			if (returnTypeName != null) {
+				Type returnType = FindDocumentedType (mc, returnTypeName, ds);
+				if (returnType == null || returnType != expected) {
+					warningType = 1581;
+					Report.Warning (1581, 1, mc.Location, "Invalid return type in XML comment cref attribute '{0}'", cref);
+					return null;
+				}
+			}
+			return mis [0];
+		}
+
+		private static Type [] emptyParamList = new Type [0];
+
+		//
+		// Processes "see" or "seealso" elements.
+		// Checks cref attribute.
+		//
+		private static void HandleXrefCommon (MemberCore mc,
+			DeclSpace ds, string name, XmlElement xref)
+		{
+			string cref = xref.GetAttribute ("cref").Trim (wsChars);
+			// when, XmlReader, "if (cref == null)"
+			if (!xref.HasAttribute ("cref"))
+				return;
+			if (cref.Length == 0)
+				Report.Warning (1001, 1, mc.Location, "Identifier expected");
+				// ... and continue until CS1584.
+
+			string signature, identifier, parameters;
+
+			// strip 'T:' 'M:' 'F:' 'P:' 'E:' etc.
+			// Here, MS ignores its member kind. No idea why.
+			if (cref.Length > 2 && cref [1] == ':')
+				signature = cref.Substring (2).Trim (wsChars);
+			else
+				signature = cref;
+
+			int parensPos = signature.IndexOf ('(');
+			if (parensPos > 0 && signature [signature.Length - 1] == ')') {
+				identifier = signature.Substring (0, parensPos).Trim (wsChars);
+				parameters = signature.Substring (parensPos + 1, signature.Length - parensPos - 2);
+			}
+			else {
+				identifier = signature;
+				parameters = String.Empty;
+			}
+
+			string alias = ds.LookupAlias (identifier);
+			if (alias != null)
+				identifier = alias;
+
+			// Check if identifier is valid.
+			// This check is not necessary to mark as error, but
+			// csc specially reports CS1584 for wrong identifiers.
+			foreach (string nameElem in identifier.Split ('.')) {
+				if (!Tokenizer.IsValidIdentifier (nameElem) && nameElem.IndexOf ("operator") < 0) {
+					Report.Warning (1584, 1, mc.Location, "XML comment on '{0}' has syntactically incorrect attribute '{1}'", mc.GetSignatureForError (), cref);
+					xref.SetAttribute ("cref", "!:" + signature);
+					return;
+				}
+			}
+
+			// check if parameters are valid
+			Type [] parameterTypes = emptyParamList;
+			if (parameters.Length > 0) {
+				string [] paramList = parameters.Split (',');
+				ArrayList plist = new ArrayList ();
+				for (int i = 0; i < paramList.Length; i++) {
+					string paramTypeName = paramList [i].Trim (wsChars);
+					alias = ds.LookupAlias (paramTypeName);
+					if (alias != null)
+						paramTypeName = alias;
+					Type paramType = FindDocumentedType (mc, paramTypeName, ds);
+					if (paramType == null) {
+						Report.Warning (1580, 1, mc.Location, "Invalid type for parameter '{0}' in XML comment cref attribute '{1}'", i + 1, cref);
+						return;
+					}
+					plist.Add (paramType);
+				}
+				parameterTypes = plist.ToArray (typeof (Type)) as Type [];
+			}
+
+			Type type = FindDocumentedType (mc, identifier, ds);
+			if (type != null) {
+				xref.SetAttribute ("cref", "T:" + type.FullName.Replace ("+", "."));
+				return; // a type
+			}
+
+			int period = identifier.LastIndexOf ('.');
+			if (period > 0) {
+				string typeName = identifier.Substring (0, period);
+				string memberName = identifier.Substring (period + 1);
+				type = FindDocumentedType (mc, typeName, ds);
+				int warnResult;
+				if (type != null) {
+					MemberInfo mi = FindDocumentedMember (mc, type, memberName, parameterTypes, ds, out warnResult, cref);
+					if (warnResult > 0)
+						return;
+					if (mi != null) {
+						xref.SetAttribute ("cref", GetMemberDocHead (mi.MemberType) + type.FullName.Replace ("+", ".") + "." + memberName);
+						return; // a member of a type
+					}
+				}
+			}
+			else {
+				int warnResult;
+				MemberInfo mi = FindDocumentedMember (mc, ds.TypeBuilder, identifier, parameterTypes, ds, out warnResult, cref);
+				if (warnResult > 0)
+					return;
+				if (mi != null) {
+					xref.SetAttribute ("cref", GetMemberDocHead (mi.MemberType) + ds.TypeBuilder.FullName.Replace ("+", ".") + "." + identifier);
+					return; // local member name
+				}
+			}
+
+			Report.Warning (1574, 1, mc.Location, "XML comment on '{0}' has cref attribute '{1}' that could not be resolved in '{2}'.", mc.GetSignatureForError (), cref, ds.GetSignatureForError ());
+
+			xref.SetAttribute ("cref", "!:" + identifier);
+		}
+
+		//
+		// Get a prefix from member type for XML documentation (used
+		// to formalize cref target name).
+		//
+		static string GetMemberDocHead (MemberTypes type)
+		{
+			switch (type) {
+			case MemberTypes.Constructor:
+			case MemberTypes.Method:
+				return "M:";
+			case MemberTypes.Event:
+				return "E:";
+			case MemberTypes.Field:
+				return "F:";
+			case MemberTypes.NestedType:
+			case MemberTypes.TypeInfo:
+				return "T:";
+			case MemberTypes.Property:
+				return "P:";
+			}
+			return "!:";
+		}
+
+		// MethodCore
+
+		//
+		// Returns a string that represents the signature for this 
+		// member which should be used in XML documentation.
+		//
+		public static string GetMethodDocCommentName (MethodCore mc, DeclSpace ds)
+		{
+			Parameter [] plist = mc.Parameters.FixedParameters;
+			Parameter parr = mc.Parameters.ArrayParameter;
+			string paramSpec = String.Empty;
+			if (plist != null) {
+				StringBuilder psb = new StringBuilder ();
+				foreach (Parameter p in plist) {
+					psb.Append (psb.Length != 0 ? "," : "(");
+					psb.Append (p.ParameterType.FullName.Replace ("+", "."));
+				}
+				psb.Append (")");
+				paramSpec = psb.ToString ();
+			}
+			else if (parr != null)
+				paramSpec = String.Concat (
+					"(",
+					parr.ParameterType.FullName.Replace ("+", "."),
+					")");
+
+			string name = mc is Constructor ? "#ctor" : mc.Name;
+			return String.Concat (mc.DocCommentHeader, ds.Name, ".", name, paramSpec);
+		}
+
+		//
+		// Raised (and passed an XmlElement that contains the comment)
+		// when GenerateDocComment is writing documentation expectedly.
+		//
+		// FIXME: with a few effort, it could be done with XmlReader,
+		// that means removal of DOM use.
+		//
+		internal static void OnMethodGenerateDocComment (
+			MethodCore mc, DeclSpace ds, XmlElement el)
+		{
+			Hashtable paramTags = new Hashtable ();
+			foreach (XmlElement pelem in el.SelectNodes ("param")) {
+				int i;
+				string xname = pelem.GetAttribute ("name");
+				if (xname == "")
+					continue; // really? but MS looks doing so
+				if (xname != "" && mc.Parameters.GetParameterByName (xname, out i) == null)
+					Report.Warning (1572, 2, mc.Location, "XML comment on '{0}' has a 'param' tag for '{1}', but there is no such parameter.", mc.Name, xname);
+				else if (paramTags [xname] != null)
+					Report.Warning (1571, 2, mc.Location, "XML comment on '{0}' has a duplicate param tag for '{1}'", mc.Name, xname);
+				paramTags [xname] = xname;
+			}
+			Parameter [] plist = mc.Parameters.FixedParameters;
+			Parameter parr = mc.Parameters.ArrayParameter;
+			if (plist != null) {
+				foreach (Parameter p in plist) {
+					if (paramTags.Count > 0 && paramTags [p.Name] == null)
+						Report.Warning (1573, 4, mc.Location, "Parameter '{0}' has no matching param tag in the XML comment for '{1}' (but other parameters do)", mc.Name, p.Name);
+				}
+			}
+		}
+
+		// Enum
+		public static void GenerateEnumDocComment (Enum e, DeclSpace ds)
+		{
+			GenerateDocComment (e, ds);
+			foreach (string name in e.ordered_enums) {
+				MemberCore mc = e.GetDefinition (name);
+				GenerateDocComment (mc, e);
+			}
+		}
+	}
+
+	//
+	// Implements XML documentation generation.
+	//
+	public class Documentation
+	{
+		public Documentation (string xml_output_filename)
+		{
+			docfilename = xml_output_filename;
+			XmlDocumentation = new XmlDocument ();
+			XmlDocumentation.PreserveWhitespace = false;
+		}
+
+		private string docfilename;
+
+		//
+		// Used to create element which helps well-formedness checking.
+		//
+		public XmlDocument XmlDocumentation;
+
+		//
+		// The output for XML documentation.
+		//
+		public XmlWriter XmlCommentOutput;
+
+		//
+		// Stores XmlDocuments that are included in XML documentation.
+		// Keys are included filenames, values are XmlDocuments.
+		//
+		public Hashtable StoredDocuments = new Hashtable ();
+
+		//
+		// Stores comments on partial types (should handle uniquely).
+		// Keys are PartialContainers, values are comment strings
+		// (didn't use StringBuilder; usually we have just 2 or more).
+		//
+		public IDictionary PartialComments = new ListDictionary ();
+
+		//
+		// Outputs XML documentation comment from tokenized comments.
+		//
+		public bool OutputDocComment (string asmfilename)
+		{
+			XmlTextWriter w = null;
+			try {
+				w = new XmlTextWriter (docfilename, null);
+				w.Indentation = 4;
+				w.Formatting = Formatting.Indented;
+				w.WriteStartDocument ();
+				w.WriteStartElement ("doc");
+				w.WriteStartElement ("assembly");
+				w.WriteStartElement ("name");
+				w.WriteString (Path.ChangeExtension (asmfilename, null));
+				w.WriteEndElement (); // name
+				w.WriteEndElement (); // assembly
+				w.WriteStartElement ("members");
+				XmlCommentOutput = w;
+				GenerateDocComment ();
+				w.WriteFullEndElement (); // members
+				w.WriteEndElement ();
+				w.WriteWhitespace (Environment.NewLine);
+				w.WriteEndDocument ();
+				return true;
+			} catch (Exception ex) {
+				Report.Error (1569, "Error generating XML documentation file '{0}' ('{1}')", docfilename, ex.Message);
+				return false;
+			} finally {
+				if (w != null)
+					w.Close ();
+			}
+		}
+
+		//
+		// Fixes full type name of each documented types/members up.
+		//
+		public void GenerateDocComment ()
+		{
+			TypeContainer root = RootContext.Tree.Types;
+			if (root.Interfaces != null)
+				foreach (Interface i in root.Interfaces) 
+					DocUtil.GenerateTypeDocComment (i, null);
+
+			if (root.Types != null)
+				foreach (TypeContainer tc in root.Types)
+					DocUtil.GenerateTypeDocComment (tc, null);
+
+			if (root.Parts != null) {
+				IDictionary comments = PartialComments;
+				foreach (ClassPart cp in root.Parts) {
+					if (cp.DocComment == null)
+						continue;
+					comments [cp] = cp;
+				}
+			}
+
+			if (root.Delegates != null)
+				foreach (Delegate d in root.Delegates) 
+					DocUtil.GenerateDocComment (d, null);
+
+			if (root.Enums != null)
+				foreach (Enum e in root.Enums)
+					DocUtil.GenerateEnumDocComment (e, null);
+
+			IDictionary table = new ListDictionary ();
+			foreach (ClassPart cp in PartialComments.Keys) {
+				table [cp.PartialContainer] += cp.DocComment;
+			}
+			foreach (PartialContainer pc in table.Keys) {
+				pc.DocComment = table [pc] as string;
+				DocUtil.GenerateDocComment (pc, null);
+			}
+		}
+	}
+}

Property changes on: doc.cs
___________________________________________________________________
Name: svn:executable
   + *
