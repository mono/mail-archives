Index: support.cs
===================================================================
--- support.cs	(revision 49060)
+++ support.cs	(working copy)
@@ -344,6 +344,7 @@
 		}
 	}
 
+/*
 	/// <summary>
 	///   This is a wrapper around StreamReader which is seekable.
 	/// </summary>
@@ -442,6 +443,7 @@
 			return buffer [pos++];
 		}
 	}
+*/
 
 	public class DoubleHash {
 		const int DEFAULT_INITIAL_BUCKETS = 100;
Index: cs-tokenizer.cs
===================================================================
--- cs-tokenizer.cs	(revision 49060)
+++ cs-tokenizer.cs	(working copy)
@@ -31,7 +31,7 @@
 
 	public class Tokenizer : yyParser.yyInput
 	{
-		SeekableStreamReader reader;
+		StreamReader reader;
 		SourceFile ref_name;
 		SourceFile file_name;
 		int ref_line = 1;
@@ -45,6 +45,8 @@
 		Location current_location;
 		Location current_comment_location = Location.Null;
 		ArrayList escapedIdentifiers = new ArrayList ();
+		SavedToken saved_token = SavedToken.Null;
+		bool putback_ambiguous_close_parens = false;
 
 		//
 		// XML documentation buffer. The save point is used to divide
@@ -385,7 +387,7 @@
 			defines [def] = true;
 		}
 		
-		public Tokenizer (SeekableStreamReader input, SourceFile file, ArrayList defs)
+		public Tokenizer (StreamReader input, SourceFile file, ArrayList defs)
 		{
 			this.ref_name = file;
 			this.file_name = file;
@@ -467,19 +469,11 @@
 
 				--deambiguate_close_parens;
 
-				// Save current position and parse next token.
-				int old = reader.Position;
-				int old_ref_line = ref_line;
-				int old_col = col;
-
-				// disable preprocessing directives when peeking
-				process_directives = false;
+				// Save next token.
+				Location cur_loc = current_location;
 				int new_token = token ();
-				process_directives = true;
-				reader.Position = old;
-				ref_line = old_ref_line;
-				col = old_col;
-				putback_char = -1;
+				saved_token = new SavedToken (new_token, val, Location);
+				current_location = cur_loc;
 
 				if (new_token == Token.OPEN_PARENS)
 					return Token.CLOSE_PARENS_OPEN_PARENS;
@@ -658,7 +652,7 @@
 
 		public void Deambiguate_CloseParens ()
 		{
-			putback (')');
+			putback_ambiguous_close_parens = true;
 			deambiguate_close_parens++;
 		}
 
@@ -1087,6 +1081,10 @@
 		int getChar ()
 		{
 			int x;
+			if (putback_ambiguous_close_parens) {
+				putback_ambiguous_close_parens = false;
+				return ')';
+			}
 			if (putback_char != -1) {
 				x = putback_char;
 				putback_char = -1;
@@ -1106,6 +1104,8 @@
 
 		int peekChar ()
 		{
+			if (putback_ambiguous_close_parens)
+				return ')';
 			if (putback_char != -1)
 				return putback_char;
 			putback_char = reader.Read ();
@@ -1114,6 +1114,8 @@
 
 		int peekChar2 ()
 		{
+			if (putback_ambiguous_close_parens)
+				return ')';
 			if (putback_char != -1)
 				return putback_char;
 			return reader.Peek ();
@@ -1202,7 +1204,14 @@
 
 		public int token ()
                 {
-			current_token = xtoken ();
+			if (!saved_token.Location.IsNull) {
+				current_token = saved_token.Token;
+				val = saved_token.Value;
+				current_location = saved_token.Location;
+				saved_token = SavedToken.Null;
+			}
+			else
+				current_token = xtoken ();
                         return current_token;
                 }
 
@@ -1844,29 +1853,21 @@
 			}
 
 			if (res == Token.PARTIAL) {
-				// Save current position and parse next token.
-				int old = reader.Position;
-				int old_putback = putback_char;
-				int old_ref_line = ref_line;
-				int old_col = col;
-
-				putback_char = -1;
-
+				// Save next token.
+				Location cur_loc = Location;
 				int next_token = token ();
+				saved_token = new SavedToken (next_token, val, Location);
+				current_location = cur_loc;
 				bool ok = (next_token == Token.CLASS) ||
 					(next_token == Token.STRUCT) ||
 					(next_token == Token.INTERFACE) ||
 					(next_token == Token.ENUM); // "partial" is a keyword in 'partial enum', even though it's not valid
 
-				reader.Position = old;
-				ref_line = old_ref_line;
-				col = old_col;
-				putback_char = old_putback;
-
 				if (ok)
 					return res;
 				else {
 					val = new LocatedToken (Location, "partial");
+					saved_token = SavedToken.Null;
 					return Token.IDENTIFIER;
 				}
 			}
@@ -2309,6 +2310,23 @@
 			}
 				
 		}
+
+		public struct SavedToken
+		{
+			public static readonly SavedToken Null =
+				new SavedToken (0, null, Location.Null);
+
+			public readonly int Token;
+			public readonly object Value;
+			public readonly Location Location;
+
+			public SavedToken (int token, object value, Location loc)
+			{
+				Token = token;
+				Value = value;
+				Location = loc;
+			}
+		}
 	}
 
 	//
Index: cs-parser.jay
===================================================================
--- cs-parser.jay	(revision 49060)
+++ cs-parser.jay	(working copy)
@@ -4856,7 +4856,7 @@
 	}
 }		   
 
-public CSharpParser (SeekableStreamReader reader, SourceFile file, ArrayList defines)
+public CSharpParser (StreamReader reader, SourceFile file, ArrayList defines)
 {
 	current_namespace = new NamespaceEntry (null, file, null, Location.Null);
 	this.name = file.Name;
Index: driver.cs
===================================================================
--- driver.cs	(revision 49060)
+++ driver.cs	(working copy)
@@ -153,7 +153,7 @@
 			}
 
 			using (input){
-				SeekableStreamReader reader = new SeekableStreamReader (input, encoding);
+				StreamReader reader = new StreamReader (input, encoding, true);
 				Tokenizer lexer = new Tokenizer (reader, file, defines);
 				int token, tokens = 0, errors = 0;
 
@@ -181,16 +181,16 @@
 				return;
 			}
 
-			SeekableStreamReader reader = new SeekableStreamReader (input, encoding);
-
 			// Check 'MZ' header
-			if (reader.Read () == 77 && reader.Read () == 90) {
+			if (input.ReadByte () == 77 && input.ReadByte () == 90) {
 				Report.Error (2015, "Source file `{0}' is a binary file and not a text file", file.Name);
 				input.Close ();
 				return;
 			}
+			input.Position = 0;
 
-			reader.Position = 0;
+			StreamReader reader = new StreamReader (input, encoding, true);
+
 			parser = new CSharpParser (reader, file, defines);
 			parser.ErrorOutput = Report.Stderr;
 			try {