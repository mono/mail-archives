Index: System.Xml.Serialization/TypeData.cs
===================================================================
--- System.Xml.Serialization/TypeData.cs	(revision 141974)
+++ System.Xml.Serialization/TypeData.cs	(working copy)
@@ -40,6 +40,10 @@
 using System.Text;
 using System.Xml.Schema;
 
+#if NET_2_1
+using XmlSchemaPatternFacet = System.Object;
+#endif
+
 namespace System.Xml.Serialization
 {
 	internal class TypeData
@@ -82,8 +86,10 @@
 					sType = SchemaTypes.Enum;
 				else if (typeof(IXmlSerializable).IsAssignableFrom (type))
 					sType = SchemaTypes.XmlSerializable;
+#if !NET_2_1
 				else if (typeof (System.Xml.XmlNode).IsAssignableFrom (type))
 					sType = SchemaTypes.XmlNode;
+#endif
 				else if (type.IsArray || typeof(IEnumerable).IsAssignableFrom (type))
 					sType = SchemaTypes.Array;
 				else
Index: System.Xml.Serialization/XmlTypeMapping.cs
===================================================================
--- System.Xml.Serialization/XmlTypeMapping.cs	(revision 141974)
+++ System.Xml.Serialization/XmlTypeMapping.cs	(working copy)
@@ -191,7 +191,7 @@
 	internal class XmlSerializableMapping : XmlTypeMapping
 	{
 		XmlSchema _schema;
-#if NET_2_0
+#if NET_2_0 && !NET_2_1
 		XmlSchemaComplexType _schemaType;
 		XmlQualifiedName _schemaTypeName;
 #endif
@@ -199,7 +199,7 @@
 		internal XmlSerializableMapping(string elementName, string ns, TypeData typeData, string xmlType, string xmlTypeNamespace)
 			: base(elementName, ns, typeData, xmlType, xmlTypeNamespace)
 		{
-#if NET_2_0
+#if NET_2_0 && !NET_2_1
 			XmlSchemaProviderAttribute schemaProvider = (XmlSchemaProviderAttribute) Attribute.GetCustomAttribute (typeData.Type, typeof (XmlSchemaProviderAttribute));
 
 			if (schemaProvider != null) {
@@ -247,7 +247,7 @@
 			}
 #endif
 			IXmlSerializable serializable = (IXmlSerializable)Activator.CreateInstance (typeData.Type, true);
-#if NET_2_0
+#if NET_2_0 && !NET_2_1
 			try {
 				_schema = serializable.GetSchema();
 			} catch (Exception) {
@@ -256,11 +256,13 @@
 #else
 			_schema = serializable.GetSchema();
 #endif
+#if !NET_2_1
 			if (_schema != null) 
 			{
 				if (_schema.Id == null || _schema.Id.Length == 0) 
 					throw new InvalidOperationException("Schema Id is missing. The schema returned from " + typeData.Type.FullName + ".GetSchema() must have an Id.");
 			}
+#endif
 		}
 
 		internal XmlSchema Schema
@@ -268,7 +270,7 @@
 			get { return _schema; }
 		}
 
-#if NET_2_0
+#if NET_2_0 && !NET_2_1
 		internal XmlSchemaType SchemaType {
 			get { return _schemaType; }
 		}
Index: System.Xml.Serialization/XmlSerializationReaderInterpreter.cs
===================================================================
--- System.Xml.Serialization/XmlSerializationReaderInterpreter.cs	(revision 141974)
+++ System.Xml.Serialization/XmlSerializationReaderInterpreter.cs	(working copy)
@@ -94,6 +94,9 @@
 
 		object ReadEncodedObject (XmlTypeMapping typeMap)
 		{
+#if NET_2_1
+			throw new NotSupportedException ();
+#else
 			object ob = null;
 			Reader.MoveToContent();
 			if (Reader.NodeType == System.Xml.XmlNodeType.Element) 
@@ -108,10 +111,14 @@
 
 			ReadReferencedElements();
 			return ob;
+#endif
 		}
 
 		protected virtual object ReadMessage (XmlMembersMapping typeMap)
 		{
+#if NET_2_1
+			throw new NotSupportedException ();
+#else
 			object[] parameters = new object[typeMap.Count];
 
 			if (typeMap.HasWrapperElement)
@@ -168,6 +175,7 @@
 				ReadReferencedElements();
 
 			return parameters;
+#endif
 		}
 
 		object ReadRoot (XmlTypeMapping rootMap)
@@ -271,6 +279,7 @@
 							nss.Add ("", Reader.Value);
 					}
 				}	
