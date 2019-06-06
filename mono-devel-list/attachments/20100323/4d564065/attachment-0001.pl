Index: System.ServiceModel.Channels/ChannelListenerBase.cs
===================================================================
--- System.ServiceModel.Channels/ChannelListenerBase.cs	(revision 154034)
+++ System.ServiceModel.Channels/ChannelListenerBase.cs	(working copy)
@@ -84,7 +84,7 @@
 			get { return timeouts.SendTimeout; }
 		}
 
-		internal KeyedByTypeCollection<object> Properties {
+		internal virtual KeyedByTypeCollection<object> Properties {
 			get {
 				if (properties == null)
 					properties = new KeyedByTypeCollection<object> ();
Index: System.ServiceModel.Channels/TransactionFlowBindingElement.cs
===================================================================
--- System.ServiceModel.Channels/TransactionFlowBindingElement.cs	(revision 154034)
+++ System.ServiceModel.Channels/TransactionFlowBindingElement.cs	(working copy)
@@ -161,6 +161,13 @@
 			this.protocol = protocol;
 		}
 
+		internal override KeyedByTypeCollection<object> Properties {
+			get {
+				var b = inner_listener as ChannelListenerBase;
+				return b != null ? b.Properties : base.Properties;
+			}
+		}
+
 		public override Uri Uri {
 			get { return inner_listener.Uri; }
 		}
