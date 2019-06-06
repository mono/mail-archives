Index: System.Net.Sockets/ChangeLog
===================================================================
--- System.Net.Sockets/ChangeLog	(revision 84012)
+++ System.Net.Sockets/ChangeLog	(working copy)
@@ -1,3 +1,7 @@
+2007-08-13   Robert Jordan  <robertj@gmx.net>
+
+	* Socket.cs: Remove 2.0 GetHashCode overload.
+
 2007-08-02  Dick Porter  <dick@ximian.com>
 
 	* Socket.cs: Patch from Brian Nickel (brian.nickel@gmail.com) to
Index: System.Net.Sockets/Socket.cs
===================================================================
--- System.Net.Sockets/Socket.cs	(revision 84012)
+++ System.Net.Sockets/Socket.cs	(working copy)
@@ -3240,10 +3240,16 @@
 				throw new SocketException (error);
 		}
 
+#if ONLY_1_1
 		public override int GetHashCode ()
 		{
+			// LAMESPEC:
+			// The socket is not suitable to serve as a hash code,
+			// because it will change during its lifetime, but
+			// this is how MS.NET 1.1 implemented this method.
 			return (int) socket; 
 		}
+#endif
 
 		protected virtual void Dispose (bool explicitDisposing)
 		{
