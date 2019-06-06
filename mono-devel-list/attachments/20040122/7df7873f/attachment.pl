--- old\XmlSerializationReaderInterpreter.cs	2004-01-22 12:59:23.397495500 +0200
+++ new\XmlSerializationReaderInterpreter.cs	2004-01-22 12:20:19.421204800 +0200
@@ -132,7 +132,7 @@
 
 		object ReadRoot (XmlTypeMapping rootMap)
 		{
-			if (Reader.LocalName != rootMap.ElementName || Reader.NamespaceURI != rootMap.Namespace)
+			if (Reader.NamespaceURI != rootMap.Namespace)
 				throw CreateUnknownNodeException();
 				
 			return ReadObject (rootMap, true, true);