+#if !NET_2_1
 				else if (anyAttrMember != null) 
 				{
 					XmlAttribute attr = (XmlAttribute) Document.ReadNode(Reader);
@@ -279,13 +288,16 @@
 				}
 				else
 					ProcessUnknownAttribute(ob);
+#endif
 			}
 
+#if !NET_2_1
 			if (anyAttrMember != null)
 			{
 				anyAttributeArray = ShrinkArray ((Array)anyAttributeArray, anyAttributeIndex, anyAttrMember.TypeData.Type.GetElementType(), true);
 				SetMemberValue (anyAttrMember, ob, anyAttributeArray, isValueList);
 			}
+#endif
 			Reader.MoveToElement ();
 		}
 
@@ -494,9 +506,10 @@
 							SetMemberValue (mem, ob, GetValueFromXmlString (Reader.ReadString(), info.TypeData, info.MappedType), isValueList);
 					}
 				}
+#if !NET_2_1
 				else 
 					UnknownNode(ob);
-
+#endif
 				Reader.MoveToContent();
 			}
 
@@ -779,10 +792,14 @@
 		
 		object ReadXmlNode (TypeData type, bool wrapped)
 		{
+#if NET_2_1
+			throw new NotSupportedException ();
+#else
 			if (type.Type == typeof (XmlDocument))
 				return ReadXmlDocument (wrapped);
 			else
 				return ReadXmlNode (wrapped);
+#endif
 		}
 
 		object ReadPrimitiveElement (XmlTypeMapping typeMap, bool isNullable)
Index: System.Xml.Serialization/XmlMapping.cs
===================================================================
--- System.Xml.Serialization/XmlMapping.cs	(revision 141974)
+++ System.Xml.Serialization/XmlMapping.cs	(working copy)
@@ -39,7 +39,9 @@
 		ObjectMap map;
 		ArrayList relatedMaps;
 		SerializationFormat format;
+#if !NET_2_1
 		SerializationSource source;
+#endif
 		
 		internal string _elementName;
 		internal string _namespace;
@@ -104,11 +106,13 @@
 			set { format = value; }
 		}
 		
+#if !NET_2_1
 		internal SerializationSource Source
 		{
 			get { return source; }
 			set { source = value; }
 		}
+#endif
 	}
 
 	internal class ObjectMap
Index: System.Xml.Serialization/XmlSerializer.cs
===================================================================
--- System.Xml.Serialization/XmlSerializer.cs	(revision 141974)
+++ System.Xml.Serialization/XmlSerializer.cs	(working copy)
@@ -37,7 +37,7 @@
 using System.Xml;
 using System.Xml.Schema;
 using System.Text;
-#if !TARGET_JVM && !MONOTOUCH
+#if !TARGET_JVM && !MONOTOUCH && !NET_2_1
 using System.CodeDom;
 using System.CodeDom.Compiler;
 using Microsoft.CSharp;
@@ -150,7 +150,7 @@
 			}
 #endif
 			deleteTempFiles = (db == null || db == "no");
