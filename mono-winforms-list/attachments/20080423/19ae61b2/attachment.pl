Index: System.Windows.Forms.VisualStyles/FontProperty.cs
===================================================================
--- System.Windows.Forms.VisualStyles/FontProperty.cs	(revision 101620)
+++ System.Windows.Forms.VisualStyles/FontProperty.cs	(working copy)
@@ -31,7 +31,18 @@
 {
 	public enum FontProperty
 	{
+                Font = 210,
+                CaptionFont=801,
+                SmallCaptionFont = 802,
+                MenuFont = 803,
+                StatusFont = 804,
+                MsgBoxFont = 805,
+                IconTitleFont = 806,
+                Heading1Font = 807,
+                Heading2Font = 808,
+                BodyFont = 809,
 		GlyphFont = 2601
+                
 	}
 }
 #endif
\ No newline at end of file
Index: System.Windows.Forms.VisualStyles/VisualStyleElement.cs
===================================================================
--- System.Windows.Forms.VisualStyles/VisualStyleElement.cs	(revision 101620)
+++ System.Windows.Forms.VisualStyles/VisualStyleElement.cs	(working copy)
@@ -426,14 +426,24 @@
 				public static VisualStyleElement UpHot { get { return VisualStyleElement.CreateElement (VisualStyleElement.SCROLLBAR, 1, 2); } }
 				public static VisualStyleElement UpNormal { get { return VisualStyleElement.CreateElement (VisualStyleElement.SCROLLBAR, 1, 1); } }
 				public static VisualStyleElement UpPressed { get { return VisualStyleElement.CreateElement (VisualStyleElement.SCROLLBAR, 1, 3); } }
+				public static VisualStyleElement UpHover { get { return VisualStyleElement.CreateElement (VisualStyleElement.SCROLLBAR, 1, 17); } }
+                                public static VisualStyleElement DownHover { get { return VisualStyleElement.CreateElement (VisualStyleElement.SCROLLBAR, 1, 18); } }
+                                public static VisualStyleElement LeftHover { get { return VisualStyleElement.CreateElement (VisualStyleElement.SCROLLBAR, 1, 19); } }
+                                public static VisualStyleElement RightHover { get { return VisualStyleElement.CreateElement (VisualStyleElement.SCROLLBAR, 1, 20); } }
 			}
 			public static class GripperHorizontal
 			{
-				public static VisualStyleElement Normal { get { return VisualStyleElement.CreateElement (VisualStyleElement.SCROLLBAR, 8, 0); } }
+				public static VisualStyleElement Normal { get { return VisualStyleElement.CreateElement (VisualStyleElement.SCROLLBAR, 8, 1); } }
+                                public static VisualStyleElement Hot { get { return VisualStyleElement.CreateElement (VisualStyleElement.SCROLLBAR, 8, 2); } }
+                                public static VisualStyleElement Pressed { get { return VisualStyleElement.CreateElement (VisualStyleElement.SCROLLBAR, 8, 3); } }
+                                public static VisualStyleElement Disabled { get { return VisualStyleElement.CreateElement (VisualStyleElement.SCROLLBAR, 8, 4); } }
 			}
 			public static class GripperVertical
 			{
-				public static VisualStyleElement Normal { get { return VisualStyleElement.CreateElement (VisualStyleElement.SCROLLBAR, 9, 0); } }
+				public static VisualStyleElement Normal { get { return VisualStyleElement.CreateElement (VisualStyleElement.SCROLLBAR, 9, 1); } }
+                                public static VisualStyleElement Hot { get { return VisualStyleElement.CreateElement (VisualStyleElement.SCROLLBAR, 9, 2); } }
+                                public static VisualStyleElement Pressed { get { return VisualStyleElement.CreateElement (VisualStyleElement.SCROLLBAR, 9, 3); } }
+                                public static VisualStyleElement Disabled { get { return VisualStyleElement.CreateElement (VisualStyleElement.SCROLLBAR, 9, 4); } }
 			}
 			public static class LeftTrackHorizontal
 			{
Index: System.Windows.Forms/ButtonBase.cs
===================================================================
--- System.Windows.Forms/ButtonBase.cs	(revision 101620)
+++ System.Windows.Forms/ButtonBase.cs	(working copy)
@@ -480,7 +480,7 @@
 			get { return ThemeEngine.Current.ButtonBaseDefaultSize; }
 		}
 
