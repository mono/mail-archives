Index: HttpUtility.cs
===================================================================
--- HttpUtility.cs	(revision 44214)
+++ HttpUtility.cs	(working copy)
@@ -544,7 +544,7 @@
 				if (c == '+')
 					c = ' ';
 				else if (c == '%' && i < end - 2) {
-					c = GetChar (bytes, i, 2);
+					c = GetChar (bytes, i + 1, 2);
 					i += 2;
 				}
 				result.WriteByte ((byte) c);