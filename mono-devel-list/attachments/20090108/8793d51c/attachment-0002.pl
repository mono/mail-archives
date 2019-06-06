Index: class/corlib/System.IO/DriveInfo.cs
===================================================================
--- class/corlib/System.IO/DriveInfo.cs	(revision 122757)
+++ class/corlib/System.IO/DriveInfo.cs	(working copy)
@@ -26,6 +26,7 @@
 using System.Collections;
 using System.Text;
 using System.Runtime.Serialization;
+using System.Runtime.CompilerServices;
 using System.Runtime.InteropServices;
 
 namespace System.IO {
@@ -33,7 +34,6 @@
 	[ComVisibleAttribute(true)] 
 	public sealed class DriveInfo : ISerializable {
 		_DriveType _drive_type;
-		DriveType drive_type;
 		string drive_format;
 		string path;
 
@@ -42,8 +42,6 @@
 			this._drive_type = _drive_type;
 			this.drive_format = fstype;
 			this.path = path;
-
-			this.drive_type = ToDriveType (_drive_type, fstype);
 		}
 
 		public DriveInfo (string driveName)
@@ -53,10 +51,8 @@
 			foreach (DriveInfo d in drives){
 				if (d.path == driveName){
 					this.path = d.path;
-					this.drive_type = d.drive_type;
 					this.drive_format = d.drive_format;
 					this.path = d.path;
-					this._drive_type = d._drive_type;
 					return;
 				}
 			}
@@ -69,28 +65,57 @@
 			Windows,
 		}
 		
-		[MonoTODO("Always returns infinite")]
 		public long AvailableFreeSpace {
 			get {
-				if (DriveType == DriveType.CDRom || DriveType == DriveType.Ram || DriveType == DriveType.Unknown)
-					return 0;
-				return Int64.MaxValue;
+				ulong availableFreeSpace;
+				ulong totalSize;
+				ulong totalFreeSpace;
+				MonoIOError error;
+
+				if (!GetDiskFreeSpaceInternal (path, out availableFreeSpace, out totalSize,
+							       out totalFreeSpace, out error))
+				{
+					throw MonoIO.GetException (path, error);
+				}
+
+				return availableFreeSpace > long.MaxValue ?
+					long.MaxValue : (long) availableFreeSpace;
 			}
 		}
 
-		[MonoTODO("Always returns infinite")]
 		public long TotalFreeSpace {
 			get {
-				if (DriveType == DriveType.CDRom || DriveType == DriveType.Ram || DriveType == DriveType.Unknown)
-					return 0;
-				return Int64.MaxValue;
+				ulong availableFreeSpace;
+				ulong totalSize;
+				ulong totalFreeSpace;
+				MonoIOError error;
+
+				if (!GetDiskFreeSpaceInternal (path, out availableFreeSpace, out totalSize,
+							       out totalFreeSpace, out error))
+				{
+					throw MonoIO.GetException (path, error);
+				}
+
+				return totalFreeSpace > long.MaxValue ?
+					long.MaxValue : (long) totalFreeSpace;
 			}
 		}
 
-		[MonoTODO("Always returns infinite")]
 		public long TotalSize {
 			get {
-				return Int64.MaxValue;
+				ulong availableFreeSpace;
+				ulong totalSize;
+				ulong totalFreeSpace;
+				MonoIOError error;
+
+				if (!GetDiskFreeSpaceInternal (path, out availableFreeSpace, out totalSize,
+							       out totalFreeSpace, out error))
+				{
+					throw MonoIO.GetException (path, error);
+				}
+
+				return totalSize > long.MaxValue ?
+					long.MaxValue : (long) totalSize;
 			}
 		}
 
@@ -113,52 +138,9 @@
 			}
 		}
 
-		static DriveType ToDriveType (_DriveType drive_type, string drive_format)
-		{
-			if (drive_type == _DriveType.Linux){
-				switch (drive_format){
-				case "tmpfs":
-				case "ramfs":
-					return DriveType.Ram;
-				case "iso9660":
-					return DriveType.CDRom;
-				case "ext2":
-				case "ext3":
-				case "sysv":
-				case "reiserfs":
-				case "ufs":
-				case "vfat":
-				case "udf":
-				case "hfs":
-				case "hpfs":
-				case "qnx4":
-					return DriveType.Fixed;
-				case "smbfs":
-				case "fuse":
-				case "nfs":
-				case "nfs4":
-				case "cifs":
-				case "ncpfs":
-				case "coda":
-				case "afs":
-					return DriveType.Network;
-				case "proc":
-				case "sysfs":
-				case "debugfs":
-				case "devpts":
-				case "securityfs":
-					return DriveType.Ram;
-				default:
-					return DriveType.Unknown;
-				}
-			} else {
-				return DriveType.Fixed;
-			}
-		}
-		
 		public DriveType DriveType {
 			get {
-				return drive_type;
+				return (DriveType) GetDriveTypeInternal (path);
 			}
 		}
 
@@ -273,6 +255,14 @@
 		{
 			return(Name);
 		}
+
+		[MethodImplAttribute (MethodImplOptions.InternalCall)]
+		extern static bool GetDiskFreeSpaceInternal (string pathName, out ulong freeBytesAvail,
+							     out ulong totalNumberOfBytes, out ulong totalNumberOfFreeBytes,
+							     out MonoIOError error);
+
+		[MethodImplAttribute (MethodImplOptions.InternalCall)]
+		extern static uint GetDriveTypeInternal (string rootPathName);
 	}
 }
 
Index: class/corlib/System.IO/ChangeLog
===================================================================
--- class/corlib/System.IO/ChangeLog	(revision 122757)
+++ class/corlib/System.IO/ChangeLog	(working copy)
@@ -1,3 +1,9 @@
+2009-01-08  Christian Prochnow  <cproch@seculogix.de>
+
+	* DriveInfo.cs: Added GetDiskFreeSpaceInternal
+	to query drive size and free space.
+	Added GetDriveTypeInternal to query type of drive.
+
 2008-12-20  Miguel de Icaza  <miguel@novell.com>
 
 	* FileStream.cs: Found while debugging webcompare, we should add
