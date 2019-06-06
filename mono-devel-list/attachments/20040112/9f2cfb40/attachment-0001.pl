--- old\XmlElement.cs	2004-01-12 18:38:28.000000000 +0200
+++ new\XmlElement.cs	2004-01-12 18:14:27.992210100 +0200
@@ -66,7 +66,10 @@
 					for (int i = 0; i < attlist.Definitions.Count; i++) {
 						DTDAttributeDefinition def = attlist [i];
 						if (def.DefaultValue != null)
+						{
 							SetAttribute (def.Name, def.DefaultValue);
+							attributes[def.Name].SetDefault();
+						}							
 					}
 				}
 			}
