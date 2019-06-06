diff --git a/src/appkit.cs b/src/appkit.cs
index 49c8375..8d854b0 100644
--- a/src/appkit.cs
+++ b/src/appkit.cs
@@ -9082,7 +9082,7 @@ namespace MonoMac.AppKit {
 		void RemoveFromSuperview ();
 
 		[Export ("replaceSubview:with:")]
-		void ReplaceSubviewwith (NSView oldView, NSView newView);
+		void ReplaceSubviewWith (NSView oldView, NSView newView);
 
 		[Export ("removeFromSuperviewWithoutNeedingDisplay")]
 		void RemoveFromSuperviewWithoutNeedingDisplay ();
@@ -9422,16 +9422,14 @@ namespace MonoMac.AppKit {
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
