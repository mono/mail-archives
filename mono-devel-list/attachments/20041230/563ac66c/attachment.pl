Index: report.cs
===================================================================
--- report.cs	(revision 38124)
+++ report.cs	(working copy)
@@ -115,7 +115,7 @@
 					Print (code, "", text);
 					return;
 				}
-				Print (code, String.Format ("{0}({1})", location.Name, location.Row), text);
+				Print (code, location.ToString (), text);
 			}
 		}
 
@@ -267,7 +267,7 @@
 		
 		static public void LocationOfPreviousError (Location loc)
 		{
-			Console.Error.WriteLine (String.Format ("{0}({1}) (Location of symbol related to previous error)", loc.Name, loc.Row));
+			Console.Error.WriteLine (String.Format ("{0} (Location of symbol related to previous error)", loc.ToString ()));
 		}    
         
 		static public void RuntimeMissingSupport (Location loc, string feature) 
@@ -281,7 +281,7 @@
 		/// </summary>
 		static public void SymbolRelatedToPreviousError (Location loc, string symbol)
 		{
-			SymbolRelatedToPreviousError (String.Format ("{0}({1})", loc.Name, loc.Row), symbol);
+			SymbolRelatedToPreviousError (loc.ToString (), symbol);
 		}
 
 		static public void SymbolRelatedToPreviousError (MemberInfo mi)
@@ -323,7 +323,7 @@
 
 		public static void ExtraInformation (Location loc, string msg)
 		{
-			extra_information.Add (String.Format ("{0}({1}) {2}", loc.Name, loc.Row, msg));
+			extra_information.Add (String.Format ("{0} {1}", loc.ToString (), msg));
 		}
 
 		public static WarningRegions RegisterWarningRegion (Location location)
Index: cs-tokenizer.cs
===================================================================
--- cs-tokenizer.cs	(revision 38124)
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
+		Location current_location;
+		bool dont_progress_location;
+		Location current_comment_location = Location.Null;
 
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
+			get { return current_location; }
 		}
 
 		void define (string def)
@@ -453,8 +455,10 @@
 
 				// Save current position and parse next token.
 				int old = reader.Position;
+				dont_progress_location = true;
 				int new_token = token ();
 				reader.Position = old;
+				dont_progress_location = false;
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
+			if (!dont_progress_location) {
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
+			if (!dont_progress_location) {
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
 
@@ -1321,6 +1335,7 @@
 				foreach (int code in codes) {
 					if (code != 0)
 						Report.RegisterWarningRegion (Location).WarningDisable (Location, code);
+Console.WriteLine ("----- disabled " + code + " at " + ref_line + "," + col);
 				}
 				return;
 			}
@@ -1757,11 +1772,7 @@
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
@@ -1791,6 +1802,7 @@
 			if (res == Token.PARTIAL) {
 				// Save current position and parse next token.
 				int old = reader.Position;
+				dont_progress_location = true;
 				int old_putback = putback_char;
 
 				putback_char = -1;
@@ -1801,12 +1813,13 @@
 					(next_token == Token.INTERFACE);
 
 				reader.Position = old;
+				dont_progress_location = false;
 				putback_char = old_putback;
 
 				if (ok)
 					return res;
 				else {
-					val = "partial";
+					val = new LocatedToken (Location, "partial");
 					return Token.IDENTIFIER;
 				}
 			}
@@ -1821,7 +1834,9 @@
 			
 			id_builder [0] = (char) s;
 
-			while ((c = reader.Read ()) != -1) {
+			current_location = new Location (ref_line, Col);
+
+			while ((c = getChar ()) != -1) {
 				if (is_identifier_part_character ((char) c)){
 					if (pos == max_id_size){
 						Report.Error (645, Location, "Identifier too long (limit is 512 chars)");
@@ -1829,10 +1844,8 @@
 					}
 					
 					id_builder [pos++] = (char) c;
-					putback_char = -1;
-					col++;
 				} else {
-					putback_char = c;
+					putback (c);
 					break;
 				}
 			}
@@ -1843,8 +1856,10 @@
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
@@ -1855,6 +1870,7 @@
 			if (identifiers [pos] != null) {
 				val = identifiers [pos][id_builder];
 				if (val != null) {
+					val = new LocatedToken (Location, (string) val);
 					return Token.IDENTIFIER;
 				}
 			}
@@ -1868,6 +1884,7 @@
 
 			identifiers [pos] [chars] = val;
 
+			val = new LocatedToken (Location, (string) val);
 			return Token.IDENTIFIER;
 		}
 		
@@ -1879,12 +1896,11 @@
 
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
 				
@@ -1895,9 +1911,6 @@
 					if (peekChar () == '\n')
 						getChar ();
 
-					line++;
-					ref_line++;
-					col = 0;
 					any_token_seen |= tokens_seen;
 					tokens_seen = false;
 					continue;
@@ -1913,6 +1926,7 @@
 							getChar ();
 							// Don't allow ////.
 							if ((d = peekChar ()) != '/') {
+								update_comment_location ();
 								if (doc_state == XmlCommentState.Allowed)
 									handle_one_line_xml_comment ();
 								else if (doc_state == XmlCommentState.NotAllowed)
@@ -1920,11 +1934,7 @@
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
@@ -1934,13 +1944,15 @@
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
@@ -1954,16 +1966,12 @@
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
@@ -1982,20 +1990,18 @@
 				}
 
 			is_punct_label:
+				current_location = new Location (ref_line, Col);
 				if ((t = is_punct ((char)c, ref doread)) != Token.ERROR){
+					val = Location;
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
@@ -2011,6 +2017,7 @@
 					int peek = peekChar ();
 					if (peek >= '0' && peek <= '9')
 						return is_number (c);
+					val = Location;
 					return Token.DOT;
 				}
 				
@@ -2025,17 +2032,12 @@
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
@@ -2075,14 +2077,11 @@
 
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
@@ -2127,7 +2126,6 @@
 			while ((c = peekChar ()) == ' ')
 				getChar (); // skip heading whitespaces.
 			while ((c = peekChar ()) != -1 && c != '\n' && c != '\r') {
-				col++;
 				xml_comment_buffer.Append ((char) getChar ());
 			}
 			if (c == '\r' || c == '\n')
@@ -2168,6 +2166,18 @@
 		}
 
 		//
+		// Updates current comment location.
+		//
+		private void update_comment_location ()
+		{
+			if (Location.IsNull (current_comment_location)) {
+				// "-2" is for heading "//" or "/*"
+				current_comment_location =
+					new Location (ref_line, col - 2);
+			}
+		}
+
+		//
 		// Checks if there was incorrect doc comments and raise
 		// warnings.
 		//
@@ -2183,10 +2193,13 @@
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
+				Report.Warning (1587, 2, current_comment_location, "XML comment is placed on an invalid language element which can not accept it.");
+			}
 		}
 
 		//
