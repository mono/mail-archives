diff --git a/samples/CoreTextArcMonoMac/CoreTextArcView.cs b/samples/CoreTextArcMonoMac/CoreTextArcView.cs
index 1a160b6..a2fb83a 100644
--- a/samples/CoreTextArcMonoMac/CoreTextArcView.cs
+++ b/samples/CoreTextArcMonoMac/CoreTextArcView.cs
@@ -81,9 +81,9 @@ namespace CoreTextArcMonoMac
                                 
                         }
                 }
-
-                public override void DrawRect (RectangleF dirtyRect)
+                public override void Draw (RectangleF dirtyRect)
                 {
+
                         // Don't draw if we don't have a font or a title.
                         if (Font == null || Title == string.Empty)
                                 return;
