Index: cs-tokenizer.cs
===================================================================
--- cs-tokenizer.cs	(revision 36616)
+++ cs-tokenizer.cs	(working copy)
@@ -42,6 +42,17 @@
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
@@ -132,6 +143,18 @@
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
@@ -362,6 +385,8 @@
 					define (def);
 			}
 
+			xml_comment_buffer = new StringBuilder ();
+
 			//
 			// FIXME: This could be `Location.Push' but we have to
 			// find out why the MS compiler allows this
@@ -411,6 +436,9 @@
 			case '}':
 				return Token.CLOSE_BRACE;
 			case '[':
+				// To block doccomment inside attribute declaration.
+				if (doc_state == XmlCommentState.Allowed)
+					doc_state = XmlCommentState.NotAllowed;
 				return Token.OPEN_BRACKET;
 			case ']':
 				return Token.CLOSE_BRACKET;
@@ -1741,6 +1769,15 @@
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
@@ -1862,6 +1899,13 @@
 				
 					if (d == '/'){
 						getChar ();
+						if (RootContext.NeedDocument && peekChar () == '/') {
+							getChar ();
+							if (doc_state == XmlCommentState.Allowed)
+								handle_one_line_xml_comment ();
+							else if (doc_state == XmlCommentState.NotAllowed)
+								warn_incorrect_doc_comment ();
+						}
 						while ((d = getChar ()) != -1 && (d != '\n') && d != '\r')
 							col++;
 						if (d == '\n'){
@@ -1874,13 +1918,33 @@
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
+							if (doc_state == XmlCommentState.Allowed)
+								docAppend = true;
+							else if (doc_state == XmlCommentState.NotAllowed)
+								warn_incorrect_doc_comment ();
+						}
 
+						int currentCommentStart = xml_comment_buffer.Length;
+						if (docAppend)
+							xml_comment_buffer.Append (Environment.NewLine);
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
@@ -1889,6 +1953,8 @@
 								tokens_seen = false;
 							}
 						}
+						if (docAppend)
+							update_formatted_doc_comment (currentCommentStart);
 						continue;
 					}
 					goto is_punct_label;
@@ -2037,6 +2103,97 @@
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
+			while ((c = peekChar ()) != -1 && (c != '\n') && c != '\r') {
+				col++;
+				xml_comment_buffer.Append ((char) getChar ());
+			}
+			if (c == '\r') {
+				getChar ();
+				xml_comment_buffer.Append ('\r');
+				if (peekChar () == '\n')
+					xml_comment_buffer.Append ('\n');
+			}
+			else if (c == '\n')
+				xml_comment_buffer.Append ('\n');
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
+				length).Split ('\n');
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
+				String.Join ("\n", lines));
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
@@ -2049,4 +2206,18 @@
 				
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
Index: rootcontext.cs
===================================================================
--- rootcontext.cs	(revision 36616)
+++ rootcontext.cs	(working copy)
@@ -13,6 +13,7 @@
 using System.Reflection;
 using System.Reflection.Emit;
 using System.Diagnostics;
