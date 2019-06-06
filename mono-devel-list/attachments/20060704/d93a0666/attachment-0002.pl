--- TcpListener.cs.old	2006-04-14 23:19:40.000000000 +0530
+++ TcpListener.cs	2006-07-04 12:22:16.000000000 +0530
@@ -4,7 +4,8 @@
//    Phillip Pearson (pp@myelin.co.nz)
//    Gonzalo Paniagua Javier (gonzalo@ximian.com)
//	  Patrik Torstensson
-//
+// NEt_2_0:
+//    Sridhar Kulkarni (sridharkulkarni@gmail.com)
// Copyright (C) 2001, Phillip Pearson
//    http://www.myelin.co.nz
//
@@ -141,6 +142,28 @@
		}


+#if NET_2_0
+        /// <summary>
+		///specifies whether the TcpListener allows only one underlying socket to 
listen to a specific port.
+		/// </summary>
+
+        public bool ExclusiveAddressUse {
+            get {
+                if (!active)
+                    throw ObjectDisposedException(GetType().ToString());
+                else
+                    return(server.ExclusiveAddressUse);
+            }
+            set{
+                if (active)
+                    throw new InvalidOperationException("The TcpListener 
has been started");
+                else
+                    server.ExclusiveAddressUse= value;
+            }
+        }
+
+#endif
+
		// methods

		/// <summary>
@@ -217,6 +240,41 @@

			active = true;
		}
+#if NET_2_0
+        /// <summary>
+        /// Tells the TcpListener to start listening for max number of 
pending connections.
+        /// </summary>
+
+        public void Start (int backlog){
+            if (active)
+                return;
+            if (server == null)
+                throw new InvalidOperationException("Invalid Server 
Socket");
+            if (backlog == 0 || backlog > 5)
+                throw new ArgumentOutOfRangeException("The backlog 
parameter is less than zero or exceeds the maximum number of permitted 
connections.");
+            server.Bind(savedEP);
+            server.Listen(backlog);
+            active = true;
+        }
+
+        public IAsyncResult BeginAcceptSocket (AsyncCallback 
callback,	Object state){
+            if (server == null)
+                throw new ObjectDisposedException(GetType().ToString());
+            return(server.BeginAccept(callback, state));
+        }
+        public IAsyncResult BeginAcceptTcpClient (AsyncCallback callback, 
Object state){
+            if(server == null)
+                throw new ObjectDisposedException(GetType().ToString());
+            return(server.BeginAccept(callback, state));
+        }
+        public Socket EndAcceptSocket (IAsyncResult asyncResult){
+            return(server.EndAccept(asyncResult));
+        }
+        public TcpClient EndAcceptTcpClient (IAsyncResult asyncResult){
+            return((TcpClient)server.EndAccept(asyncResult));
+        }
+
+#endif

		/// <summary>
		/// Tells the TcpListener to stop listening and dispose

