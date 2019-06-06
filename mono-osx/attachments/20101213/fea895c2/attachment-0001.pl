diff --git a/src/CoreAnimation/CAEnums.cs b/src/CoreAnimation/CAEnums.cs
index ccdf9a7..017fe11 100644
--- a/src/CoreAnimation/CAEnums.cs
+++ b/src/CoreAnimation/CAEnums.cs
@@ -59,4 +59,16 @@ namespace MonoMac.CoreAnimation {
 	}
 #endif
 	
+	public enum CAConstraintAttribute
+	{
+	  MinX,
+	  MidX,
+	  MaxX,
+	  Width,
+	  MinY,
+	  MidY,
+	  MaxY,
+	  Height,
+	};
+	
 }
diff --git a/src/coreanimation.cs b/src/coreanimation.cs
index 9e7dc12..5f38401 100644
--- a/src/coreanimation.cs
+++ b/src/coreanimation.cs
@@ -453,6 +453,12 @@ namespace MonoMac.CoreAnimation {
 		[Export ("rasterizationScale")]
 		float RasterizationScale { get; set; }
 #endif
+		
+		[Export ("constraints")]
+		CAConstraint[] Constraints { get; set;  }
+
+		[Export ("addConstraint:")]
+		void AddConstraint (CAConstraint c);
 	}
 
 	[BaseType (typeof (CALayer))]
@@ -995,5 +1001,45 @@ namespace MonoMac.CoreAnimation {
 		NSString TranslateZ { get; }
 		
 	}
+	
+	[BaseType (typeof (NSObject))]
+	interface CAConstraintLayoutManager {
+		[Static]
+		[Export ("layoutManager")]
+		CAConstraintLayoutManager LayoutManager ();
+
+	}
+	
+	[BaseType (typeof (NSObject))]
+	interface CAConstraint {
+		[Export ("attribute")]
+		CAConstraintAttribute Attribute { get;  }
+
+		[Export ("sourceName")]
+		string SourceName { get;  }
+
+		[Export ("sourceAttribute")]
+		CAConstraintAttribute SourceAttribute { get;  }
+
+		[Export ("scale")]
+		float Scale { get;  }
+
+		[Static]
+		[Export ("constraintWithAttribute:relativeTo:attribute:scale:offset:")]
+		CAConstraint RelativeToScaleOffset (CAConstraintAttribute attr, string srcId, CAConstraintAttribute srcAttr, float m, float c);
+
+		[Static]
+		[Export ("constraintWithAttribute:relativeTo:attribute:offset:")]
+		CAConstraint RelativeToOffset (CAConstraintAttribute attr, string srcId, CAConstraintAttribute srcAttr, float c);
+
+		[Static]
+		[Export ("constraintWithAttribute:relativeTo:attribute:")]
+		CAConstraint RelatvieToAttribute (CAConstraintAttribute attr, string srcId, CAConstraintAttribute srcAttr);
+
+		[Export ("initWithAttribute:relativeTo:attribute:scale:offset:")]
+		IntPtr Constructor (CAConstraintAttribute attr, string srcId, CAConstraintAttribute srcAttr, float m, float c);
+
+	}
+	
 }
 
