diff --git a/src/Constants.cs b/src/Constants.cs
index b79c8e7..1f5bc51 100644
--- a/src/Constants.cs
+++ b/src/Constants.cs
@@ -41,5 +41,7 @@ namespace MonoMac {
 		public const string CoreLocationLibrary = "/System/Library/Frameworks/CoreLocation.framework/CoreLocation";
 		public const string SecurityLibrary = "/System/Library/Frameworks/Security.framework/Security";
 		public const string CoreVideoLibrary = "/System/Library/Frameworks/CoreVideo.framework/CoreVideo";
+		public const string QuartzComposerLibrary = "/System/Library/Frameworks/Quartz.framework/Frameworks/QuartzComposer.framework/QuartzComposer";
+		
 	}
 }
diff --git a/src/Foundation/NSObjectMac.cs b/src/Foundation/NSObjectMac.cs
index fe886a6..6920e52 100644
--- a/src/Foundation/NSObjectMac.cs
+++ b/src/Foundation/NSObjectMac.cs
@@ -39,6 +39,7 @@ namespace MonoMac.Foundation {
 		static IntPtr ql = Dlfcn.dlopen (Constants.QTKitLibrary, 1);
 		static IntPtr cl = Dlfcn.dlopen (Constants.CoreLocationLibrary, 1);
 		static IntPtr ll = Dlfcn.dlopen (Constants.SecurityLibrary, 1);
+		static IntPtr zc = Dlfcn.dlopen (Constants.QuartzComposerLibrary, 1);
 	}
 }
 
diff --git a/src/Makefile b/src/Makefile
index 5227966..68d4637 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -96,6 +96,7 @@ APIS = \
 	growl.cs		\
 	qtkit.cs		\
 	webkit.cs		\
+	composer.cs		\
 	$(SHARED_APIS)
 
 all: $(TARGETS)
diff --git a/src/appkit.cs b/src/appkit.cs
index 49c8375..daadf2f 100644
--- a/src/appkit.cs
+++ b/src/appkit.cs
@@ -160,6 +160,7 @@ namespace MonoMac.AppKit {
 
 	[BaseType (typeof (NSObject))]
 	public interface NSAnimationContext {
+		[Static]
 		[Export ("beginGrouping")]
 		void BeginGrouping ();
 
@@ -9082,7 +9083,7 @@ namespace MonoMac.AppKit {
 		void RemoveFromSuperview ();
 
 		[Export ("replaceSubview:with:")]
-		void ReplaceSubviewwith (NSView oldView, NSView newView);
+		void ReplaceSubviewWith (NSView oldView, NSView newView);
 
 		[Export ("removeFromSuperviewWithoutNeedingDisplay")]
 		void RemoveFromSuperviewWithoutNeedingDisplay ();
@@ -9422,16 +9423,14 @@ namespace MonoMac.AppKit {
 		[Export ("alphaValue")]
 		float AlphaValue { get; set; }
 
-		// FIXME: CIFilter
-		
-		//[Export ("backgroundFilters")]
-		//CIFilter [] BackgroundFilters { get; set; }
+		[Export ("backgroundFilters"), NullAllowed]
+		CIFilter [] BackgroundFilters { get; set; }
 
-		//[Export ("compositingFilter")]
-		//CIFilter CompositingFilter { get; set; }
+		[Export ("compositingFilter"), NullAllowed]
+		CIFilter CompositingFilter { get; set; }
 
-		//[Export ("contentFilters")]
-		//CIFilter [] ContentFilters { get; set; }
+		[Export ("contentFilters"), NullAllowed]
+		CIFilter [] ContentFilters { get; set; }
 
 		[Export ("shadow")]
 		NSShadow Shadow { get; set; }
diff --git a/src/coreimage.cs b/src/coreimage.cs
index 16d9121..6d06b1f 100644
--- a/src/coreimage.cs
+++ b/src/coreimage.cs
@@ -152,6 +152,9 @@ namespace MonoMac.CoreImage {
 		[Export ("attributes")]
 		NSDictionary Attributes { get; }
 
+		[Export ("name")]
+		string Name { get; set;}
+
 		[Export ("apply:arguments:options:")]
 		CIImage Applyargumentsoptions (CIKernel k, NSArray args, NSDictionary options);
 
@@ -733,4 +736,71 @@ namespace MonoMac.CoreImage {
 		[Field ("kCISamplerFilterLinear", "Quartz"), Internal]
 		NSString FilterLinear { get; }
 	}
+	
+	[BaseType (typeof (NSObject))]
+	interface CIVector {
+		//[Export ("vectorWithValues:count:")]
+		//CIVector VectorWithValuescount (const CGFloat values, size_t count);
+
+		[Static]
+		[Export ("vectorWithX:")]
+		CIVector Create (float x);
+
+		[Static]
+		[Export ("vectorWithX:Y:")]
+		CIVector Create (float x, float y);
+
+		[Static]
+		[Export ("vectorWithX:Y:Z:")]
+		CIVector Create (float x, float y, float z);
+
+		[Static]
+		[Export ("vectorWithX:Y:Z:W:")]
+		CIVector Create (float x, float y, float z, float w);
+
+		[Static]
+		[Export ("vectorWithString:")]
+		CIVector Create (string representation);
+
+		//[Export ("initWithValues:count:")]
+		//NSObject InitWithValuescount (const CGFloat values, size_t count);
+
+		[Export ("initWithX:")]
+		IntPtr Constructor(float x);
+
+		[Export ("initWithX:Y:")]
+		IntPtr Constructor (float x, float y);
+
+		[Export ("initWithX:Y:Z:")]
+		IntPtr Constructor (float x, float y, float z);
+
+		[Export ("initWithX:Y:Z:W:")]
+		IntPtr Constructor (float x, float y, float z, float w);
+
+		[Export ("initWithString:")]
+		IntPtr Constructor (string representation);
+
+		[Export ("valueAtIndex:")]
+		float ValueAtIndex (int index);
+
+		[Export ("count")]
+		int Count { get; }
+
+		[Export ("X")]
+		float X { get; }
+
+		[Export ("Y")]
+		float Y { get; }
+
+		[Export ("Z")]
+		float Z { get; }
+
+		[Export ("W")]
+		float W { get; }
+
+		[Export ("stringRepresentation")]
+		string StringRepresentation ();
+
+	}
+	
 }
