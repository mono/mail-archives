>From 58c74142d5591dca224cc214a3ee60815d81d92b Mon Sep 17 00:00:00 2001
From: Frank Wilhelm <fwilhelm@nowisys.de>
Date: Fri, 8 Oct 2010 18:35:00 +0000
Subject: [PATCH 1/2] Fixed error in validation by WebHttpBehavior

The WebHttpBehavior did not allow multiple parameters without using the
'wrapped' BodyFormat. But there is only a problem if more than one
parameter is not passed as part of the URI or there is an output
parameter.
---
 .../WebHttpBehavior.cs                             |   43 ++++++++++++--------
 .../WebHttpBehaviorTest.cs                         |   25 +++++++++++
 2 files changed, 51 insertions(+), 17 deletions(-)

diff --git a/mcs/class/System.ServiceModel.Web/System.ServiceModel.Description/WebHttpBehavior.cs b/mcs/class/System.ServiceModel.Web/System.ServiceModel.Description/WebHttpBehavior.cs
index 38b804f..4bc4288 100644
--- a/mcs/class/System.ServiceModel.Web/System.ServiceModel.Description/WebHttpBehavior.cs
+++ b/mcs/class/System.ServiceModel.Web/System.ServiceModel.Description/WebHttpBehavior.cs
@@ -233,24 +233,33 @@ namespace System.ServiceModel.Description
 				if (wai.Method == "GET")
 					continue;
 				var style = wai != null && wai.IsBodyStyleSetExplicitly ? wai.BodyStyle : DefaultBodyStyle;
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
+
+				if (style == WebMessageBodyStyle.Bare) {
+					var uri = new UriTemplate(wai.UriTemplate);
+
+					// find all placeholders in the URI
+					string[] parameters = new string[uri.PathSegmentVariableNames.Count + uri.QueryValueVariableNames.Count];
+					uri.PathSegmentVariableNames.CopyTo(parameters, 0);
+					uri.QueryValueVariableNames.CopyTo(parameters, uri.PathSegmentVariableNames.Count);
+					Array.Sort(parameters, StringComparer.InvariantCultureIgnoreCase);
+
+					bool hasBody = false;
+
+					foreach (var msg in oper.Messages) {
+						if (msg.Direction == MessageDirection.Output && msg.Body.Parts.Count > 0)
+							throw new InvalidOperationException (String.Format ("Operation '{0}' has output parameters. BodyStyle must be 'wrapped' on the operation WebInvoke/WebGet attribute.", oper.Name));
+
+						foreach (var part in msg.Body.Parts) {
+							if (Array.BinarySearch(parameters, part.Name, StringComparer.InvariantCultureIgnoreCase) < 0) {
+								// this part of the message is not covered by a placeholder in the URI
+								// so it must be passed in the body
+								if (hasBody)
+									throw new InvalidOperationException (String.Format ("Operation '{0}' has multiple message body parts. BodyStyle must be 'wrapped' or parameters put into the UriTemplate on the operation WebInvoke/WebGet attribute.", oper.Name));
+								hasBody = true;
+							}
+						}
 					}
+				}
 			}
 
 			ValidateBinding (endpoint);
diff --git a/mcs/class/System.ServiceModel.Web/Test/System.ServiceModel.Description/WebHttpBehaviorTest.cs b/mcs/class/System.ServiceModel.Web/Test/System.ServiceModel.Description/WebHttpBehaviorTest.cs
index 1267d08..1d2fe11 100644
--- a/mcs/class/System.ServiceModel.Web/Test/System.ServiceModel.Description/WebHttpBehaviorTest.cs
+++ b/mcs/class/System.ServiceModel.Web/Test/System.ServiceModel.Description/WebHttpBehaviorTest.cs
@@ -234,6 +234,31 @@ namespace MonoTests.System.ServiceModel.Description
 			formatter.DeserializeRequest (msg, pars);
 			Assert.IsTrue (pars [0] is Stream, "ret");
 		}
+
+		[ServiceContract]
+		public interface IUriParameterService
+		{
+			[OperationContract]
+			[WebGet(UriTemplate="get?p1={p1}&p2={p2}")]
+			void Get(string p1, string p2);
+
+			[OperationContract]
+			[WebInvoke(UriTemplate="post?p1={p1}&p2={p2}")]
+			void Post(string p1, string p2);
+
+			[OperationContract]
+			[WebInvoke(UriTemplate="post?p1={p1}")]
+			void Post2(string p1, string p2);
+		}
+
+		[Test]
+		public void UriParameters ()
+		{
+			var behavior = new WebHttpBehavior();
+			var cd = ContractDescription.GetContract (typeof (IUriParameterService));
+			var se = new ServiceEndpoint (cd, new WebHttpBinding (), new EndpointAddress ("http://localhost:8080/"));
+			behavior.Validate(se);
+		}
 	}
 
 	[ServiceContract]
-- 
1.7.1.1

