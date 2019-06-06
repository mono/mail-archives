Index: System.Windows.Forms/ToolStripDropDown.cs
===================================================================
--- System.Windows.Forms/ToolStripDropDown.cs	(revision 128604)
+++ System.Windows.Forms/ToolStripDropDown.cs	(working copy)
@@ -577,7 +577,7 @@
 
 		protected override void OnLayout (LayoutEventArgs e)
 		{
-			// Find the widest menu item
+			// Find the widest menu item, so we know how wide to make our dropdown
 			int widest = 0;
 
 			foreach (ToolStripItem tsi in this.Items) {
@@ -586,12 +586,13 @@
 					
 				tsi.SetPlacement (ToolStripItemPlacement.Main);
 				
-				if (tsi.GetPreferredSize (Size.Empty).Width > widest)
-					widest = tsi.GetPreferredSize (Size.Empty).Width;
+				widest = Math.Max (widest, tsi.GetPreferredSize (Size.Empty).Width + tsi.Margin.Horizontal);
 			}
 			
+			// Add any padding our dropdown has set
+			widest += this.Padding.Horizontal;
+			
 			int x = this.Padding.Left;
-			widest += 68 - this.Padding.Horizontal;
 			int y = this.Padding.Top;
 
 			foreach (ToolStripItem tsi in this.Items) {
@@ -602,16 +603,20 @@
 
 				int height = 0;
 
-				if (tsi is ToolStripSeparator)
+				Size preferred_size = tsi.GetPreferredSize (Size.Empty);
+
+				if (preferred_size.Height > 22)
+					height = preferred_size.Height;
+				else if (tsi is ToolStripSeparator)
 					height = 7;
 				else
 					height = 22;
 
-				tsi.SetBounds (new Rectangle (x, y, widest, height));
+				tsi.SetBounds (new Rectangle (x, y, preferred_size.Width, height));
 				y += tsi.Height + tsi.Margin.Bottom;
 			}
 
-			this.Size = new Size (widest + this.Padding.Horizontal, y + this.Padding.Bottom);// + 2);
+			this.Size = new Size (widest, y + this.Padding.Bottom);
 			this.SetDisplayedItems ();
 			this.OnLayoutCompleted (EventArgs.Empty);
 			this.Invalidate ();
Index: System.Windows.Forms/ToolStripDropDownButton.cs
===================================================================
--- System.Windows.Forms/ToolStripDropDownButton.cs	(revision 128604)
+++ System.Windows.Forms/ToolStripDropDownButton.cs	(working copy)
@@ -104,7 +104,9 @@
 		#region Protected Methods
 		protected override ToolStripDropDown CreateDefaultDropDown ()
 		{
-			return base.CreateDefaultDropDown ();
+			ToolStripDropDownMenu tsdd = new ToolStripDropDownMenu ();
+			tsdd.OwnerItem = this;
+			return tsdd;
 		}
 
 		protected override void OnMouseDown (MouseEventArgs e)
Index: System.Windows.Forms/ToolStripItem.cs
===================================================================
--- System.Windows.Forms/ToolStripItem.cs	(revision 128604)
+++ System.Windows.Forms/ToolStripItem.cs	(working copy)
@@ -1856,7 +1856,7 @@
 					return true;
 
 				if (!(this.Owner is ToolStripDropDownMenu))
-					return true;
+					return false;
 
 				ToolStripDropDownMenu tsddm = (ToolStripDropDownMenu)this.Owner;
 
@@ -1870,7 +1870,7 @@
 					return true;
 
 				if (!(this.Owner is ToolStripDropDownMenu))
-					return true;
+					return false;
 
 				ToolStripDropDownMenu tsddm = (ToolStripDropDownMenu)this.Owner;
 