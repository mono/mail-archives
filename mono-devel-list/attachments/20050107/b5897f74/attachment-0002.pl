Index: XmlSerializationWriter.cs
===================================================================
--- XmlSerializationWriter.cs	(revision 38473)
+++ XmlSerializationWriter.cs	(working copy)
@@ -485,7 +485,7 @@
 
 			ICollection namespaces = ns.Namespaces.Values;
 			foreach (XmlQualifiedName qn in namespaces) {
-				if (qn.Namespace != String.Empty && Writer.LookupPrefix (qn.Namespace) == null)
+				if (qn.Namespace != String.Empty && Writer.LookupPrefix (qn.Namespace) != qn.Name)
 					WriteAttribute ("xmlns", qn.Name, xmlNamespace, qn.Namespace);
 			}
 		}