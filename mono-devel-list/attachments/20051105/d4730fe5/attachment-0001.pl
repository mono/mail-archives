Index: System.Runtime.Remoting.Channels/ChangeLog
===================================================================
--- System.Runtime.Remoting.Channels/ChangeLog	(revision 51949)
+++ System.Runtime.Remoting.Channels/ChangeLog	(working copy)
@@ -1,3 +1,7 @@
+2005-11-05  Robert Jordan  <robertj@gmx.net>
+
+	* IAuthorizeRemotingConnection.cs: Added.
+
 2005-05-18  Lluis Sanchez Gual  <lluis@novell.com>
 
 	* BinaryServerFormatterSink.cs: Properly handle exceptions raised
Index: System.Runtime.Remoting.Channels/IAuthorizeRemotingConnection.cs
===================================================================
--- System.Runtime.Remoting.Channels/IAuthorizeRemotingConnection.cs	(revision 0)
+++ System.Runtime.Remoting.Channels/IAuthorizeRemotingConnection.cs	(revision 0)
@@ -0,0 +1,45 @@
+//
+// System.Runtime.Remoting.Channels.IAuthorizeRemotingConnection.cs
+//
+// Author: Robert Jordan (robertj@gmx.net)
+//
+// Copyright (C) 2005 Novell, Inc (http://www.novell.com)
+//
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
+
+#if NET_2_0
+
+using System;
+using System.Net;
+using System.Security.Principal;
+
+namespace System.Runtime.Remoting.Channels
+{
+        public interface IAuthorizeRemotingConnection
+        {
+                bool IsConnectingEndPointAuthorized (EndPoint endPoint);
+                bool IsConnectingIdentityAuthorized (IIdentity identity);
+        }
+
+}
+
+#endif

Property changes on: System.Runtime.Remoting.Channels/IAuthorizeRemotingConnection.cs
___________________________________________________________________
Name: svn:eol-style
   + native

Index: System.Runtime.Remoting.dll.sources
===================================================================
--- System.Runtime.Remoting.dll.sources	(revision 52606)
+++ System.Runtime.Remoting.dll.sources	(working copy)
@@ -9,6 +9,7 @@
 System.Runtime.Remoting.Channels/BinaryServerFormatterSinkProvider.cs
 System.Runtime.Remoting.Channels/ChannelCore.cs
 System.Runtime.Remoting.Channels/CommonTransportKeys.cs
+System.Runtime.Remoting.Channels/IAuthorizeRemotingConnection.cs
 System.Runtime.Remoting.Channels/RemotingThreadPool.cs
 System.Runtime.Remoting.Channels/SoapClientFormatterSink.cs
 System.Runtime.Remoting.Channels/SoapCore.cs
Index: ChangeLog
===================================================================
--- ChangeLog	(revision 52606)
+++ ChangeLog	(working copy)
@@ -1,5 +1,9 @@
 2005-11-05  Robert Jordan  <robertj@gmx.net>
 
+	* System.Runtime.Remoting.dll.sources: Added Channels/IAuthorizeRemotingConnection.cs
+
+2005-11-05  Robert Jordan  <robertj@gmx.net>
+
 	* System.Runtime.Remoting.dll.sources: Removed Ipc/IpcChannelFactory.cs
 
 2005-10-19  Robert Jordan  <robertj@gmx.net>
