diff --git a/src/foundation.cs b/src/foundation.cs
index 1972cbf..1b4f0a8 100644
--- a/src/foundation.cs
+++ b/src/foundation.cs
@@ -1349,7 +1349,7 @@ namespace MonoMac.Foundation
 		[Field ("NSModalPanelRunLoopMode", "AppKit")]
 		NSString NSRunLoopModalPanelMode { get; }
 
-		[Field ("NSEventTrackingRunLoopMode")]
+		[Field ("NSEventTrackingRunLoopMode", "AppKit")]
 		NSString NSRunLoopEventTracking { get; }
 #endif
 	}
