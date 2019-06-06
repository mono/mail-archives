Index: Test/System.Data/DataSetInferXmlSchemaTest.cs
===================================================================
--- Test/System.Data/DataSetInferXmlSchemaTest.cs	(revision 105755)
+++ Test/System.Data/DataSetInferXmlSchemaTest.cs	(working copy)
@@ -482,7 +482,7 @@
 		[ExpectedException (typeof (ConstraintException))]
 		public void ConflictExistingPrimaryKey ()
 		{
-			// The 'col' DataTable tries to create another primary key (and fails)
+			// <wrong>The 'col' DataTable tries to create another primary key (and fails)</wrong> The data violates key constraint.
 			DataSet ds = new DataSet ();
 			ds.Tables.Add (new DataTable ("table"));
 			DataColumn c = new DataColumn ("pk");
Index: System.Data/DataSet.cs
===================================================================
--- System.Data/DataSet.cs	(revision 105969)
+++ System.Data/DataSet.cs	(working copy)
@@ -1166,7 +1166,7 @@
 				retMode != XmlReadMode.ReadSchema &&
 				mode != XmlReadMode.IgnoreSchema &&
 				mode != XmlReadMode.Fragment &&
-				Tables.Count == 0) {
+				(Tables.Count == 0 || mode == XmlReadMode.InferSchema)) {
 				InferXmlSchema(doc, null);
 				if (mode == XmlReadMode.Auto)
 					retMode = XmlReadMode.InferSchema;
Index: System.Data/XmlDataInferenceLoader.cs
===================================================================
--- System.Data/XmlDataInferenceLoader.cs	(revision 105969)
+++ System.Data/XmlDataInferenceLoader.cs	(working copy)
@@ -207,19 +207,20 @@
 
 			int count = 0;			
 			foreach (TableMapping map in tables) {
+				string baseName = map.PrimaryKey != null ? map.PrimaryKey.ColumnName : map.Table.TableName + "_Id";
 				
 				// Make sure name of RK column is unique
-				string rkName = map.Table.TableName + "_Id";
+				string rkName = baseName;
 				if (map.ChildTables [map.Table.TableName] != null) {
-					rkName = map.Table.TableName + "_Id_" + count;
+					rkName = baseName + '_' + count;
 					while (map.GetColumn (rkName) != null) {
 						count++;
-						rkName = map.Table.TableName + "_Id_" + count;
+						rkName = baseName + '_' + count;
 					}
 				}
 				
 				foreach (TableMapping ct in map.ChildTables) {
-					ct.ReferenceKey = GetMappedColumn (ct, rkName, map.Table.Prefix, map.Table.Namespace, MappingType.Hidden);
+					ct.ReferenceKey = GetMappedColumn (ct, rkName, map.Table.Prefix, map.Table.Namespace, MappingType.Hidden, map.PrimaryKey != null ? map.PrimaryKey.DataType : typeof (int));
 				}
 			}
 
@@ -266,6 +267,8 @@
 					throw new DataException ("Parent column was not found :" + rs.ParentColumnName);
 				else if (cc == null)
 					throw new DataException ("Child column was not found :" + rs.ChildColumnName);
+Console.WriteLine (pc.ColumnName + pc.DataType);
+Console.WriteLine (cc.ColumnName + cc.DataType);
 				DataRelation rel = new DataRelation (relName, pc, cc, rs.CreateConstraint);
 				if (rs.IsNested) {
 					rel.Nested = true;
@@ -320,11 +323,6 @@
 
 		private void PopulatePrimaryKey (TableMapping table)
 		{
-			if (table.PrimaryKey != null) {
-				if (table.PrimaryKey.ColumnName != table.Table.TableName + "_Id")
-					throw new DataException ("There is already a primary key column.");
-				return;
-			}
 			DataColumn col = new DataColumn (table.Table.TableName + "_Id");
 			col.ColumnMapping = MappingType.Hidden;
 			col.DataType = typeof (int);
@@ -335,15 +333,15 @@
 			table.PrimaryKey = col;
 		}
 
-		private void PopulateRelationStructure (string parent, string child)
+		private void PopulateRelationStructure (string parent, string child, string pkeyColumn)
 		{
 			if (relations [parent, child] != null)
 				return;
 			RelationStructure rs = new RelationStructure ();
 			rs.ParentTableName = parent;
 			rs.ChildTableName = child;
-			rs.ParentColumnName = parent + "_Id";
-			rs.ChildColumnName = parent + "_Id";
+			rs.ParentColumnName = pkeyColumn;
+			rs.ChildColumnName = pkeyColumn;
 			rs.CreateConstraint = true;
 			rs.IsNested = true;
 			relations.Add (rs);
@@ -365,7 +363,7 @@
 			if (table.SimpleContent != null)
 				return;
 
-			GetMappedColumn (table, localName + "_Column", el.Prefix, el.NamespaceURI, MappingType.SimpleContent);
+			GetMappedColumn (table, localName + "_Column", el.Prefix, el.NamespaceURI, MappingType.SimpleContent, null);
 		}
 
 		private void InferTableElement (TableMapping parentTable, XmlElement el)
@@ -400,7 +398,8 @@
 					XmlHelper.Decode (attr.LocalName),
 					attr.Prefix,
 					attr.NamespaceURI,
-					MappingType.Attribute);
+					MappingType.Attribute,
+					null);
 			}
 
 			foreach (XmlNode n in el.ChildNodes) {
@@ -423,13 +422,15 @@
 						InferColumnElement (table, cel);
 						break;
 					case ElementMappingType.Repeated:
-						PopulatePrimaryKey (table);
-						PopulateRelationStructure (table.Table.TableName, childLocalName);
+						if (table.PrimaryKey == null)
+							PopulatePrimaryKey (table);
+						PopulateRelationStructure (table.Table.TableName, childLocalName, table.PrimaryKey.ColumnName);
 						InferRepeatedElement (table, cel);
 						break;
 					case ElementMappingType.Complex:
-						PopulatePrimaryKey (table);
-						PopulateRelationStructure (table.Table.TableName, childLocalName);
+						if (table.PrimaryKey == null)
+							PopulatePrimaryKey (table);
+						PopulateRelationStructure (table.Table.TableName, childLocalName, table.PrimaryKey.ColumnName);
 						InferTableElement (table, cel);
 						break;
 					}
@@ -440,7 +441,7 @@
 			// Attributes + !Children + Text = SimpleContent
 			if (table.SimpleContent == null // no need to create
 				&& !hasChildElements && hasText && (hasAttributes || isElementRepeated)) {
-				GetMappedColumn (table, table.Table.TableName + "_Text", String.Empty, String.Empty, MappingType.SimpleContent);
+				GetMappedColumn (table, table.Table.TableName + "_Text", String.Empty, String.Empty, MappingType.SimpleContent, null);
 			}
 		}
 
@@ -469,7 +470,7 @@
 			return map;
 		}
 
-		private DataColumn GetMappedColumn (TableMapping table, string name, string prefix, string ns, MappingType type)
+		private DataColumn GetMappedColumn (TableMapping table, string name, string prefix, string ns, MappingType type, Type optColType)
 		{
 			DataColumn col = table.GetColumn (name);
 			// Infer schema
@@ -490,7 +491,7 @@
 					break;
 				case MappingType.Hidden:
 					// To generate parent key
-					col.DataType = typeof (int);
+					col.DataType = optColType;
 					table.ReferenceKey = col;
 					break;
 				}