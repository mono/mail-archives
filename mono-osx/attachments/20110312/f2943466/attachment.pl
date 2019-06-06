diff --git a/src/Foundation/Enum.cs b/src/Foundation/Enum.cs
index b823a30..6a99c1b 100644
--- a/src/Foundation/Enum.cs
+++ b/src/Foundation/Enum.cs
@@ -301,5 +301,14 @@ namespace MonoMac.Foundation  {
 		Not,
 		And,
 		Or
-	}	
+	}
+	
+	public enum NSStringDrawingOptions : uint {
+		UsesLineFragmentOrigin = (1 << 0),
+		UsesFontLeading = (1 << 1),
+		DisableScreenFontSubstitution = (1 << 2),
+		UsesDeviceMetrics = (1 << 3),
+		OneShot = (1 << 4),
+		TruncatesLastVisibleLine = (1 << 5)
+	}		
 }
diff --git a/src/foundation.cs b/src/foundation.cs
index 1b4f0a8..7939fd8 100644
--- a/src/foundation.cs
+++ b/src/foundation.cs
@@ -148,6 +148,13 @@ namespace MonoMac.Foundation
 
 		[Export ("initWithHTML:baseURL:documentAttributes:")]
 		IntPtr Constructor (NSData htmlData, NSUrl baseUrl, out NSDictionary docAttributes);
+
+		[Export ("drawAtPoint:")]
+		void DrawString (PointF point);
+		
+		[Export ("drawInRect:")]
+		void DrawString (RectangleF rect);        
+
 #endif
 	}
 
@@ -2224,8 +2231,17 @@ namespace MonoMac.Foundation
 	[BaseType (typeof (NSObject)), Bind ("NSString")]
 	public interface NSString2 {
 #if MONOMAC
+		[Bind ("boundingRectWithSize:options:attributes:")]
+		SizeF BoundingRectWithSize (SizeF size, NSStringDrawingOptions options, NSDictionary attributes);
+		
 		[Bind ("sizeWithAttributes:")]
 		SizeF StringSize (NSDictionary attributedStringAttributes);
+		
+		[Export ("drawAtPoint:withAttributes:")]
+		void DrawString (PointF point, NSDictionary attributes);       
+		
+		[Export ("drawWithRect:options:attributes:")]
+		void DrawString (RectangleF rect, NSStringDrawingOptions options, NSDictionary attributes);       
 #else
 		[Bind ("sizeWithFont:")]
 		SizeF StringSize (UIFont font);