+using System.Xml;
 
 namespace Mono.CSharp {
 
@@ -80,12 +81,34 @@
 		public static bool StrongNameDelaySign = false;
 
 		//
+		// If set, enable XML documentation generation
+		//
+		public static bool NeedDocument = false;
+
+		//
+		// Used to create element which helps well-formedness checking.
+		//
+		public static XmlDocument XmlDocumentation;
+
+		//
+		// The output for XML documentation.
+		//
+		public static XmlWriter XmlCommentOutput;
+
+		//
+		// Stores XmlDocuments that are included in XML documentation.
+		//
+		public static Hashtable StoredDocuments = new Hashtable ();
+
+		//
 		// Constructor
 		//
 		static RootContext ()
 		{
 			tree = new Tree ();
 			type_container_resolve_order = new ArrayList ();
+			XmlDocumentation = new XmlDocument ();
+			XmlDocumentation.PreserveWhitespace = false;
 		}
 		
 		public static bool NeedsEntryPoint {
@@ -174,6 +197,29 @@
 					e.DefineType ();
 		}
 
+		//
+		// Fixes full type name of each documented types/members up.
+		//
+		static public void GenerateDocComment ()
+		{
+			TypeContainer root = Tree.Types;
+
+			if (root.Interfaces != null)
+				foreach (Interface i in root.Interfaces) 
+					i.GenerateDocComment (null);
+
+			foreach (TypeContainer tc in root.Types)
+				tc.GenerateDocComment (null);
+
+			if (root.Delegates != null)
+				foreach (Delegate d in root.Delegates) 
+					d.GenerateDocComment (null);
+
+			if (root.Enums != null)
+				foreach (Enum e in root.Enums)
+					e.GenerateDocComment (null);
+		}
+
 		static void Error_TypeConflict (string name, Location loc)
 		{
 			Report.Error (
Index: class.cs
===================================================================
--- class.cs	(revision 36616)
+++ class.cs	(working copy)
@@ -40,6 +40,7 @@
 using System.Security;
 using System.Security.Permissions;
 using System.Text;
+using System.Xml;
 
 using Mono.CompilerServices.SymbolWriter;
 
@@ -2396,6 +2397,62 @@
 			return FindMembers (mt, bf | BindingFlags.DeclaredOnly, null, null);
 		}
 
+		//
+		// Generates xml doc comments (if any), and if required,
+		// handle warning report.
+		//
+		internal override void GenerateDocComment (DeclSpace ds)
+		{
+			base.GenerateDocComment (ds);
+
+			if (default_static_constructor != null)
+				default_static_constructor.GenerateDocComment (this);
+
+			if (InstanceConstructors != null)
+				foreach (Constructor c in InstanceConstructors)
+					c.GenerateDocComment (this);
+
+			if (Types != null)
+				foreach (TypeContainer tc in Types)
+					tc.GenerateDocComment (this);
+
+			if (Enums != null)
+				foreach (Enum en in Enums)
+					en.GenerateDocComment (this);
+
+			if (Constants != null)
+				foreach (Const c in Constants)
+					c.GenerateDocComment (this);
+
+			if (Fields != null)
+				foreach (Field f in Fields)
+					f.GenerateDocComment (this);
+
+			if (Events != null)
+				foreach (Event e in Events)
+					e.GenerateDocComment (this);
+
+			if (Indexers != null)
+				foreach (Indexer ix in Indexers)
+					ix.GenerateDocComment (this);
+
+			if (Properties != null)
+				foreach (Property p in Properties)
+					p.GenerateDocComment (this);
+
+			if (Methods != null)
+				foreach (Method m in Methods)
+					m.GenerateDocComment (this);
+
+			if (Operators != null)
+				foreach (Operator o in Operators)
+					o.GenerateDocComment (this);
+		}
+
+		public override string DocCommentHeader {
+			get { return "T:"; }
+		}
+
 		public virtual MemberCache ParentCache {
 			get {
 				return parent_cache;
@@ -3296,6 +3353,72 @@
 			return true;
 		}
 
+		//
+		// Returns a string that represents the signature for this 
+		// member which should be used in XML documentation.
+		//
+		public override string GetDocCommentName (DeclSpace ds)
+		{
+			Parameter [] plist = Parameters.FixedParameters;
+			Parameter parr = Parameters.ArrayParameter;
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
+			string name = this is Constructor ? "#ctor" : Name;
+			return String.Concat (DocCommentHeader, ds.Name, ".", name, paramSpec);
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
+			Hashtable paramTags = new Hashtable ();
+			foreach (XmlElement pelem in el.SelectNodes ("param")) {
+				int i;
+				string xname = pelem.GetAttribute ("name");
+				if (xname == "")
+					continue; // really? but MS looks doing so
+				if (xname != "" && Parameters.GetParameterByName (xname, out i) == null)
+					Report.Warning (1572, 2, Location, "XML comment on '{0}' has a 'param' tag for '{1}', but there is no such parameter.", Name, xname);
+				else if (paramTags [xname] != null)
+					Report.Warning (1571, 2, Location, "XML comment on '{0}' has a duplicate param tag for '{1}'", Name, xname);
+				paramTags [xname] = xname;
+			}
+			Parameter [] plist = Parameters.FixedParameters;
+			Parameter parr = Parameters.ArrayParameter;
+			if (plist != null) {
+				foreach (Parameter p in plist) {
+					if (paramTags.Count > 0 && paramTags [p.Name] == null)
+						Report.Warning (1573, 4, Location, "Parameter '{0}' has no matching param tag in the XML comment for '{1}' (but other parameters do)", Name, p.Name);
+				}
+			}
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
@@ -5223,6 +5346,13 @@
 
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
@@ -5531,6 +5661,13 @@
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
@@ -5981,6 +6118,13 @@
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
@@ -6621,6 +6765,13 @@
 
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
--- decl.cs	(revision 36616)
+++ decl.cs	(working copy)
@@ -16,6 +16,7 @@
 using System.Globalization;
 using System.Reflection.Emit;
 using System.Reflection;
+using System.Xml;
 
 namespace Mono.CSharp {
 
@@ -137,6 +138,17 @@
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
@@ -363,6 +375,469 @@
 
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
+		private XmlNode GetDocCommentNode (string name)
+		{
+			// FIXME: It could be even optimizable as not
+			// to use XmlDocument. But anyways the nodes
+			// are not kept in memory.
+			XmlDocument doc = RootContext.XmlDocumentation;
+			try {
+				XmlElement el = doc.CreateElement ("member");
+				el.SetAttribute ("name", name);
+				string normalized = DocComment;
+				el.InnerXml = normalized;
+				// csc keeps lines as written in the sources
+				// and inserts formatting indentation (which 
+				// is different from XmlTextWriter.Formatting
+				// one), but when a start tag contains an 
+				// endline, it joins the next line. We don't
+				// have to follow such a hacky behavior.
+				string [] split =
+					DocComment.Split ('\n');
+				int j = 0;
+				for (int i = 0; i < split.Length; i++) {
+					string s = split [i].TrimEnd ();
+					if (s.Length > 0)
+						split [j++] = s;
+				}
+				el.InnerXml = String.Join (
+					"\n            ", split, 0, j);
+				return el;
+			} catch (XmlException ex) {
+				Report.Warning (1570, 1, Location, "XML comment on '{0}' has non-well-formed XML ({1}).", name, ex.Message);
+				XmlComment com = doc.CreateComment (String.Format ("FIXME: Invalid documentation markup was found for member {0}", name));
+				return com;
+			}
+		}
+
+		//
+		// Generates xml doc comments (if any), and if required,
+		// handle warning report.
+		//
+		internal virtual void GenerateDocComment (DeclSpace ds)
+		{
+			if (DocComment != null) {
+				string name = GetDocCommentName (ds);
+
+				XmlNode n = GetDocCommentNode (name);
+
+				XmlElement el = n as XmlElement;
+				if (el != null) {
+					OnGenerateDocComment (ds, el);
+
+					// FIXME: it could be done with XmlReader
+					foreach (XmlElement inc in n.SelectNodes (".//include"))
+						HandleInclude (inc);
+
+					// FIXME: it could be done with XmlReader
+					DeclSpace dsTarget = this as DeclSpace;
+					if (dsTarget == null)
+						dsTarget = ds;
+
+					foreach (XmlElement see in n.SelectNodes (".//see"))
+						HandleSee (dsTarget, name, see);
+					foreach (XmlElement seealso in n.SelectNodes (".//seealso"))
+						HandleSeeAlso (dsTarget, name, seealso);
+				}
+
+				n.WriteTo (RootContext.XmlCommentOutput);
+			}
+			else if (IsExposedFromAssembly (ds) &&
+				// There are no warnings when the container also
+				// misses documentations.
+				(ds == null || ds.DocComment != null))
+			{
+				Report.Warning (1591, 4, Location,
+					"Missing XML comment for publicly visible type or member '{0}'", GetSignatureForError ());
+			}
+		}
+
+		//
+		// Processes "include" element. Check included file and
+		// embed the document content inside this documentation node.
+		//
+		private void HandleInclude (XmlElement el)
+		{
+			string file = el.GetAttribute ("file");
+			string path = el.GetAttribute ("path");
+			if (file == "") {
+				Report.Warning (1590, 1, Location, "Invalid XML 'include' element; Missing 'file' attribute.");
+				el.ParentNode.InsertBefore (el.OwnerDocument.CreateComment (" Include tag is invalid "), el);
+			}
+			else if (path == "") {
+				Report.Warning (1590, 1, Location, "Invalid XML 'include' element; Missing 'path' attribute.");
+				el.ParentNode.InsertBefore (el.OwnerDocument.CreateComment (" Include tag is invalid "), el);
+			}
+			else {
+				XmlDocument doc = RootContext.StoredDocuments [file] as XmlDocument;
+				if (doc == null) {
+					try {
+						doc = new XmlDocument ();
+						doc.Load (file);
+						RootContext.StoredDocuments.Add (file, doc);
+					} catch (Exception) {
+						el.ParentNode.InsertBefore (el.OwnerDocument.CreateComment (String.Format (" Badly formed XML in at comment file '{0}': cannot be included ", file)), el);
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
+
+		//
+		// Handles <see> elements.
+		//
+		private void HandleSee (DeclSpace ds, string name, XmlElement see)
+		{
+			HandleXrefCommon (ds, name, see);
+		}
+
+		//
+		// Handles <seealso> elements.
+		//
+		private void HandleSeeAlso (DeclSpace ds, string name, XmlElement seealso)
+		{
+			HandleXrefCommon (ds, name, seealso);
+		}
+
+		static readonly char [] wsChars =
+			new char [] {' ', '\t', '\n', '\r'};
+
+		//
+		// returns a full runtime type name from a name which might
+		// be C# specific type name.
+		//
+		private Type FindDocumentedType (string identifier, DeclSpace ds)
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
+			return ds.FindType (this.Location, identifier);
+		}
+
+		//
+		// Returns a MemberInfo that is referenced in XML documentation
+		// (by "see" or "seealso" elements).
+		//
+		private MemberInfo FindDocumentedMember (Type type, string memberName, Type [] paramList, DeclSpace ds, out int warningType, string cref)
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
+					Report.Warning (1020, 1, Location, "Overloadable {0} operator is expected", paramList.Length == 2 ? "binary" : "unary");
+					Report.Warning (1584, 1, Location, "XML comment on '{0}' has syntactically incorrect attribute '{1}'", GetSignatureForError (), cref);
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
+				Type returnType = FindDocumentedType (returnTypeName, ds);
+				if (returnType == null || returnType != expected) {
+					warningType = 1581;
+					Report.Warning (1581, 1, Location, "Invalid return type in XML comment cref attribute '{0}'", cref);
+					return null;
+				}
+			}
+			return mis [0];
+		}
+
+		private Type [] emptyParamList = new Type [0];
+
+		//
+		// Processes "see" or "seealso" elements.
+		// Checks cref attribute.
+		//
+		private void HandleXrefCommon (DeclSpace ds, string name, XmlElement xref)
+		{
+			string cref = xref.GetAttribute ("cref").Trim (wsChars);
+			// when, XmlReader, "if (cref == null)"
+			if (!xref.HasAttribute ("cref"))
+				return;
+			if (cref.Length == 0)
+				Report.Warning (1001, 1, Location, "Identifier expected");
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
+					Report.Warning (1584, 1, Location, "XML comment on '{0}' has syntactically incorrect attribute '{1}'", GetSignatureForError (), cref);
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
+					Type paramType = FindDocumentedType (paramTypeName, ds);
+					if (paramType == null) {
+						Report.Warning (1580, 1, Location, "Invalid type for parameter '{0}' in XML comment cref attribute '{1}'", i + 1, cref);
+						return;
+					}
+					plist.Add (paramType);
+				}
+				parameterTypes = plist.ToArray (typeof (Type)) as Type [];
+			}
+
+			Type type = FindDocumentedType (identifier, ds);
+			if (type != null) {
+				xref.SetAttribute ("cref", "T:" + type.FullName.Replace ("+", "."));
+				return; // a type
+			}
+
+			int period = identifier.LastIndexOf ('.');
+			if (period > 0) {
+				string typeName = identifier.Substring (0, period);
+				string memberName = identifier.Substring (period + 1);
+				type = FindDocumentedType (typeName, ds);
+				int warnResult;
+				if (type != null) {
+					MemberInfo mi = FindDocumentedMember (type, memberName, parameterTypes, ds, out warnResult, cref);
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
+				MemberInfo mi = FindDocumentedMember (ds.TypeBuilder, identifier, parameterTypes, ds, out warnResult, cref);
+				if (warnResult > 0)
+					return;
+				if (mi != null) {
+					xref.SetAttribute ("cref", GetMemberDocHead (mi.MemberType) + ds.TypeBuilder.FullName.Replace ("+", ".") + "." + identifier);
+					return; // local member name
+				}
+			}
+
+			Report.Warning (1574, 1, Location, "XML comment on '{0}' has cref attribute '{1}' that could not be resolved in '{2}'.", GetSignatureForError (), cref, ds.GetSignatureForError ());
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
 	}
 
 	/// <summary>
@@ -1325,7 +1800,7 @@
 			IDictionaryEnumerator it = parent.member_hash.GetEnumerator ();
 			while (it.MoveNext ()) {
 				hash [it.Key] = ((ArrayList) it.Value).Clone ();
-                        }
+			 }
                                 
 			return hash;
 		}
Index: delegate.cs
===================================================================
--- delegate.cs	(revision 36616)
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
--- cs-parser.jay	(revision 36616)
+++ cs-parser.jay	(working copy)
@@ -81,6 +81,14 @@
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
@@ -284,7 +292,13 @@
 	
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
@@ -304,7 +318,15 @@
 
 using_directive
 	: using_alias_directive
+	{
+		if (RootContext.NeedDocument)
+			Lexer.doc_state = XmlCommentState.Allowed;
+	}
 	| using_namespace_directive
+	{
+		if (RootContext.NeedDocument)
+			Lexer.doc_state = XmlCommentState.Allowed;
+	}
 	;
 
 using_alias_directive
@@ -375,6 +397,10 @@
 
 namespace_body
 	: OPEN_BRACE
+	  {
+		if (RootContext.NeedDocument)
+			Lexer.doc_state = XmlCommentState.Allowed;
+	  }
 	  opt_using_directives
 	  opt_namespace_member_declarations
 	  CLOSE_BRACE
@@ -491,6 +517,13 @@
 			} else {
 				$$ = new Attributes (sect);
 			}
+			if ($$ == null) {
+				if (RootContext.NeedDocument) {
+					Lexer.check_incorrect_doc_comment ();
+					Lexer.doc_state =
+						XmlCommentState.Allowed;
+				}
+			}
 		} else {
 			$$ = new Attributes (sect);
 		}		
@@ -746,9 +779,16 @@
 		if ($7 != null)
 			current_class.Bases = (ArrayList) $7;
 
+		if (RootContext.NeedDocument)
+			current_class.DocComment = Lexer.consume_doc_comment ();
+
 		current_class.Register ();
 	  }
 	  struct_body
