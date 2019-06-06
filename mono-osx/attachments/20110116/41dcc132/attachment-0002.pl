diff --git a/src/appkit.cs b/src/appkit.cs
index 49c8375..85583b7 100644
--- a/src/appkit.cs
+++ b/src/appkit.cs
@@ -9082,7 +9082,7 @@ namespace MonoMac.AppKit {
 		void RemoveFromSuperview ();
 
 		[Export ("replaceSubview:with:")]
-		void ReplaceSubviewwith (NSView oldView, NSView newView);
+		void ReplaceSubviewWith (NSView oldView, NSView newView);
 
 		[Export ("removeFromSuperviewWithoutNeedingDisplay")]
 		void RemoveFromSuperviewWithoutNeedingDisplay ();
