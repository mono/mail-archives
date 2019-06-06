? stringreaderread.diff
Index: StringReader.cs
===================================================================
RCS file: /cvs/public/mcs/class/corlib/System.IO/StringReader.cs,v
retrieving revision 1.19
diff -u -r1.19 StringReader.cs
--- StringReader.cs	5 Sep 2004 17:27:23 -0000	1.19
+++ StringReader.cs	27 Oct 2004 09:26:28 -0000
@@ -64,23 +64,29 @@
 
 		public override int Peek() {
 
-			CheckObjectDisposedException ();
+			if (source == null)
+				CheckObjectDisposedException ();
 
-			if( nextChar >= sourceLength ) {
+			if (nextChar >= sourceLength)
 				return -1;
-			} else {
-				return (int)source[ nextChar ];
-			}
+			else
+				return source [nextChar];
 		}
 
 		public override int Read() {
 
-			CheckObjectDisposedException ();
+			if (source == null)
+				CheckObjectDisposedException ();
 
-			if( nextChar >= sourceLength ) {
-				return -1;
-			} else {
-				return (int)source[ nextChar++ ];
+			try {
+				if (nextChar >= sourceLength) {
+					nextChar--;
+					return -1;
+				}
+				else
+					return source [nextChar];
+			} finally {
+				nextChar++;
 			}
 		}
 
@@ -92,7 +98,8 @@
 
 		public override int Read ([In, Out] char[] buffer, int index, int count)
 		{
-			CheckObjectDisposedException ();
+			if (source == null)
+				CheckObjectDisposedException ();
 
 			if (buffer == null)
 				throw new ArgumentNullException ("buffer");