+	  {
+		if (RootContext.NeedDocument)
+			Lexer.doc_state = XmlCommentState.Allowed;
+	  }
 	  opt_semicolon
 	  {
 		$$ = current_class;
@@ -762,7 +802,12 @@
 	;
 
 struct_body
-	: OPEN_BRACE opt_struct_member_declarations CLOSE_BRACE
+	: OPEN_BRACE
+	  {
+		if (RootContext.NeedDocument)
+			Lexer.doc_state = XmlCommentState.Allowed;
+	  }
+	  opt_struct_member_declarations CLOSE_BRACE
 	;
 
 opt_struct_member_declarations
@@ -814,6 +859,10 @@
 				(Expression) constant.expression_or_array_initializer, modflags, 
 				(Attributes) $1, l);
 
+			if (RootContext.NeedDocument) {
+				c.DocComment = Lexer.consume_doc_comment ();
+				Lexer.doc_state = XmlCommentState.Allowed;
+			}
 			current_container.AddConstant (c);
 		}
 	  }
@@ -866,6 +915,10 @@
 						 var.expression_or_array_initializer, 
 						 (Attributes) $1, l);
 
+			if (RootContext.NeedDocument) {
+				field.DocComment = Lexer.consume_doc_comment ();
+				Lexer.doc_state = XmlCommentState.Allowed;
+			}
 			current_container.AddField (field);
 		}
 	  }
