--- mcs/class/System/System.Net/WebConnection.cs.orig	2004-01-21 10:06:06.000000000 +0200
+++ mcs/class/System/System.Net/WebConnection.cs	2004-01-22 21:32:00.000000000 +0200
@@ -289,8 +289,26 @@
 
 				Data.StatusCode = (int) UInt32.Parse (parts [1]);
 				Data.StatusDescription = String.Join (" ", parts, 2, parts.Length - 2);
-				if (pos >= max)
-					return pos;
+
+				if (Data.StatusCode == (int) HttpStatusCode.Continue)
+					lineok = ReadLine (buffer, ref pos, max, ref line);
+
+				if (pos >= max)
+					return pos;
+
+				if (Data.StatusCode == (int) HttpStatusCode.Continue)
+				{
+					lineok = ReadLine (buffer, ref pos, max, ref line);
+					if (!lineok)
+						return -1;
+
+					parts = line.Split (' ');
+					if (parts.Length < 3)
+						return -1;
+
+					Data.StatusCode = (int) UInt32.Parse (parts [1]);
+					Data.StatusDescription = String.Join (" ", parts, 2, parts.Length - 2);
+				}
 			}
 
 			if (readState == ReadState.Status) {