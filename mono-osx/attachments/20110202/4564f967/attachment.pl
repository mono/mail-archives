diff --git a/src/appkit.cs b/src/appkit.cs
index 21c4588..fb4c22c 100644
--- a/src/appkit.cs
+++ b/src/appkit.cs
@@ -3310,7 +3310,7 @@ namespace MonoMac.AppKit {
 		[Export ("showsApplicationBadge")]
 		bool ShowsApplicationBadge { get; set; }
 
-		[Export ("badgeLabel")]
+		[Export ("badgeLabel"), NullAllowed]
 		string BadgeLabel { get; set; }
 	}
 
