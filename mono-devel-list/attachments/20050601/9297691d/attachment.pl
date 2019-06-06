Index: System.Web.Services.Description/ServiceDescription.cs
===================================================================
--- System.Web.Services.Description/ServiceDescription.cs	(revision 45288)
+++ System.Web.Services.Description/ServiceDescription.cs	(working copy)
@@ -66,7 +66,18 @@
 		ServiceCollection services;
 		string targetNamespace;
 		Types types;
+#if !TARGET_JVM
 		static ServiceDescriptionSerializer serializer;
+#else
+		static ServiceDescriptionSerializer serializer {
+			get {
+				return (ServiceDescriptionSerializer)AppDomain.CurrentDomain.GetData("ServiceDescriptionSerializer.serializer");
+			}
+			set {
+				AppDomain.CurrentDomain.SetData("ServiceDescriptionSerializer.serializer", value);
+			}
+		}
+#endif
 
 		#endregion // Fields
 
Index: System.Web.Services.Description/SoapTransportImporter.cs
===================================================================
--- System.Web.Services.Description/SoapTransportImporter.cs	(revision 45288)
+++ System.Web.Services.Description/SoapTransportImporter.cs	(working copy)
@@ -35,8 +35,18 @@
 	public abstract class SoapTransportImporter {
 
 		#region Fields
-
+#if !TARGET_JVM
 		static ArrayList transportImporters;
+#else
+		static ArrayList transportImporters {
+			get {
+				return (ArrayList)AppDomain.CurrentDomain.GetData("SoapTransportImporter.transportImporters");
+			}
+			set {
+				AppDomain.CurrentDomain.SetData("SoapTransportImporter.transportImporters", value);
+			}
+		}
+#endif
 		SoapProtocolImporter importContext;
 
 		#endregion // Fields
Index: System.Web.Services.Protocols/WebClientProtocol.cs
===================================================================
--- System.Web.Services.Protocols/WebClientProtocol.cs	(revision 45288)
+++ System.Web.Services.Protocols/WebClientProtocol.cs	(working copy)
@@ -58,7 +58,18 @@
 		//
 		WebRequest current_request;
 		
+#if !TARGET_JVM
 		static HybridDictionary cache;
+#else
+		static HybridDictionary cache {
+			get {
+				return (HybridDictionary)AppDomain.CurrentDomain.GetData("WebClientProtocol.cache");
+			}
+			set {
+				AppDomain.CurrentDomain.SetData("WebClientProtocol.cache", value);
+			}
+		}
+#endif
 		#endregion
 
 		#region Constructors
Index: System.Web.Services.Protocols/TypeStubManager.cs
===================================================================
--- System.Web.Services.Protocols/TypeStubManager.cs	(revision 45288)
+++ System.Web.Services.Protocols/TypeStubManager.cs	(working copy)
@@ -369,7 +369,18 @@
 	//
 	internal class TypeStubManager 
 	{
+#if !TARGET_JVM
 		static Hashtable type_to_manager;
+#else
+		static Hashtable type_to_manager {
+			get {
+				return (Hashtable)AppDomain.CurrentDomain.GetData("TypeStubManager.type_to_manager");
+			}
+			set {
+				AppDomain.CurrentDomain.SetData("TypeStubManager.type_to_manager", value);
+			}
+		}
+#endif
 		
 		static TypeStubManager ()
 		{
Index: System.Web.Services.Protocols/SoapExtension.cs
===================================================================
--- System.Web.Services.Protocols/SoapExtension.cs	(revision 45288)
+++ System.Web.Services.Protocols/SoapExtension.cs	(working copy)
@@ -62,7 +62,18 @@
 		public abstract void ProcessMessage (SoapMessage message);
 
 
+#if !TARGET_JVM
 		static ArrayList[] globalExtensions;
+#else
+		static ArrayList[] globalExtensions {
+			get {
+				return (ArrayList[])AppDomain.CurrentDomain.GetData("SoapExtension.globalExtensions");
+			}
+			set {
+				AppDomain.CurrentDomain.SetData("SoapExtension.globalExtensions", value);
+			}
+		}
+#endif
 
 		internal static SoapExtension[] CreateExtensionChain (SoapExtensionRuntimeConfig[] extensionConfigs)
 		{
Index: System.Web.Services.Configuration/WebServicesConfigurationSectionHandler.cs
===================================================================
--- System.Web.Services.Configuration/WebServicesConfigurationSectionHandler.cs	(revision 45288)
+++ System.Web.Services.Configuration/WebServicesConfigurationSectionHandler.cs	(working copy)
@@ -47,7 +47,19 @@
 	
 	class WSConfig
 	{
+#if !TARGET_JVM
 		volatile static WSConfig instance;
+#else
+		static WSConfig instance {
+			get {
+				return (WSConfig)AppDomain.CurrentDomain.GetData("WSConfig.instance");
+			}
+			set {
+				AppDomain.CurrentDomain.SetData("WSConfig.instance", value);
+			}
+		}
+
+#endif
 		WSProtocol protocols;
 		string wsdlHelpPage;
 		string filePath;
