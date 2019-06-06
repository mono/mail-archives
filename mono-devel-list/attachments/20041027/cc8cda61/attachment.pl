Index: StreamReader.cs
===================================================================
RCS file: /cvs/public/mcs/class/corlib/System.IO/StreamReader.cs,v
retrieving revision 1.40
diff -u -r1.40 StreamReader.cs
--- StreamReader.cs	24 Jun 2004 09:34:12 -0000	1.40
+++ StreamReader.cs	27 Oct 2004 10:20:11 -0000
@@ -337,7 +337,19 @@
 			if (pos >= decoded_count && ReadBuffer () == 0)
 				return -1;
 
-			return decoded_buffer [pos++];
+			// this try-finally is ABCREM optimized version of
+			// "return decoded_buffer [pos++]" .
+			try {
+				if (decoded_buffer.Length > pos)
+					return decoded_buffer [pos];
+				else {
+					pos--;
+					return -1;
+				}
+			} finally {
+				pos++;
+			}
+
 		}
 
 		public override int Read ([In, Out] char[] dest_buffer, int index, int count)