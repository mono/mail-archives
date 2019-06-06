Index: Graphics.cs
===================================================================
--- Graphics.cs	(revision 62643)
+++ Graphics.cs	(working copy)
@@ -52,6 +52,9 @@
 		private bool disposed = false;
 		private static float defDpiX = 0;
 		private static float defDpiY = 0;
+#if NET_2_0
+		internal IntPtr deviceContextHdc = IntPtr.Zero;
+#endif
 
 #if !NET_2_0
 		[ComVisible(false)]
@@ -1771,6 +1774,9 @@
 		{
 			IntPtr hdc;
 			GDIPlus.CheckStatus (GDIPlus.GdipGetDC (this.nativeObject, out hdc));
+#if NET_2_0
+			deviceContextHdc = hdc;
+#endif
 			return hdc;
 		}
 
@@ -2034,11 +2040,20 @@
 		{
 			Status status = GDIPlus.GdipReleaseDC (nativeObject, hdc);
 			GDIPlus.CheckStatus (status);
+
+#if NET_2_0
+			if (hdc == deviceContextHdc)
+				deviceContextHdc = IntPtr.Zero;
+#endif
+
 		}
 #if NET_2_0
 		public void ReleaseHdc()
 		{
-		      
+			if (deviceContextHdc == IntPtr.Zero)
+				throw new ArgumentException();
+
+			ReleaseHdc (deviceContextHdc);
 		}
 #endif
 		[MonoTODO]