@@ -2197,12 +2210,18 @@
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
+			current_comment_location = Location.Null;
+		}
+
 		public void cleanup ()
 		{
 			if (ifstack != null && ifstack.Count >= 1) {
Index: parameter.cs
===================================================================
--- parameter.cs	(revision 38124)
+++ parameter.cs	(working copy)
@@ -22,10 +22,12 @@
 	public abstract class ParameterBase : Attributable {
 
 		protected ParameterBuilder builder;
+		public readonly Location Location;
 
-		public ParameterBase (Attributes attrs)
+		public ParameterBase (Attributes attrs, Location location)
 			: base (attrs)
 		{
+			this.Location = location;
 		}
 
 		public override void ApplyAttributeBuilder (Attribute a, CustomAttributeBuilder cb)
@@ -57,7 +59,7 @@
 	/// </summary>
 	public class ReturnParameter: ParameterBase {
 		public ReturnParameter (MethodBuilder mb, Location location):
-			base (null)
+			base (null, location)
 		{
 			try {
 				builder = mb.DefineParameter (0, ParameterAttributes.None, "");			
@@ -101,8 +103,8 @@
 	/// of the 'set' method in properties, and the 'add' and 'remove' methods in events.
 	/// </summary>
 	public class ImplicitParameter: ParameterBase {
-		public ImplicitParameter (MethodBuilder mb):
-			base (null)
+		public ImplicitParameter (MethodBuilder mb, Location location):
+			base (null, location)
 		{
 			builder = mb.DefineParameter (1, ParameterAttributes.None, "");			
 		}
@@ -149,8 +151,8 @@
 
 		EmitContext ec;  // because ApplyAtrribute doesn't have ec
 		
-		public Parameter (Expression type, string name, Modifier mod, Attributes attrs)
-			: base (attrs)
+		public Parameter (Expression type, string name, Modifier mod, Attributes attrs, Location location)
+			: base (attrs, location)
 		{
 			Name = name;
 			ModFlags = mod;
@@ -321,22 +323,19 @@
 		public readonly bool HasArglist;
 		string signature;
 		Type [] types;
-		Location loc;
 		
 		static Parameters empty_parameters;
 		
-		public Parameters (Parameter [] fixed_parameters, Parameter array_parameter, Location l)
+		public Parameters (Parameter [] fixed_parameters, Parameter array_parameter)
 		{
 			FixedParameters = fixed_parameters;
 			ArrayParameter  = array_parameter;
-			loc = l;
 		}
 
-		public Parameters (Parameter [] fixed_parameters, bool has_arglist, Location l)
+		public Parameters (Parameter [] fixed_parameters, bool has_arglist)
 		{
 			FixedParameters = fixed_parameters;
 			HasArglist = has_arglist;
-			loc = l;
 		}
 
 		/// <summary>
@@ -346,7 +345,7 @@
 		public static Parameters EmptyReadOnlyParameters {
 			get {
 				if (empty_parameters == null)
-					empty_parameters = new Parameters (null, null, Location.Null);
+					empty_parameters = new Parameters (null, null);
 			
 				return empty_parameters;
 			}
@@ -365,7 +364,7 @@
 				for (int i = 0; i < FixedParameters.Length; i++){
 					Parameter par = FixedParameters [i];
 					
-					signature += par.GetSignature (ec, loc);
+					signature += par.GetSignature (ec, par.Location);
 				}
 			}
 			//
@@ -374,10 +373,10 @@
 			//
 		}
 
-		void Error_DuplicateParameterName (string name)
+		void Error_DuplicateParameterName (string name, Location l)
 		{
 			Report.Error (
-				100, loc, "The parameter name `" + name + "' is a duplicate");
+				100, l, "The parameter name `" + name + "' is a duplicate");
 		}
 		
 		public bool VerifyArgs ()
@@ -396,12 +395,12 @@
 				for (j = i + 1; j < count; j++){
 					if (base_name != FixedParameters [j].Name)
 						continue;
-					Error_DuplicateParameterName (base_name);
+					Error_DuplicateParameterName (base_name, FixedParameters [j].Location);
 					return false;
 				}
 
 				if (base_name == array_par_name){
-					Error_DuplicateParameterName (base_name);
+					Error_DuplicateParameterName (base_name, FixedParameters [j].Location);
 					return false;
 				}
 			}
@@ -480,7 +479,7 @@
 				foreach (Parameter p in FixedParameters){
 					Type t = null;
 					
-					if (p.Resolve (ec, loc))
+					if (p.Resolve (ec, p.Location))
 						t = p.ExternalType ();
 					else
 						failed = true;
@@ -491,7 +490,7 @@
 			}
 			
 			if (extra > 0){
-				if (ArrayParameter.Resolve (ec, loc))
+				if (ArrayParameter.Resolve (ec, ArrayParameter.Location))
 					types [i] = ArrayParameter.ExternalType ();
 				else 
 					failed = true;
Index: ecore.cs
===================================================================
--- ecore.cs	(revision 38124)
+++ ecore.cs	(working copy)
@@ -2455,6 +2455,12 @@
 			this.name = name;
 		}
 
+		public TypeLookupExpression (Type type, Location loc)
+		{
+			this.loc = loc;
+			this.name = type.FullName;
+		}
+
 		public override TypeExpr DoResolveAsTypeStep (EmitContext ec)
 		{
 			if (type == null) {
Index: class.cs
===================================================================
--- class.cs	(revision 38124)
+++ class.cs	(working copy)
@@ -3402,7 +3402,7 @@
 			this.builder = builder;
 			
 			CodeGen.SymbolWriter.OpenMethod (
-				file, this, start.Row, 0, end.Row, 0);
+				file, this, start.Row, start.Column, end.Row, start.Column);
 		}
 
 		public string Name {
@@ -5695,7 +5695,7 @@
 			{
 				if (a.Target == AttributeTargets.Parameter) {
 					if (param_attr == null)
-						param_attr = new ImplicitParameter (method_data.MethodBuilder);
+						param_attr = new ImplicitParameter (method_data.MethodBuilder, Location);
 
 					param_attr.ApplyAttributeBuilder (a, cb);
 					return;
@@ -5707,8 +5707,8 @@
 			protected virtual InternalParameters GetParameterInfo (EmitContext ec)
 			{
 				Parameter [] parms = new Parameter [1];
-				parms [0] = new Parameter (method.Type, "value", Parameter.Modifier.NONE, null);
-				Parameters parameters = new Parameters (parms, null, method.Location);
+				parms [0] = new Parameter (method.Type, "value", Parameter.Modifier.NONE, null, Location);
+				Parameters parameters = new Parameters (parms, null);
 				Type [] types = parameters.GetParameterInfo (ec);
 				return new InternalParameters (types, parameters);
 			}
@@ -6470,7 +6470,7 @@
 			{
 				if (a.Target == AttributeTargets.Parameter) {
 					if (param_attr == null)
-						param_attr = new ImplicitParameter (method_data.MethodBuilder);
+						param_attr = new ImplicitParameter (method_data.MethodBuilder, Location);
 
 					param_attr.ApplyAttributeBuilder (a, cb);
 					return;
@@ -6651,8 +6651,8 @@
 			ec.InUnsafe = InUnsafe;
 
 			Parameter [] parms = new Parameter [1];
-			parms [0] = new Parameter (Type, "value", Parameter.Modifier.NONE, null);
-			Parameters parameters = new Parameters (parms, null, Location);
+			parms [0] = new Parameter (Type, "value", Parameter.Modifier.NONE, null, Location);
+			Parameters parameters = new Parameters (parms, null);
 			Type [] types = parameters.GetParameterInfo (ec);
 			InternalParameters ip = new InternalParameters (types, parameters);
 
@@ -6810,9 +6810,9 @@
 
 				fixed_parms.CopyTo (tmp, 0);
 				tmp [fixed_parms.Length] = new Parameter (
-					method.Type, "value", Parameter.Modifier.NONE, null);
+					method.Type, "value", Parameter.Modifier.NONE, null, Location);
 
-				Parameters set_formal_params = new Parameters (tmp, null, method.Location);
+				Parameters set_formal_params = new Parameters (tmp, null);
 				Type [] types = set_formal_params.GetParameterInfo (ec);
 				
 				return new InternalParameters (types, set_formal_params);
Index: decl.cs
===================================================================
--- decl.cs	(revision 38124)
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
--- location.cs	(revision 38124)
+++ location.cs	(working copy)
@@ -57,14 +57,30 @@
 	///   in 8 bits (and say, map anything after char 255 to be `255+').
 	/// </remarks>
 	public struct Location {
-		public int token; 
+		int token;
 
+		struct Checkpoint {
+			public readonly int LineOffset;
+			public readonly int File;
+
+			public Checkpoint (int file, int line)
+			{
+				File = file;
+				LineOffset = line - (int) (line % (1 << line_delta_bits));
+			}
+		}
+
 		static ArrayList source_list;
 		static Hashtable source_files;
-		static int source_bits;
-		static int source_mask;
+		static int checkpoint_bits;
 		static int source_count;
 		static int current_source;
+		static int line_delta_bits;
+		static int line_delta_mask;
+		static int column_bits;
+		static int column_mask;
+		static Checkpoint [] checkpoints;
+		static int checkpoint_index;
 
 		public readonly static Location Null;
 		
@@ -73,6 +89,7 @@
 			source_files = new Hashtable ();
 			source_list = new ArrayList ();
 			current_source = 0;
+			checkpoints = new Checkpoint [10];
 			Null.token = 0;
 		}
 
@@ -100,17 +117,6 @@
 			}
 		}
 
-		static int log2 (int number)
-		{
-			int bits = 0;
-			while (number > 0) {
-				bits++;
-				number /= 2;
-			}
-
-			return bits;
-		}
-
 		// <summary>
 		//   After adding all source files we want to compile with AddFile(), this method
 		//   must be called to `reserve' an appropriate number of bits in the token for the
@@ -119,8 +125,14 @@
 		// </summary>
 		static public void Initialize ()
 		{
-			source_bits = log2 (source_list.Count) + 2;
-			source_mask = (1 << source_bits) - 1;
+			checkpoints = new Checkpoint [source_list.Count * 2];
+
+			column_bits = 8;
+			column_mask = 0xFF;
+			line_delta_bits = 8;
+			line_delta_mask = 0xFF00;
+			checkpoint_index = -1;
+			checkpoint_bits = 16;
 		}
 
 		// <remarks>
@@ -131,7 +143,7 @@
 			string path = name == "" ? "" : Path.GetFullPath (name);
 
 			if (!source_files.Contains (path)) {
-				if (source_count >= (1 << source_bits))
+				if (source_count >= (1 << checkpoint_bits))
 					return new SourceFile (name, path, 0);
 
 				source_files.Add (path, ++source_count);
@@ -147,6 +159,7 @@
 		static public void Push (SourceFile file)
 		{
 			current_source = file.Index;
+			// File is always pushed before being changed.
 		}
 
 		// <remarks>
@@ -162,16 +175,59 @@
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
+				if (column > column_mask)
+					column = column_mask;
+				int target = -1;
+				int delta = 0;
+				int max = checkpoint_index < 10 ?
+					checkpoint_index : 10;
+				for (int i = 0; i < max; i++) {
+					int offset = checkpoints [checkpoint_index - i].LineOffset;
+					delta = row - offset;
+					if (row > offset &&
+						delta < (1 << line_delta_bits) &&
+						checkpoints [checkpoint_index - i].File == current_source) {
+						target = checkpoint_index - i;
+						break;
+					}
+				}
+				if (target == -1) {
+					AddCheckpoint (current_source, row);
+					target = checkpoint_index;
+				}
+				long l = column +
+					(long) (delta << column_bits) +
+					(long) (target << (line_delta_bits + column_bits));
+				token = (int) l;
+			}
 		}
 
+		static void AddCheckpoint (int file, int row)
+		{
+			if (checkpoints.Length == ++checkpoint_index) {
+				Checkpoint [] tmp = new Checkpoint [checkpoint_index * 2];
+				Array.Copy (checkpoints, tmp, checkpoints.Length);
+				checkpoints = tmp;
+			}
+			checkpoints [checkpoint_index] = new Checkpoint (file, row);
+		}
+
 		public override string ToString ()
 		{
-			return Name + ": (" + Row + ")";
+			if (column_bits == 0)
+				return Name + ": (" + Row + ")";
+			else
+				return Name + ": (" + Row + ", " + Column +
+					(Column == column_mask ? "+)" : ")");
 		}
 		
 		/// <summary>
@@ -184,8 +240,8 @@
 
 		public string Name {
 			get {
-				int index = token & source_mask;
-				if ((token == 0) || (index == 0))
+				int index = File;
+				if (token == 0 || index == 0)
 					return "Internal";
 
 				SourceFile file = (SourceFile) source_list [index - 1];
@@ -193,18 +249,31 @@
 			}
 		}
 
+		int CheckpointIndex {
+			get { return (int) ((token & 0xFFFF0000) >> (line_delta_bits + column_bits)); }
+		}
+
 		public int Row {
 			get {
 				if (token == 0)
 					return 1;
+				return checkpoints [CheckpointIndex].LineOffset + ((token & line_delta_mask) >> column_bits);
+			}
+		}
 
-				return token >> source_bits;
+		public int Column {
+			get {
+				if (token == 0)
+					return 1;
+				return (int) (token & column_mask);
 			}
 		}
 
 		public int File {
 			get {
-				return token & source_mask;
+				if (token == 0)
+					return 0;
+				return checkpoints [CheckpointIndex].File;
 			}
 		}
 
@@ -222,11 +291,36 @@
 		// If we don't have a symbol writer, this property is always null.
 		public SourceFile SourceFile {
 			get {
-				int index = token & source_mask;
+				int index = File;
 				if (index == 0)
 					return null;
 				return (SourceFile) source_list [index - 1];
 			}
 		}
 	}
+
+	public struct LocatedToken
+	{
+		public readonly Location Location;
+		readonly object value;
+
+		public LocatedToken (Location loc, object value)
+		{
+			Location = loc;
+			this.value = value;
+		}
+
+		public string StringValue {
+			get { return value != null ? value.ToString () : null; }
+		}
+
+		public Operator.OpType OpTypeValue {
+			get { return (Operator.OpType) value; }
+		}
+
+		public override string ToString ()
+		{
+			return Location.ToString () + value;
+		}
+	}
 }
Index: delegate.cs
===================================================================
--- delegate.cs	(revision 38124)
+++ delegate.cs	(working copy)
@@ -138,10 +138,10 @@
 			// FIXME: POSSIBLY make these static, as they are always the same
 			Parameter [] fixed_pars = new Parameter [2];
 			fixed_pars [0] = new Parameter (TypeManager.system_object_expr, "object",
-							Parameter.Modifier.NONE, null);
+							Parameter.Modifier.NONE, null, Location);
 			fixed_pars [1] = new Parameter (TypeManager.system_intptr_expr, "method", 
-							Parameter.Modifier.NONE, null);
-			Parameters const_parameters = new Parameters (fixed_pars, null, Location);
+							Parameter.Modifier.NONE, null, Location);
+			Parameters const_parameters = new Parameters (fixed_pars, null);
 			
 			TypeManager.RegisterMethod (
 				ConstructorBuilder,
@@ -297,12 +297,12 @@
 			
 			async_params [params_num] = new Parameter (
 				TypeManager.system_asynccallback_expr, "callback",
-								   Parameter.Modifier.NONE, null);
+								   Parameter.Modifier.NONE, null, Location);
 			async_params [params_num + 1] = new Parameter (
 				TypeManager.system_object_expr, "object",
-								   Parameter.Modifier.NONE, null);
+								   Parameter.Modifier.NONE, null, Location);
 
-			Parameters async_parameters = new Parameters (async_params, null, Location);
+			Parameters async_parameters = new Parameters (async_params, null);
 			async_parameters.ComputeAndDefineParameterTypes (ec);
 
 			TypeManager.RegisterMethod (BeginInvokeBuilder,
@@ -330,7 +330,7 @@
 				}
 			}
 			end_param_types [out_params] = TypeManager.iasyncresult_type;
-			end_params [out_params] = new Parameter (TypeManager.system_iasyncresult_expr, "result", Parameter.Modifier.NONE, null);
+			end_params [out_params] = new Parameter (TypeManager.system_iasyncresult_expr, "result", Parameter.Modifier.NONE, null, Location);
 
 			//
 			// Create method, define parameters, register parameters with type system
@@ -346,7 +346,7 @@
 				EndInvokeBuilder.DefineParameter (i + 1, end_params [i].Attributes, end_params [i].Name);
 			}
 
-			Parameters end_parameters = new Parameters (end_params, null, Location);
+			Parameters end_parameters = new Parameters (end_params, null);
 			end_parameters.ComputeAndDefineParameterTypes (ec);
 
 			TypeManager.RegisterMethod (
Index: iterators.cs
===================================================================
--- iterators.cs	(revision 38124)
+++ iterators.cs	(working copy)
@@ -502,10 +502,10 @@
 			if (!is_static)
 				list.Add (new Parameter (
 					new TypeExpression (container.TypeBuilder, Location),
-					"this", Parameter.Modifier.NONE, null));
+					"this", Parameter.Modifier.NONE, null, Location));
 			list.Add (new Parameter (
 				TypeManager.system_boolean_expr, "initialized",
-				Parameter.Modifier.NONE, null));
+				Parameter.Modifier.NONE, null, Location));
 
 			Parameter[] old_fixed = parameters.Parameters.FixedParameters;
 			if (old_fixed != null)
@@ -515,8 +515,7 @@
 			list.CopyTo (fixed_params);
 
 			ctor_params = new Parameters (
-				fixed_params, parameters.Parameters.ArrayParameter,
-				Location);
+				fixed_params, parameters.Parameters.ArrayParameter);
 
 			Constructor ctor = new Constructor (
 				this, Name, Modifiers.PUBLIC, ctor_params,
Index: cs-parser.jay
===================================================================
--- cs-parser.jay	(revision 38124)
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
@@ -454,10 +455,14 @@
 	  }
 
 	| field_declaration {
-		Report.Error (116, lexer.Location, "A namespace can only contain types and namespace declarations");
+		MemberCore mc = (MemberCore) $1;
+		Location l = mc != null ? mc.Location : lexer.Location;
+		Report.Error (116, l, "A namespace can only contain types and namespace declarations");
 	  }
 	| method_declaration {
-		Report.Error (116, lexer.Location, "A namespace can only contain types and namespace declarations");
+		MemberCore mc = (MemberCore) $1;
+		Location l = mc != null ? mc.Location : lexer.Location;
+		Report.Error (116, l, "A namespace can only contain types and namespace declarations");
 	  }
 	;
 
@@ -581,8 +586,9 @@
 attribute_target
 	: IDENTIFIER
 	  {
-		CheckAttributeTarget ((string) $1);
-		$$ = $1;
+		LocatedToken lt = (LocatedToken) $1;
+		CheckAttributeTarget (lt.StringValue, lt.Location);
+		$$ = lt.StringValue; // Location won't be required anymore.
 	  }
         | EVENT  { $$ = "event"; }	  
         | RETURN { $$ = "return"; }
@@ -607,20 +613,17 @@
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
 
@@ -715,8 +718,9 @@
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
@@ -757,19 +761,18 @@
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
@@ -889,12 +892,13 @@
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
@@ -928,7 +932,7 @@
 	  VOID  
 	  variable_declarators
 	  SEMICOLON {
-		Report.Error (670, lexer.Location, "void type is not allowed for fields");
+		Report.Error (670, (Location) $3, "void type is not allowed for fields");
 	  }
 	;
 
@@ -950,11 +954,13 @@
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
 
