diff --git a/src/ObjCRuntime/Dlfcn.cs b/src/ObjCRuntime/Dlfcn.cs
index c69f94b..ab7d6c0 100644
--- a/src/ObjCRuntime/Dlfcn.cs
+++ b/src/ObjCRuntime/Dlfcn.cs
@@ -43,6 +43,9 @@ namespace MonoMac.ObjCRuntime {
 
 		[DllImport (Constants.SystemLibrary)]
 		static extern IntPtr dlsym (IntPtr handle, string symbol);
+		
+		[DllImport (Constants.SystemLibrary)]
+		public static extern string dlerror ();
 
 		public static NSString GetStringConstant (IntPtr handle, string symbol)
 		{
diff --git a/src/coreanimation.cs b/src/coreanimation.cs
index aec1ea5..714634b 100644
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
+		CIFilter[] Filters { get; set; }		
 #else
 		[Since (3,2)]
 		[Export ("shouldRasterize")]