@@ -927,6 +980,8 @@
 method_declaration
 	: method_header {
 		iterator_container = (IIteratorContainer) $1;
+		if (RootContext.NeedDocument)
+			Lexer.doc_state = XmlCommentState.NotAllowed;
 	  }
 	  method_body
 	  {
@@ -953,6 +1008,9 @@
 
 		current_local_parameters = null;
 		iterator_container = null;
+
+		if (RootContext.NeedDocument)
+			Lexer.doc_state = XmlCommentState.Allowed;
 	  }
 	;
 
@@ -989,6 +1047,9 @@
 
 		current_local_parameters = (Parameters) $6;
 
+		if (RootContext.NeedDocument)
+			method.DocComment = Lexer.consume_doc_comment ();
+
 		$$ = method;
 	  }
 	| opt_attributes
@@ -1003,6 +1064,10 @@
 					    (Attributes) $1, lexer.Location);
 
 		current_local_parameters = (Parameters) $6;
+
+		if (RootContext.NeedDocument)
+			method.DocComment = Lexer.consume_doc_comment ();
+
 		$$ = method;
 	  }
 	| opt_attributes
@@ -1020,6 +1085,10 @@
 					    lexer.Location);
 
 		current_local_parameters = (Parameters) $7;
+
+		if (RootContext.NeedDocument)
+			method.DocComment = Lexer.consume_doc_comment ();
+
 		$$ = method;
 	  }
 	;
