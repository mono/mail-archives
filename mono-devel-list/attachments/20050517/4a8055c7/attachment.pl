Index: System.Data.Common/DbDataAdapter.cs
===================================================================
--- System.Data.Common/DbDataAdapter.cs	(revision 44571)
+++ System.Data.Common/DbDataAdapter.cs	(working copy)
@@ -618,11 +618,16 @@
 								Array.Copy(mapping,col.Ordinal,tmp,col.Ordinal + 1,mapping.Length - col.Ordinal);
 								mapping = tmp;
 							}				
-							bool isAutoIncrement = (bool)schemaRow["IsAutoIncrement"];
-							bool allowDBNull = (bool)schemaRow["AllowDBNull"];
-							bool isReadOnly =(bool)schemaRow["IsReadOnly"];
-							bool isKey = (bool)schemaRow["IsKey"];							
-							bool isUnique = (bool)schemaRow["IsUnique"];
+							object value = schemaRow["IsAutoIncrement"];
+							bool isAutoIncrement = value is bool ? (bool)value : false;
+							value = schemaRow["AllowDBNull"];
+							bool allowDBNull = value is bool ? (bool)value : false;
+							value = schemaRow["IsReadOnly"];
+							bool isReadOnly = value is bool ? (bool)value : false;
+							value = schemaRow["IsKey"];							
+							bool isKey = value is bool ? (bool)value : false;
+							value = schemaRow["IsUnique"];
+							bool isUnique = value is bool ? (bool)value : false;
 
                             if (missingSchAction == MissingSchemaAction.AddWithKey) {
 								// fill woth key info								
