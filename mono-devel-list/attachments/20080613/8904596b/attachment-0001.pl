Index: Test/System.Data/DataTableTest.cs
===================================================================
--- Test/System.Data/DataTableTest.cs	(revision 105755)
+++ Test/System.Data/DataTableTest.cs	(working copy)
@@ -724,6 +724,7 @@
 				Assert.Fail ("test#07");
 			} catch (Exception e) {
 				Assert.AreEqual (typeof (EvaluateException), e.GetType (), "test#08");
+				// Do not compare exception messages!
 				//Assert.AreEqual ("The table [Child] involved in more than one relation. You must explicitly mention a relation name in the expression 'parent.[ChildName]'.", e.Message, "test#09");
 			}
 			
@@ -737,7 +738,8 @@
 			     	Mom.Select ("Parent.name  = 'John'");
 			} catch (Exception e) {
 				Assert.AreEqual (typeof (IndexOutOfRangeException), e.GetType (), "test#11");
-				Assert.AreEqual ("Cannot find relation 0.", e.Message, "test#12");
+				// Do not compare exception messages!
+				//Assert.AreEqual ("Cannot find relation 0.", e.Message, "test#12");
 			}
 			
 		}
@@ -797,7 +799,8 @@
 				Assert.Fail ("test#05");					
 			} catch (Exception e) {
 				Assert.AreEqual (typeof (ArgumentException), e.GetType (), "test#06");
-				Assert.AreEqual ("Column must belong to a table.", e.Message, "test#07");
+				// Never expect English message
+				// Assert.AreEqual ("Column must belong to a table.", e.Message, "test#07");
 			}
 			
 			DataTable dt2 = new DataTable ();
@@ -808,7 +811,8 @@
 				Assert.Fail ("test#08");
 			} catch (Exception e) {
 				Assert.AreEqual (typeof (ArgumentException), e.GetType (), "test#09");
-				Assert.AreEqual ("PrimaryKey columns do not belong to this table.", e.Message, "test#10");
+				// Never expect English message
+				// Assert.AreEqual ("PrimaryKey columns do not belong to this table.", e.Message, "test#10");
 			}
 			
 			
@@ -864,7 +868,8 @@
 			}
 			catch (Exception e) {
 				if (e.GetType () != typeof (AssertionException))
-					Assert.AreEqual ("Cannot change CaseSensitive or Locale property. This change would lead to at least one DataRelation or Constraint to have different Locale or CaseSensitive settings between its related tables.", e.Message, "#A02");
+					// Never expect English message
+					throw;// Assert.AreEqual ("Cannot change CaseSensitive or Locale property. This change would lead to at least one DataRelation or Constraint to have different Locale or CaseSensitive settings between its related tables.", e.Message, "#A02");
 				else
 					Console.WriteLine (e);
 			}
@@ -876,7 +881,8 @@
 			}
 			catch (Exception e) {
 				 if (e.GetType () != typeof (AssertionException))
-					Assert.AreEqual ("Cannot change CaseSensitive or Locale property. This change would lead to at least one DataRelation or Constraint to have different Locale or CaseSensitive settings between its related tables.", e.Message, "#A04");
+					// Never expect English message
+					throw;// Assert.AreEqual ("Cannot change CaseSensitive or Locale property. This change would lead to at least one DataRelation or Constraint to have different Locale or CaseSensitive settings between its related tables.", e.Message, "#A04");
 				else
 					Console.WriteLine (e);
 			}