@@ -1163,7 +1232,12 @@
 property_declaration
 	: opt_attributes
 	  opt_modifiers
-	  type namespace_or_type_name
+	  type
+	  namespace_or_type_name
+	  {
+		if (RootContext.NeedDocument)
+			tmpComment = Lexer.consume_doc_comment ();
+	  }
 	  OPEN_BRACE 
 	  {
 		implicit_value_parameter_type = (Expression) $3;
@@ -1181,11 +1255,11 @@
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
@@ -1196,6 +1270,10 @@
 		current_container.AddProperty (prop);
 		implicit_value_parameter_type = null;
 		iterator_container = null;
+
+		if (RootContext.NeedDocument)
+			prop.DocComment = ConsumeStoredComment ();
+
 	  }
 	;
 
@@ -1236,6 +1314,10 @@
 		$$ = new Accessor ((ToplevelBlock) $5, (int) $2, (Attributes) $1, lexer.Location);
 		current_local_parameters = null;
 		lexer.PropertyParsing = true;
+
+		if (RootContext.NeedDocument)
+			if (Lexer.doc_state == XmlCommentState.Error)
+				Lexer.doc_state = XmlCommentState.NotAllowed;
 	  }
 	;
 
@@ -1273,6 +1355,10 @@
 		$$ = new Accessor ((ToplevelBlock) $5, (int) $2, (Attributes) $1, lexer.Location);
 		current_local_parameters = null;
 		lexer.PropertyParsing = true;
+
+		if (RootContext.NeedDocument)
+			if (Lexer.doc_state == XmlCommentState.Error)
+				Lexer.doc_state = XmlCommentState.NotAllowed;
 	  }
 	;
 
@@ -1310,6 +1396,11 @@
 	  {
 		current_class.Bases = (ArrayList) $7;
 
+		if (RootContext.NeedDocument) {
+			current_class.DocComment = Lexer.consume_doc_comment ();
+			Lexer.doc_state = XmlCommentState.Allowed;
+		}
+
 		current_class.Register ();
 	  }
 	  interface_body 
@@ -1470,6 +1561,8 @@
 				  new MemberName (TypeContainer.DefaultIndexerName),
 				  (int) $2, true, (Parameters) $6, (Attributes) $1,
 				  info.Get, info.Set, lexer.Location);
+		if (RootContext.NeedDocument)
+			((Indexer) $$).DocComment = ConsumeStoredComment ();
 	  }
 	;
 
