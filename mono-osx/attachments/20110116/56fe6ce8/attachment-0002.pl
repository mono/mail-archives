diff --git a/src/CoreVideo/CoreVideo.cs b/src/CoreVideo/CoreVideo.cs
index ae98105..0d9f92b 100644
--- a/src/CoreVideo/CoreVideo.cs
+++ b/src/CoreVideo/CoreVideo.cs
@@ -102,4 +102,17 @@ namespace MonoMac.CoreVideo {
 	public enum CVOptionFlags {
 		None = 0,
 	}
+
+	public struct CVTimeStamp {
+		public UInt32	Version;
+		public Int32 	VideoTimeScale;
+		public Int64 	VideoTime;
+		public UInt64 	HostTime;
+		public double 	RateScalar;
+		public Int64 	VideoRefreshPeriod;
+		public double 	SMPTETime;
+		public UInt64 	Flags;
+		public UInt64 	Reserved;
+	}
+	
 }
diff --git a/src/coreanimation.cs b/src/coreanimation.cs
index af5155c..b4a6102 100644
--- a/src/coreanimation.cs
+++ b/src/coreanimation.cs
@@ -32,6 +32,7 @@ using System;
 using System.Drawing;
 #if MONOMAC
 using MonoMac.AppKit;
+using MonoMac.CoreVideo;
 #else
 using MonoMac.UIKit;
 #endif
@@ -784,6 +785,23 @@ namespace MonoMac.CoreAnimation {
 
 		[Field ("kCATransitionFromBottom")]
 		NSString TransitionFromBottom { get; }
+		
+		/* 'calculationMode' strings. */
+		[Field ("kCAAnimationLinear")]
+		NSString AnimationLinear { get; }
+				
+		[Field ("kCAAnimationDiscrete")]
+		NSString AnimationDescrete { get; }
+		
+		[Field ("kCAAnimationPaced")]
+		NSString AnimationPaced { get; }
+		
+		/* 'rotationMode' strings. */
+		[Field ("kCAAnimationRotateAuto")]
+		NSString RotateModeAuto { get; }
+
+		[Field ("kCAAnimationRotateAutoReverse")]
+		NSString RotateModeAutoReverse { get; }
 	}
 	
 	[BaseType (typeof (NSObject))]
@@ -1045,6 +1063,31 @@ namespace MonoMac.CoreAnimation {
 		NSString TranslateZ { get; }
 		
 	}
-	
+
+	[BaseType (typeof (CALayer))]
+	interface CAOpenGLLayer {
+		[Export ("asynchronous")]
+		bool Asynchronous { [Bind ("isAsynchronous")]get; set; }	
+
+		[Export ("canDrawInCGLContext:pixelFormat:forLayerTime:displayTime:")]
+		bool CanDrawInCGLContext (NSOpenGLContext ctx, NSOpenGLPixelFormat pf, double t, CVTimeStamp ts);
+
+		[Export ("drawInCGLContext:pixelFormat:forLayerTime:displayTime:")]
+		void DrawInCGLContext (NSOpenGLContext ctx, NSOpenGLPixelFormat pf, double t, CVTimeStamp ts);
+
+		[Export ("copyCGLPixelFormatForDisplayMask:")]
+		NSOpenGLPixelFormat CopyCGLPixelFormatForDisplayMask (UInt32 mask);
+
+		[Export ("releaseCGLPixelFormat:")]
+		void Release (NSOpenGLPixelFormat pf);
+
+		[Export ("copyCGLContextForPixelFormat:")]
+		NSOpenGLContext CopyContext (NSOpenGLPixelFormat pf);
+
+		[Export ("releaseCGLContext:")]
+		void Release (NSOpenGLContext ctx);
+
+	}	
+
 }
 
diff --git a/src/generator.cs b/src/generator.cs
index b28995a..cb1dd55 100644
--- a/src/generator.cs
+++ b/src/generator.cs
@@ -1300,6 +1300,7 @@ public class Generator {
 		"MonoMac.CoreAnimation",
 		"MonoMac.CoreLocation", 
 		"MonoMac.QTKit",
+		"MonoMac.CoreVideo",		
 #else
 		"MonoTouch",
 		"MonoTouch.CoreFoundation",
