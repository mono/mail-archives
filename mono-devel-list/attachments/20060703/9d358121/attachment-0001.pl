--- TcpClient.cs.old	2006-04-14 23:19:40.000000000 +0530
+++ TcpClient.cs	2006-07-03 12:30:53.000000000 +0530
@@ -3,6 +3,8 @@
// Author:
// 	Phillip Pearson (pp@myelin.co.nz)
//	Gonzalo Paniagua Javier (gonzalo@novell.com)
+// NET_2_0:
+//  Sridhar Kulkarni (sridharkulkarni@gmail.com)
//
// Copyright (C) 2001, Phillip Pearson
//    http://www.myelin.co.nz
@@ -332,16 +334,58 @@
				} catch (Exception e) {
					if(client != null) {
						client.Close();
-						client = null;
-					}

					/// This is the last known address, re-throw the exception
					if(i == host.AddressList.Length-1)
						throw e;
				}
			}
+						client = null;
+					}
+		}
+
+
+#if NET_2_0
+        public void Connect (IPAddress[] ipAddresses, int port) {
+
+            if (disposed)
+                throw new ObjectDisposedException(GetType().ToString());
+            if (ipAddresses == null)
+                throw new ArgumentNullException("addresses is a null 
reference");
+            foreach (IPAddress address in ipAddresses) {
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
+                Connect(new IPEndPoint(address, port));
+            }
+        }
+
+        public void EndConnect (IAsyncResult asyncResult){
+            client.EndConnect(asyncResult);
		}
+        public IAsyncResult BeginConnect (IPAddress address, int port,
+                        AsyncCallback requestCallback, Object state){

+            client.BeginConnect(address, port, requestCallback, state);
+        }
+        public IAsyncResult BeginConnect (IPAddress[] addresses, int port,
+                        AsyncCallback requestCallback,	Object state){
+            client.BeginConnect(addresses, port, requestCallback, state);
+        }
+        public IAsyncResult BeginConnect (string host, int port,
+                            AsyncCallback requestCallback, Object state) {
+
+            client.BeginConnect(host, port, requestCallback, state);
+
+        }
+
+#endif
		void IDisposable.Dispose ()
		{
			Dispose (true);

