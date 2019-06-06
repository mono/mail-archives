Index: System.Data.Common/DbDataAdapter.cs
===================================================================
--- System.Data.Common/DbDataAdapter.cs	(revision 44571)
+++ System.Data.Common/DbDataAdapter.cs	(working copy)
@@ -570,14 +570,25 @@
 			ArrayList primaryKey = new ArrayList ();
 			ArrayList sourceColumns = new ArrayList ();
 			bool createPrimaryKey = true;
+			
+			DataTable schemaTable = reader.GetSchemaTable ();
+			int colIndex;
+			DataColumn ColumnNameCol		= ((colIndex = schemaTable.Columns.IndexOf("ColumnName")) >= 0) ? schemaTable.Columns[colIndex] : null;
+			DataColumn DataTypeCol			= ((colIndex = schemaTable.Columns.IndexOf("DataType")) >= 0) ? schemaTable.Columns[colIndex] : null;
+			DataColumn IsAutoIncrementCol	= ((colIndex = schemaTable.Columns.IndexOf("IsAutoIncrement")) >= 0) ? schemaTable.Columns[colIndex] : null;
+			DataColumn AllowDBNullCol		= ((colIndex = schemaTable.Columns.IndexOf("AllowDBNull")) >= 0) ? schemaTable.Columns[colIndex] : null;
+			DataColumn IsReadOnlyCol		= ((colIndex = schemaTable.Columns.IndexOf("IsReadOnly")) >= 0) ? schemaTable.Columns[colIndex] : null;
+			DataColumn IsKeyCol				= ((colIndex = schemaTable.Columns.IndexOf("IsKey")) >= 0) ? schemaTable.Columns[colIndex] : null;
+			DataColumn IsUniqueCol			= ((colIndex = schemaTable.Columns.IndexOf("IsUnique")) >= 0) ? schemaTable.Columns[colIndex] : null;
+			DataColumn ColumnSizeCol		= ((colIndex = schemaTable.Columns.IndexOf("ColumnSize")) >= 0) ? schemaTable.Columns[colIndex] : null;
 
-			foreach (DataRow schemaRow in reader.GetSchemaTable ().Rows) {
+			foreach (DataRow schemaRow in schemaTable.Rows) {
 				// generate a unique column name in the source table.
 				string sourceColumnName;
-				if (schemaRow.IsNull("ColumnName"))
+				if (ColumnNameCol == null || schemaRow.IsNull(ColumnNameCol))
 					sourceColumnName = DefaultSourceColumnName;
 				else 
-					sourceColumnName = (string) schemaRow ["ColumnName"];
+					sourceColumnName = (string) schemaRow [ColumnNameCol];
 
 				string realSourceColumnName = sourceColumnName;
 
@@ -597,7 +608,7 @@
 					DataColumnMapping columnMapping = DataColumnMappingCollection.GetColumnMappingBySchemaAction(tableMapping.ColumnMappings, realSourceColumnName, missingMapAction);
 					if (columnMapping != null)
 					{
-						Type columnType = (Type)schemaRow["DataType"];
+						Type columnType = (Type)schemaRow[DataTypeCol];
 						DataColumn col =
 							columnMapping.GetDataColumnBySchemaAction(
 							table ,
@@ -618,13 +629,21 @@
 								Array.Copy(mapping,col.Ordinal,tmp,col.Ordinal + 1,mapping.Length - col.Ordinal);
 								mapping = tmp;
 							}				
-							bool isAutoIncrement = (bool)schemaRow["IsAutoIncrement"];
-							bool allowDBNull = (bool)schemaRow["AllowDBNull"];
-							bool isReadOnly =(bool)schemaRow["IsReadOnly"];
-							bool isKey = (bool)schemaRow["IsKey"];							
-							bool isUnique = (bool)schemaRow["IsUnique"];
 
+							object value = (AllowDBNullCol != null) ? schemaRow[AllowDBNullCol] : null;
+							bool allowDBNull = value is bool ? (bool)value : false;
+							value = (IsKeyCol != null) ? schemaRow[IsKeyCol] : null;
+							bool isKey = value is bool ? (bool)value : false;
+
                             if (missingSchAction == MissingSchemaAction.AddWithKey) {
+	                            
+	                            value = (IsAutoIncrementCol != null) ? schemaRow[IsAutoIncrementCol] : null;
+								bool isAutoIncrement = value is bool ? (bool)value : false;
+								value = (IsReadOnlyCol != null) ? schemaRow[IsReadOnlyCol] : null;
+								bool isReadOnly = value is bool ? (bool)value : false;
+								value = (IsUniqueCol != null) ? schemaRow[IsUniqueCol] : null;
+								bool isUnique = value is bool ? (bool)value : false;
+								
 								// fill woth key info								
 								if (isAutoIncrement && DataColumn.CanAutoIncrement(columnType)) {
 									col.AutoIncrement = true;
@@ -633,19 +652,19 @@
 								}
 
 								if (columnType == DbTypes.TypeOfString) {
-									col.MaxLength = (int)schemaRow["ColumnSize"];
+									col.MaxLength = (ColumnSizeCol != null) ? (int)schemaRow[ColumnSizeCol] : 0;
 								}
 
 								if (isReadOnly)
 									col.ReadOnly = true;
-							}
-																					
-							if (!allowDBNull && (!isReadOnly || isKey))
-								col.AllowDBNull = false;
-							if (isUnique && !isKey && !columnType.IsArray) {
-								col.Unique = true;
-								if (!allowDBNull)
+									
+								if (!allowDBNull && (!isReadOnly || isKey))
 									col.AllowDBNull = false;
+								if (isUnique && !isKey && !columnType.IsArray) {
+									col.Unique = true;
+									if (!allowDBNull)
+										col.AllowDBNull = false;
+								}
 							}
 
 							if (isKey) {
