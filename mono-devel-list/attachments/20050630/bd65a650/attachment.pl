Index: System.Web.Services.Protocols/HttpSoapWebServiceHandler.cs
===================================================================
--- System.Web.Services.Protocols/HttpSoapWebServiceHandler.cs	(revision 46760)
+++ System.Web.Services.Protocols/HttpSoapWebServiceHandler.cs	(working copy)
@@ -48,7 +48,6 @@
 		SoapExtension[] _extensionChainLowPrio;
 		SoapMethodStubInfo methodInfo;
 		SoapServerMessage requestMessage = null;
-		object server;
 
 		public HttpSoapWebServiceHandler (Type type): base (type)
 		{
@@ -105,6 +104,12 @@
 					SerializeFault (context, requestMessage, ex);
 				}
 			}
+			finally {
+				IDisposable disp = requestMessage.Server as IDisposable;
+				requestMessage = null;
+				if (disp != null)
+					disp.Dispose();
+			}
 		}
 
 		SoapServerMessage DeserializeRequest (HttpRequest request)
@@ -119,7 +124,7 @@
 				if (ctype != "text/xml")
 					throw new WebException ("Content is not XML: " + ctype);
 					
-				server = CreateServerInstance ();
+				object server = CreateServerInstance ();
 
 				SoapServerMessage message = new SoapServerMessage (request, server, stream);
 				message.SetStage (SoapMessageStage.BeforeDeserialize);
Index: System.Web.Services.Protocols/HttpSimpleWebServiceHandler.cs
===================================================================
--- System.Web.Services.Protocols/HttpSimpleWebServiceHandler.cs	(revision 46760)
+++ System.Web.Services.Protocols/HttpSimpleWebServiceHandler.cs	(working copy)
@@ -115,9 +115,16 @@
 			try
 			{
 				object server = CreateServerInstance ();
-				object[] res = method.Invoke (server, parameters);
-				if (!method.IsVoid) return res[0];
-				else return null;
+				try {
+					object[] res = method.Invoke (server, parameters);
+					if (!method.IsVoid) return res[0];
+					else return null;
+				}
+				finally {
+					IDisposable disp = server as IDisposable;
+					if (disp != null)
+						disp.Dispose();
+				}
 			}
 			catch (TargetInvocationException ex)
 			{
