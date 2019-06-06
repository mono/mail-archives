diff --git a/src/appkit.cs b/src/appkit.cs
index 2977f4b..199f033 100755
--- a/src/appkit.cs
+++ b/src/appkit.cs
@@ -63,7 +63,7 @@ namespace MonoMac.AppKit {
 	
 		[Export ("tag")]
 		int Tag  { get; set; }
-	
+			
 	}
 
 	[BaseType (typeof (NSObject), Delegates=new string [] { "Delegate" }, Events=new Type [] { typeof (NSAnimationDelegate)})]
diff --git a/src/webkit.cs b/src/webkit.cs
index 326dc0e..c30a067 100644
--- a/src/webkit.cs
+++ b/src/webkit.cs
@@ -1314,7 +1314,7 @@ namespace MonoMac.WebKit {
 		void LoadData (NSData data, string mimeType, string textDncodingName, NSUrl baseUrl);
 
 		[Export ("loadHTMLString:baseURL:")]
-		void LoadHtmlString (NSString htmlString, NSUrl baseUrl);
+		void LoadHtmlString (NSString htmlString, [NullAllowed] NSUrl baseUrl);
 
 		[Export ("loadAlternateHTMLString:baseURL:forUnreachableURL:")]
 		void LoadAlternateHtmlString (string htmlString, NSUrl baseURL, NSUrl forUnreachableURL);
