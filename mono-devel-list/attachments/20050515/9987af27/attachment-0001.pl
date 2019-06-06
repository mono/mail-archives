Index: ListBox.cs
===================================================================
--- ListBox.cs	(revision 44453)
+++ ListBox.cs	(working copy)
@@ -368,11 +368,18 @@
 		[Localizable (true)]
 		[RefreshProperties(RefreshProperties.Repaint)]
 		public virtual int ItemHeight {
-			get { return listbox_info.item_height; }
+			get {
+				if (draw_mode == DrawMode.Normal)
+					return FontHeight;
+				return listbox_info.item_height;
+			}
 			set {
 				if (value > 255)
 					throw new ArgumentOutOfRangeException ("The ItemHeight property was set beyond 255 pixels");
 
+				if (listbox_info.item_height == value)
+					return;
+
 				listbox_info.item_height = value;
 				CalcClientArea ();
 			}