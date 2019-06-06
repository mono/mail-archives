Index: ToolStripDropDown.cs
===================================================================
--- ToolStripDropDown.cs	(revision 128017)
+++ ToolStripDropDown.cs	(working copy)
@@ -602,7 +602,11 @@
 
 				int height = 0;
 
-				if (tsi is ToolStripSeparator)
+				int preferred_height = tsi.GetPreferredSize (Size.Empty).Height;
+				
+				if (preferred_height > 22)
+					height = preferred_height;
+				else if (tsi is ToolStripSeparator)
 					height = 7;
 				else
 					height = 22;