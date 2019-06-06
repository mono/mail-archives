Index: Test/System.Data/ChangeLog
===================================================================
--- Test/System.Data/ChangeLog	(revision 66162)
+++ Test/System.Data/ChangeLog	(working copy)
@@ -1,3 +1,9 @@
+2006-09-28  Patrick Earl <mono@patearl.net>
+
+	* DataTableReadWriteXml.cs: Added new tests for the DataTable's
+	ReadXml and WriteXml methods.  These tests assume proper
+	functioning of the DataSet ReadXml and WriteXml methods.
+
 2006-09-18	Boris Kirzner <borisk@mainsoft.com>
 
 	* DataViewTest.cs : fix compilation error.
Index: Test/System.Data/DataTableReadWriteXmlTest.cs
===================================================================
--- Test/System.Data/DataTableReadWriteXmlTest.cs	(revision 0)
+++ Test/System.Data/DataTableReadWriteXmlTest.cs	(revision 0)
@@ -0,0 +1,373 @@
+﻿// Author:
+//   Patrick Earl <mono@patearl.net>
+//
+// Copyright (c) 2006
+//
+// Permission is hereby granted, free of charge, to any person obtaining
+// a copy of this software and associated documentation files (the
+// "Software"), to deal in the Software without restriction, including
+// without limitation the rights to use, copy, modify, merge, publish,
+// distribute, sublicense, and/or sell copies of the Software, and to
+// permit persons to whom the Software is furnished to do so, subject to
+// the following conditions:
+//
+// The above copyright notice and this permission notice shall be
+// included in all copies or substantial portions of the Software.
+//
+// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
+// LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
+// OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
+// WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+//
+
+#if NET_2_0
+using System;
+using System.Data;
+using System.IO;
+using System.Text.RegularExpressions;
+using System.Xml;
+using NUnit.Framework; 
+
+namespace MonoTests.System.Data
+{
+    [TestFixture]
+    public class DataTableReadWriteXmlTest
+    {
+        void StandardizeXmlFormat(ref string xml)
+        {
+            XmlDocument doc = new XmlDocument();
+            doc.LoadXml(xml);
+            StringWriter sw = new StringWriter();
+            doc.Save(sw);
+            xml = sw.ToString();
+        }
+        
+        void GenerateTestData(out DataSet ds,
+                              out DataTable dtMainInDS,
+                              out DataTable dtChildInDS,
+                              out DataTable dtMain)
+        {
+            ds = new DataSet("MyDataSet");
+
+            // Create a primary table and populate it with some data.  Make a
+            // copy of the primary table and put it into the dataset.
+            dtMain = new DataTable("Main");
+            dtMain.Columns.Add(new DataColumn("ID", typeof(int)));
+            dtMain.Columns.Add(new DataColumn("Data", typeof(string)));
+            
+            DataRow row = dtMain.NewRow();
+            row["ID"] = 1;
+            row["Data"] = "One";
+            dtMain.Rows.Add(row);
+            
+            row = dtMain.NewRow();
+            row["ID"] = 2;
+            row["Data"] = "Two";
+            dtMain.Rows.Add(row);
+            
+            row = dtMain.NewRow();
+            row["ID"] = 3;
+            row["Data"] = "Three";
+            dtMain.Rows.Add(row);
+            
+            dtMainInDS = dtMain.Copy();
+            ds.Tables.Add(dtMainInDS);
+            
+            // Create a child table.  Make a copy of the child table and put
+            // it into the dataset.
+            dtChildInDS = new DataTable("Child");
+            dtChildInDS.Columns.Add(new DataColumn("ID", typeof(int)));
+            dtChildInDS.Columns.Add(new DataColumn("PID", typeof(int)));
+            dtChildInDS.Columns.Add(new DataColumn("ChildData", typeof(string)));
+            
+            row = dtChildInDS.NewRow();
+            row["ID"] = 1;
+            row["PID"] = 1;
+            row["ChildData"] = "Parent1Child1";
+            dtChildInDS.Rows.Add(row);
+            
+            row = dtChildInDS.NewRow();
+            row["ID"] = 2;
+            row["PID"] = 1;
+            row["ChildData"] = "Parent1Child2";
+            dtChildInDS.Rows.Add(row);
+            
+            row = dtChildInDS.NewRow();
+            row["ID"] = 3;
+            row["PID"] = 2;
+            row["ChildData"] = "Parent2Child3";
+            dtChildInDS.Rows.Add(row);
+            
+            ds.Tables.Add(dtChildInDS);
+            
+            // Set up the relation in the dataset.
+            ds.Relations.Add(new DataRelation("MainToChild",
+                                              dtMainInDS.Columns["ID"],
+                                              dtChildInDS.Columns["PID"]));
+        }
+        
+        [Test]
+        public void TestWriteXml()
+        {
+            DataSet ds;
+            DataTable dtMainInDS, dtChildInDS, dtMain;
+            
+            GenerateTestData(out ds,
+                             out dtMainInDS,
+                             out dtChildInDS,
+                             out dtMain);
+            
+            StringWriter sw = new StringWriter();
+            
+            // Get XML for DataSet writes.
+            sw.GetStringBuilder().Length = 0;
+            ds.WriteXml(sw);
+            string xmlDSNone = sw.ToString();
+            
+            sw.GetStringBuilder().Length = 0;
+            ds.WriteXml(sw, XmlWriteMode.DiffGram);
+            string xmlDSDiffGram = sw.ToString();
+
+            sw.GetStringBuilder().Length = 0;
+            ds.WriteXml(sw, XmlWriteMode.WriteSchema);
+            string xmlDSWriteSchema = sw.ToString();
+
+            // Get XML for recursive DataTable writes of the same data as in
+            // the DataSet.
+            sw.GetStringBuilder().Length = 0;
+            dtMainInDS.WriteXml(sw, true);
+            string xmlDTNone = sw.ToString();
+            
+            sw.GetStringBuilder().Length = 0;
+            dtMainInDS.WriteXml(sw, XmlWriteMode.DiffGram, true);
+            string xmlDTDiffGram = sw.ToString();
+
+            sw.GetStringBuilder().Length = 0;
+            dtMainInDS.WriteXml(sw, XmlWriteMode.WriteSchema, true);
+            string xmlDTWriteSchema = sw.ToString();
+            
+            // The schema XML written by the DataTable call has an extra element
+            // in the element for the dataset schema definition.  We remove that
+            // extra attribute and then check to see if the rest of the xml is
+            // identical.
+            XmlDocument doc = new XmlDocument();
+            doc.LoadXml(xmlDTWriteSchema);
+            XmlNode node = doc.DocumentElement.FirstChild.FirstChild;
+            XmlAttribute a = (XmlAttribute)node.Attributes.GetNamedItem("msdata:MainDataTable");
+            Assert.IsNotNull(a, "Test#01");
+            Assert.AreEqual("Main", a.Value, "Test#02");
+            
+            node.Attributes.Remove(a);
+            sw.GetStringBuilder().Length = 0;
+            doc.Save(sw);
+            xmlDTWriteSchema = sw.ToString();
+            
+            StandardizeXmlFormat(ref xmlDSWriteSchema);
+            
+            Assert.AreEqual(xmlDSNone, xmlDTNone, "Test#03");
+            Assert.AreEqual(xmlDSDiffGram, xmlDTDiffGram, "Test#04");
+            Assert.AreEqual(xmlDSWriteSchema, xmlDTWriteSchema, "Test#05");
+                               
+            // Now that we've tested writing tables (including children),
+            // we will go on to test the cases where the hierarchy flag
+            // is false.  For this, we will test one table inside the
+            // dataset and one table outside the dataset.
+            
+            // First, we fix our test DataSet to only have a single table
+            // with no relations.  Then, we go about comparing the XML.
+            // Get XML for DataSet writes.
+            ds.Tables[1].Constraints.Remove(ds.Tables[1].Constraints[0]);
+            ds.Tables[0].Constraints.Remove(ds.Tables[0].Constraints[0]);
+            ds.Tables[0].ChildRelations.Remove("MainToChild");
+            ds.Tables.Remove("Child");
+            
+            sw.GetStringBuilder().Length = 0;
+            ds.WriteXml(sw);
+            xmlDSNone = sw.ToString();
+            
+            sw.GetStringBuilder().Length = 0;
+            ds.WriteXml(sw, XmlWriteMode.DiffGram);
+            xmlDSDiffGram = sw.ToString();
+
+            sw.GetStringBuilder().Length = 0;
+            ds.WriteXml(sw, XmlWriteMode.WriteSchema);
+            xmlDSWriteSchema = sw.ToString();
+            
+            // Get all the DataTable.WriteXml results.
+            sw.GetStringBuilder().Length = 0;
+            dtMainInDS.WriteXml(sw);
+            string xmlDTNoneInDS = sw.ToString();
+            
+            sw.GetStringBuilder().Length = 0;
+            dtMainInDS.WriteXml(sw, XmlWriteMode.DiffGram);
+            string xmlDTDiffGramInDS = sw.ToString();
+
+            sw.GetStringBuilder().Length = 0;
+            dtMainInDS.WriteXml(sw, XmlWriteMode.WriteSchema);
+            string xmlDTWriteSchemaInDS = sw.ToString();
+
+            sw.GetStringBuilder().Length = 0;
+            dtMain.WriteXml(sw);
+            string xmlDTNoneNoDS = sw.ToString();
+
+            sw.GetStringBuilder().Length = 0;
+            dtMain.WriteXml(sw, XmlWriteMode.DiffGram);
+            string xmlDTDiffGramNoDS = sw.ToString();
+
+            sw.GetStringBuilder().Length = 0;
+            dtMain.WriteXml(sw, XmlWriteMode.WriteSchema);
+            string xmlDTWriteSchemaNoDS = sw.ToString();
+            
+            Assert.AreEqual(xmlDSNone, xmlDTNoneInDS, "Test#06");
+
+            // The only difference between the xml output from inside the
+            // dataset and the xml output from outside the dataset is that
+            // there's a fake <DocumentElement> tag surrounding tbe table
+            // in the second case.  We replace it with the name of the
+            // dataset for testing purposes.
+            doc.LoadXml(xmlDTNoneNoDS);
+            Assert.AreEqual("DocumentElement", doc.DocumentElement.Name, "Test#07");
+            sw.GetStringBuilder().Length = 0;
+            doc.Save(sw);
+            xmlDTNoneNoDS = sw.ToString();
+            xmlDTNoneNoDS = xmlDTNoneNoDS.Replace("<DocumentElement>", "<MyDataSet>");
+            xmlDTNoneNoDS = xmlDTNoneNoDS.Replace("</DocumentElement>", "</MyDataSet>");
+            
+            StandardizeXmlFormat(ref xmlDSNone);
+            
+            Assert.AreEqual(xmlDSNone, xmlDTNoneNoDS, "Test#08");
+            
+            // Now check the DiffGram.
+            Assert.AreEqual(xmlDSDiffGram, xmlDTDiffGramInDS, "Test#09");
+            
+            doc.LoadXml(xmlDTDiffGramNoDS);
+            Assert.AreEqual("DocumentElement", doc.DocumentElement.FirstChild.Name, "Test#10");
+            xmlDTDiffGramNoDS = xmlDTDiffGramNoDS.Replace("<DocumentElement>", "<MyDataSet>");
+            xmlDTDiffGramNoDS = xmlDTDiffGramNoDS.Replace("</DocumentElement>", "</MyDataSet>");
+
+            Assert.AreEqual(xmlDSDiffGram, xmlDTDiffGramNoDS, "Test#11");
+            
+            // Finally we check the WriteSchema version of the data.  First
+            // we remove the extra "msdata:MainDataTable" attribute from
+            // the schema declaration part of the DataTable xml.
+            doc = new XmlDocument();
+            doc.LoadXml(xmlDTWriteSchemaInDS);
+            node = doc.DocumentElement.FirstChild.FirstChild;
+            a = (XmlAttribute)node.Attributes.GetNamedItem("msdata:MainDataTable");
+            Assert.IsNotNull(a, "Test#12");
+            Assert.AreEqual("Main", a.Value, "Test#13");
+            node.Attributes.Remove(a);
+            sw.GetStringBuilder().Length = 0;
+            doc.Save(sw);
+            xmlDTWriteSchemaInDS = sw.ToString();
+            
+            StandardizeXmlFormat(ref xmlDSWriteSchema);
+
+            Assert.AreEqual(xmlDSWriteSchema, xmlDTWriteSchemaInDS, "Test#14");
+            
+            // Remove the extra "msdata:MainDataTable" for the other test case.
+            // Also make sure we have "NewDataSet" in the appropriate locations.
+            doc = new XmlDocument();
+            doc.LoadXml(xmlDTWriteSchemaNoDS);
+            node = doc.DocumentElement.FirstChild.FirstChild;
+            a = (XmlAttribute)node.Attributes.GetNamedItem("msdata:MainDataTable");
+            Assert.IsNotNull(a, "Test#15");
+            Assert.AreEqual("Main", a.Value, "Test#16");
+            node.Attributes.Remove(a);
+            sw.GetStringBuilder().Length = 0;
+            doc.Save(sw);
+            
+            Assert.AreEqual("NewDataSet", doc.DocumentElement.Name, "Test#17");
+            Assert.AreEqual("NewDataSet", doc.DocumentElement.FirstChild.Attributes["id"].Value, "Test#18");
+            Assert.AreEqual("NewDataSet", doc.DocumentElement.FirstChild.FirstChild.Attributes["name"].Value, "Test#19");
+            
+            xmlDTWriteSchemaNoDS = sw.ToString();
+            
+            xmlDTWriteSchemaNoDS = xmlDTWriteSchemaNoDS.Replace("<NewDataSet>","<MyDataSet>");
+            xmlDTWriteSchemaNoDS = xmlDTWriteSchemaNoDS.Replace("</NewDataSet>","</MyDataSet>");
+            xmlDTWriteSchemaNoDS = xmlDTWriteSchemaNoDS.Replace("\"NewDataSet\"","\"MyDataSet\"");
+
+            Assert.AreEqual(xmlDSWriteSchema, xmlDTWriteSchemaNoDS, "Test#20");
+        }
+        
+        [Test]
+        public void TestReadXml()
+        {
+            // For reading, DataTable.ReadXml only supports reading in xml with
+            // the schema included.  This means that we can only read in XML
+            // that was generated with the WriteSchema flag.  
+            DataSet ds;
+            DataTable dtMainInDS, dtChildInDS, dtMain;
+            
+            GenerateTestData(out ds,
+                             out dtMainInDS,
+                             out dtChildInDS,
+                             out dtMain);
+            
+            StringWriter sw = new StringWriter();
+            
+            // Get XML for recursive DataTable writes of the same data as in
+            // the DataSet.
+            sw.GetStringBuilder().Length = 0;
+            dtMainInDS.WriteXml(sw, true);
+            string xmlDTNone = sw.ToString();
+            
+            sw.GetStringBuilder().Length = 0;
+            dtMainInDS.WriteXml(sw, XmlWriteMode.DiffGram, true);
+            string xmlDTDiffGram = sw.ToString();
+
+            sw.GetStringBuilder().Length = 0;
+            dtMainInDS.WriteXml(sw, XmlWriteMode.WriteSchema, true);
+            string xmlMultiTable = sw.ToString();
+            
+            sw.GetStringBuilder().Length = 0;
+            dtMain.WriteXml(sw, XmlWriteMode.WriteSchema);
+            string xmlSingleTable = sw.ToString();
+            
+            DataTable newdt = new DataTable();
+
+            try {
+                newdt.ReadXml(new StringReader(xmlDTNone));
+                Assert.Fail("Test#01");
+            } catch(InvalidOperationException) {
+                // DataTable does not support schema inference from Xml.
+            }
+            
+            try {
+                newdt.ReadXml(new StringReader(xmlDTDiffGram));
+                Assert.Fail("Test#02");
+            } catch(InvalidOperationException) {
+                // DataTable does not support schema inference from Xml.
+            }
+            
+            DataTable multiTable = new DataTable();
+            multiTable.ReadXml(new StringReader(xmlMultiTable));
+            // Do some simple checks to see if the main dataset was created
+            // and if there are relationships present.
+            Assert.AreEqual("MyDataSet", multiTable.DataSet.DataSetName, "Test#03");
+            Assert.AreEqual(1, multiTable.ChildRelations.Count, "Test#04");
+            Assert.AreEqual(1, multiTable.Constraints.Count, "Test#05");
+            // Write the table back out and check to see that the XML is
+            // the same as before.
+            sw.GetStringBuilder().Length = 0;
+            multiTable.WriteXml(sw, XmlWriteMode.WriteSchema, true);
+            string xmlMultiTableCheck = sw.ToString();
+            Assert.AreEqual(xmlMultiTable, xmlMultiTableCheck, "Test#06");
+            
+            DataTable singleTable = new DataTable();
+            singleTable.ReadXml(new StringReader(xmlSingleTable));
+            // Do some simple checks on the table.
+            Assert.IsNull(singleTable.DataSet, "Test#07");
+            Assert.AreEqual("Main", singleTable.TableName, "Test#08");
+            // Write the table out and check if it's the same.
+            sw.GetStringBuilder().Length = 0;
+            singleTable.WriteXml(sw, XmlWriteMode.WriteSchema);
+            string xmlSingleTableCheck = sw.ToString();
+            Assert.AreEqual(xmlSingleTable, xmlSingleTableCheck, "Test#09");
+        }
+    }
+}
+#endif
Index: System.Data.dll.sources
===================================================================
--- System.Data.dll.sources	(revision 66162)
+++ System.Data.dll.sources	(working copy)
@@ -318,6 +318,7 @@
 System.Data/XmlDataLoader.cs
 System.Data/XmlSchemaDataImporter.cs
 System.Data/XmlSchemaWriter.cs
