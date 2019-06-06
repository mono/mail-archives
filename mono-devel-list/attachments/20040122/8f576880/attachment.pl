--- old\XmlSerializationReaderInterpreter.cs	2004-01-22 12:21:14.296531600 +0200
+++ new\XmlSerializationReaderInterpreter.cs	2004-01-22 12:20:19.421204800 +0200
@@ -132,9 +132,6 @@
 
 		object ReadRoot (XmlTypeMapping rootMap)
 		{
-//			if (Reader.LocalName != rootMap.ElementName || Reader.NamespaceURI != rootMap.Namespace)
-//				throw CreateUnknownNodeException();
-
 			if (Reader.NamespaceURI != rootMap.Namespace)
 				throw CreateUnknownNodeException();
 				
