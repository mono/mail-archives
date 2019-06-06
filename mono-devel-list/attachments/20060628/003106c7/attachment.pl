--- NetworkStream.cs.old	2006-06-28 15:24:04.000000000 +0530
+++ NetworkStream.cs	2006-06-28 15:21:01.000000000 +0530
@@ -3,7 +3,8 @@
//
// Author:
//   Miguel de Icaza (miguel@ximian.com)
-//
+//NET 2.0:
+//  Sridhar Kulkarni <sridharkulkarni@gmail.com>
// (C) 2002 Ximian, Inc. http://www.ximian.com
//

@@ -30,6 +31,8 @@

using System.IO;
using System.Runtime.InteropServices;
+using System.Threading;
+using System.Timers;

namespace System.Net.Sockets
{
@@ -39,6 +42,8 @@
		bool owns_socket;
		bool readable, writeable;
		bool disposed = false;
+        private int readTimeout = Timeout.Infinite;
+        private int writeTimeout = Timeout.Infinite;

		public NetworkStream (Socket socket)
			: this (socket, FileAccess.ReadWrite, false)
@@ -119,6 +124,35 @@
			}
		}

+#if NET_2_0 //Sri
+        public override bool CanTimeout {
+            get {
+                return (true);
+            }
+        }
+
+        public override int ReadTimeout {
+            get {
+                return (ReadTimeout);
+            }
+            set {
+                if (value <=0 && value == Timeout.Infinite)
+                    throw new ArgumentOutOfRangeException("The value 
specified is less than or equal to zero and is not Infinite");
+                readTimeout = value;
+            }
+        }
+        public override int WriteTimeout {
+            get {
+                return (writeTimeout);
+            }
+            set {
+                if (value <=0 && value == Timeout.Infinite)
+                    throw new ArgumentOutOfRangeException("The value 
specified is less than or equal to zero and is not Infinite");
+                writeTimeout = value;
+            }
+        }
+#endif
+
		protected bool Readable {
			get {
				return readable;
@@ -205,7 +239,26 @@
		{
			((IDisposable) this).Dispose ();
		}
+#if NET_2_0
+        public void Close (int timeout) {
+            if (timeout < -1)
+                throw new ArgumentOutOfRangeException("timeout is less than 
-1");
+            else{
+                System.Timers.Timer closTimer = new System.Timers.Timer();
+                try {
+                    closTimer.Elapsed+= new 
ElapsedEventHandler(OnTimeoutClose);
+                    closTimer.Interval = timeout;
+                    closTimer.Enabled = true;
+                }finally {
+                    closTimer.Close();
+                }
+            }
+        }

+        private static void OnTimeoutClose(object source, ElapsedEventArgs 
e){
+            ((IDisposable)this).Dispose();
+        }
+#endif
		protected
#if NET_2_0
		override