@@ -969,11 +975,11 @@
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
@@ -993,13 +999,13 @@
 		if (b == null){
 			if ((method.ModFlags & extern_abstract) == 0){
 				Report.Error (
-					501, lexer.Location,  current_container.MakeName (method.Name) +
+					501, method.MemberName.Location,  current_container.MakeName (method.Name) +
 				        "must declare a body because it is not marked abstract or extern");
 			}
 		} else {
 			if ((method.ModFlags & Modifiers.EXTERN) != 0){
 				Report.Error (
-					179, lexer.Location, current_container.MakeName (method.Name) +
+					179, method.Location, current_container.MakeName (method.Name) +
 					" is declared extern, but has a body");
 			}
 		}
@@ -1044,7 +1050,7 @@
 
 		Method method = new Method (current_class, (Expression) $3, (int) $2,
 					    false, name,  (Parameters) $6, (Attributes) $1,
-					    lexer.Location);
+					    name.Location);
 
 		current_local_parameters = (Parameters) $6;
 
@@ -1060,9 +1066,9 @@
 	  {
 		MemberName name = (MemberName) $4;
 
-		Method method = new Method (current_class, TypeManager.system_void_expr,
+		Method method = new Method (current_class, new TypeLookupExpression (typeof (void), (Location) $3),
 					    (int) $2, false, name, (Parameters) $6,
-					    (Attributes) $1, lexer.Location);
+					    (Attributes) $1, name.Location);
 
 		current_local_parameters = (Parameters) $6;
 
@@ -1076,14 +1082,14 @@
 	  type 
 	  modifiers namespace_or_type_name OPEN_PARENS opt_formal_parameter_list CLOSE_PARENS
 	  {
-		Report.Error (1585, lexer.Location, 
+		MemberName name = (MemberName) $5;
+		Report.Error (1585, name.Location, 
 			String.Format ("Modifier {0} should appear before type", 
 				Modifiers.Name ((int) $4)));
-		MemberName name = (MemberName) $4;
 
-		Method method = new Method (current_class, TypeManager.system_void_expr,
+		Method method = new Method (current_class, new TypeLookupExpression (typeof (void), (Location) name.Location),
 					    0, false, name, (Parameters) $7, (Attributes) $1,
-					    lexer.Location);
+					    name.Location);
 
 		current_local_parameters = (Parameters) $7;
 
@@ -1112,7 +1118,7 @@
 		Parameter [] pars = new Parameter [pars_list.Count];
 		pars_list.CopyTo (pars);
 
-	  	$$ = new Parameters (pars, null, lexer.Location); 
+	  	$$ = new Parameters (pars, null); 
 	  } 
 	| fixed_parameters COMMA parameter_array
 	  {
@@ -1121,7 +1127,7 @@
 		Parameter [] pars = new Parameter [pars_list.Count];
 		pars_list.CopyTo (pars);
 
-		$$ = new Parameters (pars, (Parameter) $3, lexer.Location); 
+		$$ = new Parameters (pars, (Parameter) $3); 
 	  }
 	| fixed_parameters COMMA ARGLIST
 	  {
@@ -1130,25 +1136,25 @@
 		Parameter [] pars = new Parameter [pars_list.Count];
 		pars_list.CopyTo (pars);
 
-		$$ = new Parameters (pars, true, lexer.Location);
+		$$ = new Parameters (pars, true);
 	  }
 	| parameter_array COMMA fixed_parameters
 	  {
-		Report.Error (231, lexer.Location, "A params parameter must be the last parameter in a formal parameter list");
+		Report.Error (231, (Location) $2, "A params parameter must be the last parameter in a formal parameter list");
 		$$ = null;
 	  }
 	| ARGLIST COMMA fixed_parameters
 	  {
-		Report.Error (257, lexer.Location, "An __arglist parameter must be the last parameter in a formal parameter list");
+		Report.Error (257, (Location) $1, "An __arglist parameter must be the last parameter in a formal parameter list");
 		$$ = null;
 	  }
 	| parameter_array 
 	  {
-		$$ = new Parameters (null, (Parameter) $1, lexer.Location);
+		$$ = new Parameters (null, (Parameter) $1);
 	  }
 	| ARGLIST
 	  {
-		$$ = new Parameters (null, true, lexer.Location);
+		$$ = new Parameters (null, true);
 	  }
 	;
 
@@ -1175,7 +1181,9 @@
 	  type
 	  IDENTIFIER
 	  {
-		$$ = new Parameter ((Expression) $3, (string) $4, (Parameter.Modifier) $2, (Attributes) $1);
+		LocatedToken lt = (LocatedToken) $4;
+		Expression type = (Expression) $3;
+		$$ = new Parameter (type, lt.StringValue, (Parameter.Modifier) $2, (Attributes) $1, lt.Location);
 	  }
 	| opt_attributes
 	  opt_parameter_modifier
@@ -1198,7 +1206,7 @@
 	  ASSIGN
 	  constant_expression
 	   {
-		 Report.Error (241, lexer.Location, "Default parameter specifiers are not permitted");
+		 Report.Error (241, ((LocatedToken) $4).Location, "Default parameter specifiers are not permitted");
 		 $$ = null;
 	   }
 	;
@@ -1216,12 +1224,14 @@
 parameter_array
 	: opt_attributes PARAMS type IDENTIFIER
 	  { 
-		$$ = new Parameter ((Expression) $3, (string) $4, Parameter.Modifier.PARAMS, (Attributes) $1);
+		LocatedToken lt = (LocatedToken) $4;
+		Expression type = (Expression) $3;
+		$$ = new Parameter (type, lt.StringValue, Parameter.Modifier.PARAMS, (Attributes) $1, lt.Location);
 		note ("type must be a single-dimension array type"); 
 	  }
 	| opt_attributes PARAMS parameter_modifier type IDENTIFIER 
 	  {
-		Report.Error (1611, lexer.Location, "The params parameter cannot be declared as ref or out");
+		Report.Error (1611, ((LocatedToken) $5).Location, "The params parameter cannot be declared as ref or out");
                 $$ = null;
 	  }
 	| opt_attributes PARAMS type error {
@@ -1245,8 +1255,6 @@
 
 		lexer.PropertyParsing = true;
 
-		$$ = lexer.Location;
-
 		iterator_container = SimpleIteratorContainer.GetSimple ();
 	  }
 	  accessor_declarations 
@@ -1260,11 +1268,11 @@
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
 		
@@ -1312,7 +1320,7 @@
 	  }
           accessor_body
 	  {
-		$$ = new Accessor ((ToplevelBlock) $5, (int) $2, (Attributes) $1, lexer.Location);
+		$$ = new Accessor ((ToplevelBlock) $5, (int) $2, (Attributes) $1, (Location) $3);
 		current_local_parameters = null;
 		lexer.PropertyParsing = true;
 
@@ -1328,12 +1336,12 @@
 		Parameter [] args;
 		Parameter implicit_value_parameter = new Parameter (
 			implicit_value_parameter_type, "value", 
-			Parameter.Modifier.NONE, null);
+			Parameter.Modifier.NONE, null, (Location) $3);
 
 		if (parsing_indexer == false) {
 			args  = new Parameter [1];
 			args [0] = implicit_value_parameter;
-			current_local_parameters = new Parameters (args, null, lexer.Location);
+			current_local_parameters = new Parameters (args, null);
 		} else {
 			Parameter [] fpars = indexer_parameters.FixedParameters;
 
@@ -1346,14 +1354,14 @@
 			} else 
 				args = null;
 			current_local_parameters = new Parameters (
-				args, indexer_parameters.ArrayParameter, lexer.Location);
+				args, indexer_parameters.ArrayParameter);
 		}
 		
 		lexer.PropertyParsing = false;
 	  }
 	  accessor_body
 	  {
-		$$ = new Accessor ((ToplevelBlock) $5, (int) $2, (Attributes) $1, lexer.Location);
+		$$ = new Accessor ((ToplevelBlock) $5, (int) $2, (Attributes) $1, (Location) $3);
 		current_local_parameters = null;
 		lexer.PropertyParsing = true;
 
@@ -1375,19 +1383,18 @@
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
@@ -1494,7 +1501,7 @@
 		MemberName name = (MemberName) $4;
 
 		$$ = new Method (current_class, (Expression) $3, (int) $2, true,
-				 name, (Parameters) $6, (Attributes) $1, lexer.Location);
+				 name, (Parameters) $6, (Attributes) $1, name.Location);
 		if (RootContext.Documentation != null)
 			((Method) $$).DocComment = Lexer.consume_doc_comment ();
 	  }
@@ -1504,8 +1511,8 @@
 	  {
 		MemberName name = (MemberName) $4;
 
-		$$ = new Method (current_class, TypeManager.system_void_expr, (int) $2,
-				 true, name, (Parameters) $6,  (Attributes) $1, lexer.Location);
+		$$ = new Method (current_class, new TypeLookupExpression (typeof (void), (Location) $3), (int) $2,
+				 true, name, (Parameters) $6,  (Attributes) $1, name.Location);
 		if (RootContext.Documentation != null)
 			((Method) $$).DocComment = Lexer.consume_doc_comment ();
 	  }
@@ -1521,11 +1528,12 @@
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
@@ -1539,21 +1547,22 @@
 
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
@@ -1562,11 +1571,11 @@
 		$$ = null;
 	  }
 	| opt_attributes opt_new EVENT type IDENTIFIER ASSIGN  {
-		Report.Error (68, lexer.Location, "Event declarations on interfaces can not be initialized.");
+		Report.Error (68, ((LocatedToken) $5).Location, "Event declarations on interfaces can not be initialized.");
 		$$ = null;
 	  }
 	| opt_attributes opt_new EVENT type IDENTIFIER OPEN_BRACE event_accessor_declarations CLOSE_BRACE {
-		Report.Error (69, lexer.Location, "Event accessors not valid on interfaces");
+		Report.Error (69, (Location) $3, "Event accessors not valid on interfaces");
  		$$ = null;
  	  }
 	;
@@ -1583,9 +1592,9 @@
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
@@ -1602,13 +1611,13 @@
 		
 		Parameter [] param_list = new Parameter [decl.arg2type != null ? 2 : 1];
 
-		param_list[0] = new Parameter (decl.arg1type, decl.arg1name, Parameter.Modifier.NONE, null);
+		param_list[0] = new Parameter (decl.arg1type, decl.arg1name, Parameter.Modifier.NONE, null, decl.location);
 		if (decl.arg2type != null)
