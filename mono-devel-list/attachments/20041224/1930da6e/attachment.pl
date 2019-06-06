Index: report.cs
===================================================================
--- report.cs	(revision 38021)
+++ report.cs	(working copy)
@@ -115,7 +115,7 @@
 					Print (code, "", text);
 					return;
 				}
-				Print (code, String.Format ("{0}({1})", location.Name, location.Row), text);
+				Print (code, String.Format ("{0}({1},{2})", location.Name, location.Row, location.Column), text);
 			}
 		}
 
@@ -267,7 +267,7 @@
 		
 		static public void LocationOfPreviousError (Location loc)
 		{
-			Console.Error.WriteLine (String.Format ("{0}({1}) (Location of symbol related to previous error)", loc.Name, loc.Row));
+			Console.Error.WriteLine (String.Format ("{0}({1},{2}) (Location of symbol related to previous error)", loc.Name, loc.Row, loc.Column));
 		}    
         
 		static public void RuntimeMissingSupport (Location loc, string feature) 
@@ -281,7 +281,7 @@
 		/// </summary>
 		static public void SymbolRelatedToPreviousError (Location loc, string symbol)
 		{
-			SymbolRelatedToPreviousError (String.Format ("{0}({1})", loc.Name, loc.Row), symbol);
+			SymbolRelatedToPreviousError (String.Format ("{0}({1},{2})", loc.Name, loc.Row, loc.Column), symbol);
 		}
 
 		static public void SymbolRelatedToPreviousError (MemberInfo mi)
@@ -323,7 +323,7 @@
 
 		public static void ExtraInformation (Location loc, string msg)
 		{
-			extra_information.Add (String.Format ("{0}({1}) {2}", loc.Name, loc.Row, msg));
+			extra_information.Add (String.Format ("{0}({1},{2}) {3}", loc.Name, loc.Row, loc.Column, msg));
 		}
 
 		public static WarningRegions RegisterWarningRegion (Location location)
Index: cs-tokenizer.cs
===================================================================
--- cs-tokenizer.cs	(revision 38021)
+++ cs-tokenizer.cs	(working copy)
@@ -32,15 +32,19 @@
 	public class Tokenizer : yyParser.yyInput
 	{
 		SeekableStreamReader reader;
-		public SourceFile ref_name;
-		public SourceFile file_name;
-		public int ref_line = 1;
-		public int line = 1;
-		public int col = 1;
-		public int current_token;
+		SourceFile ref_name;
+		SourceFile file_name;
+		int ref_line = 1;
+		int line = 1;
+		int col = 0;
+		int previous_col;
+		int current_token;
 		bool handle_get_set = false;
 		bool handle_remove_add = false;
 		bool handle_assembly = false;
+		Location currentLocation;
+		bool dontProgressLocation;
+		Location currentCommentLocation = Location.Null;
 
 		//
 		// XML documentation buffer. The save point is used to divide
@@ -150,7 +154,7 @@
 			set {
 				if (value == XmlCommentState.Allowed) {
 					check_incorrect_doc_comment ();
-					consume_doc_comment ();
+					reset_doc_comment ();
 				}
 				xmlDocState = value;
 			}
@@ -357,9 +361,7 @@
 		}
 
 		public Location Location {
-			get {
-				return new Location (ref_line);
-			}
+			get { return currentLocation; }
 		}
 
 		void define (string def)
@@ -453,8 +455,10 @@
 
 				// Save current position and parse next token.
 				int old = reader.Position;
+				dontProgressLocation = true;
 				int new_token = token ();
 				reader.Position = old;
+				dontProgressLocation = false;
 				putback_char = -1;
 
 				if (new_token == Token.OPEN_PARENS)
@@ -1051,13 +1055,24 @@
 
 		int getChar ()
 		{
-			if (putback_char != -1){
-				int x = putback_char;
+			int x;
+			if (putback_char != -1) {
+				x = putback_char;
 				putback_char = -1;
-
-				return x;
 			}
-			return reader.Read ();
+			else
+				x = reader.Read ();
+			if (!dontProgressLocation) {
+				if (x == '\n') {
+					line++;
+					ref_line++;
+					previous_col = col;
+					col = 0;
+				}
+				else
+					col++;
+			}
+			return x;
 		}
 
 		int peekChar ()
@@ -1084,6 +1099,16 @@
 				Console.WriteLine ("Current [{0}] putting back [{1}]  ", putback_char, c);
 				throw new Exception ("This should not happen putback on putback");
 			}
+			if (!dontProgressLocation) {
+				if (c == '\n' || col == 0) {
+					// It won't happen though.
+					line--;
+					ref_line--;
+					col = previous_col;
+				}
+				else
+					col--;
+			}
 			putback_char = c;
 		}
 
@@ -1182,22 +1207,16 @@
 			cmd = static_cmd_arg.ToString ();
 
 			if (c == '\n'){
-				line++;
-				ref_line++;
 				return;
-			} else if (c == '\r')
-				col = 0;
+			}
 
 			// skip over white space
 			while ((c = getChar ()) != -1 && (c != '\n') && ((c == '\r') || (c == ' ') || (c == '\t')))
 				;
 
 			if (c == '\n'){
-				line++;
-				ref_line++;
 				return;
 			} else if (c == '\r'){
-				col = 0;
 				return;
 			}
 			
@@ -1208,11 +1227,6 @@
 				static_cmd_arg.Append ((char) c);
 			}
 
-			if (c == '\n'){
-				line++;
-				ref_line++;
-			} else if (c == '\r')
-				col = 0;
 			arg = static_cmd_arg.ToString ().Trim ();
 		}
 
