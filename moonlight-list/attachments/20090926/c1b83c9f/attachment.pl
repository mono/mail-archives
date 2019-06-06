Index: System.ServiceModel.Web/WebInvokeAttribute.cs
===================================================================
--- System.ServiceModel.Web/WebInvokeAttribute.cs	(revision 142176)
+++ System.ServiceModel.Web/WebInvokeAttribute.cs	(working copy)
@@ -34,7 +34,12 @@
 namespace System.ServiceModel.Web
 {
 	[AttributeUsage (AttributeTargets.Method)]
-	public sealed class WebInvokeAttribute : Attribute, IOperationBehavior
+	public sealed class WebInvokeAttribute
+#if NET_2_1
+		: Attribute
+#else
+		: Attribute, IOperationBehavior
+#endif
 	{
 		WebAttributeInfo info = new WebAttributeInfo ();
 
@@ -79,6 +84,7 @@
 			set { info.UriTemplate = value; }
 		}
 
+#if !NET_2_1
 		void IOperationBehavior.AddBindingParameters (OperationDescription operation, BindingParameterCollection parameters)
 		{
 			// "it is a passive operation behavior"
@@ -98,5 +104,6 @@
 		{
 			// "it is a passive operation behavior"
 		}
+#endif
 	}
 }
Index: System.ServiceModel.Web/WebGetAttribute.cs
===================================================================
--- System.ServiceModel.Web/WebGetAttribute.cs	(revision 142176)
+++ System.ServiceModel.Web/WebGetAttribute.cs	(working copy)
@@ -34,7 +34,12 @@
 namespace System.ServiceModel.Web
 {
 	[AttributeUsage (AttributeTargets.Method)]
-	public sealed class WebGetAttribute : Attribute, IOperationBehavior
+	public sealed class WebGetAttribute
+#if NET_2_1
+		: Attribute
+#else
+		: Attribute, IOperationBehavior
+#endif
 	{
 		WebAttributeInfo info = new WebAttributeInfo () { Method = "GET" };
 
@@ -74,6 +79,7 @@
 			set { info.UriTemplate = value; }
 		}
 
+#if !NET_2_1
 		void IOperationBehavior.AddBindingParameters (OperationDescription operation, BindingParameterCollection parameters)
 		{
 			// "it is a passive operation behavior"
@@ -93,5 +99,6 @@
 		{
 			// "it is a passive operation behavior"
 		}
+#endif
 	}
 }
Index: System.ServiceModel.Web/WebOperationContext.cs
===================================================================
--- System.ServiceModel.Web/WebOperationContext.cs	(revision 142176)
+++ System.ServiceModel.Web/WebOperationContext.cs	(working copy)
@@ -30,6 +30,11 @@
 using System.ServiceModel.Channels;
 using System.ServiceModel.Description;
 
