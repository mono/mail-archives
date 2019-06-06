Index: System.Data/XmlSchemaWriter.cs
===================================================================
--- System.Data/XmlSchemaWriter.cs	(revision 105755)
+++ System.Data/XmlSchemaWriter.cs	(working copy)
@@ -63,9 +63,10 @@
 		internal static void WriteXmlSchema (XmlWriter writer, DataTable[] tables,
 						     DataRelation[] relations,
 						     string mainDataTable,
-						     string dataSetName)
+						     string dataSetName,
+						     CultureInfo locale)
 		{
-			new XmlSchemaWriter (writer, tables, relations, mainDataTable, dataSetName).WriteSchema ();
+			new XmlSchemaWriter (writer, tables, relations, mainDataTable, dataSetName, locale).WriteSchema ();
 		}
 
 		public XmlSchemaWriter (DataSet dataset,
@@ -74,7 +75,11 @@
 		{
 			dataSetName = dataset.DataSetName;
 			dataSetNamespace = dataset.Namespace;
+#if NET_2_0
+			dataSetLocale = dataset.LocaleSpecified ? dataset.Locale : null;
+#else
 			dataSetLocale = dataset.Locale;
+#endif
 			dataSetProperties = dataset.ExtendedProperties;
 			w = writer;
 			if (tables != null) {
@@ -91,20 +96,26 @@
 			DataTable[] tables,
 			DataRelation[] relations,
 			string mainDataTable,
-			string dataSetName)
+			string dataSetName,
+			CultureInfo locale)
 		{
 			w = writer;
 			this.tables = tables;
 			this.relations = relations;
 			this.mainDataTable = mainDataTable;
 			this.dataSetName = dataSetName;
+			this.dataSetLocale = locale;
 			this.dataSetProperties = new PropertyCollection();
 			if (tables[0].DataSet != null) {
 				dataSetNamespace = tables[0].DataSet.Namespace;
+#if !NET_2_0
 				dataSetLocale = tables[0].DataSet.Locale;
+#endif
 			} else {
 				dataSetNamespace = tables[0].Namespace;
+#if !NET_2_0
 				dataSetLocale = tables[0].Locale;
+#endif
 			}
 		}
 
@@ -217,29 +228,35 @@
 				"IsDataSet", XmlConstants.MsdataNamespace,
 				"true");
 
+#if NET_2_0
+			bool useCurrentLocale = (dataSetLocale == null);
+
+			if (!useCurrentLocale)
+#endif
+			{
+				w.WriteAttributeString (
+					XmlConstants.MsdataPrefix,
+					"Locale",
+					XmlConstants.MsdataNamespace,
+					dataSetLocale.Name);
+			}
+
+#if NET_2_0
 			if(mainDataTable != null && mainDataTable != "")
 				w.WriteAttributeString (
 					XmlConstants.MsdataPrefix,
 					"MainDataTable",
 					XmlConstants.MsdataNamespace,
 					mainDataTable);
-#if NET_2_0
-			if (dataSetLocale == CultureInfo.CurrentCulture) {
+
+			if (useCurrentLocale) {
 				w.WriteAttributeString (
 					XmlConstants.MsdataPrefix,
 					"UseCurrentLocale",
 					XmlConstants.MsdataNamespace,
 					"true");
 			}
-			else
 #endif
-			{
-				w.WriteAttributeString (
-					XmlConstants.MsdataPrefix,
-					"Locale",
-					XmlConstants.MsdataNamespace,
-					dataSetLocale.Name);
-			}
 
 			AddExtendedPropertyAttributes (dataSetProperties);
 
Index: System.Data/DataSet.cs
===================================================================
--- System.Data/DataSet.cs	(revision 105755)
+++ System.Data/DataSet.cs	(working copy)
@@ -78,7 +78,7 @@
 		private DataRelationCollection relationCollection;
 		private PropertyCollection properties;
 		private DataViewManager defaultView;
-		private CultureInfo locale = Thread.CurrentThread.CurrentCulture;
+		private CultureInfo locale;
 		internal XmlDataDocument _xmlDataDocument;
 #if NET_2_0
 		private bool dataSetInitialized = true;
@@ -98,7 +98,6 @@
 			relationCollection = new DataRelationCollection.DataSetRelationCollection (this);
 			properties = new PropertyCollection ();
 			prefix = String.Empty;
-			Locale = CultureInfo.CurrentCulture;
 		}
 
 		protected DataSet (SerializationInfo info, StreamingContext context) : this ()
