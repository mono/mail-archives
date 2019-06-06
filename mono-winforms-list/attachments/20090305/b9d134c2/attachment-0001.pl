diff -ur orig/ToolStripDropDownButton.cs System.Windows.Forms/ToolStripDropDownButton.cs
--- orig/ToolStripDropDownButton.cs	2009-03-05 18:51:10.000000000 +0200
+++ System.Windows.Forms/ToolStripDropDownButton.cs	2009-03-05 19:07:10.000000000 +0200
@@ -156,6 +156,16 @@
 			}
 		}
 
+		internal override Size CalculatePreferredSize (Size constrainingSize)
+		{
+			Size preferred_size = base.CalculatePreferredSize (constrainingSize);
+
+			if (this.ShowDropDownArrow)
+				preferred_size.Width += 10;
+
+			return preferred_size;
+		}
+
 		protected internal override bool ProcessMnemonic (char charCode)
 		{
 			if (!this.Selected)
diff -ur orig/ToolStripDropDownMenu.cs System.Windows.Forms/ToolStripDropDownMenu.cs
--- orig/ToolStripDropDownMenu.cs	2009-03-05 18:51:40.000000000 +0200
+++ System.Windows.Forms/ToolStripDropDownMenu.cs	2009-03-05 19:01:16.000000000 +0200
@@ -120,17 +120,10 @@
 
 				tsi.SetPlacement (ToolStripItemPlacement.Main);
 
-				if (tsi.GetPreferredSize (Size.Empty).Width > widest)
-					widest = tsi.GetPreferredSize (Size.Empty).Width;
+				widest = Math.Max (widest, tsi.GetPreferredSize (Size.Empty).Width + tsi.Margin.Horizontal);
 			}
 
 			int x = this.Padding.Left;
-			
-			if (show_check_margin || show_image_margin)
-				widest += 68 - this.Padding.Horizontal;
-			else
-				widest += 47 - this.Padding.Horizontal;
-			
 			int y = this.Padding.Top;
 
 			foreach (ToolStripItem tsi in this.Items) {
@@ -141,7 +134,11 @@
 
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
diff -ur orig/ToolStripItem.cs System.Windows.Forms/ToolStripItem.cs
--- orig/ToolStripItem.cs	2009-03-05 18:49:06.000000000 +0200
+++ System.Windows.Forms/ToolStripItem.cs	2009-03-05 19:02:20.000000000 +0200
@@ -1582,10 +1582,6 @@
 				preferred_size.Height += 4;
 				preferred_size.Width += 4;
 			}
-			
-			// Account for ToolStripDropDownButton's drop down arrow
-			if (this is ToolStripDropDownButton && (this as ToolStripDropDownButton).ShowDropDownArrow)
-				preferred_size.Width += 9;
 
 			return preferred_size;
 		}
diff -ur orig/ToolStripMenuItem.cs System.Windows.Forms/ToolStripMenuItem.cs
--- orig/ToolStripMenuItem.cs	2009-03-05 18:51:56.000000000 +0200
+++ System.Windows.Forms/ToolStripMenuItem.cs	2009-03-05 19:01:54.000000000 +0200
@@ -377,20 +377,25 @@
 			if (text_layout_rect != Rectangle.Empty)
 				this.Owner.Renderer.DrawItemText (new ToolStripItemTextRenderEventArgs (e.Graphics, this, this.Text, text_layout_rect, font_color, this.Font, this.TextAlign));
 
-			string key_string = GetShortcutDisplayString ();
-			
-			if (!string.IsNullOrEmpty (key_string) && !this.HasDropDownItems) {
-				int offset = 15;
-				Size key_string_size = TextRenderer.MeasureText (key_string, this.Font);
-				Rectangle key_string_rect = new Rectangle (this.ContentRectangle.Right - key_string_size.Width - offset, text_layout_rect.Top, key_string_size.Width, text_layout_rect.Height);
-				this.Owner.Renderer.DrawItemText (new ToolStripItemTextRenderEventArgs (e.Graphics, this, key_string, key_string_rect, font_color, this.Font, this.TextAlign));
+			if (this.Owner is ToolStripDropDownMenu)
+			{
+				string key_string = GetShortcutDisplayString ();
+
+				if (!string.IsNullOrEmpty (key_string) && !this.HasDropDownItems)
+				{
+					int offset = 15;
+					Size key_string_size = TextRenderer.MeasureText (key_string, this.Font);
+					Rectangle key_string_rect = new Rectangle (this.ContentRectangle.Right - key_string_size.Width - offset, text_layout_rect.Top, key_string_size.Width, text_layout_rect.Height);
+					this.Owner.Renderer.DrawItemText (new ToolStripItemTextRenderEventArgs (e.Graphics, this, key_string, key_string_rect, font_color, this.Font, this.TextAlign));
+				}
+
+				if (this.IsOnDropDown && this.HasDropDownItems)
+					this.Owner.Renderer.DrawArrow (new ToolStripArrowRenderEventArgs (e.Graphics, this, new Rectangle (this.Bounds.Width - 17, 2, 10, 20), Color.Black, ArrowDirection.Right));
 			}
-				
+
 			if (image_layout_rect != Rectangle.Empty)
 				this.Owner.Renderer.DrawItemImage (new ToolStripItemImageRenderEventArgs (e.Graphics, this, draw_image, image_layout_rect));
 
-			if (this.IsOnDropDown && this.HasDropDownItems)
-				this.Owner.Renderer.DrawArrow (new ToolStripArrowRenderEventArgs (e.Graphics, this, new Rectangle (this.Bounds.Width - 17, 2, 10, 20), Color.Black, ArrowDirection.Right));
 			return;
 		}
 
@@ -450,16 +455,29 @@
 		#region Internal Methods
 		internal override Size CalculatePreferredSize (Size constrainingSize)
 		{
-			Size base_size = base.CalculatePreferredSize (constrainingSize);
-			
+			Size preferred_size = base.CalculatePreferredSize (constrainingSize);
+
+			if (this.Owner == null || !(this.Owner is ToolStripDropDownMenu))
+				return preferred_size;
+
+			// Account for drop down arrow
+			if (this.HasDropDownItems)
+				preferred_size.Width += 17;
+
+			// Account for image margin
+			if (this.UseImageMargin)
+				preferred_size.Width += 35;
+
 			string key_string = GetShortcutDisplayString ();
-			
-			if (string.IsNullOrEmpty (key_string))
-				return base_size;
-			
-			Size text_size = TextRenderer.MeasureText (key_string, this.Font);
-			
-			return new Size (base_size.Width + text_size.Width - 25, base_size.Height);
+
+			if (!string.IsNullOrEmpty (key_string))
+			{
+				Size text_size = TextRenderer.MeasureText (key_string, this.Font);
+
+				preferred_size.Width += text_size.Width + 15;
+			}
+
+			return preferred_size;
 		}
 		
 		internal string GetShortcutDisplayString ()
