diff --git a/src/CoreGraphics/CGBitmapContext.cs b/src/CoreGraphics/CGBitmapContext.cs
index 027d501..c5355eb 100644
--- a/src/CoreGraphics/CGBitmapContext.cs
+++ b/src/CoreGraphics/CGBitmapContext.cs
@@ -50,7 +50,24 @@ namespace MonoMac.CoreGraphics {
 		{
 		}
 
-		[DllImport (Constants.CoreGraphicsLibrary)]
+                public CGBitmapContext (byte[] data, int width, int height, int bitsPerComponent, int bytesPerRow, CGColorSpace colorSpace, CGImageAlphaInfo bitmapInfo)
+                {
+                        IntPtr contextPtr = IntPtr.Zero;
+                        unsafe {
+                                
+                                fixed (byte* ptr = data) {
+                                        contextPtr = CGBitmapContextCreate ((IntPtr) ptr, (UIntPtr) width, (UIntPtr) height, (UIntPtr) bitsPerComponent, (UIntPtr) bytesPerRow, colorSpace.handle, (uint) bitmapInfo);
+                                }
+                        }
+                        
+                        if (contextPtr == IntPtr.Zero)
+                                throw new Exception ("Invalid parameters to context creation");
+                        
+                        CGContextRetain (contextPtr);
+                        this.handle = contextPtr;
+                }
+
+                [DllImport (Constants.CoreGraphicsLibrary)]
 		extern static IntPtr CGBitmapContextGetData (IntPtr cgContextRef);
 		public IntPtr Data {
 			get {return CGBitmapContextGetData (Handle);}
diff --git a/src/CoreGraphics/CGContext.cs b/src/CoreGraphics/CGContext.cs
index aa647ac..e81c5c0 100644
--- a/src/CoreGraphics/CGContext.cs
+++ b/src/CoreGraphics/CGContext.cs
@@ -154,7 +154,7 @@ namespace MonoMac.CoreGraphics {
 		extern static void CGContextRelease (IntPtr handle);
 		
 		[DllImport (Constants.CoreGraphicsLibrary)]
-		extern static void CGContextRetain (IntPtr handle);
+		protected extern static void CGContextRetain (IntPtr handle);
 		
 		protected virtual void Dispose (bool disposing)
 		{