@@ -1493,6 +1586,9 @@
 			new Parameters (param_list, null, decl.location),
 			(ToplevelBlock) $5, (Attributes) $1, decl.location);
 
+		if (RootContext.NeedDocument)
+			op.DocComment = ConsumeStoredComment ();
+
 		if (SimpleIteratorContainer.Simple.Yields)
 			op.SetYields ();
 
@@ -1522,12 +1618,18 @@
 			op = Operator.OpType.UnaryNegation;
 
 		Parameter [] pars = new Parameter [1];
+		Expression type = (Expression) $5;
 
-		pars [0] = new Parameter ((Expression) $5, (string) $6, Parameter.Modifier.NONE, null);
+		pars [0] = new Parameter (type, (string) $6, Parameter.Modifier.NONE, null);
 
 		current_local_parameters = new Parameters (pars, null, lexer.Location);
 
-		$$ = new OperatorDeclaration (op, (Expression) $1, (Expression) $5, (string) $6,
+		if (RootContext.NeedDocument) {
+			tmpComment = Lexer.consume_doc_comment ();
+			Lexer.doc_state = XmlCommentState.Allowed;
+		}
+
+		$$ = new OperatorDeclaration (op, (Expression) $1, type, (string) $6,
 					      null, null, lexer.Location);
 	}
 	| type OPERATOR overloadable_operator
@@ -1536,18 +1638,26 @@
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
+		if (RootContext.NeedDocument) {
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
@@ -1624,6 +1734,9 @@
 		c.OptAttributes = (Attributes) $1;
 		c.ModFlags = (int) $2;
 	
+		if (RootContext.NeedDocument)
+			c.DocComment = ConsumeStoredComment ();
+
 		if (c.Name == current_container.Basename){
 			if ((c.ModFlags & Modifiers.STATIC) != 0){
 				if ((c.ModFlags & Modifiers.Accessibility) != 0){
@@ -1657,22 +1770,30 @@
 		current_container.AddConstructor (c);
 
 		current_local_parameters = null;
+		if (RootContext.NeedDocument)
+			Lexer.doc_state = XmlCommentState.Allowed;
 	  }
 	;
 
 constructor_declarator
-	: IDENTIFIER 
+	: IDENTIFIER
+	  {
+		if (RootContext.NeedDocument) {
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
 
@@ -1708,9 +1829,16 @@
         ;
         
 destructor_declaration
-	: opt_attributes opt_finalizer TILDE IDENTIFIER OPEN_PARENS CLOSE_PARENS block
+	: opt_attributes opt_finalizer TILDE 
 	  {
-		if ((string) $4 != current_container.Basename){
+		if (RootContext.NeedDocument) {
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
@@ -1734,8 +1862,10 @@
 			Method d = new Destructor (
 				current_class, TypeManager.system_void_expr, m, "Finalize", 
 				new Parameters (null, null, l), (Attributes) $1, l);
+			if (RootContext.NeedDocument)
+				d.DocComment = ConsumeStoredComment ();
 		  
-			d.Block = (ToplevelBlock) $7;
+			d.Block = (ToplevelBlock) $8;
 			current_container.AddMethod (d);
 		}
 	  }
@@ -1756,7 +1886,11 @@
 				lexer.Location);
 
 			current_container.AddEvent (e);
-				       
+
+			if (RootContext.NeedDocument) {
+				e.DocComment = Lexer.consume_doc_comment ();
+				Lexer.doc_state = XmlCommentState.Allowed;
+			}
 		}
 	  }
 	| opt_attributes
@@ -1788,7 +1922,11 @@
 				current_class, (Expression) $4, (int) $2, false, name, null,
 				(Attributes) $1, (Accessor) pair.First, (Accessor) pair.Second,
 				loc);
-			
+			if (RootContext.NeedDocument) {
+				e.DocComment = Lexer.consume_doc_comment ();
+				Lexer.doc_state = XmlCommentState.Allowed;
+			}
+
 			current_container.AddEvent (e);
 			implicit_value_parameter_type = null;
 		}
@@ -1800,6 +1938,9 @@
 			Report.Error (71, lexer.Location, "Explicit implementation of events requires property syntax");
 		else 
 			Report.Error (71, lexer.Location, "Event declaration should use property syntax");
+
+		if (RootContext.NeedDocument)
+			Lexer.doc_state = XmlCommentState.Allowed;
 	  }
 	;
 
@@ -1910,6 +2051,8 @@
 		indexer = new Indexer (current_class, decl.type, name,
 				       (int) $2, false, decl.param_list, (Attributes) $1,
 				       get_block, set_block, loc);
+		if (RootContext.NeedDocument)
+			indexer.DocComment = ConsumeStoredComment ();
 
 		current_container.AddIndexer (indexer);
 		
@@ -1929,6 +2072,10 @@
 		} else if (pars.FixedParameters == null && pars.ArrayParameter == null){
 			Report.Error (1551, lexer.Location, "Indexers must have at least one parameter");
 		}
