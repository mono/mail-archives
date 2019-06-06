Index: SimpleWorkerRequest.cs
===================================================================
RCS file: /cvs/public/mcs/class/System.Web/System.Web.Hosting/SimpleWorkerRequest.cs,v
retrieving revision 1.11
diff -u -r1.11 SimpleWorkerRequest.cs
--- SimpleWorkerRequest.cs	11 Jan 2004 13:47:20 -0000	1.11
+++ SimpleWorkerRequest.cs	18 Mar 2004 11:04:00 -0000
@@ -45,7 +45,7 @@
 			o = current.GetData (".hostingVirtualPath");
 			if (o == null)
 				throw new HttpException ("Cannot get .hostingVirtualPath");
-			_AppVirtualPath = CheckAndAddVSlash (o.ToString ());
+			_AppVirtualPath = o.ToString ();
 
 			o = current.GetData (".hostingInstallDir");
 			if (o == null)
@@ -205,9 +205,9 @@
 			char sep = Path.DirectorySeparatorChar;
 			if (path.StartsWith(_AppVirtualPath)) {
 				if (sep == '/')
-					return _AppPhysicalPath + path.Substring (_AppVirtualPath.Length);
+					return sPath + path.Substring (_AppVirtualPath.Length);
 				else
-					return _AppPhysicalPath + path.Substring (_AppVirtualPath.Length).Replace ('/', sep);
+					return sPath + path.Substring (_AppVirtualPath.Length).Replace ('/', sep);
 			}
 
 			return null;
@@ -246,18 +246,6 @@
 
 			if (!sPath.EndsWith ("" + Path.DirectorySeparatorChar))
 				return sPath + Path.DirectorySeparatorChar;
-
-			return sPath;
-		}
-
-		// Creates a path string
-		private string CheckAndAddVSlash(string sPath)
-		{
-			if (null == sPath)
-				return null;
-
-			if (!sPath.EndsWith ("/"))
-				return sPath + "/";
 
 			return sPath;
 		}
