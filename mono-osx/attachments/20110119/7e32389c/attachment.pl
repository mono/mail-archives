diff --git a/src/coreanimation.cs b/src/coreanimation.cs
index aec1ea5..5487599 100644
--- a/src/coreanimation.cs
+++ b/src/coreanimation.cs
@@ -33,6 +33,7 @@ using System.Drawing;
 #if MONOMAC
 using MonoMac.AppKit;
 using MonoMac.CoreVideo;
+using MonoMac.CoreImage;
 #else
 using MonoMac.UIKit;
 #endif
@@ -501,6 +502,8 @@ namespace MonoMac.CoreAnimation {
 		[Export ("rasterizationScale")]
 		float RasterizationScale { get; set; }
 #endif
+		[Export ("filters")]
+		CIFilter[] Filters { get; set; }
 	}
 
 	[BaseType (typeof (CALayer))]
