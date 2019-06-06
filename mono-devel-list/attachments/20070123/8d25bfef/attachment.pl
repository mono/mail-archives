Index: System.Net.Sockets/Socket.cs
===================================================================
--- System.Net.Sockets/Socket.cs	(revision 71501)
+++ System.Net.Sockets/Socket.cs	(working copy)
@@ -818,9 +818,11 @@
 				bool dontfragment;
 				
 				if (address_family == AddressFamily.InterNetwork) {
-					dontfragment = (int)(GetSocketOption (SocketOptionLevel.IP, SocketOptionName.DontFragment)) != 0;
+					object o = GetSocketOption (SocketOptionLevel.IP, SocketOptionName.DontFragment);
+					dontfragment = o is int && ((int) o) != 0;
 				} else if (address_family == AddressFamily.InterNetworkV6) {
-					dontfragment = (int)(GetSocketOption (SocketOptionLevel.IPv6, SocketOptionName.DontFragment)) != 0;
+					object o = GetSocketOption (SocketOptionLevel.IPv6, SocketOptionName.DontFragment);
+					dontfragment = o is int && ((int) o) != 0;
 				} else {
 					throw new NotSupportedException ("This property is only valid for InterNetwork and InterNetworkV6 sockets");
 				}