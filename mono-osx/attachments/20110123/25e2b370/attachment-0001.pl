diff --git a/src/growl.cs b/src/growl.cs
index e73759f..806b07b 100644
--- a/src/growl.cs
+++ b/src/growl.cs
@@ -42,11 +42,11 @@ namespace MonoMac.Growl {
 
 		[Static]
 		[Export ("notifyWithTitle:description:notificationName:iconData:priority:isSticky:clickContext:")]
-		void Notify (string title, string description, string notifName, NSData iconData, int priority, bool isSticky, NSObject clickContext);
+		void Notify (string title, string description, string notifName, [NullAllowed] NSData iconData, int priority, bool isSticky, [NullAllowed] NSObject clickContext);
 
 		[Static]
 		[Export ("notifyWithTitle:description:notificationName:iconData:priority:isSticky:clickContext:identifier:")]
-		void Notify (string title, string description, string notifName, NSData iconData, int priority, bool isSticky, NSObject clickContext, string identifier);
+		void Notify (string title, string description, string notifName, [NullAllowed] NSData iconData, int priority, bool isSticky, [NullAllowed] NSObject clickContext, string identifier);
 
 		[Static]
 		[Export ("notifyWithDictionary:")]
