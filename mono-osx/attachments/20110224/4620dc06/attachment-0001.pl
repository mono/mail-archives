diff --git a/src/Make.shared b/src/Make.shared
index 16d85dc..43c099e 100644
--- a/src/Make.shared
+++ b/src/Make.shared
@@ -133,6 +133,8 @@ SHARED_CORE_SOURCE = \
 	./CoreGraphics/CGPDFPage.cs                     \
 	./CoreGraphics/CGPath.cs                        \
 	./CoreGraphics/CGPattern.cs                     \
+	./CoreGraphics/CGEnums.cs                     \
+	./CoreGraphics/CGDirectDisplay.cs                     \
 	./CoreLocation/CLEnums.cs			\
 	./CoreLocation/CoreLocation.cs			\
 	./CoreMedia/CMSampleBuffer.cs			\
diff --git a/src/OpenGL/CGLPixelFormat.cs b/src/OpenGL/CGLPixelFormat.cs
index f9a7c9b..2c0f6e6 100644
--- a/src/OpenGL/CGLPixelFormat.cs
+++ b/src/OpenGL/CGLPixelFormat.cs
@@ -33,6 +33,72 @@ using MonoMac.ObjCRuntime;
 using MonoMac.Foundation;
 
 namespace MonoMac.OpenGL {
+
+    public enum CGLErrorCode : int
+    {
+		NoError            = 0,     /* no error */
+		BadAttribute       = 10000,	/* invalid pixel format attribute  */
+		BadProperty        = 10001,	/* invalid renderer property       */
+		BadPixelFormat     = 10002,	/* invalid pixel format            */
+		BadRendererInfo    = 10003,	/* invalid renderer info           */
+		BadContext         = 10004,	/* invalid context                 */
+		BadDrawable        = 10005,	/* invalid drawable                */
+		BadDisplay         = 10006,	/* invalid graphics device         */
+		BadState           = 10007,	/* invalid context state           */
+		BadValue           = 10008,	/* invalid numerical value         */
+		BadMatch           = 10009,	/* invalid share context           */
+		BadEnumeration     = 10010,	/* invalid enumerant               */
+		BadOffScreen       = 10011,	/* invalid offscreen drawable      */
+		BadFullScreen      = 10012,	/* invalid offscreen drawable      */
+		BadWindow          = 10013,	/* invalid window                  */
+		BadAddress         = 10014,	/* invalid pointer                 */
+		BadCodeModule      = 10015,	/* invalid code module             */
+		BadAlloc           = 10016,	/* invalid memory allocation       */
+		BadConnection      = 10017 	/* invalid CoreGraphics connection */
+
+    }
+	
+	public enum CGLPixelFormatAttribute 
+	{
+		AllRenderers = 1,
+		DoubleBuffer = 5,
+		Stereo = 6,
+		AuxBuffers = 7,
+		ColorSize = 8,
+		AlphaSize = 11,
+		DepthSize = 12,
+		StencilSize = 13,
+		AccumSize = 14,
+		MinimumPolicy = 51,
+		MaximumPolicy = 52,
+		OffScreen = 53,
+		FullScreen = 54,
+		SampleBuffers = 55,
+		Samples = 56,
+		AuxDepthStencil = 57,
+		ColorFloat = 58,
+		Multisample = 59,
+		Supersample = 60,
+		SampleAlpha = 61,
+		RendererID = 70,
+		SingleRenderer = 71,
+		NoRecovery = 72,
+		Accelerated = 73,
+		ClosestPolicy = 74,
+		Robust = 75,
+		BackingStore = 76,
+		MPSafe = 78,
+		Window = 80,
+		MultiScreen = 81,
+		Compliant = 83,
+		ScreenMask = 84,
+		PixelBuffer = 90,
+		RemotePixelBuffer = 91,
+		AllowOfflineRenderers = 96,
+		AcceleratedCompute = 97,
+		VirtualScreenCount = 128
+	}
+	
 	public class CGLPixelFormat : INativeObject, IDisposable {
 		internal IntPtr handle;
 
@@ -86,5 +152,29 @@ namespace MonoMac.OpenGL {
 				handle = IntPtr.Zero;
 			}
 		}
+		
+		[DllImport (Constants.OpenGLLibrary)]
+        extern static CGLErrorCode CGLChoosePixelFormat(CGLPixelFormatAttribute[] attributes, IntPtr pix, IntPtr npix);
+        public CGLPixelFormat(CGLPixelFormatAttribute[] attributes, out int npix)
+        {
+			
+			IntPtr pixelFormatOut = Marshal.AllocHGlobal (Marshal.SizeOf (typeof (IntPtr)));
+			IntPtr npixOut = Marshal.AllocHGlobal (Marshal.SizeOf (typeof (IntPtr)));
+			
+			CGLErrorCode ret = CGLChoosePixelFormat (attributes, pixelFormatOut, npixOut );
+
+			if (ret != CGLErrorCode.NoError) {
+				Marshal.FreeHGlobal (pixelFormatOut);
+				Marshal.FreeHGlobal (npixOut);
+				throw new Exception ("CGLChoosePixelFormat returned: " + ret);
+			}
+
+			this.handle = Marshal.ReadIntPtr (pixelFormatOut);
+			npix = Marshal.ReadInt32(npixOut);
+			Marshal.FreeHGlobal (pixelFormatOut);
+			Marshal.FreeHGlobal (npixOut);
+			
+        }
+		
 	}
 }