@@ -886,7 +892,8 @@
 			}
 			catch (Exception e){
 				if (e.GetType () != typeof (AssertionException))
-					Assert.AreEqual ("Prefix 'Prefix#1' is not valid, because it contains special characters.",e.Message, "#A06");
+					// Never expect English message
+					throw;//Assert.AreEqual ("Prefix 'Prefix#1' is not valid, because it contains special characters.",e.Message, "#A06");
 				else
 					Console.WriteLine (e);
 
@@ -3075,7 +3082,7 @@
 
 			substring = TextString.Substring (0, TextString.IndexOf (EOL));
 			TextString = TextString.Substring (TextString.IndexOf (EOL) + EOL.Length);
-			Assert.AreEqual ("  <xs:element msdata:IsDataSet=\"true\" msdata:MainDataTable=\"Region\" msdata:UseCurrentLocale=\"true\" name=\"Root\">", substring, "test#03");
+			Assert.AreEqual ("  <xs:element msdata:IsDataSet=\"true\" msdata:Locale=\"en-US\" msdata:MainDataTable=\"Region\" name=\"Root\">", substring, "test#03");
 
 			substring = TextString.Substring (0, TextString.IndexOf (EOL));
 			TextString = TextString.Substring (TextString.IndexOf (EOL) + EOL.Length);
@@ -3564,7 +3571,7 @@
 		[Test]
 		[Category ("NotWorking")]
 		public void WriteXmlSchema_DifferentNamespace () {
-			string schema = @"<?xml version='1.0' encoding='utf-16'?>\n<xs:schema id='NewDataSet' targetNamespace='urn:bar' xmlns:mstns='urn:bar' xmlns='urn:bar' xmlns:xs='http://www.w3.org/2001/XMLSchema' xmlns:msdata='urn:schemas-microsoft-com:xml-msdata' attributeFormDefault='qualified' elementFormDefault='qualified' xmlns:app1='urn:baz' xmlns:app2='urn:foo' msdata:schemafragmentcount='3'>
+			string schema = @"<xs:schema id='NewDataSet' targetNamespace='urn:bar' xmlns:mstns='urn:bar' xmlns='urn:bar' xmlns:xs='http://www.w3.org/2001/XMLSchema' xmlns:msdata='urn:schemas-microsoft-com:xml-msdata' attributeFormDefault='qualified' elementFormDefault='qualified' xmlns:app1='urn:baz' xmlns:app2='urn:foo' msdata:schemafragmentcount='3'>
   <xs:import namespace='urn:foo' />
   <xs:import namespace='urn:baz' />
   <xs:element name='NewDataSet' msdata:IsDataSet='true' msdata:MainDataTable='urn_x003A_foo_x003A_NS1Table' msdata:UseCurrentLocale='true'>
@@ -3612,7 +3619,7 @@
 			xw1.QuoteChar = '\'';
 			ds.Tables[0].WriteXmlSchema (xw1);
 			string result1 = sw1.ToString ();
-			Assert.AreEqual (schema, result1, "#1");
+			Assert.AreEqual (schema, result1.Replace ("\r\n", "\n"), "#1");
 
 			StringWriter sw2 = new StringWriter ();
 			XmlTextWriter xw2 = new XmlTextWriter (sw2);
@@ -3620,7 +3627,7 @@
 			xw2.QuoteChar = '\'';
 			ds.Tables[0].WriteXmlSchema (xw2);
 			string result2 = sw2.ToString ();
-			Assert.AreEqual (schema, result2, "#2");
+			Assert.AreEqual (schema, result2.Replace ("\r\n", "\n"), "#2");
 		}
 
 		[Test]
@@ -3686,7 +3693,7 @@
   @"<xs:complexType name=""bookstoreType"">" +
   @"</xs:complexType>" +
   @"<xs:element name=""bookstore"" type=""bookstoreType"" />" +
-  @"<xs:element name=""Root"" msdata:IsDataSet=""true"" msdata:MainDataTable=""bookstore"" msdata:UseCurrentLocale=""true"">" +
+  @"<xs:element name=""Root"" msdata:IsDataSet=""true"" msdata:MainDataTable=""bookstore"" msdata:Locale=""en-US"">" +
     @"<xs:complexType>" +
       @"<xs:choice minOccurs=""0"" maxOccurs=""unbounded"">" +
     @"<xs:element ref=""bookstore"" />" +
@@ -3711,7 +3718,7 @@
     @"<xs:attribute name=""bookstore_Id"" type=""xs:int"" use=""prohibited"" />" +
   @"</xs:complexType>" +
   @"<xs:element name=""book"" type=""bookType"" />" +
-  @"<xs:element name=""Root"" msdata:IsDataSet=""true"" msdata:MainDataTable=""book"" msdata:UseCurrentLocale=""true"">" +
+  @"<xs:element name=""Root"" msdata:IsDataSet=""true"" msdata:MainDataTable=""book"" msdata:Locale=""en-US"">" +
     @"<xs:complexType>" +
       @"<xs:choice minOccurs=""0"" maxOccurs=""unbounded"">" +
     @"<xs:element ref=""book"" />" +
@@ -3735,7 +3742,7 @@
     @"<xs:attribute name=""book_Id"" type=""xs:int"" use=""prohibited"" />" +
   @"</xs:complexType>" +
   @"<xs:element name=""author"" type=""authorName"" />" +
-  @"<xs:element name=""Root"" msdata:IsDataSet=""true"" msdata:MainDataTable=""author"" msdata:UseCurrentLocale=""true"">" +
+  @"<xs:element name=""Root"" msdata:IsDataSet=""true"" msdata:MainDataTable=""author"" msdata:Locale=""en-US"">" +
     @"<xs:complexType>" +
       @"<xs:choice minOccurs=""0"" maxOccurs=""unbounded"">" +
         @"<xs:element ref=""author"" />" +
@@ -3751,7 +3758,7 @@
 			string TextString4 = writer4.ToString();
 			string expected4 = @"<?xml version=""1.0"" encoding=""utf-16""?>" +
 @"<xs:schema id=""Root"" xmlns="""" xmlns:xs=""http://www.w3.org/2001/XMLSchema"" xmlns:msdata=""urn:schemas-microsoft-com:xml-msdata"">" +
-  @"<xs:element name=""Root"" msdata:IsDataSet=""true"" msdata:MainDataTable=""Region"" msdata:UseCurrentLocale=""true"">" +
+  @"<xs:element name=""Root"" msdata:IsDataSet=""true"" msdata:MainDataTable=""Region"" msdata:Locale=""en-US"">" +
     @"<xs:complexType>" +
       @"<xs:choice minOccurs=""0"" maxOccurs=""unbounded"">" +
         @"<xs:element name=""Region"">" +
@@ -3812,19 +3819,19 @@
 			ds.Tables[1].WriteXmlSchema (writer2, false);
 			string TextString2 = GetNormalizedSchema (writer2.ToString ());
 			string expected2 = @"<?xml version=""1.0"" encoding=""utf-16""?>" +
-@"<xs:schema id=""NewDataSet"" xmlns="""" xmlns:xs=""http://www.w3.org/2001/XMLSchema"" xmlns:msdata=""urn:schemas-microsoft-com:xml-msdata"">" +
+@"<xs:schema id=""NewDataSet"" xmlns:msdata=""urn:schemas-microsoft-com:xml-msdata"" xmlns:xs=""http://www.w3.org/2001/XMLSchema"">" +
   @"<xs:complexType name=""bookType"">" +
     @"<xs:sequence>" +
-      @"<xs:element name=""title"" type=""xs:string"" msdata:Ordinal=""1"" />" +
-      @"<xs:element name=""price"" type=""xs:decimal"" msdata:Ordinal=""2"" />" +
+      @"<xs:element msdata:Ordinal=""1"" name=""title"" type=""xs:string"" />" +
+      @"<xs:element msdata:Ordinal=""2"" name=""price"" type=""xs:decimal"" />" +
     @"</xs:sequence>" +
     @"<xs:attribute name=""genre"" type=""xs:string"" />" +
     @"<xs:attribute name=""bookstore_Id"" type=""xs:int"" use=""prohibited"" />" +
   @"</xs:complexType>" +
   @"<xs:element name=""book"" type=""bookType"" />" +
-  @"<xs:element name=""NewDataSet"" msdata:IsDataSet=""true"" msdata:MainDataTable=""book"" msdata:UseCurrentLocale=""true"">" +
+  @"<xs:element msdata:IsDataSet=""true"" msdata:MainDataTable=""book"" msdata:UseCurrentLocale=""true"" name=""NewDataSet"">" +
     @"<xs:complexType>" +
-      @"<xs:choice minOccurs=""0"" maxOccurs=""unbounded"">" +
+      @"<xs:choice maxOccurs=""unbounded"" minOccurs=""0"">" +
 	@"<xs:element ref=""book"" />" +
       @"</xs:choice>" +
     @"</xs:complexType>" +
@@ -3836,18 +3843,18 @@
 			ds.Tables[2].WriteXmlSchema (writer3);
 			string TextString3 = GetNormalizedSchema (writer3.ToString ());
 			string expected3 = @"<?xml version=""1.0"" encoding=""utf-16""?>" +
-@"<xs:schema id=""NewDataSet"" xmlns="""" xmlns:xs=""http://www.w3.org/2001/XMLSchema"" xmlns:msdata=""urn:schemas-microsoft-com:xml-msdata"">" +
+@"<xs:schema id=""NewDataSet"" xmlns:msdata=""urn:schemas-microsoft-com:xml-msdata"" xmlns:xs=""http://www.w3.org/2001/XMLSchema"">" +
   @"<xs:complexType name=""authorName"">" +
     @"<xs:sequence>" +
-      @"<xs:element name=""first-name"" type=""xs:string"" msdata:Ordinal=""0"" />" +
-      @"<xs:element name=""last-name"" type=""xs:string"" msdata:Ordinal=""1"" />" +
+      @"<xs:element msdata:Ordinal=""0"" name=""first-name"" type=""xs:string"" />" +
+      @"<xs:element msdata:Ordinal=""1"" name=""last-name"" type=""xs:string"" />" +
     @"</xs:sequence>" +
     @"<xs:attribute name=""book_Id"" type=""xs:int"" use=""prohibited"" />" +
   @"</xs:complexType>" +
   @"<xs:element name=""author"" type=""authorName"" />" +
-  @"<xs:element name=""NewDataSet"" msdata:IsDataSet=""true"" msdata:MainDataTable=""author"" msdata:UseCurrentLocale=""true"">" +
+  @"<xs:element msdata:IsDataSet=""true"" msdata:MainDataTable=""author"" msdata:UseCurrentLocale=""true"" name=""NewDataSet"">" +
     @"<xs:complexType>" +
-      @"<xs:choice minOccurs=""0"" maxOccurs=""unbounded"">" +
+      @"<xs:choice maxOccurs=""unbounded"" minOccurs=""0"">" +
 	@"<xs:element ref=""author"" />" +
       @"</xs:choice>" +
     @"</xs:complexType>" +
@@ -3856,14 +3863,15 @@
 			Assert.AreEqual (expected3, TextString3.Replace ("\r\n", "").Replace ("  ", ""), "#3");
 
 			TextWriter writer4 = new StringWriter ();
-			string expStr = "";
+			//string expStr = "";
 			try {
 				ds.Tables[3].WriteXmlSchema (writer4);
+				Assert.Fail ("expected exception");
 			}
 			catch (Exception ex) {
-				expStr = ex.Message;
+			//	expStr = ex.Message;
 			}
-			Assert.AreEqual ("Cannot find table 3.", expStr, "#4");
+			//Assert.AreEqual ("Cannot find table 3.", expStr, "#4");
 		}
 
 		[Test]
Index: Test/System.Data/TestFile3.xml
===================================================================
--- Test/System.Data/TestFile3.xml	(revision 105755)
+++ Test/System.Data/TestFile3.xml	(working copy)
@@ -1,27 +1,27 @@
-﻿<?xml version="1.0" encoding="utf-8"?>
-<xs:schema id="XmlSchemaDataSet" xmlns="" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:msdata="urn:schemas-microsoft-com:xml-msdata">
-  <xs:element name="XmlSchemaDataSet" msdata:IsDataSet="true" msdata:MainDataTable="ParentTable" msdata:UseCurrentLocale="true">
-    <xs:complexType>
-      <xs:choice minOccurs="0" maxOccurs="unbounded">
-        <xs:element name="ParentTable">
-          <xs:complexType>
-            <xs:sequence>
-              <xs:element name="id" type="xs:int" />
-              <xs:element name="ParentItem" type="xs:string" minOccurs="0" />
-              <xs:element name="DepartmentID" type="xs:int" />
-            </xs:sequence>
-          </xs:complexType>
-        </xs:element>
-      </xs:choice>
-    </xs:complexType>
-    <xs:unique name="Constraint1">
-      <xs:selector xpath=".//ParentTable" />
-      <xs:field xpath="id" />
-    </xs:unique>
-    <xs:unique name="Constraint2" msdata:PrimaryKey="true">
-      <xs:selector xpath=".//ParentTable" />
-      <xs:field xpath="id" />
-      <xs:field xpath="DepartmentID" />
-    </xs:unique>
-  </xs:element>
+﻿<?xml version="1.0" encoding="utf-8"?>
+<xs:schema id="XmlSchemaDataSet" xmlns="" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:msdata="urn:schemas-microsoft-com:xml-msdata">
+  <xs:element name="XmlSchemaDataSet" msdata:IsDataSet="true" msdata:MainDataTable="ParentTable" msdata:UseCurrentLocale="true">
+    <xs:complexType>
+      <xs:choice minOccurs="0" maxOccurs="unbounded">
+        <xs:element name="ParentTable">
+          <xs:complexType>
+            <xs:sequence>
+              <xs:element name="id" type="xs:int" />
+              <xs:element name="ParentItem" type="xs:string" minOccurs="0" />
+              <xs:element name="DepartmentID" type="xs:int" />
+            </xs:sequence>
+          </xs:complexType>
+        </xs:element>
+      </xs:choice>
+    </xs:complexType>
+    <xs:unique name="Constraint1">
+      <xs:selector xpath=".//ParentTable" />
+      <xs:field xpath="id" />
+    </xs:unique>
+    <xs:unique name="Constraint2" msdata:PrimaryKey="true">
+      <xs:selector xpath=".//ParentTable" />
+      <xs:field xpath="id" />
+      <xs:field xpath="DepartmentID" />
+    </xs:unique>
+  </xs:element>
 </xs:schema>
\ No newline at end of file
Index: Test/System.Data/TestFile5.xml
===================================================================
--- Test/System.Data/TestFile5.xml	(revision 105755)
+++ Test/System.Data/TestFile5.xml	(working copy)
@@ -1,111 +1 @@
-﻿<NewDataSet>
-  <xs:schema id="NewDataSet" xmlns="" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:msdata="urn:schemas-microsoft-com:xml-msdata">
-    <xs:element name="NewDataSet" msdata:IsDataSet="true" msdata:MainDataTable="Parent" msdata:UseCurrentLocale="true">
-      <xs:complexType>
-        <xs:choice minOccurs="0" maxOccurs="unbounded">
-          <xs:element name="Parent">
-            <xs:complexType>
-              <xs:sequence>
-                <xs:element name="col1" type="xs:int" minOccurs="0" />
-                <xs:element name="col2" type="xs:string" minOccurs="0" />
-              </xs:sequence>
-            </xs:complexType>
-          </xs:element>
-          <xs:element name="Child1">
-            <xs:complexType>
-              <xs:sequence>
-                <xs:element name="col3" type="xs:int" minOccurs="0" />
-                <xs:element name="col4" type="xs:string" minOccurs="0" />
-                <xs:element name="col5" type="xs:int" minOccurs="0" />
-              </xs:sequence>
-            </xs:complexType>
-          </xs:element>
-          <xs:element name="Child2">
-            <xs:complexType>
-              <xs:sequence>
-                <xs:element name="col6" type="xs:int" minOccurs="0" />
-                <xs:element name="col7" type="xs:string" minOccurs="0" />
-              </xs:sequence>
-            </xs:complexType>
-          </xs:element>
-        </xs:choice>
-      </xs:complexType>
-      <xs:unique name="Constraint1">
-        <xs:selector xpath=".//Parent" />
-        <xs:field xpath="col1" />
-      </xs:unique>
-      <xs:unique name="Child1_Constraint1" msdata:ConstraintName="Constraint1">
-        <xs:selector xpath=".//Child1" />
-        <xs:field xpath="col5" />
-      </xs:unique>
-      <xs:keyref name="Relation1" refer="Constraint1">
-        <xs:selector xpath=".//Child1" />
-        <xs:field xpath="col3" />
-      </xs:keyref>
-      <xs:keyref name="Relation2" refer="Child1_Constraint1">
-        <xs:selector xpath=".//Child2" />
-        <xs:field xpath="col6" />
-      </xs:keyref>
-    </xs:element>
-  </xs:schema>
-  <Parent>
-    <col1>1</col1>
-    <col2>P_</col2>
-  </Parent>
-  <Parent>
-    <col1>2</col1>
-    <col2>P_</col2>
-  </Parent>
-  <Child1>
-    <col3>1</col3>
-    <col4>C1_</col4>
-    <col5>3</col5>
-  </Child1>
-  <Child1>
-    <col3>1</col3>
-    <col4>C1_</col4>
-    <col5>4</col5>
-  </Child1>
-  <Child1>
-    <col3>2</col3>
-    <col4>C1_</col4>
-    <col5>5</col5>
-  </Child1>
-  <Child1>
-    <col3>2</col3>
-    <col4>C1_</col4>
-    <col5>6</col5>
-  </Child1>
-  <Child2>
-    <col6>3</col6>
-    <col7>C2_</col7>
-  </Child2>
-  <Child2>
-    <col6>3</col6>
-    <col7>C2_</col7>
-  </Child2>
-  <Child2>
-    <col6>4</col6>
-    <col7>C2_</col7>
-  </Child2>
-  <Child2>
-    <col6>4</col6>
-    <col7>C2_</col7>
-  </Child2>
-  <Child2>
-    <col6>5</col6>
-    <col7>C2_</col7>
-  </Child2>
-  <Child2>
-    <col6>5</col6>
-    <col7>C2_</col7>
-  </Child2>
-  <Child2>
-    <col6>6</col6>
-    <col7>C2_</col7>
-  </Child2>
-  <Child2>
-    <col6>6</col6>
-    <col7>C2_</col7>
-  </Child2>
-</NewDataSet>
\ No newline at end of file
+﻿<?xml version="1.0" encoding="utf-8"?><start><xs:schema id="NewDataSet" xmlns="" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:msdata="urn:schemas-microsoft-com:xml-msdata"><xs:element name="NewDataSet" msdata:IsDataSet="true" msdata:MainDataTable="Parent" msdata:UseCurrentLocale="true"><xs:complexType><xs:choice minOccurs="0" maxOccurs="unbounded"><xs:element name="Parent"><xs:complexType><xs:sequence><xs:element name="col1" type="xs:int" minOccurs="0" /><xs:element name="col2" type="xs:string" minOccurs="0" /></xs:sequence></xs:complexType></xs:element></xs:choice></xs:complexType><xs:unique name="Constraint1"><xs:selector xpath=".//Parent" /><xs:field xpath="col1" /></xs:unique></xs:element></xs:schema><diffgr:diffgram xmlns:msdata="urn:schemas-microsoft-com:xml-msdata" xmlns:diffgr="urn:schemas-microsoft-com:xml-diffgram-v1"><NewDataSet><Parent diffgr:id="Parent1" msdata:rowOrder="0" diffgr:hasChanges="inserted"><col1>1</col1><col2>P_</col2></Parent><Parent diffgr:id="Parent2" msdata:rowOrder="1" diffgr:hasChanges="inserted"><col1>2</col1><col2>P_</col2></Parent></NewDataSet></diffgr:diffgram></start>
\ No newline at end of file