Index: class/System.Runtime.Remoting/Test/ChangeLog
===================================================================
--- class/System.Runtime.Remoting/Test/ChangeLog	(revision 49867)
+++ class/System.Runtime.Remoting/Test/ChangeLog	(working copy)
@@ -1,3 +1,7 @@
+2005-09-11  Robert Jordan <robertj@gmx.net>
+
+	* UnixCalls.cs: test case for the Unix channel.
+
 2005-04-27  Lluis Sanchez Gual  <lluis@ximian.com>
 
 	* RemotingServicesTest.cs: Fix warning.
Index: class/System.Runtime.Remoting/Test/UnixCalls.cs
===================================================================
--- class/System.Runtime.Remoting/Test/UnixCalls.cs	(revision 0)
+++ class/System.Runtime.Remoting/Test/UnixCalls.cs	(revision 0)
@@ -0,0 +1,67 @@
+//
+// MonoTests.Remoting.UnixCalls.cs
+//
+// Author: Lluis Sanchez Gual (lluis@ximian.com)
+//         Robert Jordan (robertj@gmx.net)
+//
+// 2003 (C) Copyright, Ximian, Inc.
+//
+
+using System;
+using System.Runtime.Remoting;
+using System.Runtime.Remoting.Channels;
+using Mono.Remoting.Channels.Unix;
+using NUnit.Framework;
+
+namespace MonoTests.Remoting
+{
+	[TestFixture]
+	public class UnixSyncCallTest : SyncCallTest
+	{
+		public override ChannelManager CreateChannelManager ()
+		{
+			return new UnixChannelManager ();
+		}
+	}
+
+	[TestFixture]
+	public class UnixAsyncCallTest : AsyncCallTest
+	{
+		public override ChannelManager CreateChannelManager ()
+		{
+			return new UnixChannelManager ();
+		}
+	}
+
+	[TestFixture]
+	public class UnixReflectionCallTest : ReflectionCallTest
+	{
+		public override ChannelManager CreateChannelManager ()
+		{
+			return new UnixChannelManager ();
+		}
+	}
+
+	[TestFixture]
+	public class UnixDelegateCallTest : DelegateCallTest
+	{
+		public override ChannelManager CreateChannelManager ()
+		{
+			return new UnixChannelManager ();
+		}
+	}
+
+	[Serializable]
+	public class UnixChannelManager : ChannelManager
+	{
+		public override IChannelSender CreateClientChannel ()
+		{
+			return new UnixChannel (null);
+		}
+
+		public override IChannelReceiver CreateServerChannel ()
+		{
+			return new UnixChannel ("/tmp/UnixCallsTestSocket");
+		}
+	}
+}

Property changes on: class/System.Runtime.Remoting/Test/UnixCalls.cs
___________________________________________________________________
Name: svn:eol-style
   + native

Index: class/System.Runtime.Remoting/System.Runtime.Remoting_test.dll.sources
===================================================================
--- class/System.Runtime.Remoting/System.Runtime.Remoting_test.dll.sources	(revision 49867)
+++ class/System.Runtime.Remoting/System.Runtime.Remoting_test.dll.sources	(working copy)
@@ -12,3 +12,4 @@
 HttpCalls.cs
 ActivationTests.cs
 RemotingServicesTest.cs
+UnixCalls.cs
Index: class/System.Runtime.Remoting/ChangeLog
===================================================================
--- class/System.Runtime.Remoting/ChangeLog	(revision 49867)
+++ class/System.Runtime.Remoting/ChangeLog	(working copy)
@@ -1,3 +1,8 @@
+2005-09-11  Robert Jordan <robertj@gmx.net>
+
+	* System.Runtime.Remoting_test.dll.sources: Added: UnixChannel.cs.
+	* Makefile: Added reference to Mono.Posix.dll for the Unix channel.
+
 2005-01-14  Lluis Sanchez Gual  <lluis@novell.com>
 
 	* System.Runtime.Remoting_test.dll.sources: Added:
Index: class/System.Runtime.Remoting/Makefile
===================================================================
--- class/System.Runtime.Remoting/Makefile	(revision 49867)
+++ class/System.Runtime.Remoting/Makefile	(working copy)
@@ -7,7 +7,8 @@
 LIB_MCS_FLAGS = /r:$(corlib) /r:System.dll /r:System.Web.dll \
 	/r:System.Xml.dll /r:System.Runtime.Serialization.Formatters.Soap.dll
 
-TEST_MCS_FLAGS = $(LIB_MCS_FLAGS) -nowarn:618 /r:System.Runtime.Remoting.dll
+TEST_MCS_FLAGS = $(LIB_MCS_FLAGS) -nowarn:618 /r:System.Runtime.Remoting.dll \
+	/r:Mono.Posix.dll
 
 TEST_MONO_PATH = .
 
