Index: XmlDocument.cs
===================================================================
RCS file: /cvs/public/mcs/class/System.XML/System.Xml/XmlDocument.cs,v
retrieving revision 1.102
diff -u -r1.102 XmlDocument.cs
--- XmlDocument.cs	21 Jun 2004 18:06:53 -0000	1.102
+++ XmlDocument.cs	27 Jun 2004 21:21:13 -0000
@@ -597,7 +597,8 @@
 				xr.XmlResolver = resolver;
 				Load (xr);
 			} finally {
-				xr.Close ();
+				if (xr != null)
+					xr.Close ();
 			}
 		}
 