+		if (RootContext.NeedDocument) {
+			tmpComment = Lexer.consume_doc_comment ();
+			Lexer.doc_state = XmlCommentState.Allowed;
+		}
 
 		$$ = new IndexerDeclaration ((Expression) $1, null, pars);
 	  }
@@ -1942,8 +2089,14 @@
 		} else if (pars.FixedParameters == null && pars.ArrayParameter == null){
 			Report.Error (1551, lexer.Location, "Indexers must have at least one parameter");
 		}
+
 		MemberName name = (MemberName) $2;
 		$$ = new IndexerDeclaration ((Expression) $1, name, pars);
+
+		if (RootContext.NeedDocument) {
+			tmpComment = Lexer.consume_doc_comment ();
+			Lexer.doc_state = XmlCommentState.Allowed;
+		}
 	  }
 	;
 
@@ -1951,7 +2104,10 @@
 	: opt_attributes
 	  opt_modifiers
 	  ENUM IDENTIFIER 
-	  opt_enum_base
+	  opt_enum_base {
+		if (RootContext.NeedDocument)
+			enumTypeComment = Lexer.consume_doc_comment ();
+	  }
 	  enum_body
 	  opt_semicolon
 	  { 
@@ -1961,10 +2117,14 @@
 		Enum e = new Enum (current_namespace, current_container, (Expression) $5, (int) $2,
 				   full_name, (Attributes) $1, enum_location);
 		
-		foreach (VariableDeclaration ev in (ArrayList) $6) {
+		if (RootContext.NeedDocument)
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
@@ -1980,10 +2140,21 @@
 	;
 
 enum_body
-	: OPEN_BRACE opt_enum_member_declarations CLOSE_BRACE
+	: OPEN_BRACE
 	  {
-		$$ = $2;
+		if (RootContext.NeedDocument)
+			Lexer.doc_state = XmlCommentState.Allowed;
 	  }
+	  opt_enum_member_declarations
+	  {
+	  	// here will be evaluated after CLOSE_BLACE is consumed.
+		if (RootContext.NeedDocument)
+			Lexer.doc_state = XmlCommentState.Allowed;
+	  }
+	  CLOSE_BRACE
+	  {
+		$$ = $3;
+	  }
 	;
 
 opt_enum_member_declarations
@@ -2012,15 +2183,31 @@
 enum_member_declaration
 	: opt_attributes IDENTIFIER 
 	  {
-		$$ = new VariableDeclaration ((string) $2, null, lexer.Location, (Attributes) $1);
+		VariableDeclaration vd = new VariableDeclaration ((string) $2, null, lexer.Location, (Attributes) $1);
+
+		if (RootContext.NeedDocument) {
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
+		if (RootContext.NeedDocument) {
+			tmpComment = Lexer.consume_doc_comment ();
+			Lexer.doc_state = XmlCommentState.NotAllowed;
+		}
 	  }
           ASSIGN expression
 	  { 
-		$$ = new VariableDeclaration ((string) $2, $5, lexer.Location, (Attributes) $1);
+		VariableDeclaration vd = new VariableDeclaration ((string) $2, $5, lexer.Location, (Attributes) $1);
+
+		if (RootContext.NeedDocument)
+			vd.DocComment = ConsumeStoredComment ();
+
+		$$ = vd;
 	  }
 	;
 
@@ -2036,6 +2223,11 @@
 		Delegate del = new Delegate (current_namespace, current_container, (Expression) $4,
 					     (int) $2, name, (Parameters) $7, (Attributes) $1, l);
 
+		if (RootContext.NeedDocument) {
+			del.DocComment = Lexer.consume_doc_comment ();
+			Lexer.doc_state = XmlCommentState.Allowed;
+		}
+
 		current_container.AddDelegate (del);
 		RootContext.Tree.RecordDecl (name.GetName (true), del);
 	  }	
@@ -2052,6 +2244,11 @@
 			TypeManager.system_void_expr, (int) $2, name,
 			(Parameters) $7, (Attributes) $1, l);
 
+		if (RootContext.NeedDocument) {
+			del.DocComment = Lexer.consume_doc_comment ();
+			Lexer.doc_state = XmlCommentState.Allowed;
+		}
+
 		current_container.AddDelegate (del);
 		RootContext.Tree.RecordDecl (name.GetName (true), del);
 	  }
@@ -3055,9 +3252,18 @@
 			current_class.Bases = (ArrayList) $7;
 		}
 
+		if (RootContext.NeedDocument) {
+			current_class.DocComment = Lexer.consume_doc_comment ();
+			Lexer.doc_state = XmlCommentState.Allowed;
+		}
+
 		current_class.Register ();
 	  }