-		protected bool IsDefault {
+		protected internal bool IsDefault {
 			get { return is_default; }
 			set {
 				if (is_default != value) {
Index: System.Windows.Forms/ScrollBar.cs
===================================================================
--- System.Windows.Forms/ScrollBar.cs	(revision 101620)
+++ System.Windows.Forms/ScrollBar.cs	(working copy)
@@ -59,7 +59,11 @@
 		private Rectangle thumb_area = new Rectangle ();
 		internal ButtonState firstbutton_state = ButtonState.Normal;
 		internal ButtonState secondbutton_state = ButtonState.Normal;
-		private bool firstbutton_pressed = false;
+                internal ButtonState thumb_state = ButtonState.Normal;
+                internal bool firstbutton_entered = false;
+                internal bool secondbutton_entered = false;
+                internal bool thumb_entered = false;
+                private bool firstbutton_pressed = false;
 		private bool secondbutton_pressed = false;
 		private bool thumb_pressed = false;
 		private float pixel_per_pos = 0;
@@ -238,6 +242,8 @@
 			base.MouseDown += new MouseEventHandler (OnMouseDownSB);
 			base.MouseUp += new MouseEventHandler (OnMouseUpSB);
 			base.MouseMove += new MouseEventHandler (OnMouseMoveSB);
+                        base.MouseEnter += new EventHandler(OnMouseEnterSB);
+                        base.MouseLeave += new EventHandler(OnMouseLeaveSB);
 			base.Resize += new EventHandler (OnResizeSB);
 			base.TabStop = false;
 			base.Cursor = Cursors.Default;
@@ -590,9 +596,9 @@
 			base.OnEnabledChanged (e);
 
 			if (Enabled)
-				firstbutton_state = secondbutton_state = ButtonState.Normal;
+				firstbutton_state = secondbutton_state = thumb_state = ButtonState.Normal;
 			else
-				firstbutton_state = secondbutton_state = ButtonState.Inactive;
+                                firstbutton_state = secondbutton_state = thumb_state = ButtonState.Inactive;
 
 			Refresh ();
 		}
@@ -926,11 +932,42 @@
 			Update ();
 		}
 
+                private void OnMouseEnterSB(object sender, EventArgs e)
+                {
+                        Invalidate ();
+                }
+
+                private void OnMouseLeaveSB(object sender, EventArgs e)
+                {
+                        firstbutton_entered = false;
+                        secondbutton_entered = false;
+                        thumb_entered = false;
+                        Invalidate ();
+                }
+            
     		private void OnMouseMoveSB (object sender, MouseEventArgs e)
     		{
 			if (Enabled == false || thumb_size == 0)
 				return;
 
+                        //Track mouse enter and leave for arrows and thumb to allow "hot" effect when VisualStyles enabled
+                        bool newstate;
+                        newstate = first_arrow_area.Contains(e.X, e.Y);
+                        if (firstbutton_entered != newstate) {
+                                firstbutton_entered = newstate;
+                                Invalidate (first_arrow_area);
+                        }
+                        newstate = second_arrow_area.Contains(e.X, e.Y);
+                        if (secondbutton_entered != newstate) {
+                                secondbutton_entered = newstate;
+                                Invalidate (second_arrow_area);
+                        }
+			newstate = thumb_size > 0 && thumb_pos.Contains (e.X, e.Y);
+                        if (thumb_entered != newstate) {
+                                thumb_entered = newstate;
+                                Invalidate (thumb_area);
+                        }
+
 			if (firstbutton_pressed) {
     				if (!first_arrow_area.Contains (e.X, e.Y) && ((firstbutton_state & ButtonState.Pushed) == ButtonState.Pushed)) {
 					firstbutton_state = ButtonState.Normal;
@@ -1031,6 +1068,9 @@
 
 			if (thumb_size > 0 && thumb_pos.Contains (e.X, e.Y)) {
 				thumb_pressed = true;
+                                thumb_state = ButtonState.Pushed;
+                                Invalidate (thumb_area);
+                                Update ();
 				SendWMScroll(ScrollBarCommands.SB_THUMBTRACK);
 				if (vert) {
 					thumbclick_offset = e.Y - thumb_pos.Y;
@@ -1125,6 +1165,8 @@
 				OnScroll (new ScrollEventArgs (ScrollEventType.EndScroll, position));
 				SendWMScroll(ScrollBarCommands.SB_THUMBPOSITION);
 				thumb_pressed = false;
+                                thumb_state = ButtonState.Normal;
+                                Invalidate (thumb_area);
 				return;
 			}
 
Index: System.Windows.Forms/ThemeVisualStyles.cs
===================================================================
--- System.Windows.Forms/ThemeVisualStyles.cs	(revision 0)
+++ System.Windows.Forms/ThemeVisualStyles.cs	(revision 0)
@@ -0,0 +1,896 @@
+// Permission is hereby granted, free of charge, to any person obtaining
+// a copy of this software and associated documentation files (the
+// "Software"), to deal in the Software without restriction, including
+// without limitation the rights to use, copy, modify, merge, publish,
+// distribute, sublicense, and/or sell copies of the Software, and to
+// permit persons to whom the Software is furnished to do so, subject to
+// the following conditions:
+//
+// The above copyright notice and this permission notice shall be
+// included in all copies or substantial portions of the Software.
+//
+// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
+// LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
+// OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
+// WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+//
+// Copyright (c) 2004-2006 Novell, Inc.
+//
+// Authors:
+//	Ernesto Carrea, equistango@gmail.com
+//
+
+using System.ComponentModel;
+using System.Data;
+using System.Drawing;
+using System.Drawing.Drawing2D;
+using System.Drawing.Imaging;
+using System.Drawing.Printing;
+using System.Drawing.Text;
+using System.Text;
+using System.Windows.Forms.Theming;
+using System.Runtime.InteropServices;
+
+namespace System.Windows.Forms
+{
+
+	internal class ThemeVisualStyles 
+		: ThemeWin32Classic
+	{		
+		public override Version Version {
+			get {
+				return new Version(0, 1, 0, 0);
+			}
+		}
+
+		private bool IsVista = false;
+
+		public ThemeVisualStyles()
+			: base()
+		{
+			IsVista = System.Environment.OSVersion.Platform == PlatformID.Win32NT && System.Environment.OSVersion.Version.Major >= 6;
+		}
+
+                public override void CPDrawCheckBox(Graphics dc, Rectangle rectangle, ButtonState state)
+                {
+                        VisualStyles.VisualStyleElement element;
+
+                        if ((state & ButtonState.Checked) == ButtonState.Checked) {
+                                if ((state & ButtonState.Inactive) == ButtonState.Inactive)
+                                        element = VisualStyles.VisualStyleElement.Button.CheckBox.CheckedDisabled;
+                                else
+                                        element = VisualStyles.VisualStyleElement.Button.CheckBox.CheckedNormal;
+                        } else {
+                                if ((state & ButtonState.Inactive) == ButtonState.Inactive)
+                                        element = VisualStyles.VisualStyleElement.Button.CheckBox.UncheckedDisabled;
+                                else
+                                        element = VisualStyles.VisualStyleElement.Button.CheckBox.UncheckedNormal;
+
+                        }
+
+                        VisualStyles.VisualStyleRenderer rndr = new System.Windows.Forms.VisualStyles.VisualStyleRenderer (element);
+                        rndr.DrawBackground (dc, rectangle);
+                }
+
+		#region Button
+		#region Standard Button Style
+		public override void DrawButton (Graphics g, Button b, Rectangle textBounds, Rectangle imageBounds, Rectangle clipRectangle)
+		{
+			VisualStyles.VisualStyleElement element;
+			if(b.Enabled == false)
+				element = VisualStyles.VisualStyleElement.Button.PushButton.Disabled;
+			else if (b.Pressed || b.ButtonState == ButtonState.Pushed)
+				element = VisualStyles.VisualStyleElement.Button.PushButton.Pressed;
+			else if (b.Entered)
+				element = VisualStyles.VisualStyleElement.Button.PushButton.Hot;
+			else if (b.IsDefault)
+				element = VisualStyles.VisualStyleElement.Button.PushButton.Default;
+			else
+				element = VisualStyles.VisualStyleElement.Button.PushButton.Normal;
+
+			VisualStyles.VisualStyleRenderer rndr = new System.Windows.Forms.VisualStyles.VisualStyleRenderer(element);
+			rndr.DrawBackground(g, b.ClientRectangle, clipRectangle);
+
+			if (imageBounds.Size != Size.Empty)
+				rndr.DrawImage(g, imageBounds, b.Image);
+
+			//If we're focused, draw a focus rectangle
+			if (b.Focused && b.Enabled && b.ShowFocusCues)
+				DrawButtonFocus(g, b);
+
+			// If we have text, draw it
+			if (textBounds != Rectangle.Empty)
+				rndr.DrawText(g, textBounds, b.Text, !b.Enabled, TextFormatFlags.HorizontalCenter & TextFormatFlags.VerticalCenter & TextFormatFlags.EndEllipsis & TextFormatFlags.SingleLine);
+		}
+		#endregion
+		#endregion
+
+		#region CheckBox
+#if NET_2_0
+		public override void DrawCheckBox (Graphics g, CheckBox cb, Rectangle glyphArea, Rectangle textBounds, Rectangle imageBounds, Rectangle clipRectangle)
+		{
+			// Draw Button Background
+			if (cb.Appearance == Appearance.Button && cb.FlatStyle != FlatStyle.Flat)
+				ButtonBase_DrawButton (cb, g);
+			else if (cb.Appearance != Appearance.Button)
+				DrawCheckBoxGlyph (g, cb, glyphArea);
+
+			// Draw the borders and such for a Flat CheckBox Button
+			if (cb.Appearance == Appearance.Button && cb.FlatStyle == FlatStyle.Flat)
+			        DrawFlatButton (g, cb, textBounds, imageBounds, clipRectangle);
+			
+			// If we have an image, draw it
+			if (imageBounds.Size != Size.Empty)
+				DrawCheckBoxImage (g, cb, imageBounds);
+
+			if (cb.Focused && cb.Enabled && cb.ShowFocusCues && textBounds != Rectangle.Empty)
+				DrawCheckBoxFocus (g, cb, textBounds);
+
+			// If we have text, draw it
+			if (textBounds != Rectangle.Empty)
+			{
+				VisualStyles.VisualStyleElement element;
+				switch (cb.CheckState)
+				{
+					case CheckState.Checked:
+						if (cb.Enabled == false)
+							element = VisualStyles.VisualStyleElement.Button.CheckBox.CheckedDisabled;
+						else if (cb.Entered)
+							element = VisualStyles.VisualStyleElement.Button.CheckBox.CheckedHot;
+						else if (cb.Pressed)
+							element = VisualStyles.VisualStyleElement.Button.CheckBox.CheckedPressed;
+						else
+							element = VisualStyles.VisualStyleElement.Button.CheckBox.CheckedNormal;
+						break;
+					case CheckState.Indeterminate:
+						if (cb.Enabled == false)
+							element = VisualStyles.VisualStyleElement.Button.CheckBox.MixedDisabled;
+						else if (cb.Entered)
+							element = VisualStyles.VisualStyleElement.Button.CheckBox.MixedHot;
+						else if (cb.Pressed)
+							element = VisualStyles.VisualStyleElement.Button.CheckBox.MixedPressed;
+						else
+							element = VisualStyles.VisualStyleElement.Button.CheckBox.MixedNormal;
+						break;
+					default:
+						if (cb.Enabled == false)
+							element = VisualStyles.VisualStyleElement.Button.CheckBox.UncheckedDisabled;
+						else if (cb.Entered)
+							element = VisualStyles.VisualStyleElement.Button.CheckBox.UncheckedHot;
+						else if (cb.Pressed)
+							element = VisualStyles.VisualStyleElement.Button.CheckBox.UncheckedPressed;
+						else
+							element = VisualStyles.VisualStyleElement.Button.CheckBox.UncheckedNormal;
+						break;
+				}
+
+				VisualStyles.VisualStyleRenderer rndr = new System.Windows.Forms.VisualStyles.VisualStyleRenderer(element);
+				rndr.DrawBackground(g, glyphArea);
+				rndr.DrawText(g, textBounds, cb.Text, !cb.Enabled, TextFormatFlags.Default);
+			}
+		}
+
+		public override void DrawCheckBoxGlyph (Graphics g, CheckBox cb, Rectangle glyphArea)
+		{
+			VisualStyles.VisualStyleElement element;
+			switch (cb.CheckState)
+			{
+				case CheckState.Checked:
+					if (cb.Enabled == false)
+						element = VisualStyles.VisualStyleElement.Button.CheckBox.CheckedDisabled;
+					else if (cb.is_entered)
+						element = VisualStyles.VisualStyleElement.Button.CheckBox.CheckedHot;
+					else if (cb.is_pressed)
+						element = VisualStyles.VisualStyleElement.Button.CheckBox.CheckedPressed;
+					else
+						element = VisualStyles.VisualStyleElement.Button.CheckBox.CheckedNormal;
+					break;
+				case CheckState.Indeterminate:
+					if (cb.Enabled == false)
+						element = VisualStyles.VisualStyleElement.Button.CheckBox.MixedDisabled;
+                                        else if (cb.is_entered)
+						element = VisualStyles.VisualStyleElement.Button.CheckBox.MixedHot;
+                                        else if (cb.is_pressed)
+						element = VisualStyles.VisualStyleElement.Button.CheckBox.MixedPressed;
+					else
+						element = VisualStyles.VisualStyleElement.Button.CheckBox.MixedNormal;
+					break;
+				default:
+					if (cb.Enabled == false)
+						element = VisualStyles.VisualStyleElement.Button.CheckBox.UncheckedDisabled;
+                                        else if (cb.is_entered)
+						element = VisualStyles.VisualStyleElement.Button.CheckBox.UncheckedHot;
+                                        else if (cb.is_pressed)
+						element = VisualStyles.VisualStyleElement.Button.CheckBox.UncheckedPressed;
+					else
+						element = VisualStyles.VisualStyleElement.Button.CheckBox.UncheckedNormal;
+					break;
+			}
+
+			VisualStyles.VisualStyleRenderer rndr = new System.Windows.Forms.VisualStyles.VisualStyleRenderer(element);
+			rndr.DrawBackground(g, glyphArea);
+		}
+#endif
+		#endregion
+
+                #region Managed Windows
+                public override void DrawManagedWindowDecorations(Graphics dc, Rectangle clip, InternalWindowManager wm)
+                {
+                        VisualStyles.VisualStyleElement element;
+                        VisualStyles.VisualStyleRenderer rndr;
+
+			int BorderWidth = ManagedWindowBorderWidth(wm);
+
+			Rectangle TitleBarRect;
+
+			if(wm.IsActive && !wm.IsMaximized) {
+				TitleBarRect = new Rectangle(0, 0, wm.Form.Width, ManagedWindowTitleBarHeight(wm));
+
+				if(wm.form.FormBorderStyle == FormBorderStyle.SizableToolWindow || wm.form.FormBorderStyle == FormBorderStyle.FixedToolWindow) {
+					switch(wm.form.window_state) {
+						case FormWindowState.Minimized:
+							if(wm.Form.Enabled == false)
+								element = VisualStyles.VisualStyleElement.Window.SmallMinCaption.Disabled;
+							else if(wm.Form.IsActive)
+								element = VisualStyles.VisualStyleElement.Window.SmallMinCaption.Active;
+							else
+								element = VisualStyles.VisualStyleElement.Window.SmallMinCaption.Inactive;
+							break;
+						case FormWindowState.Maximized:
+							if(wm.Form.Enabled == false)
+								element = VisualStyles.VisualStyleElement.Window.SmallMaxCaption.Disabled;
+							else if(wm.Form.IsActive)
+								element = VisualStyles.VisualStyleElement.Window.SmallMaxCaption.Active;
+							else
+								element = VisualStyles.VisualStyleElement.Window.SmallMaxCaption.Inactive;
+							break;
+						default:
+							if(wm.Form.Enabled == false)
+								element = VisualStyles.VisualStyleElement.Window.SmallCaption.Disabled;
+							else if(wm.Form.IsActive)
+								element = VisualStyles.VisualStyleElement.Window.SmallCaption.Active;
+							else
+								element = VisualStyles.VisualStyleElement.Window.SmallCaption.Inactive;
+							break;
+					}
+				} else {
+					switch(wm.form.window_state) {
+						case FormWindowState.Minimized:
+							if(wm.Form.Enabled == false)
+								element = VisualStyles.VisualStyleElement.Window.MinCaption.Disabled;
+							else if(wm.Form.IsActive)
+								element = VisualStyles.VisualStyleElement.Window.MinCaption.Active;
+							else
+								element = VisualStyles.VisualStyleElement.Window.MinCaption.Inactive;
+							break;
+						case FormWindowState.Maximized:
+							if(wm.Form.Enabled == false)
+								element = VisualStyles.VisualStyleElement.Window.MaxCaption.Disabled;
+							else if(wm.Form.IsActive)
+								element = VisualStyles.VisualStyleElement.Window.MaxCaption.Active;
+							else
+								element = VisualStyles.VisualStyleElement.Window.MaxCaption.Inactive;
+							break;
+						default:
+							if(wm.Form.Enabled == false)
+								element = VisualStyles.VisualStyleElement.Window.Caption.Disabled;
+							else if(wm.Form.IsActive)
+								element = VisualStyles.VisualStyleElement.Window.Caption.Active;
+							else
+								element = VisualStyles.VisualStyleElement.Window.Caption.Inactive;
+							break;
+					}
+				}
+
+				
+
+                                rndr = new System.Windows.Forms.VisualStyles.VisualStyleRenderer (element);
+				TitleBarRect.Height = rndr.GetPartSize(dc, System.Windows.Forms.VisualStyles.ThemeSizeType.True).Height;
+				rndr.DrawBackground(dc, TitleBarRect, clip);
+
+				string window_caption = wm.Form.Text;
+				window_caption = window_caption.Replace(Environment.NewLine, string.Empty);
+
+				if(window_caption != null && window_caption != string.Empty)
+					rndr.DrawText(dc, TitleBarRect, window_caption, !wm.Form.Enabled, TextFormatFlags.Default);
+                        }
+			else
+			{
+				TitleBarRect = Rectangle.Empty;
+			}
+
+			if(wm.HasBorders && wm.form.window_state != FormWindowState.Minimized) {
+				//Left
+				if(wm.form.FormBorderStyle == FormBorderStyle.FixedToolWindow)
+					if(wm.form.IsActive)
+						element = VisualStyles.VisualStyleElement.Window.SmallFrameLeft.Active;
+					else
+						element = VisualStyles.VisualStyleElement.Window.SmallFrameLeft.Inactive;
+				else
+					if(wm.form.IsActive)
+						element = VisualStyles.VisualStyleElement.Window.FrameLeft.Active;
+					else
+						element = VisualStyles.VisualStyleElement.Window.FrameLeft.Inactive;
+				
+				rndr = new System.Windows.Forms.VisualStyles.VisualStyleRenderer(element);
+				rndr.DrawBackground(dc, new Rectangle(0, TitleBarRect.Bottom, BorderWidth, wm.form.Height - TitleBarRect.Bottom), clip);
+
+				//Right
+				if(wm.form.FormBorderStyle == FormBorderStyle.FixedToolWindow)
+					if(wm.form.IsActive)
+						element = VisualStyles.VisualStyleElement.Window.SmallFrameRight.Active;
+					else
+						element = VisualStyles.VisualStyleElement.Window.SmallFrameRight.Inactive;
+				else
+					if(wm.form.IsActive)
+						element = VisualStyles.VisualStyleElement.Window.FrameRight.Active;
+					else
+						element = VisualStyles.VisualStyleElement.Window.FrameRight.Inactive;
+
+				rndr = new System.Windows.Forms.VisualStyles.VisualStyleRenderer(element);
+				rndr.DrawBackground(dc, new Rectangle(wm.form.Width - BorderWidth, TitleBarRect.Bottom, BorderWidth, wm.form.Height - TitleBarRect.Bottom), clip);
+
+				//Bottom
+				if(wm.form.FormBorderStyle == FormBorderStyle.FixedToolWindow)
+					if(wm.form.IsActive)
+						element = VisualStyles.VisualStyleElement.Window.SmallFrameBottom.Active;
+					else
+						element = VisualStyles.VisualStyleElement.Window.SmallFrameBottom.Inactive;
+				else
+					if(wm.form.IsActive)
+						element = VisualStyles.VisualStyleElement.Window.FrameBottom.Active;
+					else
+						element = VisualStyles.VisualStyleElement.Window.FrameBottom.Inactive;
+
+				rndr = new System.Windows.Forms.VisualStyles.VisualStyleRenderer(element);
+				rndr.DrawBackground(dc, new Rectangle(0, wm.form.Height - BorderWidth, wm.form.Width, BorderWidth), clip);
+
+
+				if(TitleBarRect.Height > 0) {
+					bool draw_icon = false;
+#if NET_2_0
+					draw_icon = !wm.IsToolWindow && wm.Form.Icon != null && wm.Form.ShowIcon;
+#else
+					draw_icon = !wm.IsToolWindow && wm.Form.Icon != null;
+#endif
+					if(draw_icon) {
+						Rectangle IconRect = new Rectangle(BorderWidth + 3, BorderWidth + 2, wm.IconWidth, wm.IconWidth);
+						if(IconRect.IntersectsWith(clip))
+							dc.DrawIcon(wm.Form.Icon, IconRect);
+					}
+
+					foreach(TitleButton button in wm.TitleButtons.AllButtons) {
+						switch(button.Caption) {
+							case CaptionButton.Minimize:
+								if(button.State == ButtonState.Pushed)
+									element = VisualStyles.VisualStyleElement.Window.MinButton.Pressed;
+								else if(wm.form.Enabled == false)
+									element = VisualStyles.VisualStyleElement.Window.MinButton.Disabled;
+								else
+									element = VisualStyles.VisualStyleElement.Window.MinButton.Normal;
+								break;
+							case CaptionButton.Maximize:
+								if(button.State == ButtonState.Pushed)
+									element = VisualStyles.VisualStyleElement.Window.MaxButton.Pressed;
+								else if(wm.form.Enabled == false)
+									element = VisualStyles.VisualStyleElement.Window.MaxButton.Disabled;
+								else
+									element = VisualStyles.VisualStyleElement.Window.MaxButton.Normal;
+								break;
+							case CaptionButton.Close:
+								if(button.State == ButtonState.Pushed)
+									element = VisualStyles.VisualStyleElement.Window.CloseButton.Pressed;
+								else if(wm.form.Enabled == false)
+									element = VisualStyles.VisualStyleElement.Window.CloseButton.Disabled;
+								else
+									element = VisualStyles.VisualStyleElement.Window.CloseButton.Normal;
+								break;
+							case CaptionButton.Restore:
+								if(button.State == ButtonState.Pushed)
+									element = VisualStyles.VisualStyleElement.Window.RestoreButton.Pressed;
+								else if(wm.form.Enabled == false)
+									element = VisualStyles.VisualStyleElement.Window.RestoreButton.Disabled;
+								else
+									element = VisualStyles.VisualStyleElement.Window.RestoreButton.Normal;
+								break;
+							case CaptionButton.Help:
+								if(button.State == ButtonState.Pushed)
+									element = VisualStyles.VisualStyleElement.Window.HelpButton.Pressed;
+								else if(wm.form.Enabled == false)
+									element = VisualStyles.VisualStyleElement.Window.HelpButton.Disabled;
+								else
+									element = VisualStyles.VisualStyleElement.Window.HelpButton.Normal;
+								break;
+						}
+
+						rndr = new System.Windows.Forms.VisualStyles.VisualStyleRenderer(element);
+						rndr.DrawBackground(dc, button.Rectangle, clip);
+					}
+				}
+
+			}
+
+                }
+
+		 /*public override int ManagedWindowTitleBarHeight(InternalWindowManager wm)
+		{
+			System.Windows.Forms.VisualStyles.VisualStyleElement element;
+			if(wm.form.FormBorderStyle == FormBorderStyle.FixedToolWindow || wm.form.FormBorderStyle == FormBorderStyle.SizableToolWindow)
+				element = System.Windows.Forms.VisualStyles.VisualStyleElement.Window.SmallCaption.Active;
+			else
+				element = System.Windows.Forms.VisualStyles.VisualStyleElement.Window.Caption.Active;
+
+			System.Windows.Forms.VisualStyles.VisualStyleRenderer rndr = new System.Windows.Forms.VisualStyles.VisualStyleRenderer(element);
+			return rndr.GetPartSize(wm.form.CreateGraphics(), System.Windows.Forms.VisualStyles.ThemeSizeType.True).Height;
+
+		}*/
+
+		public override int ManagedWindowBorderWidth(InternalWindowManager wm)
+		{
+			return XplatUIWin32.Win32GetSystemMetrics(XplatUIWin32.SystemMetrics.SM_CXEDGE);
+		}
+                #endregion
+
+                #region ProgressBar
+                public override void DrawProgressBar(Graphics dc, Rectangle clip_rect, ProgressBar ctrl)
+		{
+			VisualStyles.VisualStyleElement element = VisualStyles.VisualStyleElement.ProgressBar.Bar.Normal;
+			VisualStyles.VisualStyleRenderer rndr = new System.Windows.Forms.VisualStyles.VisualStyleRenderer(element);
+			rndr.DrawBackground(dc, ctrl.ClientRectangle, clip_rect);
+
+			element = VisualStyles.VisualStyleElement.ProgressBar.Chunk.Normal;
+			rndr = new System.Windows.Forms.VisualStyles.VisualStyleRenderer(element);
+
+			Rectangle client_area = ctrl.client_area;
+
+			/* Draw Blocks */
+			int draw_mode = 0;
+			int max_blocks = int.MaxValue;
+			int start_pixel = client_area.X;
+#if NET_2_0
+			draw_mode = (int)ctrl.Style;
+#endif
+			switch (draw_mode)
+			{
+#if NET_2_0
+				case 1:
+					{ // Continuous
+						int pixels_to_draw = (int)(client_area.Width * ((double)(ctrl.Value - ctrl.Minimum) / (double)(Math.Max(ctrl.Maximum - ctrl.Minimum, 1))));
+						rndr.DrawBackground(dc, new Rectangle(client_area.X, client_area.Y, pixels_to_draw, client_area.Height));
+						break;
+					}
+				case 2: // Marquee
+					if (XplatUI.ThemesEnabled)
+					{
+						int ms_diff = (int)(DateTime.Now - ctrl.start).TotalMilliseconds;
+						double percent_done = (double)ms_diff % (double)ctrl.MarqueeAnimationSpeed / (double)ctrl.MarqueeAnimationSpeed;
+						max_blocks = 5;
+						start_pixel = client_area.X + (int)(client_area.Width * percent_done);
+					}
+					goto case 0;
+#endif
+				case 0:
+				default:  // Blocks
+					Rectangle block_rect;
+					int space_betweenblocks = 1;
+					int block_width;
+					int increment;
+					int barpos_pixels;
+					int block_count = 0;
+
+                                        block_width = 6; // (client_area.Height * 2) / 3;
+					barpos_pixels = ((ctrl.Value - ctrl.Minimum) * client_area.Width) / (Math.Max(ctrl.Maximum - ctrl.Minimum, 1));
+					increment = block_width + space_betweenblocks;
+
+					block_rect = new Rectangle(start_pixel, client_area.Y, block_width, client_area.Height);
+					while (true) {
+						if (max_blocks != int.MaxValue) {
+							if (block_count >= max_blocks)
+								break;
+							if (block_rect.X > client_area.Width)
+								block_rect.X -= client_area.Width;
+						} else {
+							if ((block_rect.X - client_area.X) >= barpos_pixels)
+								break;
+						}
+
+						if (clip_rect.IntersectsWith(block_rect) == true) {
+							rndr.DrawBackground(dc, block_rect);
+						}
+
+						block_rect.X += increment;
+						block_count++;
+					}
+					break;
+
+			}
+		}
+		#endregion	// ProgressBar
+
+                #region RadioButton
+#if NET_2_0
+		public override void DrawRadioButton (Graphics g, RadioButton rb, Rectangle glyphArea, Rectangle textBounds, Rectangle imageBounds, Rectangle clipRectangle)
+		{
+			// Draw Button Background
+			if (rb.FlatStyle == FlatStyle.Flat || rb.FlatStyle == FlatStyle.Popup) {
+				glyphArea.Height -= 2;
+				glyphArea.Width -= 2;
+			}
+			
+			DrawRadioButtonGlyph (g, rb, glyphArea);
+
+			// If we have an image, draw it
+			if (imageBounds.Size != Size.Empty)
+				DrawRadioButtonImage (g, rb, imageBounds);
+
+			if (rb.Focused && rb.Enabled && rb.ShowFocusCues && textBounds.Size != Size.Empty)
+				DrawRadioButtonFocus (g, rb, textBounds);
+
+			// If we have text, draw it
+                        if (textBounds != Rectangle.Empty) {
+                                VisualStyles.VisualStyleElement element;
+                                if (rb.Checked) {
+                                        if (rb.Enabled == false)
+                                                element = VisualStyles.VisualStyleElement.Button.RadioButton.CheckedDisabled;
+                                        else if (rb.Entered)
+                                                element = VisualStyles.VisualStyleElement.Button.RadioButton.CheckedHot;
+                                        else if (rb.Pressed)
+                                                element = VisualStyles.VisualStyleElement.Button.RadioButton.CheckedPressed;
+                                        else
+                                                element = VisualStyles.VisualStyleElement.Button.RadioButton.CheckedNormal;
+                                } else {
+                                        if (rb.Enabled == false)
+                                                element = VisualStyles.VisualStyleElement.Button.RadioButton.UncheckedDisabled;
+                                        else if (rb.Entered)
+                                                element = VisualStyles.VisualStyleElement.Button.RadioButton.UncheckedHot;
+                                        else if (rb.Pressed)
+                                                element = VisualStyles.VisualStyleElement.Button.RadioButton.UncheckedPressed;
+                                        else
+                                                element = VisualStyles.VisualStyleElement.Button.RadioButton.UncheckedNormal;
+                                }
+                                VisualStyles.VisualStyleRenderer rndr = new System.Windows.Forms.VisualStyles.VisualStyleRenderer (element);
+                                rndr.DrawBackground (g, glyphArea);
+                                rndr.DrawText (g, textBounds, rb.Text, !rb.Enabled, TextFormatFlags.Default);
+                        }
+		}
+
+		public override void DrawRadioButtonGlyph (Graphics g, RadioButton rb, Rectangle glyphArea)
+		{
+                        VisualStyles.VisualStyleElement element;
+                        if (rb.Checked) {
+                                if (rb.Enabled == false)
+                                        element = VisualStyles.VisualStyleElement.Button.RadioButton.CheckedDisabled;
+                                else if (rb.Entered)
+                                        element = VisualStyles.VisualStyleElement.Button.RadioButton.CheckedHot;
+                                else if (rb.Pressed)
+                                        element = VisualStyles.VisualStyleElement.Button.RadioButton.CheckedPressed;
+                                else
+                                        element = VisualStyles.VisualStyleElement.Button.RadioButton.CheckedNormal;
+                        } else {
+                                if (rb.Enabled == false)
+                                        element = VisualStyles.VisualStyleElement.Button.RadioButton.UncheckedDisabled;
+                                else if (rb.Entered)
+                                        element = VisualStyles.VisualStyleElement.Button.RadioButton.UncheckedHot;
+                                else if (rb.Pressed)
+                                        element = VisualStyles.VisualStyleElement.Button.RadioButton.UncheckedPressed;
+                                else
+                                        element = VisualStyles.VisualStyleElement.Button.RadioButton.UncheckedNormal;
+                        }
+
+                        VisualStyles.VisualStyleRenderer rndr = new System.Windows.Forms.VisualStyles.VisualStyleRenderer (element);
+                        rndr.DrawBackground (g, glyphArea);
+		}
+#endif
+                #endregion      // RadioButton
+
+                #region ScrollBar
+                public override void DrawScrollBar(Graphics dc, Rectangle clip, ScrollBar bar)
+		{
+			VisualStyles.VisualStyleElement element;
+			VisualStyles.VisualStyleRenderer rndr;
+
+			int scrollbutton_width = bar.scrollbutton_width;
+			int scrollbutton_height = bar.scrollbutton_height;
+
+			if (bar.vert)
+			{
+				bar.FirstArrowArea = new Rectangle (0, 0, bar.Width, scrollbutton_height);
+				bar.SecondArrowArea = new Rectangle(0, bar.ClientRectangle.Height - scrollbutton_height, bar.Width, scrollbutton_height);
+				Rectangle thumb_pos = bar.ThumbPos;
+				thumb_pos.Width = bar.Width;
+				bar.ThumbPos = thumb_pos;
+
+				/* Background, upper track */
+				if(bar.thumb_moving == ScrollBar.ThumbMoving.Backwards)
+					element = VisualStyles.VisualStyleElement.ScrollBar.LowerTrackVertical.Pressed;
+				else
+					element = bar.Enabled ? VisualStyles.VisualStyleElement.ScrollBar.LowerTrackVertical.Normal : VisualStyles.VisualStyleElement.ScrollBar.LowerTrackVertical.Disabled;
+				rndr = new System.Windows.Forms.VisualStyles.VisualStyleRenderer (element);
+				Rectangle upper_track_rect = new Rectangle (0, 0, bar.ClientRectangle.Width, bar.ThumbPos.Top);
+				if (clip.IntersectsWith (upper_track_rect))
+					rndr.DrawBackground (dc, upper_track_rect, clip);
+
+				/* Background, lower track */
+				if (bar.thumb_moving == ScrollBar.ThumbMoving.Forward)
+					element = VisualStyles.VisualStyleElement.ScrollBar.LowerTrackVertical.Pressed;
+				else
+					element = bar.Enabled ? VisualStyles.VisualStyleElement.ScrollBar.LowerTrackVertical.Normal : VisualStyles.VisualStyleElement.ScrollBar.LowerTrackVertical.Disabled;
+				rndr = new System.Windows.Forms.VisualStyles.VisualStyleRenderer (element);
+				Rectangle lower_track_rect = new Rectangle (0, bar.ThumbPos.Bottom, bar.ClientRectangle.Width, bar.ClientRectangle.Height - bar.ThumbPos.Bottom);
+				if (clip.IntersectsWith (lower_track_rect))
+					rndr.DrawBackground (dc, lower_track_rect, clip);
+
+				/* Buttons */
+				if (clip.IntersectsWith (bar.FirstArrowArea)) {
+                                        if (bar.Enabled == false)
+                                                element = VisualStyles.VisualStyleElement.ScrollBar.ArrowButton.UpDisabled;
+                                        else if (bar.firstbutton_state == ButtonState.Pushed)
+                                                element = VisualStyles.VisualStyleElement.ScrollBar.ArrowButton.UpPressed;
+                                        else if (bar.firstbutton_entered)
+                                                element = VisualStyles.VisualStyleElement.ScrollBar.ArrowButton.UpHot;
+					else if(bar.Entered && IsVista)
+                                                element = VisualStyles.VisualStyleElement.ScrollBar.ArrowButton.UpHover;
+                                        else
+                                                element = VisualStyles.VisualStyleElement.ScrollBar.ArrowButton.UpNormal;
+					rndr = new System.Windows.Forms.VisualStyles.VisualStyleRenderer (element);
+					rndr.DrawBackground (dc, bar.FirstArrowArea);
+				}
+				if (clip.IntersectsWith (bar.SecondArrowArea)) {
+                                        if (bar.Enabled == false)
+                                                element = VisualStyles.VisualStyleElement.ScrollBar.ArrowButton.DownDisabled;
+                                        else if (bar.secondbutton_state == ButtonState.Pushed)
+                                                element = VisualStyles.VisualStyleElement.ScrollBar.ArrowButton.DownPressed;
+                                        else if (bar.secondbutton_entered)
+                                                element = VisualStyles.VisualStyleElement.ScrollBar.ArrowButton.DownHot;
+					else if(bar.Entered && IsVista)
+                                                element = VisualStyles.VisualStyleElement.ScrollBar.ArrowButton.DownHover;
+                                        else
+                                                element = VisualStyles.VisualStyleElement.ScrollBar.ArrowButton.DownNormal;
+					rndr = new System.Windows.Forms.VisualStyles.VisualStyleRenderer (element);
+					rndr.DrawBackground (dc, bar.SecondArrowArea);
+				}
+
+				/* Thumb and grip */
+                                if (bar.Enabled == false)
+                                        element = VisualStyles.VisualStyleElement.ScrollBar.LowerTrackVertical.Disabled;
+                                else if (bar.thumb_state == ButtonState.Pushed)
+                                        element = VisualStyles.VisualStyleElement.ScrollBar.ThumbButtonVertical.Pressed;
+                                else if (bar.thumb_entered)
+                                        element = VisualStyles.VisualStyleElement.ScrollBar.ThumbButtonVertical.Hot;
+                                else
+                                        element = VisualStyles.VisualStyleElement.ScrollBar.ThumbButtonVertical.Normal;
+				rndr = new System.Windows.Forms.VisualStyles.VisualStyleRenderer (element);
+				rndr.DrawBackground (dc, bar.ThumbPos, clip);
+
+				if (bar.Enabled && bar.ThumbPos.Height >= 20) {
+                                        if (bar.Enabled == false)
+                                                element = VisualStyles.VisualStyleElement.ScrollBar.GripperVertical.Disabled;
+                                        else if (bar.thumb_state == ButtonState.Pushed)
+                                                element = VisualStyles.VisualStyleElement.ScrollBar.GripperVertical.Pressed;
+                                        else if (bar.thumb_entered)
+                                                element = VisualStyles.VisualStyleElement.ScrollBar.GripperVertical.Hot;
+                                        else
+                                                element = VisualStyles.VisualStyleElement.ScrollBar.GripperVertical.Normal;
+					rndr = new System.Windows.Forms.VisualStyles.VisualStyleRenderer (element);
+					rndr.DrawBackground (dc, bar.ThumbPos, clip);
+				}
+			}
+			else
+			{
+				bar.FirstArrowArea = new Rectangle(0, 0, scrollbutton_width, bar.Height);
+				bar.SecondArrowArea = new Rectangle (bar.ClientRectangle.Width - scrollbutton_width, 0, scrollbutton_width, bar.Height);
+				Rectangle thumb_pos = bar.ThumbPos;
+				thumb_pos.Height = bar.Height;
+				bar.ThumbPos = thumb_pos;
+
+				/* Background, left track */
+				if (bar.thumb_moving == ScrollBar.ThumbMoving.Backwards)
+					element = VisualStyles.VisualStyleElement.ScrollBar.LeftTrackHorizontal.Pressed;
+				else
+					element = bar.Enabled ? VisualStyles.VisualStyleElement.ScrollBar.LeftTrackHorizontal.Normal : VisualStyles.VisualStyleElement.ScrollBar.LeftTrackHorizontal.Disabled;
+				rndr = new System.Windows.Forms.VisualStyles.VisualStyleRenderer (element);
+				Rectangle left_track_rect = new Rectangle (0, 0, bar.ThumbPos.Left, bar.ClientRectangle.Height);
+				if (clip.IntersectsWith (left_track_rect))
+					rndr.DrawBackground (dc, left_track_rect, clip);
+
+				/* Background, right track */
+                                if (bar.thumb_moving == ScrollBar.ThumbMoving.Forward)
+                                        element = VisualStyles.VisualStyleElement.ScrollBar.RightTrackHorizontal.Pressed;
+                                else
+                                        element = bar.Enabled ? VisualStyles.VisualStyleElement.ScrollBar.RightTrackHorizontal.Normal : VisualStyles.VisualStyleElement.ScrollBar.RightTrackHorizontal.Disabled;
+				rndr = new System.Windows.Forms.VisualStyles.VisualStyleRenderer (element);
+				Rectangle right_track_rect = new Rectangle (bar.ThumbPos.Right, 0, bar.ClientRectangle.Width - bar.ThumbPos.Right, bar.ClientRectangle.Height);
+				if (clip.IntersectsWith (right_track_rect))
+					rndr.DrawBackground (dc, right_track_rect, clip);
+
+				/* Buttons */
+				if (clip.IntersectsWith (bar.FirstArrowArea)) {
+                                        if (bar.Enabled == false)
+                                                element = VisualStyles.VisualStyleElement.ScrollBar.ArrowButton.LeftDisabled;
+                                        else if (bar.firstbutton_state == ButtonState.Pushed)
+                                                element = VisualStyles.VisualStyleElement.ScrollBar.ArrowButton.LeftPressed;
+                                        else if (bar.firstbutton_entered)
+                                                element = VisualStyles.VisualStyleElement.ScrollBar.ArrowButton.LeftHot;
+					else if(bar.Entered && IsVista)
+                                                element = VisualStyles.VisualStyleElement.ScrollBar.ArrowButton.LeftHover;
+                                        else
+                                                element = VisualStyles.VisualStyleElement.ScrollBar.ArrowButton.LeftNormal;
+					rndr = new System.Windows.Forms.VisualStyles.VisualStyleRenderer (element);
+					rndr.DrawBackground (dc, bar.FirstArrowArea);
+				}
+				if (clip.IntersectsWith (bar.SecondArrowArea)) {
+                                        if (bar.Enabled == false)
+                                                element = VisualStyles.VisualStyleElement.ScrollBar.ArrowButton.RightDisabled;
+                                        else if (bar.secondbutton_state == ButtonState.Pushed)
+                                                element = VisualStyles.VisualStyleElement.ScrollBar.ArrowButton.RightPressed;
+                                        else if (bar.secondbutton_entered)
+                                                element = VisualStyles.VisualStyleElement.ScrollBar.ArrowButton.RightHot;
+					else if(bar.Entered && IsVista)
+                                                element = VisualStyles.VisualStyleElement.ScrollBar.ArrowButton.RightHover;
+                                        else
+                                                element = VisualStyles.VisualStyleElement.ScrollBar.ArrowButton.RightNormal;
+					rndr = new System.Windows.Forms.VisualStyles.VisualStyleRenderer (element);
+					rndr.DrawBackground (dc, bar.SecondArrowArea);
+				}
+
+				/* Thumb and grip */
+                                if (bar.Enabled == false)
+                                        element = VisualStyles.VisualStyleElement.ScrollBar.RightTrackHorizontal.Disabled;
+                                else if (bar.thumb_state == ButtonState.Pushed)
+                                        element = VisualStyles.VisualStyleElement.ScrollBar.ThumbButtonHorizontal.Pressed;
+                                else if (bar.thumb_entered)
+                                        element = VisualStyles.VisualStyleElement.ScrollBar.ThumbButtonHorizontal.Hot;
+                                else
+                                        element = VisualStyles.VisualStyleElement.ScrollBar.ThumbButtonHorizontal.Normal;
+				rndr = new System.Windows.Forms.VisualStyles.VisualStyleRenderer (element);
+				rndr.DrawBackground (dc, bar.ThumbPos, clip);
+
+                                if (bar.Enabled && bar.ThumbPos.Height >= 20) {
+                                        if (bar.Enabled == false)
+                                                element = VisualStyles.VisualStyleElement.ScrollBar.GripperHorizontal.Disabled;
+                                        else if (bar.thumb_state == ButtonState.Pushed)
+                                                element = VisualStyles.VisualStyleElement.ScrollBar.GripperHorizontal.Pressed;
+                                        else if (bar.thumb_entered)
+                                                element = VisualStyles.VisualStyleElement.ScrollBar.GripperHorizontal.Hot;
+                                        else
+                                                element = VisualStyles.VisualStyleElement.ScrollBar.GripperHorizontal.Normal;
+					rndr = new System.Windows.Forms.VisualStyles.VisualStyleRenderer (element);
+					rndr.DrawBackground (dc, bar.ThumbPos, clip);
+				}
+			}
+		}
+
+		public override int ScrollBarButtonSize
+		{
+			get
+			{
+				//VisualStyles.VisualStyleElement element = VisualStyles.VisualStyleElement.ScrollBar.ArrowButton.UpNormal;
+				//VisualStyles.VisualStyleRenderer rndr = new VisualStyles.VisualStyleRenderer (element);
+				//return rndr.GetPartSize (IntPtr.Zero, VisualStyles.ThemeSizeType.Draw).Width;
+                                return  XplatUIWin32.Win32GetSystemMetrics(XplatUIWin32.SystemMetrics.SM_CXVSCROLL);
+			}
+		}
+		#endregion
+
+                #region TabControl
+
+                public override void DrawTabControl(Graphics dc, Rectangle area, TabControl tab)
+                {
+                        VisualStyles.VisualStyleElement element = VisualStyles.VisualStyleElement.Tab.Body.Normal;
+                        VisualStyles.VisualStyleRenderer rndr = new System.Windows.Forms.VisualStyles.VisualStyleRenderer (element);
+                        rndr.DrawBackground (dc, tab.ClientRectangle, area);
+
+                        int start = 0;
+                        int end = tab.TabPages.Count;
+                        int delta = 1;
+
+                        if (tab.Alignment == TabAlignment.Top) {
+                                start = end;
+                                end = 0;
+                                delta = -1;
+                        }
+                        int counter = start;
+                        for (; counter != end; counter += delta) {
+                                for (int i = tab.SliderPos; i < tab.TabPages.Count; i++) {
+                                        if (counter != tab.TabPages[i].Row)
+                                                continue;
+                                        Rectangle rect = tab.GetTabRect (i);
+                                        if (!rect.IntersectsWith (area))
+                                                continue;
+                                        DrawTab (dc, tab.TabPages[i], tab, rect, i == tab.SelectedIndex);
+                                }
+                        }
+
+                        /* if (tab.SelectedIndex != -1 && tab.SelectedIndex >= tab.SliderPos) {
+                                Rectangle rect = tab.GetTabRect (tab.SelectedIndex);
+                                if (rect.IntersectsWith (area))
+                                        DrawTab (dc, tab.TabPages[tab.SelectedIndex], tab, rect, true);
+                        }
+
+                        if (tab.ShowSlider) {
+                                Rectangle right = GetRightScrollRect (tab);
+                                Rectangle left = GetLeftScrollRect (tab);
+                                ControlPaint.DrawScrollButton (dc, right, ScrollButton.Right, tab.RightSliderState);
+                                ControlPaint.DrawScrollButton (dc, left, ScrollButton.Left, tab.LeftSliderState);
+                        }
+                        */
+                }
+
+                protected virtual void DrawTab(Graphics dc, System.Windows.Forms.TabPage page, System.Windows.Forms.TabControl tab, Rectangle bounds, bool is_selected)
+                {
+                        VisualStyles.VisualStyleElement element;
+                        if(tab.Enabled == false)
+                                element = VisualStyles.VisualStyleElement.Tab.TabItem.Disabled;
+                        else if (page.is_entered)
+                                element = VisualStyles.VisualStyleElement.Tab.TabItem.Hot;
+                        else if(is_selected)
+                                element = VisualStyles.VisualStyleElement.Tab.TabItem.Pressed;
+                        else
+                                element = VisualStyles.VisualStyleElement.Tab.TabItem.Normal;
+
+                        VisualStyles.VisualStyleRenderer rndr = new System.Windows.Forms.VisualStyles.VisualStyleRenderer (element);
+                        rndr.DrawBackground (dc, tab.ClientRectangle, bounds);
+
+                        Rectangle panel_rect = GetTabPanelRect (tab);
+                        element = VisualStyles.VisualStyleElement.Tab.Pane.Normal;
+                        rndr = new System.Windows.Forms.VisualStyles.VisualStyleRenderer (element);
+                        rndr.DrawBackground (dc, panel_rect, bounds);
+
+                        rndr.DrawText (dc, bounds, page.Text, !tab.Enabled, TextFormatFlags.HorizontalCenter | TextFormatFlags.VerticalCenter);
+                }
+
+                public Rectangle GetTabPanelRect(System.Windows.Forms.TabControl tab)
+                {
+                        // Offset the tab page (panel) from the top corner
+                        Rectangle res = new Rectangle (tab.ClientRectangle.X,
+                                tab.ClientRectangle.Y,
+                                tab.ClientRectangle.Width,
+                                tab.ClientRectangle.Height);
+
+                        if (tab.TabCount == 0)
+                                return res;
+
+                        int spacing = RowSpacing (tab).Height;
+                        Rectangle selectedTabDelta = new Rectangle (2, 2, 4, 3);
+                        int tabOffset = (tab.ItemSize.Height + spacing - (selectedTabDelta.Height - selectedTabDelta.Y)) * tab.RowCount;
+                        switch (tab.Alignment) {
+                                case TabAlignment.Top:
+                                        res.Y += tabOffset;
+                                        res.Height -= tabOffset;
+                                        break;
+                                case TabAlignment.Bottom:
+                                        res.Height -= tabOffset;
+                                        break;
+                                case TabAlignment.Left:
+                                        res.X += tabOffset;
+                                        res.Width -= tabOffset;
+                                        break;
+                                case TabAlignment.Right:
+                                        res.Width -= tabOffset;
+                                        break;
+                        }
+
+                        return res;
+                }
+
+                public virtual Size RowSpacing(System.Windows.Forms.TabControl tab)
+                {
+                        switch (tab.Appearance) {
+                                case TabAppearance.Normal:
+                                        return new Size (0, 0);
+                                case TabAppearance.Buttons:
+                                        return new Size (3, 3);
+                                case TabAppearance.FlatButtons:
+                                        return new Size (9, 3);
+                                default:
+                                        throw new Exception ("Invalid Appearance value: " + tab.Appearance);
+                        }
+                }
+
+                #endregion
+
+	} //class
+}
Index: System.Windows.Forms/XplatUIWin32.cs
===================================================================
--- System.Windows.Forms/XplatUIWin32.cs	(revision 101620)
+++ System.Windows.Forms/XplatUIWin32.cs	(working copy)
@@ -3443,7 +3443,7 @@
 		private extern static IntPtr Win32GetActiveWindow();
 
 		[DllImport ("user32.dll", EntryPoint="GetSystemMetrics", CallingConvention=CallingConvention.StdCall)]
-		private extern static int Win32GetSystemMetrics(SystemMetrics nIndex);
+		internal extern static int Win32GetSystemMetrics(SystemMetrics nIndex);
 
 		[DllImport ("shell32.dll", EntryPoint="Shell_NotifyIconW", CharSet=CharSet.Unicode, CallingConvention=CallingConvention.StdCall)]
 		private extern static bool Win32Shell_NotifyIcon(NotifyIconMessage dwMessage, ref NOTIFYICONDATA lpData);