+System.Data/XmlTableWriter.cs
 System.Xml/XmlDataDocument.cs
 Mono.Data.SqlExpressions/Tokenizer.cs
 Mono.Data.SqlExpressions/Numeric.cs
Index: System.Data_test.dll.sources
===================================================================
--- System.Data_test.dll.sources	(revision 66162)
+++ System.Data_test.dll.sources	(working copy)
@@ -40,6 +40,7 @@
 System.Data/DataTableTest2.cs
 System.Data/DataTableLoadRowTest.cs
 System.Data/DataTableReaderTest.cs
+System.Data/DataTableReadWriteXmlTest.cs
 System.Data/DataViewManagerTest.cs
 System.Data/DataViewTest.cs
 System.Data/DataViewTest2.cs
Index: ChangeLog
===================================================================
--- ChangeLog	(revision 66162)
+++ ChangeLog	(working copy)
@@ -1,3 +1,7 @@
+2006-10-02	Patrick Earl <mono@patearl.net>
+
+	* Implemented DataTable.WriteXml
+
 2006-09-26	Boris Kirzner <borisk@mainsoft.com>
 
 	* run-tests.test.disconnected.bat,run-tests.test.connected.bat: 
Index: System.Data/XmlSchemaWriter.cs
===================================================================
--- System.Data/XmlSchemaWriter.cs	(revision 66162)
+++ System.Data/XmlSchemaWriter.cs	(working copy)
@@ -64,16 +64,50 @@
 			XmlWriter writer, DataTableCollection tables,
 			DataRelationCollection relations)
 		{
-			ds = dataset;
+			dataSetName = dataset.DataSetName;
+			dataSetNamespace = dataset.Namespace;
+			dataSetLocale = dataset.Locale;
+			dataSetProperties = dataset.ExtendedProperties;
 			w = writer;
+			if (tables != null) {
+				this.tables = new DataTable[tables.Count];
+				for(int i=0;i<tables.Count;i++) this.tables[i] = tables[i];
+			}
+			if (relations != null) {
+				this.relations = new DataRelation[relations.Count];
+				for(int i=0;i<relations.Count;i++) this.relations[i] = relations[i];
+			}
+		}
+
+		public XmlSchemaWriter (XmlWriter writer,
+			DataTable[] tables,
+			DataRelation[] relations,
+			string mainDataTable,
+			string dataSetName)
+		{
+			w = writer;
 			this.tables = tables;
 			this.relations = relations;
+			this.mainDataTable = mainDataTable;
+			this.dataSetName = dataSetName;
+			this.dataSetProperties = new PropertyCollection();
+			if (tables[0].DataSet != null) {
+				dataSetNamespace = tables[0].DataSet.Namespace;
+				dataSetLocale = tables[0].DataSet.Locale;
+			} else {
+				dataSetNamespace = tables[0].Namespace;
+				dataSetLocale = tables[0].Locale;
+			}
 		}
 