@@ -1757,11 +1771,7 @@
 				if (c == '\n'){
 					if (!quoted)
 						Report.Error (1010, Location, "Newline in constant");
-					line++;
-					ref_line++;
-					col = 0;
-				} else
-					col++;
+				}
 
 				if (!quoted){
 					c = escape (c);
@@ -1791,6 +1801,7 @@
 			if (res == Token.PARTIAL) {
 				// Save current position and parse next token.
 				int old = reader.Position;
+				dontProgressLocation = true;
 				int old_putback = putback_char;
 
 				putback_char = -1;
@@ -1801,12 +1812,13 @@
 					(next_token == Token.INTERFACE);
 
 				reader.Position = old;
+				dontProgressLocation = false;
 				putback_char = old_putback;
 
 				if (ok)
 					return res;
 				else {
-					val = "partial";
+					val = new LocatedToken (Location, "partial");
 					return Token.IDENTIFIER;
 				}
 			}
@@ -1821,7 +1833,9 @@
 			
 			id_builder [0] = (char) s;
 
-			while ((c = reader.Read ()) != -1) {
+			currentLocation = new Location (ref_line, Col);
+
+			while ((c = getChar ()) != -1) {
 				if (is_identifier_part_character ((char) c)){
 					if (pos == max_id_size){
 						Report.Error (645, Location, "Identifier too long (limit is 512 chars)");
@@ -1829,10 +1843,10 @@
 					}
 					
 					id_builder [pos++] = (char) c;
-					putback_char = -1;
-					col++;
+//					putback_char = -1;
 				} else {
-					putback_char = c;
+//					putback_char = c;
+					putback (c);
 					break;
 				}
 			}
@@ -1843,8 +1857,10 @@
 			//
 			if (!quoted && (s >= 'a' || s == '_')){
 				int keyword = GetKeyword (id_builder, pos);
-				if (keyword != -1)
+				if (keyword != -1) {
+					val = Location;
 					return keyword;
+				}
 			}
 
 			//
@@ -1855,6 +1871,7 @@
 			if (identifiers [pos] != null) {
 				val = identifiers [pos][id_builder];
 				if (val != null) {
+					val = new LocatedToken (Location, (string) val);
 					return Token.IDENTIFIER;
 				}
 			}
@@ -1868,6 +1885,7 @@
 
 			identifiers [pos] [chars] = val;
 
+			val = new LocatedToken (Location, (string) val);
 			return Token.IDENTIFIER;
 		}
 		
@@ -1879,12 +1897,11 @@
 
 			val = null;
 			// optimization: eliminate col and implement #directive semantic correctly.
-			for (;(c = getChar ()) != -1; col++) {
+			for (;(c = getChar ()) != -1;) {
 				if (c == ' ')
 					continue;
 				
 				if (c == '\t') {
-					col = (((col + 8) / 8) * 8) - 1;
 					continue;
 				}
 				
@@ -1895,9 +1912,6 @@
 					if (peekChar () == '\n')
 						getChar ();
 
-					line++;
-					ref_line++;
-					col = 0;
 					any_token_seen |= tokens_seen;
 					tokens_seen = false;
 					continue;
@@ -1913,6 +1927,7 @@
 							getChar ();
 							// Don't allow ////.
 							if ((d = peekChar ()) != '/') {
+								update_comment_location ();
 								if (doc_state == XmlCommentState.Allowed)
 									handle_one_line_xml_comment ();
 								else if (doc_state == XmlCommentState.NotAllowed)
@@ -1920,11 +1935,7 @@
 							}
 						}
 						while ((d = getChar ()) != -1 && (d != '\n') && d != '\r')
-							col++;
 						if (d == '\n'){
-							line++;
-							ref_line++;
-							col = 0;
 						}
 						any_token_seen |= tokens_seen;
 						tokens_seen = false;
@@ -1934,13 +1945,15 @@
 						bool docAppend = false;
 						if (RootContext.Documentation != null && peekChar () == '*') {
 							getChar ();
+							update_comment_location ();
 							// But when it is /**/, just do nothing.
 							if (peekChar () == '/') {
 								getChar ();
 								continue;
 							}
-							if (doc_state == XmlCommentState.Allowed)
+							if (doc_state == XmlCommentState.Allowed) {
 								docAppend = true;
+							}
 							else if (doc_state == XmlCommentState.NotAllowed)
 								warn_incorrect_doc_comment ();
 						}
@@ -1954,16 +1967,12 @@
 						while ((d = getChar ()) != -1){
 							if (d == '*' && peekChar () == '/'){
 								getChar ();
-								col++;
 								break;
 							}
 							if (docAppend)
 								xml_comment_buffer.Append ((char) d);
 							
 							if (d == '\n'){
-								line++;
-								ref_line++;
-								col = 0;
 								any_token_seen |= tokens_seen;
 								tokens_seen = false;
 							}
@@ -1982,20 +1991,17 @@
 				}
 
 			is_punct_label:
+				currentLocation = new Location (ref_line, Col);
 				if ((t = is_punct ((char)c, ref doread)) != Token.ERROR){
 					tokens_seen = true;
 					if (doread){
 						getChar ();
-						col++;
 					}
 					return t;
 				}
 
 				// white space
 				if (c == '\n'){
-					line++;
-					ref_line++;
-					col = 0;
 					any_token_seen |= tokens_seen;
 					tokens_seen = false;
 					continue;
@@ -2025,17 +2031,12 @@
 					cont = handle_preprocessing_directive (cont);
 
 					if (cont){
-						col = 0;
 						continue;
 					}
-					col = 1;
 
 					bool skipping = false;
-					for (;(c = getChar ()) != -1; col++){
+					for (;(c = getChar ()) != -1;){
 						if (c == '\n'){
-							col = 0;
-							line++;
-							ref_line++;
 							skipping = false;
 						} else if (c == ' ' || c == '\t' || c == '\v' || c == '\r' || c == 0xa0)
 							continue;
@@ -2075,14 +2076,11 @@
 
 						// Try to recover, read until newline or next "'"
 						while ((c = getChar ()) != -1){
-							if (c == '\n' || c == '\''){
-								line++;
-								ref_line++;
-								col = 0;
+							if (c == '\n'){
 								break;
-							} else
-								col++;
-							
+							}
+							else if (c == '\'')
+								break;
 						}
 						return Token.ERROR;
 					}
@@ -2127,7 +2125,6 @@
 			while ((c = peekChar ()) == ' ')
 				getChar (); // skip heading whitespaces.
 			while ((c = peekChar ()) != -1 && c != '\n' && c != '\r') {
-				col++;
 				xml_comment_buffer.Append ((char) getChar ());
 			}
 			if (c == '\r' || c == '\n')
@@ -2168,6 +2165,18 @@
 		}
 
 		//
+		// Updates current comment location.
+		//
+		private void update_comment_location ()
+		{
+			if (Location.IsNull (currentCommentLocation)) {
+				// "-2" is for heading "//" or "/*"
+				currentCommentLocation =
+					new Location (ref_line, col - 2);
+			}
+		}
+
+		//
 		// Checks if there was incorrect doc comments and raise
 		// warnings.
 		//
@@ -2183,10 +2192,13 @@
 		//
 		private void warn_incorrect_doc_comment ()
 		{
-			doc_state = XmlCommentState.Error;
-			// in csc, it is 'XML comment is not placed on a valid 
-			// language element'. But that does not make sense.
-			Report.Warning (1587, 2, Location, "XML comment is placed on an invalid language element which can not accept it.");
+			if (doc_state != XmlCommentState.Error) {
+				doc_state = XmlCommentState.Error;
+				// in csc, it is 'XML comment is not placed on 
+				// a valid language element'. But that does not
+				// make sense.
+				Report.Warning (1587, 2, currentCommentLocation, "XML comment is placed on an invalid language element which can not accept it.");
+			}
 		}
 
 		//
@@ -2197,12 +2209,18 @@
 		{
 			if (xml_comment_buffer.Length > 0) {
 				string ret = xml_comment_buffer.ToString ();
-				xml_comment_buffer.Length = 0;
+				reset_doc_comment ();
 				return ret;
 			}
 			return null;
 		}
 
+		void reset_doc_comment ()
+		{
+			xml_comment_buffer.Length = 0;
+			currentCommentLocation = Location.Null;
+		}
+
 		public void cleanup ()
 		{
 			if (ifstack != null && ifstack.Count >= 1) {
Index: class.cs
===================================================================
--- class.cs	(revision 38021)
+++ class.cs	(working copy)
@@ -3402,7 +3402,7 @@
 			this.builder = builder;
 			
 			CodeGen.SymbolWriter.OpenMethod (
-				file, this, start.Row, 0, end.Row, 0);
+				file, this, start.Row, start.Column, end.Row, start.Column);
 		}
 
 		public string Name {
Index: decl.cs
===================================================================
--- decl.cs	(revision 38021)
+++ decl.cs	(working copy)
@@ -29,25 +29,42 @@
 	public class MemberName {
 		public string Name;
 		public readonly MemberName Left;
+		public readonly Location Location;
 
 		public static readonly MemberName Null = new MemberName ("");
 
 		public MemberName (string name)
+			: this (name, Location.Null)
 		{
-			this.Name = name;
 		}
 
 		public MemberName (MemberName left, string name)
-			: this (name)
+			: this (left, name, left.Location)
 		{
-			this.Left = left;
 		}
 
 		public MemberName (MemberName left, MemberName right)
-			: this (left, right.Name)
+			: this (left, right.Name, left.Location)
 		{
 		}
 
+		public MemberName (string name, Location loc)
+		{
+			this.Name = name;
+			this.Location = loc;
+		}
+
+		public MemberName (MemberName left, string name, Location loc)
+			: this (name, loc)
+		{
+			this.Left = left;
+		}
+
+		public MemberName (MemberName left, MemberName right, Location loc)
+			: this (left, right.Name, loc)
+		{
+		}
+
 		public string GetName ()
 		{
 			return GetName (false);
@@ -96,9 +113,9 @@
 		public MemberName Clone ()
 		{
 			if (Left != null)
-				return new MemberName (Left.Clone (), Name);
+				return new MemberName (Left.Clone (), Name, Location);
 			else
-				return new MemberName (Name);
+				return new MemberName (Name, Location);
 		}
 
 		public string Basename {
Index: location.cs
===================================================================
--- location.cs	(revision 38021)
+++ location.cs	(working copy)
@@ -57,7 +57,7 @@
 	///   in 8 bits (and say, map anything after char 255 to be `255+').
 	/// </remarks>
 	public struct Location {
-		public int token; 
+		int token;
 
 		static ArrayList source_list;
 		static Hashtable source_files;
@@ -65,6 +65,8 @@
 		static int source_mask;
 		static int source_count;
 		static int current_source;
+		static int column_bits;
+		static int column_max;
 
 		public readonly static Location Null;
 		
@@ -121,6 +123,13 @@
 		{
 			source_bits = log2 (source_list.Count) + 2;
 			source_mask = (1 << source_bits) - 1;
+
+			column_bits = 16 - source_bits;
+			column_max = (1 << column_bits) - 1;
+			if (column_bits < 0) {
+				column_bits = 0;
+				column_max = 0;
+			}
 		}
 
 		// <remarks>
@@ -162,16 +171,28 @@
 		}
 		
 		public Location (int row)
+			: this (row, 0)
 		{
+		}
+
+		public Location (int row, int column)
+		{
 			if (row < 0)
 				token = 0;
-			else
-				token = current_source + (row << source_bits);
+			else {
+				if (column > column_max)
+					column = column_max;
+				token = current_source + (((row << column_bits) + column) << source_bits);
+			}
 		}
 
 		public override string ToString ()
 		{
-			return Name + ": (" + Row + ")";
+			if (column_bits == 0)
+				return Name + ": (" + Row + ")";
+			else
+				return Name + ": (" + Row + ", " + Column +
+					(Column == column_max ? "+)" : ")");
 		}
 		
 		/// <summary>
@@ -184,7 +205,7 @@
 
 		public string Name {
 			get {
-				int index = token & source_mask;
+				int index = (int) (token & source_mask);
 				if ((token == 0) || (index == 0))
 					return "Internal";
 
@@ -198,13 +219,21 @@
 				if (token == 0)
 					return 1;
 
-				return token >> source_bits;
+				return (int) (token >> source_bits >> column_bits);
 			}
 		}
 
+		public int Column {
+			get {
+				if (token == 0 || column_max == 0)
+					return 1;
+				return (int) ((token >> source_bits) & column_max);
+			}
+		}
+
 		public int File {
 			get {
-				return token & source_mask;
+				return (int) (token & source_mask);
 			}
 		}
 
@@ -222,11 +251,32 @@
 		// If we don't have a symbol writer, this property is always null.
 		public SourceFile SourceFile {
 			get {
-				int index = token & source_mask;
+				int index = (int) (token & source_mask);
 				if (index == 0)
 					return null;
 				return (SourceFile) source_list [index - 1];
 			}
 		}
 	}
+
+	public class LocatedToken
+	{
+		public readonly Location Location;
+		readonly object Value;
+
+		public LocatedToken (Location loc, string value)
+		{
+			Location = loc;
+			Value = value;
+		}
+
+		public string StringValue {
+			get { return Value != null ? Value.ToString () : null; }
+		}
+
+		public override string ToString ()
+		{
+			return Location.ToString () + Value;
+		}
+	}
 }
Index: cs-parser.jay
===================================================================
--- cs-parser.jay	(revision 38021)
+++ cs-parser.jay	(working copy)
@@ -334,7 +334,8 @@
 	: USING IDENTIFIER ASSIGN 
 	  namespace_or_type_name SEMICOLON
 	  {
-		current_namespace.UsingAlias ((string) $2, (MemberName) $4, lexer.Location);
+		LocatedToken lt = (LocatedToken) $2;
+		current_namespace.UsingAlias (lt.StringValue, (MemberName) $4, lt.Location);
 	  }
 	| USING error {
 		CheckIdentifierToken (yyToken);
@@ -344,7 +345,7 @@
 using_namespace_directive
 	: USING namespace_name SEMICOLON 
 	  {
-		current_namespace.Using ((string) $2, lexer.Location);
+		current_namespace.Using ((string) $2, (Location) $1);
           }
 	;
 
@@ -356,21 +357,21 @@
 namespace_declaration
 	: opt_attributes NAMESPACE namespace_or_type_name
 	{
+		MemberName name = (MemberName) $3;
+
 		if ($1 != null) {
-			Report.Error(1518, Lexer.Location, "Attributes cannot be applied to namespaces."
+			Report.Error(1518, name.Location, "Attributes cannot be applied to namespaces."
 					+ " Expected class, delegate, enum, interface, or struct");
 		}
 
-		MemberName name = (MemberName) $3;
-
 		if ((current_namespace.Parent != null) && (name.Left != null)) {
-			Report.Error (134, lexer.Location,
+			Report.Error (134, name.Location,
 				      "Cannot use qualified namespace names in nested " +
 				      "namespace declarations");
 		}
 
 		current_namespace = new NamespaceEntry (
-			current_namespace, file, name.GetName (), lexer.Location);
+			current_namespace, file, name.GetName (), name.Location);
 	  } 
 	  namespace_body opt_semicolon
 	  { 
@@ -443,7 +444,7 @@
 
 		if ((mod_flags & (Modifiers.PRIVATE|Modifiers.PROTECTED)) != 0){
 			Report.Error (
-				1527, lexer.Location, 
+				1527, ((MemberCore) $1).Location, 
 				"Namespace elements cant be explicitly " +
 			        "declared private or protected in `" + name + "'");
 		}
@@ -454,10 +455,10 @@
 	  }
 
 	| field_declaration {
-		Report.Error (116, lexer.Location, "A namespace can only contain types and namespace declarations");
+		Report.Error (116, ((MemberCore) $1).Location, "A namespace can only contain types and namespace declarations");
 	  }
 	| method_declaration {
-		Report.Error (116, lexer.Location, "A namespace can only contain types and namespace declarations");
+		Report.Error (116, ((MemberCore) $1).Location, "A namespace can only contain types and namespace declarations");
 	  }
 	;
 
@@ -581,8 +582,9 @@
 attribute_target
 	: IDENTIFIER
 	  {
-		CheckAttributeTarget ((string) $1);
-		$$ = $1;
+		LocatedToken lt = (LocatedToken) $1;
+		CheckAttributeTarget (lt.StringValue);
+		$$ = lt.StringValue; // Location won't be required anymore.
 	  }
         | EVENT  { $$ = "event"; }	  
         | RETURN { $$ = "return"; }
@@ -607,20 +609,17 @@
 	;
 
 attribute
-	: attribute_name
+	: attribute_name opt_attribute_arguments
 	  {
-		$$ = lexer.Location;
-	  }
-	  opt_attribute_arguments
-	  {
 		MemberName mname = (MemberName) $1;
 		string name = mname.GetName ();
 		if (current_attr_target == "assembly" || current_attr_target == "module")
-			$$ = new GlobalAttribute (current_container, current_attr_target,
-						  name, (ArrayList) $3, (Location) $2);
+			$$ = new GlobalAttribute (current_container,
+				current_attr_target, name, (ArrayList) $2,
+				mname.Location);
 		else
-			$$ = new Attribute (current_attr_target, name, (ArrayList) $3,
-					    (Location) $2);
+			$$ = new Attribute (current_attr_target, name,
+				(ArrayList) $2, mname.Location);
 	  }
 	;
 
@@ -715,8 +714,9 @@
 named_argument
 	: IDENTIFIER ASSIGN expression
 	  {
+		// FIXME: keep location
 		$$ = new DictionaryEntry (
-			(string) $1, 
+			((LocatedToken) $1).StringValue, 
 			new Argument ((Expression) $3, Argument.AType.Expression));
 	  }
 	;
@@ -757,19 +757,18 @@
 	  STRUCT member_name
 	  { 
 		MemberName name = MakeName ((MemberName) $5);
-		bool partial = (bool) $3;
 
-		if (partial) {
+		if ($3 != null) {
 			ClassPart part = PartialContainer.CreatePart (
 				current_namespace, current_container, name, (int) $2,
-				(Attributes) $1, Kind.Struct, lexer.Location);
+				(Attributes) $1, Kind.Struct, (Location) $3);
 
 			current_container = part.PartialContainer;
 			current_class = part;
 		} else {
 			current_class = new Struct (
 				current_namespace, current_container, name, (int) $2,
-				(Attributes) $1, lexer.Location);
+				(Attributes) $1, name.Location);
 
 			current_container = current_class;
 			RootContext.Tree.RecordDecl (name.GetName (true), current_class);
@@ -889,12 +888,13 @@
 constant_declarator
 	: IDENTIFIER ASSIGN constant_expression
 	  {
-		$$ = new VariableDeclaration ((string) $1, $3, lexer.Location);
+		LocatedToken lt = (LocatedToken) $1;
+		$$ = new VariableDeclaration (lt.StringValue, $3, lt.Location);
 	  }
 	| IDENTIFIER
 	  {
 		// A const field requires a value to be provided
-		Report.Error (145, lexer.Location, "A const field requires a value to be provided");
+		Report.Error (145, ((LocatedToken) $1).Location, "A const field requires a value to be provided");
 		$$ = null;
 	  }
 	;
@@ -928,7 +928,7 @@
 	  VOID  
 	  variable_declarators
 	  SEMICOLON {
-		Report.Error (670, lexer.Location, "void type is not allowed for fields");
+		Report.Error (670, (Location) $3, "void type is not allowed for fields");
 	  }
 	;
 
@@ -950,11 +950,13 @@
 variable_declarator
 	: IDENTIFIER ASSIGN variable_initializer
 	  {
-		$$ = new VariableDeclaration ((string) $1, $3, lexer.Location);
+		LocatedToken lt = (LocatedToken) $1;
+		$$ = new VariableDeclaration (lt.StringValue, $3, lt.Location);
 	  }
 	| IDENTIFIER
 	  {
-		$$ = new VariableDeclaration ((string) $1, null, lexer.Location);
+		LocatedToken lt = (LocatedToken) $1;
+		$$ = new VariableDeclaration (lt.StringValue, null, lt.Location);
 	  }
 	;
 
@@ -969,11 +971,11 @@
 	  }
 	| STACKALLOC type OPEN_BRACKET expression CLOSE_BRACKET
 	  {
-		$$ = new StackAlloc ((Expression) $2, (Expression) $4, lexer.Location);
+		$$ = new StackAlloc ((Expression) $2, (Expression) $4, (Location) $1);
 	  }
 	| STACKALLOC type
 	  {
-		Report.Error (1575, lexer.Location, "A stackalloc expression requires [] after type");
+		Report.Error (1575, (Location) $1, "A stackalloc expression requires [] after type");
                 $$ = null;
 	  }
 	;
@@ -993,7 +995,7 @@
 		if (b == null){
 			if ((method.ModFlags & extern_abstract) == 0){
 				Report.Error (
-					501, lexer.Location,  current_container.MakeName (method.Name) +
+					501, method.MemberName.Location,  current_container.MakeName (method.Name) +
 				        "must declare a body because it is not marked abstract or extern");
 			}
 		} else {
@@ -1044,7 +1046,7 @@
 
 		Method method = new Method (current_class, (Expression) $3, (int) $2,
 					    false, name,  (Parameters) $6, (Attributes) $1,
-					    lexer.Location);
+					    name.Location);
 
 		current_local_parameters = (Parameters) $6;
 
@@ -1062,7 +1064,7 @@
 
 		Method method = new Method (current_class, TypeManager.system_void_expr,
 					    (int) $2, false, name, (Parameters) $6,
-					    (Attributes) $1, lexer.Location);
+					    (Attributes) $1, name.Location);
 
 		current_local_parameters = (Parameters) $6;
 
@@ -1076,14 +1078,14 @@
 	  type 
 	  modifiers namespace_or_type_name OPEN_PARENS opt_formal_parameter_list CLOSE_PARENS
 	  {
+		MemberName name = (MemberName) $5;
 		Report.Error (1585, lexer.Location, 
 			String.Format ("Modifier {0} should appear before type", 
 				Modifiers.Name ((int) $4)));
-		MemberName name = (MemberName) $4;
 
 		Method method = new Method (current_class, TypeManager.system_void_expr,
 					    0, false, name, (Parameters) $7, (Attributes) $1,
-					    lexer.Location);
+					    name.Location);
 
 		current_local_parameters = (Parameters) $7;
 
@@ -1139,7 +1141,7 @@
 	  }
 	| ARGLIST COMMA fixed_parameters
 	  {
-		Report.Error (257, lexer.Location, "An __arglist parameter must be the last parameter in a formal parameter list");
+		Report.Error (257, (Location) $1, "An __arglist parameter must be the last parameter in a formal parameter list");
 		$$ = null;
 	  }
 	| parameter_array 
@@ -1148,7 +1150,7 @@
 	  }
 	| ARGLIST
 	  {
-		$$ = new Parameters (null, true, lexer.Location);
+		$$ = new Parameters (null, true, (Location) $1);
 	  }
 	;
 
@@ -1175,7 +1177,8 @@
 	  type
 	  IDENTIFIER
 	  {
-		$$ = new Parameter ((Expression) $3, (string) $4, (Parameter.Modifier) $2, (Attributes) $1);
+		LocatedToken lt = (LocatedToken) $4;
+		$$ = new Parameter ((Expression) $3, lt.StringValue, (Parameter.Modifier) $2, (Attributes) $1);
 	  }
 	| opt_attributes
 	  opt_parameter_modifier
@@ -1216,7 +1219,8 @@
 parameter_array
 	: opt_attributes PARAMS type IDENTIFIER
 	  { 
-		$$ = new Parameter ((Expression) $3, (string) $4, Parameter.Modifier.PARAMS, (Attributes) $1);
+		LocatedToken lt = (LocatedToken) $4;
+		$$ = new Parameter ((Expression) $3, lt.StringValue, Parameter.Modifier.PARAMS, (Attributes) $1);
 		note ("type must be a single-dimension array type"); 
 	  }
 	| opt_attributes PARAMS parameter_modifier type IDENTIFIER 
@@ -1245,8 +1249,6 @@
 
 		lexer.PropertyParsing = true;
 
-		$$ = lexer.Location;
-
 		iterator_container = SimpleIteratorContainer.GetSimple ();
 	  }
 	  accessor_declarations 
@@ -1260,11 +1262,11 @@
 		Accessor get_block = (Accessor) pair.First;
 		Accessor set_block = (Accessor) pair.Second;
 
-		Location loc = (Location) $7;
 		MemberName name = (MemberName) $4;
 
-		prop = new Property (current_class, (Expression) $3, (int) $2, false,
-				     name, (Attributes) $1, get_block, set_block, loc);
+		prop = new Property (current_class, (Expression) $3, (int) $2,
+			false, name, (Attributes) $1, get_block, set_block,
+			name.Location);
 		if (SimpleIteratorContainer.Simple.Yields)
 			prop.SetYields ();
 		
@@ -1312,7 +1314,7 @@
 	  }
           accessor_body
 	  {
-		$$ = new Accessor ((ToplevelBlock) $5, (int) $2, (Attributes) $1, lexer.Location);
+		$$ = new Accessor ((ToplevelBlock) $5, (int) $2, (Attributes) $1, (Location) $3);
 		current_local_parameters = null;
 		lexer.PropertyParsing = true;
 
@@ -1353,7 +1355,7 @@
 	  }
 	  accessor_body
 	  {
-		$$ = new Accessor ((ToplevelBlock) $5, (int) $2, (Attributes) $1, lexer.Location);
+		$$ = new Accessor ((ToplevelBlock) $5, (int) $2, (Attributes) $1, (Location) $3);
 		current_local_parameters = null;
 		lexer.PropertyParsing = true;
 
@@ -1375,19 +1377,18 @@
 	  INTERFACE member_name
 	  {
 		MemberName name = MakeName ((MemberName) $5);
-		bool partial = (bool) $3;
 
-		if (partial) {
+		if ($3 != null) {
 			ClassPart part = PartialContainer.CreatePart (
 				current_namespace, current_container, name, (int) $2,
-				(Attributes) $1, Kind.Interface, lexer.Location);
+				(Attributes) $1, Kind.Interface, (Location) $3);
 
 			current_container = part.PartialContainer;
 			current_class = part;
 		} else {
 			current_class = new Interface (
 				current_namespace, current_container, name, (int) $2,
-				(Attributes) $1, lexer.Location);
+				(Attributes) $1, name.Location);
 
 			current_container = current_class;
 			RootContext.Tree.RecordDecl (name.GetName (true), current_class);
@@ -1494,7 +1495,7 @@
 		MemberName name = (MemberName) $4;
 
 		$$ = new Method (current_class, (Expression) $3, (int) $2, true,
-				 name, (Parameters) $6, (Attributes) $1, lexer.Location);
+				 name, (Parameters) $6, (Attributes) $1, name.Location);
 		if (RootContext.Documentation != null)
 			((Method) $$).DocComment = Lexer.consume_doc_comment ();
 	  }
@@ -1505,7 +1506,7 @@
 		MemberName name = (MemberName) $4;
 
 		$$ = new Method (current_class, TypeManager.system_void_expr, (int) $2,
-				 true, name, (Parameters) $6,  (Attributes) $1, lexer.Location);
+				 true, name, (Parameters) $6,  (Attributes) $1, name.Location);
 		if (RootContext.Documentation != null)
 			((Method) $$).DocComment = Lexer.consume_doc_comment ();
 	  }