-#if !MONOTOUCH			
+#if !MONOTOUCH && !NET_2_1
 			IDictionary table = (IDictionary) ConfigurationSettings.GetConfig("system.diagnostics");
 			if (table != null) 
 			{
@@ -249,11 +249,11 @@
 #endregion // Constructors
 
 #region Events
-
+		private UnreferencedObjectEventHandler onUnreferencedObject;
+#if !NET_2_1
 		private XmlAttributeEventHandler onUnknownAttribute;
 		private XmlElementEventHandler onUnknownElement;
 		private XmlNodeEventHandler onUnknownNode;
-		private UnreferencedObjectEventHandler onUnreferencedObject;
 
 		public event XmlAttributeEventHandler UnknownAttribute 
 		{
@@ -270,12 +270,7 @@
 			add { onUnknownNode += value; } remove { onUnknownNode -= value; }
 		}
 
-		public event UnreferencedObjectEventHandler UnreferencedObject 
-		{
-			add { onUnreferencedObject += value; } remove { onUnreferencedObject -= value; }
-		}
 
-
 		internal virtual void OnUnknownAttribute (XmlAttributeEventArgs e) 
 		{
 			if (onUnknownAttribute != null) onUnknownAttribute(this, e);
@@ -291,11 +286,17 @@
 			if (onUnknownNode != null) onUnknownNode(this, e);
 		}
 
+#endif
+
 		internal virtual void OnUnreferencedObject (UnreferencedObjectEventArgs e) 
 		{
 			if (onUnreferencedObject != null) onUnreferencedObject(this, e);
 		}
 
+		public event UnreferencedObjectEventHandler UnreferencedObject 
+		{
+			add { onUnreferencedObject += value; } remove { onUnreferencedObject -= value; }
+		}
 
 #endregion // Events
 
@@ -481,7 +482,7 @@
 			}
 		}
 		
-#if NET_2_0
+#if NET_2_0 && !NET_2_1
 		
 		[MonoTODO]
 		public object Deserialize (XmlReader xmlReader, string encodingStyle, XmlDeserializationEvents events)
@@ -513,7 +514,7 @@
 			throw new NotImplementedException ();
 		}
 
-#if !TARGET_JVM && !MONOTOUCH
+#if !TARGET_JVM && !MONOTOUCH && !NET_2_1
 		public static Assembly GenerateSerializer (Type[] types, XmlMapping[] mappings)
 		{
 			return GenerateSerializer (types, mappings, null);
@@ -572,6 +573,7 @@
 				}
 			}
 			
+#if !NET_2_1
 			if (!typeMapping.Source.CanBeGenerated || generationThreshold == -1)
 				return new XmlSerializationWriterInterpreter (typeMapping);
 
@@ -586,11 +588,13 @@
 					throw new InvalidOperationException ("Error while generating serializer");
 			}
 			
+#endif
 			return new XmlSerializationWriterInterpreter (typeMapping);
 		}
 		
 		XmlSerializationReader CreateReader (XmlMapping typeMapping)
 		{
+#if !NET_2_1
 			XmlSerializationReader reader;
 			
 			lock (this) {
@@ -616,10 +620,11 @@
 					throw new InvalidOperationException ("Error while generating serializer");
 			}
 			
+#endif
 			return new XmlSerializationReaderInterpreter (typeMapping);
 		}
 		
-#if TARGET_JVM || MONOTOUCH
+#if TARGET_JVM || MONOTOUCH || NET_2_1
  		void CheckGeneratedTypes (XmlMapping typeMapping)
  		{
 			throw new NotImplementedException();
Index: System.Xml.Serialization/XmlReflectionMember.cs
===================================================================
--- System.Xml.Serialization/XmlReflectionMember.cs	(revision 141974)
+++ System.Xml.Serialization/XmlReflectionMember.cs	(working copy)
@@ -37,7 +37,9 @@
 		string memberName;
 		Type memberType;
 		bool overrideIsNullable;
+#if !NET_2_1
 		SoapAttributes soapAttributes;
+#endif
 		XmlAttributes xmlAttributes;
 		Type declaringType;
 
@@ -56,12 +58,14 @@
 			xmlAttributes = attributes;
 		}
 
+#if !NET_2_1
 		internal XmlReflectionMember (string name, Type type, SoapAttributes attributes)
 		{
 			memberName = name;
 			memberType = type;
 			soapAttributes = attributes;
 		}
+#endif
 
 		#endregion // Constructors
 
@@ -87,6 +91,7 @@
 			set { overrideIsNullable = value; }
 		}
 
+#if !NET_2_1
 		public SoapAttributes SoapAttributes {
 			get { 
 				if (soapAttributes == null) soapAttributes = new SoapAttributes();
@@ -94,6 +99,7 @@
 			}
 			set { soapAttributes = value; }
 		}
