diff --git a/mcs/class/System.ServiceModel.Web/System.ServiceModel.Description/WebHttpBehavior.cs b/mcs/class/System.ServiceModel.Web/System.ServiceModel.Description/WebHttpBehavior.cs
index 38b804f..90241d0 100644
--- a/mcs/class/System.ServiceModel.Web/System.ServiceModel.Description/WebHttpBehavior.cs
+++ b/mcs/class/System.ServiceModel.Web/System.ServiceModel.Description/WebHttpBehavior.cs
@@ -200,30 +200,38 @@ namespace System.ServiceModel.Description
 
 		protected virtual IClientMessageFormatter GetReplyClientFormatter (OperationDescription operationDescription, ServiceEndpoint endpoint)
 		{
+			ValidateStyleForMessageFormatter (endpoint);
 			return new WebMessageFormatter.ReplyClientFormatter (operationDescription, endpoint, GetQueryStringConverter (operationDescription), this);
 		}
 
 #if !NET_2_1
 		protected virtual IDispatchMessageFormatter GetReplyDispatchFormatter (OperationDescription operationDescription, ServiceEndpoint endpoint)
 		{
+			ValidateStyleForMessageFormatter (endpoint);
 			return new WebMessageFormatter.ReplyDispatchFormatter (operationDescription, endpoint, GetQueryStringConverter (operationDescription), this);
 		}
 #endif
 
 		protected virtual IClientMessageFormatter GetRequestClientFormatter (OperationDescription operationDescription, ServiceEndpoint endpoint)
 		{
+			ValidateStyleForMessageFormatter (endpoint);
 			return new WebMessageFormatter.RequestClientFormatter (operationDescription, endpoint, GetQueryStringConverter (operationDescription), this);
 		}
 
 #if !NET_2_1
 		protected virtual IDispatchMessageFormatter GetRequestDispatchFormatter (OperationDescription operationDescription, ServiceEndpoint endpoint)
 		{
+			ValidateStyleForMessageFormatter (endpoint);
 			return new WebMessageFormatter.RequestDispatchFormatter (operationDescription, endpoint, GetQueryStringConverter (operationDescription), this);
 		}
 #endif
 
-		[MonoTODO ("check UriTemplate validity")]
-		public virtual void Validate (ServiceEndpoint endpoint)
+		WebMessageBodyStyle GetBodyStyle (WebAttributeInfo wai)
+		{
+			return wai != null && wai.IsBodyStyleSetExplicitly ? wai.BodyStyle : DefaultBodyStyle;
+		}
+
+		void ValidateStyleForMessageFormatter (ServiceEndpoint endpoint)
 		{
 			if (endpoint == null)
 				throw new ArgumentNullException ("endpoint");
@@ -232,7 +240,8 @@ namespace System.ServiceModel.Description
 				var wai = oper.GetWebAttributeInfo ();
 				if (wai.Method == "GET")
 					continue;
-				var style = wai != null && wai.IsBodyStyleSetExplicitly ? wai.BodyStyle : DefaultBodyStyle;
+				var style = GetBodyStyle (wai);
+
 				foreach (var msg in oper.Messages)
 					switch (style) {
 					case WebMessageBodyStyle.Wrapped:
@@ -252,6 +261,47 @@ namespace System.ServiceModel.Description
 						break;
 					}
 			}
+		}
+
+		[MonoTODO ("check UriTemplate validity")]
+		public virtual void Validate (ServiceEndpoint endpoint)
+		{
+			if (endpoint == null)
+				throw new ArgumentNullException ("endpoint");
+
+			foreach (var oper in endpoint.Contract.Operations) {
+				var wai = oper.GetWebAttributeInfo ();
+				if (wai.Method == "GET")
+					continue;
+				var style = GetBodyStyle (wai);
+
+				if (style == WebMessageBodyStyle.Bare && wai.UriTemplate != null) {
+					var uri = new UriTemplate(wai.UriTemplate);
+
+					// find all placeholders in the URI
+					string [] parameters = new string [uri.PathSegmentVariableNames.Count + uri.QueryValueVariableNames.Count];
+					uri.PathSegmentVariableNames.CopyTo (parameters, 0);
+					uri.QueryValueVariableNames.CopyTo (parameters, uri.PathSegmentVariableNames.Count);
+					Array.Sort (parameters, StringComparer.InvariantCultureIgnoreCase);
+
+					bool hasBody = false;
+
+					foreach (var msg in oper.Messages) {
+						if (msg.Direction == MessageDirection.Output && msg.Body.Parts.Count > 0)
+							throw new InvalidOperationException (String.Format ("Operation '{0}' has output parameters. BodyStyle must be 'wrapped' on the operation WebInvoke/WebGet attribute.", oper.Name));
+
+						foreach (var part in msg.Body.Parts) {
+							if (Array.BinarySearch (parameters, part.Name, StringComparer.InvariantCultureIgnoreCase) < 0) {
+								// this part of the message is not covered by a placeholder in the URI
+								// so it must be passed in the body
+								if (hasBody)
+									throw new InvalidOperationException (String.Format ("Operation '{0}' has multiple message body parts. BodyStyle must be 'wrapped' or parameters put into the UriTemplate on the operation WebInvoke/WebGet attribute.", oper.Name));
+								hasBody = true;
+							}
+						}
+					}
+				}
+			}
 
 			ValidateBinding (endpoint);
 		}
