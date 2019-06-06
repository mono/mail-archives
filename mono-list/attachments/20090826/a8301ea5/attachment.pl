Index: src/Mono.WebServer/Paths.cs
===================================================================
--- src/Mono.WebServer/Paths.cs	(revision 140700)
+++ src/Mono.WebServer/Paths.cs	(working copy)
@@ -69,9 +69,7 @@
 
 			int dot, slash;
 			int lastSlash = uri.Length;
-#if !NET_2_0
 			bool windows = (Path.DirectorySeparatorChar == '\\');
-#endif
 			string partial;
 				
 			for (dot = uri.LastIndexOf ('.'); dot > 0; dot = uri.LastIndexOf ('.', dot - 1)) {
@@ -83,17 +81,12 @@
 				partial = uri.Substring (0, slash);
 				lastSlash = slash;
 
-#if NET_2_0
-				if (!VirtualPathExists (appHost, verb, partial))
-					continue;
-#else
 				if (windows)
 					partial = partial.Replace ('/', '\\');
 				
 				string path = Path.Combine (basepath, (partial));
 				if (!File.Exists (path) && !VirtualPathExists (appHost, verb, partial))
 					continue;
-#endif
 				
 				realUri = vpath + uri.Substring (0, slash);
 				pathInfo = uri.Substring (slash);
@@ -106,11 +99,6 @@
 			if (appHost.IsHttpHandler (verb, uri))
 				return true;
 
-#if NET_2_0
-			VirtualPathProvider vpp = HostingEnvironment.VirtualPathProvider;
-			if (vpp != null && vpp.FileExists ("/" + uri))
-				return true;
-#endif
 			return false;
 		}
 	}