+#endif
 
 		public XmlAttributes XmlAttributes {
 			get { 
@@ -116,8 +122,10 @@
 			KeyHelper.AddField (sb, 1, memberType);
 			KeyHelper.AddField (sb, 1, overrideIsNullable);
 			
+#if !NET_2_1
 			if (soapAttributes != null)
 				soapAttributes.AddKeyHash (sb);
+#endif
 			
 			if (xmlAttributes != null)
 				xmlAttributes.AddKeyHash (sb);
Index: System.Xml.Serialization/XmlReflectionImporter.cs
===================================================================
--- System.Xml.Serialization/XmlReflectionImporter.cs	(revision 141974)
+++ System.Xml.Serialization/XmlReflectionImporter.cs	(working copy)
@@ -161,8 +161,10 @@
 			mps.RelatedMaps = relatedMaps;
 			mps.Format = SerializationFormat.Literal;
 			Type[] extraTypes = includedTypes != null ? (Type[])includedTypes.ToArray(typeof(Type)) : null;
+#if !NET_2_1
 			mps.Source = new MembersSerializationSource (elementName, hasWrapperElement, members, false, true, ns, extraTypes);
 			if (allowPrivateTypes) mps.Source.CanBeGenerated = false;
+#endif
 			return mps;
 		}
 
@@ -230,8 +232,10 @@
 				map.RelatedMaps = relatedMaps;
 				map.Format = SerializationFormat.Literal;
 				Type[] extraTypes = includedTypes != null ? (Type[]) includedTypes.ToArray (typeof (Type)) : null;
+#if !NET_2_1
 				map.Source = new XmlTypeSerializationSource (typeData.Type, root, attributeOverrides, defaultNamespace, extraTypes);
 				if (allowPrivateTypes) map.Source.CanBeGenerated = false;
+#endif
 				return map;
 			} catch (InvalidOperationException ex) {
 				throw new InvalidOperationException (string.Format (CultureInfo.InvariantCulture,
@@ -397,8 +401,10 @@
 				XmlTypeMapMember mem = classMap.XmlTextCollector;
 				if (mem.TypeData.Type != typeof(string) && 
 				   mem.TypeData.Type != typeof(string[]) && 
-				   mem.TypeData.Type != typeof(object[]) && 
-				   mem.TypeData.Type != typeof(XmlNode[]))
+#if !NET_2_1
+				   mem.TypeData.Type != typeof(XmlNode[]) && 
+#endif
+				   mem.TypeData.Type != typeof(object[]))
 				   
 					throw new InvalidOperationException (String.Format (errSimple2, map.TypeData.TypeName, mem.Name, mem.TypeData.TypeName));
 			}
@@ -796,6 +802,7 @@
 					throw new InvalidOperationException ("XmlArrayAttribute can be applied to members of array or collection type.");
 			}
 
+#if !NET_2_1
 			if (atts.XmlAnyAttribute != null)
 			{
 				if ( (rmember.MemberType.FullName == "System.Xml.XmlAttribute[]") ||
@@ -806,7 +813,9 @@
 				else
 					throw new InvalidOperationException ("XmlAnyAttributeAttribute can only be applied to members of type XmlAttribute[] or XmlNode[]");
 			}
-			else if (atts.XmlAnyElements != null && atts.XmlAnyElements.Count > 0)
+			else
+#endif
+			if (atts.XmlAnyElements != null && atts.XmlAnyElements.Count > 0)
 			{
 				if ( (rmember.MemberType.FullName == "System.Xml.XmlElement[]") ||
 					 (rmember.MemberType.FullName == "System.Xml.XmlNode[]") ||
@@ -1029,6 +1038,7 @@
 
 			ImportTextElementInfo (list, rmember.MemberType, member, atts, defaultNamespace);
 
+#if !NET_2_1 // no practical anyElement support
 			foreach (XmlAnyElementAttribute att in atts.XmlAnyElements)
 			{
 				XmlTypeMapElementInfo elem = new XmlTypeMapElementInfo (member, TypeTranslator.GetTypeData(typeof(XmlElement)));
@@ -1046,6 +1056,7 @@
 				}
 				list.Add (elem);
 			}
+#endif
 			return list;
 		}
 
@@ -1061,7 +1072,9 @@
 					}
 					defaultType = atts.XmlText.Type;
 				}
+#if !NET_2_1
 				if (defaultType == typeof(XmlNode)) defaultType = typeof(XmlText);	// Nodes must be text nodes