@@ -1521,11 +1522,12 @@
 	  { lexer.PropertyParsing = false; }
 	  CLOSE_BRACE
 	  {
+		LocatedToken lt = (LocatedToken) $4;
                 InterfaceAccessorInfo pinfo = (InterfaceAccessorInfo) $7;
 
 		$$ = new Property (current_class, (Expression) $3, (int) $2, true,
-				   new MemberName ((string) $4), (Attributes) $1,
-				   pinfo.Get, pinfo.Set, lexer.Location);
+				   new MemberName (lt.StringValue, lt.Location), (Attributes) $1,
+				   pinfo.Get, pinfo.Set, lt.Location);
 		if (RootContext.Documentation != null)
 			((Property) $$).DocComment = Lexer.consume_doc_comment ();
 	  }
@@ -1539,21 +1541,22 @@
 
 interface_accessors
 	: opt_attributes opt_modifiers GET SEMICOLON	
-	{ $$ = new InterfaceAccessorInfo (true, false, (Attributes) $1, null, (int) $2, 0, lexer.Location, lexer.Location); }
+	{ $$ = new InterfaceAccessorInfo (true, false, (Attributes) $1, null, (int) $2, 0, (Location) $3, Location.Null); }
 	| opt_attributes opt_modifiers SET SEMICOLON		
