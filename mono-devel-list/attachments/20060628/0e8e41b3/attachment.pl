--- Socket.cs.old	2006-04-14 23:19:40.000000000 +0530
+++ Socket.cs	2006-06-27 17:16:45.000000000 +0530
@@ -5,11 +5,13 @@
//	Dick Porter <dick@ximian.com>
//	Gonzalo Paniagua Javier (gonzalo@ximian.com)
//
+//	NET_2.0 specific methods and properties
+//		Sridhar Kulkarni (sridharkulkarni@gmail.com)
// Copyright (C) 2001, 2002 Phillip Pearson and Ximian, Inc.
//    http://www.myelin.co.nz
// (c) 2004 Novell, Inc. (http://www.novell.com)
//
-
+//
//
// Permission is hereby granted, free of charge, to any person obtaining
// a copy of this software and associated documentation files (the
@@ -40,7 +42,11 @@
using System.Reflection;
using System.IO;
using System.Net.Configuration;
-
+#if NET_2_0
+using System.Collections.Generic;
+using System.Net.NetworkInformation;
+#endif
+using System.Text;
namespace System.Net.Sockets
{
	public class Socket : IDisposable
@@ -51,7 +57,8 @@
			Receive,
			ReceiveFrom,
			Send,
-			SendTo
+			SendTo,
+            Disconnect
		}

		[StructLayout (LayoutKind.Sequential)]
@@ -82,6 +89,7 @@
			internal int error;
			SocketOperation operation;
			public object ares;
+            public bool reusesocket;

			public SocketAsyncResult (Socket sock, object state, AsyncCallback 
callback, SocketOperation operation)
			{
@@ -304,7 +312,19 @@

				result.Complete ();
			}
-
+#if NET_2_0
+            public void Disconnect(){
+                try {
+                    if (result.reusesocket)
+                        result.Sock.Disconnect(true);
+                    else
+                        result.Sock.Disconnect(false);
+                } catch (Exception e){
+                    result.Complete(e);
+                    return;
+                }
+            }
+#endif
			public void Receive ()
			{
				// Actual recv() done in the runtime
@@ -405,6 +425,43 @@
		 * the last IO operation
		 */
		private bool connected=false;
+
+        /* When true IP datagrams will be fragmented
+         *
+         */
+        private bool dontfragment = true;
+
+        private bool enablebroadcast = false;
+
+        private bool exclusiveaddressuse;
+        private bool isbound = false;
+        //Lingre option
+        private LingerOption lingeropt = null;
+        private bool multicastloopback;
+        // false if the Socket uses the Nagle algorithm
+        private bool nodelay = false;
+
+        //recv buff size
+        private int recvbuffsize = 8192;
+        //recv time out
+        private int recvtimeout = 0;
+        //send buffer size
+        private int sendbuffsize = 8192;
+
+        //Time out for send call
+
+        private int sendtimeout = 0;
+        /*
+         * UseOnlyOverLappedIO
+         */
+        private bool useoverlappedIO = false;
+
+        /*
+         * TIme To Live(TTL) value
+         */
+        private short ttl;
+
+
		/* true if we called Close_internal */
		private bool closed;
		internal bool disposed;
@@ -508,7 +565,7 @@
			ConstructorInfo cons=unixendpointtype.GetConstructor(arg_types);

			object[] args=new object[1];
-			args[0]="nothing";
+			args[0]="";

			unixendpoint=cons.Invoke(args);
		}
@@ -544,8 +601,38 @@
			if (error != 0) {
				throw new SocketException (error);
			}
+#if NET_2_0
+            if (Environment.OSVersion.Platform > PlatformID.Win32NT)
+                exclusiveaddressuse = true;
+            else
+                exclusiveaddressuse = false;
+            SetSocketOption(SocketOptionLevel.Socket, 
SocketOptionName.ReceiveBuffer, recvbuffsize);
+            SetSocketOption(SocketOptionLevel.Socket, 
SocketOptionName.SendBuffer, sendbuffsize)
+#endif
+
+		}
+#if NET_2_0
+
+        public Socket (SocketInformation socketInformation) {
+
+            address_family = socketInformation.address_family;
+            socket_type = socketInformation.socket_type;
+            protocol_type = socketInformation.protocol_type;
+
+            int error;
+            socket = Socket_internal(socketInformation.address_family, 
socketInformation.socket_type, socketInformation.protocol_type, error);
+            if (error != 0)
+                throw new SocketException(error);
+            if (Environment.OSVersion.Platform > PlatformID.Win32NT)
+                exclusiveaddressuse = true;
+            else
+                exclusiveaddressuse = false;
+            SetSocketOption(SocketOptionLevel.Socket, 
SocketOptionName.ReceiveBuffer, recvbuffsize);
+            SetSocketOption(SocketOptionLevel.Socket, 
SocketOptionName.SendBuffer, sendbuffsize)
		}

+#endif
+
		public AddressFamily AddressFamily {
			get {
				return(address_family);
@@ -604,13 +691,261 @@
				return(connected);
			}
		}