-			param_list[1] = new Parameter (decl.arg2type, decl.arg2name, Parameter.Modifier.NONE, null);
+			param_list[1] = new Parameter (decl.arg2type, decl.arg2name, Parameter.Modifier.NONE, null, decl.location);
 
 		Operator op = new Operator (
 			current_class, decl.optype, decl.ret_type, (int) $2, 
-			new Parameters (param_list, null, decl.location),
+			new Parameters (param_list, null),
 			(ToplevelBlock) $5, (Attributes) $1, decl.location);
 
 		if (RootContext.Documentation != null) {
@@ -1635,8 +1644,10 @@
 	: type OPERATOR overloadable_operator 
 	  OPEN_PARENS type IDENTIFIER CLOSE_PARENS
 	{
-		Operator.OpType op = (Operator.OpType) $3;
-		CheckUnaryOperator (op);
+		LocatedToken ltParam = (LocatedToken) $6;
+		LocatedToken ltOp = (LocatedToken) $3;
+		Operator.OpType op = (Operator.OpType) ltOp.OpTypeValue;
+		CheckUnaryOperator (op, ltOp.Location);
 
 		if (op == Operator.OpType.Addition)
 			op = Operator.OpType.UnaryPlus;
@@ -1647,17 +1658,18 @@
 		Parameter [] pars = new Parameter [1];
 		Expression type = (Expression) $5;
 
-		pars [0] = new Parameter (type, (string) $6, Parameter.Modifier.NONE, null);
+		pars [0] = new Parameter (type, ltParam.StringValue,
+			Parameter.Modifier.NONE, null, ltParam.Location);
 
-		current_local_parameters = new Parameters (pars, null, lexer.Location);
+		current_local_parameters = new Parameters (pars, null);
 
 		if (RootContext.Documentation != null) {
 			tmpComment = Lexer.consume_doc_comment ();
 			Lexer.doc_state = XmlCommentState.NotAllowed;
 		}
 
-		$$ = new OperatorDeclaration (op, (Expression) $1, type, (string) $6,
-					      null, null, lexer.Location);
+		$$ = new OperatorDeclaration (op, (Expression) $1, type,
+			ltParam.StringValue, null, null, ltOp.Location);
 	}
 	| type OPERATOR overloadable_operator
 	  OPEN_PARENS 
@@ -1665,98 +1677,106 @@
 	  	type IDENTIFIER 
 	  CLOSE_PARENS
         {
-		CheckBinaryOperator ((Operator.OpType) $3);
+		LocatedToken ltParam1 = (LocatedToken) $6;
+		LocatedToken ltParam2 = (LocatedToken) $9;
+		LocatedToken ltOp = (LocatedToken) $3;
+		Operator.OpType op = (Operator.OpType) ltOp.OpTypeValue;
+		CheckBinaryOperator (op, ltOp.Location);
 
 		Parameter [] pars = new Parameter [2];
 
 		Expression typeL = (Expression) $5;
 		Expression typeR = (Expression) $8;
 
-	       pars [0] = new Parameter (typeL, (string) $6, Parameter.Modifier.NONE, null);
-	       pars [1] = new Parameter (typeR, (string) $9, Parameter.Modifier.NONE, null);
+	       pars [0] = new Parameter (typeL, ltParam1.StringValue, Parameter.Modifier.NONE, null, ltParam1.Location);
+	       pars [1] = new Parameter (typeR, ltParam2.StringValue, Parameter.Modifier.NONE, null, ltParam2.Location);
 
-	       current_local_parameters = new Parameters (pars, null, lexer.Location);
+	       current_local_parameters = new Parameters (pars, null);
 
 		if (RootContext.Documentation != null) {
 			tmpComment = Lexer.consume_doc_comment ();
 			Lexer.doc_state = XmlCommentState.NotAllowed;
 		}
 	       
-	       $$ = new OperatorDeclaration ((Operator.OpType) $3, (Expression) $1, 
-					     typeL, (string) $6,
-					     typeR, (string) $9, lexer.Location);
+	       $$ = new OperatorDeclaration (op, (Expression) $1, 
+					     typeL, ltParam1.StringValue,
+					     typeR, ltParam2.StringValue, ltOp.Location);
         }
 	| conversion_operator_declarator
 	;
 
 overloadable_operator
 // Unary operators:
-	: BANG   { $$ = Operator.OpType.LogicalNot; }
-        | TILDE  { $$ = Operator.OpType.OnesComplement; }  
-        | OP_INC { $$ = Operator.OpType.Increment; }
-        | OP_DEC { $$ = Operator.OpType.Decrement; }
-        | TRUE   { $$ = Operator.OpType.True; }
-        | FALSE  { $$ = Operator.OpType.False; }
+	: BANG   { $$ = new LocatedToken ((Location) $$, Operator.OpType.LogicalNot); }
+        | TILDE  { $$ = new LocatedToken ((Location) $$, Operator.OpType.OnesComplement); }  
+        | OP_INC { $$ = new LocatedToken ((Location) $$, Operator.OpType.Increment); }
+        | OP_DEC { $$ = new LocatedToken ((Location) $$, Operator.OpType.Decrement); }
+        | TRUE   { $$ = new LocatedToken ((Location) $$, Operator.OpType.True); }
+        | FALSE  { $$ = new LocatedToken ((Location) $$, Operator.OpType.False); }
 // Unary and binary:
-        | PLUS { $$ = Operator.OpType.Addition; }
-        | MINUS { $$ = Operator.OpType.Subtraction; }
+        | PLUS { $$ = new LocatedToken ((Location) $$, Operator.OpType.Addition); }
+        | MINUS { $$ = new LocatedToken ((Location) $$, Operator.OpType.Subtraction); }
 // Binary:
-        | STAR { $$ = Operator.OpType.Multiply; }
-        | DIV {  $$ = Operator.OpType.Division; }
-        | PERCENT { $$ = Operator.OpType.Modulus; }
-        | BITWISE_AND { $$ = Operator.OpType.BitwiseAnd; }
-        | BITWISE_OR { $$ = Operator.OpType.BitwiseOr; }
-        | CARRET { $$ = Operator.OpType.ExclusiveOr; }
-        | OP_SHIFT_LEFT { $$ = Operator.OpType.LeftShift; }
-        | OP_SHIFT_RIGHT { $$ = Operator.OpType.RightShift; }
-        | OP_EQ { $$ = Operator.OpType.Equality; }
-        | OP_NE { $$ = Operator.OpType.Inequality; }
-        | OP_GT { $$ = Operator.OpType.GreaterThan; }
-        | OP_LT { $$ = Operator.OpType.LessThan; }
-        | OP_GE { $$ = Operator.OpType.GreaterThanOrEqual; }
-        | OP_LE { $$ = Operator.OpType.LessThanOrEqual; }
+        | STAR { $$ = new LocatedToken ((Location) $$, Operator.OpType.Multiply); }
+        | DIV {  $$ = new LocatedToken ((Location) $$, Operator.OpType.Division); }
+        | PERCENT { $$ = new LocatedToken ((Location) $$, Operator.OpType.Modulus); }
+        | BITWISE_AND { $$ = new LocatedToken ((Location) $$, Operator.OpType.BitwiseAnd); }
+        | BITWISE_OR { $$ = new LocatedToken ((Location) $$, Operator.OpType.BitwiseOr); }
+        | CARRET { $$ = new LocatedToken ((Location) $$, Operator.OpType.ExclusiveOr); }
+        | OP_SHIFT_LEFT { $$ = new LocatedToken ((Location) $$, Operator.OpType.LeftShift); }
+        | OP_SHIFT_RIGHT { $$ = new LocatedToken ((Location) $$, Operator.OpType.RightShift); }
+        | OP_EQ { $$ = new LocatedToken ((Location) $$, Operator.OpType.Equality); }
+        | OP_NE { $$ = new LocatedToken ((Location) $$, Operator.OpType.Inequality); }
+        | OP_GT { $$ = new LocatedToken ((Location) $$, Operator.OpType.GreaterThan); }
+        | OP_LT { $$ = new LocatedToken ((Location) $$, Operator.OpType.LessThan); }
+        | OP_GE { $$ = new LocatedToken ((Location) $$, Operator.OpType.GreaterThanOrEqual); }
+        | OP_LE { $$ = new LocatedToken ((Location) $$, Operator.OpType.LessThanOrEqual); }
 	;
 
 conversion_operator_declarator
 	: IMPLICIT OPERATOR type OPEN_PARENS type IDENTIFIER CLOSE_PARENS
 	  {
+		LocatedToken lt = (LocatedToken) $6;
 		Parameter [] pars = new Parameter [1];
+		Expression type = (Expression) $5;
 
-		pars [0] = new Parameter ((Expression) $5, (string) $6, Parameter.Modifier.NONE, null);
+		pars [0] = new Parameter (type, lt.StringValue, Parameter.Modifier.NONE, null, lt.Location);
 
-		current_local_parameters = new Parameters (pars, null, lexer.Location);  
+		current_local_parameters = new Parameters (pars, null);  
 		  
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
+		Expression type = (Expression) $5;
 
-		pars [0] = new Parameter ((Expression) $5, (string) $6, Parameter.Modifier.NONE, null);
+		pars [0] = new Parameter (type, lt.StringValue, Parameter.Modifier.NONE, null, lt.Location);
 
-		current_local_parameters = new Parameters (pars, null, lexer.Location);  
+		current_local_parameters = new Parameters (pars, null);  
 		  
 		if (RootContext.Documentation != null) {
 			tmpComment = Lexer.consume_doc_comment ();
 			Lexer.doc_state = XmlCommentState.NotAllowed;
 		}
 
-		$$ = new OperatorDeclaration (Operator.OpType.Explicit, (Expression) $3, (Expression) $5, (string) $6,
-					      null, null, lexer.Location);
+		$$ = new OperatorDeclaration (Operator.OpType.Explicit, (Expression) $3, (Expression) $5, lt.StringValue,
+					      null, null, (Location) $2);
 	  }
 	| IMPLICIT error 
 	  {
-		syntax_error (lexer.Location, "'operator' expected");
+		syntax_error ((Location) $1, "'operator' expected");
 	  }
 	| EXPLICIT error 
 	  {
-		syntax_error (lexer.Location, "'operator' expected");
+		syntax_error ((Location) $1, "'operator' expected");
 	  }
 	;
 
@@ -1822,15 +1842,13 @@
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
 
@@ -1847,14 +1865,14 @@
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
-		Report.Error (1018, lexer.Location, "Keyword this or base expected");
+		Report.Error (1018, (Location) $1, "Keyword this or base expected");
 		$$ = null;
 	  }
 	;
@@ -1875,12 +1893,13 @@
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
@@ -1898,7 +1917,7 @@
                         
 			Method d = new Destructor (
 				current_class, TypeManager.system_void_expr, m, "Finalize", 
-				new Parameters (null, null, l), (Attributes) $1, l);
+				new Parameters (null, null), (Attributes) $1, l);
 			if (RootContext.Documentation != null)
 				d.DocComment = ConsumeStoredComment ();
 		  
@@ -1915,12 +1934,13 @@
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
 
@@ -1937,7 +1957,6 @@
 	  {
 		implicit_value_parameter_type = (Expression) $4;  
 		lexer.EventParsing = true;
-		oob_stack.Push (lexer.Location);
 	  }
 	  event_accessor_declarations
 	  {
@@ -1945,15 +1964,14 @@
 	  }
 	  CLOSE_BRACE
 	  {
-		Location loc = (Location) oob_stack.Pop ();
-
 		if ($8 == null){
-			Report.Error (65, lexer.Location, "Event must have both add and remove accesors");
+			Report.Error (65, (Location) $3, "Event must have both add and remove accesors");
 			$$ = null;
 		} else {
 			Pair pair = (Pair) $8;
 			
 			MemberName name = (MemberName) $5;
+			Location loc = name.Location;
 
 			Event e = new EventProperty (
 				current_class, (Expression) $4, (int) $2, false, name, null,
@@ -1968,13 +1986,13 @@
 			implicit_value_parameter_type = null;
 		}
 	  }
-	| opt_attributes opt_modifiers EVENT type namespace_or_type_name OPEN_PARENS opt_formal_parameter_list CLOSE_PARENS block {
+	| opt_attributes opt_modifiers EVENT type namespace_or_type_name error/*OPEN_PARENS opt_formal_parameter_list CLOSE_PARENS block*/ {
 		MemberName mn = (MemberName) $5;
 
 		if (mn.Left != null)
-			Report.Error (71, lexer.Location, "Explicit implementation of events requires property syntax");
+			Report.Error (71, mn.Location, "Explicit implementation of events requires property syntax");
 		else 
-			Report.Error (71, lexer.Location, "Event declaration should use property syntax");
+			Report.Error (71, mn.Location, "Event declaration should use property syntax");
 
 		if (RootContext.Documentation != null)
 			Lexer.doc_state = XmlCommentState.Allowed;
@@ -2006,20 +2024,20 @@
 		Parameter [] args = new Parameter [1];
 		Parameter implicit_value_parameter = new Parameter (
 			implicit_value_parameter_type, "value", 
-			Parameter.Modifier.NONE, null);
+			Parameter.Modifier.NONE, null, (Location) $2);
 
 		args [0] = implicit_value_parameter;
 		
-		current_local_parameters = new Parameters (args, null, lexer.Location);  
+		current_local_parameters = new Parameters (args, null);
 		lexer.EventParsing = false;
 	  }
           block
 	  {
-		$$ = new Accessor ((ToplevelBlock) $4, 0, (Attributes) $1, lexer.Location);
+		$$ = new Accessor ((ToplevelBlock) $4, 0, (Attributes) $1, (Location) $2);
 		lexer.EventParsing = true;
 	  }
 	| opt_attributes ADD error {
-		Report.Error (73, lexer.Location, "Add or remove accessor must have a body");
+		Report.Error (73, (Location) $2, "Add or remove accessor must have a body");
 		$$ = null;
 	  }
 	;
@@ -2030,20 +2048,20 @@
 		Parameter [] args = new Parameter [1];
 		Parameter implicit_value_parameter = new Parameter (
 			implicit_value_parameter_type, "value", 
-			Parameter.Modifier.NONE, null);
+			Parameter.Modifier.NONE, null, (Location) $2);
 
 		args [0] = implicit_value_parameter;
 		
-		current_local_parameters = new Parameters (args, null, lexer.Location);  
+		current_local_parameters = new Parameters (args, null);
 		lexer.EventParsing = false;
 	  }
           block
 	  {
-		$$ = new Accessor ((ToplevelBlock) $4, 0, (Attributes) $1, lexer.Location);
+		$$ = new Accessor ((ToplevelBlock) $4, 0, (Attributes) $1, (Location) $2);
 		lexer.EventParsing = true;
 	  }
 	| opt_attributes REMOVE error {
-		Report.Error (73, lexer.Location, "Add or remove accessor must have a body");
+		Report.Error (73, (Location) $2, "Add or remove accessor must have a body");
 		$$ = null;
 	  }
 	;
@@ -2060,7 +2078,6 @@
 		parsing_indexer  = true;
 		
 		indexer_parameters = decl.param_list;