@@ -223,7 +222,7 @@
 #endif
 		public CultureInfo Locale {
 			get {
-				return locale;
+				return locale != null ? locale : Thread.CurrentThread.CurrentCulture;
 			}
 			set {
 				if (locale == null || !locale.Equals (value)) {
@@ -234,6 +233,10 @@
 			}
 		}
 
+		internal bool LocaleSpecified {
+			get { return locale != null; }
+		}
+
 		internal void InternalEnforceConstraints(bool value,bool resetIndexes)
 		{
 			if (value == enforceConstraints) 
@@ -493,7 +496,7 @@
 				for (int i = 0; i < ExtendedProperties.Count; i++)
 					Copy.ExtendedProperties.Add (tgtArray.GetValue (i), ExtendedProperties[tgtArray.GetValue (i)]);
 			}
-			Copy.Locale = Locale;
+			Copy.locale = locale;
 			Copy.Namespace = Namespace;
 			Copy.Prefix = Prefix;
 			//Copy.Site = Site; // FIXME : Not sure of this.
Index: System.Data/XmlTableWriter.cs
===================================================================
--- System.Data/XmlTableWriter.cs	(revision 105755)
+++ System.Data/XmlTableWriter.cs	(working copy)
@@ -60,11 +60,13 @@
 				tables.CopyTo(_tables);
 				DataRelation[] _relations = new DataRelation[relations.Count];
 				relations.CopyTo(_relations);
+				DataTable dt = _tables [0];
 				new XmlSchemaWriter(writer,
 					_tables,
 					_relations,
 					mainDataTable,
-					dataSetName
+					dataSetName,
+					dt.LocaleSpecified ? dt.Locale : null
 				).WriteSchema();
 			}
 
Index: System.Data/XmlDataInferenceLoader.cs
===================================================================
--- System.Data/XmlDataInferenceLoader.cs	(revision 105755)
+++ System.Data/XmlDataInferenceLoader.cs	(working copy)
@@ -36,6 +36,7 @@
 using System;
 using System.Collections;
 using System.Data;
+using System.Globalization;
 using System.IO; // for Driver
 using System.Text; // for Driver
 using System.Xml;
@@ -179,6 +180,8 @@
 			if (document.DocumentElement == null)
 				return;
 
+			dataset.Locale = new CultureInfo ("en-US"); // default(!)
+
 			// If the root element is not a data table, treat 
 			// this element as DataSet.
 			// Read one element. It might be DataSet element.
Index: System.Data/XmlSchemaDataImporter.cs
===================================================================
--- System.Data/XmlSchemaDataImporter.cs	(revision 105755)
+++ System.Data/XmlSchemaDataImporter.cs	(working copy)
@@ -500,6 +500,8 @@
 				ProcessDataSetElement (el);
 				return;
 			}
+			else
+				dataset.Locale = CultureInfo.CurrentCulture;
 
 			// Register as a top-level element
 			topLevelElements.Add (el);
@@ -512,9 +514,15 @@
 			dataset.DataSetName = el.Name;
 			this.datasetElement = el;
 
-			// Search for msdata:Locale attribute
+			// Search for locale attributes
+			bool useCurrent = false;
 			if (el.UnhandledAttributes != null) {
 				foreach (XmlAttribute attr in el.UnhandledAttributes) {
+#if NET_2_0
+					if (attr.LocalName == "UseCurrentLocale" &&
+						attr.NamespaceURI == XmlConstants.MsdataNamespace)
+						useCurrent = true;
+#endif
 					if (attr.LocalName == "Locale" &&
 						attr.NamespaceURI == XmlConstants.MsdataNamespace) {
 						CultureInfo ci = new CultureInfo (attr.Value);
@@ -522,6 +530,10 @@
 					}
 				}
 			}
