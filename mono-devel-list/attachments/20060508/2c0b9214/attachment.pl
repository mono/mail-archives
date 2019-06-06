Index: System.XML/System.Xml.dll.sources
===================================================================
--- System.XML/System.Xml.dll.sources	(revision 60270)
+++ System.XML/System.Xml.dll.sources	(working copy)
@@ -338,6 +338,7 @@
 System.Xml.Serialization/XmlMemberMapping.cs
 System.Xml.Serialization/XmlMembersMapping.cs
 System.Xml.Serialization/XmlMapping.cs
+System.Xml.Serialization/XmlMappingAccess.cs
 System.Xml.Serialization/XmlNamespaceDeclarationsAttribute.cs
 System.Xml.Serialization/XmlNodeEventArgs.cs
 System.Xml.Serialization/XmlReflectionImporter.cs
Index: System.XML/System.Xml.Serialization/XmlCodeExporter.cs
===================================================================
--- System.XML/System.Xml.Serialization/XmlCodeExporter.cs	(revision 60270)
+++ System.XML/System.Xml.Serialization/XmlCodeExporter.cs	(working copy)
@@ -87,11 +87,11 @@
 		[MonoTODO ("mappings?")]
 		public XmlCodeExporter (CodeNamespace codeNamespace, 
 								CodeCompileUnit codeCompileUnit, 
-								ICodeGenerator codeGen, 
+								CodeDomProvider codeProvider, 
 								CodeGenerationOptions options, 
 								Hashtable mappings)
 		{
-			codeGenerator = new XmlMapCodeGenerator (codeNamespace, codeCompileUnit, codeGen, options, mappings);
+			codeGenerator = new XmlMapCodeGenerator (codeNamespace, codeCompileUnit, codeProvider, options, mappings);
 		}
 #endif
 
@@ -189,8 +189,8 @@
 		{
 		}
 
-		public XmlMapCodeGenerator (CodeNamespace codeNamespace, CodeCompileUnit codeCompileUnit, ICodeGenerator codeGen, CodeGenerationOptions options, Hashtable mappings)
-		: base (codeNamespace, codeCompileUnit, codeGen, options, mappings)
+		public XmlMapCodeGenerator (CodeNamespace codeNamespace, CodeCompileUnit codeCompileUnit, CodeDomProvider codeProvider, CodeGenerationOptions options, Hashtable mappings)
+		: base (codeNamespace, codeCompileUnit, codeProvider, options, mappings)
 		{
 		}
 		
Index: System.XML/System.Xml.Serialization/SoapCodeExporter.cs
===================================================================
--- System.XML/System.Xml.Serialization/SoapCodeExporter.cs	(revision 60270)
+++ System.XML/System.Xml.Serialization/SoapCodeExporter.cs	(working copy)
@@ -80,11 +80,11 @@
 		[MonoTODO ("mappings?")]
 		public SoapCodeExporter (CodeNamespace codeNamespace, 
 								CodeCompileUnit codeCompileUnit, 
-								ICodeGenerator codeGen, 
+								CodeDomProvider codeProvider, 
 								CodeGenerationOptions options, 
 								Hashtable mappings)
 		{
-			codeGenerator = new SoapMapCodeGenerator (codeNamespace, codeCompileUnit, codeGen, options, mappings);
+			codeGenerator = new SoapMapCodeGenerator (codeNamespace, codeCompileUnit, codeProvider, options, mappings);
 		}
 
 #endif
@@ -144,8 +144,8 @@
 			includeArrayTypes = true;
 		}
 
-		public SoapMapCodeGenerator (CodeNamespace codeNamespace, CodeCompileUnit codeCompileUnit, ICodeGenerator codeGen, CodeGenerationOptions options, Hashtable mappings)
-		: base (codeNamespace, codeCompileUnit, codeGen, options, mappings)
+		public SoapMapCodeGenerator (CodeNamespace codeNamespace, CodeCompileUnit codeCompileUnit, CodeDomProvider codeProvider, CodeGenerationOptions options, Hashtable mappings)
+		: base (codeNamespace, codeCompileUnit, codeProvider, options, mappings)
 		{
 		}
 		
