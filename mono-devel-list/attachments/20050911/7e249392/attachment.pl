Index: class/Mono.Posix/Mono.Remoting.Channels.Unix/UnixChannel.cs
===================================================================
--- class/Mono.Posix/Mono.Remoting.Channels.Unix/UnixChannel.cs	(revision 49879)
+++ class/Mono.Posix/Mono.Remoting.Channels.Unix/UnixChannel.cs	(working copy)
@@ -43,7 +43,7 @@
         private string _name = "unix";
         private int _priority = 1;
     
-        public UnixChannel (): this ("")
+        public UnixChannel (): this (null)
         {
         }
 
Index: class/Mono.Posix/Mono.Remoting.Channels.Unix/ChangeLog
===================================================================
--- class/Mono.Posix/Mono.Remoting.Channels.Unix/ChangeLog	(revision 49879)
+++ class/Mono.Posix/Mono.Remoting.Channels.Unix/ChangeLog	(working copy)
@@ -1,3 +1,9 @@
+2005-09-11  Robert Jordan  <robertj@gmx.net>
+
+	* UnixChannel.cs: fixed default ctor.
+	* UnixServerChannel.cs: fixed GetUrlsForUri to return properly
+	 formatted unix URIs (the "?" was missing).
+
 2005-08-24  Lluis Sanchez Gual  <lluis@novell.com>
 
 	* UnixServerChannel.cs:
Index: class/Mono.Posix/Mono.Remoting.Channels.Unix/UnixServerChannel.cs
===================================================================
--- class/Mono.Posix/Mono.Remoting.Channels.Unix/UnixServerChannel.cs	(revision 49879)
+++ class/Mono.Posix/Mono.Remoting.Channels.Unix/UnixServerChannel.cs	(working copy)
@@ -157,7 +157,7 @@
             string [] result = new String [chnl_uris.Length];
 
             for (int i = 0; i < chnl_uris.Length; i++) 
-                result [i] = chnl_uris [i] + uri;
+                result [i] = chnl_uris [i] + "?" + uri;
             
             return result;
         }