-		oob_stack.Push (lexer.Location);
 	  }
           accessor_declarations 
 	  {
@@ -2071,7 +2088,6 @@
 	  { 
 		// The signature is computed from the signature of the indexer.  Look
 	 	// at section 3.6 on the spec
-		Location loc = (Location) oob_stack.Pop ();
 		Indexer indexer;
 		IndexerDeclaration decl = (IndexerDeclaration) $3;
 		Pair pair = (Pair) $6;
@@ -2081,13 +2097,13 @@
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
 
@@ -2105,16 +2121,16 @@
 		Parameters pars = (Parameters) $4;
 		if (pars.HasArglist) {
 			// "__arglist is not valid in this context"
-			Report.Error (1669, lexer.Location, "__arglist is not valid in this context");
+			Report.Error (1669, (Location) $2, "__arglist is not valid in this context");
 		} else if (pars.FixedParameters == null && pars.ArrayParameter == null){
-			Report.Error (1551, lexer.Location, "Indexers must have at least one parameter");
+			Report.Error (1551, (Location) $2, "Indexers must have at least one parameter");
 		}
 		if (RootContext.Documentation != null) {
 			tmpComment = Lexer.consume_doc_comment ();
 			Lexer.doc_state = XmlCommentState.Allowed;
 		}
 
-		$$ = new IndexerDeclaration ((Expression) $1, null, pars);
+		$$ = new IndexerDeclaration ((Expression) $1, null, pars, (Location) $2);
 	  }
 	| type namespace_or_type_name DOT THIS OPEN_BRACKET opt_formal_parameter_list CLOSE_BRACKET
 	  {
@@ -2122,13 +2138,13 @@
 
 		if (pars.HasArglist) {
 			// "__arglist is not valid in this context"
-			Report.Error (1669, lexer.Location, "__arglist is not valid in this context");
+			Report.Error (1669, (Location) $4, "__arglist is not valid in this context");
 		} else if (pars.FixedParameters == null && pars.ArrayParameter == null){
-			Report.Error (1551, lexer.Location, "Indexers must have at least one parameter");
+			Report.Error (1551, (Location) $4, "Indexers must have at least one parameter");
 		}
 
 		MemberName name = (MemberName) $2;
-		$$ = new IndexerDeclaration ((Expression) $1, name, pars);
+		$$ = new IndexerDeclaration ((Expression) $1, name, pars, (Location) $4);
 
 		if (RootContext.Documentation != null) {
 			tmpComment = Lexer.consume_doc_comment ();
@@ -2148,11 +2164,11 @@
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
@@ -2220,7 +2236,8 @@
 enum_member_declaration
 	: opt_attributes IDENTIFIER 
 	  {
-		VariableDeclaration vd = new VariableDeclaration ((string) $2, null, lexer.Location, (Attributes) $1);
+		LocatedToken lt = (LocatedToken) $2;
+		VariableDeclaration vd = new VariableDeclaration (lt.StringValue, null, lt.Location, (Attributes) $1);
 
 		if (RootContext.Documentation != null) {
 			vd.DocComment = Lexer.consume_doc_comment ();
@@ -2231,7 +2248,6 @@
 	  }
 	| opt_attributes IDENTIFIER
 	  {
-		$$ = lexer.Location;
 		if (RootContext.Documentation != null) {
 			tmpComment = Lexer.consume_doc_comment ();
 			Lexer.doc_state = XmlCommentState.NotAllowed;
@@ -2239,7 +2255,8 @@
 	  }
           ASSIGN expression
 	  { 
-		VariableDeclaration vd = new VariableDeclaration ((string) $2, $5, lexer.Location, (Attributes) $1);
+		LocatedToken lt = (LocatedToken) $2;
+		VariableDeclaration vd = new VariableDeclaration (lt.StringValue, $5, lt.Location, (Attributes) $1);
 
 		if (RootContext.Documentation != null)
 			vd.DocComment = ConsumeStoredComment ();
@@ -2255,8 +2272,8 @@
 	  OPEN_PARENS opt_formal_parameter_list CLOSE_PARENS 
 	  SEMICOLON
 	  {
-		Location l = lexer.Location;
 		MemberName name = MakeName ((MemberName) $5);
+		Location l = name.Location;
 		Delegate del = new Delegate (current_namespace, current_container, (Expression) $4,
 					     (int) $2, name, (Parameters) $7, (Attributes) $1, l);
 
@@ -2274,12 +2291,12 @@
 	  OPEN_PARENS opt_formal_parameter_list CLOSE_PARENS 
 	  SEMICOLON
 	  {
-		Location l = lexer.Location;
 		MemberName name = MakeName ((MemberName) $5);
+		Location l = name.Location;
 		Delegate del = new Delegate (
 			current_namespace, current_container,
-			TypeManager.system_void_expr, (int) $2, name,
-			(Parameters) $7, (Attributes) $1, l);
+			new TypeLookupExpression (typeof (void), (Location) $4),
+			(int) $2, name, (Parameters) $7, (Attributes) $1, l);
 
 		if (RootContext.Documentation != null) {
 			del.DocComment = Lexer.consume_doc_comment ();
@@ -2294,13 +2311,15 @@
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
 
@@ -2313,7 +2332,8 @@
 type
 	: namespace_or_type_name
 	  {
-		$$ = ((MemberName) $1).GetTypeExpression (lexer.Location);
+		MemberName name = (MemberName) $1;
+		$$ = name.GetTypeExpression (name.Location);
 	  }
 	| builtin_types
 	| array_type
@@ -2329,11 +2349,13 @@
 		// can't perform checks during this phase - we do it during
 		// semantic analysis.
 		//
-		$$ = new ComposedCast ((Expression) $1, "*", lexer.Location);
+		Expression e = (Expression) $1;
+		$$ = new ComposedCast (e, "*", e.Location);
 	  }
 	| VOID STAR
 	  {
-		$$ = new ComposedCast (TypeManager.system_void_expr, "*", lexer.Location);
+		Location l = (Location) $1;
+		$$ = new ComposedCast (new TypeLookupExpression (typeof (void), l), "*", l);
 	  }
 	;
 
@@ -2341,19 +2363,23 @@
 	: builtin_types	
 	| non_expression_type rank_specifier
 	  {
-		$$ = new ComposedCast ((Expression) $1, (string) $2, lexer.Location);
+		Expression e = (Expression) $1;
+		$$ = new ComposedCast (e, (string) $2, e.Location);
 	  }
 	| non_expression_type STAR
 	  {
-		$$ = new ComposedCast ((Expression) $1, "*", lexer.Location);
+		Expression e = (Expression) $1;
+		$$ = new ComposedCast (e, "*", e.Location);
 	  }
 	| expression rank_specifiers 
 	  {
-		$$ = new ComposedCast ((Expression) $1, (string) $2, lexer.Location);
+		Expression e = (Expression) $1;
+		$$ = new ComposedCast (e, (string) $2, e.Location);
 	  }
 	| expression STAR 
 	  {
-		$$ = new ComposedCast ((Expression) $1, "*", lexer.Location);
+		Expression e = (Expression) $1;
+		$$ = new ComposedCast (e, "*", e.Location);
 	  }
 	
 	//
@@ -2362,7 +2388,7 @@
 	//
 	| multiplicative_expression STAR 
 	  {
-		$$ = new ComposedCast ((Expression) $1, "*", lexer.Location);
+		$$ = new ComposedCast ((Expression) $1, "*", (Location) $2);
 	  }
 	;
 
@@ -2388,32 +2414,33 @@
  * simple types, but we need this to reuse it easily in local_variable_type
  */
 builtin_types
-	: OBJECT	{ $$ = TypeManager.system_object_expr; }
-	| STRING	{ $$ = TypeManager.system_string_expr; }
-	| BOOL		{ $$ = TypeManager.system_boolean_expr; }
-	| DECIMAL	{ $$ = TypeManager.system_decimal_expr; }
-	| FLOAT		{ $$ = TypeManager.system_single_expr; }
-	| DOUBLE	{ $$ = TypeManager.system_double_expr; }
+	: OBJECT	{ $$ = new TypeLookupExpression (typeof (object), (Location) $1); }
+	| STRING	{ $$ = new TypeLookupExpression (typeof (string), (Location) $1); }
+	| BOOL		{ $$ = new TypeLookupExpression (typeof (bool), (Location) $1); }
+	| DECIMAL	{ $$ = new TypeLookupExpression (typeof (decimal), (Location) $1); }
+	| FLOAT		{ $$ = new TypeLookupExpression (typeof (float), (Location) $1); }
+	| DOUBLE	{ $$ = new TypeLookupExpression (typeof (double), (Location) $1); }
 	| integral_type
 	;
 
 integral_type
-	: SBYTE		{ $$ = TypeManager.system_sbyte_expr; }
-	| BYTE		{ $$ = TypeManager.system_byte_expr; }
-	| SHORT		{ $$ = TypeManager.system_int16_expr; }
-	| USHORT	{ $$ = TypeManager.system_uint16_expr; }
-	| INT		{ $$ = TypeManager.system_int32_expr; }
-	| UINT		{ $$ = TypeManager.system_uint32_expr; }
-	| LONG		{ $$ = TypeManager.system_int64_expr; }
-	| ULONG		{ $$ = TypeManager.system_uint64_expr; }
-	| CHAR		{ $$ = TypeManager.system_char_expr; }
-	| VOID		{ $$ = TypeManager.system_void_expr; }
+	: SBYTE		{ $$ = new TypeLookupExpression (typeof (sbyte), (Location) $1); }
+	| BYTE		{ $$ = new TypeLookupExpression (typeof (byte), (Location) $1); }
+	| SHORT		{ $$ = new TypeLookupExpression (typeof (short), (Location) $1); }
+	| USHORT	{ $$ = new TypeLookupExpression (typeof (ushort), (Location) $1); }
+	| INT		{ $$ = new TypeLookupExpression (typeof (int), (Location) $1); }
+	| UINT		{ $$ = new TypeLookupExpression (typeof (uint), (Location) $1); }
+	| LONG		{ $$ = new TypeLookupExpression (typeof (long), (Location) $1); }
+	| ULONG		{ $$ = new TypeLookupExpression (typeof (ulong), (Location) $1); }
+	| CHAR		{ $$ = new TypeLookupExpression (typeof (char), (Location) $1); }
+	| VOID		{ $$ = new TypeLookupExpression (typeof (void), (Location) $1); }
 	;
 
 array_type
 	: type rank_specifiers
 	  {
-		$$ = new ComposedCast ((Expression) $1, (string) $2, lexer.Location);
+		Expression e = (Expression) $1;
+		$$ = new ComposedCast (e, (string) $2, e.Location);
 	  }
 	;
 
@@ -2428,7 +2455,8 @@
  
 	| member_name
 	  {
-		$$ = ((MemberName) $1).GetTypeExpression (lexer.Location);
+		MemberName name = (MemberName) $1;
+		$$ = name.GetTypeExpression (name.Location);
 	  }
 	| parenthesized_expression
 	| member_access
@@ -2512,18 +2540,21 @@
 		// If a parenthesized expression is followed by a minus, we need to wrap
 		// the expression inside a ParenthesizedExpression for the CS0075 check
 		// in Binary.DoResolve().
-		$$ = new ParenthesizedExpression ((Expression) $1, lexer.Location);
+		Expression e = (Expression) $1;
+		$$ = new ParenthesizedExpression (e, e.Location);
 	  }
 	;;
 
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
 
@@ -2535,18 +2566,21 @@
 	: primary_expression OPEN_PARENS opt_argument_list CLOSE_PARENS
 	  {
 		if ($1 == null) {
-			Location l = lexer.Location;
-			Report.Error (1, l, "Parse error");
+			Report.Error (1, (Location) $2, "Parse error");
 		}
-		$$ = new Invocation ((Expression) $1, (ArrayList) $3, lexer.Location);
+		Expression e = (Expression) $1;
+		Location l = e == null ? (Location) $2 : e.Location;
+		$$ = new Invocation (e, (ArrayList) $3, l);
 	  }
 	| parenthesized_expression_0 CLOSE_PARENS_OPEN_PARENS OPEN_PARENS CLOSE_PARENS
 	  {
-		$$ = new Invocation ((Expression) $1, new ArrayList (), lexer.Location);
+		Expression e = (Expression) $1;
+		$$ = new Invocation (e, new ArrayList (), e.Location);
 	  }
 	| parenthesized_expression_0 CLOSE_PARENS_OPEN_PARENS primary_expression
 	  {
-		$$ = new InvocationOrCast ((Expression) $1, (Expression) $3, lexer.Location);
+		Expression e = (Expression) $1;
+		$$ = new InvocationOrCast (e, (Expression) $3, e.Location);
 	  }
 	;
 
@@ -2592,12 +2626,12 @@
 		Argument[] args = new Argument [list.Count];
 		list.CopyTo (args, 0);
 
-		Expression expr = new Arglist (args, lexer.Location);
+		Expression expr = new Arglist (args, (Location) $1);
 		$$ = new Argument (expr, Argument.AType.Expression);
 	  }
 	| ARGLIST
 	  {
-		$$ = new Argument (new ArglistAccess (lexer.Location), Argument.AType.ArgList);
+		$$ = new Argument (new ArglistAccess ((Location) $1), Argument.AType.ArgList);
 	  }
 	;
 
@@ -2608,7 +2642,7 @@
 element_access
 	: primary_expression OPEN_BRACKET expression_list CLOSE_BRACKET	
 	  {
-		$$ = new ElementAccess ((Expression) $1, (ArrayList) $3, lexer.Location);
+		$$ = new ElementAccess ((Expression) $1, (ArrayList) $3, (Location) $2);
 	  }
 	| primary_expression rank_specifiers
 	  {
@@ -2621,16 +2655,16 @@
 		  
 		Expression expr = (Expression) $1;  
 		if (expr is ComposedCast){
-			$$ = new ComposedCast (expr, (string) $2, lexer.Location);
+			$$ = new ComposedCast (expr, (string) $2, expr.Location);
 		} else if (!(expr is SimpleName || expr is MemberAccess)){
-			Error_ExpectingTypeName (lexer.Location, expr);
-			$$ = TypeManager.system_object_expr;
+			Error_ExpectingTypeName (expr.Location, expr);
+			$$ = new TypeLookupExpression (typeof (object), expr.Location);
 		} else {
 			//
 			// So we extract the string corresponding to the SimpleName
 			// or MemberAccess
 			// 
-			$$ = new ComposedCast (expr, (string) $2, lexer.Location);
+			$$ = new ComposedCast (expr, (string) $2, expr.Location);
 		}
 	  }
 	;
@@ -2653,21 +2687,22 @@
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
@@ -2676,7 +2711,7 @@
 	: primary_expression OP_INC
 	  {
 		$$ = new UnaryMutator (UnaryMutator.Mode.PostIncrement,
-				       (Expression) $1, lexer.Location);
+				       (Expression) $1, (Location) $2);
 	  }
 	;
 
@@ -2684,7 +2719,7 @@
 	: primary_expression OP_DEC
 	  {
 		$$ = new UnaryMutator (UnaryMutator.Mode.PostDecrement,
-				       (Expression) $1, lexer.Location);
+				       (Expression) $1, (Location) $2);
 	  }
 	;
 
@@ -2696,7 +2731,7 @@
 object_or_delegate_creation_expression
 	: NEW type OPEN_PARENS opt_argument_list CLOSE_PARENS
 	  {
-		$$ = new New ((Expression) $2, (ArrayList) $4, lexer.Location);
+		$$ = new New ((Expression) $2, (ArrayList) $4, (Location) $1);
 	  }
 	;
 
@@ -2705,20 +2740,20 @@
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
-		Report.Error (1031, lexer.Location, "Type expected");
+		Report.Error (1031, (Location) $1, "Type expected");
                 $$ = null;
 	  }          
 	| NEW type error 
 	  {
-		Report.Error (1526, lexer.Location, "new expression requires () or [] after type");
+		Report.Error (1526, (Location) $1, "new expression requires () or [] after type");
 	  }
 	;
 
@@ -2810,31 +2845,31 @@
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
 
@@ -2842,9 +2877,10 @@
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
 
@@ -2856,14 +2892,13 @@
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
@@ -2890,7 +2925,7 @@
 			ArrayList par_list = (ArrayList) $2;
 			Parameter [] pars = new Parameter [par_list.Count];
 			par_list.CopyTo (pars);
-			$$ = new Parameters (pars, null, lexer.Location);
+			$$ = new Parameters (pars, null);
 		}
 	  }
 	;