+#endif
 
 				XmlTypeMapElementInfo elem = new XmlTypeMapElementInfo (member, TypeTranslator.GetTypeData(defaultType, atts.XmlText.DataType));
 
Index: System.Xml.Serialization/XmlMemberMapping.cs
===================================================================
--- System.Xml.Serialization/XmlMemberMapping.cs	(revision 141974)
+++ System.Xml.Serialization/XmlMemberMapping.cs	(working copy)
@@ -127,7 +127,7 @@
 		{
 			get { return _mapMember.Name; }
 		}
-#if !TARGET_JVM	&& !MONOTOUCH
+#if !TARGET_JVM	&& !MONOTOUCH && !NET_2_1
 		public string GenerateTypeName (System.CodeDom.Compiler.CodeDomProvider codeProvider)
 		{
 			string ret = codeProvider.CreateValidIdentifier (_mapMember.TypeData.FullTypeName);
Index: System.Xml.Serialization/XmlAttributes.cs
===================================================================
--- System.Xml.Serialization/XmlAttributes.cs	(revision 141974)
+++ System.Xml.Serialization/XmlAttributes.cs	(working copy)
@@ -40,7 +40,9 @@
 	/// </summary>
 	public class XmlAttributes
 	{
+#if !NET_2_1
 		private XmlAnyAttributeAttribute xmlAnyAttribute;
+#endif
 		private XmlAnyElementAttributes xmlAnyElements = new XmlAnyElementAttributes();
 		private XmlArrayAttribute xmlArray;
 		private XmlArrayItemAttributes xmlArrayItems = new XmlArrayItemAttributes();
@@ -64,9 +66,12 @@
 			object[] attributes = provider.GetCustomAttributes(false);
 			foreach(object obj in attributes)
 			{
+#if !NET_2_1
 				if(obj is XmlAnyAttributeAttribute)
 					xmlAnyAttribute = (XmlAnyAttributeAttribute) obj;
-				else if(obj is XmlAnyElementAttribute)
+				else
+#endif
+				if(obj is XmlAnyElementAttribute)
 					xmlAnyElements.Add((XmlAnyElementAttribute) obj);
 				else if(obj is XmlArrayAttribute)
 					xmlArray = (XmlArrayAttribute) obj;
@@ -96,6 +101,7 @@
 		}
 
 		#region public properties
+#if !NET_2_1
 		public XmlAnyAttributeAttribute XmlAnyAttribute 
 		{
 			get 
@@ -107,6 +113,7 @@
 				xmlAnyAttribute = value;
 			}
 		}
+#endif
 		public XmlAnyElementAttributes XmlAnyElements 
 		{
 			get 
@@ -241,7 +248,9 @@
 			
 			KeyHelper.AddField (sb, 1, xmlIgnore);
 			KeyHelper.AddField (sb, 2, xmlns);
+#if !NET_2_1
 			KeyHelper.AddField (sb, 3, xmlAnyAttribute!=null);
+#endif
 
 			xmlAnyElements.AddKeyHash (sb);
 			xmlArrayItems.AddKeyHash (sb);
Index: System.Xml.Serialization/XmlSerializationWriterInterpreter.cs
===================================================================
--- System.Xml.Serialization/XmlSerializationWriterInterpreter.cs	(revision 141974)
+++ System.Xml.Serialization/XmlSerializationWriterInterpreter.cs	(working copy)
@@ -107,12 +107,14 @@
 				return;
 			}
 
+#if !NET_2_1
 			if (ob is XmlNode)
 			{
 				if (_format == SerializationFormat.Literal) WriteElementLiteral((XmlNode)ob, "", "", true, false);
 				else WriteElementEncoded((XmlNode)ob, "", "", true, false);
 				return;
 			}
+#endif
 
 			if (typeMap.TypeData.SchemaType == SchemaTypes.XmlSerializable)
 			{
@@ -124,6 +126,7 @@
 
 			if (map == null) 
 			{
+#if !NET_2_1
 				// bug #81539
 				if (ob.GetType ().IsArray && typeof (XmlNode).IsAssignableFrom (ob.GetType ().GetElementType ())) {
 					Writer.WriteStartElement (element, namesp);
@@ -132,6 +135,7 @@
 					Writer.WriteEndElement ();
 				}
 				else
+#endif
 					WriteTypedPrimitive (element, namesp, ob, true);
 				return;
 			}
@@ -209,6 +213,7 @@
 			// Write attributes
 
 			XmlTypeMapMember anyAttrMember = map.DefaultAnyAttributeMember;
+#if !NET_2_1
 			if (anyAttrMember != null && MemberHasValue (anyAttrMember, ob, isValueList))
 			{
 				ICollection extraAtts = (ICollection) GetMemberValue (anyAttrMember, ob, isValueList);
@@ -219,6 +224,7 @@
 							WriteXmlAttribute (attr, ob);
 				}
 			}
+#endif
 
 			ICollection attributes = map.AttributeMembers;
 			if (attributes != null)
@@ -303,10 +309,14 @@
 			switch (elem.TypeData.SchemaType)
 			{
 				case SchemaTypes.XmlNode:
+#if NET_2_1
+					throw new NotSupportedException ();
+#else
 					string elemName = elem.WrappedElement ? elem.ElementName : "";
 					if (_format == SerializationFormat.Literal) WriteElementLiteral(((XmlNode)memberValue), elemName, elem.Namespace, elem.IsNullable, false);
 					else WriteElementEncoded(((XmlNode)memberValue), elemName, elem.Namespace, elem.IsNullable, false);
 					break;
+#endif
 
 				case SchemaTypes.Enum:
 				case SchemaTypes.Primitive:
@@ -468,6 +478,9 @@
 
 		void WriteAnyElementContent (XmlTypeMapMemberAnyElement member, object memberValue)
 		{
+#if NET_2_1
+			throw new NotSupportedException ();
+#else
 			if (member.TypeData.Type == typeof (XmlElement)) {
 				memberValue = new object[] { memberValue };
 			}
@@ -488,6 +501,7 @@
 				else
 					elem.WriteTo (Writer);
 			}
+#endif
 		}
 
 		protected virtual void WritePrimitiveElement (XmlTypeMapping typeMap, object ob, string element, string namesp)
Index: System.Xml.Serialization/XmlSerializationReader.cs
===================================================================
--- System.Xml.Serialization/XmlSerializationReader.cs	(revision 141974)
+++ System.Xml.Serialization/XmlSerializationReader.cs	(working copy)
@@ -52,7 +52,9 @@
 
 		#region Fields
 
+#if !NET_2_1
 		XmlDocument document;
+#endif
 		XmlReader reader;
 		ArrayList fixups;
 		Hashtable collFixups;
@@ -115,6 +117,7 @@
 		{
 		}
 
+#if !NET_2_1
 		protected XmlDocument Document
 		{
 			get {
@@ -124,6 +127,7 @@
 				return document;
 			}
 		}
+#endif
 
 		protected XmlReader Reader {
 			get { return reader; }
@@ -383,6 +387,7 @@
 			return name.StartsWith ("xmlns:");
 		}
 
+#if !NET_2_1
 		protected void ParseWsdlArrayType (XmlAttribute attr)
 		{
 			if (attr.NamespaceURI == wsdlNS && attr.LocalName == arrayType)
@@ -393,6 +398,7 @@
 				attr.Value = ns + type + dimensions;
 			}
 		}
