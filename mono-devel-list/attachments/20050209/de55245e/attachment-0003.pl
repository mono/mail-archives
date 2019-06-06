Index: System.Xml.XPath/Parser.jay
===================================================================
--- System.Xml.XPath/Parser.jay	(revision 40268)
+++ System.Xml.XPath/Parser.jay	(working copy)
@@ -14,6 +14,7 @@
 	{
 	
 		internal System.Xml.Xsl.IStaticXsltContext Context;
+		internal System.IO.TextWriter ErrorOutput;
 		
 		public XPathParser () : this (null) {}
 		internal XPathParser (System.Xml.Xsl.IStaticXsltContext context)