@@ -2917,10 +2952,12 @@
 
 anonymous_method_parameter
 	: opt_parameter_modifier type IDENTIFIER {
-		$$ = new Parameter ((Expression) $2, (string) $3, (Parameter.Modifier) $1, null);
+		LocatedToken lt = (LocatedToken) $3;
+		Expression type = (Expression) $2;
+		$$ = new Parameter (type, lt.StringValue, (Parameter.Modifier) $1, null, lt.Location);
 	  }
 	| PARAMS type IDENTIFIER {
-		Report.Error (-221, lexer.Location, "params modifier not allowed in anonymous method declaration");
+		Report.Error (-221, (Location) $1, "params modifier not allowed in anonymous method declaration");
 		$$ = null;
 	  }
 	;
@@ -2929,11 +2966,11 @@
 	: primary_expression
 	| BANG prefixed_unary_expression
 	  {
-		$$ = new Unary (Unary.Operator.LogicalNot, (Expression) $2, lexer.Location);
+		$$ = new Unary (Unary.Operator.LogicalNot, (Expression) $2, (Location) $1);
 	  }
 	| TILDE prefixed_unary_expression
 	  {
-		$$ = new Unary (Unary.Operator.OnesComplement, (Expression) $2, lexer.Location);
+		$$ = new Unary (Unary.Operator.OnesComplement, (Expression) $2, (Location) $1);
 	  }
 	| cast_expression
 	;
@@ -2941,11 +2978,11 @@
 cast_list
 	: parenthesized_expression_0 CLOSE_PARENS_CAST unary_expression
 	  {
-		$$ = new Cast ((Expression) $1, (Expression) $3, lexer.Location);
+		$$ = new Cast ((Expression) $1, (Expression) $3, (Location) $2);
 	  }
 	| parenthesized_expression_0 CLOSE_PARENS_OPEN_PARENS cast_expression
 	  {
-		$$ = new Cast ((Expression) $1, (Expression) $3, lexer.Location);
+		$$ = new Cast ((Expression) $1, (Expression) $3, (Location) $2);
 	  }	
 	;
 
@@ -2953,7 +2990,7 @@
 	: cast_list
 	| OPEN_PARENS non_expression_type CLOSE_PARENS prefixed_unary_expression
 	  {
-		$$ = new Cast ((Expression) $2, (Expression) $4, lexer.Location);
+		$$ = new Cast ((Expression) $2, (Expression) $4, (Location) $1);
 	  }
 	;
 
@@ -2965,29 +3002,29 @@
 	: unary_expression
 	| PLUS prefixed_unary_expression
 	  { 
-	  	$$ = new Unary (Unary.Operator.UnaryPlus, (Expression) $2, lexer.Location);
+	  	$$ = new Unary (Unary.Operator.UnaryPlus, (Expression) $2, (Location) $1);
 	  } 
 	| MINUS prefixed_unary_expression 
 	  { 
-		$$ = new Unary (Unary.Operator.UnaryNegation, (Expression) $2, lexer.Location);
+		$$ = new Unary (Unary.Operator.UnaryNegation, (Expression) $2, (Location) $1);
 	  }
 	| OP_INC prefixed_unary_expression 
 	  {
 		$$ = new UnaryMutator (UnaryMutator.Mode.PreIncrement,
-				       (Expression) $2, lexer.Location);
+				       (Expression) $2, (Location) $1);
 	  }
 	| OP_DEC prefixed_unary_expression 
 	  {
 		$$ = new UnaryMutator (UnaryMutator.Mode.PreDecrement,
-				       (Expression) $2, lexer.Location);
+				       (Expression) $2, (Location) $1);
 	  }
 	| STAR prefixed_unary_expression
 	  {
-		$$ = new Unary (Unary.Operator.Indirection, (Expression) $2, lexer.Location);
+		$$ = new Unary (Unary.Operator.Indirection, (Expression) $2, (Location) $1);
 	  }
 	| BITWISE_AND prefixed_unary_expression
 	  {
-		$$ = new Unary (Unary.Operator.AddressOf, (Expression) $2, lexer.Location);
+		$$ = new Unary (Unary.Operator.AddressOf, (Expression) $2, (Location) $1);
 	  }
 	;
 
@@ -2995,7 +3032,7 @@
 	: OP_INC prefixed_unary_expression 
 	  {
 		$$ = new UnaryMutator (UnaryMutator.Mode.PreIncrement,
-				       (Expression) $2, lexer.Location);
+				       (Expression) $2, (Location) $1);
 	  }
 	;
 
@@ -3003,7 +3040,7 @@
 	: OP_DEC prefixed_unary_expression 
 	  {
 		$$ = new UnaryMutator (UnaryMutator.Mode.PreDecrement,
-				       (Expression) $2, lexer.Location);
+				       (Expression) $2, (Location) $1);
 	  }
 	;
 
@@ -3012,17 +3049,17 @@
 	| multiplicative_expression STAR prefixed_unary_expression
 	  {
 		$$ = new Binary (Binary.Operator.Multiply, 
-			         (Expression) $1, (Expression) $3, lexer.Location);
+			         (Expression) $1, (Expression) $3, (Location) $2);
 	  }
 	| multiplicative_expression DIV prefixed_unary_expression
 	  {
 		$$ = new Binary (Binary.Operator.Division, 
-			         (Expression) $1, (Expression) $3, lexer.Location);
+			         (Expression) $1, (Expression) $3, (Location) $2);
 	  }
 	| multiplicative_expression PERCENT prefixed_unary_expression 
 	  {
 		$$ = new Binary (Binary.Operator.Modulus, 
-			         (Expression) $1, (Expression) $3, lexer.Location);
+			         (Expression) $1, (Expression) $3, (Location) $2);
 	  }
 	;
 
@@ -3031,12 +3068,12 @@
 	| additive_expression PLUS multiplicative_expression 
 	  {
 		$$ = new Binary (Binary.Operator.Addition, 
-			         (Expression) $1, (Expression) $3, lexer.Location);
+			         (Expression) $1, (Expression) $3, (Location) $2);
 	  }
 	| additive_expression MINUS multiplicative_expression
 	  {
 		$$ = new Binary (Binary.Operator.Subtraction, 
-			         (Expression) $1, (Expression) $3, lexer.Location);
+			         (Expression) $1, (Expression) $3, (Location) $2);
 	  }
 	;
 
@@ -3045,12 +3082,12 @@
 	| shift_expression OP_SHIFT_LEFT additive_expression
 	  {
 		$$ = new Binary (Binary.Operator.LeftShift, 
-			         (Expression) $1, (Expression) $3, lexer.Location);
+			         (Expression) $1, (Expression) $3, (Location) $2);
 	  }
 	| shift_expression OP_SHIFT_RIGHT additive_expression
 	  {
 		$$ = new Binary (Binary.Operator.RightShift, 
-			         (Expression) $1, (Expression) $3, lexer.Location);
+			         (Expression) $1, (Expression) $3, (Location) $2);
 	  }
 	; 
 
@@ -3059,30 +3096,30 @@
 	| relational_expression OP_LT shift_expression
 	  {
 		$$ = new Binary (Binary.Operator.LessThan, 
-			         (Expression) $1, (Expression) $3, lexer.Location);
+			         (Expression) $1, (Expression) $3, (Location) $2);
 	  }
 	| relational_expression OP_GT shift_expression
 	  {
 		$$ = new Binary (Binary.Operator.GreaterThan, 
-			         (Expression) $1, (Expression) $3, lexer.Location);
+			         (Expression) $1, (Expression) $3, (Location) $2);
 	  }
 	| relational_expression OP_LE shift_expression
 	  {
 		$$ = new Binary (Binary.Operator.LessThanOrEqual, 
-			         (Expression) $1, (Expression) $3, lexer.Location);
+			         (Expression) $1, (Expression) $3, (Location) $2);
 	  }
 	| relational_expression OP_GE shift_expression
 	  {
 		$$ = new Binary (Binary.Operator.GreaterThanOrEqual, 
-			         (Expression) $1, (Expression) $3, lexer.Location);
+			         (Expression) $1, (Expression) $3, (Location) $2);
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
 
@@ -3091,12 +3128,12 @@
 	| equality_expression OP_EQ relational_expression
 	  {
 		$$ = new Binary (Binary.Operator.Equality, 
-			         (Expression) $1, (Expression) $3, lexer.Location);
+			         (Expression) $1, (Expression) $3, (Location) $2);
 	  }
 	| equality_expression OP_NE relational_expression
 	  {
 		$$ = new Binary (Binary.Operator.Inequality, 
-			         (Expression) $1, (Expression) $3, lexer.Location);
+			         (Expression) $1, (Expression) $3, (Location) $2);
 	  }
 	; 
 
@@ -3105,7 +3142,7 @@
 	| and_expression BITWISE_AND equality_expression
 	  {
 		$$ = new Binary (Binary.Operator.BitwiseAnd, 
-			         (Expression) $1, (Expression) $3, lexer.Location);
+			         (Expression) $1, (Expression) $3, (Location) $2);
 	  }
 	;
 
@@ -3114,7 +3151,7 @@
 	| exclusive_or_expression CARRET and_expression
 	  {
 		$$ = new Binary (Binary.Operator.ExclusiveOr, 
-			         (Expression) $1, (Expression) $3, lexer.Location);
+			         (Expression) $1, (Expression) $3, (Location) $2);
 	  }
 	;
 
@@ -3123,7 +3160,7 @@
 	| inclusive_or_expression BITWISE_OR exclusive_or_expression
 	  {
 		$$ = new Binary (Binary.Operator.BitwiseOr, 
-			         (Expression) $1, (Expression) $3, lexer.Location);
+			         (Expression) $1, (Expression) $3, (Location) $2);
 	  }
 	;
 
@@ -3132,7 +3169,7 @@
 	| conditional_and_expression OP_AND inclusive_or_expression
 	  {
 		$$ = new Binary (Binary.Operator.LogicalAnd, 
-			         (Expression) $1, (Expression) $3, lexer.Location);
+			         (Expression) $1, (Expression) $3, (Location) $2);
 	  }
 	;
 
@@ -3141,7 +3178,7 @@
 	| conditional_or_expression OP_OR conditional_and_expression
 	  {
 		$$ = new Binary (Binary.Operator.LogicalOr, 
-			         (Expression) $1, (Expression) $3, lexer.Location);
+			         (Expression) $1, (Expression) $3, (Location) $2);
 	  }
 	;
 
