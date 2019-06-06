Index: corlib.dll.sources
===================================================================
--- corlib.dll.sources	(revision 51732)
+++ corlib.dll.sources	(working copy)
@@ -820,6 +820,7 @@
 System.Runtime.Remoting.Channels/IClientFormatterSink.cs
 System.Runtime.Remoting.Channels/IClientFormatterSinkProvider.cs
 System.Runtime.Remoting.Channels/IClientResponseChannelSinkStack.cs
+System.Runtime.Remoting.Channels/ISecurableChannel.cs
 System.Runtime.Remoting.Channels/IServerResponseChannelSinkStack.cs
 System.Runtime.Remoting.Channels/ServerDispatchSink.cs
 System.Runtime.Remoting.Channels/ServerDispatchSinkProvider.cs
Index: ChangeLog
===================================================================
--- ChangeLog	(revision 51732)
+++ ChangeLog	(working copy)
@@ -1,3 +1,7 @@
+2005-11-05  Robert Jordan  <robertj@gmx.net>
+
+	* corlib.dll.sources: Added System.Runtime.Remoting.Channels/ISecurableChannel.cs
+
 2005-10-07  Zoltan Varga  <vargaz@gmail.com>
 
 	* corlib.dll.sources: Add System.Runtime.CompilerServices/{RuntimeCompatibilityAttribute.cs, RuntimeWrappedException.cs}.
Index: System.Runtime.Remoting.Channels/ChangeLog
===================================================================
--- System.Runtime.Remoting.Channels/ChangeLog	(revision 51732)
+++ System.Runtime.Remoting.Channels/ChangeLog	(working copy)
@@ -1,3 +1,7 @@
+2005-11-05  Robert Jordan  <robertj@gmx.net>
+
+	* ISecurableChannel.cs: Added.
+
 2005-06-01  Lluis Sanchez Gual  <lluis@novell.com>
 
 	* TransportHeaders.cs: This collection turns out to be case insensitive
Index: System.Runtime.Remoting.Channels/ISecurableChannel.cs
===================================================================
--- System.Runtime.Remoting.Channels/ISecurableChannel.cs	(revision 0)
+++ System.Runtime.Remoting.Channels/ISecurableChannel.cs	(revision 0)
@@ -0,0 +1,41 @@
+//
+// System.Runtime.Remoting.Channels.ISecurableChannel.cs
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
+
+namespace System.Runtime.Remoting.Channels
+{
+	public interface ISecurableChannel
+	{
+		bool IsSecured { get; set; }
+	}
+}
+
+#endif

Property changes on: System.Runtime.Remoting.Channels/ISecurableChannel.cs
___________________________________________________________________
Name: svn:eol-style
   + native

