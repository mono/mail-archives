Index: System.ServiceModel.Web/Assembly/AssemblyInfo.cs
===================================================================
--- System.ServiceModel.Web/Assembly/AssemblyInfo.cs	(revision 159019)
+++ System.ServiceModel.Web/Assembly/AssemblyInfo.cs	(working copy)
@@ -62,6 +62,7 @@
 
 #if NET_2_1
 [assembly: InternalsVisibleTo ("System.Json, PublicKey=00240000048000009400000006020000002400005253413100040000010001008D56C76F9E8649383049F383C44BE0EC204181822A6C31CF5EB7EF486944D032188EA1D3920763712CCB12D75FB77E9811149E6148E5D32FBAAB37611C1878DDC19E20EF135D0CB2CFF2BFEC3D115810C3D9069638FE4BE215DBF795861920E5AB6F7DB2E2CEEF136AC23D5DD2BF031700AEC232F6C6B1C785B4305C123B37AB")]
+[assembly: InternalsVisibleTo ("System.ServiceModel.Web.Extensions, PublicKey=0024000004800000940000000602000000240000525341310004000001000100b5fc90e7027f67871e773a8fde8938c81dd402ba65b9201d60593e96c492651e889cc13f1415ebb53fac1131ae0bd333c5ee6021672d9718ea31a8aebd0da0072f25d87dba6fc90ffd598ed4da35e44c398c454307e8e33b8426143daec9f596836f97c8f74750e5975c64e2189f45def46b2a2b1247adc3652bf5c308055da9")]
 #else
 [assembly: InternalsVisibleTo ("dummy-System.Json, PublicKey=00240000048000009400000006020000002400005253413100040000010001008D56C76F9E8649383049F383C44BE0EC204181822A6C31CF5EB7EF486944D032188EA1D3920763712CCB12D75FB77E9811149E6148E5D32FBAAB37611C1878DDC19E20EF135D0CB2CFF2BFEC3D115810C3D9069638FE4BE215DBF795861920E5AB6F7DB2E2CEEF136AC23D5DD2BF031700AEC232F6C6B1C785B4305C123B37AB")]
 #endif
Index: System.ServiceModel.Web/System.ServiceModel.Dispatcher/WebMessageFormatter.cs
===================================================================
--- System.ServiceModel.Web/System.ServiceModel.Dispatcher/WebMessageFormatter.cs	(revision 159019)
+++ System.ServiceModel.Web/System.ServiceModel.Dispatcher/WebMessageFormatter.cs	(working copy)
@@ -38,6 +38,10 @@
 using System.Text;
 using System.Xml;
 
+#if NET_2_1
+using XmlObjectSerializer = System.Object;
+#endif
+
 namespace System.ServiceModel.Description
 {
 	internal abstract class WebMessageFormatter
@@ -56,10 +60,12 @@
 			this.converter = converter;
 			this.behavior = behavior;
 			ApplyWebAttribute ();
+#if !NET_2_1
 			// This is a hack for WebScriptEnablingBehavior
 			var jqc = converter as JsonQueryStringConverter;
 			if (jqc != null)
 				BodyName = jqc.CustomWrapperName;
+#endif
 		}
 
 		void ApplyWebAttribute ()
@@ -313,7 +319,13 @@
 						reader.ReadStartElement (md.Body.WrapperName, md.Body.WrapperNamespace);
 				}
 
+#if NET_2_1
+				var ret = (serializer is DataContractJsonSerializer) ?
+					((DataContractJsonSerializer) serializer).ReadObject (reader) :
+					((DataContractSerializer) serializer).ReadObject (reader, true);
+#else
 				var ret = serializer.ReadObject (reader, true);
+#endif
 
 				if (IsResponseBodyWrapped)
 					reader.ReadEndElement ();
@@ -360,7 +372,7 @@
 					writer.WriteStartElement ("root");
 					writer.WriteAttributeString ("type", "object");
 				}
-				serializer.WriteObject (writer, value);
+				WriteObject (serializer, writer, value);
 				if (name != null)
 					writer.WriteEndElement ();
 			}
