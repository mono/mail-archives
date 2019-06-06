diff --git a/src/coreanimation.cs b/src/coreanimation.cs
index aec1ea5..dad19fb 100644
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
@@ -488,6 +489,9 @@ namespace MonoMac.CoreAnimation {
 
 		[Export ("addConstraint:")]
 		void AddConstraint (CAConstraint c);
+		
+		[Export ("filters"), NullAllowed]
+		CIFilter [] Filters { get; set;}
 #else
 		[Since (3,2)]
 		[Export ("shouldRasterize")]
