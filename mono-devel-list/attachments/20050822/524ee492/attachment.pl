Index: mcs/driver.cs
===================================================================
--- mcs/driver.cs	(revision 48630)
+++ mcs/driver.cs	(working copy)
@@ -91,16 +91,11 @@
 		static DateTime last_time, first_time;
 
 		//
-		// Encoding: ISO-Latin1 is 28591
+		// Encoding.
 		//
 		static Encoding encoding;
 
-		//
-		// Whether the user has specified a different encoder manually
-		//
-		static bool using_default_encoder = true;
 
-
 		static public void Reset ()
 		{
 			want_debugging_support = false;
@@ -114,7 +109,6 @@
 			defines = null;
 			output_file = null;
 			encoding = null;
-			using_default_encoder = true;
 			first_source = null;
 		}
 
@@ -158,7 +152,7 @@
 			}
 
 			using (input){
-				SeekableStreamReader reader = new SeekableStreamReader (input, encoding, using_default_encoder);
+				SeekableStreamReader reader = new SeekableStreamReader (input, encoding, true);
 				Tokenizer lexer = new Tokenizer (reader, file, defines);
 				int token, tokens = 0, errors = 0;
 
@@ -186,7 +180,7 @@
 				return;
 			}
 
-			SeekableStreamReader reader = new SeekableStreamReader (input, encoding, using_default_encoder);
+			SeekableStreamReader reader = new SeekableStreamReader (input, encoding, true);
 
 			// Check 'MZ' header
 			if (reader.Read () == 77 && reader.Read () == 90) {
@@ -1308,21 +1302,15 @@
 
 				if (value == "utf8"){
 					encoding = new UTF8Encoding();
-					using_default_encoder = false;
 					return true;
 				}
 				if (value == "reset"){
-					//
-					// 28591 is the code page for ISO-8859-1 encoding.
-					//
-					cp = 28591;
-					using_default_encoder = true;
+					cp = Encoding.Default.CodePage;
 				}
 				
 				try {
 					cp = Int32.Parse (value);
 					encoding = Encoding.GetEncoding (cp);
-					using_default_encoder = false;
 				} catch {
 					Report.Error (2016, "Code page `{0}' is invalid or not installed", value);
 				}
@@ -1373,13 +1361,8 @@
 			int i;
 			bool parsing_options = true;
 
-			try {
-				encoding = Encoding.GetEncoding (28591);
-			} catch {
-				Console.WriteLine ("Error: could not load encoding 28591, trying 1252");
-				encoding = Encoding.GetEncoding (1252);
-			}
-			
+			encoding = Encoding.Default;
+
 			references = new ArrayList ();
 			soft_references = new ArrayList ();
 			modules = new ArrayList ();
Index: mcs/support.cs
===================================================================
--- mcs/support.cs	(revision 48630)
+++ mcs/support.cs	(working copy)
@@ -359,36 +359,8 @@
 			// Let the StreamWriter autodetect the encoder
 			reader.Peek ();
 			
-			reader.BaseStream.Position = 0;
 			Encoding enc = reader.CurrentEncoding;
-			// First of all, get at least a char
-			
-			byte[] auxb = new byte [50];
-			int num_bytes = 0;
-			int num_chars = 0;
-			int br = 0;
-			do {
-				br = reader.BaseStream.Read (auxb, num_bytes, auxb.Length - num_bytes);
-				num_bytes += br;
-				num_chars = enc.GetCharCount (auxb, 0, num_bytes);
-			}
-			while (num_chars == 0 && br > 0);
-			
-			if (num_chars != 0)
-			{
-				// Now, check which bytes at the beginning have no effect in the
-				// char count
-				
-				int p = 0;
-				while (enc.GetCharCount (auxb, p, num_bytes-p) >= num_chars)
-					p++;
-				
-				preamble_size = p - 1;
-				reader.BaseStream.Position = 0;
-				reader.DiscardBufferedData ();
-				
-				buffer_start = preamble_size;
-			}
+			preamble_size = (int) reader.BaseStream.Position;
 		}
 
 		public SeekableStreamReader (Stream stream, Encoding encoding, bool detect_encoding_from_bytemarks)
Index: class/corlib/System.Text/UTF8Encoding.cs
===================================================================
--- class/corlib/System.Text/UTF8Encoding.cs	(revision 48630)
+++ class/corlib/System.Text/UTF8Encoding.cs	(working copy)
@@ -426,7 +426,7 @@
 					if (++leftSoFar >= leftSize) {
 						// We have a complete character now.
 						if (leftBits < (uint)0x10000) {
-							if (leftBits != (uint)0xFEFF) {
+//							if (leftBits != (uint)0xFEFF) {
 								// is it an overlong ?
 								bool overlong = false;
 								switch (leftSize) {
@@ -452,7 +452,7 @@
 								}
 								else
 									++length;
-							}
+//							}
 						} else if (leftBits < (uint)0x110000) {
 							length += 2;
 						} else if (throwOnInvalid) {
@@ -571,7 +571,7 @@
 					if (++leftSoFar >= leftSize) {
 						// We have a complete character now.
 						if (leftBits < (uint)0x10000) {
-							if (leftBits != (uint)0xFEFF) {
+//							if (leftBits != (uint)0xFEFF) {
 								// is it an overlong ?
 								bool overlong = false;
 								switch (leftSize) {
@@ -602,7 +602,7 @@
 									}
 									chars[posn++] = (char)leftBits;
 								}
-							}
+//							}
 						} else if (leftBits < (uint)0x110000) {
 							if ((posn + 2) > length) {
 								throw new ArgumentException
