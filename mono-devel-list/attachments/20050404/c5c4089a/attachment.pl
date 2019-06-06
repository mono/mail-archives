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
 
@@ -99,18 +101,14 @@
 		
 		static XmlSerializer ()
 		{
+			
+#if MAINSOFT_ONLY
+			string db = null;
+			string th = null;
+			generationThreshold = -1;
+			backgroundGeneration = false;
+#else
 			string db = Environment.GetEnvironmentVariable ("MONO_XMLSERIALIZER_DEBUG");
-			deleteTempFiles = (db == null || db == "no");
-			
-			IDictionary table = (IDictionary) ConfigurationSettings.GetConfig("system.diagnostics");
-			if (table != null) {
-				table = (IDictionary) table["switches"];
-				if (table != null) {
-					string val = (string) table ["XmlSerialization.Compilation"];
-					if (val == "1") deleteTempFiles = false;
-				}
-			}
-			
 			string th = Environment.GetEnvironmentVariable ("MONO_XMLSERIALIZER_THS");
 			
 			if (th == null) {
@@ -124,6 +122,19 @@
 				backgroundGeneration = (generationThreshold != 0);
 				if (generationThreshold < 1) generationThreshold = 1;
 			}
+#endif
+			deleteTempFiles = (db == null || db == "no");
+			
+			IDictionary table = (IDictionary) ConfigurationSettings.GetConfig("system.diagnostics");
+			if (table != null) 
+			{
+				table = (IDictionary) table["switches"];
+				if (table != null) 
+				{
+					string val = (string) table ["XmlSerialization.Compilation"];
+					if (val == "1") deleteTempFiles = false;
+				}
+			}
 		}
 
 #region Constructors
@@ -561,6 +572,20 @@
 			return new XmlSerializationReaderInterpreter (typeMapping);
 		}
 		
+#if TARGET_JVM
+ 		void CheckGeneratedTypes (XmlMapping typeMapping)
+ 		{
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
 		void CheckGeneratedTypes (XmlMapping typeMapping)
 		{
 			lock (this)
@@ -715,6 +740,7 @@
 				
 			return res.CompiledAssembly;
 		}
+#endif
 		
 #if NET_2_0
 		GenerationBatch LoadFromSatelliteAssembly (GenerationBatch batch)

