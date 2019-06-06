Index: XmlUrlResolver.cs
===================================================================
RCS file: /cvs/public/mcs/class/System.XML/System.Xml/XmlUrlResolver.cs,v
retrieving revision 1.13
diff -u -r1.13 XmlUrlResolver.cs
--- XmlUrlResolver.cs	7 Dec 2003 15:03:54 -0000	1.13
+++ XmlUrlResolver.cs	9 Dec 2003 16:09:27 -0000
@@ -76,12 +76,11 @@
 					relativeUri.StartsWith ("file:"))
 					return new Uri (relativeUri);
 				else
-					return new Uri (Path.GetFullPath (relativeUri));
-
-				// extraneous "/a" is required because current Uri stuff 
-				// seems ignorant of difference between "." and "./". 
-				// I'd be appleciate if it is fixed with better solution.
-//				return new Uri (new Uri (Path.GetFullPath ("./a")), EscapeRelativeUriBody (relativeUri));
+					// extraneous "/a" is required because current Uri stuff 
+					// seems ignorant of difference between "." and "./". 
+					// I'd be appleciate if it is fixed with better solution.
+//					return new Uri (Path.GetFullPath (relativeUri));
+					return new Uri (new Uri (Path.GetFullPath ("./a")), EscapeRelativeUriBody (relativeUri));
 			}
 
 			if (relativeUri == null)
