--- mcs/class/Managed.Windows.Forms/System.Windows.Forms/XplatUIX11.cs.old	2007-05-23 04:52:54.000000000 +0200
+++ mcs/class/Managed.Windows.Forms/System.Windows.Forms/XplatUIX11.cs	2007-05-23 04:52:28.000000000 +0200
@@ -3272,6 +3272,9 @@
 
 		internal override void DrawReversibleLine(Point start, Point end, Color backColor)
 		{
+			if (backColor.GetBrightness() < 0.5)
+				backColor = Color.FromArgb(255 - backColor.R, 255 - backColor.G, 255 - backColor.B);
+
 			IntPtr gc = GetReversibleScreenGC (backColor);
 
 			XDrawLine (DisplayHandle, RootWindow, gc, start.X, start.Y, end.X, end.Y);
@@ -3281,6 +3284,9 @@
 
 		internal override void DrawReversibleFrame (Rectangle rectangle, Color backColor, FrameStyle style)
 		{
+			if (backColor.GetBrightness() < 0.5)
+				backColor = Color.FromArgb(255 - backColor.R, 255 - backColor.G, 255 - backColor.B);
+
 			IntPtr gc = GetReversibleScreenGC (backColor);
 
 			if (rectangle.Width < 0) {
