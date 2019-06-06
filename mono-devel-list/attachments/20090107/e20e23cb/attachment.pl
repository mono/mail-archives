Index: class/corlib/System.IO/DriveInfo.cs
===================================================================
--- class/corlib/System.IO/DriveInfo.cs	(revision 122667)
+++ class/corlib/System.IO/DriveInfo.cs	(working copy)
@@ -26,6 +26,7 @@
 using System.Collections;
 using System.Text;
 using System.Runtime.Serialization;
+using System.Runtime.CompilerServices;
 using System.Runtime.InteropServices;
 
 namespace System.IO {
@@ -36,6 +37,9 @@
 		DriveType drive_type;
 		string drive_format;
 		string path;
+		long availableFreeSpace;
+		long totalFreeSpace;
+		long totalSize;
 
 		DriveInfo (_DriveType _drive_type, string path, string fstype)
 		{
@@ -44,6 +48,8 @@
 			this.path = path;
 
 			this.drive_type = ToDriveType (_drive_type, fstype);
+
+			GetDiskFreeSpace ();
 		}
 
 		public DriveInfo (string driveName)
@@ -57,6 +63,7 @@
 					this.drive_format = d.drive_format;
 					this.path = d.path;
 					this._drive_type = d._drive_type;
+					GetDiskFreeSpace ();
 					return;
 				}
 			}
@@ -69,28 +76,21 @@
 			Windows,
 		}
 		
-		[MonoTODO("Always returns infinite")]
 		public long AvailableFreeSpace {
 			get {
-				if (DriveType == DriveType.CDRom || DriveType == DriveType.Ram || DriveType == DriveType.Unknown)
-					return 0;
-				return Int64.MaxValue;
+				return availableFreeSpace;
 			}
 		}
 
-		[MonoTODO("Always returns infinite")]
 		public long TotalFreeSpace {
 			get {
-				if (DriveType == DriveType.CDRom || DriveType == DriveType.Ram || DriveType == DriveType.Unknown)
-					return 0;
-				return Int64.MaxValue;
+				return totalFreeSpace;
 			}
 		}
 
-		[MonoTODO("Always returns infinite")]
 		public long TotalSize {
 			get {
-				return Int64.MaxValue;
+				return totalSize;
 			}
 		}
 
@@ -273,6 +273,32 @@
 		{
 			return(Name);
 		}
+
+		void GetDiskFreeSpace ()
+		{
+			ulong freeBytesAvail;
+			ulong totalNumberOfBytes;
+			ulong totalNumberOfFreeBytes;
+			MonoIOError error;
+
+			if (!GetDiskFreeSpaceInternal (path, out freeBytesAvail, out totalNumberOfBytes,
+						       out totalNumberOfFreeBytes, out error))
+			{
+				throw MonoIO.GetException (path, error);
+			}
+
+			availableFreeSpace = freeBytesAvail > long.MaxValue ?
+				long.MaxValue : (long)freeBytesAvail;
+			totalFreeSpace = totalNumberOfFreeBytes > long.MaxValue ?
+				long.MaxValue : (long)totalNumberOfFreeBytes;
+			totalSize = totalNumberOfBytes > long.MaxValue ?
+				long.MaxValue : (long)totalNumberOfBytes;
+		}
+
+		[MethodImplAttribute (MethodImplOptions.InternalCall)]
+		extern static bool GetDiskFreeSpaceInternal (string directoryName, out ulong freeBytesAvail,
+							     out ulong totalNumberOfBytes, out ulong totalNumberOfFreeBytes,
+							     out MonoIOError error);
 	}
 }
 
Index: class/corlib/System.IO/ChangeLog
===================================================================
--- class/corlib/System.IO/ChangeLog	(revision 122667)
+++ class/corlib/System.IO/ChangeLog	(working copy)
@@ -1,3 +1,8 @@
+2009-01-07  Christian Prochnow  <cproch@seculogix.de>
+
+	* DriveInfo.cs: Added GetDiskFreeSpace, GetDiskFreeSpaceInternal
+	for querying drive size and free space.
+
 2008-12-20  Miguel de Icaza  <miguel@novell.com>
 
 	* FileStream.cs: Found while debugging webcompare, we should add
