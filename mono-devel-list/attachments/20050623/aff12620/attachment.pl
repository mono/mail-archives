Index: System.Data/DataSet.cs
===================================================================
--- System.Data/DataSet.cs	(revision 46217)
+++ System.Data/DataSet.cs	(working copy)
@@ -1023,9 +1023,17 @@
 					continue;
 				}
 
-				//collect data
-				XmlNode n = doc.ReadNode(reader);
-				root.AppendChild(n);
+				if (mode == XmlReadMode.InferSchema ||
+					mode == XmlReadMode.Auto ||
+					mode == XmlReadMode.DiffGram ||
+					mode == XmlReadMode.IgnoreSchema) {
+					//collect data
+					XmlNode n = doc.ReadNode(reader);
+					root.AppendChild(n);
+					continue;
+				}
+
+				XmlDataReader.ReadXml (this, reader, mode);
 			}
 
 			if (reader.NodeType == XmlNodeType.EndElement)

