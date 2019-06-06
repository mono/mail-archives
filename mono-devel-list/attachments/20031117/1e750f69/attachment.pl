Index: System.IO/ChangeLog
===================================================================
RCS file: /cvs/public/mcs/class/corlib/System.IO/ChangeLog,v
retrieving revision 1.206
diff -u -r1.206 ChangeLog
--- System.IO/ChangeLog	15 Nov 2003 13:13:45 -0000	1.206
+++ System.IO/ChangeLog	17 Nov 2003 20:45:08 -0000
@@ -1,3 +1,6 @@
+2003-11-17  Jordi Mas i Hernàndez <jmas@softcatala.org>
+	* Directory.cs, added GetLogicalDrives win32 implementation
+
 2003-11-15  Gonzalo Paniagua Javier <gonzalo@ximian.com>
 
 	* Directory.cs:
Index: System.IO/Directory.cs
===================================================================
RCS file: /cvs/public/mcs/class/corlib/System.IO/Directory.cs,v
retrieving revision 1.34
diff -u -r1.34 Directory.cs
--- System.IO/Directory.cs	15 Nov 2003 13:13:45 -0000	1.34
+++ System.IO/Directory.cs	17 Nov 2003 20:45:10 -0000
@@ -6,7 +6,8 @@
 //   Miguel de Icaza (miguel@ximian.com)
 //   Dan Lewis       (dihlewis@yahoo.co.uk)
 //   Eduardo Garcia  (kiwnix@yahoo.es)
-//   Ville Palo      (vi64pa@kolumbus.fi)
+//   Ville Palo      (vi64pa@kolumbus.fi)
+//	 Jordi Mas		 (jmas@softcatala.org)
 //
 // Copyright (C) 2001 Moonlight Enterprises, All Rights Reserved
 // Copyright (C) 2002 Ximian, Inc.
@@ -19,9 +20,16 @@
 using System.Security.Permissions;
 using System.Collections;
 using System.Text;
+using System.Runtime.InteropServices;
 
 namespace System.IO
-{
+{
+	internal class Win32 
+	{
+		[DllImport("kernel32.dll")]
+		internal static extern int GetLogicalDriveStrings(int nSize, IntPtr pointer);		
+	}	
+	
 	public sealed class Directory : Object
 	{
 		private Directory () {}
@@ -213,14 +221,60 @@
 			return GetFileSystemEntries (path, pattern, 0, 0);
 		}
 		
-		[MonoTODO("Implement on windows, for real")]
 		public static string[] GetLogicalDrives ()
-		{ 
-			//FIXME: Hardcoded Paths
-			if ((int)Environment.OSVersion.Platform == 128)
-				return new string[] { "/" };
-			else
-				return new string [] { "A:\\", "C:\\" };
+		{ 					
+			switch((int)Environment.OSVersion.Platform)
+			{
+				case 128: /*System.PlatformID.Unix*/
+					return new string[] { "/" };
+				
+				case (int)PlatformID.Win32Windows:
+				case (int)PlatformID.Win32NT:
+				case (int)PlatformID.Win32S:
+				{										
+  					IntPtr tempBuf;  					
+  					int nDrives  = 0, nOffset = 0, nSize;  							
+  					bool bDrivesLeft = true;  					
+  					char ch = '\0', prev;
+  					
+  					// Get the size of the buffer that we need
+  					nSize = Win32.GetLogicalDriveStrings(0, IntPtr.Zero);  					  					  					
+  					
+  					tempBuf = Marshal.AllocHGlobal(nSize);
+  					Win32.GetLogicalDriveStrings(nSize, tempBuf);
+  					
+  					while (bDrivesLeft)
+  					{  		
+  						prev = ch;		  					
+  						//NOTE: If one day we support win32 unicode builds, this has to be reviewed
+						ch = (char) Marshal.ReadByte (tempBuf, nOffset);
+						
+						if (ch==0 && prev==0) bDrivesLeft = false;
+						
+						if (ch==0 && prev!=0) nDrives++;  			  						  						
+  						nOffset++;
+  					}
+  					
+  					nOffset = 0;
+  					string[] sDrives = new string[nDrives];  					
+  					
+  					for (int nDrive =0; nDrive<nDrives;nOffset++)
+  					{  		
+  						ch = (char) Marshal.ReadByte (tempBuf, nOffset);
+  																								
+						if (ch!=0)						
+  							sDrives[nDrive]+=ch;
+  						else
+  							nDrive++;  						  						
+  					}
+				
+					Marshal.FreeHGlobal(tempBuf);
+					return sDrives;
+				}				
+					
+				default:
+					return new string[] { "/" };
+			}
 		}
 
 		public static DirectoryInfo GetParent (string path)
