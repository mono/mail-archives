Index: Directory.cs
===================================================================
RCS file: /cvs/public/mcs/class/corlib/System.IO/Directory.cs,v
retrieving revision 1.45
diff -u -r1.45 Directory.cs
--- Directory.cs	27 May 2004 16:25:27 -0000	1.45
+++ Directory.cs	31 May 2004 16:37:03 -0000
@@ -131,19 +131,23 @@
 
 		public static bool Exists (string path)
 		{
-			if (path == null)
-				return false;
+			try {
+				if (path == null)
+					return false;
 				
-			MonoIOError error;
-			bool exists;
+				MonoIOError error;
+				bool exists;
 			
-			exists = MonoIO.ExistsDirectory (path, out error);
-			if (error != MonoIOError.ERROR_SUCCESS &&
-			    error != MonoIOError.ERROR_PATH_NOT_FOUND) {
-				throw MonoIO.GetException (path, error);
-			}
+				exists = MonoIO.ExistsDirectory (path, out error);
+				if (error != MonoIOError.ERROR_SUCCESS &&
+				    error != MonoIOError.ERROR_PATH_NOT_FOUND) {
+					throw MonoIO.GetException (path, error);
+				}
 
-			return(exists);
+				return(exists);
+			} catch (Exception) {
+				return false;
+			}
 		}
 
 		public static DateTime GetLastAccessTime (string path)
Index: File.cs
===================================================================
RCS file: /cvs/public/mcs/class/corlib/System.IO/File.cs,v
retrieving revision 1.25
diff -u -r1.25 File.cs
--- File.cs	27 May 2004 16:25:27 -0000	1.25
+++ File.cs	31 May 2004 16:37:03 -0000
@@ -129,26 +129,30 @@
 
 		public static bool Exists (string path)
 		{
-			// For security reasons no exceptions are
-			// thrown, only false is returned if there is
-			// any problem with the path or permissions.
-			// Minimizes what information can be
-			// discovered by using this method.
-			if (null == path || String.Empty == path.Trim()
-			    || path.IndexOfAny(Path.InvalidPathChars) >= 0) {
-				return false;
-			}
+			try {
+				// For security reasons no exceptions are
+				// thrown, only false is returned if there is
+				// any problem with the path or permissions.
+				// Minimizes what information can be
+				// discovered by using this method.
+				if (null == path || String.Empty == path.Trim()
+				    || path.IndexOfAny(Path.InvalidPathChars) >= 0) {
+					return false;
+				}
 
-			MonoIOError error;
-			bool exists;
+				MonoIOError error;
+				bool exists;
 			
-			exists = MonoIO.ExistsFile (path, out error);
-			if (error != MonoIOError.ERROR_SUCCESS &&
-			    error != MonoIOError.ERROR_FILE_NOT_FOUND) {
-				throw MonoIO.GetException (path, error);
-			}
+				exists = MonoIO.ExistsFile (path, out error);
+				if (error != MonoIOError.ERROR_SUCCESS &&
+				    error != MonoIOError.ERROR_FILE_NOT_FOUND) {
+					throw MonoIO.GetException (path, error);
+				}
 
-			return(exists);
+				return(exists);
+			} catch (Exception) {
+				return false;
+			}
 		}
 
 		public static FileAttributes GetAttributes (string path)