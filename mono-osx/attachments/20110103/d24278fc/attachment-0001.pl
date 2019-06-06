diff --git a/samples/Rulers/RectsView.cs b/samples/Rulers/RectsView.cs
index 9949e14..00db096 100644
--- a/samples/Rulers/RectsView.cs
+++ b/samples/Rulers/RectsView.cs
@@ -921,7 +921,7 @@ namespace Rulers
 				}
 			}
 				
-			newColor = NSColor.FromDeviceRGBA ((float)rand.NextDouble (),
+			newColor = NSColor.FromDeviceRgba ((float)rand.NextDouble (),
 			                                        (float)rand.NextDouble (),
 			                                        (float)rand.NextDouble (),
 			                                        1.0f);
