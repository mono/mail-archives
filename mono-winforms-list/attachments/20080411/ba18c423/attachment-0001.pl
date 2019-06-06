Index: ThemeWin32Classic.cs
===================================================================
--- ThemeWin32Classic.cs	(revision 100451)
+++ ThemeWin32Classic.cs	(working copy)
@@ -2381,7 +2381,8 @@
 			bool details = control.View == View.Details;
 			int first = control.FirstVisibleIndex;	
 
-			for (int i = first; i <= control.LastVisibleIndex; i ++) {					
+			int LastVisibleIndex = control.LastVisibleIndex;
+			for (int i = first; i <= LastVisibleIndex; i ++) {					
 				if (clip.IntersectsWith (control.Items[i].GetBounds (ItemBoundsPortion.Entire))) {
 #if NET_2_0
 					bool owner_draw = false;