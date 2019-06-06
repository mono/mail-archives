--- UdpClient.cs.old	2006-04-14 23:19:40.000000000 +0530
+++ UdpClient.cs	2006-07-04 12:22:23.000000000 +0530
@@ -3,10 +3,11 @@
//
// Author:
//    Gonzalo Paniagua Javier <gonzalo@ximian.com>
-//
+// NEt_2_0:
+//    Sridhar Kulkarni (sridharkulkarni@gmail.com)
// Copyright (C) Ximian, Inc. http://www.ximian.com
//
-
+//
//
// Permission is hereby granted, free of charge, to any person obtaining
// a copy of this software and associated documentation files (the
@@ -39,6 +40,7 @@
		private bool active = false;
		private Socket socket;
		private AddressFamily family = AddressFamily.InterNetwork;
+        private byte[] recvbuffer;

#region Constructors
		public UdpClient () : this(AddressFamily.InterNetwork)
@@ -335,16 +337,144 @@
			return newArray;
		}
#endregion
+
+#if NET_2_0
+        public void JoinMulticastGroup (IPAddress multicastAddr,
+                            IPAddress localAddress){
+
+            CheckDisposed ();
+			JoinMulticastGroup (multicastAddr);
+            if (family == AddressFamily.InterNetwork){
+                socket.SetSocketOption(SocketOptionLevel.IP, 
SocketOptionName.AddMembership,
+                                ((new 
MulticastOption(multicastAddr)).LocalAddress));
+
+            }
+            else if(family == AddressFamily.InterNetworkV6){
+                socket.SetSocketOption(SocketOptionLevel.IPv6, 
SocketOptionName.AddMembership,
+                                ((new 
MulticastOption(multicastAddr)).LocalAddress));
+
+            }
+        }
+
+        public IAsyncResult BeginSend (byte[] datagram,	int bytes,
+                        AsyncCallback requestCallback,	Object state){
+            CheckDisposed();
+            if (dgram == null)
+                throw new ArgumentNullException("dgram");
+
+            if (!active)
+                throw new InvalidOperationException("Operation not allowed 
on " +
+                                     "non-connected sockets.");
+
+            return(socket.BeginSend(datagram, 0, bytes, SocketFlags.None, 
requestCallback, state));
+        }
+
+        public IAsyncResult BeginSend (byte[] datagram,	int bytes,
+                  IPEndPoint endPoint, AsyncCallback requestCallback, 
Object state){
+
+            CheckDisposed();
+            if (dgram == null)
+                throw new ArgumentNullException("dgram");
+
+            if (active) {
+                if(endPoint != null)
+                    throw new InvalidOperationException("Operation not 
allowed on " + "non-connected sockets.");
+                return(socket.BeginSend(datagram, 0, bytes, 
SocketFlags.None, requestCallback, state));
+
+            }
+            return (socket.BeginSendTo(datagram, 0, bytes, 
SocketFlags.None, endPoint, requestCallback, state));
+        }
+
+        public IAsyncResult BeginSend (byte[] datagram,	int bytes,
+                string hostname, int port,	AsyncCallback 
requestCallback,	Object state){
+
+            return (BeginSend(datagram, bytes, new 
IPEndPoint(Dns.Resolve(hostname).AddressList[0], port), requestCallback, 
state));
+        }
+
+        public int EndSend (IAsyncResult asyncResult){
+            CheckDisposed();
+            if (asyncResult == null)
+                throw new ArgumentNullException("asyncResult is a null 
reference");
+            return (socket.EndSend(asyncResult));
+        }
+        public IAsyncResult BeginReceive (AsyncCallback requestCallback, 
Object state){
+
+            IPEndPoint tempRemoteEP;
+            CheckDisposed();
+            recvbuffer = new byte[8192];
+
+            return (socket.BeginReceiveFrom(recvbuffer, 0, 8192, 
SocketFlags.None, tempRemoteEP, requestCallback, state));
+        }
+        public byte[] EndReceive (IAsyncResult asyncResult,	ref IPEndPoint 
remoteEP){
+
+            CheckDisposed();
+            if (asyncResult == null)
+                throw new ArgumentNullException("asyncResult is a null 
reference");
+            socket.EndReceiveFrom(asyncResult, remoteEP);
+            if (recvbuffer != null)
+                return (recvbuffer);
+        }
+#endif
+#endregion
+
#region Properties
		protected bool Active {
			get { return active; }
			set { active = value; }
		}

-		protected Socket Client {
+		public Socket Client {
			get { return socket; }
			set { socket = value; }
		}
+#if NET_2_0
+        public int Available {
+            get{
+                return (socket.Available);
+            }
+        }
+        public bool DontFragment {
+            get{
+                return (socket.DontFragment);
+            }
+            set{
+                socket.DontFragment = value;
+            }
+        }
+        public bool EnableBroadcast {
+            get{
+                return (socket.EnableBroadcast);
+            }
+            set{
+                socket.EnableBroadcast = value;
+            }
+        }
+        public bool ExclusiveAddressUse {
+            get{
+                return (socket.ExclusiveAddressUse);
+            }
+            set{
+                socket.ExclusiveAddressUse = value;
+            }
+        }
+        public bool MulticastLoopback {
+            get{
+                return (socket.MulticastLoopback);
+            }
+            set{
+                socket.MulticastLoopback = value;
+            }
+        }
+        public short Ttl {
+            get{
+                return (socket.Ttl);
+            }
+            set{
+                socket.Ttl = value;
+            }
+        }
+#endif
+
#endregion
#region Disposing
		void IDisposable.Dispose ()
@@ -378,7 +508,7 @@
				throw new ObjectDisposedException (GetType().FullName);
		}
#endregion
-#endregion
+
	}
}