@@ -3149,81 +3186,81 @@
 	: conditional_or_expression
 	| conditional_or_expression INTERR expression COLON expression 
 	  {
-		$$ = new Conditional ((Expression) $1, (Expression) $3, (Expression) $5, lexer.Location);
+		$$ = new Conditional ((Expression) $1, (Expression) $3, (Expression) $5, (Location) $2);
 	  }
 	;
 
 assignment_expression
 	: prefixed_unary_expression ASSIGN expression
 	  {
-		$$ = new Assign ((Expression) $1, (Expression) $3, lexer.Location);
+		$$ = new Assign ((Expression) $1, (Expression) $3, (Location) $2);
 	  }
 	| prefixed_unary_expression OP_MULT_ASSIGN expression
 	  {
-		Location l = lexer.Location;
+		Location l = (Location) $2;
 
 		$$ = new CompoundAssign (
 			Binary.Operator.Multiply, (Expression) $1, (Expression) $3, l);
 	  }
 	| prefixed_unary_expression OP_DIV_ASSIGN expression
 	  {
-		Location l = lexer.Location;
+		Location l = (Location) $2;
 
 		$$ = new CompoundAssign (
 			Binary.Operator.Division, (Expression) $1, (Expression) $3, l);
 	  }
 	| prefixed_unary_expression OP_MOD_ASSIGN expression
 	  {
-		Location l = lexer.Location;
+		Location l = (Location) $2;
 
 		$$ = new CompoundAssign (
 			Binary.Operator.Modulus, (Expression) $1, (Expression) $3, l);
 	  }
 	| prefixed_unary_expression OP_ADD_ASSIGN expression
 	  {
-		Location l = lexer.Location;
+		Location l = (Location) $2;
 
 		$$ = new CompoundAssign (
 			Binary.Operator.Addition, (Expression) $1, (Expression) $3, l);
 	  }
 	| prefixed_unary_expression OP_SUB_ASSIGN expression
 	  {
-		Location l = lexer.Location;
+		Location l = (Location) $2;
 
 		$$ = new CompoundAssign (
 			Binary.Operator.Subtraction, (Expression) $1, (Expression) $3, l);
 	  }
 	| prefixed_unary_expression OP_SHIFT_LEFT_ASSIGN expression
 	  {
-		Location l = lexer.Location;
+		Location l = (Location) $2;
 
 		$$ = new CompoundAssign (
 			Binary.Operator.LeftShift, (Expression) $1, (Expression) $3, l);
 	  }
 	| prefixed_unary_expression OP_SHIFT_RIGHT_ASSIGN expression
 	  {
-		Location l = lexer.Location;
+		Location l = (Location) $2;
 
 		$$ = new CompoundAssign (
 			Binary.Operator.RightShift, (Expression) $1, (Expression) $3, l);
 	  }
 	| prefixed_unary_expression OP_AND_ASSIGN expression
 	  {
-		Location l = lexer.Location;
+		Location l = (Location) $2;
 
 		$$ = new CompoundAssign (
 			Binary.Operator.BitwiseAnd, (Expression) $1, (Expression) $3, l);
 	  }
 	| prefixed_unary_expression OP_OR_ASSIGN expression
 	  {
-		Location l = lexer.Location;
+		Location l = (Location) $2;
 
 		$$ = new CompoundAssign (
 			Binary.Operator.BitwiseOr, (Expression) $1, (Expression) $3, l);
 	  }
 	| prefixed_unary_expression OP_XOR_ASSIGN expression
 	  {
-		Location l = lexer.Location;
+		Location l = (Location) $2;
 
 		$$ = new CompoundAssign (
 			Binary.Operator.ExclusiveOr, (Expression) $1, (Expression) $3, l);
@@ -3253,13 +3290,12 @@
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
@@ -3267,11 +3303,11 @@
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
@@ -3312,9 +3348,9 @@
 
 opt_partial
 	: /* empty */
-	  { $$ = (bool) false; }
+	  { $$ = null; }
 	| PARTIAL
-	  { $$ = (bool) true; }
+	  { $$ = $1; } // location
 	;
 
 opt_modifiers
@@ -3380,11 +3416,11 @@
 	: OPEN_BRACE 
 	  {
 		if (current_block == null){
-			current_block = new ToplevelBlock ((ToplevelBlock) top_current_block, current_local_parameters, lexer.Location);
+			current_block = new ToplevelBlock ((ToplevelBlock) top_current_block, current_local_parameters, (Location) $1);
 			top_current_block = current_block;
 		} else {
 		current_block = new Block (current_block, current_local_parameters,
-					   lexer.Location, Location.Null);
+					   (Location) $1, Location.Null);
 		}
 	  } 
 	  opt_statement_list CLOSE_BRACE 
@@ -3392,7 +3428,7 @@
 		while (current_block.Implicit)
 			current_block = current_block.Parent;
 		$$ = current_block;
-		current_block.SetEndLocation (lexer.Location);
+		current_block.SetEndLocation ((Location) $4);
 		current_block = current_block.Parent;
 		if (current_block == null)
 			top_current_block = null;
@@ -3444,12 +3480,12 @@
 	: valid_declaration_statement
 	| declaration_statement
 	  {
-		  Report.Error (1023, lexer.Location, "An embedded statement may not be a declaration.");
+		  Report.Error (1023, ((Statement) $1).loc, "An embedded statement may not be a declaration.");
 		  $$ = null;
 	  }
 	| labeled_statement
 	  {
-		  Report.Error (1023, lexer.Location, "An embedded statement may not be a labeled statement.");
+		  Report.Error (1023, ((Statement) $1).loc, "An embedded statement may not be a labeled statement.");
 		  $$ = null;
 	  }
 	;
@@ -3457,16 +3493,17 @@
 empty_statement
 	: SEMICOLON
 	  {
-		  $$ = EmptyStatement.Value;
+		  $$ = new EmptyStatement ((Location) $1);
 	  }
 	;
 
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
@@ -3477,8 +3514,8 @@
 	  {
 		if ($1 != null){
 			DictionaryEntry de = (DictionaryEntry) $1;
-
-			$$ = declare_local_variables ((Expression) de.Key, (ArrayList) de.Value, lexer.Location);
+			Expression e = (Expression) de.Key;
+			$$ = declare_local_variables (e, (ArrayList) de.Value, e.Location);
 		}
 	  }
 
@@ -3518,8 +3555,10 @@
 		// Blah i;
 		  
 		Expression expr = (Expression) $1;  
+		Location l = expr.Location;
+
 		if (!(expr is SimpleName || expr is MemberAccess || expr is ComposedCast)) {
-			Error_ExpectingTypeName (lexer.Location, expr);
+			Error_ExpectingTypeName (l, expr);
 			$$ = null;
 		} else {
 			//
@@ -3530,15 +3569,17 @@
 			if ((string) $2 == "")
 				$$ = $1;
 			else
-				$$ = new ComposedCast ((Expression) $1, (string) $2, lexer.Location);
+				$$ = new ComposedCast (expr, (string) $2, l);
 		}
 	  }
 	| builtin_types opt_rank_specifier
 	  {
 		if ((string) $2 == "")
 			$$ = $1;
-		else
-			$$ = new ComposedCast ((Expression) $1, (string) $2, lexer.Location);
+		else {
+			Expression e = (Expression) $1;
+			$$ = new ComposedCast (e, (string) $2, e.Location);
+		}
 	  }
         ;
 
@@ -3546,26 +3587,28 @@
 	: primary_expression STAR
 	  {
 		Expression expr = (Expression) $1;  
-		Location l = lexer.Location;
 
 		if (!(expr is SimpleName || expr is MemberAccess || expr is ComposedCast)) {
-			Error_ExpectingTypeName (l, expr);
+			Error_ExpectingTypeName (expr.Location, expr);
 
 			$$ = null;
 		} else 
-			$$ = new ComposedCast ((Expression) $1, "*", l);
+			$$ = new ComposedCast (expr, "*", (Location) $2);
 	  }
         | builtin_types STAR
 	  {
-		$$ = new ComposedCast ((Expression) $1, "*", lexer.Location);;
+		Expression e = (Expression) $1;
+		$$ = new ComposedCast (e, "*", e.Location);
 	  }
         | VOID STAR
 	  {
-		$$ = new ComposedCast (TypeManager.system_void_expr, "*", lexer.Location);;
+		Location l = (Location) $1;
+		$$ = new ComposedCast (new TypeLookupExpression (typeof (void), l), "*", l);
 	  }
 	| local_variable_pointer_type STAR
           {
-		$$ = new ComposedCast ((Expression) $1, "*", lexer.Location);
+		Expression e = (Expression) $1;
+		$$ = new ComposedCast (e, "*", e.Location);
 	  }
         ;
 
@@ -3584,8 +3627,10 @@
 
 			if ((string) $2 == "")
 				t = (Expression) $1;
-			else
-				t = new ComposedCast ((Expression) $1, (string) $2, lexer.Location);
+			else {
+				Expression e = (Expression) $1;
+				t = new ComposedCast (e, (string) $2, e.Location);
+			}
 			$$ = new DictionaryEntry (t, $3);
 		} else 
 			$$ = null;
@@ -3614,13 +3659,41 @@
 	// because statement_expression is used for example in for_statement
 	//
 statement_expression
-	: invocation_expression		{ $$ = new StatementExpression ((ExpressionStatement) $1, lexer.Location); }
-	| object_creation_expression	{ $$ = new StatementExpression ((ExpressionStatement) $1, lexer.Location); }
-	| assignment_expression		{ $$ = new StatementExpression ((ExpressionStatement) $1, lexer.Location); }
-	| post_increment_expression	{ $$ = new StatementExpression ((ExpressionStatement) $1, lexer.Location); }
-	| post_decrement_expression	{ $$ = new StatementExpression ((ExpressionStatement) $1, lexer.Location); }
-	| pre_increment_expression	{ $$ = new StatementExpression ((ExpressionStatement) $1, lexer.Location); }
-	| pre_decrement_expression	{ $$ = new StatementExpression ((ExpressionStatement) $1, lexer.Location); }
+	: invocation_expression
+	  {
+		ExpressionStatement e = (ExpressionStatement) $1;
+		$$ = new StatementExpression (e, e.Location);
+	  }
+	| object_creation_expression
+	  {
+		ExpressionStatement e = (ExpressionStatement) $1;
+		$$ = new StatementExpression (e, e.Location);
+	  }
+	| assignment_expression
+	  {
+		ExpressionStatement e = (ExpressionStatement) $1;
+		$$ = new StatementExpression (e, e.Location);
+	  }
+	| post_increment_expression
+	  {
+		ExpressionStatement e = (ExpressionStatement) $1;
+		$$ = new StatementExpression (e, e.Location);
+	  }
+	| post_decrement_expression
+	  {
+		ExpressionStatement e = (ExpressionStatement) $1;
+		$$ = new StatementExpression (e, e.Location);
+	  }
+	| pre_increment_expression
+	  {
+		ExpressionStatement e = (ExpressionStatement) $1;
+		$$ = new StatementExpression (e, e.Location);
+	  }
+	| pre_decrement_expression
+	  {
+		ExpressionStatement e = (ExpressionStatement) $1;
+		$$ = new StatementExpression (e, e.Location);
+	  }
 	| error {
 		Report.Error (1002, lexer.Location, "Expecting `;'");
 		$$ = null;
@@ -3647,7 +3720,7 @@
 if_statement_open
 	: IF OPEN_PARENS 
 	  {
-	   	oob_stack.Push (lexer.Location);
+	   	oob_stack.Push ((Location) $1);
 	  }
 	;
 
@@ -3660,8 +3733,8 @@
 		$$ = new If ((Expression) $1, (Statement) $3, l);
 
 		if (RootContext.WarningLevel >= 4){
-			if ($3 == EmptyStatement.Value)
-				Report.Warning (642, lexer.Location, "Possible mistaken empty statement");
+			if ($3 is EmptyStatement)
+				Report.Warning (642, ((Statement) $3).loc, "Possible mistaken empty statement");
 		}
 
 	  }
@@ -3677,13 +3750,12 @@
 switch_statement
 	: SWITCH OPEN_PARENS 
 	  { 
-		oob_stack.Push (lexer.Location);
 		switch_stack.Push (current_block);
 	  }
 	  expression CLOSE_PARENS 
 	  switch_block
 	  {
-		$$ = new Switch ((Expression) $4, (ArrayList) $6, (Location) oob_stack.Pop ());
+		$$ = new Switch ((Expression) $4, (ArrayList) $6, (Location) $1);
 		current_block = (Block) switch_stack.Pop ();
 	  }
 	;
@@ -3725,6 +3797,7 @@
 switch_section
 	: switch_labels
 	  {
+		// FIXME: get Location (but maybe impossible)
 		current_block = current_block.CreateSwitchBlock (lexer.Location);
 	  }
  	  statement_list 
@@ -3755,8 +3828,8 @@
 	;
 
 switch_label
-	: CASE constant_expression COLON 	{ $$ = new SwitchLabel ((Expression) $2, lexer.Location); }
-	| DEFAULT COLON				{ $$ = new SwitchLabel (null, lexer.Location); }
+	: CASE constant_expression COLON 	{ $$ = new SwitchLabel ((Expression) $2, (Location) $1); }
+	| DEFAULT COLON				{ $$ = new SwitchLabel (null, (Location) $1); }
 	| error {
 		Report.Error (
 			1523, lexer.Location, 
@@ -3772,32 +3845,25 @@
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
-				Report.Warning (642, lexer.Location, "Possible mistaken empty statement");
+		if (RootContext.WarningLevel >= 3){
+			if ($5 is EmptyStatement)
+				Report.Warning (642, ((Statement) $5).loc, "Possible mistaken empty statement");
 		}
 	}
 	;
 
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
 
@@ -3823,7 +3889,6 @@
 				if (vi == null)
 					continue;
 
-				Location l = lexer.Location;
 				Expression expr;
 				if (decl.expression_or_array_initializer is Expression){
 					expr = (Expression) decl.expression_or_array_initializer;
@@ -3835,30 +3900,29 @@
 				}
 					
 				LocalVariableReference var;
-				var = new LocalVariableReference (assign_block, decl.identifier, l);
+				var = new LocalVariableReference (assign_block, decl.identifier, decl.Location);
 
 				if (expr != null) {
 					Assign a = new Assign (var, expr, decl.Location);
 					
-					assign_block.AddStatement (new StatementExpression (a, lexer.Location));
+					assign_block.AddStatement (new StatementExpression (a, a.Location));
 				}
 			}
 			
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
 
 		if (RootContext.WarningLevel >= 4){
-			if ($10 == EmptyStatement.Value)
-				Report.Warning (642, lexer.Location, "Possible mistaken empty statement");
+			if ($10 is EmptyStatement)
+				Report.Warning (642, ((Statement) $10).loc, "Possible mistaken empty statement");
 		}
 
 		current_block.AddStatement (f);