-	  class_body 
+	  class_body
+	  {
+		if (RootContext.NeedDocument)
+			Lexer.doc_state = XmlCommentState.Allowed;
+	  }
 	  opt_semicolon 
 	  {
 		$$ = current_class;
@@ -4138,6 +4344,7 @@
 	public object expression_or_array_initializer;
 	public Location Location;
 	public Attributes OptAttributes;
+	public string DocComment;
 
 	public VariableDeclaration (string id, object eoai, Location l, Attributes opt_attrs)
 	{
@@ -4482,5 +4689,13 @@
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
--- ChangeLog	(revision 36616)
+++ ChangeLog	(working copy)
@@ -1,3 +1,35 @@
+2004-11-26  Atsushi Enomoto  <atsushi@ximian.com>
+
+	all things are for /doc support:
+
+	* driver.cs:
+	  Handle /doc command line option.
+	  Report error 2006 instead of 5 for missing file name for /doc.
+	  Added call to RootContext.GenerateDocComment() after type resolution.
+	* cs-tokenizer.cs:
+	  Added support for picking up documentation (/// and /** ... */),
+	  including a new XmlCommentState enumeration.
+	* cs-parser.jay:
+	  Added lines to fill Documentation element for field, constant,
+	  property, indexer, method, constructor, destructor, operator, event
+	  and class, struct, interface, delegate, enum.
+	  Added lines to warn incorrect comment.
+	* rootcontext.cs :
+	  Added NeedDocument, XmlCommentOutput and XmlDocumentation (values
+	  are passed only when /doc was specified).
+	  Added StoredDocuments() to cache <include>d xml comment documents.
+	  Added static GenerateDocComment().
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
 2004-11-25  Ben Maurer  <bmaurer@ximian.com>
 
 	* rootcontext.cs (LookupType): Make sure to cache lookups that
Index: driver.cs
===================================================================
--- driver.cs	(revision 36616)
+++ driver.cs	(working copy)
@@ -17,6 +17,7 @@
 	using System.IO;
 	using System.Text;
 	using System.Globalization;
+	using System.Xml;
 	using System.Diagnostics;
 
 	public enum Target {
@@ -98,6 +99,11 @@
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
@@ -220,6 +226,7 @@
 				"   -nostdlib[+|-]     Does not load core libraries\n" +
 				"   -nowarn:W1[,W2]    Disables one or more warnings\n" + 
 				"   -out:FNAME         Specifies output file\n" +
+				"   -doc:XMLFILE         Generates xml documentation into specified file\n" +
 				"   -pkg:P1[,Pn]       References packages P1..Pn\n" + 
 				"   --expect-error X   Expect that error X will be encountered\n" +
 				"   -recurse:SPEC      Recursively compiles the files in SPEC ([dir]/file)\n" + 
@@ -1101,10 +1108,11 @@
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
@@ -1536,6 +1544,7 @@
 			if (timestamps)
 				ShowTime ("Resolving tree");
 			RootContext.ResolveTree ();
+
 			if (Report.Errors > 0)
 				return false;
 			if (timestamps)
@@ -1546,6 +1555,35 @@
 			RootContext.PopulateTypes ();
 			RootContext.DefineTypes ();
 			
+			if (RootContext.NeedDocument) {
+				XmlTextWriter w = null;
+				try {
+					w = new XmlTextWriter (xml_documentation_file, null);
+					w.Indentation = 4;
+					w.Formatting = Formatting.Indented;
+					w.WriteStartDocument ();
+					w.WriteStartElement ("doc");
+					w.WriteStartElement ("assembly");
+					w.WriteStartElement ("name");
+					w.WriteString (Path.ChangeExtension (output_file, null));
+					w.WriteEndElement (); // name
+					w.WriteEndElement (); // assembly
+					w.WriteStartElement ("members");
+					RootContext.XmlCommentOutput = w;
+					RootContext.GenerateDocComment ();
+					w.WriteFullEndElement (); // members
+					w.WriteEndElement ();
+					w.WriteWhitespace (Environment.NewLine);
+					w.WriteEndDocument ();
+				} catch (Exception ex) {
+					Report.Error (1569, "Error generating XML documentation file '{0}' ('{1}')", xml_documentation_file, ex.Message);
+					return false;
+				} finally {
+					if (w != null)
+						w.Close ();
+				}
+			}
+
 			TypeManager.InitCodeHelpers ();
 
 			//
@@ -1735,7 +1773,6 @@
 #endif
 			return (Report.Errors == 0);
 		}
-
 	}
 
 	//
Index: enum.cs
===================================================================
--- enum.cs	(revision 36616)
+++ enum.cs	(working copy)
@@ -14,6 +14,7 @@
 using System.Reflection;
 using System.Reflection.Emit;
 using System.Globalization;
+using System.Xml;
 
 namespace Mono.CSharp {
 
@@ -100,6 +101,10 @@
 		protected override void VerifyObsoleteAttribute()
 		{
 		}
+
+		public override string DocCommentHeader {
+			get { return "F:"; }
+		}
 	}
 
 	/// <summary>
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
 
@@ -784,5 +790,25 @@
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
+			base.GenerateDocComment (ds);
+			foreach (string name in ordered_enums) {
+				MemberCore mc = GetDefinition (name);
+				mc.GenerateDocComment (this);
+			}
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