+#if NET_2_0
+			if (!useCurrent && !dataset.LocaleSpecified) // then set current culture instance _explicitly_
+				dataset.Locale = CultureInfo.CurrentCulture;
+#endif
 
 			// Process content type particle (and create DataTable)
 			XmlSchemaComplexType ct = null;
Index: System.Data/DataTable.cs
===================================================================
--- System.Data/DataTable.cs	(revision 105755)
+++ System.Data/DataTable.cs	(working copy)
@@ -683,6 +683,10 @@
 			}
 		}
 
+		internal bool LocaleSpecified {
+			get { return _locale != null; }
+		}
+
 		/// <summary>
 		/// Gets or sets the initial starting size for this table.
 		/// </summary>
@@ -1186,7 +1190,7 @@
 				for (int i=0; i < ExtendedProperties.Count; i++)
 					Copy.ExtendedProperties.Add (tgtArray.GetValue (i), ExtendedProperties[tgtArray.GetValue (i)]);
 			}
-			Copy.Locale = Locale;
+			Copy._locale = _locale;
 			Copy.MinimumCapacity = MinimumCapacity;
 			Copy.Namespace = Namespace;
 			// Copy.ParentRelations
@@ -1721,7 +1725,7 @@
 			}
 
 			XmlSchemaWriter.WriteXmlSchema (writer, new DataTable [] { this }, 
-											null, TableName, dset.DataSetName);
+											null, TableName, dset.DataSetName, LocaleSpecified ? Locale : dset.LocaleSpecified ? dset.Locale : null);
 			dset.WriteIndividualTableContent (writer, this, XmlWriteMode.DiffGram);
 			writer.Flush ();
 
@@ -2659,6 +2663,8 @@
 
 		public void WriteXmlSchema (XmlWriter writer)
 		{
+			WriteXmlSchema (writer, false);
+/*
 			if (TableName == "") {
 				throw new InvalidOperationException ("Cannot serialize the DataTable. DataTable name is not set.");
 			}
@@ -2684,6 +2690,7 @@
 				if (tmp != null)
 					ds.Tables.Remove (this);
 			}
+*/
 		}
 
 		public void WriteXmlSchema (string fileName)
@@ -2732,10 +2739,10 @@
 			if (TableName == "") {
 				throw new InvalidOperationException ("Cannot serialize the DataTable. DataTable name is not set.");
 			}
-			if (writeHierarchy == false) {
-				WriteXmlSchema (writer);
-			}
-			else {
+//			if (writeHierarchy == false) {
+//				WriteXmlSchema (writer);
+//			}
+//			else {
 				DataSet ds = DataSet;
 				DataSet tmp = null;
 				try {
@@ -2752,7 +2759,7 @@
 					//	relations[i] = ds.Relations[i];
 					//}
 					DataRelation [] relations = null;
-					if (ChildRelations.Count > 0) {
+					if (writeHierarchy && ChildRelations.Count > 0) {
 						relations = new DataRelation [ChildRelations.Count];
 						for (int i = 0; i < ChildRelations.Count; i++) {
 							relations [i] = ChildRelations [i];
@@ -2769,12 +2776,12 @@
 						tableName = TableName;
 					else
 						tableName = ds.Namespace + "_x003A_" + TableName;
-					XmlSchemaWriter.WriteXmlSchema (writer, tables, relations, tableName, ds.DataSetName);
+					XmlSchemaWriter.WriteXmlSchema (writer, tables, relations, tableName, ds.DataSetName, LocaleSpecified ? Locale : ds.LocaleSpecified ? ds.Locale : null);
 				} finally {
 					if (tmp != null)
 						ds.Tables.Remove (this);
 				}
-			}
+//			}
 		}
 
 		public void WriteXmlSchema (string fileName, bool writeHierarchy)