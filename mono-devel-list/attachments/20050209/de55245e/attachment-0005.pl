Index: Mono.Xml.XPath/LocationPathPattern.cs
===================================================================
--- Mono.Xml.XPath/LocationPathPattern.cs	(revision 40268)
+++ Mono.Xml.XPath/LocationPathPattern.cs	(working copy)
@@ -72,7 +72,7 @@
 				if (patternPrevious == null && filter == null) {
 					NodeNameTest t = nodeTest as NodeNameTest;
 					if (t != null) {
-						if (t.Name.Name == "*")
+						if (t.Name.Name == "*" || t.Name.Name.Length == 0)
 							return -.25;
 						return 0;
 					}