-		DataSet ds;
 		XmlWriter w;
-		DataTableCollection tables;
-		DataRelationCollection relations;
+		DataTable[] tables;
+		DataRelation[] relations;
+		string mainDataTable;
+		string dataSetName;
+		string dataSetNamespace;
+		PropertyCollection dataSetProperties;
+		CultureInfo dataSetLocale;
 
 		ArrayList globalTypeTables = new ArrayList ();
 		Hashtable additionalNamespaces = new Hashtable ();
@@ -81,7 +115,7 @@
 		ArrayList annotation = new ArrayList ();
 
 		public string ConstraintPrefix {
-			get { return ds.Namespace != String.Empty ? XmlConstants.TnsPrefix + ':' : String.Empty; }
+			get { return dataSetNamespace != String.Empty ? XmlConstants.TnsPrefix + ':' : String.Empty; }
 		}
 
 		// the whole DataSet
@@ -99,18 +133,18 @@
 			}
 
 			w.WriteStartElement ("xs", "schema", xmlnsxs);
-			w.WriteAttributeString ("id", XmlHelper.Encode (ds.DataSetName));
+			w.WriteAttributeString ("id", XmlHelper.Encode (dataSetName));
 
-			if (ds.Namespace != String.Empty) {
+			if (dataSetNamespace != String.Empty) {
 				w.WriteAttributeString ("targetNamespace",
-					ds.Namespace);
+					dataSetNamespace);
 				w.WriteAttributeString (
 					"xmlns",
 					XmlConstants.TnsPrefix,
 					XmlConstants.XmlnsNS,
-					ds.Namespace);
+					dataSetNamespace);
 			}
