Index: System.Xml.Serialization/XmlSerializationReaderInterpreter.cs
===================================================================
--- System.Xml.Serialization/XmlSerializationReaderInterpreter.cs	(revision 42751)
+++ System.Xml.Serialization/XmlSerializationReaderInterpreter.cs	(working copy)
@@ -128,7 +128,7 @@
 				
 				while (Reader.NodeType != System.Xml.XmlNodeType.EndElement) 
 				{
-					if (Reader.IsStartElement(typeMap.ElementName, typeMap.Namespace) 
+					if (Reader.IsStartElement(XmlConvert.EncodeLocalName(typeMap.ElementName), typeMap.Namespace) 
 					    || _format == SerializationFormat.Encoded)  
 					{
 						if (Reader.IsEmptyElement) { Reader.Skip(); Reader.MoveToContent(); continue; }
Index: System.Xml.Serialization/XmlSchemaExporter.cs
===================================================================
--- System.Xml.Serialization/XmlSchemaExporter.cs	(revision 42751)
+++ System.Xml.Serialization/XmlSchemaExporter.cs	(working copy)
@@ -96,13 +96,13 @@
 				
 				if (encodedFormat)
 				{
-					stype.Name = xmlMembersMapping.ElementName;
+					stype.Name = XmlConvert.EncodeLocalName(xmlMembersMapping.ElementName);
 					schema.Items.Add (stype);
 				}
 				else
 				{
 					XmlSchemaElement selem = new XmlSchemaElement ();
-					selem.Name = xmlMembersMapping.ElementName;
+					selem.Name = XmlConvert.EncodeLocalName(xmlMembersMapping.ElementName);
 					selem.SchemaType = stype;
 					schema.Items.Add (selem);
 				}
Index: System.Xml.Serialization/XmlReflectionImporter.cs
===================================================================
--- System.Xml.Serialization/XmlReflectionImporter.cs	(revision 42751)
+++ System.Xml.Serialization/XmlReflectionImporter.cs	(working copy)
@@ -233,7 +233,7 @@
 			if (root != null)
 			{
 				if (root.ElementName != null && root.ElementName != String.Empty)
-					elementName = root.ElementName;
+					elementName = XmlConvert.EncodeLocalName(root.ElementName);
 				if (root.Namespace != null && root.Namespace != String.Empty)
 					rootNamespace = root.Namespace;
 				nullable = root.IsNullable;
@@ -415,7 +415,7 @@
 				else if (elem.TypeData.IsComplexType)
 					elem.MappedType = ImportTypeMapping (elemType, null, elem.Namespace);
 
-				if (att.ElementName != null) elem.ElementName = att.ElementName;
+				if (att.ElementName != null) elem.ElementName = XmlConvert.EncodeLocalName(att.ElementName);
 				else if (elem.MappedType != null) elem.ElementName = elem.MappedType.ElementName;
 				else elem.ElementName = TypeTranslator.GetTypeData(elemType).XmlType;
 
@@ -712,6 +712,8 @@
 				else 
 					mapAttribute.AttributeName = atts.XmlAttribute.AttributeName;
 
+				mapAttribute.AttributeName = XmlConvert.EncodeLocalName(mapAttribute.AttributeName);
+
 				if (typeData.IsComplexType)
 					mapAttribute.MappedType = ImportTypeMapping (typeData.Type, null, mapAttribute.Namespace);
 				
@@ -761,7 +763,7 @@
 					// Creates an ElementInfo that identifies the array instance. 
 					member.ElementInfo = new XmlTypeMapElementInfoList();
 					XmlTypeMapElementInfo elem = new XmlTypeMapElementInfo (member, typeData);
-					elem.ElementName = (atts.XmlArray != null && atts.XmlArray.ElementName != null) ? atts.XmlArray.ElementName : rmember.MemberName;
+					elem.ElementName = XmlConvert.EncodeLocalName((atts.XmlArray != null && atts.XmlArray.ElementName != null) ? atts.XmlArray.ElementName : rmember.MemberName);
 					elem.Namespace = (atts.XmlArray != null && atts.XmlArray.Namespace != null) ? atts.XmlArray.Namespace : defaultNamespace;
 					elem.MappedType = ImportListMapping (rmember.MemberType, null, elem.Namespace, atts, 0);
 					elem.IsNullable = (atts.XmlArray != null) ? atts.XmlArray.IsNullable : false;
@@ -776,7 +778,7 @@
 				// An element
 
 				XmlTypeMapMemberElement member = new XmlTypeMapMemberElement ();
-				member.ElementInfo = ImportElementInfo (declaringType, rmember.MemberName, defaultNamespace, rmember.MemberType, member, atts);
+ 				member.ElementInfo = ImportElementInfo (declaringType, XmlConvert.EncodeLocalName(rmember.MemberName), defaultNamespace, rmember.MemberType, member, atts);
 				mapMember = member;
 			}
 
@@ -841,7 +843,7 @@
 				}
 
 				if (att.ElementName != null) 
-					elem.ElementName = att.ElementName;
+					elem.ElementName = XmlConvert.EncodeLocalName(att.ElementName);
 				else if (multiType) {
 					if (elem.MappedType != null) elem.ElementName = elem.MappedType.ElementName;
 					else elem.ElementName = TypeTranslator.GetTypeData(elemType).XmlType;
@@ -871,7 +873,7 @@
 				XmlTypeMapElementInfo elem = new XmlTypeMapElementInfo (member, TypeTranslator.GetTypeData(typeof(XmlElement)));
 				if (att.Name != null && att.Name != string.Empty) 
 				{
-					elem.ElementName = att.Name;
+					elem.ElementName = XmlConvert.EncodeLocalName(att.Name);
 					elem.Namespace = (att.Namespace != null) ? att.Namespace : "";
 				}
 				else 
Index: System.Xml.Serialization/XmlSerializationWriterInterpreter.cs
===================================================================
--- System.Xml.Serialization/XmlSerializationWriterInterpreter.cs	(revision 42751)
+++ System.Xml.Serialization/XmlSerializationWriterInterpreter.cs	(working copy)
@@ -153,7 +153,7 @@
 		{
 			if (membersMap.HasWrapperElement) {
 				TopLevelElement ();
-				WriteStartElement(membersMap.ElementName, membersMap.Namespace, (_format == SerializationFormat.Encoded));
+				WriteStartElement(XmlConvert.EncodeLocalName(membersMap.ElementName), membersMap.Namespace, (_format == SerializationFormat.Encoded));
 
 				if (Writer.LookupPrefix (XmlSchema.Namespace) == null)
 					WriteAttribute ("xmlns","xsd",XmlSchema.Namespace,XmlSchema.Namespace);
Index: System.Xml.Serialization/XmlSerializationWriter.cs
===================================================================
--- System.Xml.Serialization/XmlSerializationWriter.cs	(revision 42751)
+++ System.Xml.Serialization/XmlSerializationWriter.cs	(working copy)
@@ -213,7 +213,7 @@
 			if (xmlQualifiedName == null || xmlQualifiedName == XmlQualifiedName.Empty)
 				return null;
 				
-			return GetQualifiedName (xmlQualifiedName.Name, xmlQualifiedName.Namespace);
+			return GetQualifiedName (XmlConvert.EncodeLocalName(xmlQualifiedName.Name), xmlQualifiedName.Namespace);
 		}
 
 		private string GetId (object o, bool addToReferencesList)
