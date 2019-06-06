Index: Mono.Xml.XPath/DTMXPathDocumentBuilder2.cs
===================================================================
--- Mono.Xml.XPath/DTMXPathDocumentBuilder2.cs	(revision 40268)
+++ Mono.Xml.XPath/DTMXPathDocumentBuilder2.cs	(working copy)
@@ -256,17 +256,20 @@
 			parentForFirstChild = -1;	// Might be changed in ProcessElement().
 
 			string value = null;
-			XPathNodeType nodeType = xmlReader.NodeType == XmlNodeType.Whitespace ?
-				XPathNodeType.Whitespace : XPathNodeType.Text;
+			XPathNodeType nodeType = XPathNodeType.Text;
 
 			switch (xmlReader.NodeType) {
 			case XmlNodeType.Element:
 				ProcessElement (parent, prevSibling);
 				break;
+			case XmlNodeType.SignificantWhitespace:
+				nodeType = XPathNodeType.SignificantWhitespace;
+				goto case XmlNodeType.Text;
+			case XmlNodeType.Whitespace:
+				nodeType = XPathNodeType.Whitespace;
+				goto case XmlNodeType.Text;
 			case XmlNodeType.CDATA:
-			case XmlNodeType.SignificantWhitespace:
 			case XmlNodeType.Text:
-			case XmlNodeType.Whitespace:
 				if (value == null)
 					skipRead = true;
 				AddNode (parent,
Index: Mono.Xml.Xsl.Operations/XslApplyTemplates.cs
===================================================================
--- Mono.Xml.Xsl.Operations/XslApplyTemplates.cs	(revision 40268)
+++ Mono.Xml.Xsl.Operations/XslApplyTemplates.cs	(working copy)
@@ -56,6 +56,7 @@
 					case XPathNodeType.Comment:
 					case XPathNodeType.ProcessingInstruction:
 					case XPathNodeType.Whitespace:
+					case XPathNodeType.SignificantWhitespace:
 						continue;
 					case XPathNodeType.Element:
 						if (c.Input.NamespaceURI != XsltNamespace)