-			w.WriteAttributeString ("xmlns", ds.Namespace);
+			w.WriteAttributeString ("xmlns", dataSetNamespace);
 
 			w.WriteAttributeString ("xmlns", "xs",
 				XmlConstants.XmlnsNS, xmlnsxs);
@@ -125,7 +159,7 @@
 					XmlConstants.XmlnsNS,
 					XmlConstants.MspropNamespace);
 
-			if (ds.Namespace != String.Empty) {
+			if (dataSetNamespace != String.Empty) {
 				w.WriteAttributeString ("attributeFormDefault", "qualified");
 				w.WriteAttributeString ("elementFormDefault", "qualified");
 			}
@@ -156,12 +190,19 @@
 		private void WriteDataSetElement ()
 		{
 			w.WriteStartElement ("xs", "element", xmlnsxs);
-			w.WriteAttributeString ("name", XmlHelper.Encode (ds.DataSetName));
+			w.WriteAttributeString ("name", XmlHelper.Encode (dataSetName));
 			w.WriteAttributeString (XmlConstants.MsdataPrefix,
 				"IsDataSet", XmlConstants.MsdataNamespace,
 				"true");
+
+			if(mainDataTable != null && mainDataTable != "")
+				w.WriteAttributeString (
+					XmlConstants.MsdataPrefix,
+					"MainDataTable",
+					XmlConstants.MsdataNamespace,
+					mainDataTable);
 #if NET_2_0
-			if (ds.Locale == CultureInfo.CurrentCulture) {
+			if (dataSetLocale == CultureInfo.CurrentCulture) {
 				w.WriteAttributeString (
 					XmlConstants.MsdataPrefix,
 					"UseCurrentCulture",
@@ -175,10 +216,10 @@
 					XmlConstants.MsdataPrefix,
 					"Locale",
 					XmlConstants.MsdataNamespace,
-					ds.Locale.Name);
+					dataSetLocale.Name);
 			}
 
-			AddExtendedPropertyAttributes (ds.ExtendedProperties);
+			AddExtendedPropertyAttributes (dataSetProperties);
 
 			w.WriteStartElement ("xs", "complexType", xmlnsxs);
 			w.WriteStartElement ("xs", "choice", xmlnsxs);
@@ -194,7 +235,7 @@
 				}
 				
 				if (isTopLevel) {
-					if (ds.Namespace != table.Namespace) {
+					if (dataSetNamespace != table.Namespace) {
 						// <xs:element ref="X:y" />
 						w.WriteStartElement ("xs",
 							"element",
@@ -286,7 +327,12 @@
 					}
 
 					ForeignKeyConstraint fk = c as ForeignKeyConstraint;
-					if (fk != null && (relations == null || !(relations.Contains (fk.ConstraintName)))) {
+					bool haveConstraint = false;
+					if (relations != null)
+						foreach (DataRelation r in relations)
+							if(r.RelationName == fk.ConstraintName)
+								haveConstraint = true;
+					if (fk != null && !haveConstraint) {
 						DataRelation rel = new DataRelation (fk.ConstraintName,
 										fk.RelatedColumns, fk.Columns);
 						AddForeignKeys (rel, names, true);
@@ -399,12 +445,12 @@
 			// first try to find the concatenated name. If we didn't find it - use constraint name.
 			if (names.Contains (concatName)) {
 				w.WriteStartAttribute ("refer", String.Empty);
-				w.WriteQualifiedName (concatName, ds.Namespace);
+				w.WriteQualifiedName (concatName, dataSetNamespace);
 				w.WriteEndAttribute ();
 			}
 			else {
 				w.WriteStartAttribute ("refer", String.Empty);
-				w.WriteQualifiedName (XmlHelper.Encode (uqConst.ConstraintName), ds.Namespace);
+				w.WriteQualifiedName (XmlHelper.Encode (uqConst.ConstraintName), dataSetNamespace);
 				w.WriteEndAttribute ();
 			}
 
@@ -445,10 +491,10 @@
 		// ExtendedProperties
 
 		private bool CheckExtendedPropertyExists (
-			DataTableCollection tables,
-			DataRelationCollection relations)
+			DataTable[] tables,
+			DataRelation[] relations)
 		{
-			if (ds.ExtendedProperties.Count > 0)
+			if (dataSetProperties.Count > 0)
 				return true;
 			foreach (DataTable dt in tables) {
 				if (dt.ExtendedProperties.Count > 0)
@@ -640,7 +686,7 @@
 
 		private void WriteChildRelations (DataRelation rel)
 		{
-			if (rel.ChildTable.Namespace != ds.Namespace) {
+			if (rel.ChildTable.Namespace != dataSetNamespace) {
 				w.WriteStartElement ("xs", "element", xmlnsxs);
 				w.WriteStartAttribute ("ref", String.Empty);
 				w.WriteQualifiedName (
@@ -734,8 +780,8 @@
 		{
 			if (ns == String.Empty)
 				return;
-			if (ds.Namespace != ns) {
-				if (names [prefix] != ns) {
+			if (dataSetNamespace != ns) {
+				if ((string)names [prefix] != ns) {
 					for (int i = 1; i < int.MaxValue; i++) {
 						string p = "app" + i;
 						if (names [p] == null) {
Index: System.Data/DataSet.cs
===================================================================
--- System.Data/DataSet.cs	(revision 66162)
+++ System.Data/DataSet.cs	(working copy)
@@ -1538,29 +1538,33 @@
 				WriteTable ( writer, table, mode, version);
 		}
 
-		private void WriteTable (XmlWriter writer, DataTable table, XmlWriteMode mode, DataRowVersion version)
+		internal static void WriteTable (XmlWriter writer, DataTable table, XmlWriteMode mode, DataRowVersion version)
 		{
 			DataRow[] rows = table.NewRowArray(table.Rows.Count);
 			table.Rows.CopyTo (rows, 0);
 			WriteTable (writer, rows, mode, version, true);
 		}
 
-		private void WriteTable (XmlWriter writer,
+		internal static void WriteTable (XmlWriter writer,
 			DataRow [] rows,
 			XmlWriteMode mode,
 			DataRowVersion version, bool skipIfNested)
 		{
+			if (rows.Length == 0) return;
+			DataTable table = rows[0].Table;
+
+			if (table.TableName == null || table.TableName == "")
+				throw new InvalidOperationException("Cannot serialize the DataTable. DataTable name is not set.");
+
 			//The columns can be attributes, hidden, elements, or simple content
 			//There can be 0-1 simple content cols or 0-* elements
 			System.Collections.ArrayList atts;
 			System.Collections.ArrayList elements;
 			DataColumn simple = null;
 
-			if (rows.Length == 0) return;
-			DataTable table = rows[0].Table;
 			SplitColumns (table, out atts, out elements, out simple);
 			//sort out the namespacing
-			string nspc = table.Namespace.Length > 0 ? table.Namespace : Namespace;
+			string nspc = (table.Namespace.Length > 0 || table.DataSet == null) ? table.Namespace : table.DataSet.Namespace;
 			int relationCount = table.ParentRelations.Count;
 			DataRelation oneRel = relationCount == 1 ? table.ParentRelations [0] : null;
 
@@ -1628,7 +1632,7 @@
 
 		}
 
-		private void WriteColumnAsElement (XmlWriter writer, XmlWriteMode mode, DataColumn col, DataRow row, DataRowVersion version)
+		internal static void WriteColumnAsElement (XmlWriter writer, XmlWriteMode mode, DataColumn col, DataRow row, DataRowVersion version)
 		{
 			string colnspc = null;
 			object rowObject = row [col, version];
@@ -1645,16 +1649,16 @@
 			writer.WriteEndElement ();
 		}
 
-		private void WriteColumnAsAttribute (XmlWriter writer, XmlWriteMode mode, DataColumn col, DataRow row, DataRowVersion version)
+		internal static void WriteColumnAsAttribute (XmlWriter writer, XmlWriteMode mode, DataColumn col, DataRow row, DataRowVersion version)
 		{
 			if (!row.IsNull (col))
 				WriteAttributeString (writer, mode, col.Namespace, col.Prefix, XmlHelper.Encode (col.ColumnName), WriteObjectXml (row[col, version]));
 		}
 
-		private void WriteTableElement (XmlWriter writer, XmlWriteMode mode, DataTable table, DataRow row, DataRowVersion version)
+		internal static void WriteTableElement (XmlWriter writer, XmlWriteMode mode, DataTable table, DataRow row, DataRowVersion version)
 		{
 			//sort out the namespacing
-			string nspc = table.Namespace.Length > 0 ? table.Namespace : Namespace;
+			string nspc = (table.Namespace.Length > 0 || table.DataSet == null) ? table.Namespace : table.DataSet.Namespace;
 
 			WriteStartElement (writer, mode, nspc, table.Prefix, XmlHelper.Encode (table.TableName));
 
@@ -1672,12 +1676,12 @@
 			}
 		}
 		    
-		private void WriteStartElement (XmlWriter writer, XmlWriteMode mode, string nspc, string prefix, string name)
+		internal static void WriteStartElement (XmlWriter writer, XmlWriteMode mode, string nspc, string prefix, string name)
 		{
 			writer.WriteStartElement (prefix, name, nspc);
 		}
 		
-		private void WriteAttributeString (XmlWriter writer, XmlWriteMode mode, string nspc, string prefix, string name, string stringValue)
+		internal static void WriteAttributeString (XmlWriter writer, XmlWriteMode mode, string nspc, string prefix, string name, string stringValue)
 		{
 			switch ( mode) {
 				case XmlWriteMode.WriteSchema:
@@ -1695,7 +1699,7 @@
 		internal void WriteIndividualTableContent (XmlWriter writer, DataTable table, XmlWriteMode mode)
 		{
 			if (mode == XmlWriteMode.DiffGram) {
-				SetTableRowsID (table);
+				table.SetRowsID();
 				WriteDiffGramElement (writer);
 			}
 			
@@ -1760,7 +1764,7 @@
 			}
 		}
 
-		private void WriteDiffGramElement(XmlWriter writer)
+		internal static void WriteDiffGramElement(XmlWriter writer)
 		{
 			WriteStartElement (writer, XmlWriteMode.DiffGram, XmlConstants.DiffgrNamespace, XmlConstants.DiffgrPrefix, "diffgram");
 			WriteAttributeString(writer, XmlWriteMode.DiffGram, null, "xmlns", XmlConstants.MsdataPrefix, XmlConstants.MsdataNamespace);
@@ -1768,18 +1772,9 @@
 
 		private void SetRowsID()
 		{
-			foreach (DataTable Table in Tables)
-				SetTableRowsID (Table);
+			foreach (DataTable table in Tables)
+				table.SetRowsID();
 		}
-		
-		private void SetTableRowsID (DataTable Table)
-		{
-			int dataRowID = 0;
-			foreach (DataRow Row in Table.Rows) {
-				Row.XmlRowID = dataRowID;
-				dataRowID++;
-			}
-		}
 		#endregion //Private Xml Serialisation
 	}
 }
Index: System.Data/XmlTableWriter.cs
===================================================================
--- System.Data/XmlTableWriter.cs	(revision 0)
+++ System.Data/XmlTableWriter.cs	(revision 0)
@@ -0,0 +1,97 @@
+// 
+// System.Data/XmlTableWriter.cs
+//
+// Author:
+//   Patrick Earl <mono@patearl.net>
+//
+// Copyright (c) 2006, Patrick Earl
+//
+// Permission is hereby granted, free of charge, to any person obtaining
+// a copy of this software and associated documentation files (the
+// "Software"), to deal in the Software without restriction, including
+// without limitation the rights to use, copy, modify, merge, publish,
+// distribute, sublicense, and/or sell copies of the Software, and to
+// permit persons to whom the Software is furnished to do so, subject to
+// the following conditions:
+// 
+// The above copyright notice and this permission notice shall be
+// included in all copies or substantial portions of the Software.
+// 
+// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
+// LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
+// OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
+// WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+
+#if NET_2_0
+using System;
+using System.Collections.Generic;
+using System.Data;
+using System.Xml;
+
+internal class XmlTableWriter {
+	// This method is modelled after the DataSet's WriteXml functionality.
+	internal static void WriteTables(XmlWriter writer,
+		                 XmlWriteMode mode,
+				 List<DataTable> tables,
+				 List<DataRelation> relations,
+				 string mainDataTable,
+				 string dataSetName)
+	{
+		if (mode == XmlWriteMode.DiffGram) {
+			foreach (DataTable table in tables)
+				table.SetRowsID();
+			DataSet.WriteDiffGramElement(writer);
+		}
+
+		bool shouldOutputContent = (mode != XmlWriteMode.DiffGram);
+		for (int n = 0; n < tables.Count && !shouldOutputContent; n++)
+			shouldOutputContent = tables[n].Rows.Count > 0;
+
+		if (shouldOutputContent) {
+			// We assume that tables[0] is the main table being written.
+			// We happen to know that the code above us does things that way.
+			DataSet.WriteStartElement(writer, mode, tables[0].Namespace, tables[0].Prefix, XmlHelper.Encode(dataSetName));
+
+			if (mode == XmlWriteMode.WriteSchema) {
+				new XmlSchemaWriter(writer,
+					tables.ToArray(),
+					relations.ToArray(),
+					mainDataTable,
+					dataSetName
+				).WriteSchema();
+			}
+
+			WriteTableList (writer, mode, tables, DataRowVersion.Default);
+
+			writer.WriteEndElement();
+		}
+
+		if (mode == XmlWriteMode.DiffGram) {
+			List<DataTable> changedTables = new List<DataTable>();
+			foreach (DataTable table in tables) {
+				DataTable changed = table.GetChanges(DataRowState.Modified | DataRowState.Deleted);
+				if (changed != null && changed.Rows.Count > 0)
+					changedTables.Add(changed);
+			}
+			if (changedTables.Count > 0) {
+				DataSet.WriteStartElement(writer, XmlWriteMode.DiffGram, XmlConstants.DiffgrNamespace, XmlConstants.DiffgrPrefix, "before");
+				WriteTableList (writer, mode, changedTables, DataRowVersion.Original);
+				writer.WriteEndElement();
+			}
+		
+			writer.WriteEndElement(); // diffgr:diffgram
+		}
+
+		writer.Flush();
+	}
+
+	internal static void WriteTableList(XmlWriter writer, XmlWriteMode mode, List<DataTable> tables, DataRowVersion version)
+	{
+		foreach (DataTable table in tables)
+			DataSet.WriteTable(writer, table, mode, version);
+	}
+}
+#endif
Index: System.Data/DataTable.cs
===================================================================
--- System.Data/DataTable.cs	(revision 66162)
+++ System.Data/DataTable.cs	(working copy)
@@ -43,6 +43,9 @@
 using System;
 using System.Data.Common;
 using System.Collections;
+#if NET_2_0
+using System.Collections.Generic;
+#endif
 using System.ComponentModel;
 using System.Globalization;
 using System.IO;
@@ -1929,10 +1932,49 @@
 		}
 
 #if NET_2_0
+		public XmlReadMode ReadXml (Stream stream)
+		{
+			return ReadXml (new XmlTextReader(stream, null));
+		}
+
+		public XmlReadMode ReadXml (string fileName)
+		{
+			XmlReader reader = new XmlTextReader(fileName);
+			try {
+				return ReadXml (reader);
+			} finally {
+				reader.Close();
+			}
+		}
+
+		public XmlReadMode ReadXml (TextReader reader)
+		{
+			return ReadXml (new XmlTextReader(reader));
+		}
+
 		[MonoTODO]
-		XmlReadMode ReadXml (Stream stream)
+		public XmlReadMode ReadXml (XmlReader reader)
 		{
-			throw new NotImplementedException ();
+			// The documentation from MS for this method is rather
+			// poor.  The following cases have been observed
+			// during testing:
+			//
+			//     Reading a table from XML may create a DataSet to
+			//     store child tables.
+			//
+			//     If the table has at least one column present,
+			//     we do not require the schema to be present in
+			//     the xml.  If the table has no columns, neither
+			//     regular data nor diffgrams will be read, but
+			//     will throw an error indicating that schema
+			//     will not be inferred.
+			//
+			//     We will likely need to take advantage of the
+			//     msdata:MainDataTable attribute added to the
+			//     schema info to load into the appropriate
+			//     locations.
+
+			throw new NotImplementedException();
 		}
 
 		public void ReadXmlSchema (Stream stream)
@@ -2244,57 +2286,158 @@
 		{
 			XmlWriterSettings s = new XmlWriterSettings ();
 			s.Indent = true;
+			s.OmitXmlDeclaration = true;
 			return s;
 		}
 
 		public void WriteXml (Stream stream)
 		{
-			WriteXml (stream, XmlWriteMode.IgnoreSchema);
+			WriteXml (stream, XmlWriteMode.IgnoreSchema, false);
 		}
 
+		public void WriteXml (string fileName)
+		{
+			WriteXml (fileName, XmlWriteMode.IgnoreSchema, false);
+		}
+
 		public void WriteXml (TextWriter writer)
 		{
-			WriteXml (writer, XmlWriteMode.IgnoreSchema);
+			WriteXml (writer, XmlWriteMode.IgnoreSchema, false);
 		}
 
 		public void WriteXml (XmlWriter writer)
 		{
-			WriteXml (writer, XmlWriteMode.IgnoreSchema);
+			WriteXml (writer, XmlWriteMode.IgnoreSchema, false);
 		}
 
-		public void WriteXml (string fileName)
+		public void WriteXml (Stream stream, XmlWriteMode mode)
 		{
-			WriteXml (fileName, XmlWriteMode.IgnoreSchema);
+			WriteXml (stream, mode, false);
 		}
 
-		public void WriteXml (Stream stream, XmlWriteMode mode)
+		public void WriteXml (string fileName, XmlWriteMode mode)
 		{
-			WriteXml (XmlWriter.Create (stream, GetWriterSettings ()), mode);
+			WriteXml (fileName, mode, false);
 		}
 
 		public void WriteXml (TextWriter writer, XmlWriteMode mode)
 		{
-			WriteXml (XmlWriter.Create (writer, GetWriterSettings ()), mode);
+			WriteXml (writer, mode, false);
 		}
 
-		[MonoTODO]
 		public void WriteXml (XmlWriter writer, XmlWriteMode mode)
 		{
-			throw new NotImplementedException ();
+			WriteXml (writer, mode, false);
 		}
 
-		public void WriteXml (string fileName, XmlWriteMode mode)
+		public void WriteXml (Stream stream, bool writeHierarchy)
 		{
+			WriteXml (stream, XmlWriteMode.IgnoreSchema, writeHierarchy);
+		}
+
+		public void WriteXml (string fileName, bool writeHierarchy)
+		{
+			WriteXml (fileName, XmlWriteMode.IgnoreSchema, writeHierarchy);
+		}
+
+		public void WriteXml (TextWriter writer, bool writeHierarchy)
+		{
+			WriteXml (writer, XmlWriteMode.IgnoreSchema, writeHierarchy);
+		}
+
+		public void WriteXml (XmlWriter writer, bool writeHierarchy)
+		{
+			WriteXml (writer, XmlWriteMode.IgnoreSchema, writeHierarchy);
+		}
+
+		public void WriteXml (Stream stream, XmlWriteMode mode, bool writeHierarchy)
+		{
+			WriteXml (XmlWriter.Create (stream, GetWriterSettings ()), mode, writeHierarchy);
+		}
+
+		public void WriteXml (string fileName, XmlWriteMode mode, bool writeHierarchy)
+		{
 			XmlWriter xw = null;
 			try {
 				xw = XmlWriter.Create (fileName, GetWriterSettings ());
-				WriteXml (xw, mode);
+				WriteXml (xw, mode, writeHierarchy);
 			} finally {
 				if (xw != null)
 					xw.Close ();
 			}
 		}
 
+		public void WriteXml (TextWriter writer, XmlWriteMode mode, bool writeHierarchy)
+		{
+			WriteXml (XmlWriter.Create (writer, GetWriterSettings ()), mode, writeHierarchy);
+		}
+
+		public void WriteXml (XmlWriter writer, XmlWriteMode mode, bool writeHierarchy)
+		{
+			// If we're in mode XmlWriteMode.WriteSchema, we need to output an extra
+			// msdata:MainDataTable attribute that wouldn't normally be part of the
+			// DataSet WriteXml output.
+			//
+			// For the writeHierarchy == true case, we write what would be output by
+			// a DataSet write, but we limit ourselves to our table and its descendants.
+			//
+			// For the writeHierarchy == false case, we write what would be output by
+			// a DataSet write, but we limit ourselves to this table.
+			//
+			// If the table is not in a DataSet, we follow the following behaviour:
+			//   For WriteSchema cases, we do a write as if there is a wrapper
+			//   dataset called NewDataSet.
+			//   For IgnoreSchema or DiffGram cases, we do a write as if there
+			//   is a wrapper dataset called DocumentElement.
+			
+			// Generate a list of tables to write.
+			List<DataTable> tables = new List<DataTable>();	
+			if (writeHierarchy == false)
+				tables.Add(this);
+			else
+				FindAllChildren(tables, this);
+
+			// If we're in a DataSet, generate a list of relations to write.
+			List<DataRelation> relations = new List<DataRelation>();
+			if (DataSet != null)
+			{
+				foreach(DataRelation relation in DataSet.Relations)
+				{
+					if(tables.Contains(relation.ParentTable) &&
+					   tables.Contains(relation.ChildTable))
+						relations.Add(relation);
+				}
+			}
+
+			// Add the msdata:MainDataTable info if we're writing schema data.
+			string mainDataTable = null;
+			if (mode == XmlWriteMode.WriteSchema)
+				mainDataTable = this.TableName;
+
+			// Figure out the DataSet name.
+			string dataSetName = null;
+			if (DataSet != null)
+				dataSetName = DataSet.DataSetName;
+			else if (DataSet == null && mode == XmlWriteMode.WriteSchema)
+				dataSetName = "NewDataSet";
+			else
+				dataSetName = "DocumentElement";
+				
+			XmlTableWriter.WriteTables(writer, mode, tables, relations, mainDataTable, dataSetName);
+		}
+
+		private void FindAllChildren(List<DataTable> list, DataTable root)
+		{
+			if (!list.Contains(root))
+			{
+				list.Add(root);
+				foreach (DataRelation relation in root.ChildRelations)
+				{
+					FindAllChildren(list, relation.ChildTable);
+				}
+			}
+		}
+
 		public void WriteXmlSchema (Stream stream)
 		{
 			WriteXmlSchema (XmlWriter.Create (stream, GetWriterSettings ()));
@@ -2581,5 +2724,14 @@
 		internal void ResetPropertyDescriptorsCache() {
 			_propertyDescriptorsCache = null;
 		}
+
+		internal void SetRowsID()
+		{
+			int dataRowID = 0;
+			foreach (DataRow row in Rows) {
+				row.XmlRowID = dataRowID;
+				dataRowID++;
+			}
+		}
 	}
 }
