Index: Test/System.Data/TestMerge1.xml
===================================================================
--- Test/System.Data/TestMerge1.xml	(revision 0)
+++ Test/System.Data/TestMerge1.xml	(revision 0)
@@ -0,0 +1,64 @@
+<MyDataSet>
+  <xs:schema id="MyDataSet" xmlns="" xmlns:xs="http://www.w3.org/2001/XMLSchema"
+ xmlns:msdata="urn:schemas-microsoft-com:xml-msdata">
+    <xs:element name="MyDataSet" msdata:IsDataSet="true" msdata:MainDataTable="Main" msdata:UseCurrentLocale="true">
+      <xs:complexType>
+        <xs:choice minOccurs="0" maxOccurs="unbounded">
+          <xs:element name="Main">
+            <xs:complexType>
+              <xs:sequence>
+                <xs:element name="ID" type="xs:int" minOccurs="0" />
+                <xs:element name="Data" type="xs:string" minOccurs="0" />
+              </xs:sequence>
+            </xs:complexType>
+          </xs:element>
+          <xs:element name="Child">
+            <xs:complexType>
+              <xs:sequence>
+                <xs:element name="ID" type="xs:int" minOccurs="0" />
+                <xs:element name="PID" type="xs:int" minOccurs="0" />
+                <xs:element name="ChildData" type="xs:string" minOccurs="0" />
+              </xs:sequence>
+            </xs:complexType>
+          </xs:element>
+        </xs:choice>
+      </xs:complexType>
+      <xs:unique name="Constraint1">
+        <xs:selector xpath=".//Main" />
+        <xs:field xpath="ID" />
+      </xs:unique>
+      <xs:keyref name="MainToChild" refer="Constraint1">
+        <xs:selector xpath=".//Child" />
+        <xs:field xpath="PID" />
+      </xs:keyref>
+    </xs:element>
+  </xs:schema>
+  <Main>
+    <ID>1</ID>
+    <Data>One</Data>
+  </Main>
+  <Main>
+    <ID>2</ID>
+    <Data>Two</Data>
+  </Main>
+  <Main>
+    <ID>3</ID>
+    <Data>Three</Data>
+  </Main>
+  <Child>
+    <ID>1</ID>
+    <PID>1</PID>
+    <ChildData>Parent1Child1</ChildData>
+  </Child>
+  <Child>
+    <ID>2</ID>
+    <PID>1</PID>
+    <ChildData>Parent1Child2</ChildData>
+  </Child>
+  <Child>
+    <ID>3</ID>
+    <PID>2</PID>
+    <ChildData>Parent2Child3</ChildData>
+  </Child>
+</MyDataSet>
+
Index: Test/System.Data/DataSetTest2.cs
===================================================================
--- Test/System.Data/DataSetTest2.cs	(revision 106188)
+++ Test/System.Data/DataSetTest2.cs	(working copy)
@@ -1474,7 +1474,7 @@
 			ds.Merge (ds1);
 			Assert.AreEqual (1, ds.Relations.Count , "#1");
 			Assert.AreEqual (0, ds.Tables [0].Constraints.Count , "#2");
-			Assert.AreEqual (0, ds.Tables [1].Constraints.Count , "#2");
+			Assert.AreEqual (0, ds.Tables [1].Constraints.Count , "#3");
 		}
 
 		[Test]
@@ -1550,6 +1550,18 @@
 		}
 
 		[Test]
+		public void Merge_ConstraintsFromReadXmlSchema ()
+		{
+			DataSet ds = new DataSet ();
+			ds.ReadXml ("Test/System.Data/TestMerge1.xml");
+			DataSet ds2 = new DataSet ();
+			ds2.Merge (ds, true, MissingSchemaAction.AddWithKey);
+			DataRelation c = ds2.Tables [0].ChildRelations [0];
+			Assert.IsNotNull (c.ParentKeyConstraint, "#1");
+			Assert.IsNotNull (c.ChildKeyConstraint, "#2");
+		}
+
+		[Test]
 		[ExpectedException (typeof (DataException))]
 		public void Merge_MissingEventHandler ()
 		{
Index: System.Data/MergeManager.cs
===================================================================
--- System.Data/MergeManager.cs	(revision 106188)
+++ System.Data/MergeManager.cs	(working copy)
@@ -223,7 +223,7 @@
 					DataColumn[] childColumns = ResolveColumns (targetSet.Tables [relation.ChildTable.TableName],
 							relation.ChildColumns);
 					targetRelation = targetSet.Relations.Add (relation.RelationName, parentColumns,
-							childColumns, false);
+							childColumns, relation.createConstraints);
 					targetRelation.Nested = relation.Nested;
 				} else if (!CompareColumnArrays (relation.ParentColumns, targetRelation.ParentColumns) ||
 						!CompareColumnArrays (relation.ChildColumns, targetRelation.ChildColumns)) {
Index: System.Data/XmlSchemaDataImporter.cs
===================================================================
--- System.Data/XmlSchemaDataImporter.cs	(revision 106188)
+++ System.Data/XmlSchemaDataImporter.cs	(working copy)
@@ -1162,7 +1162,7 @@
 
 			if (!c.IsConstraintOnly) {
 				// generate the relation.
-				DataRelation rel = new DataRelation (c.ConstraintName, uniq.Columns, cols, false);
+				DataRelation rel = new DataRelation (c.ConstraintName, uniq.Columns, cols, true);
 				rel.Nested = c.IsNested;
 				rel.SetParentKeyConstraint (uniq);
 				rel.SetChildKeyConstraint (fkc);
Index: System.Data/DataRelation.cs
===================================================================
--- System.Data/DataRelation.cs	(revision 106188)
+++ System.Data/DataRelation.cs	(working copy)
@@ -59,7 +59,8 @@
 		private DataColumn[] parentColumns;
 		private DataColumn[] childColumns;
 		private bool nested;
-		internal bool createConstraints;
+		internal bool createConstraints = true;
+		private bool initFinished;
 		private PropertyCollection extendedProperties;
 		private PropertyChangedEventHandler onPropertyChangingDelegate;
 
@@ -183,7 +184,7 @@
 
 			this.RelationName = _relationName;
 			this.Nested = _nested;
-			this.createConstraints = false;
+			this.initFinished = true;
 			this.extendedProperties = new PropertyCollection ();
 			InitInProgress = false;
 #if NET_2_0
@@ -345,7 +346,7 @@
                 
         internal void UpdateConstraints ()
         {
-            if ( ! createConstraints)
+            if (initFinished || ! createConstraints)
                 return;
             
             ForeignKeyConstraint    foreignKeyConstraint    = null;