Index: System.Web.Services.Description/ProtocolImporter.cs
===================================================================
--- System.Web.Services.Description/ProtocolImporter.cs	(revision 39533)
+++ System.Web.Services.Description/ProtocolImporter.cs	(working copy)
@@ -279,7 +279,7 @@
 			try
 			{
 				portType = ServiceDescriptions.GetPortType (binding.Type);
-				if (portType == null) throw new Exception ("Port type not found: " + binding.Type);
+				if (portType == null) throw new SystemException ("Port type not found: " + binding.Type);
 
 				CodeTypeDeclaration codeClass = BeginClass ();
 				codeTypeDeclaration = codeClass;
@@ -309,12 +309,12 @@
 				{
 					operationBinding = oper;
 					operation = FindPortOperation ();
-					if (operation == null) throw new Exception ("Operation " + operationBinding.Name + " not found in portType " + PortType.Name);
+					if (operation == null) throw new SystemException ("Operation " + operationBinding.Name + " not found in portType " + PortType.Name);
 
 					foreach (OperationMessage omsg in operation.Messages)
 					{
 						Message msg = ServiceDescriptions.GetMessage (omsg.Message);
-						if (msg == null) throw new Exception ("Message not found: " + omsg.Message);
+						if (msg == null) throw new SystemException ("Message not found: " + omsg.Message);
 						
 						if (omsg is OperationInput)
 							inputMessage = msg;
Index: System.Web.Services.Description/HttpSimpleProtocolImporter.cs
===================================================================
--- System.Web.Services.Description/HttpSimpleProtocolImporter.cs	(revision 39533)
+++ System.Web.Services.Description/HttpSimpleProtocolImporter.cs	(working copy)
@@ -124,7 +124,7 @@
 			try
 			{
 				HttpOperationBinding httpOper = OperationBinding.Extensions.Find (typeof (HttpOperationBinding)) as HttpOperationBinding;
-				if (httpOper == null) throw new Exception ("Http operation binding not found");
+				if (httpOper == null) throw new SystemException ("Http operation binding not found");
 				
 				XmlMembersMapping inputMembers = ImportInMembersMapping (InputMessage);
 				XmlTypeMapping outputMember = ImportOutMembersMapping (OutputMessage);
Index: System.Web.Services.Description/HttpGetProtocolImporter.cs
===================================================================
--- System.Web.Services.Description/HttpGetProtocolImporter.cs	(revision 39533)
+++ System.Web.Services.Description/HttpGetProtocolImporter.cs	(working copy)
@@ -70,7 +70,7 @@
 		protected override Type GetInMimeFormatter ()
 		{
 			HttpUrlEncodedBinding bin = OperationBinding.Input.Extensions.Find (typeof(HttpUrlEncodedBinding)) as HttpUrlEncodedBinding;
-			if (bin == null) throw new Exception ("Http urlEncoded binding not found");
+			if (bin == null) throw new SystemException ("Http urlEncoded binding not found");
 			return typeof (UrlParameterWriter);
 		}
 
Index: System.Web.Services.Description/ServiceDescriptionImporter.cs
===================================================================
--- System.Web.Services.Description/ServiceDescriptionImporter.cs	(revision 39533)
+++ System.Web.Services.Description/ServiceDescriptionImporter.cs	(working copy)
@@ -137,7 +137,7 @@
 			ProtocolImporter importer = GetImporter ();
 			
 			if (!importer.Import (this, codeNamespace, codeCompileUnit, importInfo))
-				throw new Exception ("None of the supported bindings was found");
+				throw new SystemException ("None of the supported bindings was found");
 				
 			return importer.Warnings;
 		}
@@ -151,7 +151,7 @@
 					return importer;
 			}
 			
-			throw new Exception ("Protocol " + protocolName + " not supported");
+			throw new SystemException ("Protocol " + protocolName + " not supported");
 		}
 		
 		ArrayList GetSupportedImporters ()
Index: System.Web.Services.Description/HttpPostProtocolImporter.cs
===================================================================
--- System.Web.Services.Description/HttpPostProtocolImporter.cs	(revision 39533)
+++ System.Web.Services.Description/HttpPostProtocolImporter.cs	(working copy)
@@ -70,8 +70,8 @@
 		protected override Type GetInMimeFormatter ()
 		{
 			MimeContentBinding bin = OperationBinding.Input.Extensions.Find (typeof(MimeContentBinding)) as MimeContentBinding;
-			if (bin == null) throw new Exception ("Http mime:content binding not found");
-			if (bin.Type != "application/x-www-form-urlencoded") throw new Exception ("Encoding of mime:content binding not supported");
+			if (bin == null) throw new SystemException ("Http mime:content binding not found");
+			if (bin.Type != "application/x-www-form-urlencoded") throw new SystemException ("Encoding of mime:content binding not supported");
 			return typeof (HtmlFormParameterWriter);
 		}
 
Index: System.Web.Services.Protocols/SoapDocumentationHandler.cs
===================================================================
--- System.Web.Services.Protocols/SoapDocumentationHandler.cs	(revision 39533)
+++ System.Web.Services.Protocols/SoapDocumentationHandler.cs	(working copy)
@@ -117,7 +117,7 @@
 				else if (key == "schema") GenerateSchema (context, req.QueryString ["schema"]);
 				else if (key == "code") GenerateCode (context, req.QueryString ["code"]);
 				else if (key == "disco") GenerateDiscoDocument (context);
-				else throw new Exception ("This should never happen");
+				else throw new SystemException ("This should never happen");
 			}
 		}
 
