diff --git a/src/coreanimation.cs b/src/coreanimation.cs
index af5155c..aabf9a8 100644
--- a/src/coreanimation.cs
+++ b/src/coreanimation.cs
@@ -784,6 +784,23 @@ namespace MonoMac.CoreAnimation {
 
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