Index: System.XML/System.Xml.Serialization/MapCodeGenerator.cs
===================================================================
--- System.XML/System.Xml.Serialization/MapCodeGenerator.cs	(revision 60270)
+++ System.XML/System.Xml.Serialization/MapCodeGenerator.cs	(working copy)
@@ -48,7 +48,7 @@
 		CodeAttributeDeclarationCollection includeMetadata;
 		XmlTypeMapping exportedAnyType = null;
 		protected bool includeArrayTypes;
-		ICodeGenerator codeGen;
+		CodeDomProvider codeProvider;
 		CodeGenerationOptions options;
 
 		Hashtable exportedMaps = new Hashtable ();
@@ -61,11 +61,11 @@
 			this.options = options;
 		}
 
-		public MapCodeGenerator (CodeNamespace codeNamespace, CodeCompileUnit codeCompileUnit, ICodeGenerator codeGen, CodeGenerationOptions options, Hashtable mappings)
+		public MapCodeGenerator (CodeNamespace codeNamespace, CodeCompileUnit codeCompileUnit, CodeDomProvider codeProvider, CodeGenerationOptions options, Hashtable mappings)
 		{
 			this.codeCompileUnit = codeCompileUnit;
 			this.codeNamespace = codeNamespace;
-			this.codeGen = codeGen;
+			this.codeProvider = codeProvider;
 			this.options = options;
 //			this.mappings = mappings;
 		}
@@ -156,7 +156,7 @@
 			codeClass.Attributes = MemberAttributes.Public;
 
 #if NET_2_0
-			codeClass.IsPartial = CodeGenerator.Supports(GeneratorSupport.PartialTypes);
+			codeClass.IsPartial = CodeProvider.Supports(GeneratorSupport.PartialTypes);
 
 			CodeAttributeDeclaration generatedCodeAttribute = new CodeAttributeDeclaration (
 				new CodeTypeReference (typeof(GeneratedCodeAttribute)));
@@ -617,12 +617,12 @@
 		#region Private Properties
 
 #if NET_2_0