+#endif
 
 		protected XmlQualifiedName ReadElementQualifiedName ()
 		{
@@ -436,8 +442,13 @@
 			}
 
 			reader.ReadStartElement();
+#if NET_2_1
 			while (reader.NodeType != XmlNodeType.EndElement)
+				;
+#else
+			while (reader.NodeType != XmlNodeType.EndElement)
 				UnknownNode (null);
+#endif
 
 			ReadEndElement ();
 			return true;
@@ -758,6 +769,11 @@
 			TypeData typeData = TypeTranslator.FindPrimitiveTypeData (qname.Name);
 			if (typeData == null || typeData.SchemaType != SchemaTypes.Primitive)
 			{
+#if NET_2_1
+				// skip everything
+				reader.Skip ();
+				return new Object ();
+#else
 				// Put everything into a node array
 				readCount++;
 				XmlNode node = Document.ReadNode (reader);
@@ -781,6 +797,7 @@
 						nodes[n++] = no;
 					return nodes;
 				}
+#endif
 			}
 
 			if (typeData.Type == typeof (XmlQualifiedName)) return ReadNullableQualifiedName ();
@@ -788,6 +805,7 @@
 			return XmlCustomFormatter.FromXmlString (typeData, Reader.ReadElementString ());
 		}
 
+#if !NET_2_1
 		protected XmlNode ReadXmlNode (bool wrapped)
 		{
 			readCount++;
@@ -814,6 +832,7 @@
 				
 			return doc;
 		}