-	{ $$ = new InterfaceAccessorInfo (false, true, null, (Attributes) $1, 0, (int) $2, lexer.Location, lexer.Location); }
+	{ $$ = new InterfaceAccessorInfo (false, true, null, (Attributes) $1, 0, (int) $2, Location.Null, (Location) $3); }
 	| opt_attributes opt_modifiers GET SEMICOLON opt_attributes opt_modifiers SET SEMICOLON 
-	  { $$ = new InterfaceAccessorInfo (true, true, (Attributes) $1, (Attributes) $5, (int) $2, (int) $6, lexer.Location, lexer.Location); }
+	  { $$ = new InterfaceAccessorInfo (true, true, (Attributes) $1, (Attributes) $5, (int) $2, (int) $6, (Location) $3, (Location) $7); }
 	| opt_attributes opt_modifiers SET SEMICOLON opt_attributes opt_modifiers GET SEMICOLON
-	  { $$ = new InterfaceAccessorInfo (true, true, (Attributes) $5, (Attributes) $1, (int) $6, (int) $2, lexer.Location, lexer.Location); }
+	  { $$ = new InterfaceAccessorInfo (true, true, (Attributes) $5, (Attributes) $1, (int) $6, (int) $2, (Location) $7, (Location) $3); }
 	;
 
 interface_event_declaration
 	: opt_attributes opt_new EVENT type IDENTIFIER SEMICOLON
 	  {
+		LocatedToken lt = (LocatedToken) $5;
 		$$ = new EventField (current_class, (Expression) $4, (int) $2, true,
-				     new MemberName ((string) $5), null,
-				     (Attributes) $1, lexer.Location);
+				     new MemberName (lt.StringValue, lt.Location), null,
+				     (Attributes) $1, lt.Location);
 		if (RootContext.Documentation != null)
 			((EventField) $$).DocComment = Lexer.consume_doc_comment ();
 	  }
@@ -1583,9 +1586,9 @@
 		InterfaceAccessorInfo info = (InterfaceAccessorInfo) $10;
 
 		$$ = new Indexer (current_class, (Expression) $3,
-				  new MemberName (TypeContainer.DefaultIndexerName),
+				  new MemberName (TypeContainer.DefaultIndexerName, (Location) $4),
 				  (int) $2, true, (Parameters) $6, (Attributes) $1,
-				  info.Get, info.Set, lexer.Location);
+				  info.Get, info.Set, (Location) $4);
 		if (RootContext.Documentation != null)
 			((Indexer) $$).DocComment = ConsumeStoredComment ();
 	  }
@@ -1635,6 +1638,7 @@
 	: type OPERATOR overloadable_operator 
 	  OPEN_PARENS type IDENTIFIER CLOSE_PARENS
 	{
+		LocatedToken lt = (LocatedToken) $6;
 		Operator.OpType op = (Operator.OpType) $3;
 		CheckUnaryOperator (op);
 
@@ -1647,17 +1651,17 @@
 		Parameter [] pars = new Parameter [1];
 		Expression type = (Expression) $5;
 
-		pars [0] = new Parameter (type, (string) $6, Parameter.Modifier.NONE, null);
+		pars [0] = new Parameter (type, lt.StringValue, Parameter.Modifier.NONE, null);
 
-		current_local_parameters = new Parameters (pars, null, lexer.Location);
+		current_local_parameters = new Parameters (pars, null, lt.Location);
 
 		if (RootContext.Documentation != null) {
 			tmpComment = Lexer.consume_doc_comment ();
 			Lexer.doc_state = XmlCommentState.NotAllowed;
 		}
 
-		$$ = new OperatorDeclaration (op, (Expression) $1, type, (string) $6,
-					      null, null, lexer.Location);
+		$$ = new OperatorDeclaration (op, (Expression) $1, type, lt.StringValue,
+					      null, null, (Location) $2);
 	}
 	| type OPERATOR overloadable_operator
 	  OPEN_PARENS 
