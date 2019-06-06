Index: System.IO/IntPtrStream.cs
===================================================================
--- System.IO/IntPtrStream.cs	(revision 47495)
+++ System.IO/IntPtrStream.cs	(working copy)
@@ -1,5 +1,5 @@
 //
-// System.IO.IntPtrStream: A stream that is backed up by unmanaged memory
+// System.IO.UnmanagedMemoryStream: A stream that is backed up by unmanaged memory
 //
 // Author:
 //   Miguel de Icaza (miguel@ximian.com)
@@ -40,23 +40,31 @@
 using System.Runtime.InteropServices;
 namespace System.IO {
 
-	internal class IntPtrStream : Stream {
+#if NET_2_0
+	public
+#else
+	internal
+#endif
+	class UnmanagedMemoryStream : Stream {
 		unsafe byte *base_address;
-		int size;
-		int position;
+		long size;
+		long position;
 		bool closed;
 
 		public event EventHandler Closed;
-		
-		public IntPtrStream (IntPtr base_address, int size)
+
+		[CLSCompliant (false)]
+		public unsafe UnmanagedMemoryStream (byte *base_address, long size)
 		{
-			unsafe {
-				this.base_address = (byte*)((void *)base_address);
-			}
+			this.base_address = base_address;
 			this.size = size;
 			position = 0;
 		}
 
+		public IntPtr PositionPointer {
+			get { unsafe { return new IntPtr (base_address + position); } }
+		}
+
 		public override bool CanRead {
 			get {
 				return true;
@@ -115,7 +123,7 @@
 				return 0;
 
 			if (position > size - count)
-				count = size - position;
+				count = (int) (size - position);
 
 			unsafe {
 				Marshal.Copy ((IntPtr) (base_address + position), buffer, offset, count);
@@ -146,7 +154,7 @@
 			if (closed)
 				throw new ObjectDisposedException ("Stream has been closed");
 
-			int ref_point;
+			long ref_point;
 			switch (loc) {
 			case SeekOrigin.Begin:
 				if (offset < 0)
@@ -165,7 +173,7 @@
 
 			checked {
 				try {
-					ref_point += (int) offset;
+					ref_point += offset;
 				} catch {
 					throw new ArgumentOutOfRangeException ("Too large seek destination");
 				}
Index: System.Reflection/Assembly.cs
===================================================================
--- System.Reflection/Assembly.cs	(revision 47495)
+++ System.Reflection/Assembly.cs	(working copy)
@@ -274,7 +274,11 @@
 			if (data == (IntPtr) 0)
 				return null;
 			else {
-				IntPtrStream stream = new IntPtrStream (data, size);
+				UnmanagedMemoryStream stream = null;
+				unsafe {
+					stream = new UnmanagedMemoryStream (
+						(byte*) ((void *) data), size);
+				}
 				/* 
 				 * The returned pointer points inside metadata, so
 				 * we have to increase the refcount of the module, and decrease