+#endif
 
 		protected void Referenced (object o)
 		{
@@ -932,6 +951,12 @@
 			return new XmlQualifiedName (name, ns);
 		}
 
+#if NET_2_1
+		protected void UnknownNode (object o)
+		{
+			throw new NotSupportedException ();
+		}
+#else
 		protected void UnknownAttribute (object o, XmlAttribute attr)
 		{
 			UnknownAttribute (o, attr, null);
@@ -1034,6 +1059,7 @@
 					throw new InvalidOperationException ("End of document found");
 			}
 		}
+#endif // !NET_2_1
 
 		protected void UnreferencedObject (string id, object o)
 		{
Index: System.Xml.Serialization/TypeTranslator.cs
===================================================================
--- System.Xml.Serialization/TypeTranslator.cs	(revision 141974)
+++ System.Xml.Serialization/TypeTranslator.cs	(working copy)
@@ -98,16 +98,20 @@
 			nameCache.Add (typeof (decimal), new TypeData (typeof (decimal), "decimal", true));
 			nameCache.Add (typeof (XmlQualifiedName), new TypeData (typeof (XmlQualifiedName), "QName", true));
 			nameCache.Add (typeof (string), new TypeData (typeof (string), "string", true));
+#if !NET_2_1
 			XmlSchemaPatternFacet guidFacet = new XmlSchemaPatternFacet();
 			guidFacet.Value = "[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}";
 			nameCache.Add (typeof (Guid), new TypeData (typeof (Guid), "guid", true, (TypeData)nameCache[typeof (string)], guidFacet));
+#endif
 			nameCache.Add (typeof (byte), new TypeData (typeof (byte), "unsignedByte", true));
 			nameCache.Add (typeof (sbyte), new TypeData (typeof (sbyte), "byte", true));
 			nameCache.Add (typeof (char), new TypeData (typeof (char), "char", true, (TypeData)nameCache[typeof (ushort)], null));
 			nameCache.Add (typeof (object), new TypeData (typeof (object), "anyType", false));
 			nameCache.Add (typeof (byte[]), new TypeData (typeof (byte[]), "base64Binary", true));
+#if !NET_2_1
 			nameCache.Add (typeof (XmlNode), new TypeData (typeof (XmlNode), "XmlNode", false));
 			nameCache.Add (typeof (XmlElement), new TypeData (typeof (XmlElement), "XmlElement", false));
+#endif
 
 			primitiveTypes = new Hashtable();
 			ICollection types = nameCache.Values;
Index: System.Xml.Serialization/XmlSerializationWriter.cs
===================================================================
--- System.Xml.Serialization/XmlSerializationWriter.cs	(revision 141974)
+++ System.Xml.Serialization/XmlSerializationWriter.cs	(working copy)
@@ -297,6 +297,7 @@
 			Writer.WriteAttributeString (prefix, localName, ns, value);
 		}
 
+#if !NET_2_1
 		void WriteXmlNode (XmlNode node)
 		{
 			if (node is XmlDocument)
@@ -344,6 +345,7 @@
 			else
 				WriteXmlNode (node);
 		}
+#endif
 
 		protected void WriteElementQualifiedName (string localName, XmlQualifiedName value)
 		{
@@ -911,6 +913,7 @@
 				Writer.WriteString (value);
 		}
 
+#if !NET_2_1
 		protected void WriteXmlAttribute (XmlNode node)
 		{
 			WriteXmlAttribute (node, null);
@@ -936,6 +939,7 @@
 			
 			WriteAttribute (attr.Prefix, attr.LocalName, attr.NamespaceURI, attr.Value);
 		}
+#endif
 
 		protected void WriteXsiType (string name, string ns)
 		{
