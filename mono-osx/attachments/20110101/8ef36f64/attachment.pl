diff --git a/src/Foundation/NSString2.cs b/src/Foundation/NSString2.cs
index 61b9530..6507838 100644
--- a/src/Foundation/NSString2.cs
+++ b/src/Foundation/NSString2.cs
@@ -35,7 +35,7 @@ namespace MonoMac.Foundation {
 		//static Selector selDataUsingEncoding = new Selector ("dataUsingEncoding:");
 		static IntPtr selDataUsingEncodingAllow = Selector.sel_registerName ("dataUsingEncoding:allowLossyConversion:");
 		static IntPtr selInitWithDataEncoding = Selector.sel_registerName ("initWithData:encoding:");
-
+  
 		[Obsolete("Use Encode instead")]
 		public NSData DataUsingEncoding (NSStringEncoding enc)
 		{
@@ -65,8 +65,8 @@ namespace MonoMac.Foundation {
 			h = Messaging.IntPtr_objc_msgSend_IntPtr_int (h, selInitWithDataEncoding, data.Handle, (int)encoding);
 			return new NSString (h);
 		}
-
-		public char this [int idx] {
+  
+  		public char this [int idx] {
 			get {
 				return _characterAtIndex (idx);
 			}
diff --git a/src/foundation.cs b/src/foundation.cs
index afe4f27..37e0088 100644
--- a/src/foundation.cs
+++ b/src/foundation.cs
@@ -2242,6 +2242,10 @@ namespace MonoMac.Foundation
 
 		[Export ("length")]
 		int Length {get;}
+		
+		[Static,Export ("stringWithContentsOfFile:encoding:error:")]
+                string FromFile (string path, NSStringEncoding enc, [NullAllowed] NSError error);
+		
 	}
 	
 	[BaseType (typeof (NSStream))]