+#if NET_2_0 // .Net 2.0 public properties --Sri
+        public bool DontFragment {
+            get {
+                if (disposed && closed)
+                    throw new 
ObjectDisposedException(GetType().ToString());
+                return (dontfragment);
+            }
+            set {
+                if (disposed && closed)
+                    throw new 
ObjectDisposedException(GetType().ToString());
+                if(address_family!= AddressFamily.InterNetwork || 
address_family != AddressFamily.InterNetworkV6)
+                    throw new NotSupportedException("This property can be 
set only for sockets in the InterNetwork or InterNetworkV6 families");
+                if (protocol_type == ProtocolType.Tcp)
+                    dontfragment = false;
+                else
+                   dontfragment = value;
+                SetSocketOption(SocketOptionLevel.Socket, 
SocketOptionName.DontFragment, ((dontfragment)?1:0));
+            }
+        }
+
+        public bool EnableBroadCast {
+            get {
+                if (disposed && closed)
+                    throw new 
ObjectDisposedException(GetType().ToString());
+                if (protocol_type != ProtocolType.Udp || protocol_type != 
ProtocolType.Tcp)
+                    throw new SocketException("This option is valid for a 
datagram socket only");
+                return(enablebroadcast);
+            }
+
+            set {
+                if (disposed && closed)
+                    throw new 
ObjectDisposedException(GetType().ToString());
+                if (protocol_type != ProtocolType.Udp || protocol_type != 
ProtocolType.Tcp)
+                    throw new SocketException("This option is valid for a 
datagram socket only");
+                if (protocol_type != ProtocolType.Tcp)
+                    enablebroadcast = false;
+                else
+                    enablebroadcast = value;
+            }
+        }
+
+        public bool ExclusiveAddressUse {
+            get {
+                if (disposed && closed)
+                    throw new 
ObjectDisposedException(GetType().ToString());
+                return (exclusiveaddressuse);
+            }
+            set {
+                if (closed && disposed)
+                    throw new 
ObjectDisposedException(GetType().ToString());
+                if (isbound)
+                    throw new InvalidOperationException("Bind has been 
called for this Socket");
+                exclusiveaddressuse = value;
+            }
+        }
+        public bool IsBound {
+            get {
+                return (isbound);
+            }
+
+        }
+
+        public LingerOption LingerState {
+            get {
+                if (disposed && closed)
+                    throw new 
ObjectDisposedException(GetType().ToString());
+                return (lingeropt);
+
+            }
+            set {
+                if (disposed && closed)
+                    throw new 
ObjectDisposedException(GetType().ToString());
+                lingeropt = value;
+                SetSocketOption(SocketOptionLevel.Socket, 
SocketOptionName.Linger, lingeropt.LingerTime);
+            }
+        }
+
+        public bool MulticastLoopback {
+            get{
+                if (disposed && closed)
+                    throw new 
ObjectDisposedException(GetType().ToString());
+
+                int opt;
+                GetSocketOption(SocketOptionLevel.Socket, 
SocketOptionName.MulticastLoopback, opt);
+                multicastloopback = (opt)?true:false;
+                return(multicastloopback);
+            }
+            set{
+                if (disposed && closed)
+                    throw new 
ObjectDisposedException(GetType().ToString());
+                multicastloopback = value;
+                SetSocketOption(SocketOptionLevel.Socket, 
SocketOptionName.MulticastLoopback, (multicastloopback)?1:0);
+            }
+
+        }
+
+        public bool NoDelay {
+            get{
+                if (disposed && closed)
+                    throw new 
ObjectDisposedException(GetType().ToString());
+                return (nodelay);
+            }
+            set{
+                if (disposed && closed)
+                    throw new 
ObjectDisposedException(GetType().ToString());
+                nodelay = value;
+                SetSocketOption(SocketOptionLevel.Tcp, 
SocketOptionName.NoDelay, ((value)?1:0));
+
+            }
+        }
+
+        public static bool OSSupportsIPv6 {
+            get {
+                NetworkInterface[] nics = 
NetworkInterface.GetAllNetworkInterfaces();
+                foreach (NetworkInterface adapter in nics) {
+                    if (adapter.Supports(NetworkInterfaceComponent.IPv6) == 
true)
+                        return true;
+                    else
+                        continue;
+                }
+                return false;
+            }
+        }
+
+        public int ReceiveBufferSize {
+            get{
+                if (disposed && closed)
+                    throw new 
ObjectDisposedException(GetType().ToString());
+                return (recvbuffsize);
+            }
+            set{
+                if (disposed && closed)
+                    throw new 
ObjectDisposedException(GetType().ToString());
+                if (value < 0)
+                    throw new ArgumentOutOfRangeException("The value 
specified for a set operation is less than 0{zero}");
+                recvbuffsize = value;
+                SetSocketOption(SocketOptionLevel.Socket, 
SocketOptionName.ReceiveBuffer, value);
+            }
+
+        }
+
+        public int ReceiveTimeout {
+            get {
+                if (disposed && closed)
+                    throw new 
ObjectDisposedException(GetType().ToString());
+
+                return (recvtimeout);
+            }
+            set {
+                if (disposed && closed)
+                    throw new 
ObjectDisposedException(GetType().ToString());
+                if (value < -1)
+                    throw new ArgumentOutOfRangeException("The value 
specified for a set operation is less than -1");
+                if (valuse == -1)
+                    recvtimeout = 0;
+                else
+                    recvtimeout = value;
+                SetSocketOption(SocketOptionLevel.Socket, 
SocketOptionName.ReceiveTimeout, value);
+            }
+        }
+
+        public int SendBufferSize {
+            get {
+                if (disposed && closed)
+                    throw new 
ObjectDisposedException(GetType().ToString());
+                return (sendbuffsize);
+            }
+            set {
+                if (disposed && closed)
+                    throw new 
ObjectDisposedException(GetType().ToString());
+                if (value < 0)
+                    throw new ArgumentOutOfRangeException("The value 
specified for a set operation is less than 0{zero}");
+                sendbuffsize = value;
+                SetSocketOption(SocketOptionLevel.Socket, 
SocketOptionName.SendBuffer, sendtimeout);
+            }
+        }
+        public int SendTimeout {
+            get {
+                if (disposed && closed)
+                    throw new 
ObjectDisposedException(GetType().ToString());
+                return (sendtimeout);
+            }
+
+            set {
+                if (disposed && closed)
+                    throw new 
ObjectDisposedException(GetType().ToString());
+                if (value < -1)
+                    throw new ArgumentOutOfRangeException("The value 
specified for a set operation is less than -1");
+
+                if (value == -1)
+                    sendtimeout = 0;
+                else if (value >= 1 && value <= 499)
+                    sendtimeout = 500;
+                else
+                    sendtimeout = value;
+                SetSocketOption(SocketOptionLevel.Socket, 
SocketOptionName.SendTimeout, sendtimeout);
+            }
+        }
+        public short Ttl {
+            get{
+                if (disposed && closed)
+                    throw new 
ObjectDisposedException(GetType().ToString());
+                byte[] ttl_val;
+                int error=0;
+                if (address_family == AddressFamily.InterNetwork)
+                    GetSocketOption_arr_internal(socket, 
SocketOptionLevel.IP.Socket,
+                                        SocketOptionName.IpTimeToLive, 
ttl_val, error);
+                if (address_family == AddressFamily.InterNetworkV6)
+                    GetSocketOption_arr_internal(socket, 
SocketOptionLevel.IPv6,
+                                        SocketOptionName.HopLimit, ttl_val, 
error);
+                if (error != 0)
+                    throw new SocketException(error);
+                else
+                    return (BitConverter.ToInt16(ttl_val, 0));
+            }
+            set {
+                if (disposed && closed)
+                    throw new 
ObjectDisposedException(GetType().ToString());
+
+                if (address_family != AddressFamily.InterNetwork || 
address_family != AddressFamily.InterNetworkV6)
+                    throw new NotSupportedException("This property can be 
set only for sockets in the InterNetwork or InterNetworkV6 families");
+                int error;
+			    if (address_family == AddressFamily.InterNetwork)
+                    SetSocketOption_internal(socket, 
SocketOptionLevel.Socket, SocketOptionName.IpTimeToLive, null, null, value, 
out error);
+                if (address_family == AddressFamily.InterNetworkV6)
+                    SetSocketOption_internal(socket, 
SocketOptionLevel.IPv6, SocketOptionName.HopLimit, null, null, value, out 
error);
+    			if (error != 0) {
+	    			throw new SocketException (error);
+		    	}
+            }
+
+        }
+
+        public bool UseOnlyOverlappedIO {
+            get{
+
+                return (useoverlappedIO);
+            }
+            set {
+                useoverlappedIO = value;
+
+            }
+
+        }

+
+#endif // --Sri
		public IntPtr Handle {
			get {
				return(socket);
			}
		}

+
+
		// Returns the local endpoint details in addr and port
		[MethodImplAttribute(MethodImplOptions.InternalCall)]
		private extern static SocketAddress LocalEndPoint_internal(IntPtr socket, 
out int error);
@@ -786,6 +1121,77 @@
			sac.BeginInvoke (null, req);
			return(req);
		}
+#if NET_2_0 // --Sri
+
+        public IAsyncResult BeginAccept (int receiveSize,
+                            AsyncCallback callback, Object state) {
+
+            if (disposed && closed)
+                throw new ObjectDisposedException(GetType().ToString());
+            if (receiveSize < 0)
+                throw new ArgumentOutOfRangeException("receiveSize is less 
than 0");
+
+
+            SocketAsyncResult req = new SocketAsyncResult(this, state, 
callback, SocketOperation.Accept);
+            Worker worker = new Worker(req);
+            SocketAsyncCall sac = new SocketAsyncCall(worker.Accept);
+            sac.BeginInvoke(null, req);
+            return (req);
+
+        }
+
+        public IAsyncResult BeginAccept(Socket acceptSocket, int 
receiveSize,
+                                AsyncCallback callback, Object state){
+
+
+            if (disposed && closed)
+                throw new ObjectDisposedException(GetType().ToString());
+            if (receiveSize < 0)
+                throw new ArgumentOutOfRangeException("receiveSize is less 
than 0");
+
+            if (!(Environment.OSVersion.Platform >= Win32NT))
+                throw new NotSupportedException("Windows NT is required for 
this method.");
+            if (!acceptSocket){
+
+                int error = 0;
+			    IntPtr sock = (IntPtr) (-1);
+			    blocking_thread = Thread.CurrentThread;
+		        try {
+			        sock = Accept_internal(socket, out error);
+		        } catch (ThreadAbortException the) {
+			        if (disposed) {
+				        Thread.ResetAbort ();
+				        error = 10004;
+			        }
+		        } finally {
+			        blocking_thread = null;
+		        }
+
+		        if (error != 0) {
+			        throw new SocketException (error);
+		        }
+
+		        Socket accepted = new Socket(this.AddressFamily, this.SocketType, 
this.ProtocolType, sock);
+                SocketAsyncResult req = new SocketAsyncResult(accepted, 
state, callback, SocketOperation.Accept);
+                Worker worker = new Worker(req);
+                SocketAsyncCall sac = new SocketAsyncCall(worker.Accept);
+                sac.BeginInvoke(null, req);
+                return (req);
+
+            }
+            else {
+                SocketAsyncResult req = new SocketAsyncResult(acceptSocket, 
state, callback, SocketOperation.Accept);
+                Worker worker = new Worker(req);
+                SocketAsyncCall sac = new SocketAsyncCall(worker.Accept);
+                sac.BeginInvoke(null, req);
+                return (req);
+            }
+        }
+
+
+
+#endif
+

		public IAsyncResult BeginConnect(EndPoint end_point,
						 AsyncCallback callback,
@@ -835,16 +1241,134 @@
			return(req);
		}

-		public IAsyncResult BeginReceive(byte[] buffer, int offset,
-						 int size,
-						 SocketFlags socket_flags,
-						 AsyncCallback callback,
-						 object state) {
+#if NET_2_0 // --Sri
+        public IAsyncResult BeginConnect (IPAddress address, int port,
+                                AsyncCallback requestCallback,Object state) 
{

			if (disposed && closed)
				throw new ObjectDisposedException (GetType ().ToString ());
+            if (address == null)
+                throw new ArgumentNullException("ip address is a null");
+            if (address.ToString().Length == 0)
+                throw new ArgumentException("Length of the IP address is 
zero");

-			if (buffer == null)
+            SocketAsyncResult req = new SocketAsyncResult(this, state, 
requestCallback, SocketOperation.Connect);
+
+            IPEndPoint iep = new IPEndPoint(address, port);
+            if (iep.Address.Equals(IPAddress.Any) || 
iep.Address.Equals(IPAddress.IPv6Any)) {
+                req.Complete(new SocketException(10049), true);
+                return req;
+            }
+            int error = 0;
+            if (!blocking) {
+
+                SocketAddress sa = iep.Serialize();
+                Connect_internal (socket, serial, out error);
+				if (error == 0) {
+					// succeeded synch
+					connected = true;
+					req.Complete (true);
+				} else if (error != 10036 && error != 10035) {
+					// error synch
+					connected = false;
+					req.Complete (new SocketException (error), true);
+				}
+            }
+            if (blocking || error == 10036 || error == 10035)
+            {
+                // continue asynch
+                connected = false;
+                Worker worker = new Worker(req);
+                SocketAsyncCall sac = new SocketAsyncCall(worker.Connect);
+                sac.BeginInvoke(null, req);
+            }
+
+            return (req);
+        }
+
+        public IAsyncResult BeginConnect (IPAddress[] addresses, int port,
+                                 AsyncCallback requestCallback, Object 
state) {
+
+            if (disposed && closed)
+                throw new ObjectDisposedException(GetType().ToString());
+            if (address == null)
+                throw new ArgumentNullException("ip address is a null");
+            SocketAsyncResult req = new SocketAsyncResult(this, state, 
requestCallback, SocketOperation.Connect);
+            int error = 0;
+            if (!blocking) {
+                foreach (IPAddress address in addresses)
+                {
+
+                    IPEndPoint iep = new IPEndPoint(address, port);
+                    if (iep.Address.Equals(IPAddress.Any) || 
iep.Address.Equals(IPAddress.IPv6Any))
+                        throw new SocketException(10049);
+                    if (address.AddressFamily != AddressFamily.InterNetwork 
|| address.AddressFamily != AddressFamily.InterNetworkV6)
+                        throw new NotSupportedException("This method is 
valid for sockets in the InterNetwork or InterNetworkV6 families");
+                    if (address.ToString().Length == 0)
+                        throw new ArgumentException("The length of address 
is zero");
+
+                    SocketAddress sa = iep.Serialize();
+
+
+                    Connect_internal(socket, Sa, error);
+                    if (error == 10048)
+                        continue;
+                    else
+                        break;
+
+                }
+                if (error == 0)
+                {
+                    // succeeded synch
+                    connected = true;
+                    req.Complete(true);
+                }
+                else if (error != 10036 && error != 10035)
+                {
+                    // error synch
+                    connected = false;
+                    req.Complete(new SocketException(error), true);
+                }
+            }
+            if (blocking || error == 10036 || error == 10035)
+            {
+                // continue asynch
+                connected = false;
+                Worker worker = new Worker(req);
+                SocketAsyncCall sac = new SocketAsyncCall(worker.Connect);
+                sac.BeginInvoke(null, req);
+            }
+            return (req);
+
+        }
+
+        public IAsyncResult BeginConnect (string host, int port,
+                        AsyncCallback requestCallback,	Object state) {
+
+
+            if (disposed && closed)
+                throw new ObjectDisposedException(GetType().ToString());
+
+            if (host == null)
+                throw new ArgumentNullException("host is a null reference 
");
+            if (address_family != AddressFamily.InterNetwork || 
address_family != AddressFamily.InterNetworkV6)
+                throw new NotSupportedException("This method is valid for 
sockets in the InterNetwork or InterNetworkV6 families.");
+            IPAddress address = Dns.GetHostAddresses(host);
+            BeginConnect(address, port, requestCallback, state);
+        }
+
+#endif //Sri
+
+		public IAsyncResult BeginReceive(byte[] buffer, int offset,
+						 int size,
+						 SocketFlags socket_flags,
+						 AsyncCallback callback,
+						 object state) {
+
+			if (disposed && closed)
+				throw new ObjectDisposedException (GetType ().ToString ());
+
+			if (buffer == null)
				throw new ArgumentNullException ("buffer");

			if (offset < 0 || offset > buffer.Length)
@@ -871,6 +1395,114 @@
			return req;
		}

+#if NET_2_0 //--sri
+
+        public IAsyncResult BeginReceive (byte[] buffer, int offset,
+                            int size,
+                            SocketFlags socketFlags,
+                            out SocketError errorCode,
+                            AsyncCallback callback,
+                            Object state) {
+
+
+            if (disposed && closed)
+                throw new ObjectDisposedException(GetType().ToString());
+
+            if (buffer == null)
+                throw new ArgumentNullException("buffer is a null 
reference");
+
+            if (offset < 0 || offset > buffer.Length)
+                throw new ArgumentOutOfRangeException("offset is less than 
0 or greater than buffer length");
+            if (size < 0 || size > (buffer.Length - offset))
+                throw new ArgumentOutOfRangeException("size is less than 0 
or greater than difference of buffer length and offset");
+
+            SocketAsyncResult req;
+            lock(readQ){
+
+                req = new SocketAsyncResult(this, state, callback, 
SocketOperation.Receive);
+                req.Buffer = buffer;
+                req.Size = size;
+                req.Offset = offset;
+                req.SockFlags = socketFlags;
+
+                readQ.Enqueue(req);
+                if (readQ.Count ==1) {
+
+                    Worker worker = new Worker(req);
+                    SocketAsyncCall sac = new 
SocketAsyncCall(worker.Receive);
+                    sac.BeginInvoke(null, req);
+                }
+
+            }
+            return (req);
+
+        }
+
+
+
+        [CLSCompliantAttribute(false)]
+        public IAsyncResult BeginReceive (IList<ArraySegment<byte>> 
buffers,
+                                        SocketFlags socketFlags,
+                                        AsyncCallback callback,
+                                        Object state) {
+
+            if (disposed && closed)
+                throw new ObjectDisposedException(GetType().ToString());
+
+            if (buffers == null)
+                throw new ArgumentNullException("buffer is a null 
reference");
+
+            SocketAsyncResult req;
+            lock(readQ) {
+                req = new SocketAsyncResult(this, state, callback, 
SocketOperation.Receive);
+                IEnumerator enumerator = ((IList)buffers).GetEnumerator();
+                enumerator.MoveNext();
+                for (int i=0; i<= ((IList)buffers).Count; i++) {
+                    req.Buffer = (byte)enumerator.Current;
+                    req.SockFlags = socketFlags;
+                    readQ.Enqueue(req);
+                    if (readQ.Count == 1) {
+                        Worker worker = new Worker(req);
+                        SocketAsyncCall sac = new 
SocketAsyncCall(worker.Receive);
+                        sac.BeginInvoke(null, req);
+                    }
+                }
+            }
+            return (req);
+        }
+
+        [CLSCompliantAttribute(false)]
+        public IAsyncResult BeginReceive (IList<ArraySegment<byte>> 
buffers,
+                                        SocketFlags socketFlags,
+                                        out SocketError errorCode,
+                                        AsyncCallback callback,
+                                        Object state) {
+            if (disposed && closed)
+                throw new ObjectDisposedException(GetType().ToString());
+
+            if (buffers == null)
+                throw new ArgumentNullException("buffer is a null 
reference");
+
+            SocketAsyncResult req;
+            lock(readQ) {
+                req = new SocketAsyncResult(this, state, callback, 
SocketOperation.Receive);
+                IEnumerator enumerator = ((IList)buffers).GetEnumerator();
+                enumerator.MoveNext();
+                for (int i=0; i<= ((IList)buffers).Count; i++) {
+                    req.Buffer = (byte)enumerator.Current;
+                    req.SockFlags = socketFlags;
+                    readQ.Enqueue(req);
+                    if (readQ.Count == 1) {
+                        Worker worker = new Worker(req);
+                        SocketAsyncCall sac = new 
SocketAsyncCall(worker.Receive);
+                        sac.BeginInvoke(null, req);
+                    }
+                }
+            }
+            return (req);
+        }
+
+#endif
		public IAsyncResult BeginReceiveFrom(byte[] buffer, int offset,
						     int size,
						     SocketFlags socket_flags,
@@ -945,6 +1577,103 @@
			return req;
		}

+#if NET_2_0 //-- Sri
+        public IAsyncResult BeginSend (byte[] buffer, int offset,
+                                    int size,
+                                    SocketFlags socketFlags,
+                                    out SocketError errorCode,
+                                    AsyncCallback callback,
+                                    Object state) {
+
+            if (disposed && closed)
+                throw new ObjectDisposedException(GetType().ToString());
+
+            if (buffer == null)
+                throw new ArgumentNullException("Buffer is a null 
reference");
+            if (offset < 0 || offset < buffer.Length)
+                throw new ArgumentOutOfRangeException("offset is less than 
zero or buffer length");
+            if (size < 0 || size > (buffer.Length - offset))
+                throw new ArgumentOutOfRangeException("size is less than 
zero or greater than the difference of buffer length and offset");
+            SocketAsyncResult req;
+            lock(writeQ) {
+                req = new SocketAsyncResult(this, state, callback, 
SocketOperation.Send);
+                req.Buffer = buffer;
+                req.SockFlags = socketFlags;
+                req.Size = size;
+                req.Offset = offset;
+                writeQ.Enqueue(req);
+                if (writeQ.Count ==1) {
+                    Worker worker = new Worker(req);
+                    SocketAsyncCall sac = new SocketAsyncCall(worker.Send);
+                    sac.BeginInvoke(null, req);
+                }
+            }
+            return (req);
+        }
+
+        public IAsyncResult BeginSend (IList<ArraySegment<byte>> buffers,
+                                    SocketFlags socketFlags,
+                                    AsyncCallback callback,
+                                    Object state) {
+            if (disposed && closed)
+                throw new ObjectDisposedException(GetType().ToString());
+
+            if (buffers == null)
+                throw new ArgumentNullException("buffer is a null 
reference");
+            SocketAsyncResult req;
+            lock(writeQ) {
+                req = new SocketAsyncResult(this, state, callback, 
SocketOperation.Send);
+                IEnumerator enumerator = ((IList)buffers).GetEnumerator();
+                enumerator.MoveNext();
+                for (int i=0; i<= ((IList)buffers).Count; i++) {
+                    req.Buffer = (byte)enumerator.Current;
+                    req.SockFlags = socketFlags;
+                    writeQ.Enqueue(req);
+                    if(writeQ.Count ==1) {
+                        Worker worker = new Worker(req);
+                        SocketAsyncCall sac = new 
SocketAsyncCall(worker.Send);
+                        sac.BeginInvoke(null, req);
+                    }
+                }
+            }
+            return (req);
+        }
+
+        [CLSCompliantAttribute(false)]
+        public IAsyncResult BeginSend (IList<ArraySegment<byte>> buffers,
+                                    SocketFlags socketFlags,
+                                    out SocketError errorCode,
+                                	AsyncCallback callback,
+                                    Object state) {
+            if (disposed && closed)
+                throw new ObjectDisposedException(GetType().ToString());
+
+            if (buffers == null)
+                throw new ArgumentNullException("buffer reference is 
null");
+
+            SocketAsyncResult req;
+            lock(writeQ) {
+                req = new SocketAsyncResult(this, state, callback, 
SocketOperation.Send);
+                IEnumerator enumerator = ((IList)buffers).GetEnumerator();
+                enumerator.MoveNext();
+                for (int i=0; i<= ((IList)buffers).Count; i++) {
+                    req.Buffer = (byte)enumerator.Current;
+                    req.SockFlags = socketFlags;
+                    writeQ.Enqueue(req);
+                    if(writeQ.Count ==1) {
+                        Worker worker = new Worker(req);
+                        SocketAsyncCall sac = new 
SocketAsyncCall(worker.Send);
+                        sac.BeginInvoke(null, req);
+                    }
+                }
+            }
+            return (req);
+        }
+
+
+#endif
+
+
		public IAsyncResult BeginSendTo(byte[] buffer, int offset,
						int size,
						SocketFlags socket_flags,
@@ -999,13 +1728,29 @@
			}

			int error;
-
+#if !NET_2_0
			Bind_internal(socket, local_end.Serialize(),
				      out error);

			if (error != 0) {
				throw new SocketException (error);
			}
+#endif
+#if NET_2_0 //Sri
+            if (exclusiveaddressuse) {
+                if (!isbound){
+                    Bind_internal(socket, local_end.Serialize(), error);
+                } else {
+                    throw new SocketException("An error occurred when 
attempting to access the socket.");
+                }
+            }else {
+                Bind_internal(socket, local_end.Serialize(), error);
+            }
+            if (error != 0) {
+				throw new SocketException (error);
+            if (error == 0)
+                isbound = true;
+#endif
		}

		// Closes the socket
@@ -1017,47 +1762,252 @@
			((IDisposable) this).Dispose ();
		}

-		// Connects to the remote address
-		[MethodImplAttribute(MethodImplOptions.InternalCall)]
-		private extern static void Connect_internal(IntPtr sock,
-							    SocketAddress sa,
-							    out int error);
+#if NET_2_0
+
+        public void Close(int timeout){
+            if (!lingeropt && timeout ==0){
+                ((IDisposable) this).Dispose ();
+            }
+            else {
+                throw NotImplementedException ("Error");
+            }
+
+        }
+#endif
+
+		// Connects to the remote address
+		[MethodImplAttribute(MethodImplOptions.InternalCall)]
+		private extern static void Connect_internal(IntPtr sock,
+							    SocketAddress sa,
+							    out int error);
+
+		public void Connect(EndPoint remote_end) {
+			if (disposed && closed)
+				throw new ObjectDisposedException (GetType ().ToString ());
+
+			if(remote_end==null) {
+				throw new ArgumentNullException("remote_end");
+			}
+
+			if (remote_end is IPEndPoint) {
+				IPEndPoint ep = (IPEndPoint) remote_end;
+				if (ep.Address.Equals (IPAddress.Any) || ep.Address.Equals 
(IPAddress.IPv6Any))
+					throw new SocketException (10049);
+			}
+
+			SocketAddress serial = remote_end.Serialize ();
+			int error = 0;
+
+			blocking_thread = Thread.CurrentThread;
+			try {
+				Connect_internal (socket, serial, out error);
+			} catch (ThreadAbortException the) {
+				if (disposed) {
+					Thread.ResetAbort ();
+					error = 10004;
+				}
+			} finally {
+				blocking_thread = null;
+			}
+
+			if (error != 0) {
+				throw new SocketException (error);
+			}
+
+			connected=true;
+#if NET_2_0
+            isbound = true;
+#endif
+		}
+
+#if NET_2_0
+        public void Connect (IPAddress address,	int port) {
+
+            if (address == null)
+                throw new ArgumentNullException("address is a null 
reference");
+
+            if (closed && disposed)
+                throw new ObjectDisposedException(GetType().ToString());
+            if (address.AddressFamily != AddressFamily.InterNetwork || 
address.AddressFamily != AddressFamily.InterNetworkV6)
+                throw new NotSupportedException("This method is valid for 
sockets in the InterNetwork or InterNetworkV6 families");
+            if (address.ToString().Length == 0)
+                throw new ArgumentException("The length of address is 
zero");
+
+            if ((this.ProtocolType == ProtocolType.Tcp) && (this.Blocking 
== false))
+                throw new SocketException("An error occurred when 
attempting to access the socket");
+
+            IPEndPoint iep = new IPEndPoint(address, port);
+            if (iep.Address.Equals(IPAddress.Any) || 
iep.Address.Equals(IPAddress.IPv6Any))
+                throw new SocketException(10049);
+
+            SocketAddress sa = iep.Serialize();
+            int error = 0;
+
+            blocking_thread = Thread.CurrentThread;
+            try {
+                Connect_internal(socket, Sa, error);
+            } catch (ThreadAbortException the){
+                if (disposed) {
+                    Thread.ResetAbort();
+                    error = 10004;
+                }
+            }
+            finally{
+                blocking_thread = null;
+            }
+            if (error != 0){
+                throw new SocketException(error);
+            }
+            connected = true;
+            isbound = true;
+        }
+
+        public void Connect (IPAddress[] addresses,	int port) {
+
+            if (disposed && closed)
+                throw new ObjectDisposedException(GetType().ToString());
+            if ((this.ProtocolType == ProtocolType.Tcp) && (this.Blocking 
== false))
+                throw new SocketException("An error occurred when 
attempting to access the socket");
+            if (addresses == null)
+                throw new ArgumentNullException("addresses is a null 
reference");
+            foreach (IPAddress address in addresses) {
+
+                IPEndPoint iep = new IPEndPoint(address, port);
+                if (iep.Address.Equals(IPAddress.Any) || 
iep.Address.Equals(IPAddress.IPv6Any))
+                    throw new SocketException(10049);
+                if (address.AddressFamily != AddressFamily.InterNetwork || 
address.AddressFamily != AddressFamily.InterNetworkV6)
+                    throw new NotSupportedException("This method is valid 
for sockets in the InterNetwork or InterNetworkV6 families");
+                if (address.ToString().Length == 0)
+                    throw new ArgumentException("The length of address is 
zero");
+
+                SocketAddress sa = iep.Serialize();
+                int error = 0;
+
+                blocking_thread = Thread.CurrentThread;
+                try
+                {
+                    Connect_internal(socket, Sa, error);
+                }
+                catch (ThreadAbortException the)
+                {
+                    if (disposed)
+                    {
+                        Thread.ResetAbort();
+                        error = 10004;
+                    }
+                }
+                finally
+                {
+                    blocking_thread = null;
+                }
+                if (error == 10048)
+                    continue;
+                else
+                    break;
+
+            }
+            if (error != 0)
+            {
+                throw new SocketException(error);
+            }
+            connected = true;
+            isbound = true;
+        }
+
+        public void Connect (string host, int port) {
+
+            if (host == null)
+                throw new ArgumentNullException("host is null reference");
+            if ((this.ProtocolType ==ProtocolType.Tcp) && (this.Blocking == 
false))
+                throw new SocketException("An error occurred when 
attempting to access the socket");
+
+            IPAddress address = Dns.GetHostAddresses(host);
+            Connect(address, port);
+        }
+
+
+        public void Disconnect (bool reuseSocket){
+
+            if (disposed && closed)
+                throw new ObjectDisposedException(GetType().ToString());
+            if ((Environment.OSVersion.Platform != PlatformID.Unix) && 
(Environment.OSVersion.Platform >= Win32NT))
+                throw new NotSupportedException("This method requires 
Windows 2000 or earlier");
+
+            if (reuseSocket) {
+                if ((int)socket != -1) {
+                    int error;
+                    closed = true;
+                    Close_internal(socket, out error);
+                    if (blocking_thread != null){
+
+                        blocking_thread.Abort();
+                        blocking_thread = null;
+                    }
+
+                    if (error != 0)
+                        throw new SocketException(error);
+                }
+            }
+            else {
+                ((IDisposable)this).Dispose();
+            }
+
+        }
+
+        public IAsyncResult BeginDisconnect (bool reuseSocket,
+                                AsyncCallback callback, Object state) {
+

-		public void Connect(EndPoint remote_end) {
			if (disposed && closed)
				throw new ObjectDisposedException (GetType ().ToString ());

-			if(remote_end==null) {
-				throw new ArgumentNullException("remote_end");
+
+            if (!(Environment.OSVersion.Platform > PlatformID.Win32NT))
+                 throw new NotSupportedException("The operating system is 
Windows 2000 or earlier, and this method requires Windows XP");
+
+            SocketAsyncResult req = new SocketAsyncResult(this, state, 
callback, SocketOperation.Disconnect);
+            req.reusesocket = reuseSocket;
+            Worker worker = new Worker(req);
+            SocketAsyncCall sac = new SocketAsyncCall(worker.Disconnect);
+            sac.BeginInvoke(null, req);
+            return (req);
			}
+        public void EndDisconnect (	IAsyncResult asyncResult) {

-			if (remote_end is IPEndPoint) {
-				IPEndPoint ep = (IPEndPoint) remote_end;
-				if (ep.Address.Equals (IPAddress.Any) || ep.Address.Equals 
(IPAddress.IPv6Any))
-					throw new SocketException (10049);
+            if (disposed && closed)
+                throw new ObjectDisposedException(GetType().ToString());
+            if ((Environment.OSVersion.Platform != PlatformID.Unix) 
&&(Environment.OSVersion.Platform <= PlatformID.Win32NT))
+                throw new NotSupportedException("The operating system is 
Windows 2000 or earlier, and this method requires Windows XP");
+
+            if (asyncResult == null)
+                throw new ArgumentNullException("asyncResult is Nullable");
+            SocketAsyncResult req = asyncResult as SocketAsyncResult;
+            if (req == null)
+                throw new ArgumentException("Invalid IAsyncResult", 
"asyncResult");
+
+            if (!asyncResult.IsCompleted)
+                asyncResult.AsyncWaitHandle.WaitOne();
+
+            req.CheckIfThrowDelayedException();
			}

-			SocketAddress serial = remote_end.Serialize ();
-			int error = 0;
+        public SocketInformation DuplicateAndClose (int targetProcessId) {

-			blocking_thread = Thread.CurrentThread;
+            SocketInformation socinfo = new SocketInformation();
			try {
-				Connect_internal (socket, serial, out error);
-			} catch (ThreadAbortException the) {
-				if (disposed) {
-					Thread.ResetAbort ();
-					error = 10004;
-				}
-			} finally {
-				blocking_thread = null;
-			}

-			if (error != 0) {
-				throw new SocketException (error);
-			}
+                socinfo.address_family = this.AddressFamily;
+                socinfo.socket_type = this.SocketType;
+                socinfo.protocol_type = this.ProtocolType;
+
+                ((IDisposable)this).Dispose();
+            }catch (SocketException socex ) {

-			connected=true;
		}
+            return (socinfo);
+        }
+
+#endif

		public Socket EndAccept(IAsyncResult result) {
			if (disposed && closed)
@@ -1077,6 +2027,50 @@
			return req.Socket;
		}

+#if NET_2_0
+        public Socket EndAccept (out byte[] buffer,	IAsyncResult 
asyncResult) {
+
+            if (disposed && closed)
+                throw new ObjectDisposedException(GetType().ToString());
+
+            if (Environment.OSVersion.Platform != PlatformID.Win32NT)
+                throw new NotSupportedException("Windows NT is required for 
this methos");
+            if (asyncResult == null)
+                throw new ArgumentNullException("asyncResult is Nullable");
+            SocketAsyncResult req = asyncResult as SocketAsyncResult;
+            if (req == null)
+                throw new ArgumentException("Invalid IAsyncResult", 
"asyncResult");
+
+            if (!asyncResult.IsCompleted)
+                asyncResult.AsyncWaitHandle.WaitOne();
+            req.CheckIfThrowDelayedException();
+            buffer = req.Buffer;
+            return (req.Socket);
+        }
+
+        public Socket EndAccept (out byte[] buffer,
+                        out int bytesTransferred, IAsyncResult 
asyncResult){
+
+            if (disposed && closed)
+                throw new ObjectDisposedException(GetType().ToString());
+
+            if (Environment.OSVersion.Platform != PlatformID.Win32NT)
+                throw new NotSupportedException("Windows NT is required for 
this methos");
+            if (asyncResult == null)
+                throw new ArgumentNullException("asyncResult is Nullable");
+            SocketAsyncResult req = asyncResult as SocketAsyncResult;
+            if (req == null)
+                throw new ArgumentException("Invalid IAsyncResult", 
"asyncResult");
+            if (!asyncResult.IsCompleted)
+                asyncResult.AsyncWaitHandle.WaitOne();
+            req.CheckIfThrowDelayedException();
+            buffer = req.Buffer;
+            bytesTransferred = req.Total;
+            return (req.Socket);
+        }
+#endif
+
+
		public void EndConnect(IAsyncResult result) {
			if (disposed && closed)
				throw new ObjectDisposedException (GetType ().ToString ());
@@ -1111,6 +2105,23 @@
			req.CheckIfThrowDelayedException();
			return req.Total;
		}
+#if NET_2_0
+        public int EndReceive (IAsyncResult asyncResult, out SocketError 
errorCode) {
+            if (disposed && closed)
+                throw new ObjectDisposedException(GetType().ToString());
+
+            if (result == null)
+                throw new ArgumentNullException("asyncResult");
+
+            SocketAsyncResult req = result as SocketAsyncResult;
+            if (req == null)
+                throw new ArgumentException("Invalid IAsyncResult", 
"asyncResult");
+            if (!asyncResult.IsCompleted)
+                asyncResult.AsyncWaitHandle.WaitOne();
+            req.CheckIfThrowDelayedException();
+            return req.Total;
+        }
+#endif

		public int EndReceiveFrom(IAsyncResult result,
					  ref EndPoint end_point) {
@@ -1150,6 +2161,25 @@
			return req.Total;
		}

+#if NET_2_0
+        public int EndSend (IAsyncResult asyncResult, out SocketError 
errorCode) {
+
+            if (disposed && closed)
+                throw new ObjectDisposedException(GetType().ToString());
+
+            if (result == null)
+                throw new ArgumentNullException("asyncResult");
+
+            SocketAsyncResult req = result as SocketAsyncResult;
+            if (req == null)
+                throw new ArgumentException("Invalid IAsyncResult", 
"asyncResult");
+            if (!asyncResult.IsCompleted)
+                asyncResult.AsyncWaitHandle.WaitOne();
+            req.CheckIfThrowDelayedException();
+            return req.Total;
+        }
+#endif
+
		public int EndSendTo(IAsyncResult result) {
			if (disposed && closed)
				throw new ObjectDisposedException (GetType ().ToString ());
@@ -1261,6 +2291,15 @@
			return result;
		}

+#if NET_2_0
+        public int IOControl (IOControlCode ioControlCode,	byte[] 
optionInValue,
+                            byte[] optionOutValue){
+            throw new NotImplementedException("Not implemented");
+
+        }
+#endif
+
+
		[MethodImplAttribute(MethodImplOptions.InternalCall)]
		private extern static void Listen_internal(IntPtr sock,
							   int backlog,
@@ -1318,14 +2357,7 @@
			if (buf == null)
				throw new ArgumentNullException ("buf");

-			SocketError error;
-
-			int ret = Receive_nochecks (buf, 0, buf.Length, SocketFlags.None, out 
error);
-
-			if (error != SocketError.Success)
-				throw new SocketException ((int) error);
-
-			return ret;
+			return Receive_nochecks (buf, 0, buf.Length, SocketFlags.None);
		}

		public int Receive (byte [] buf, SocketFlags flags)
@@ -1336,14 +2368,7 @@
			if (buf == null)
				throw new ArgumentNullException ("buf");

-			SocketError error;
-
-			int ret = Receive_nochecks (buf, 0, buf.Length, flags, out error);
-
-			if (error != SocketError.Success)
-				throw new SocketException ((int) error);
-
-			return ret;
+			return Receive_nochecks (buf, 0, buf.Length, flags);
		}

		public int Receive (byte [] buf, int size, SocketFlags flags)
@@ -1357,16 +2382,17 @@
			if (size < 0 || size > buf.Length)
				throw new ArgumentOutOfRangeException ("size");

-			SocketError error;
-
-			int ret = Receive_nochecks (buf, 0, size, flags, out error);
-
-			if (error != SocketError.Success)
-				throw new SocketException ((int) error);
-
-			return ret;
+			return Receive_nochecks (buf, 0, size, flags);
		}

+		[MethodImplAttribute(MethodImplOptions.InternalCall)]
+		private extern static int Receive_internal(IntPtr sock,
+							   byte[] buffer,
+							   int offset,
+							   int count,
+							   SocketFlags flags,
+							   out int error);
+
		public int Receive (byte [] buf, int offset, int size, SocketFlags flags)
		{
			if (disposed && closed)
@@ -1381,56 +2407,47 @@
			if (size < 0 || offset + size > buf.Length)
				throw new ArgumentOutOfRangeException ("size");

-			SocketError error;
-
-			int ret = Receive_nochecks (buf, offset, size, flags, out error);
-
-			if(error != SocketError.Success)
-				throw new SocketException ((int) error);
-
-			return ret;
+			return Receive_nochecks (buf, offset, size, flags);
		}

-#if NET_2_0
-		public int Receive (byte [] buf, int offset, int size, SocketFlags flags, 
out SocketError error)
+		int Receive_nochecks (byte [] buf, int offset, int size, SocketFlags 
flags)
		{
-			if (disposed && closed)
-				throw new ObjectDisposedException (GetType ().ToString ());
-
-			if (buf == null)
-				throw new ArgumentNullException ("buf");
+			int ret, error;

-			if (offset < 0 || offset > buf.Length)
-				throw new ArgumentOutOfRangeException ("offset");
+			ret = Receive_internal (socket, buf, offset, size, flags, out error);

-			if (size < 0 || offset + size > buf.Length)
-				throw new ArgumentOutOfRangeException ("size");
+			if (error != 0) {
+				if (error != 10035 && error != 10036) // WSAEWOULDBLOCK && 
WSAEINPROGRESS
+					connected = false;

-			return Receive_nochecks (buf, offset, size, flags, out error);
+				throw new SocketException (error);
		}
-#endif
-
-		[MethodImplAttribute(MethodImplOptions.InternalCall)]
-		private extern static int Receive_internal(IntPtr sock,
-							   byte[] buffer,
-							   int offset,
-							   int count,
-							   SocketFlags flags,
-							   out int error);

-		int Receive_nochecks (byte [] buf, int offset, int size, SocketFlags 
flags, out SocketError error)
-		{
-			int nativeError;
-			int ret = Receive_internal (socket, buf, offset, size, flags, out 
nativeError);
-			error = (SocketError) nativeError;
-			if (error != SocketError.Success && error != SocketError.WouldBlock && 
error != SocketError.InProgress)
-				connected = false;
-			else
				connected = true;

			return ret;
		}

+//#if NET_2_0
+        //public int Receive (IList<ArraySegment<byte>> buffers) {
+
+
+        //    int bufsize = ((ArraySegment<byte>)buffers).Array.Length;
+        //    byte[] buf = ((ArraySegment<byte>)buffers).Array;
+
+        //    int bytesRecv = SOCKET_ERROR;
+        //    int offset=0;
+        //    while (bytesRecv != SOCKET_ERROR) {
+        //        bytesRecv = Receive_nochecks(buf, offset, bufsize, 
SocketFlags.None);
+        //        if (bytesRecv == bufsize) {
+        //            ((IList)buffers).Add(buf);
+        //            offset+=bufsize;
+        //        }
+        //    }
+        //}
+
+//#endif
+
		public int ReceiveFrom (byte [] buf, ref EndPoint remote_end)
		{
			if (disposed && closed)
@@ -1525,7 +2542,9 @@
			}

			connected = true;
-
+#if NET_2_0
+            isbound = true;
+#endif
			// If sockaddr is null then we're a connection
			// oriented protocol and should ignore the
			// remote_end parameter (see MSDN
@@ -1548,14 +2567,7 @@
			if (buf == null)
				throw new ArgumentNullException ("buf");

-			SocketError error;
-
-			int ret = Send_nochecks (buf, 0, buf.Length, SocketFlags.None, out 
error);
-
-			if (error != SocketError.Success)
-				throw new SocketException ((int) error);
-
-			return ret;
+			return Send_nochecks (buf, 0, buf.Length, SocketFlags.None);
		}

		public int Send (byte [] buf, SocketFlags flags)
@@ -1566,14 +2578,7 @@
			if (buf == null)
				throw new ArgumentNullException ("buf");

-			SocketError error;
-
-			int ret = Send_nochecks (buf, 0, buf.Length, flags, out error);
-
-			if (error != SocketError.Success)
-				throw new SocketException ((int) error);
-
-			return ret;
+			return Send_nochecks (buf, 0, buf.Length, flags);
		}

		public int Send (byte [] buf, int size, SocketFlags flags)
@@ -1587,16 +2592,16 @@
			if (size < 0 || size > buf.Length)
				throw new ArgumentOutOfRangeException ("size");

-			SocketError error;
-
-			int ret = Send_nochecks (buf, 0, size, flags, out error);
-
-			if (error != SocketError.Success)
-				throw new SocketException ((int) error);
-
-			return ret;
+			return Send_nochecks (buf, 0, size, flags);
		}

+		[MethodImplAttribute(MethodImplOptions.InternalCall)]
+		private extern static int Send_internal(IntPtr sock,
+							byte[] buf, int offset,
+							int count,
+							SocketFlags flags,
+							out int error);
+
		public int Send (byte [] buf, int offset, int size, SocketFlags flags)
		{
			if (disposed && closed)
@@ -1611,19 +2616,97 @@
			if (size < 0 || offset + size > buf.Length)
				throw new ArgumentOutOfRangeException ("size");

-			SocketError error;
+			return Send_nochecks (buf, offset, size, flags);
+        }
+
+
+        int Send_nochecks (byte [] buf, int offset, int size, SocketFlags 
flags)
+		{
+			if (size == 0)
+				return 0;
+
+			int ret, error;
+
+			ret = Send_internal (socket, buf, offset, size, flags, out error);
+
+			if (error != 0) {
+				if (error != 10035 && error != 10036) // WSAEWOULDBLOCK && 
WSAEINPROGRESS
+					connected = false;

-			int ret = Send_nochecks (buf, offset, size, flags, out error);
+				throw new SocketException (error);
+			}

-			if (error != SocketError.Success)
-				throw new SocketException ((int) error);
+			connected = true;

			return ret;
		}

-#if NET_2_0
-		public int Send (byte [] buf, int offset, int size, SocketFlags flags, 
out SocketError error)
-		{
+#if NET_2_0 //Sri
+
+        public int Send (IList<ArraySegment<byte>> buffers){
+
+            if (buffers == null)
+                throw new ArgumentNullException("buffers is a null 
reference");
+            if (closed && disposed)
+                throw new ObjectDisposedException(GetType().ToString());
+            IEnumerator enumerator = ((IList)buffers).GetEnumerator();
+            byte[] buf=null;
+            enumerator.MoveNext();
+            for (int i=0; i<= ((IList)buffers).Count; i++) {
+                buf = (byte)enumerator.Current;
+                Send_nochecks(buf, 0, buf.Length, SocketFlags.None);
+                enumerator.MoveNext();
+
+            }
+        }
+
+        public int Send (IList<ArraySegment<byte>> buffers,	SocketFlags 
socketFlags){
+            if (buffers == null)
+                throw new ArgumentNullException("buffers is a null 
reference"0;
+            if (disposed && closed)
+                throw new ObjectDisposedException(GetType().ToString());
+            IEnumerator enumerator = 
((IList<ArraySegment<byte>>)buffers).GetEnumerator();
+            byte[] buf=null;
+            enumerator.MoveNext();
+            for (int i=0; i<= ((IList)buffers).Count; i++) {
+                buf = (byte)enumerator.Current;
+
+                Send_nochecks(buf, 0, buf.Length, socketFlags);
+                enumerator.MoveNext();
+            }
+        }
+
+        [CLSCompliantAttribute(false)]
+        public int Send (IList<ArraySegment<byte>> buffers,	SocketFlags 
socketFlags,
+                       out SocketError errorCode) {
+
+            if (disposed && closed)
+                throw new ObjectDisposedException(GetType().ToString());
+            if (buffers == null)
+                throw new ArgumentNullException("buffers is a null 
reference");
+
+            IEnumerator enumerator = 
((IList<ArraySegment<byte>>)buffers).GetEnumerator();
+            byte[] buf=null;
+            int error = 0;
+            enumerator.MoveNext();
+            for (int i=0; i<= ((IList)buffers).Count; i++) {
+                buf = (byte)enumerator.Current;
+                Send_internal(this, buf, 0, buf.Length, socketFlags, 
error);
+                if (error != 0){
+                    errorCode = error;
+                    return;
+
+                }
+                Send_nochecks(buf, 0, buf.Length, socketFlags);
+                enumerator.MoveNext();
+            }
+
+        }
+
+
+        public int Send(byte[] buffer, int offset, int size,
+                    SocketFlags socketFlags, out SocketError errorCode) {
+
			if (disposed && closed)
				throw new ObjectDisposedException (GetType ().ToString ());

@@ -1636,38 +2719,29 @@
			if (size < 0 || offset + size > buf.Length)
				throw new ArgumentOutOfRangeException ("size");

-			return Send_nochecks (buf, offset, size, flags, out error);
-		}
-#endif
-
-		[MethodImplAttribute(MethodImplOptions.InternalCall)]
-		private extern static int Send_internal(IntPtr sock,
-							byte[] buf, int offset,
-							int count,
-							SocketFlags flags,
-							out int error);
-
-		int Send_nochecks (byte [] buf, int offset, int size, SocketFlags flags, 
out SocketError error)
-		{
-			if (size == 0) {
-				error = SocketError.Success;
+            if (size == 0)
				return 0;
-			}

-			int nativeError;
-
-			int ret = Send_internal (socket, buf, offset, size, flags, out 
nativeError);
+            int ret, error;

-			error = (SocketError)nativeError;
+            ret = Send_internal(socket, buffer, offset, size, socketFlags, 
out error);

-			if (error != SocketError.Success && error != SocketError.WouldBlock && 
error != SocketError.InProgress)
+            if (error != 0)
+            {
+                if (error != 10035 && error != 10036) // WSAEWOULDBLOCK && 
WSAEINPROGRESS
				connected = false;
-			else
+
+                throw new SocketException(error);
+            }
+
				connected = true;

			return ret;
		}

+        }
+#endif
+
		public int SendTo (byte [] buffer, EndPoint remote_end)
		{
			if (disposed && closed)
@@ -1761,7 +2835,9 @@
			}

			connected = true;
-
+#if NET_2_0
+            isbound = true;
+#endif
			return ret;
		}

@@ -1904,5 +2980,7 @@
			Dispose(false);
		}
	}
+
+
}


