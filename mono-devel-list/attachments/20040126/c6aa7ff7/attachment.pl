--- WebConnection.cs	2004-01-26 15:04:53.000000000 +0200
+++ WebConnection.cs	2004-01-26 15:14:56.000000000 +0200
@@ -269,67 +269,81 @@
 			int pos = 0;
 			string line = null;
 			bool lineok = false;
-			
-			if (readState == ReadState.None) {
-				lineok = ReadLine (buffer, ref pos, max, ref line);
-				if (!lineok)
-					return -1;
-
-				readState = ReadState.Status;
-
-				string [] parts = line.Split (' ');
-				if (parts.Length < 3)
-					return -1;
+			bool isContinue = false;
+			do {
+				if (readState == ReadState.None) {
+					lineok = ReadLine (buffer, ref pos, max, ref line);
+					if (!lineok)
+						return -1;
+
+					readState = ReadState.Status;
+
+					string [] parts = line.Split (' ');
+					if (parts.Length < 3)
+						return -1;
 
-				if (String.Compare (parts [0], "HTTP/1.1", true) == 0) {
-					Data.Version = HttpVersion.Version11;
-				} else {
-					Data.Version = HttpVersion.Version10;
+					if (String.Compare (parts [0], "HTTP/1.1", true) == 0) {
+						Data.Version = HttpVersion.Version11;
+					} else {
+						Data.Version = HttpVersion.Version10;
+					}
+
+					Data.StatusCode = (int) UInt32.Parse (parts [1]);
+					Data.StatusDescription = String.Join (" ", parts, 2, parts.Length - 2);
+
+					if (pos >= max)
+						return pos;
+
 				}
 
-				Data.StatusCode = (int) UInt32.Parse (parts [1]);
-				Data.StatusDescription = String.Join (" ", parts, 2, parts.Length - 2);
-				if (pos >= max)
-					return pos;
-			}
-
-			if (readState == ReadState.Status) {
-				readState = ReadState.Headers;
-				Data.Headers = new WebHeaderCollection ();
-				ArrayList headers = new ArrayList ();
-				bool finished = false;
-				while (!finished) {
-					if (ReadLine (buffer, ref pos, max, ref line) == false)
-						break;
+				if (readState == ReadState.Status) {
+					readState = ReadState.Headers;
+					Data.Headers = new WebHeaderCollection ();
+					ArrayList headers = new ArrayList ();
+					bool finished = false;
+					while (!finished) {
+						if (ReadLine (buffer, ref pos, max, ref line) == false)
+							break;
 					
-					if (line == null) {
-						// Empty line: end of headers
-						finished = true;
-						continue;
-					}
+						if (line == null) {
+							// Empty line: end of headers
+							finished = true;
+							continue;
+						}
 					
-					if (line.Length > 0 && (line [0] == ' ' || line [0] == '\t')) {
-						int count = headers.Count - 1;
-						if (count < 0)
-							break;
-
-						string prev = (string) headers [count] + line;
-						headers [count] = prev;
-					} else {
-						headers.Add (line);
+						if (line.Length > 0 && (line [0] == ' ' || line [0] == '\t')) {
+							int count = headers.Count - 1;
+							if (count < 0)
+								break;
+
+							string prev = (string) headers [count] + line;
+							headers [count] = prev;
+						} else {
+							headers.Add (line);
+						}
 					}
-				}
 
-				if (!finished) {
-					// handle the error...
-				} else {
-					foreach (string s in headers)
-						Data.Headers.Add (s);
+					if (!finished) {
+						// handle the error...
+					} else {
+						foreach (string s in headers)
+							Data.Headers.Add (s);
 
-					readState = ReadState.Content;
-					return pos;
+						if (Data.StatusCode == (int) HttpStatusCode.Continue) {
+							if (pos >= max)
+								return pos;
+							if (Data.request.ExpectContinue)
+								Data.request.DoContinueDelegate (Data.StatusCode, Data.Headers);
+							readState = ReadState.None;
+							isContinue = true;
+						}
+						else {
+							readState = ReadState.Content;
+							return pos;
+						}
+					}
 				}
-			}
+			} while (isContinue == true);
 
 			return -1;
 		}
