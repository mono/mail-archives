diff --git a/src/Constants.cs b/src/Constants.cs
index ee12168..376bfb7 100644
--- a/src/Constants.cs
+++ b/src/Constants.cs
@@ -45,5 +45,5 @@ namespace MonoMac {
 		public const string CoreWlanLibrary = "/System/Library/Frameworks/CoreWLAN.framework/CoreWLAN";
 		public const string PdfKitLibrary = "/System/Library/Frameworks/Quartz.framework/Frameworks/PDFKit.framework/PDFKit";
 		public const string ImageKitLibrary = "/System/Library/Frameworks/Quartz.framework/Frameworks/ImageKit.framework/ImageKit";
-	}
+        }
 }
diff --git a/src/appkit.cs b/src/appkit.cs
index f22d8a1..c723d52 100644
--- a/src/appkit.cs
+++ b/src/appkit.cs
@@ -5430,7 +5430,7 @@ namespace MonoMac.AppKit {
 	[BaseType (typeof (NSObject))]
 	public interface NSOpenGLContext {
 		[Export ("initWithFormat:shareContext:")]
-		IntPtr Constructor (NSOpenGLPixelFormat format, NSOpenGLContext shareContext);
+		IntPtr Constructor (NSOpenGLPixelFormat format, [NullAllowed] NSOpenGLContext shareContext);
 
 		// FIXME: This conflicts with our internal ctor
 		// [Export ("initWithCGLContextObj:")]
