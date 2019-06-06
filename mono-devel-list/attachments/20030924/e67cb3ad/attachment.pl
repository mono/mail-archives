Index: BufferedStream.cs
===================================================================
RCS file: /mono/mcs/class/corlib/System.IO/BufferedStream.cs,v
retrieving revision 1.8
diff -u -r1.8 BufferedStream.cs
--- BufferedStream.cs	11 Sep 2003 23:44:33 -0000	1.8
+++ BufferedStream.cs	25 Sep 2003 01:54:45 -0000
@@ -180,7 +180,7 @@
 
 			CheckObjectDisposedException ();
 
-			if (!m_stream.CanRead)
+			if (!m_stream.CanWrite)
 				throw new NotSupportedException ();
 			if (offset < 0)
 				throw new ArgumentOutOfRangeException ();
