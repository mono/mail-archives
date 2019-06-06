--- mcs/class/System.Web.Services/System.Web.Services.Description/ProtocolReflector.cs.orig	2004-01-12 17:05:00.000000000 +0200
+++ mcs/class/System.Web.Services/System.Web.Services.Description/ProtocolReflector.cs	2004-01-12 17:05:07.000000000 +0200
@@ -234,6 +234,7 @@
 				{
 					ServiceDescription newDesc = new ServiceDescription();
 					newDesc.TargetNamespace = binfo.Namespace;
+					newDesc.Name = binfo.Name;
 					int id = ServiceDescriptions.Add (newDesc);
 					AddImport (desc, binfo.Namespace, GetWsdlUrl (url,id));
 					ImportBindingContent (newDesc, typeInfo, url, binfo);