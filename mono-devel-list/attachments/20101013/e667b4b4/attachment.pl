diff --git a/mcs/class/System.ServiceModel.Web/System.ServiceModel.Description/WebHttpBehavior.cs b/mcs/class/System.ServiceModel.Web/System.ServiceModel.Description/WebHttpBehavior.cs
index 38b804f..32554b9 100644
--- a/mcs/class/System.ServiceModel.Web/System.ServiceModel.Description/WebHttpBehavior.cs
+++ b/mcs/class/System.ServiceModel.Web/System.ServiceModel.Description/WebHttpBehavior.cs
@@ -222,6 +222,61 @@ namespace System.ServiceModel.Description
 		}
 #endif
 
+		WebMessageBodyStyle GetBodyStyle (WebAttributeInfo wai)
+		{
+			return wai != null && wai.IsBodyStyleSetExplicitly ? wai.BodyStyle : DefaultBodyStyle;
+		}
+
+		protected void ValidateOperation (OperationDescription operation)
+		{
+			var wai = operation.GetWebAttributeInfo ();
+			if (wai.Method == "GET")
+				return;
+			var style = GetBodyStyle (wai);
+
+			// if the style is wrapped there won't be problems
+			if (style == WebMessageBodyStyle.Wrapped)
+				return;
+
+			string [] parameters;
+			if (wai.UriTemplate != null) {
+				// find all variables in the URI
+				var uri = new UriTemplate (wai.UriTemplate);
+				parameters = new string [uri.PathSegmentVariableNames.Count + uri.QueryValueVariableNames.Count];
+				uri.PathSegmentVariableNames.CopyTo (parameters, 0);
+				uri.QueryValueVariableNames.CopyTo (parameters, uri.PathSegmentVariableNames.Count);
+
+				// sort because Array.BinarySearch is the easiest way for case-insensitive search
+				Array.Sort (parameters, StringComparer.InvariantCultureIgnoreCase);
+			} else
+				parameters = new string [0];
+
+			bool hasBody = false;
+
+			foreach (var msg in operation.Messages) {
+				if (msg.Direction == MessageDirection.Input) {
+					// the message is for a request
+					// if requests are wrapped there is nothing to check
+					if (style == WebMessageBodyStyle.WrappedRequest)
+						continue;
+
+					foreach (var part in msg.Body.Parts) {
+						if (Array.BinarySearch (parameters, part.Name, StringComparer.InvariantCultureIgnoreCase) < 0) {
+							// this part of the message is not covered by a variable in the URI
+							// so it must be passed in the body
+							if (hasBody)
+								throw new InvalidOperationException (String.Format ("Operation '{0}' has multiple message body parts. Add parameters to the UriTemplate or change the BodyStyle to 'Wrapped' or 'WrappedRequest' on the WebInvoke/WebGet attribute.", operation.Name));
+							hasBody = true;
+						}
+					}
+				} else {
+					// the message is for a response
+					if (style != WebMessageBodyStyle.WrappedResponse && msg.Body.Parts.Count > 0)
+						throw new InvalidOperationException (String.Format ("Operation '{0}' has output parameters. BodyStyle must be 'Wrapped' or 'WrappedResponse' on the operation WebInvoke/WebGet attribute.", operation.Name));
+				}
+			}
+		}
+
 		[MonoTODO ("check UriTemplate validity")]
 		public virtual void Validate (ServiceEndpoint endpoint)
 		{
@@ -229,28 +284,7 @@ namespace System.ServiceModel.Description
 				throw new ArgumentNullException ("endpoint");
 
 			foreach (var oper in endpoint.Contract.Operations) {
-				var wai = oper.GetWebAttributeInfo ();
-				if (wai.Method == "GET")
-					continue;
-				var style = wai != null && wai.IsBodyStyleSetExplicitly ? wai.BodyStyle : DefaultBodyStyle;
-				foreach (var msg in oper.Messages)
-					switch (style) {
-					case WebMessageBodyStyle.Wrapped:
-						continue;
-					case WebMessageBodyStyle.WrappedRequest:
-						if (msg.Direction == MessageDirection.Output)
-							continue;
-						goto case WebMessageBodyStyle.Bare;
-					case WebMessageBodyStyle.WrappedResponse:
-						if (msg.Direction == MessageDirection.Input)
-							continue;
-						goto case WebMessageBodyStyle.Bare;
-					case WebMessageBodyStyle.Bare:
-					default:
-						if (msg.Body.Parts.Count > 1)
-							throw new InvalidOperationException (String.Format ("{0} message on operation '{1}' has multiple parameters which is not allowed when the operation indicates no wrapper element. BodyStyle must be 'wrapped' on the operation WebInvoke/WebGet attribute.", msg.Direction, oper.Name));
-						break;
-					}
+				ValidateOperation (oper);
 			}
 
 			ValidateBinding (endpoint);
diff --git a/mcs/class/System.ServiceModel.Web/Test/System.ServiceModel.Description/WebHttpBehaviorTest.cs b/mcs/class/System.ServiceModel.Web/Test/System.ServiceModel.Description/WebHttpBehaviorTest.cs
index 1267d08..4ba5014 100644
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
@@ -234,6 +248,39 @@ namespace MonoTests.System.ServiceModel.Description
 			formatter.DeserializeRequest (msg, pars);
 			Assert.IsTrue (pars [0] is Stream, "ret");
 		}
+
+		[ServiceContract]
+		public interface IMultipleParameters
+		{
+			[OperationContract]
+			[WebGet (UriTemplate = "get")]
+			void Get(string p1, string p2);
+
+			[OperationContract]
+			[WebInvoke (UriTemplate = "posturi?p1={p1}&p2={p2}")]
+			string PostUri (string p1, string p2);
+
+			[OperationContract]
+			[WebInvoke (UriTemplate = "postone?p1={p1}")]
+			string PostOne (string p1, string p2);
+
+			[OperationContract]
+			[WebInvoke (UriTemplate = "postwrapped", BodyStyle=WebMessageBodyStyle.WrappedRequest)]
+			string PostWrapped (string p1, string p2);
+
+			[OperationContract]
+			[WebInvoke (UriTemplate = "out?p1={p1}&p2={p2}", BodyStyle=WebMessageBodyStyle.WrappedResponse)]
+			void PostOut (string p1, string p2, out string ret);
+		}
+
+		[Test]
+		public void MultipleParameters ()
+		{
+			var behavior = new WebHttpBehavior ();
+			var cd = ContractDescription.GetContract (typeof (IMultipleParameters));
+			var se = new ServiceEndpoint (cd, new WebHttpBinding (), new EndpointAddress ("http://localhost:8080/"));
+			behavior.Validate (se);
+		}
 	}
 
 	[ServiceContract]