@@ -1665,6 +1669,8 @@
 	  	type IDENTIFIER 
 	  CLOSE_PARENS
         {
+		LocatedToken ltParam1 = (LocatedToken) $6;
+		LocatedToken ltParam2 = (LocatedToken) $9;
 		CheckBinaryOperator ((Operator.OpType) $3);
 
 		Parameter [] pars = new Parameter [2];
@@ -1672,10 +1678,10 @@
 		Expression typeL = (Expression) $5;
 		Expression typeR = (Expression) $8;
 
-	       pars [0] = new Parameter (typeL, (string) $6, Parameter.Modifier.NONE, null);
-	       pars [1] = new Parameter (typeR, (string) $9, Parameter.Modifier.NONE, null);
+	       pars [0] = new Parameter (typeL, ltParam1.StringValue, Parameter.Modifier.NONE, null);
+	       pars [1] = new Parameter (typeR, ltParam2.StringValue, Parameter.Modifier.NONE, null);
 
-	       current_local_parameters = new Parameters (pars, null, lexer.Location);
+	       current_local_parameters = new Parameters (pars, null, ltParam1.Location);
 
 		if (RootContext.Documentation != null) {
 			tmpComment = Lexer.consume_doc_comment ();
@@ -1683,8 +1689,8 @@
 		}
 	       
 	       $$ = new OperatorDeclaration ((Operator.OpType) $3, (Expression) $1, 
-					     typeL, (string) $6,
-					     typeR, (string) $9, lexer.Location);
+					     typeL, ltParam1.StringValue,
+					     typeR, ltParam2.StringValue, (Location) $2);
         }
 	| conversion_operator_declarator
 	;
@@ -1720,25 +1726,27 @@
 conversion_operator_declarator
 	: IMPLICIT OPERATOR type OPEN_PARENS type IDENTIFIER CLOSE_PARENS
 	  {
+		LocatedToken lt = (LocatedToken) $6;
 		Parameter [] pars = new Parameter [1];
 
-		pars [0] = new Parameter ((Expression) $5, (string) $6, Parameter.Modifier.NONE, null);
+		pars [0] = new Parameter ((Expression) $5, lt.StringValue, Parameter.Modifier.NONE, null);
 
-		current_local_parameters = new Parameters (pars, null, lexer.Location);  
+		current_local_parameters = new Parameters (pars, null, lt.Location);  
 		  
 		if (RootContext.Documentation != null) {
 			tmpComment = Lexer.consume_doc_comment ();
 			Lexer.doc_state = XmlCommentState.NotAllowed;
 		}
 
-		$$ = new OperatorDeclaration (Operator.OpType.Implicit, (Expression) $3, (Expression) $5, (string) $6,
-					      null, null, lexer.Location);
+		$$ = new OperatorDeclaration (Operator.OpType.Implicit, (Expression) $3, (Expression) $5, lt.StringValue,
+					      null, null, (Location) $2);
 	  }
 	| EXPLICIT OPERATOR type OPEN_PARENS type IDENTIFIER CLOSE_PARENS
 	  {
+		LocatedToken lt = (LocatedToken) $6;
 		Parameter [] pars = new Parameter [1];
 
-		pars [0] = new Parameter ((Expression) $5, (string) $6, Parameter.Modifier.NONE, null);
+		pars [0] = new Parameter ((Expression) $5, lt.StringValue, Parameter.Modifier.NONE, null);
 
 		current_local_parameters = new Parameters (pars, null, lexer.Location);  
 		  
@@ -1747,8 +1755,8 @@
 			Lexer.doc_state = XmlCommentState.NotAllowed;
 		}
 
-		$$ = new OperatorDeclaration (Operator.OpType.Explicit, (Expression) $3, (Expression) $5, (string) $6,
-					      null, null, lexer.Location);
+		$$ = new OperatorDeclaration (Operator.OpType.Explicit, (Expression) $3, (Expression) $5, lt.StringValue,
+					      null, null, (Location) $2);
 	  }
 	| IMPLICIT error 
 	  {
@@ -1822,15 +1830,13 @@
 	  }
 	  OPEN_PARENS opt_formal_parameter_list CLOSE_PARENS 
 	  {
-		oob_stack.Push (lexer.Location);
-
 		current_local_parameters = (Parameters) $4;
 	  }
 	  opt_constructor_initializer
 	  {
-		Location l = (Location) oob_stack.Pop ();
-		$$ = new Constructor (current_class, (string) $1, 0, (Parameters) $4,
-				      (ConstructorInitializer) $7, l);
+		LocatedToken lt = (LocatedToken) $1;
+		$$ = new Constructor (current_class, lt.StringValue, 0, (Parameters) $4,
+				      (ConstructorInitializer) $7, lt.Location);
 	  }
 	;
 
