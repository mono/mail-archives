? io-fixes.diff
Index: ChangeLog
===================================================================
RCS file: /cvs/public/mcs/class/corlib/System.IO/ChangeLog,v
retrieving revision 1.282
diff -u -r1.282 ChangeLog
--- ChangeLog	15 Jun 2004 17:51:32 -0000	1.282
+++ ChangeLog	21 Jun 2004 01:14:26 -0000
@@ -1,3 +1,11 @@
+2004-06-21  Atsushi Enomoto  <atsushi@ximian.com>
+
+	* FileStream.cs : Check buffer size before creating file.
+	* StreamReader.cs : Check encoding!=null before creating file.
+	* File.cs,
+	  MonoIO.cs : Convert DateTime to FileTime after checking
+	  file IO sharing violation (it just fixes the type of exception).
+
 2004-06-15  Gert Driesen <drieseng@users.sourceforge.net>
 
 	* MemoryStream.cs: added TODO for serialization
Index: File.cs
===================================================================
RCS file: /cvs/public/mcs/class/corlib/System.IO/File.cs,v
retrieving revision 1.29
diff -u -r1.29 File.cs
--- File.cs	14 Jun 2004 13:18:13 -0000	1.29
+++ File.cs	21 Jun 2004 01:14:28 -0000
@@ -328,8 +328,7 @@
 			if (!MonoIO.Exists (path, out error))
 				throw MonoIO.GetException (path, error);
 			
-			if (!MonoIO.SetFileTime (path, creation_time.ToFileTime(),
-						 -1, -1, out error)) {
+			if (!MonoIO.SetCreationTime (path, creation_time, out error)) {
 				throw MonoIO.GetException (path, error);
 			}
 		}
@@ -347,9 +346,7 @@
 			if (!MonoIO.Exists (path, out error))
 				throw MonoIO.GetException (path, error);
 
-			if (!MonoIO.SetFileTime (path, -1,
-						 last_access_time.ToFileTime(), -1,
-						 out error)) {
+			if (!MonoIO.SetLastAccessTime (path, last_access_time, out error)) {
 				throw MonoIO.GetException (path, error);
 			}
 		}
@@ -367,9 +364,7 @@
 			if (!MonoIO.Exists (path, out error))
 				throw MonoIO.GetException (path, error);
 
-			if (!MonoIO.SetFileTime (path, -1, -1,
-						 last_write_time.ToFileTime(),
-						 out error)) {
+			if (!MonoIO.SetLastWriteTime (path, last_write_time, out error)) {
 				throw MonoIO.GetException (path, error);
 			}
 		}
Index: FileStream.cs
===================================================================
RCS file: /cvs/public/mcs/class/corlib/System.IO/FileStream.cs,v
retrieving revision 1.64
diff -u -r1.64 FileStream.cs
--- FileStream.cs	11 Jun 2004 02:02:15 -0000	1.64
+++ FileStream.cs	21 Jun 2004 01:14:28 -0000
@@ -121,6 +121,9 @@
 				throw new ArgumentException ("Name is empty");
 			}
 
+			if (bufferSize <= 0)
+				throw new ArgumentOutOfRangeException ("Positive number required.");
+
 			if (mode < FileMode.CreateNew || mode > FileMode.Append)
 				throw new ArgumentOutOfRangeException ("mode");
 
Index: MonoIO.cs
===================================================================
RCS file: /cvs/public/mcs/class/corlib/System.IO/MonoIO.cs,v
retrieving revision 1.16
diff -u -r1.16 MonoIO.cs
--- MonoIO.cs	11 Jun 2004 02:02:15 -0000	1.16
+++ MonoIO.cs	21 Jun 2004 01:14:28 -0000
@@ -242,6 +242,44 @@
 						long last_write_time,
 						out MonoIOError error)
 		{
+			return SetFileTime (path,
+				0,
+				creation_time,
+				last_access_time,
+				last_write_time,
+				DateTime.MinValue,
+				out error);
+		}
+
+		public static bool SetCreationTime (string path,
+						DateTime dateTime,
+						out MonoIOError error)
+		{
+			return SetFileTime (path, 1, -1, -1, -1, dateTime, out error);
+		}
+
+		public static bool SetLastAccessTime (string path,
+						DateTime dateTime,
+						out MonoIOError error)
+		{
+			return SetFileTime (path, 2, -1, -1, -1, dateTime, out error);
+		}
+
+		public static bool SetLastWriteTime (string path,
+						DateTime dateTime,
+						out MonoIOError error)
+		{
+			return SetFileTime (path, 3, -1, -1, -1, dateTime, out error);
+		}
+
+		public static bool SetFileTime (string path,
+						int type,
+						long creation_time,
+						long last_access_time,
+						long last_write_time,
+						DateTime dateTime,
+						out MonoIOError error)
+		{
 			IntPtr handle;
 			bool result;
 
@@ -250,6 +288,18 @@
 				       FileShare.ReadWrite, false, out error);
 			if (handle == MonoIO.InvalidHandle)
 				return false;
+
+			switch (type) {
+			case 1:
+				creation_time = dateTime.ToFileTime ();
+				break;
+			case 2:
+				last_access_time = dateTime.ToFileTime ();
+				break;
+			case 3:
+				last_write_time = dateTime.ToFileTime ();
+				break;
+			}
 
 			result = SetFileTime (handle, creation_time,
 					      last_access_time,
Index: StreamReader.cs
===================================================================
RCS file: /cvs/public/mcs/class/corlib/System.IO/StreamReader.cs,v
retrieving revision 1.38
diff -u -r1.38 StreamReader.cs
--- StreamReader.cs	11 Jun 2004 02:02:15 -0000	1.38
+++ StreamReader.cs	21 Jun 2004 01:14:28 -0000
@@ -155,6 +155,8 @@
 				throw new ArgumentException("Empty path not allowed");
 			if (path.IndexOfAny (Path.InvalidPathChars) != -1)
 				throw new ArgumentException("path contains invalid characters");
+			if (null == encoding)
+				throw new ArgumentNullException ("encoding");
 			if (buffer_size <= 0)
 				throw new ArgumentOutOfRangeException ("buffer_size", "The minimum size of the buffer must be positive");
 