+#if NET_2_1
+using IncomingWebRequestContext = System.Object;
+using OutgoingWebResponseContext = System.Object;
+#endif
+
 namespace System.ServiceModel.Web
 {
 	public class WebOperationContext : IExtension<OperationContext>
@@ -56,15 +61,20 @@
 		{
 			if (operation == null)
 				throw new ArgumentNullException ("operation");
+
+			outgoing_request = new OutgoingWebRequestContext ();
+			incoming_response = new IncomingWebResponseContext (operation);
+#if !NET_2_1
 			incoming_request = new IncomingWebRequestContext (operation);
-			incoming_response = new IncomingWebResponseContext (operation);
-			outgoing_request = new OutgoingWebRequestContext ();
 			outgoing_response = new OutgoingWebResponseContext ();
+#endif
 		}
 
+#if !NET_2_1
 		public IncomingWebRequestContext IncomingRequest {
 			get { return incoming_request; }
 		}
+#endif
 
 		public IncomingWebResponseContext IncomingResponse {
 			get { return incoming_response; }
@@ -74,9 +84,11 @@
 			get { return outgoing_request; }
 		}
 
+#if !NET_2_1
 		public OutgoingWebResponseContext OutgoingResponse {
 			get { return outgoing_response; }
 		}
+#endif
 
 		public void Attach (OperationContext context)
 		{
Index: System.ServiceModel.Web/IncomingWebResponseContext.cs
===================================================================
--- System.ServiceModel.Web/IncomingWebResponseContext.cs	(revision 142176)
+++ System.ServiceModel.Web/IncomingWebResponseContext.cs	(working copy)
@@ -46,17 +46,17 @@
 
 		public long ContentLength {
 			get {
-				string s = hp.Headers.Get ("Content-Length");
+				string s = hp.Headers ["Content-Length"];
 				return s != null ? long.Parse (s, CultureInfo.InvariantCulture) : 0;
 			}
 		}
 
 		public string ContentType {
-			get { return hp.Headers.Get ("Content-Type"); }
+			get { return hp.Headers ["Content-Type"]; }
 		}
 
 		public string ETag {
-			get { return hp.Headers.Get ("ETag"); }
+			get { return hp.Headers ["ETag"]; }
 		}
 
 		public WebHeaderCollection Headers {
@@ -64,7 +64,7 @@
 		}
 
 		public string Location {
-			get { return hp.Headers.Get ("Location"); }
+			get { return hp.Headers ["Location"]; }
 		}
 
 		public HttpStatusCode StatusCode {
Index: System.ServiceModel.Web/OutgoingWebRequestContext.cs
===================================================================
--- System.ServiceModel.Web/OutgoingWebRequestContext.cs	(revision 142176)
+++ System.ServiceModel.Web/OutgoingWebRequestContext.cs	(working copy)
@@ -62,7 +62,8 @@
 
 		internal void Apply (HttpRequestMessageProperty hp)
 		{
-			hp.Headers.Add (Headers);
+			foreach (var key in Headers.AllKeys)
+				hp.Headers [key] = Headers [key];
 			if (Accept != null)
 				hp.Headers ["Accept"] = Accept;
 			if (ContentLength > 0)
Index: System/UriTemplate.cs
===================================================================
--- System/UriTemplate.cs	(revision 142428)
+++ System/UriTemplate.cs	(working copy)
@@ -32,6 +32,10 @@
 using System.Globalization;
 using System.Text;
 
+#if NET_2_1
+using NameValueCollection = System.Object;
+#endif
+
 namespace System
 {
 	public class UriTemplate
@@ -102,6 +106,7 @@
 
 		// Bind
 
+#if !NET_2_1
 		public Uri BindByName (Uri baseAddress, NameValueCollection parameters)
 		{
 			return BindByName (baseAddress, parameters, false);
@@ -111,6 +116,7 @@
 		{
 			return BindByNameCommon (baseAddress, parameters, null, omitDefaults);
 		}
+#endif
 
 		public Uri BindByName (Uri baseAddress, IDictionary<string,string> parameters)
 		{
@@ -144,7 +150,11 @@
 				int s = template.IndexOf ('{', src);
 				int e = template.IndexOf ('}', s + 1);
 				sb.Append (template.Substring (src, s - src));
+#if NET_2_1
+				string value = null;
+#else
 				string value = nvc != null ? nvc [name] : null;
+#endif
 				if (dic != null)
 					dic.TryGetValue (name, out value);
 				if (value == null && (omitDefaults || !Defaults.TryGetValue (name, out value)))
Index: System/UriTemplateMatch.cs
===================================================================
--- System/UriTemplateMatch.cs	(revision 142176)
+++ System/UriTemplateMatch.cs	(working copy)
@@ -29,6 +29,10 @@
 using System.Collections.ObjectModel;
 using System.Collections.Specialized;
 
+#if NET_2_1
+using NameValueCollection = System.Collections.Generic.Dictionary<string,string>;
+#endif
+
 namespace System
 {
 	public class UriTemplateMatch
Index: System.ServiceModel.Description/WebHttpBehavior.cs
===================================================================
--- System.ServiceModel.Description/WebHttpBehavior.cs	(revision 142257)
+++ System.ServiceModel.Description/WebHttpBehavior.cs	(working copy)
@@ -38,6 +38,16 @@
 	{
 		public static WebAttributeInfo GetWebAttributeInfo (this OperationDescription od)
 		{
+#if NET_2_1
+			var mi = od.BeginMethod ?? od.SyncMethod;
+			var atts = mi.GetCustomAttributes (typeof (WebGetAttribute), true);
+			if (atts.Length == 1)
+				return ((WebGetAttribute) atts [0]).Info;
+			atts = mi.GetCustomAttributes (typeof (WebInvokeAttribute), true);
+			if (atts.Length == 1)
+				return ((WebInvokeAttribute) atts [0]).Info;
+			return null;
+#else
 			foreach (IOperationBehavior ob in od.Behaviors) {
 				WebAttributeInfo info = null;
 				var wg = ob as WebGetAttribute;
@@ -48,6 +58,7 @@
 					return wi.Info;
 			}
 			return null;
+#endif
 		}
 	}
 
@@ -77,11 +88,13 @@
 			// clientRuntime.MessageInspectors.Add (something);
 		}
 
+#if !NET_2_1
 		[MonoTODO]
 		protected virtual void AddServerErrorHandlers (ServiceEndpoint endpoint, EndpointDispatcher endpointDispatcher)
 		{
 			// endpointDispatcher.ChannelDispatcher.ErrorHandlers.Add (something);
 		}
+#endif
 
 		public virtual void ApplyClientBehavior (ServiceEndpoint endpoint, ClientRuntime clientRuntime)
 		{
@@ -94,6 +107,7 @@
 			}
 		}
 
+#if !NET_2_1
 		public virtual void ApplyDispatchBehavior (ServiceEndpoint endpoint, EndpointDispatcher endpointDispatcher)
 		{
 			endpointDispatcher.DispatchRuntime.OperationSelector = GetOperationSelector (endpoint);
@@ -108,6 +122,7 @@
 				oper.Formatter = new DispatchPairFormatter (req, res);
 			}
 		}
+#endif
 
 		internal class ClientPairFormatter : IClientMessageFormatter
 		{
@@ -130,6 +145,7 @@
 			}
 		}
 
+#if !NET_2_1
 		internal class DispatchPairFormatter : IDispatchMessageFormatter
 		{
 			public DispatchPairFormatter (IDispatchMessageFormatter request, IDispatchMessageFormatter reply)
@@ -156,6 +172,7 @@
 		{
 			return new WebHttpDispatchOperationSelector (endpoint);
 		}
+#endif
 
 		protected virtual QueryStringConverter GetQueryStringConverter (OperationDescription operationDescription)
 		{
@@ -167,20 +184,24 @@
 			return new WebMessageFormatter.ReplyClientFormatter (operationDescription, endpoint, GetQueryStringConverter (operationDescription), this);
 		}
 
+#if !NET_2_1
 		protected virtual IDispatchMessageFormatter GetReplyDispatchFormatter (OperationDescription operationDescription, ServiceEndpoint endpoint)
 		{
 			return new WebMessageFormatter.ReplyDispatchFormatter (operationDescription, endpoint, GetQueryStringConverter (operationDescription), this);
 		}
+#endif
 
 		protected virtual IClientMessageFormatter GetRequestClientFormatter (OperationDescription operationDescription, ServiceEndpoint endpoint)
 		{
 			return new WebMessageFormatter.RequestClientFormatter (operationDescription, endpoint, GetQueryStringConverter (operationDescription), this);
 		}
 
+#if !NET_2_1
 		protected virtual IDispatchMessageFormatter GetRequestDispatchFormatter (OperationDescription operationDescription, ServiceEndpoint endpoint)
 		{
 			return new WebMessageFormatter.RequestDispatchFormatter (operationDescription, endpoint, GetQueryStringConverter (operationDescription), this);
 		}
+#endif
 
 		[MonoTODO ("check UriTemplate validity")]
 		public virtual void Validate (ServiceEndpoint endpoint)
Index: System.ServiceModel.Dispatcher/WebMessageFormatter.cs
===================================================================
--- System.ServiceModel.Dispatcher/WebMessageFormatter.cs	(revision 142176)
+++ System.ServiceModel.Dispatcher/WebMessageFormatter.cs	(working copy)
@@ -26,7 +26,7 @@
 // WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 //
 using System;
-using System.Collections.Specialized;
+using System.Collections.Generic;
 using System.Reflection;
 using System.Runtime.Serialization;
 using System.Runtime.Serialization.Json;
@@ -197,6 +197,7 @@
 			}
 		}
 
+#if !NET_2_1
 		internal class RequestDispatchFormatter : WebDispatchMessageFormatter
 		{
 			public RequestDispatchFormatter (OperationDescription operation, ServiceEndpoint endpoint, QueryStringConverter converter, WebHttpBehavior behavior)
@@ -222,6 +223,7 @@
 				throw new NotSupportedException ();
 			}
 		}
+#endif
 
 		internal abstract class WebClientMessageFormatter : WebMessageFormatter, IClientMessageFormatter
 		{
@@ -236,7 +238,7 @@
 					throw new ArgumentNullException ("parameters");
 				CheckMessageVersion (messageVersion);
 
-				var c = new NameValueCollection ();
+				var c = new Dictionary<string,string> ();
 
 				MessageDescription md = GetMessageDescription (MessageDirection.Input);
 
@@ -335,6 +337,7 @@
 			}
 		}
 
+#if !NET_2_1
 		internal abstract class WebDispatchMessageFormatter : WebMessageFormatter, IDispatchMessageFormatter
 		{
 			protected WebDispatchMessageFormatter (OperationDescription operation, ServiceEndpoint endpoint, QueryStringConverter converter, WebHttpBehavior behavior)
@@ -432,5 +435,6 @@
 				}
 			}
 		}