@@ -3870,7 +3934,7 @@
 	;
 
 opt_for_initializer
-	: /* empty */		{ $$ = EmptyStatement.Value; }
+	: /* empty */		{ $$ = new EmptyStatement (lexer.Location); }
 	| for_initializer	
 	;
 
@@ -3885,7 +3949,7 @@
 	;
 
 opt_for_iterator
-	: /* empty */		{ $$ = EmptyStatement.Value; }
+	: /* empty */		{ $$ = new EmptyStatement (lexer.Location); }
 	| for_iterator
 	;
 
@@ -3914,28 +3978,24 @@
 foreach_statement
 	: FOREACH OPEN_PARENS type IN expression CLOSE_PARENS
 	{
-		Report.Error (230, lexer.Location, "Type and identifier are both required in a foreach statement");
+		Report.Error (230, (Location) $4, "Type and identifier are both required in a foreach statement");
 		$$ = null;
 	}
-	| FOREACH OPEN_PARENS type IDENTIFIER IN 
+	| FOREACH OPEN_PARENS type IDENTIFIER IN expression CLOSE_PARENS 
 	  {
-		oob_stack.Push (lexer.Location);
-	  }
-	  expression CLOSE_PARENS 
-	  {
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
 
@@ -3947,12 +4007,11 @@
 		Block foreach_block = (Block) oob_stack.Pop ();
 		LocalVariableReference v = (LocalVariableReference) oob_stack.Pop ();
 		Block prev_block = (Block) oob_stack.Pop ();
-		Location l = (Location) oob_stack.Pop ();
 
 		current_block = prev_block;
 
 		if (v != null) {
-			Foreach f = new Foreach ((Expression) $3, v, (Expression) $7, (Statement) $10, l);
+			Foreach f = new Foreach ((Expression) $3, v, (Expression) $6, (Statement) $9, (Location) $1);
 			foreach_block.AddStatement (f);
 		}
 
@@ -3972,83 +4031,86 @@
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
@@ -4139,15 +4201,16 @@
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
@@ -4160,18 +4223,20 @@
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
@@ -4206,7 +4271,7 @@
 	: UNSAFE 
 	{
 		if (!RootContext.Unsafe){
-			Report.Error (227, lexer.Location, 
+			Report.Error (227, (Location) $1, 
 				"Unsafe code can only be used if --unsafe is used");
 		}
 	} block {
@@ -4221,7 +4286,7 @@
 	  {
 		ArrayList list = (ArrayList) $4;
 		Expression type = (Expression) $3;
-		Location l = lexer.Location;
+		Location l = (Location) $1;
 		int top = list.Count;
 
 		Block assign_block = new Block (current_block);
@@ -4241,17 +4306,16 @@
 			list [i] = p;
 		}
 
-		oob_stack.Push (l);
 	  }
 	  embedded_statement 
 	  {
-		Location l = (Location) oob_stack.Pop ();
+		Location l = (Location) $1;
 
 		Fixed f = new Fixed ((Expression) $3, (ArrayList) $4, (Statement) $7, l);
 
 		if (RootContext.WarningLevel >= 4){
-			if ($7 == EmptyStatement.Value)
-				Report.Warning (642, lexer.Location, "Possible mistaken empty statement");
+			if ($7 is EmptyStatement)
+				Report.Warning (642, ((Expression) $7).Location, "Possible mistaken empty statement");
 		}
 
 		current_block.AddStatement (f);
@@ -4280,12 +4344,13 @@
 
 fixed_pointer_declarator
 	: IDENTIFIER ASSIGN expression
-	  {	
-		$$ = new Pair ($1, $3);
+	  {
+		LocatedToken lt = (LocatedToken) $1;
+		$$ = new Pair (lt.StringValue, $3);
 	  }
 	| IDENTIFIER
 	  {
-		Report.Error (210, lexer.Location, "You must provide an initializer in a fixed or using statement declaration");
+		Report.Error (210, ((LocatedToken) $1).Location, "You must provide an initializer in a fixed or using statement declaration");
 		$$ = null;
 	  }
 	;
@@ -4297,7 +4362,7 @@
  	  } 
 	  embedded_statement
 	  {
-		$$ = new Lock ((Expression) $3, (Statement) $6, lexer.Location);
+		$$ = new Lock ((Expression) $3, (Statement) $6, (Location) $1);
 	  }
 	;
 
@@ -4307,11 +4372,8 @@
 		Block assign_block = new Block (current_block);
 		current_block = assign_block;
 
-		oob_stack.Push (lexer.Location);
-		
 		if ($3 is DictionaryEntry){
 			DictionaryEntry de = (DictionaryEntry) $3;
-			Location l = lexer.Location;
 
 			Expression type = (Expression) de.Key;
 			ArrayList var_declarators = (ArrayList) de.Value;
@@ -4333,7 +4395,7 @@
 				} else {
 					ArrayList init = (ArrayList) decl.expression_or_array_initializer;
 					if (init == null) {
-						Report.Error (210, l, "You must provide an initializer in a fixed or using statement declaration");
+						Report.Error (210, decl.Location, "You must provide an initializer in a fixed or using statement declaration");
 					}
 					
 					expr = new ArrayCreation (type, "", init, decl.Location);
@@ -4342,7 +4404,7 @@
 				LocalVariableReference var;
 
 				// Get a writable reference to this read-only variable.
-				var = new LocalVariableReference (assign_block, decl.identifier, l, vi, false);
+				var = new LocalVariableReference (assign_block, decl.identifier, decl.Location, vi, false);
 
 				// This is so that it is not a warning on using variables
 				vi.Used = true;
@@ -4357,7 +4419,7 @@
 	  } 
 	  embedded_statement
 	  {
-		Using u = new Using ($3, (Statement) $6, (Location) oob_stack.Pop ());
+		Using u = new Using ($3, (Statement) $6, (Location) $1);
 		current_block.AddStatement (u);
 		while (current_block.Implicit)
 			current_block = current_block.Parent;
@@ -4427,13 +4489,15 @@
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
 
@@ -4500,7 +4564,7 @@
 
 	if (current_container.Name == ""){
 		if (ns != "")
-			return new MemberName (new MemberName (ns), class_name);
+			return new MemberName (new MemberName (ns, class_name.Location), class_name);
 		else
 			return class_name;
 	} else {
@@ -4565,7 +4629,7 @@
 
 		assign = new Assign (var, expr, decl.Location);
 
-		implicit_block.AddStatement (new StatementExpression (assign, lexer.Location));
+		implicit_block.AddStatement (new StatementExpression (assign, assign.Location));
 	}
 	
 	return implicit_block;
@@ -4588,7 +4652,7 @@
 	return implicit_block;
 }
 
-void CheckAttributeTarget (string a)
+void CheckAttributeTarget (string a, Location l)
 {
 	switch (a) {
 
@@ -4596,14 +4660,13 @@
 		return;
 		
 	default :
-		Location l = lexer.Location;
 		Report.Error (658, l, "`" + a + "' is an invalid attribute target");
 		break;
 	}
 
 }
 
-void CheckUnaryOperator (Operator.OpType op)
+void CheckUnaryOperator (Operator.OpType op, Location l)
 {
 	switch (op) {
 		
@@ -4619,14 +4682,13 @@
 		break;
 		
 	default :
-		Location l = lexer.Location;
 		Report.Error (1019, l, "Overloadable unary operator expected"); 
 		break;
 		
 	}
 }
 
-void CheckBinaryOperator (Operator.OpType op)
+void CheckBinaryOperator (Operator.OpType op, Location l)
 {
 	switch (op) {
 		
@@ -4649,7 +4711,6 @@
 		break;
 		
 	default :
-		Location l = lexer.Location;
 		Report.Error (1020, l, "Overloadable binary operator expected");
 		break;
 	}
Index: ChangeLog
===================================================================
--- ChangeLog	(revision 38124)
+++ ChangeLog	(working copy)
@@ -1,3 +1,43 @@
+2004-12-29  Atsushi Enomoto  <atsushi@ximian.com>
+
+	* ecore.cs,
+	  cs-parser.jay : TypeLookupExpression is now instantiable with
+	  Type and Location. Instantiate those type references in parser.
+	* parameter.cs,
+	  class.cs,
+	  delegate.cs,
+	  iterators.cs,
+	  anonymous.cs :
+	  - Now ParameterBase has Location.
+	  - Removed Location from Parameters.
+	* statement.cs,
+	  gen-treedump.cs,
+	  cs-parser.jay : Now EmptyStatement is instantiable to contain
+	  Location. So use type comparison instead of object equality.
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
+	  - Now it stores Location object as a value of IDENTIFIER, keywords
+	    and puncts (is_punct()).
+	* report.cs : Just use Location.ToString() to include column number.
+	* class.cs,
+	  codegen.cs :
+	   : provide column information for SymbolWriter.
+
 2004-12-21  Ben Maurer  <bmaurer@ximian.com>
 
 	* statement.cs (Block.ThisVariable): remove the recursion here, to
Index: anonymous.cs
===================================================================
--- anonymous.cs	(revision 38124)
+++ anonymous.cs	(working copy)
@@ -192,7 +192,7 @@
 						continue;
 					fixedpars [j] = new Parameter (
 						new TypeExpression (invoke_pd.ParameterType (i), loc),
-						"+" + j, invoke_pd.ParameterModifier (i), null);
+						"+" + j, invoke_pd.ParameterModifier (i), null, loc);
 					j++;
 				}
 				
@@ -200,10 +200,10 @@
 				if (params_idx != -1){
 					variable = new Parameter (
 						new TypeExpression (invoke_pd.ParameterType (params_idx), loc),
-						"+" + params_idx, invoke_pd.ParameterModifier (params_idx), null);
+						"+" + params_idx, invoke_pd.ParameterModifier (params_idx), null, loc);
 				}
 
-				Parameters = new Parameters (fixedpars, variable, loc);
+				Parameters = new Parameters (fixedpars, variable);
 			}
 			
 			//
Index: gen-treedump.cs
===================================================================
--- gen-treedump.cs	(revision 38124)
+++ gen-treedump.cs	(working copy)
@@ -448,12 +448,12 @@
 		void GenerateFor (For s)
 		{
 			output ("for (");
-			if (! (s.InitStatement == EmptyStatement.Value))
+			if (! (s.InitStatement is EmptyStatement))
 				GenerateStatement (s.InitStatement, true, true, true);
 			output ("; ");
 			output (GetExpression (s.Test, 0));
 			output ("; ");
-			if (! (s.Increment == EmptyStatement.Value))
+			if (! (s.Increment is EmptyStatement))
 				GenerateStatement (s.Increment, true, true, true);
 			output (") ");
 			GenerateStatement (s.Statement, true, true, false);
@@ -589,7 +589,7 @@
 				output_newline ("break;");
 			else if (s is Continue)
 				output_newline ("continue;");
-			else if (s == EmptyStatement.Value)
+			else if (s is EmptyStatement)
 				output_newline ("/* empty statement */;");
 			else if (s is Block)
 				GenerateBlock ((Block) s, doPlacement, embedded);
Index: codegen.cs
===================================================================
--- codegen.cs	(revision 38124)
+++ codegen.cs	(working copy)
@@ -780,7 +780,7 @@
 			if (check_file && (CurrentFile != loc.File))
 				return;
 
-			CodeGen.SymbolWriter.MarkSequencePoint (ig, loc.Row, 0);
+			CodeGen.SymbolWriter.MarkSequencePoint (ig, loc.Row, loc.Column);
 		}
 
 		public void DefineLocalVariable (string name, LocalBuilder builder)
Index: statement.cs
===================================================================
--- statement.cs	(revision 38124)
+++ statement.cs	(working copy)
@@ -98,9 +98,12 @@
 
 	public sealed class EmptyStatement : Statement {
 		
-		private EmptyStatement () {}
+		public EmptyStatement (Location location)
+		{
+			loc = location;
+		}
 		
-		public static readonly EmptyStatement Value = new EmptyStatement ();
+		public static readonly EmptyStatement Value = new EmptyStatement (Location.Null);
 		
 		public override bool Resolve (EmitContext ec)
 		{
@@ -480,7 +483,7 @@
 			Label loop = ig.DefineLabel ();
 			Label test = ig.DefineLabel ();
 			
-			if (InitStatement != null && InitStatement != EmptyStatement.Value)
+			if (InitStatement != null && !(InitStatement is EmptyStatement))
 				InitStatement.Emit (ec);
 
 			ec.LoopBegin = ig.DefineLabel ();
@@ -491,7 +494,7 @@
 			Statement.Emit (ec);
 
 			ig.MarkLabel (ec.LoopBegin);
-			if (Increment != EmptyStatement.Value)
+			if (!(Increment is EmptyStatement))
 				Increment.Emit (ec);
 
 			ig.MarkLabel (test);
@@ -1948,13 +1951,13 @@
 				Statement s = (Statement) statements [ix];
 
 				if (unreachable && !(s is LabeledStatement)) {
-					if (s == EmptyStatement.Value)
+					if (s is EmptyStatement)
 						s.loc = EndLocation;
 
 					if (!s.ResolveUnreachable (ec, !unreachable_shown))
 						ok = false;
 
-					if (s != EmptyStatement.Value)
+					if (!(s is EmptyStatement))
 						unreachable_shown = true;
 					else
 						s.loc = Location.Null;