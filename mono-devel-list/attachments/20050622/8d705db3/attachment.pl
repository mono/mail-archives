Index: DTDReader.cs
===================================================================
--- DTDReader.cs	(revision 46238)
+++ DTDReader.cs	(working copy)
@@ -641,8 +641,9 @@
 		private void ResolveExternalEntityReplacementText (DTDEntityBase decl)
 		{
 			if (decl.LiteralEntityValue.StartsWith ("<?xml")) {
+				// FIXME: not always it should be read in Element context - AS
 				XmlTextReader xtr = new XmlTextReader (decl.LiteralEntityValue, XmlNodeType.Element, null);
-				if (decl is DTDEntityDeclaration) {
+				if (decl is DTDEntityDeclaration  && DTD.EntityDecls [decl.Name] == null) {
 					// GE - also checked as valid contents
 					StringBuilder sb = new StringBuilder ();
 					xtr.Normalization = this.Normalization;
@@ -710,8 +711,9 @@
 			}
 			decl.ReplacementText = CreateValueString ();
 
-			if (decl is DTDEntityDeclaration) {
+			if (decl is DTDEntityDeclaration && DTD.EntityDecls [decl.Name] == null) {
 				// GE - also checked as valid contents
+				// FIXME: not always it should be read in Element context - AS
 				XmlTextReader xtr = new XmlTextReader (decl.ReplacementText, XmlNodeType.Element, null);
 				StringBuilder sb = new StringBuilder ();
 				xtr.Normalization = this.Normalization;
