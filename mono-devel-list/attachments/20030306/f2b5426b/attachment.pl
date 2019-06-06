? ChannelServices.diff
Index: ChannelServices.cs
===================================================================
RCS file: /mono/mcs/class/corlib/System.Runtime.Remoting.Channels/ChannelServices.cs,v
retrieving revision 1.12
diff -u -r1.12 ChannelServices.cs
--- ChannelServices.cs	3 Mar 2003 16:40:35 -0000	1.12
+++ ChannelServices.cs	7 Mar 2003 00:08:58 -0000
@@ -181,6 +181,10 @@
 				throw new RemotingException ();
 
 			registeredChannels.Remove ((object) chnl);
+
+			IChannelReceiver chnlReceiver = chnl as IChannelReceiver;
+			if(chnlReceiver != null)
+				chnlReceiver.StopListening(null);
 		}
 
 		internal static object [] GetCurrentChannelInfo ()
