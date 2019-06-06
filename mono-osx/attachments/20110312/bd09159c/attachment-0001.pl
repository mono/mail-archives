diff --git a/src/Makefile b/src/Makefile
index e1356b2..9c0e194 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -32,6 +32,7 @@ CORE_SOURCES =					\
 	./OpenGL/CGLEnums.cs				\
 	./OpenGL/CGLContext.cs				\
 	./OpenGL/CGLPixelFormat.cs			\
+	./OpenGL/CGLCurrent.cs				\
 	./WebKit/Enums.cs
 
 # Sources that are not part of CORE_SOURCES or the generated templates
@@ -168,6 +169,7 @@ all: MonoMac.dll
 
 update: MonoMac.dll
 	cp MonoMac.dll* ~/.config/MonoDevelop/addins/MonoDevelop.MonoMac.2.4.*/
+	cp MonoMac.dll* /Applications/MonoDevelop.app/Contents/MacOS/lib/monodevelop/AddIns/MonoDevelop.MonoMac/
 
 push-to-monodevelop:
 	cp MonoMac.dll* /cvs/monodevelop/extras/MonoDevelop.MonoMac/MonoDevelop.MonoMac
diff --git a/src/OpenGL/CGLCurrent.cs b/src/OpenGL/CGLCurrent.cs
new file mode 100644
index 0000000..faae04a
--- /dev/null
+++ b/src/OpenGL/CGLCurrent.cs
@@ -0,0 +1,52 @@
+//
+// Author: Kenneth J. Pouncey
+//
+// Permission is hereby granted, free of charge, to any person obtaining
+// a copy of this software and associated documentation files (the
+// "Software"), to deal in the Software without restriction, including
+// without limitation the rights to use, copy, modify, merge, publish,
+// distribute, sublicense, and/or sell copies of the Software, and to
+// permit persons to whom the Software is furnished to do so, subject to
+// the following conditions:
+// 
+// The above copyright notice and this permission notice shall be
+// included in all copies or substantial portions of the Software.
+// 
+// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
+// LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
+// OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
+// WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+//
+using System;
+using System.Runtime.InteropServices;
+
+using MonoMac.ObjCRuntime;
+using MonoMac.Foundation;
+
+namespace MonoMac.OpenGL {
+
+	public static class CGLCurrent
+	{
+		[DllImport (Constants.OpenGLLibrary)]
+		extern static CGLErrorCode CGLSetCurrentContext (IntPtr ctx);
+		public static CGLErrorCode SetContext (CGLContext ctx)
+		{
+			return CGLSetCurrentContext (ctx.Handle);
+		}
+
+		[DllImport (Constants.OpenGLLibrary)]
+		extern static IntPtr CGLGetCurrentContext ();
+		public static CGLContext GetContext ()
+		{
+			IntPtr ctx = CGLGetCurrentContext();
+			if (ctx != IntPtr.Zero)
+				return new CGLContext(ctx);
+			else
+				return null;
+		}
+	}
+
+} 
