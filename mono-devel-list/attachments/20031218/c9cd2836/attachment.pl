Index: Path.cs
===================================================================
RCS file: /cvs/public/mcs/class/corlib/System.IO/Path.cs,v
retrieving revision 1.34
diff -u -r1.34 Path.cs
--- Path.cs	12 Dec 2003 07:26:48 -0000	1.34
+++ Path.cs	17 Dec 2003 16:34:15 -0000
@@ -128,8 +128,9 @@
 			int iExt = findExtension (path);
 
 			if (iExt > -1)
-			{	// okay it has an extension
-				return path.Substring (iExt);
+			{
+				if (iExt < path.Length - 1)
+					return path.Substring (iExt);
 			}
 			return string.Empty;
 		}
@@ -160,10 +161,23 @@
 				throw (new ArgumentNullException (
 					"path",
 					"You must specify a path when calling System.IO.Path.GetFullPath"));
-			
+
 			if (path.Trim () == String.Empty)
 				throw new ArgumentException ("The path is not of a legal form", "path");
 
+			if (path.Length >= 2 &&
+				IsDsc (path [0]) &&
+				IsDsc (path [1])
+			) {
+				if (path.Length == 2 || path.IndexOf (path [0], 2) < 0)
+					throw new ArgumentException ("UNC pass should be of the form \\\\server\\share.");
+				else
+					if (path [0] == DirectorySeparatorChar)
+						return path; // UNC
+					else
+						return path.Replace (AltDirectorySeparatorChar, DirectorySeparatorChar);
+			}
+
 			if (!IsPathRooted (path))
 				path = Directory.GetCurrentDirectory () + DirectorySeparatorStr + path;
 			
@@ -181,24 +195,33 @@
 			
 			if (DirectorySeparatorChar == '/') {
 				// UNIX
-				return IsDsc (path [0]) ? DirectorySeparatorChar.ToString () : String.Empty;
+				return IsDsc (path [0]) ? DirectorySeparatorStr : String.Empty;
 			} else {
 				// Windows
 				int len = 2;
-				
-				if (path.Length <= 2) return String.Empty;
-					
+
+				if (path.Length == 1 && IsDsc (path [0]))
+					return DirectorySeparatorStr;
+				else if (path.Length < 2)
+					return String.Empty;
+
 				if (IsDsc (path [0]) && IsDsc (path[1])) {
 					// UNC: \\server or \\server\share
 					// Get server
 					while (len < path.Length && !IsDsc (path [len])) len++;
 					// Get share
-					while (len < path.Length && !IsDsc (path [len])) len++;				
+					while (len < path.Length && !IsDsc (path [len])) len++;
+					return DirectorySeparatorStr +
+						DirectorySeparatorStr +
+						path.Substring (2);
+				} else if (IsDsc (path [0])) {
+					// path starts with '\' or '/'
+					return DirectorySeparatorStr;
 				} else if (path[1] == VolumeSeparatorChar) {
 					// C:\folder
 					if (path.Length >= 3 && (IsDsc (path [2]))) len++;
-				}
-				
+				} else
+					return Directory.GetCurrentDirectory ().Substring (0, 2);// + path.Substring (0, len);
 				return path.Substring (0, len);
 			}
 		}
@@ -243,11 +266,11 @@
 
 		public static bool HasExtension (string path)
 		{  
-			CheckArgument.Null (path);
-			CheckArgument.Empty (path);
-			CheckArgument.WhitespaceOnly (path);
-			
-			return findExtension (path) > -1;
+			if (path == null || path.Trim () == String.Empty)
+				return false;
+
+			int pos = findExtension (path);
+			return 0 <= pos && pos < path.Length - 1;
 		}
 
 		public static bool IsPathRooted (string path)
@@ -310,7 +333,7 @@
 			
 			// STEP 2: Check to see if this is only a root
 			string root = GetPathRoot (path);
-			if (root == path) return path;
+//			if (root == path) return path; // it will return '\' for path '\', while it should return 'c:\' or so.
 				
 			// STEP 3: split the directories, this gets rid of consecutative "/"'s
 			string [] dirs = path.Split (DirectorySeparatorChar, AltDirectorySeparatorChar);
@@ -325,12 +348,38 @@
 				else
 					dirs [target++] = dirs [i];
 			}
-			
+
 			// STEP 5: Combine everything.
 			if (target == 0)
 				return root;
-			else
-				return String.Join (DirectorySeparatorStr, dirs, 0, target);
+			else {
+				string ret = String.Join (DirectorySeparatorStr, dirs, 0, target);
+				switch (DirectorySeparatorChar) {
+				case '\\': // Windows
+					// In GetFullPath(), it is assured that here never comes UNC. So this must only applied to such path that starts with '\', without drive specification.
+					if (path [0] != DirectorySeparatorChar && path.StartsWith (root)) {
+						if (ret.Length <= 2 && !ret.EndsWith (DirectorySeparatorStr)) // '\' after "c:"
+							ret += DirectorySeparatorChar;
+						return ret;
+					} else {
+						string current = Directory.GetCurrentDirectory ();
+						if (current.Length > 1 && current [1] == VolumeSeparatorChar) {
+							// DOS local file path
+							if (ret.Length == 0 || IsDsc (ret [0]))
+								ret += '\\';
+							return current.Substring (0, 2) + ret;
+						}
+						else if (IsDsc (current [current.Length - 1]) && IsDsc (ret [0]))
+							return current + ret.Substring (1);
+						else
+							return current + ret;
+					}
+				default: // Unix/Mac
+					return ret;
+				}
+
+				return ret;
+			}
 		}
 	}
 }
