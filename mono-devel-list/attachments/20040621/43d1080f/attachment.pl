Index: System.IO/ChangeLog
===================================================================
RCS file: /cvs/public/mcs/class/corlib/System.IO/ChangeLog,v
retrieving revision 1.283
diff -u -r1.283 ChangeLog
--- System.IO/ChangeLog	21 Jun 2004 13:30:46 -0000	1.283
+++ System.IO/ChangeLog	21 Jun 2004 13:46:59 -0000
@@ -1,5 +1,10 @@
 2004-06-21  Atsushi Enomoto  <atsushi@ximian.com>
 
+	* FileStream.cs :
+	  .ctor() should block write access when created with FileAccess.Write.
+
+2004-06-21  Atsushi Enomoto  <atsushi@ximian.com>
+
 	* FileStream.cs : Check buffer size before creating file.
 	* StreamReader.cs : Check encoding!=null before creating file.
 	* File.cs,
Index: System.IO/FileStream.cs
===================================================================
RCS file: /cvs/public/mcs/class/corlib/System.IO/FileStream.cs,v
retrieving revision 1.65
diff -u -r1.65 FileStream.cs
--- System.IO/FileStream.cs	21 Jun 2004 13:30:46 -0000	1.65
+++ System.IO/FileStream.cs	21 Jun 2004 13:46:59 -0000
@@ -103,7 +103,7 @@
 			: this (name, mode, (mode == FileMode.Append ? FileAccess.Write : FileAccess.ReadWrite), FileShare.Read, DefaultBufferSize, false) { }
 
 		public FileStream (string name, FileMode mode, FileAccess access)
-			: this (name, mode, access, FileShare.ReadWrite, DefaultBufferSize, false) { }
+			: this (name, mode, access, access == FileAccess.Write ? FileShare.None : FileShare.Read, DefaultBufferSize, false) { }
 
 		public FileStream (string name, FileMode mode, FileAccess access, FileShare share)
 			: this (name, mode, access, share, DefaultBufferSize, false) { }
Index: Test/System.IO/ChangeLog
===================================================================
RCS file: /cvs/public/mcs/class/corlib/Test/System.IO/ChangeLog,v
retrieving revision 1.116
diff -u -r1.116 ChangeLog
--- Test/System.IO/ChangeLog	21 Jun 2004 13:46:04 -0000	1.116
+++ Test/System.IO/ChangeLog	21 Jun 2004 13:46:59 -0000
@@ -1,5 +1,9 @@
 2004-06-21  Atsushi Enomoto  <atsushi@ximian.com>
 
+	* FileStreamTest.cs : Added some tests on .ctor() without FileShare.
+
+2004-06-21  Atsushi Enomoto  <atsushi@ximian.com>
+
 	  FileInfoTest.cs : more '/' and Path.DirectorySeparatorChar fixes
 
 2004-06-21  Atsushi Enomoto  <atsushi@ximian.com>
Index: Test/System.IO/FileStreamTest.cs
===================================================================
RCS file: /cvs/public/mcs/class/corlib/Test/System.IO/FileStreamTest.cs,v
retrieving revision 1.22
diff -u -r1.22 FileStreamTest.cs
--- Test/System.IO/FileStreamTest.cs	21 Jun 2004 13:42:39 -0000	1.22
+++ Test/System.IO/FileStreamTest.cs	21 Jun 2004 13:46:59 -0000
@@ -326,6 +326,68 @@
 		}
 
 		[Test]
+		public void CtorAccess1Read2Read ()
+		{
+			FileStream fs = null;
+			FileStream fs2 = null;
+			try {
+				if (!File.Exists ("temp")) {
+					TextWriter tw = File.CreateText ("temp");
+					tw.Write ("FOO");
+					tw.Close ();
+				}
+				fs = new FileStream ("temp", FileMode.Open, FileAccess.Read);
+				fs2 = new FileStream ("temp", FileMode.Open, FileAccess.Read);
+			} finally {
+				if (fs != null)
+					fs.Close ();
+				if (fs2 != null)
+					fs2.Close ();
+				if (File.Exists ("temp"))
+					File.Delete ("temp");
+			}
+		}
+
+		[Test]
+		[ExpectedException (typeof (IOException))]
+		public void CtorAccess1Read2Write ()
+		{
+			FileStream fs = null;
+			try {
+				if (!File.Exists ("temp")) {
+					using (TextWriter tw = File.CreateText ("temp")) {
+						tw.Write ("FOO");
+					}
+				}
+				fs = new FileStream ("temp", FileMode.Open, FileAccess.Read);
+				fs = new FileStream ("temp", FileMode.Create, FileAccess.Write);
+			} finally {
+				if (fs != null)
+					fs.Close ();
+				if (File.Exists ("temp"))
+					File.Delete ("temp");
+			}
+		}
+
+		[Test]
+		[ExpectedException (typeof (IOException))]
+		public void CtorAccess1Write2Write ()
+		{
+			FileStream fs = null;
+			try {
+				if (File.Exists ("temp"))
+					File.Delete ("temp");
+				fs = new FileStream ("temp", FileMode.Create, FileAccess.Write);
+				fs = new FileStream ("temp", FileMode.Create, FileAccess.Write);
+			} finally {
+				if (fs != null)
+					fs.Close ();
+				if (File.Exists ("temp"))
+					File.Delete ("temp");
+			}
+		}
+
+		[Test]
 		public void Write ()
 		{
 			string path = TempFolder + DSC + "FileStreamTest.Write";