+#endif
 	}
 }
Index: System.ServiceModel.Channels/WebMessageEncodingBindingElement.cs
===================================================================
--- System.ServiceModel.Channels/WebMessageEncodingBindingElement.cs	(revision 142176)
+++ System.ServiceModel.Channels/WebMessageEncodingBindingElement.cs	(working copy)
@@ -34,7 +34,11 @@
 namespace System.ServiceModel.Channels
 {
 	public sealed class WebMessageEncodingBindingElement
+#if NET_2_1
+		: MessageEncodingBindingElement
+#else
 		: MessageEncodingBindingElement, IWsdlExportExtension
+#endif
 	{
 		Encoding write_encoding;
 		XmlDictionaryReaderQuotas reader_quotas;
@@ -108,6 +112,7 @@
 			return base.BuildChannelFactory<TChannel> (context);
 		}
 
+#if !NET_2_1
 		[MonoTODO ("Why is it overriden?")]
 		public override bool CanBuildChannelListener<TChannel> (BindingContext context)
 		{
@@ -123,6 +128,7 @@
 			context.RemainingBindingElements.Add (this);
 			return base.BuildChannelListener<TChannel> (context);
 		}
+#endif
 
 		public override BindingElement Clone ()
 		{
@@ -141,6 +147,7 @@
 			return context.GetInnerProperty<T> ();
 		}
 
+#if !NET_2_1
 		[MonoTODO]
 		void IWsdlExportExtension.ExportContract (WsdlExporter exporter, WsdlContractConversionContext context)
 		{
@@ -152,5 +159,6 @@
 		{
 			throw new NotImplementedException ();
 		}
+#endif
 	}
 }
Index: System.ServiceModel/WebHttpSecurity.cs
===================================================================
--- System.ServiceModel/WebHttpSecurity.cs	(revision 142176)
+++ System.ServiceModel/WebHttpSecurity.cs	(working copy)
@@ -31,19 +31,21 @@
 	{
 		internal WebHttpSecurity ()
 		{
+			// there is no public constructor for transport ...
+#if !NET_2_1
+			Transport = new BasicHttpBinding ().Security.Transport;
+#endif
 		}
 
 		WebHttpSecurityMode mode;
-		// there is no publicly exposed constructor for transport ...
-		HttpTransportSecurity transport = new BasicHttpBinding ().Security.Transport;
 
 		public WebHttpSecurityMode Mode {
 			get { return mode; }
 			set { mode = value; }
 		}
 
-		public HttpTransportSecurity Transport {
-			get { return transport; }
-		}
+#if !NET_2_1
+		public HttpTransportSecurity Transport { get; private set; }
+#endif
 	}
 }
