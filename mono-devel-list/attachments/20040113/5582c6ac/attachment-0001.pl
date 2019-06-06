--- old\XmlAttributeCollection.cs	2004-01-13 10:13:33.000000000 +0200
+++ new\XmlAttributeCollection.cs	2004-01-13 10:11:53.558596000 +0200
@@ -168,13 +168,19 @@
 				ownerDocument.onNodeRemoved (node, null);
 			}
 			// If it is default, then directly create new attribute.
-			if (!retAttr.Specified) {
-				XmlAttribute attr = ownerDocument.CreateAttribute (retAttr.Prefix,
-					retAttr.LocalName, retAttr.NamespaceURI);
-				attr.SetDefault ();
-				foreach (XmlNode child in retAttr.ChildNodes)
-					attr.AppendChild (child);
-				this.SetNamedItem (attr);
+			DTDAttListDeclaration attlist = ownerDocument.DocumentType.DTD.AttListDecls[ownerElement.LocalName];
+			if (attlist != null) 
+			{
+				DTDAttributeDefinition def = attlist [retAttr.Name];
+			
+				if (def.DefaultValue != null)
+				{
+					XmlAttribute attr = ownerDocument.CreateAttribute (retAttr.Prefix,
+						retAttr.LocalName, retAttr.NamespaceURI);
+					attr.SetDefault ();
+					attr.Value = def.DefaultValue;
+					this.SetNamedItem (attr);
+				}
 			}
 			retAttr.SetOwnerElement (null);
 			return retAttr;
