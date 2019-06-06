Index: SerializationCodeGeneratorConfiguration.cs
===================================================================
--- SerializationCodeGeneratorConfiguration.cs	(revision 38473)
+++ SerializationCodeGeneratorConfiguration.cs	(working copy)
@@ -55,7 +55,16 @@
 		
 		[XmlElement ("writer")]
 		public string WriterClassName;
+	
+		[XmlElement ("noreader")]
+		public bool NoReader;
 		
+		[XmlElement ("nowriter")]
+		public bool NoWriter;
+		
+		[XmlElement ("generateAsInternal")]
+		public bool GenerateAsInternal;
+		
 		[XmlElement ("namespace")]
 		public string Namespace;
 		
Index: SerializationCodeGenerator.cs
===================================================================
--- SerializationCodeGenerator.cs	(revision 38473)
+++ SerializationCodeGenerator.cs	(working copy)
@@ -232,9 +232,11 @@
 				WriteLine ("namespace " + entry.Key);
 				WriteLineInd ("{");
 				
-				GenerateReader (readerClassName, maps);
+				if (!_config.NoReader)
+					GenerateReader (readerClassName, maps);
 				WriteLine ("");
-				GenerateWriter (writerClassName, maps);
+				if (!_config.NoWriter)
+					GenerateWriter (writerClassName, maps);
 				WriteLine ("");
 				
 #if NET_2_0
@@ -411,7 +413,10 @@
 			
 			InitHooks ();
 			
-			WriteLine ("public class " + writerClassName + " : XmlSerializationWriter");
+			if (!_config.GenerateAsInternal)
+				WriteLine ("public class " + writerClassName + " : XmlSerializationWriter");
+			else
+				WriteLine ("internal class " + writerClassName + " : XmlSerializationWriter");
 			WriteLineInd ("{");
 			
 			for (int n=0; n<maps.Count; n++)
@@ -1199,7 +1204,10 @@
 		
 		public void GenerateReader (string readerClassName, ArrayList maps)
 		{
-			WriteLine ("public class " + readerClassName + " : XmlSerializationReader");
+			if (!_config.GenerateAsInternal)
+				WriteLine ("public class " + readerClassName + " : XmlSerializationReader");
+			else
+				WriteLine ("internal class " + readerClassName + " : XmlSerializationReader");
 			WriteLineInd ("{");
 
 			_mapsToGenerate = new ArrayList ();