@@ -1847,11 +1853,11 @@
 constructor_initializer
 	: COLON BASE OPEN_PARENS opt_argument_list CLOSE_PARENS
 	  {
-		$$ = new ConstructorBaseInitializer ((ArrayList) $4, current_local_parameters, lexer.Location);
+		$$ = new ConstructorBaseInitializer ((ArrayList) $4, current_local_parameters, (Location) $2);
 	  }
 	| COLON THIS OPEN_PARENS opt_argument_list CLOSE_PARENS
 	  {
-		$$ = new ConstructorThisInitializer ((ArrayList) $4, current_local_parameters, lexer.Location);
+		$$ = new ConstructorThisInitializer ((ArrayList) $4, current_local_parameters, (Location) $2);
 	  }
 	| COLON error {
 		Report.Error (1018, lexer.Location, "Keyword this or base expected");
@@ -1875,12 +1881,13 @@
 	  }
 	  IDENTIFIER OPEN_PARENS CLOSE_PARENS block
 	  {
-		if ((string) $5 != current_container.Basename){
-			Report.Error (574, lexer.Location, "Name of destructor must match name of class");
+		LocatedToken lt = (LocatedToken) $5;
+		if (lt.StringValue != current_container.Basename){
+			Report.Error (574, lt.Location, "Name of destructor must match name of class");
 		} else if (!(current_container is Class)){
-			Report.Error (575, lexer.Location, "Destructors are only allowed in class types");
+			Report.Error (575, lt.Location, "Destructors are only allowed in class types");
 		} else {
-			Location l = lexer.Location;
+			Location l = lt.Location;
 
 			int m = (int) $2;
 			if (!RootContext.StdLib && current_container.Name == "System.Object")
@@ -1915,12 +1922,13 @@
 	  {
 		foreach (VariableDeclaration var in (ArrayList) $5) {
 
-			MemberName name = new MemberName (var.identifier);
+			MemberName name = new MemberName (var.identifier,
+				var.Location);
 
 			Event e = new EventField (
 				current_class, (Expression) $4, (int) $2, false, name,
 				var.expression_or_array_initializer, (Attributes) $1,
-				lexer.Location);
+				name.Location);
 
 			current_container.AddEvent (e);
 
@@ -1937,7 +1945,6 @@
 	  {
 		implicit_value_parameter_type = (Expression) $4;  
 		lexer.EventParsing = true;
-		oob_stack.Push (lexer.Location);
 	  }
 	  event_accessor_declarations
 	  {
@@ -1945,8 +1952,6 @@
 	  }
 	  CLOSE_BRACE
 	  {
-		Location loc = (Location) oob_stack.Pop ();
-
 		if ($8 == null){
 			Report.Error (65, lexer.Location, "Event must have both add and remove accesors");
 			$$ = null;
@@ -1954,6 +1959,7 @@
 			Pair pair = (Pair) $8;
 			
 			MemberName name = (MemberName) $5;
+			Location loc = name.Location;
 
 			Event e = new EventProperty (
 				current_class, (Expression) $4, (int) $2, false, name, null,
@@ -1972,9 +1978,9 @@
 		MemberName mn = (MemberName) $5;
 
 		if (mn.Left != null)
-			Report.Error (71, lexer.Location, "Explicit implementation of events requires property syntax");
+			Report.Error (71, mn.Location, "Explicit implementation of events requires property syntax");
 		else 
-			Report.Error (71, lexer.Location, "Event declaration should use property syntax");
+			Report.Error (71, mn.Location, "Event declaration should use property syntax");
 
 		if (RootContext.Documentation != null)
 			Lexer.doc_state = XmlCommentState.Allowed;
@@ -2015,7 +2021,7 @@
 	  }
           block
 	  {
-		$$ = new Accessor ((ToplevelBlock) $4, 0, (Attributes) $1, lexer.Location);
+		$$ = new Accessor ((ToplevelBlock) $4, 0, (Attributes) $1, (Location) $2);
 		lexer.EventParsing = true;
 	  }
 	| opt_attributes ADD error {
@@ -2039,7 +2045,7 @@
 	  }
           block
 	  {
-		$$ = new Accessor ((ToplevelBlock) $4, 0, (Attributes) $1, lexer.Location);
+		$$ = new Accessor ((ToplevelBlock) $4, 0, (Attributes) $1, (Location) $2);
 		lexer.EventParsing = true;
 	  }
 	| opt_attributes REMOVE error {
@@ -2060,7 +2066,6 @@
 		parsing_indexer  = true;
 		
 		indexer_parameters = decl.param_list;
-		oob_stack.Push (lexer.Location);
 	  }
           accessor_declarations 
 	  {
@@ -2071,7 +2076,6 @@
 	  { 
 		// The signature is computed from the signature of the indexer.  Look
 	 	// at section 3.6 on the spec
-		Location loc = (Location) oob_stack.Pop ();
 		Indexer indexer;
 		IndexerDeclaration decl = (IndexerDeclaration) $3;
 		Pair pair = (Pair) $6;
@@ -2081,13 +2085,13 @@
 		MemberName name;
 		if (decl.interface_type != null)
 			name = new MemberName (decl.interface_type,
-					       TypeContainer.DefaultIndexerName);
+					       TypeContainer.DefaultIndexerName, decl.location);
 		else
-			name = new MemberName (TypeContainer.DefaultIndexerName);
+			name = new MemberName (TypeContainer.DefaultIndexerName, decl.location);
 
 		indexer = new Indexer (current_class, decl.type, name,
 				       (int) $2, false, decl.param_list, (Attributes) $1,
-				       get_block, set_block, loc);
+				       get_block, set_block, name.Location);
 		if (RootContext.Documentation != null)
 			indexer.DocComment = ConsumeStoredComment ();
 
@@ -2114,7 +2118,7 @@
 			Lexer.doc_state = XmlCommentState.Allowed;
 		}
 
-		$$ = new IndexerDeclaration ((Expression) $1, null, pars);
+		$$ = new IndexerDeclaration ((Expression) $1, null, pars, (Location) $2);
 	  }
 	| type namespace_or_type_name DOT THIS OPEN_BRACKET opt_formal_parameter_list CLOSE_BRACKET
 	  {
@@ -2128,7 +2132,7 @@
 		}
 
 		MemberName name = (MemberName) $2;
-		$$ = new IndexerDeclaration ((Expression) $1, name, pars);
+		$$ = new IndexerDeclaration ((Expression) $1, name, pars, (Location) $4);
 
 		if (RootContext.Documentation != null) {
 			tmpComment = Lexer.consume_doc_comment ();
@@ -2148,11 +2152,11 @@
 	  enum_body
 	  opt_semicolon
 	  { 
-		Location enum_location = lexer.Location;
+		LocatedToken lt = (LocatedToken) $4;
 
-		MemberName full_name = MakeName (new MemberName ((string) $4));
+		MemberName full_name = MakeName (new MemberName (lt.StringValue, lt.Location));
 		Enum e = new Enum (current_namespace, current_container, (Expression) $5, (int) $2,
-				   full_name, (Attributes) $1, enum_location);
+				   full_name, (Attributes) $1, lt.Location);
 		
 		if (RootContext.Documentation != null)
 			e.DocComment = enumTypeComment;
@@ -2220,7 +2224,8 @@
 enum_member_declaration
 	: opt_attributes IDENTIFIER 
 	  {
-		VariableDeclaration vd = new VariableDeclaration ((string) $2, null, lexer.Location, (Attributes) $1);
+		LocatedToken lt = (LocatedToken) $2;
+		VariableDeclaration vd = new VariableDeclaration (lt.StringValue, null, lt.Location, (Attributes) $1);
 
 		if (RootContext.Documentation != null) {
 			vd.DocComment = Lexer.consume_doc_comment ();
@@ -2231,7 +2236,6 @@
 	  }
 	| opt_attributes IDENTIFIER
 	  {
-		$$ = lexer.Location;
 		if (RootContext.Documentation != null) {
 			tmpComment = Lexer.consume_doc_comment ();
 			Lexer.doc_state = XmlCommentState.NotAllowed;
@@ -2239,7 +2243,8 @@
 	  }
           ASSIGN expression
 	  { 
-		VariableDeclaration vd = new VariableDeclaration ((string) $2, $5, lexer.Location, (Attributes) $1);
+		LocatedToken lt = (LocatedToken) $2;
+		VariableDeclaration vd = new VariableDeclaration (lt.StringValue, $5, lt.Location, (Attributes) $1);
 
 		if (RootContext.Documentation != null)
 			vd.DocComment = ConsumeStoredComment ();
@@ -2255,8 +2260,8 @@
 	  OPEN_PARENS opt_formal_parameter_list CLOSE_PARENS 
 	  SEMICOLON
 	  {
-		Location l = lexer.Location;
 		MemberName name = MakeName ((MemberName) $5);
+		Location l = name.Location;
 		Delegate del = new Delegate (current_namespace, current_container, (Expression) $4,
 					     (int) $2, name, (Parameters) $7, (Attributes) $1, l);
 
@@ -2274,8 +2279,8 @@
 	  OPEN_PARENS opt_formal_parameter_list CLOSE_PARENS 
 	  SEMICOLON
 	  {
-		Location l = lexer.Location;
 		MemberName name = MakeName ((MemberName) $5);
+		Location l = name.Location;
 		Delegate del = new Delegate (
 			current_namespace, current_container,
 			TypeManager.system_void_expr, (int) $2, name,
@@ -2294,13 +2299,15 @@
 namespace_or_type_name
 	: member_name
 	| namespace_or_type_name DOT IDENTIFIER {
-		$$ = new MemberName ((MemberName) $1, (string) $3);
+		LocatedToken lt = (LocatedToken) $3;
+		$$ = new MemberName ((MemberName) $1, lt.StringValue, lt.Location);
 	  }
 	;
 
 member_name
 	: IDENTIFIER {
-		$$ = new MemberName ((string) $1);
+		LocatedToken lt = (LocatedToken) $1;
+		$$ = new MemberName (lt.StringValue, lt.Location);
 	  }
 	;
 
@@ -2519,11 +2526,13 @@
 member_access
 	: primary_expression DOT IDENTIFIER
 	  {
-		$$ = new MemberAccess ((Expression) $1, (string) $3, lexer.Location);
+		LocatedToken lt = (LocatedToken) $3;
+		$$ = new MemberAccess ((Expression) $1, lt.StringValue, lt.Location);
 	  }
 	| predefined_type DOT IDENTIFIER
 	  {
-		$$ = new MemberAccess ((Expression) $1, (string) $3, lexer.Location);
+		LocatedToken lt = (LocatedToken) $3;
+		$$ = new MemberAccess ((Expression) $1, lt.StringValue, lt.Location);
 	  }
 	;
 
@@ -2653,21 +2662,22 @@
 this_access
 	: THIS
 	  {
-		$$ = new This (current_block, lexer.Location);
+		$$ = new This (current_block, (Location) $1);
 	  }
 	;
 
 base_access
 	: BASE DOT IDENTIFIER
 	  {
-		$$ = new BaseAccess ((string) $3, lexer.Location);
+		LocatedToken lt = (LocatedToken) $3;
+		$$ = new BaseAccess (lt.StringValue, lt.Location);
 	  }
 	| BASE OPEN_BRACKET expression_list CLOSE_BRACKET
 	  {
-		$$ = new BaseIndexerAccess ((ArrayList) $3, lexer.Location);
+		$$ = new BaseIndexerAccess ((ArrayList) $3, (Location) $1);
 	  }
 	| BASE error {
-		Report.Error (175, lexer.Location, "Use of keyword `base' is not valid in this context");
+		Report.Error (175, (Location) $1, "Use of keyword `base' is not valid in this context");
 		$$ = null;
 	  }
 	;
@@ -2696,7 +2706,7 @@
 object_or_delegate_creation_expression
 	: NEW type OPEN_PARENS opt_argument_list CLOSE_PARENS
 	  {
-		$$ = new New ((Expression) $2, (ArrayList) $4, lexer.Location);
+		$$ = new New ((Expression) $2, (ArrayList) $4, (Location) $1);
 	  }
 	;
 
@@ -2705,11 +2715,11 @@
 	  opt_rank_specifier
 	  opt_array_initializer
 	  {
-		$$ = new ArrayCreation ((Expression) $2, (ArrayList) $4, (string) $6, (ArrayList) $7, lexer.Location);
+		$$ = new ArrayCreation ((Expression) $2, (ArrayList) $4, (string) $6, (ArrayList) $7, (Location) $1);
 	  }
 	| NEW type rank_specifiers array_initializer
 	  {
-		$$ = new ArrayCreation ((Expression) $2, (string) $3, (ArrayList) $4, lexer.Location);
+		$$ = new ArrayCreation ((Expression) $2, (string) $3, (ArrayList) $4, (Location) $1);
 	  }
 	| NEW error
 	  {
@@ -2810,31 +2820,31 @@
 typeof_expression
 	: TYPEOF OPEN_PARENS VOID CLOSE_PARENS
 	  {
-		$$ = new TypeOfVoid (lexer.Location);
+		$$ = new TypeOfVoid ((Location) $1);
 	  }
 	| TYPEOF OPEN_PARENS type CLOSE_PARENS
 	  {
-		$$ = new TypeOf ((Expression) $3, lexer.Location);
+		$$ = new TypeOf ((Expression) $3, (Location) $1);
 	  }
 	;
 
 sizeof_expression
 	: SIZEOF OPEN_PARENS type CLOSE_PARENS { 
-		$$ = new SizeOf ((Expression) $3, lexer.Location);
+		$$ = new SizeOf ((Expression) $3, (Location) $1);
 	  }
 	;
 
 checked_expression
 	: CHECKED OPEN_PARENS expression CLOSE_PARENS
 	  {
-		$$ = new CheckedExpr ((Expression) $3, lexer.Location);
+		$$ = new CheckedExpr ((Expression) $3, (Location) $1);
 	  }
 	;
 
 unchecked_expression
 	: UNCHECKED OPEN_PARENS expression CLOSE_PARENS
 	  {
-		$$ = new UnCheckedExpr ((Expression) $3, lexer.Location);
+		$$ = new UnCheckedExpr ((Expression) $3, (Location) $1);
 	  }
 	;
 
@@ -2842,9 +2852,10 @@
 	: primary_expression OP_PTR IDENTIFIER
 	  {
 		Expression deref;
+		LocatedToken lt = (LocatedToken) $3;
 
-		deref = new Unary (Unary.Operator.Indirection, (Expression) $1, lexer.Location);
-		$$ = new MemberAccess (deref, (string) $3, lexer.Location);
+		deref = new Unary (Unary.Operator.Indirection, (Expression) $1, lt.Location);
+		$$ = new MemberAccess (deref, lt.StringValue, lt.Location);
 	  }
 	;
 
@@ -2856,14 +2867,13 @@
 		// Force the next block to be created as a ToplevelBlock
 		oob_stack.Push (current_block);
 		oob_stack.Push (top_current_block);
-		oob_stack.Push (lexer.Location);
 		current_block = null;
 	  } block {
-		Location loc = (Location) oob_stack.Pop ();
+		Location loc = (Location) $1;
 		top_current_block = (Block) oob_stack.Pop ();
 		current_block = (Block) oob_stack.Pop ();
 		if (RootContext.Version == LanguageVersion.ISO_1){
-			Report.FeatureIsNotStandardized (lexer.Location, "anonymous methods");
+			Report.FeatureIsNotStandardized (loc, "anonymous methods");
 			$$ = null;
 		} else  {
 			ToplevelBlock anon_block = (ToplevelBlock) $4;
@@ -2917,7 +2927,8 @@
 
 anonymous_method_parameter
 	: opt_parameter_modifier type IDENTIFIER {
-		$$ = new Parameter ((Expression) $2, (string) $3, (Parameter.Modifier) $1, null);
+		LocatedToken lt = (LocatedToken) $3;
+		$$ = new Parameter ((Expression) $2, lt.StringValue, (Parameter.Modifier) $1, null);
 	  }
 	| PARAMS type IDENTIFIER {
 		Report.Error (-221, lexer.Location, "params modifier not allowed in anonymous method declaration");
@@ -3078,11 +3089,11 @@
 	  }
 	| relational_expression IS type
 	  {
-		$$ = new Is ((Expression) $1, (Expression) $3, lexer.Location);
+		$$ = new Is ((Expression) $1, (Expression) $3, (Location) $2);
 	  }
 	| relational_expression AS type
 	  {
-		$$ = new As ((Expression) $1, (Expression) $3, lexer.Location);
+		$$ = new As ((Expression) $1, (Expression) $3, (Location) $2);
 	  }
 	;
 
@@ -3253,13 +3264,12 @@
 	  CLASS member_name
 	  {
 		MemberName name = MakeName ((MemberName) $5);
-		bool partial = (bool) $3;
 		int mod_flags = (int) $2;
 
-		if (partial) {
+		if ($3 != null) {
 			ClassPart part = PartialContainer.CreatePart (
 				current_namespace, current_container, name, mod_flags,
-				(Attributes) $1, Kind.Class, lexer.Location);
+				(Attributes) $1, Kind.Class, (Location) $3);
 
 			current_container = part.PartialContainer;
 			current_class = part;
@@ -3267,11 +3277,11 @@
 			if ((mod_flags & Modifiers.STATIC) != 0) {
 				current_class = new StaticClass (
 					current_namespace, current_container, name,
-					mod_flags, (Attributes) $1, lexer.Location);
+					mod_flags, (Attributes) $1, name.Location);
 			} else {
 				current_class = new Class (
 					current_namespace, current_container, name,
-					mod_flags, (Attributes) $1, lexer.Location);
+					mod_flags, (Attributes) $1, name.Location);
 			}
 
 			current_container = current_class;
@@ -3312,9 +3322,9 @@
 
 opt_partial
 	: /* empty */
-	  { $$ = (bool) false; }
+	  { $$ = null; }
 	| PARTIAL
-	  { $$ = (bool) true; }
+	  { $$ = $1; } // location
 	;
 
 opt_modifiers
@@ -3464,9 +3474,10 @@
 labeled_statement
 	: IDENTIFIER COLON 
 	  {
-		LabeledStatement labeled = new LabeledStatement ((string) $1, lexer.Location);
+		LocatedToken lt = (LocatedToken) $1;
+		LabeledStatement labeled = new LabeledStatement (lt.StringValue, lt.Location);
 
-		if (current_block.AddLabel ((string) $1, labeled, lexer.Location))
+		if (current_block.AddLabel (lt.StringValue, labeled, lt.Location))
 			current_block.AddStatement (labeled);
 	  }
 	  statement
@@ -3647,7 +3658,7 @@
 if_statement_open
 	: IF OPEN_PARENS 
 	  {
-	   	oob_stack.Push (lexer.Location);
+	   	oob_stack.Push ((Location) $1);
 	  }
 	;
 
@@ -3677,13 +3688,13 @@
 switch_statement
 	: SWITCH OPEN_PARENS 
 	  { 
-		oob_stack.Push (lexer.Location);
+		$$ = lexer.Location;
 		switch_stack.Push (current_block);
 	  }
 	  expression CLOSE_PARENS 
 	  switch_block
 	  {
-		$$ = new Switch ((Expression) $4, (ArrayList) $6, (Location) oob_stack.Pop ());
+		$$ = new Switch ((Expression) $4, (ArrayList) $6, (Location) $3);
 		current_block = (Block) switch_stack.Pop ();
 	  }
 	;
@@ -3772,17 +3783,13 @@
 	;
 
 while_statement
-	: WHILE OPEN_PARENS 
+	: WHILE OPEN_PARENS boolean_expression CLOSE_PARENS embedded_statement
 	{
-		oob_stack.Push (lexer.Location);
-	}
-	boolean_expression CLOSE_PARENS embedded_statement
-	{
-		Location l = (Location) oob_stack.Pop ();
-		$$ = new While ((Expression) $4, (Statement) $6, l);
+		Location l = (Location) $1;
+		$$ = new While ((Expression) $3, (Statement) $5, l);
 	
-		if (RootContext.WarningLevel >= 4){
-			if ($6 == EmptyStatement.Value)
+		if (RootContext.WarningLevel >= 3){
+			if ($5 == EmptyStatement.Value)
 				Report.Warning (642, lexer.Location, "Possible mistaken empty statement");
 		}
 	}
@@ -3790,14 +3797,11 @@
 
 do_statement
 	: DO embedded_statement 
-	  WHILE OPEN_PARENS {
-		oob_stack.Push (lexer.Location);
-	  }
-	  boolean_expression CLOSE_PARENS SEMICOLON
+	  WHILE OPEN_PARENS boolean_expression CLOSE_PARENS SEMICOLON
 	  {
-		Location l = (Location) oob_stack.Pop ();
+		Location l = (Location) $1;
 
-		$$ = new Do ((Statement) $2, (Expression) $6, l);
+		$$ = new Do ((Statement) $2, (Expression) $5, l);
 	  }
 	;
 
@@ -3846,13 +3850,12 @@
 			
 			$3 = null;
 		} 
-		oob_stack.Push (lexer.Location);
 	  } 
 	  opt_for_condition SEMICOLON
 	  opt_for_iterator CLOSE_PARENS 
 	  embedded_statement
 	  {
-		Location l = (Location) oob_stack.Pop ();
+		Location l = (Location) $1;
 
 		For f = new For ((Statement) $3, (Expression) $6, (Statement) $8, (Statement) $10, l);
 
@@ -3919,23 +3922,23 @@
 	}
 	| FOREACH OPEN_PARENS type IDENTIFIER IN 
 	  {
-		oob_stack.Push (lexer.Location);
+		// FIXME: remove this block and shift token numbers.
 	  }
 	  expression CLOSE_PARENS 
 	  {
+		LocatedToken lt = (LocatedToken) $4;
 		oob_stack.Push (current_block);
 
 		Block foreach_block = new Block (current_block);
 		LocalVariableReference v = null;
-		Location l = lexer.Location;
 		LocalInfo vi;
 
-		vi = foreach_block.AddVariable ((Expression) $3, (string) $4, current_local_parameters, l);
+		vi = foreach_block.AddVariable ((Expression) $3, lt.StringValue, current_local_parameters, lt.Location);
 		if (vi != null) {
 			vi.ReadOnly = true;
 
 			// Get a writable reference to this read-only variable.
-			v = new LocalVariableReference (foreach_block, (string) $4, l, vi, false);
+			v = new LocalVariableReference (foreach_block, lt.StringValue, lt.Location, vi, false);
 		}
 		current_block = foreach_block;
 
@@ -3947,12 +3950,11 @@
 		Block foreach_block = (Block) oob_stack.Pop ();
 		LocalVariableReference v = (LocalVariableReference) oob_stack.Pop ();
 		Block prev_block = (Block) oob_stack.Pop ();
-		Location l = (Location) oob_stack.Pop ();
 
 		current_block = prev_block;
 
 		if (v != null) {
-			Foreach f = new Foreach ((Expression) $3, v, (Expression) $7, (Statement) $10, l);
+			Foreach f = new Foreach ((Expression) $3, v, (Expression) $7, (Statement) $10, (Location) $1);
 			foreach_block.AddStatement (f);
 		}
 
@@ -3972,83 +3974,86 @@
 break_statement
 	: BREAK SEMICOLON
 	  {
-		$$ = new Break (lexer.Location);
+		$$ = new Break ((Location) $1);
 	  }
 	;
 
 continue_statement
 	: CONTINUE SEMICOLON
 	  {
-		$$ = new Continue (lexer.Location);
+		$$ = new Continue ((Location) $1);
 	  }
 	;
 
 goto_statement
 	: GOTO IDENTIFIER SEMICOLON 
 	  {
-		$$ = new Goto (current_block, (string) $2, lexer.Location);
+		LocatedToken lt = (LocatedToken) $2;
+		$$ = new Goto (current_block, lt.StringValue, lt.Location);
 	  }
 	| GOTO CASE constant_expression SEMICOLON
 	  {
-		$$ = new GotoCase ((Expression) $3, lexer.Location);
+		$$ = new GotoCase ((Expression) $3, (Location) $1);
 	  }
 	| GOTO DEFAULT SEMICOLON 
 	  {
-		$$ = new GotoDefault (lexer.Location);
+		$$ = new GotoDefault ((Location) $1);
 	  }
 	; 
 
 return_statement
 	: RETURN opt_expression SEMICOLON
 	  {
-		$$ = new Return ((Expression) $2, lexer.Location);
+		$$ = new Return ((Expression) $2, (Location) $1);
 	  }
 	;
 
 throw_statement
 	: THROW opt_expression SEMICOLON
 	  {
-		$$ = new Throw ((Expression) $2, lexer.Location);
+		$$ = new Throw ((Expression) $2, (Location) $1);
 	  }
 	;
 
 yield_statement 
 	: IDENTIFIER RETURN expression SEMICOLON
 	  {
-		string s = (string) $1;
+		LocatedToken lt = (LocatedToken) $1;
+		string s = lt.StringValue;
 		if (s != "yield"){
-			Report.Error (1003, lexer.Location, "; expected");
+			Report.Error (1003, lt.Location, "; expected");
 			$$ = null;
 		}
 		if (RootContext.Version == LanguageVersion.ISO_1){
-			Report.FeatureIsNotStandardized (lexer.Location, "yield statement");
+			Report.FeatureIsNotStandardized (lt.Location, "yield statement");
 			$$ = null;
 		}
 		if (iterator_container == null){
-			Report.Error (204, lexer.Location, "yield statement can only be used within a method, operator or property");
+			Report.Error (204, lt.Location, "yield statement can only be used within a method, operator or property");
 			$$ = null;
 		} else {
 			iterator_container.SetYields ();
-			$$ = new Yield ((Expression) $3, lexer.Location); 
+			$$ = new Yield ((Expression) $3, lt.Location); 
 		}
 	  }
 	| IDENTIFIER BREAK SEMICOLON
 	  {
-		string s = (string) $1;
+		LocatedToken lt = (LocatedToken) $1;
+		string s = lt.StringValue;
 		if (s != "yield"){
-			Report.Error (1003, lexer.Location, "; expected");
+			Report.Error (1003, lt.Location, "; expected");
 			$$ = null;
 		}
 		if (RootContext.Version == LanguageVersion.ISO_1){
-			Report.FeatureIsNotStandardized (lexer.Location, "yield statement");
+			Report.FeatureIsNotStandardized (lt.Location, "yield statement");
 			$$ = null;
 		}
 		if (iterator_container == null){
-			Report.Error (204, lexer.Location, "yield statement can only be used within a method, operator or property");
+			Report.Error (204, lt.Location, "yield statement can only be used within a method, operator or property");
 			$$ = null;
 		} else {
 			iterator_container.SetYields ();
-			$$ = new YieldBreak (lexer.Location);
+			$$ = new YieldBreak (lt.Location);
 		}
 	  }
 	;
@@ -4139,15 +4144,16 @@
 		if ($2 != null) {
 			DictionaryEntry cc = (DictionaryEntry) $2;
 			type = (Expression) cc.Key;
-			id   = (string) cc.Value;
 
-			if (id != null){
+			if (cc.Value != null){
+				LocatedToken lt = (LocatedToken) cc.Value;
+				id   = lt.StringValue;
 				ArrayList one = new ArrayList (4);
-				Location loc = lexer.Location;
+				Location loc = lt.Location;
 
 				one.Add (new VariableDeclaration (id, null, loc));
 
-				$1 = current_block;
+				$$ = current_block;
 				current_block = new Block (current_block);
 				Block b = declare_local_variables (type, one, loc);
 				current_block = b;
@@ -4160,18 +4166,20 @@
 		if ($2 != null){
 			DictionaryEntry cc = (DictionaryEntry) $2;
 			type = (Expression) cc.Key;
-			id   = (string) cc.Value;
+			if (cc.Value != null) {
+				LocatedToken lt = (LocatedToken) cc.Value;
+				id   = lt.StringValue;
+			}
 
-			if ($1 != null){
+			if ($3 != null){
 				//
 				// FIXME: I can change this for an assignment.
 				//
-				while (current_block != (Block) $1)
+				while (current_block != (Block) $3)
 					current_block = current_block.Parent;
 			}
 		}
 
-
 		$$ = new Catch (type, id , (Block) $4, ((Block) $4).loc);
 	}
         ;
@@ -4221,7 +4229,7 @@
 	  {
 		ArrayList list = (ArrayList) $4;
 		Expression type = (Expression) $3;
-		Location l = lexer.Location;
+		Location l = (Location) $1;
 		int top = list.Count;
 
 		Block assign_block = new Block (current_block);
@@ -4241,11 +4249,10 @@
 			list [i] = p;
 		}
 
-		oob_stack.Push (l);
 	  }
 	  embedded_statement 
 	  {
-		Location l = (Location) oob_stack.Pop ();
+		Location l = (Location) $1;
 
 		Fixed f = new Fixed ((Expression) $3, (ArrayList) $4, (Statement) $7, l);
 
@@ -4280,8 +4287,10 @@
 
 fixed_pointer_declarator
 	: IDENTIFIER ASSIGN expression
-	  {	
-		$$ = new Pair ($1, $3);
+	  {
+		LocatedToken lt = (LocatedToken) $1;
+		// FIXME: keep location
+		$$ = new Pair (lt.StringValue, $3);
 	  }
 	| IDENTIFIER
 	  {
@@ -4297,7 +4306,7 @@
  	  } 
 	  embedded_statement
 	  {
-		$$ = new Lock ((Expression) $3, (Statement) $6, lexer.Location);
+		$$ = new Lock ((Expression) $3, (Statement) $6, (Location) $1);
 	  }
 	;
 
@@ -4307,8 +4316,6 @@
 		Block assign_block = new Block (current_block);
 		current_block = assign_block;
 
-		oob_stack.Push (lexer.Location);
-		
 		if ($3 is DictionaryEntry){
 			DictionaryEntry de = (DictionaryEntry) $3;
 			Location l = lexer.Location;
@@ -4357,7 +4364,7 @@
 	  } 
 	  embedded_statement
 	  {
-		Using u = new Using ($3, (Statement) $6, (Location) oob_stack.Pop ());
+		Using u = new Using ($3, (Statement) $6, (Location) $1);
 		current_block.AddStatement (u);
 		while (current_block.Implicit)
 			current_block = current_block.Parent;
@@ -4427,13 +4434,15 @@
 	public Expression type;
 	public MemberName interface_type;
 	public Parameters param_list;
+	public Location location;
 
 	public IndexerDeclaration (Expression type, MemberName interface_type,
-				   Parameters param_list)
+				   Parameters param_list, Location loc)
 	{
 		this.type = type;
 		this.interface_type = interface_type;
 		this.param_list = param_list;
+		this.location = loc;
 	}
 }
 
@@ -4500,7 +4509,7 @@
 
 	if (current_container.Name == ""){
 		if (ns != "")
-			return new MemberName (new MemberName (ns), class_name);
+			return new MemberName (new MemberName (ns, class_name.Location), class_name);
 		else
 			return class_name;
 	} else {
Index: ChangeLog
===================================================================
--- ChangeLog	(revision 38021)
+++ ChangeLog	(working copy)
@@ -1,3 +1,29 @@
+2004-12-23  Atsushi Enomoto  <atsushi@ximian.com>
+
+	* location.cs :
+	  Now it supports column (within limited bits).
+	  token could be private.
+	  Added LocatedToken class to store Location information in parser.
+	* decl.cs :
+	  Add Location field to MemberName.
+	* cs-parser.jay :
+	  Now lexer.Location is used in very limited areas (in case it could
+	  not acquire Location as yet, or in case it might not make sense).
+	* cs-tokenizer.cs :
+	  - privatify some fields which don't have to be public.
+	  - Now create currentLocation before starting parse tokens
+	    (and don't create location every time).
+	  - Provide currentCommentLocation for precise comment location.
+	  - Simplify line/column count (do them only at getChar().
+	  - Don't premise tab as 8 whitespaces.
+	  - Don't report invalid comment error once it was reported.
+	  - Now it stores Location object as a value of IDENTIFIER and
+	    keywords (many of keywords are now expected to have location).
+	* report.cs : report column number too.
+	* class.cs,
+	  codegen.cs :
+	   : provide column information for SymbolWriter.
+
 2004-12-17  Carlos Cortez <calberto.cortez@gmail.com>
 
 	* driver.cs: Patch to handle a xsp bug that prevents to reference an .exe
Index: codegen.cs
===================================================================
--- codegen.cs	(revision 38021)
+++ codegen.cs	(working copy)
@@ -780,7 +780,7 @@
 			if (check_file && (CurrentFile != loc.File))
 				return;
 
-			CodeGen.SymbolWriter.MarkSequencePoint (ig, loc.Row, 0);
+			CodeGen.SymbolWriter.MarkSequencePoint (ig, loc.Row, loc.Column);
 		}
 
 		public void DefineLocalVariable (string name, LocalBuilder builder)