Index: System.Windows.Forms/ToolStripDropDownMenu.cs
===================================================================
--- System.Windows.Forms/ToolStripDropDownMenu.cs	(revision 128604)
+++ System.Windows.Forms/ToolStripDropDownMenu.cs	(working copy)
@@ -71,6 +71,7 @@
 			set { 
 				if (this.show_check_margin != value) {
 					this.show_check_margin = value;
+					CalculatePadding ();
 					PerformLayout (this, "ShowCheckMargin");
 				}
 			}
@@ -82,6 +83,7 @@
 			set { 
 				if (this.show_image_margin != value) {
 					this.show_image_margin = value;
+					CalculatePadding ();
 					PerformLayout (this, "ShowImageMargin");
 				}
 			}
@@ -90,7 +92,7 @@
 
 		#region Protected Properties
 		protected override Padding DefaultPadding {
-			get { return base.DefaultPadding; }
+			get { return new Padding (33, 2, 1, 2); }
 		}
 
 		protected internal override Size MaxItemSize {
@@ -187,6 +189,18 @@
 
 			return base.CalculateConnectedArea ();
 		}
+		
+		private void CalculatePadding ()
+		{
+			int left = 8;
+
+			if (show_check_margin && show_image_margin)
+				left = 55;
+			else if (show_check_margin || show_image_margin)
+				left = 33;
+				
+			Padding = new Padding (left, Padding.Top, Padding.Right, Padding.Bottom);
+		}
 		#endregion
 	}
 }