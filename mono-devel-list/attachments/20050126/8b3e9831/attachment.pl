Index: XmlSerializationReaderInterpreter.cs
===================================================================
--- XmlSerializationReaderInterpreter.cs	(revision 39533)
+++ XmlSerializationReaderInterpreter.cs	(working copy)
@@ -178,7 +178,7 @@
 				case SchemaTypes.Primitive: return ReadPrimitiveElement (typeMap, isNullable);
 				case SchemaTypes.Enum: return ReadEnumElement (typeMap, isNullable);
 				case SchemaTypes.XmlSerializable: return ReadXmlSerializableElement (typeMap, isNullable);
-				default: throw new Exception ("Unsupported map type");
+				default: throw new SystemException ("Unsupported map type");
 			}
 		}
 
Index: SerializationCodeGenerator.cs
===================================================================
--- SerializationCodeGenerator.cs	(revision 39533)
+++ SerializationCodeGenerator.cs	(working copy)
@@ -1043,7 +1043,7 @@
 				WriteLineUni ("}");
 			}
 			else
-				throw new Exception ("Unsupported collection type");
+				throw new SystemException ("Unsupported collection type");
 
 			return targetString;
 		}
@@ -1263,7 +1263,7 @@
 				if (_format == SerializationFormat.Literal)
 				{
 					if (typeMap.TypeData.SchemaType == SchemaTypes.XmlNode)
-						throw new Exception ("Not supported for XmlNode types");
+						throw new SystemException ("Not supported for XmlNode types");
 						
 //					Console.WriteLine ("This should be string:" + typeMap.ElementName.GetType());
 					WriteLineInd ("if (Reader.LocalName != " + GetLiteral (typeMap.ElementName) + " || Reader.NamespaceURI != " + GetLiteral (typeMap.Namespace) + ")");
@@ -1392,7 +1392,7 @@
 				case SchemaTypes.Primitive: GenerateReadPrimitiveElement (typeMap, isNullable); break;
 				case SchemaTypes.Enum: GenerateReadEnumElement (typeMap, isNullable); break;
 				case SchemaTypes.XmlSerializable: GenerateReadXmlSerializableElement (typeMap, isNullable); break;
-				default: throw new Exception ("Unsupported map type");
+				default: throw new SystemException ("Unsupported map type");
 			}
 			
 			WriteLineUni ("}");
Index: XmlReflectionImporter.cs
===================================================================
--- XmlReflectionImporter.cs	(revision 39533)
+++ XmlReflectionImporter.cs	(working copy)
@@ -717,7 +717,7 @@
 				// An attribute
 
 				if (atts.XmlElements != null && atts.XmlElements.Count > 0)
-					throw new Exception ("XmlAttributeAttribute and XmlElementAttribute cannot be applied to the same member");
+					throw new SystemException ("XmlAttributeAttribute and XmlElementAttribute cannot be applied to the same member");
 
 				XmlTypeMapMemberAttribute mapAttribute = new XmlTypeMapMemberAttribute ();
 				if (atts.XmlAttribute.AttributeName == null) 
Index: SoapReflectionImporter.cs
===================================================================
--- SoapReflectionImporter.cs	(revision 39533)
+++ SoapReflectionImporter.cs	(working copy)
@@ -397,7 +397,7 @@
 				// An attribute
 
 				if (atts.SoapElement != null)
-					throw new Exception ("SoapAttributeAttribute and SoapElementAttribute cannot be applied to the same member");
+					throw new SystemException ("SoapAttributeAttribute and SoapElementAttribute cannot be applied to the same member");
 
 				XmlTypeMapMemberAttribute mapAttribute = new XmlTypeMapMemberAttribute ();
 				if (atts.SoapAttribute.AttributeName == null) 
Index: XmlAttributeOverrides.cs
===================================================================
--- XmlAttributeOverrides.cs	(revision 39533)
+++ XmlAttributeOverrides.cs	(working copy)
@@ -68,7 +68,7 @@
 		public void Add (Type type, string member, XmlAttributes attributes) 
 		{
 			if(overrides[GetKey(type, member)] != null)
-				throw new Exception("The attributes for the given type and Member already exist in the collection");
+				throw new SystemException("The attributes for the given type and Member already exist in the collection");
 			
 			overrides.Add(GetKey(type,member), attributes);
 		}
Index: SoapAttributeOverrides.cs
===================================================================
--- SoapAttributeOverrides.cs	(revision 39533)
+++ SoapAttributeOverrides.cs	(working copy)
@@ -79,7 +79,7 @@
 		public void Add (Type type, string member, SoapAttributes attributes) 
 		{
 			if(overrides[GetKey(type, member)] != null)
-				throw new Exception("The attributes for the given type and Member already exist in the collection");
+				throw new SystemException("The attributes for the given type and Member already exist in the collection");
 			
 			overrides.Add(GetKey(type,member), attributes);
 		}
Index: XmlSerializationWriterInterpreter.cs
===================================================================
--- XmlSerializationWriterInterpreter.cs	(revision 39533)
+++ XmlSerializationWriterInterpreter.cs	(working copy)
@@ -426,7 +426,7 @@
 				}
 			}
 			else
-				throw new Exception ("Unsupported collection type");
+				throw new SystemException ("Unsupported collection type");
 		}
 
 		int GetListCount (TypeData listType, object ob)