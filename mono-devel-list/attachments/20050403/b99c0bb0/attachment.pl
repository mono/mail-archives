Index: System.Xml.Serialization/ChangeLog
===================================================================
--- System.Xml.Serialization/ChangeLog	(revision 42365)
+++ System.Xml.Serialization/ChangeLog	(working copy)
@@ -1,3 +1,8 @@
+2004-04-03  Andrew Skiba <andrews@mainsoft.com>
+
+	* XmlSerializer.cs: added TARGET_JVM that does not support on-the-fly
+        code generation.
+
 2005-03-29  Lluis Sanchez Gual  <lluis@novell.com>
 
 	* XmlReflectionImporter.cs: Added support for subclasses of XmlNode.
Index: System.Xml.Serialization/XmlSerializer.cs
===================================================================
--- System.Xml.Serialization/XmlSerializer.cs	(revision 42365)
+++ System.Xml.Serialization/XmlSerializer.cs	(working copy)
@@ -37,9 +37,11 @@
 using System.Xml;
 using System.Xml.Schema;
 using System.Text;
+#if !TARGET_JVM
 using System.CodeDom;
 using System.CodeDom.Compiler;
 using Microsoft.CSharp;
+#endif
 using System.Configuration;
 using System.Security.Policy;
 
@@ -561,8 +583,22 @@
 			return new XmlSerializationReaderInterpreter (typeMapping);
 		}
 		
+#if TARGET_JVM
 		void CheckGeneratedTypes (XmlMapping typeMapping)
 		{
+			throw new NotImplementedException();
+		}
+		void GenerateSerializersAsync (GenerationBatch batch)
+		{
+			throw new NotImplementedException();
+		}
+		void RunSerializerGeneration (object obj)
+		{
+			throw new NotImplementedException();
+		}
+#else
+		void CheckGeneratedTypes (XmlMapping typeMapping)
+		{
 			lock (this)
 			{
 				if (serializerData == null) 
@@ -715,6 +751,7 @@
 				
 			return res.CompiledAssembly;
 		}
+#endif
 		
 #if NET_2_0
 		GenerationBatch LoadFromSatelliteAssembly (GenerationBatch batch)
