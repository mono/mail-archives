Index: File.cs
===================================================================
--- File.cs	(revision 37663)
+++ File.cs	(working copy)
@@ -259,7 +259,9 @@
 
 		public static void Move (string src, string dest)
 		{
-			MonoIOError error;
+			MonoIOError error;
+			FileInfo source = new FileInfo (src);
+			FileInfo destination = new FileInfo (dest);
 
 			if (src == null)
 				throw new ArgumentNullException ("src");
@@ -270,9 +272,11 @@
 			if (dest.Trim () == "" || dest.IndexOfAny (Path.InvalidPathChars) != -1)
 				throw new ArgumentException ("dest");
 			if (!MonoIO.Exists (src, out error))
-				throw new FileNotFoundException (Locale.GetText ("{0} does not exist", src), src);
+				throw new FileNotFoundException (Locale.GetText ("{0} does not exist", src), src);
+			if (source.FullName == destination.FullName)
+				return;
 			if (MonoIO.ExistsDirectory (dest, out error))
-					throw new IOException (Locale.GetText ("{0} is a directory", dest));	
+				throw new IOException (Locale.GetText ("{0} is a directory", dest));	
 			if (MonoIO.Exists (dest, out error))
 				throw new IOException (Locale.GetText ("{0} already exists", dest));
 
