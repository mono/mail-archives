Index: System.Windows.Forms/ScrollBar.cs
===================================================================
--- System.Windows.Forms/ScrollBar.cs	(revision 85451)
+++ System.Windows.Forms/ScrollBar.cs	(working copy)
@@ -1278,9 +1278,11 @@
 				else
 					pos = newPos;
 
-			// pos can't be less than minimum
+			// pos can't be less than minimum or more than maximum
 			if (pos < minimum)
 				pos = minimum;
+			if (pos > maximum)
+				pos = maximum;
 
 			if (update_thumbpos) {
 				if (vert)