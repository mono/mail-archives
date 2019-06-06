? gc.log
? xsd-20040421.diff
Index: Makefile
===================================================================
RCS file: /cvs/public/mcs/tools/mono-xsd/Makefile,v
retrieving revision 1.2
diff -u -r1.2 Makefile
--- Makefile	7 Aug 2003 23:39:39 -0000	1.2
+++ Makefile	21 Apr 2004 14:25:42 -0000
@@ -2,7 +2,7 @@
 SUBDIRS = 
 include ../../build/rules.make
 
-LOCAL_MCS_FLAGS = /r:System.Xml.dll
+LOCAL_MCS_FLAGS = /r:System.Xml.dll /r:System.Data.dll
 PROGRAM = xsd.exe
 
 include ../../build/executable.make
Index: NewMonoXSD.cs
===================================================================
RCS file: /cvs/public/mcs/tools/mono-xsd/NewMonoXSD.cs,v
retrieving revision 1.2
diff -u -r1.2 NewMonoXSD.cs
--- NewMonoXSD.cs	19 Jan 2004 13:40:41 -0000	1.2
+++ NewMonoXSD.cs	21 Apr 2004 14:25:42 -0000
@@ -1,8 +1,9 @@
 ///
 /// MonoXSD.cs -- A reflection-based tool for dealing with XML Schema.
 ///
-/// Author: Duncan Mak (duncan@ximian.com)
-///         Lluis Sanchez Gual (lluis@ximian.com)
+/// Authors: Duncan Mak (duncan@ximian.com)
+///          Lluis Sanchez Gual (lluis@ximian.com)
+///          Atsushi Enomoto (atsushi@ximian.com)
 ///
 /// Copyright (C) 2003, Duncan Mak,
 ///                     Ximian, Inc.
@@ -10,6 +11,7 @@
 
 using System;
 using System.Collections;
+using System.Data;
 using System.IO;
 using System.Reflection;
 using System.Xml;
@@ -27,8 +29,13 @@
 			"xsd.exe - a utility for generating schema or class files\n\n" +
 			"xsd.exe <schema>.xsd /classes [/element:NAME] [/language:NAME]\n" +
 			"            [/namespace:NAME] [/outputdir:PATH] [/uri:NAME]\n\n" +
+//			"xsd.exe <schema>.xsd /dataset [/element:NAME] [/language:NAME]\n" +
+//			"            [/namespace:NAME] [/outputdir:PATH] [/uri:NAME]\n\n" +
+
 			"xsd.exe <assembly>.dll|<assembly>.exe [/outputdir:PATH] [/type:NAME]\n\n" +
+			"xsd.exe <instance>.xml [<instance>.xml ...] [/outputdir:PATH]\n\n" +
 			"   /c /classes        Generate classes for the specified schema.\n" +
+//			"   /d /dataset        Generate typed dataset classes for the specified schema.\n" +
 			"   /e /element:NAME   Element from schema to generate code for.\n" +
 			"                      Multiple elements can be specified.\n" +
 			"   /u /uri:NAME       Namespace uri of the elements to generate code for.\n" +
@@ -49,7 +56,7 @@
 		static readonly string errLoadAssembly = "Could not load assembly: {0}";
 		static readonly string typeNotFound = "Type {0} not found in the specified assembly";
 		static readonly string languageNotSupported = "The language {0} is not supported";
