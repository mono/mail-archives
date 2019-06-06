Index: Mono.Xml.Xsl/XslStylesheet.cs
===================================================================
--- Mono.Xml.Xsl/XslStylesheet.cs	(revision 40268)
+++ Mono.Xml.Xsl/XslStylesheet.cs	(working copy)
@@ -327,7 +327,7 @@
 					break;
 				
 				case "namespace-alias":
-					namespaceAliases.Add ((string) c.GetAttribute ("stylesheet-prefix", ""), (string) c.GetAttribute ("result-prefix", ""));
+					namespaceAliases.Set ((string) c.GetAttribute ("stylesheet-prefix", ""), (string) c.GetAttribute ("result-prefix", ""));
 					break;
 				
 				case "attribute-set":