diff --git a/mcs/class/System.ServiceModel.Web/Test/System.ServiceModel.Description/WebHttpBehaviorTest.cs b/mcs/class/System.ServiceModel.Web/Test/System.ServiceModel.Description/WebHttpBehaviorTest.cs
index 1267d08..ddc4661 100644
--- a/mcs/class/System.ServiceModel.Web/Test/System.ServiceModel.Description/WebHttpBehaviorTest.cs
+++ b/mcs/class/System.ServiceModel.Web/Test/System.ServiceModel.Description/WebHttpBehaviorTest.cs
@@ -53,6 +53,20 @@ namespace MonoTests.System.ServiceModel.Description
 		}
 
 		[Test]
+		public void DefaultValues ()
+		{
+			var b = new WebHttpBehavior ();
+			Assert.AreEqual (WebMessageBodyStyle.Bare, b.DefaultBodyStyle, "#1");
+			Assert.AreEqual (WebMessageFormat.Xml, b.DefaultOutgoingRequestFormat, "#2");
+			Assert.AreEqual (WebMessageFormat.Xml, b.DefaultOutgoingResponseFormat, "#3");
+#if NET_4_0
+			Assert.IsFalse (b.AutomaticFormatSelectionEnabled, "#11");
+			Assert.IsFalse (b.FaultExceptionEnabled, "#12");
+			Assert.IsFalse (b.HelpEnabled, "#13");
+#endif
+		}
+		
+		[Test]
 		public void AddBiningParameters ()
 		{
 			var se = CreateEndpoint ();
@@ -234,6 +248,31 @@ namespace MonoTests.System.ServiceModel.Description
 			formatter.DeserializeRequest (msg, pars);
 			Assert.IsTrue (pars [0] is Stream, "ret");
 		}
+
+		[ServiceContract]
+		public interface IUriParameterService
+		{
+			[OperationContract]
+			[WebGet (UriTemplate = "get?p1={p1}&p2={p2}")]
+			void Get(string p1, string p2);
+
+			[OperationContract]
+			[WebInvoke (UriTemplate = "post?p1={p1}&p2={p2}")]
+			void Post (string p1, string p2);
+
+			[OperationContract]
+			[WebInvoke (UriTemplate = "post?p1={p1}")]
+			void Post2 (string p1, string p2);
+		}
+
+		[Test]
+		public void UriParameters ()
+		{
+			var behavior = new WebHttpBehavior();
+			var cd = ContractDescription.GetContract (typeof (IUriParameterService));
+			var se = new ServiceEndpoint (cd, new WebHttpBinding (), new EndpointAddress ("http://localhost:8080/"));
+			behavior.Validate (se);
+		}
 	}
 
 	[ServiceContract]
diff --git a/mcs/class/System.ServiceModel.Web/Test/System.ServiceModel.Web/WebInvokeAttributeTest.cs b/mcs/class/System.ServiceModel.Web/Test/System.ServiceModel.Web/WebInvokeAttributeTest.cs
index 2858239..e74e289 100644
--- a/mcs/class/System.ServiceModel.Web/Test/System.ServiceModel.Web/WebInvokeAttributeTest.cs
+++ b/mcs/class/System.ServiceModel.Web/Test/System.ServiceModel.Web/WebInvokeAttributeTest.cs
@@ -57,9 +57,18 @@ namespace MonoTests.System.ServiceModel.Description
 		}
 
 		[Test]
+		public void TwoParametersWhenNotWrapped ()
+		{
+			// It is not rejected, but the next test is.
+			var se = new ServiceEndpoint (ContractDescription.GetContract (typeof (IBogusService1)), new WebHttpBinding (), new EndpointAddress ("http://localhost:37564"));
+			new WebHttpBehavior ().Validate (se);
+		}
+
+		[Test]
 		[ExpectedException (typeof (InvalidOperationException))]
 		public void RejectTwoParametersWhenNotWrapped ()
 		{
+			// It is rejected, unlike the previous one.
 			new WebChannelFactory<IBogusService1> (new WebHttpBinding (), new Uri ("http://localhost:37564")).CreateChannel ();
 		}
 