-		
+		static readonly string missingOutputForXsdInput = "Can only generate one of classes or datasets.";
 
 		static void Main (string [] args)
 		{
@@ -76,6 +83,7 @@
 		ArrayList assemblies = new ArrayList();
 
 		ArrayList schemaNames = new ArrayList();
+		ArrayList inferenceNames = new ArrayList();
 		ArrayList elements = new ArrayList();
 		string language = null;
 		string namesp = null;
@@ -88,6 +96,8 @@
 			bool readingFiles = true;
 			bool schemasOptions = false;
 			bool assemblyOptions = false;
+			bool generateDataset = false;
+			bool inference = false;
 
 			foreach (string arg in args)
 			{
@@ -105,6 +115,13 @@
 					schemasOptions = true;
 					continue;
 				}
+				else if (arg.EndsWith (".xml"))
+				{
+					if (generateClasses || generateDataset) Error (duplicatedParam);
+					inferenceNames.Add (arg);
+					inference = true;
+					continue;
+				}
 				else if (!arg.StartsWith ("/") && !arg.StartsWith ("-"))
 				{
 					if (!readingFiles) Error (incorrectOrder);
@@ -121,10 +138,16 @@
 
 				if (option == "classes" || option == "c")
 				{
-					if (generateClasses) Error (duplicatedParam, option);
+					if (generateClasses || generateDataset || inference) Error (duplicatedParam, option);
 					generateClasses = true;
 					schemasOptions = true;
 				}
+				else if (option == "dataset" || option == "d")
+				{
+					if (generateClasses || generateDataset || inference) Error (duplicatedParam, option);
+					generateDataset = true;
+					schemasOptions = true;
+				}
 				else if (option == "element" || option == "e")
 				{
 					elements.Add (param);
@@ -167,7 +190,7 @@
 					Error (unknownOption, option);
 			}
 
-			if (!schemasOptions && !assemblyOptions)
+			if (!schemasOptions && !assemblyOptions && !inference)
 				Error (invalidParams);
 
 			if (schemasOptions && assemblyOptions)
@@ -180,8 +203,23 @@
 				
 			if (schemasOptions)
 			{
+				if (!generateClasses && !generateDataset)
+					Error (missingOutputForXsdInput);
 				schemaNames.AddRange (unknownFiles);
-				GenerateClasses ();
+				if (generateClasses)
+					GenerateClasses ();
+				else if (generateDataset)
+					GenerateDataset ();
+			}
+			else if (inference)
+			{
+				foreach (string xmlfile in inferenceNames) {
+					string genFile = Path.Combine (outputDir, Path.ChangeExtension (xmlfile, ".xsd"));
+					DataSet ds = new DataSet ();
+					ds.InferXmlSchema (xmlfile, null);
+					ds.WriteXmlSchema (genFile);
+					Console.WriteLine ("Written file " + genFile);
+				}
 			}
 			else
 			{
@@ -314,6 +352,48 @@
 			
 			CSharpCodeProvider provider = new CSharpCodeProvider();
 			ICodeGenerator gen = provider.CreateGenerator();
+
+			string genFile = Path.Combine (outputDir, targetFile);
+			StreamWriter sw = new StreamWriter(genFile, false);
+			gen.GenerateCodeFromCompileUnit (cunit, sw, new CodeGeneratorOptions());
+			sw.Close();
+
+			Console.WriteLine ("Written file " + genFile);
+		}
+
+		public void GenerateDataset ()
+		{
+			Error ("DataSet generation is not supported yet.");
+
+			if (language != null && language != "CS") Error (languageNotSupported, language);
+			if (namesp == null) namesp = "Schemas";
+			if (uri == null) uri = "";
+			string targetFile = "";
+
+			DataSet dataset = new DataSet ();
+			foreach (string fileName in schemaNames)
+			{
+				dataset.ReadXmlSchema (fileName);
+
+				if (targetFile == "") targetFile = Path.GetFileNameWithoutExtension (fileName);
+				else targetFile += "_" + Path.GetFileNameWithoutExtension (fileName);
+			}
+
+			targetFile += ".cs";
+
+			CodeCompileUnit cunit = new CodeCompileUnit ();
+			CodeNamespace codeNamespace = new CodeNamespace (namesp);
+			cunit.Namespaces.Add (codeNamespace);
+			codeNamespace.Comments.Add (new CodeCommentStatement ("\nThis source code was auto-generated by MonoXSD\n"));
+
+			// Import schemas and generate the class model
+
+			// Generate the code
+			
+			CSharpCodeProvider provider = new CSharpCodeProvider();
+			ICodeGenerator gen = provider.CreateGenerator();
+
+			TypedDataSetGenerator.Generate (dataset, codeNamespace, gen);
 
 			string genFile = Path.Combine (outputDir, targetFile);
 			StreamWriter sw = new StreamWriter(genFile, false);