-		private ICodeGenerator CodeGenerator {
+		private CodeDomProvider CodeProvider {
 			get {
-				if (codeGen == null) {
-					codeGen = new CSharpCodeProvider ().CreateGenerator ();
+				if (codeProvider == null) {
+					codeProvider = new CSharpCodeProvider ();
 				}
-				return codeGen;
+				return codeProvider;
 			}
 		}
 #endif
Index: System.XML/System.Xml.Serialization/SchemaImporterExtension.cs
===================================================================
--- System.XML/System.Xml.Serialization/SchemaImporterExtension.cs	(revision 60270)
+++ System.XML/System.Xml.Serialization/SchemaImporterExtension.cs	(working copy)
@@ -37,7 +37,7 @@
 using System.Collections.Specialized;
 using System.Xml.Schema;
 
-namespace System.Xml.Serialization 
+namespace System.Xml.Serialization.Advanced
 {
 	public abstract class SchemaImporterExtension
 	{
@@ -51,10 +51,10 @@
 			bool mixed, 
 			XmlSchemas schemas, 
 			XmlSchemaImporter importer, 
+			CodeCompileUnit codeCompileUnit, 
 			CodeNamespace codeNamespace, 
-			StringCollection referencedAssemblies, 
 			CodeGenerationOptions options, 
-			ICodeGenerator codeGenerator
+			CodeDomProvider codeProvider
 		)
 		{
 			throw new NotImplementedException ();
@@ -72,10 +72,10 @@
 			XmlSchemaObject context, 
 			XmlSchemas schemas, 
 			XmlSchemaImporter importer, 
+			CodeCompileUnit codeCompileUnit, 
 			CodeNamespace codeNamespace, 
-			StringCollection referencedAssemblies, 
 			CodeGenerationOptions options, 
-			ICodeGenerator codeGenerator
+			CodeDomProvider codeProvider
 		)
 		{
 			throw new NotImplementedException ();
@@ -88,10 +88,10 @@
 			XmlSchemaObject context, 
 			XmlSchemas schemas, 
 			XmlSchemaImporter importer, 
+			CodeCompileUnit codeCompileUnit, 
 			CodeNamespace codeNamespace, 
-			StringCollection referencedAssemblies, 
 			CodeGenerationOptions options, 
-			ICodeGenerator codeGenerator
+			CodeDomProvider codeProvider
 		)
 		{
 			throw new NotImplementedException ();
Index: System.XML/System.Xml.Serialization/XmlMappingAccess.cs
===================================================================
--- System.XML/System.Xml.Serialization/XmlMappingAccess.cs	(revision 0)
+++ System.XML/System.Xml.Serialization/XmlMappingAccess.cs	(revision 0)
@@ -0,0 +1,46 @@
+//
+// XmlMappingAccess.cs
+//
+// Author:
+//   Atsushi Enomoto
+//
+// Copyright (C) 2006 Atsushi Enomoto
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
+#if NET_2_0
+
+using System;
+using System.Xml.Schema;
+
+namespace System.Xml.Serialization
+{
+	public enum XmlMappingAccess
+	{
+		None,
+		Read,
+		Write
+	}
+}
+
+#endif

Property changes on: System.XML/System.Xml.Serialization/XmlMappingAccess.cs
___________________________________________________________________
Name: svn:eol-style
   + native

Index: System.XML/System.Xml.Serialization/XmlSchemaImporter.cs
===================================================================
--- System.XML/System.Xml.Serialization/XmlSchemaImporter.cs	(revision 60270)
+++ System.XML/System.Xml.Serialization/XmlSchemaImporter.cs	(working copy)
@@ -30,6 +30,7 @@
 //
 
 using System.Xml;
+using System.CodeDom.Compiler;
 using System.Xml.Schema;
 using System.Collections;
 
@@ -91,7 +92,7 @@
 		
 #if NET_2_0
 		[MonoTODO]
-		public XmlSchemaImporter (XmlSchemas schemas, CodeGenerationOptions options, System.CodeDom.Compiler.ICodeGenerator codeGenerator, ImportContext context)
+		public XmlSchemaImporter (XmlSchemas schemas, CodeGenerationOptions options, CodeDomProvider codeProvider, ImportContext context)
 		{
 			this.schemas = schemas;
 			this.options = options;
Index: System.XML/System.Xml.Serialization/XmlMemberMapping.cs
===================================================================
--- System.XML/System.Xml.Serialization/XmlMemberMapping.cs	(revision 60270)
+++ System.XML/System.Xml.Serialization/XmlMemberMapping.cs	(working copy)
@@ -124,13 +124,13 @@
 		
 #if NET_2_0
 		[MonoTODO]
-		public bool IsNullable
+		public string XsdElementName
 		{
 			get { throw new NotImplementedException (); }
 		}
 		
 		[MonoTODO]
-		public string GetTypeName (System.CodeDom.Compiler.ICodeGenerator codeGenerator)
+		public string GenerateTypeName (System.CodeDom.Compiler.CodeDomProvider codeProvider)
 		{
 			throw new NotImplementedException ();
 		}
Index: System.XML/System.Xml.Serialization/SoapSchemaImporter.cs
===================================================================
--- System.XML/System.Xml.Serialization/SoapSchemaImporter.cs	(revision 60270)
+++ System.XML/System.Xml.Serialization/SoapSchemaImporter.cs	(working copy)
@@ -75,9 +75,9 @@
 		}
 		
 		public SoapSchemaImporter (XmlSchemas schemas,CodeGenerationOptions options, 
-									ICodeGenerator codeGenerator, ImportContext context)
+									CodeDomProvider codeProvider, ImportContext context)
 		{
-			_importer = new XmlSchemaImporter (schemas, options, codeGenerator, context);
+			_importer = new XmlSchemaImporter (schemas, options, codeProvider, context);
 			_importer.UseEncodedFormat = true;
 		}
 
Index: System.XML/System.Xml.Serialization/XmlSerializationReader.cs
===================================================================
--- System.XML/System.Xml.Serialization/XmlSerializationReader.cs	(revision 60270)
+++ System.XML/System.Xml.Serialization/XmlSerializationReader.cs	(working copy)
@@ -1069,7 +1069,7 @@
 		}
 				
 		[MonoTODO]
-		protected Exception CreateBadDeriveationException (
+		protected Exception CreateBadDerivationException (
 			string xsdDerived, 
 			string nsDerived, 
 			string xsdBase, 
Index: System.XML/System.Xml.Serialization/SchemaImporter.cs
===================================================================
--- System.XML/System.Xml.Serialization/SchemaImporter.cs	(revision 60270)
+++ System.XML/System.Xml.Serialization/SchemaImporter.cs	(working copy)
@@ -31,6 +31,7 @@
 #if NET_2_0
 
 using System;
+using System.Xml.Serialization.Advanced;
 
 namespace System.Xml.Serialization 
 {
Index: System.XML/System.Xml.Serialization/SchemaImporterExtensionCollection.cs
===================================================================
--- System.XML/System.Xml.Serialization/SchemaImporterExtensionCollection.cs	(revision 60270)
+++ System.XML/System.Xml.Serialization/SchemaImporterExtensionCollection.cs	(working copy)
@@ -33,7 +33,7 @@
 using System;
 using System.Collections;
 
-namespace System.Xml.Serialization 
+namespace System.Xml.Serialization.Advanced
 {
 	public class SchemaImporterExtensionCollection : CollectionBase
 	{
Index: System.Web.Services/System.Web.Services.Description/ProtocolImporter.cs
===================================================================
--- System.Web.Services/System.Web.Services.Description/ProtocolImporter.cs	(revision 60270)
+++ System.Web.Services/System.Web.Services.Description/ProtocolImporter.cs	(working copy)
@@ -185,7 +185,7 @@
 			get { return descriptionImporter.CodeGenerationOptions; }
 		}
 		
-		internal ICodeGenerator CodeGenerator {
+		internal CodeDomProvider CodeGenerator {
 			get { return descriptionImporter.CodeGenerator; }
 		}
 
Index: System.Web.Services/System.Web.Services.Description/ServiceDescriptionImporter.cs
===================================================================
--- System.Web.Services/System.Web.Services.Description/ServiceDescriptionImporter.cs	(revision 60270)
+++ System.Web.Services/System.Web.Services.Description/ServiceDescriptionImporter.cs	(working copy)
@@ -54,7 +54,7 @@
 		
 #if NET_2_0
 		CodeGenerationOptions options;
-		ICodeGenerator codeGenerator;
+		CodeDomProvider codeGenerator;
 		ImportContext context;
 #endif
 
@@ -104,7 +104,7 @@
 		}
 		
 		[System.Runtime.InteropServices.ComVisible(false)]
-		public ICodeGenerator CodeGenerator {
+		public CodeDomProvider CodeGenerator {
 			get { return codeGenerator; }
 			set { codeGenerator = value; }
 		}
@@ -174,7 +174,7 @@
 			WebReferenceCollection webReferences, 
 			CodeGenerationOptions options, 
 			ServiceDescriptionImportStyle style, 
-			ICodeGenerator codeGenerator)
+			CodeDomProvider codeGenerator)
 		{
 			CodeCompileUnit codeCompileUnit = new CodeCompileUnit ();
 			return GenerateWebReferences (webReferences, options, style, codeGenerator, codeCompileUnit, false);
@@ -185,7 +185,7 @@
 			WebReferenceCollection webReferences, 
 			CodeGenerationOptions options, 
 			ServiceDescriptionImportStyle style, 
-			ICodeGenerator codeGenerator, 
+			CodeDomProvider codeGenerator, 
 			CodeCompileUnit codeCompileUnit, 
 			bool verbose)
 		{