@@ -369,10 +381,22 @@
 			{
 				if (name != null)
 					writer.WriteStartElement (name, ns);
-				serializer.WriteObject (writer, value);
+				WriteObject (serializer, writer, value);
 				if (name != null)
 					writer.WriteEndElement ();
 			}
+
+			void WriteObject (XmlObjectSerializer serializer, XmlDictionaryWriter writer, object value)
+			{
+#if NET_2_1
+					if (serializer is DataContractJsonSerializer)
+						((DataContractJsonSerializer) serializer).WriteObject (writer, value);
+					else
+						((DataContractSerializer) serializer).WriteObject (writer, value);
+#else
+					serializer.WriteObject (writer, value);
+#endif
+			}
 		}
 
 #if !NET_2_1
Index: System.ServiceModel.Web/System.Runtime.Serialization.Json/DataContractJsonSerializer_2_1.cs
===================================================================
--- System.ServiceModel.Web/System.Runtime.Serialization.Json/DataContractJsonSerializer_2_1.cs	(revision 159019)
+++ System.ServiceModel.Web/System.Runtime.Serialization.Json/DataContractJsonSerializer_2_1.cs	(working copy)
@@ -72,7 +72,18 @@
 		{
 			var r = (JsonReader) JsonReaderWriterFactory.CreateJsonReader (stream, XmlDictionaryReaderQuotas.Max);
 			r.LameSilverlightLiteralParser = true;
+			return ReadObject (r);
+		}
 
+		// FIXME: should be internal
+		public object ReadObject (XmlReader r)
+		{
+			return ReadObject (XmlDictionaryReader.CreateDictionaryReader (r));
+		}
+		
+		// FIXME: should be internal
+		public object ReadObject (XmlDictionaryReader r)
+		{
 			try {
 				r.MoveToContent ();
 				if (!r.IsStartElement ("root", String.Empty)) {
@@ -95,6 +106,19 @@
 		public void WriteObject (Stream stream, object graph)
 		{
 			using (var writer = JsonReaderWriterFactory.CreateJsonWriter (stream)) {
+				WriteObject (writer, graph);
+			}
+		}
+		
+		// FIXME: should be internal
+		public void WriteObject (XmlWriter writer, object graph)
+		{
+			WriteObject (XmlDictionaryWriter.CreateDictionaryWriter (writer), graph);
+		}
+		
+		// FIXME: should be internal
+		public void WriteObject (XmlDictionaryWriter writer, object graph)
+		{
 				try {
 					writer.WriteStartElement ("root");
 					new JsonSerializationWriter (this, writer, type, false).WriteObjectContent (graph, true, false);
@@ -110,7 +134,6 @@
 				} catch (Exception ex) {
 					throw new SerializationException (String.Format ("There was an error during serialization for object of type {0}", graph != null ? graph.GetType () : null), ex);
 				}
-			}
 		}
 	}
 }
