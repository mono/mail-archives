Index: SerializationCodeGenerator.cs
===================================================================
--- SerializationCodeGenerator.cs	(revision 38760)
+++ SerializationCodeGenerator.cs	(working copy)
@@ -418,6 +418,7 @@
 			else
 				WriteLine ("internal class " + writerClassName + " : XmlSerializationWriter");
 			WriteLineInd ("{");
+			WriteLine ("const string xmlNamespace = \"http://www.w3.org/2000/xmlns/\";");
 			
 			for (int n=0; n<maps.Count; n++)
 			{
@@ -670,28 +671,7 @@
 					WriteLine ("WriteNamespaceDeclarations ((XmlSerializerNamespaces) " + ob + ".@" + map.NamespaceDeclarations.Name + ");");
 					WriteLine ("");
 				}
-				
-				ICollection attributes = map.AttributeMembers;
-				if (attributes != null)
-				{
-					foreach (XmlTypeMapMemberAttribute attr in attributes) 
-					{
-						if (GenerateWriteMemberHook (xmlMapType, attr)) continue;
-					
-						string val = GenerateGetMemberValue (attr, ob, isValueList);
-						string cond = GenerateMemberHasValueCondition (attr, ob, isValueList);
-						
-						if (cond != null) WriteLineInd ("if (" + cond + ") {");
-						
-						string strVal = GenerateGetStringValue (attr.MappedType, attr.TypeData, val);
-						WriteLine ("WriteAttribute (" + GetLiteral(attr.AttributeName) + ", " + GetLiteral(attr.Namespace) + ", " + strVal + ");");
 	
-						if (cond != null) WriteLineUni ("}");
-						GenerateEndHook ();
-					}
-					WriteLine ("");
-				}
-	
 				XmlTypeMapMember anyAttrMember = map.DefaultAnyAttributeMember;
 				if (anyAttrMember != null) 
 				{
@@ -706,8 +686,10 @@
 		
 						string tmpVar2 = GetObTempVar ();
 						WriteLineInd ("foreach (XmlAttribute " + tmpVar2 + " in " + tmpVar + ")");
+						WriteLineInd ("if (" + tmpVar2 + ".NamespaceURI != xmlNamespace)");
 						WriteLine ("WriteXmlAttribute (" + tmpVar2 + ", " + ob + ");");
 						Unindent ();
+						Unindent ();
 						WriteLineUni ("}");
 		
 						if (cond != null) WriteLineUni ("}");
@@ -715,6 +697,27 @@
 						GenerateEndHook ();
 					}
 				}
+				
+				ICollection attributes = map.AttributeMembers;
+				if (attributes != null)
+				{
+					foreach (XmlTypeMapMemberAttribute attr in attributes) 
+					{
+						if (GenerateWriteMemberHook (xmlMapType, attr)) continue;
+					
+						string val = GenerateGetMemberValue (attr, ob, isValueList);
+						string cond = GenerateMemberHasValueCondition (attr, ob, isValueList);
+						
+						if (cond != null) WriteLineInd ("if (" + cond + ") {");
+						
+						string strVal = GenerateGetStringValue (attr.MappedType, attr.TypeData, val);
+						WriteLine ("WriteAttribute (" + GetLiteral(attr.AttributeName) + ", " + GetLiteral(attr.Namespace) + ", " + strVal + ");");
+	
+						if (cond != null) WriteLineUni ("}");
+						GenerateEndHook ();
+					}
+					WriteLine ("");
+				}
 				GenerateEndHook ();
 			}
 			
Index: XmlSerializationWriterInterpreter.cs
===================================================================
--- XmlSerializationWriterInterpreter.cs	(revision 38759)
+++ XmlSerializationWriterInterpreter.cs	(working copy)
@@ -40,6 +40,7 @@
 	{
 		XmlMapping _typeMap;
 		SerializationFormat _format;
+		const string xmlNamespace = "http://www.w3.org/2000/xmlns/";
 
 		public XmlSerializationWriterInterpreter (XmlMapping typeMap)
 		{
@@ -199,15 +200,6 @@
 		{
 			// Write attributes
 
-			ICollection attributes = map.AttributeMembers;
-			if (attributes != null)
-			{
-				foreach (XmlTypeMapMemberAttribute attr in attributes) {
-					if (MemberHasValue (attr, ob, isValueList))
-						WriteAttribute (attr.AttributeName, attr.Namespace, GetStringValue (attr.MappedType, attr.TypeData, GetMemberValue (attr, ob, isValueList)));
-				}
-			}
-
 			XmlTypeMapMember anyAttrMember = map.DefaultAnyAttributeMember;
 			if (anyAttrMember != null && MemberHasValue (anyAttrMember, ob, isValueList))
 			{
@@ -215,9 +207,19 @@
 				if (extraAtts != null) 
 				{
 					foreach (XmlAttribute attr in extraAtts)
-						WriteXmlAttribute (attr, ob);
+						if (attr.NamespaceURI != xmlNamespace)
+							WriteXmlAttribute (attr, ob);
 				}
 			}
+
+			ICollection attributes = map.AttributeMembers;
+			if (attributes != null)
+			{
+				foreach (XmlTypeMapMemberAttribute attr in attributes) {
+					if (MemberHasValue (attr, ob, isValueList))
+						WriteAttribute (attr.AttributeName, attr.Namespace, GetStringValue (attr.MappedType, attr.TypeData, GetMemberValue (attr, ob, isValueList)));
+				}
+			}
 		}
 
 		void WriteElementMembers (ClassMap map, object ob, bool isValueList)