@@ -205,7 +205,7 @@
 				    break;
 			    
 			    default:
-				    throw new Exception("Unknown language: " + langId);
+				    throw new SystemException("Unknown language: " + langId);
 			}
 
 			return provider;
Index: System.Web.Services.Protocols/PatternMatcher.cs
===================================================================
--- System.Web.Services.Protocols/PatternMatcher.cs	(revision 39533)
+++ System.Web.Services.Protocols/PatternMatcher.cs	(working copy)
@@ -108,11 +108,11 @@
 		public object GetMatchValue (Match match, Type castType)
 		{
 			if (Match.Group >= match.Groups.Count)
-				throw new Exception (string.Format (GroupError, Match.Group, Field.Name, match.Groups.Count-1));
+				throw new SystemException (string.Format (GroupError, Match.Group, Field.Name, match.Groups.Count-1));
 				
 			Group group = match.Groups [Match.Group];
 			if (Match.Capture >= group.Captures.Count)
-				throw new Exception (string.Format (CaptureError, Match.Capture, Field.Name, group.Captures.Count-1));
+				throw new SystemException (string.Format (CaptureError, Match.Capture, Field.Name, group.Captures.Count-1));
 				
 			string val = group.Captures [Match.Capture].Value;
 			return Convert.ChangeType (val, castType);
Index: System.Web.Services.Protocols/Methods.cs
===================================================================
--- System.Web.Services.Protocols/Methods.cs	(revision 39533)
+++ System.Web.Services.Protocols/Methods.cs	(working copy)
@@ -146,9 +146,9 @@
 
 			if (OneWay){
 				if (source.ReturnType != typeof (void))
-					throw new Exception ("OneWay methods should not have a return value.");
+					throw new SystemException ("OneWay methods should not have a return value.");
 				if (source.OutParameters.Length != 0)
-					throw new Exception ("OneWay methods should not have out/ref parameters.");
+					throw new SystemException ("OneWay methods should not have out/ref parameters.");
 			}
 			
 			BindingInfo binfo = parent.GetBinding (Binding);
Index: System.Web.Services.Protocols/SoapHttpClientProtocol.cs
===================================================================
--- System.Web.Services.Protocols/SoapHttpClientProtocol.cs	(revision 39533)
+++ System.Web.Services.Protocols/SoapHttpClientProtocol.cs	(working copy)
@@ -183,7 +183,7 @@
 			}
 			
 			string msg = string.Format ("The binding named '{0}' from namespace '{1}' was not found in the discovery document at '{2}'", bnd.Name, bnd.Namespace, Url);
-			throw new Exception (msg);
+			throw new SystemException (msg);
 		}
 
 		protected override WebRequest GetWebRequest (Uri uri)
Index: System.Web.Services.Discovery/SchemaReference.cs
===================================================================
--- System.Web.Services.Discovery/SchemaReference.cs	(revision 39533)
+++ System.Web.Services.Discovery/SchemaReference.cs	(working copy)
@@ -98,7 +98,7 @@
 				
 				XmlSchema doc = ClientProtocol.Documents [Url] as XmlSchema;
 				if (doc == null)
-					throw new Exception ("The Documents property of ClientProtocol does not contain a schema with the url " + Url);
+					throw new SystemException ("The Documents property of ClientProtocol does not contain a schema with the url " + Url);
 					
 				return doc; 
 			}
Index: System.Web.Services.Discovery/DiscoveryDocumentReference.cs
===================================================================
--- System.Web.Services.Discovery/DiscoveryDocumentReference.cs	(revision 39533)
+++ System.Web.Services.Discovery/DiscoveryDocumentReference.cs	(working copy)
@@ -72,7 +72,7 @@
 				
 				DiscoveryDocument doc = ClientProtocol.Documents [Url] as DiscoveryDocument;
 				if (doc == null)
-					throw new Exception ("The Documents property of ClientProtocol does not contain a discovery document with the url " + Url);
+					throw new SystemException ("The Documents property of ClientProtocol does not contain a discovery document with the url " + Url);
 					
 				return doc; 
 			}
Index: System.Web.Services.Discovery/ContractReference.cs
===================================================================
--- System.Web.Services.Discovery/ContractReference.cs	(revision 39533)
+++ System.Web.Services.Discovery/ContractReference.cs	(working copy)
@@ -80,7 +80,7 @@
 				
 				ServiceDescription desc = ClientProtocol.Documents [Url] as ServiceDescription;
 				if (desc == null)
-					throw new Exception ("The Documents property of ClientProtocol does not contain a WSDL document with the url " + Url);
+					throw new SystemException ("The Documents property of ClientProtocol does not contain a WSDL document with the url " + Url);
 					
 				return desc; 
 			}