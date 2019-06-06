Index: HtmlEmitter.cs
===================================================================
--- HtmlEmitter.cs	(revision 45479)
+++ HtmlEmitter.cs	(working copy)
@@ -306,7 +306,8 @@
 
 			if (attribute == "SELECTED" && element == "option"
 				|| attribute == "CHECKED" && element == "input")
-				return;
+				if (string.Compare(attribute, value, true) == 0)
+					return;
 
 			writer.Write ("=\"");
 			openAttribute = true;

