diff --git a/src/ImageIO/CGImageDestination.cs b/src/ImageIO/CGImageDestination.cs
index 1aedfc0..5e1aa5e 100644
--- a/src/ImageIO/CGImageDestination.cs
+++ b/src/ImageIO/CGImageDestination.cs
@@ -137,7 +137,8 @@ namespace MonoMac.ImageIO {
 
 			var dict = options == null ? null : options.ToDictionary ();
 			var ret = new CGImageDestination (CGImageDestinationCreateWithData (data.Handle, new NSString (typeIdentifier).Handle, (IntPtr) imageCount, dict == null ? IntPtr.Zero : dict.Handle));
-			dict.Dispose ();
+                        if (dict != null)
+                                dict.Dispose ();
 			return ret;
 		}
 
@@ -158,7 +159,8 @@ namespace MonoMac.ImageIO {
 
 			var dict = options == null ? null : options.ToDictionary ();
 			var ret = new CGImageDestination (CGImageDestinationCreateWithURL (url.Handle, new NSString (typeIdentifier).Handle, (IntPtr) imageCount, dict == null ? IntPtr.Zero : dict.Handle));
-			dict.Dispose ();
+                        if (dict != null)
+			        dict.Dispose ();
 			return ret;
 		}
 
@@ -194,12 +196,13 @@ namespace MonoMac.ImageIO {
 		}
 
 		[DllImport (Constants.ImageIOLibrary)]
-		extern static void CGImageDestinationFinalize (IntPtr handle);
+		extern static bool CGImageDestinationFinalize (IntPtr handle);
 
-		public void Close ()
+		public bool Close ()
 		{
-			CGImageDestinationFinalize (handle);
+			var success = CGImageDestinationFinalize (handle);
 			Dispose ();
+                        return success;
 		}
 	}
 }
\ No newline at end of file
diff --git a/src/foundation.cs b/src/foundation.cs
index bd6efa7..165ab7b 100644
--- a/src/foundation.cs
+++ b/src/foundation.cs
@@ -125,14 +125,16 @@ namespace MonoMac.Foundation
 		[Field ("NSParagraphStyleAttributeName")]
 #endif
 		NSString ParagraphStyleAttributeName { get; }
-
+                
 #if MONOMAC
 		[Field ("NSForegroundColorAttributeName", "AppKit")]
 #else
 		[Field ("NSForegroundColorAttributeName")]
 #endif
-		NSString ForegroundColorAttributeName { get; }
-
+                NSString ForegroundColorAttributeName { get; }
+                
+                [Field ("NSLigatureAttributeName", "AppKit")]
+                NSString LigatureAttributeName { get; } 
 #if MONOMAC
 		[Export ("initWithData:options:documentAttributes:error:")]
 		IntPtr Constructor (NSData data, NSDictionary options, out NSDictionary docAttributes, out NSError error);