Index: System.Runtime.Serialization.Json/Assembly/AssemblyInfo.cs
===================================================================
--- System.Runtime.Serialization.Json/Assembly/AssemblyInfo.cs	(revision 0)
+++ System.Runtime.Serialization.Json/Assembly/AssemblyInfo.cs	(revision 0)
@@ -0,0 +1,69 @@
+//
+// AssemblyInfo.cs
+//
+// Author:
+//   Andreas Nahr (ClassDevelopment@A-SoftTech.com)
+//
+// (C) 2003 Ximian, Inc.  http://www.ximian.com
+//
+
+//
+// Permission is hereby granted, free of charge, to any person obtaining
+// a copy of this software and associated documentation files (the
+// "Software"), to deal in the Software without restriction, including
+// without limitation the rights to use, copy, modify, merge, publish,
+// distribute, sublicense, and/or sell copies of the Software, and to
+// permit persons to whom the Software is furnished to do so, subject to
+// the following conditions:
+// 
+// The above copyright notice and this permission notice shall be
+// included in all copies or substantial portions of the Software.
+// 
+// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
+// LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
+// OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
+// WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+//
+
+using System;
+using System.Reflection;
+using System.Resources;
+using System.Security;
+using System.Diagnostics;
+using System.Runtime.CompilerServices;
+using System.Runtime.InteropServices;
+
+// General Information about the System.Runtime.Serialization.Json assembly
+// v2.1 Assembly
+
+[assembly: AssemblyTitle ("System.Runtime.Serialization.Json.dll")]
+[assembly: AssemblyDescription ("System.Runtime.Serialization.Json.dll")]
+[assembly: AssemblyDefaultAlias ("System.Runtime.Serialization.Json.dll")]
+
+[assembly: AssemblyCompany (Consts.MonoCompany)]
+[assembly: AssemblyProduct (Consts.MonoProduct)]
+[assembly: AssemblyCopyright (Consts.MonoCopyright)]
+[assembly: AssemblyVersion (Consts.FxVersion)]
+[assembly: SatelliteContractVersion (Consts.FxVersion)]
+[assembly: AssemblyInformationalVersion (Consts.FxFileVersion)]
+[assembly: AssemblyFileVersion (Consts.FxFileVersion)]
+
+[assembly: NeutralResourcesLanguage ("en-US")]
+[assembly: CLSCompliant (true)]
+[assembly: AssemblyDelaySign (true)]
+#if NET_2_1
+[assembly: AssemblyKeyFile ("../silverlight.pub")]
+#else
+[assembly: AssemblyKeyFile ("../ecma.pub")]
+#endif
+
+[assembly: ComVisible (false)]
+[assembly: AllowPartiallyTrustedCallers]
+
+[assembly: CompilationRelaxations (CompilationRelaxations.NoStringInterning)]
+[assembly: Debuggable (DebuggableAttribute.DebuggingModes.IgnoreSymbolStoreSequencePoints)]
+[assembly: RuntimeCompatibility (WrapNonExceptionThrows = true)]
+// Extension attribute should be added by compiler
Index: System.Runtime.Serialization.Json/System.Runtime.Serialization.Json.dll.sources
===================================================================
--- System.Runtime.Serialization.Json/System.Runtime.Serialization.Json.dll.sources	(revision 0)
+++ System.Runtime.Serialization.Json/System.Runtime.Serialization.Json.dll.sources	(revision 0)
@@ -0,0 +1,9 @@
+../../build/common/Consts.cs
+../../build/common/Locale.cs
+../../build/common/MonoTODOAttribute.cs
+Assembly/AssemblyInfo.cs
+../System.ServiceModel.Web/System.Runtime.Serialization.Json/IXmlJsonReaderInitializer.cs
+../System.ServiceModel.Web/System.Runtime.Serialization.Json/IXmlJsonWriterInitializer.cs
+../System.ServiceModel.Web/System.Runtime.Serialization.Json/JsonReader.cs
+../System.ServiceModel.Web/System.Runtime.Serialization.Json/JsonReaderWriterFactory.cs
+../System.ServiceModel.Web/System.Runtime.Serialization.Json/JsonWriter.cs
Index: System.Runtime.Serialization.Json/Makefile
===================================================================
--- System.Runtime.Serialization.Json/Makefile	(revision 0)
+++ System.Runtime.Serialization.Json/Makefile	(revision 0)
@@ -0,0 +1,19 @@
+thisdir = class/System.Runtime.Serialization.Json
+SUBDIRS = 
+include ../../build/rules.make
+
+LIBRARY = System.Runtime.Serialization.Json.dll
+LIB_MCS_FLAGS = -r:System.dll -r:System.Xml.dll -r:System.Runtime.Serialization.dll -r:System.Core.dll
+
+TEST_MCS_FLAGS = $(LIB_MCS_FLAGS)
+
+EXTRA_DISTFILES = $(RESOURCE_FILES)
+
+VALID_PROFILE := $(filter 2.1, $(FRAMEWORK_VERSION))
+ifndef VALID_PROFILE
+LIBRARY_NAME = dummy-System.Runtime.Serialization.Json.dll
+NO_INSTALL = yes
+NO_SIGN_ASSEMBLY = yes
+endif
+
+include ../../build/library.make
Index: System.ServiceModel.Syndication/Assembly/AssemblyInfo.cs
===================================================================
--- System.ServiceModel.Syndication/Assembly/AssemblyInfo.cs	(revision 0)
+++ System.ServiceModel.Syndication/Assembly/AssemblyInfo.cs	(revision 0)
@@ -0,0 +1,69 @@
+//
+// AssemblyInfo.cs
+//
+// Author:
+//   Andreas Nahr (ClassDevelopment@A-SoftTech.com)
+//
+// (C) 2003 Ximian, Inc.  http://www.ximian.com
+//
+
+//
+// Permission is hereby granted, free of charge, to any person obtaining
+// a copy of this software and associated documentation files (the
+// "Software"), to deal in the Software without restriction, including
+// without limitation the rights to use, copy, modify, merge, publish,
+// distribute, sublicense, and/or sell copies of the Software, and to
+// permit persons to whom the Software is furnished to do so, subject to
+// the following conditions:
+// 
+// The above copyright notice and this permission notice shall be
+// included in all copies or substantial portions of the Software.
+// 
+// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
+// LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
+// OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
+// WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+//
+
+using System;
+using System.Reflection;
+using System.Resources;
+using System.Security;
+using System.Diagnostics;
+using System.Runtime.CompilerServices;
+using System.Runtime.InteropServices;
+
+// General Information about the System.ServiceModel.Syndication assembly
+// v2.1 Assembly
+
+[assembly: AssemblyTitle ("System.ServiceModel.Syndication.dll")]
+[assembly: AssemblyDescription ("System.ServiceModel.Syndication.dll")]
+[assembly: AssemblyDefaultAlias ("System.ServiceModel.Syndication.dll")]
+
+[assembly: AssemblyCompany (Consts.MonoCompany)]
+[assembly: AssemblyProduct (Consts.MonoProduct)]
+[assembly: AssemblyCopyright (Consts.MonoCopyright)]
+[assembly: AssemblyVersion (Consts.FxVersion)]
+[assembly: SatelliteContractVersion (Consts.FxVersion)]
+[assembly: AssemblyInformationalVersion (Consts.FxFileVersion)]
+[assembly: AssemblyFileVersion (Consts.FxFileVersion)]
+
+[assembly: NeutralResourcesLanguage ("en-US")]
+[assembly: CLSCompliant (true)]
+[assembly: AssemblyDelaySign (true)]
+#if NET_2_1
+[assembly: AssemblyKeyFile ("../silverlight.pub")]
+#else
+[assembly: AssemblyKeyFile ("../ecma.pub")]
+#endif
+
+[assembly: ComVisible (false)]
+[assembly: AllowPartiallyTrustedCallers]
+
+[assembly: CompilationRelaxations (CompilationRelaxations.NoStringInterning)]
+[assembly: Debuggable (DebuggableAttribute.DebuggingModes.IgnoreSymbolStoreSequencePoints)]
+[assembly: RuntimeCompatibility (WrapNonExceptionThrows = true)]
+// Extension attribute should be added by compiler
Index: System.ServiceModel.Syndication/System.ServiceModel.Syndication.dll.sources
===================================================================
--- System.ServiceModel.Syndication/System.ServiceModel.Syndication.dll.sources	(revision 0)
+++ System.ServiceModel.Syndication/System.ServiceModel.Syndication.dll.sources	(revision 0)
@@ -0,0 +1,40 @@
+../../build/common/Consts.cs
+../../build/common/Locale.cs
+../../build/common/MonoTODOAttribute.cs
+Assembly/AssemblyInfo.cs
+../System.ServiceModel.Web/System.ServiceModel.Syndication/Atom10FeedFormatter.cs
+../System.ServiceModel.Web/System.ServiceModel.Syndication/Atom10FeedFormatter_1.cs
+../System.ServiceModel.Web/System.ServiceModel.Syndication/Atom10ItemFormatter.cs
+../System.ServiceModel.Web/System.ServiceModel.Syndication/Atom10ItemFormatter_1.cs
+../System.ServiceModel.Web/System.ServiceModel.Syndication/AtomPub10CategoriesDocumentFormatter.cs
+../System.ServiceModel.Web/System.ServiceModel.Syndication/AtomPub10ServiceDocumentFormatter.cs
+../System.ServiceModel.Web/System.ServiceModel.Syndication/AtomPub10ServiceDocumentFormatter_1.cs
+../System.ServiceModel.Web/System.ServiceModel.Syndication/CategoriesDocument.cs
+../System.ServiceModel.Web/System.ServiceModel.Syndication/CategoriesDocumentFormatter.cs
+../System.ServiceModel.Web/System.ServiceModel.Syndication/ISyndicationElement.cs
+../System.ServiceModel.Web/System.ServiceModel.Syndication/InlineCategoriesDocument.cs
+../System.ServiceModel.Web/System.ServiceModel.Syndication/ReferencedCategoriesDocument.cs
+../System.ServiceModel.Web/System.ServiceModel.Syndication/ResourceCollectionInfo.cs
+../System.ServiceModel.Web/System.ServiceModel.Syndication/Rss20FeedFormatter.cs
+../System.ServiceModel.Web/System.ServiceModel.Syndication/Rss20FeedFormatter_1.cs
+../System.ServiceModel.Web/System.ServiceModel.Syndication/Rss20ItemFormatter.cs
+../System.ServiceModel.Web/System.ServiceModel.Syndication/Rss20ItemFormatter_1.cs
+../System.ServiceModel.Web/System.ServiceModel.Syndication/ServiceDocument.cs
+../System.ServiceModel.Web/System.ServiceModel.Syndication/ServiceDocumentFormatter.cs
+../System.ServiceModel.Web/System.ServiceModel.Syndication/SyndicationCategory.cs
+../System.ServiceModel.Web/System.ServiceModel.Syndication/SyndicationContent.cs
+../System.ServiceModel.Web/System.ServiceModel.Syndication/SyndicationElementExtension.cs
+../System.ServiceModel.Web/System.ServiceModel.Syndication/SyndicationElementExtensionCollection.cs
+../System.ServiceModel.Web/System.ServiceModel.Syndication/SyndicationExtensions.cs
+../System.ServiceModel.Web/System.ServiceModel.Syndication/SyndicationFeed.cs
+../System.ServiceModel.Web/System.ServiceModel.Syndication/SyndicationFeedFormatter.cs
+../System.ServiceModel.Web/System.ServiceModel.Syndication/SyndicationItem.cs
+../System.ServiceModel.Web/System.ServiceModel.Syndication/SyndicationItemFormatter.cs
+../System.ServiceModel.Web/System.ServiceModel.Syndication/SyndicationLink.cs
+../System.ServiceModel.Web/System.ServiceModel.Syndication/SyndicationPerson.cs
+../System.ServiceModel.Web/System.ServiceModel.Syndication/SyndicationVersions.cs
+../System.ServiceModel.Web/System.ServiceModel.Syndication/TextSyndicationContent.cs
+../System.ServiceModel.Web/System.ServiceModel.Syndication/TextSyndicationContentKind.cs
+../System.ServiceModel.Web/System.ServiceModel.Syndication/UrlSyndicationContent.cs
+../System.ServiceModel.Web/System.ServiceModel.Syndication/Workspace.cs
+../System.ServiceModel.Web/System.ServiceModel.Syndication/XmlSyndicationContent.cs
Index: System.ServiceModel.Syndication/Makefile
===================================================================
--- System.ServiceModel.Syndication/Makefile	(revision 0)
+++ System.ServiceModel.Syndication/Makefile	(revision 0)
@@ -0,0 +1,27 @@
+thisdir = class/System.ServiceModel.Syndication
+SUBDIRS = 
+include ../../build/rules.make
+
+LIBRARY = System.ServiceModel.Syndication.dll
+LIB_MCS_FLAGS = -r:System.dll -r:System.Xml.dll -r:System.Runtime.Serialization.dll -r:System.ServiceModel.dll -r:System.Core.dll
+
+ifeq (moonlight_raw, $(PROFILE))
+LIB_MCS_FLAGS += /r:System.Xml.Serialization.dll
+endif
+
+ifneq (2.1, $(FRAMEWORK_VERSION))
+LIB_MCS_FLAGS += /r:System.Configuration.dll
+endif
+
+TEST_MCS_FLAGS = $(LIB_MCS_FLAGS)
+
+EXTRA_DISTFILES = $(RESOURCE_FILES)
+
+VALID_PROFILE := $(filter 2.1, $(FRAMEWORK_VERSION))
+ifndef VALID_PROFILE
+LIBRARY_NAME = dummy-System.ServiceModel.Syndication.dll
+NO_INSTALL = yes
+NO_SIGN_ASSEMBLY = yes
+endif
+
+include ../../build/library.make
Index: System.ServiceModel.Web.Extensions/Assembly/AssemblyInfo.cs
===================================================================
--- System.ServiceModel.Web.Extensions/Assembly/AssemblyInfo.cs	(revision 0)
+++ System.ServiceModel.Web.Extensions/Assembly/AssemblyInfo.cs	(revision 0)
@@ -0,0 +1,69 @@
+//
+// AssemblyInfo.cs
+//
+// Author:
+//   Andreas Nahr (ClassDevelopment@A-SoftTech.com)
+//
+// (C) 2003 Ximian, Inc.  http://www.ximian.com
+//
+
+//
+// Permission is hereby granted, free of charge, to any person obtaining
+// a copy of this software and associated documentation files (the
+// "Software"), to deal in the Software without restriction, including
+// without limitation the rights to use, copy, modify, merge, publish,
+// distribute, sublicense, and/or sell copies of the Software, and to
+// permit persons to whom the Software is furnished to do so, subject to
+// the following conditions:
+// 
+// The above copyright notice and this permission notice shall be
+// included in all copies or substantial portions of the Software.
+// 
+// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
+// LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
+// OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
+// WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+//
+
+using System;
+using System.Reflection;
+using System.Resources;
+using System.Security;
+using System.Diagnostics;
+using System.Runtime.CompilerServices;
+using System.Runtime.InteropServices;
+
+// General Information about the System.ServiceModel.Web.Extensions assembly
+// v2.1 Assembly
+
+[assembly: AssemblyTitle ("System.ServiceModel.Web.Extensions.dll")]
+[assembly: AssemblyDescription ("System.ServiceModel.Web.Extensions.dll")]
+[assembly: AssemblyDefaultAlias ("System.ServiceModel.Web.Extensions.dll")]
+
+[assembly: AssemblyCompany (Consts.MonoCompany)]
+[assembly: AssemblyProduct (Consts.MonoProduct)]
+[assembly: AssemblyCopyright (Consts.MonoCopyright)]
+[assembly: AssemblyVersion (Consts.FxVersion)]
+[assembly: SatelliteContractVersion (Consts.FxVersion)]
+[assembly: AssemblyInformationalVersion (Consts.FxFileVersion)]
+[assembly: AssemblyFileVersion (Consts.FxFileVersion)]
+
+[assembly: NeutralResourcesLanguage ("en-US")]
+[assembly: CLSCompliant (true)]
+[assembly: AssemblyDelaySign (true)]
+#if NET_2_1
+[assembly: AssemblyKeyFile ("../silverlight.pub")]
+#else
+[assembly: AssemblyKeyFile ("../silverlight.pub")] // easing InternalVisibleTo use.
+#endif
+
+[assembly: ComVisible (false)]
+[assembly: AllowPartiallyTrustedCallers]
+
+[assembly: CompilationRelaxations (CompilationRelaxations.NoStringInterning)]
+[assembly: Debuggable (DebuggableAttribute.DebuggingModes.IgnoreSymbolStoreSequencePoints)]
+[assembly: RuntimeCompatibility (WrapNonExceptionThrows = true)]
+// Extension attribute should be added by compiler
Index: System.ServiceModel.Web.Extensions/System.ServiceModel.Web.Extensions.dll.sources
===================================================================
--- System.ServiceModel.Web.Extensions/System.ServiceModel.Web.Extensions.dll.sources	(revision 0)
+++ System.ServiceModel.Web.Extensions/System.ServiceModel.Web.Extensions.dll.sources	(revision 0)
@@ -0,0 +1,23 @@
+../../build/common/Consts.cs
+../../build/common/Locale.cs
+../../build/common/MonoTODOAttribute.cs
+Assembly/AssemblyInfo.cs
+../System.ServiceModel.Web/System/UriTemplate.cs
+../System.ServiceModel.Web/System/UriTemplateEquivalenceComparer.cs
+../System.ServiceModel.Web/System/UriTemplateMatch.cs
+../System.ServiceModel.Web/System/UriTemplateMatchException.cs
+../System.ServiceModel.Web/System/UriTemplateTable.cs
+../System.ServiceModel.Web/System.ServiceModel.Channels/WebBodyFormatMessageProperty.cs
+../System.ServiceModel.Web/System.ServiceModel.Channels/WebContentFormat.cs
+../System.ServiceModel.Web/System.ServiceModel.Description/WebHttpBehavior.cs
+../System.ServiceModel.Web/System.ServiceModel.Dispatcher/QueryStringConverter.cs
+../System.ServiceModel.Web/System.ServiceModel.Dispatcher/WebMessageFormatter.cs
+../System.ServiceModel.Web/System.ServiceModel.Web/IncomingWebResponseContext.cs
+../System.ServiceModel.Web/System.ServiceModel.Web/OutgoingWebRequestContext.cs
+../System.ServiceModel.Web/System.ServiceModel.Web/WebAttributeInfo.cs
+../System.ServiceModel.Web/System.ServiceModel.Web/WebGetAttribute.cs
+../System.ServiceModel.Web/System.ServiceModel.Web/WebInvokeAttribute.cs
+../System.ServiceModel.Web/System.ServiceModel.Web/WebMessageBodyStyle.cs
+../System.ServiceModel.Web/System.ServiceModel.Web/WebMessageFormat.cs
+../System.ServiceModel.Web/System.ServiceModel.Web/WebOperationContext.cs
+
Index: System.ServiceModel.Web.Extensions/Makefile
===================================================================
--- System.ServiceModel.Web.Extensions/Makefile	(revision 0)
+++ System.ServiceModel.Web.Extensions/Makefile	(revision 0)
@@ -0,0 +1,27 @@
+thisdir = class/System.ServiceModel.Web.Extensions
+SUBDIRS = 
+include ../../build/rules.make
+
+LIBRARY = System.ServiceModel.Web.Extensions.dll
+LIB_MCS_FLAGS = -r:System.dll -r:System.Xml.dll -r:System.Runtime.Serialization.dll -r:System.ServiceModel.dll -r:System.Core.dll -r:System.ServiceModel.Web.dll
+
+ifeq (2.1, $(FRAMEWORK_VERSION))
+LIB_MCS_FLAGS += /r:System.Xml.Serialization.dll /r:System.Net.dll
+endif
+
+ifneq (2.1, $(FRAMEWORK_VERSION))
+LIB_MCS_FLAGS += /r:System.Configuration.dll
+endif
+
+TEST_MCS_FLAGS = $(LIB_MCS_FLAGS)
+
+EXTRA_DISTFILES = $(RESOURCE_FILES)
+
+VALID_PROFILE := $(filter 2.1, $(FRAMEWORK_VERSION))
+ifndef VALID_PROFILE
+LIBRARY_NAME = dummy-System.ServiceModel.Web.Extensions.dll
+NO_INSTALL = yes
+NO_SIGN_ASSEMBLY = yes
+endif
+
+include ../../build/library.make
