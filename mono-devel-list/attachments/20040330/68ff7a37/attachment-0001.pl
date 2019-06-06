? file.diff
Index: DataTableTest.cs
===================================================================
RCS file: /mono/mcs/class/System.Data/Test/System.Data/DataTableTest.cs,v
retrieving revision 1.11
diff -u -r1.11 DataTableTest.cs
--- DataTableTest.cs	29 Mar 2004 07:56:47 -0000	1.11
+++ DataTableTest.cs	30 Mar 2004 06:46:43 -0000
@@ -11,6 +11,7 @@
 using NUnit.Framework;
 using System;
 using System.Data;
+using System.Globalization;
 
 namespace MonoTests.System.Data
 {
@@ -745,6 +746,293 @@
 			AssertEquals ("test#16", "Column2", dt.PrimaryKey [1].ColumnName);
 			
 		}
+		
+		[Test]
+		public void PropertyExceptions ()
+		{
+			DataSet set = new DataSet ();
+			DataTable table = new DataTable ();
+			DataTable table1 =  new DataTable ();
+			set.Tables.Add (table);
+			set.Tables.Add (table1);
+
+			DataColumn col = new DataColumn ();
+			col.ColumnName = "Id";
+			col.DataType = System.Type.GetType ("System.Int32");
+			table.Columns.Add (col);
+			UniqueConstraint uc = new UniqueConstraint ("UK1", table.Columns[0] );
+			table.Constraints.Add (uc);
+			table.CaseSensitive = false;
+                                                                                                                           
+			col = new DataColumn ();
+			col.ColumnName = "Name";
+			col.DataType = System.Type.GetType ("System.String");
+			table.Columns.Add (col);
+        	        
+			col = new DataColumn ();
+			col.ColumnName = "Id";
+			col.DataType = System.Type.GetType ("System.Int32");
+			table1.Columns.Add (col);
+			col = new DataColumn ();
+			col.ColumnName = "Name";
+			col.DataType = System.Type.GetType ("System.String");
+			table1.Columns.Add (col);
+
+			DataRelation dr = new DataRelation ("DR", table.Columns[0], table1.Columns[0]);
+			set.Relations.Add (dr);
+
+			try {
+				table.CaseSensitive = true;
+				table1.CaseSensitive = true;
+				Fail ("#A01");
+			}
+			catch (Exception e) {
+				if (e.GetType () != typeof (AssertionException))
+					AssertEquals ("#A02", "Cannot change CaseSensitive or Locale property. This change would lead to at least one DataRelation or Constraint to have different Locale or CaseSensitive settings between its related tables.",e.Message);
+				else
+					Console.WriteLine (e);
+			}
+			try {
+				CultureInfo cultureInfo = new CultureInfo ("en-gb");
+				table.Locale = cultureInfo;
+				table1.Locale = cultureInfo;
+				Fail ("#A03");
+			}
+			catch (Exception e) {
+				 if (e.GetType () != typeof (AssertionException))
+					AssertEquals ("#A04", "Cannot change CaseSensitive or Locale property. This change would lead to at least one DataRelation or Constraint to have different Locale or CaseSensitive settings between its related tables.",e.Message);
+				else
+					Console.WriteLine (e);
+			}
+			try {
+				table.Prefix = "Prefix#1";
+				Fail ("#A05");
+			}
+			catch (Exception e){
+				if (e.GetType () != typeof (AssertionException))
+					AssertEquals ("#A06", "Prefix 'Prefix#1' is not valid, because it contains special characters.",e.Message);
+				else
+					Console.WriteLine (e);
+
+			}
+		}
+
+		[Test]
+		public void GetErrors ()
+		{
+			DataTable table = new DataTable ();
+
+			DataColumn col = new DataColumn ();
+			col.ColumnName = "Id";
+			col.DataType = System.Type.GetType ("System.Int32");
+			table.Columns.Add (col);
+                                                                                                                             
+			col = new DataColumn ();
+			col.ColumnName = "Name";
+			col.DataType = System.Type.GetType ("System.String");
+			table.Columns.Add (col);
+			
+			DataRow row = table.NewRow ();
+			row ["Id"] = 147;
+			row ["name"] = "Abc";
+			row.RowError = "Error#1";
+			table.Rows.Add (row);
+
+			AssertEquals ("#A01", 1, table.GetErrors ().Length);
+			AssertEquals ("#A02", "Error#1", (table.GetErrors ())[0].RowError);
+		}
+		[Test]
+		public void CloneCopyTest ()
+		{
+			DataTable table = new DataTable ();
+			table.TableName = "Table#1";
+			DataTable table1 = new DataTable ();
+			table1.TableName = "Table#2";
+                
+			table.AcceptChanges ();
+        	        
+			DataSet set = new DataSet ("Data Set#1");
+			set.DataSetName = "Dataset#1";
+			set.Tables.Add (table);
+			set.Tables.Add (table1);
+
+			DataColumn col = new DataColumn ();
+			col.ColumnName = "Id";
+			col.DataType = System.Type.GetType ("System.Int32");
+			table.Columns.Add (col);
+			UniqueConstraint uc = new UniqueConstraint ("UK1", table.Columns[0] );
+			table.Constraints.Add (uc);
+                
+			col = new DataColumn ();
+			col.ColumnName = "Id";
+			col.DataType = System.Type.GetType ("System.Int32");
+			table1.Columns.Add (col);
+                                                                                                                             
+			col = new DataColumn ();
+			col.ColumnName = "Name";
+			col.DataType = System.Type.GetType ("System.String");
+			table.Columns.Add (col);
+			
+			col = new DataColumn ();
+			col.ColumnName = "Name";
+			col.DataType = System.Type.GetType ("System.String");
+                	table1.Columns.Add (col);
+			DataRow row = table.NewRow ();
+			row ["Id"] = 147;
+			row ["name"] = "Abc";
+			row.RowError = "Error#1";
+			table.Rows.Add (row);
+                                                                                                                             
+			row = table.NewRow ();
+			row ["Id"] = 47;
+			row ["name"] = "Efg";
+			table.Rows.Add (row);
+			table.AcceptChanges ();
+                                                                                                                             
+			table.CaseSensitive = true;
+			table1.CaseSensitive = true;
+			table.MinimumCapacity = 100;
+			table.Prefix = "PrefixNo:1";
+			table.Namespace = "Namespace#1";
+			table.DisplayExpression = "Id / Name + (Id * Id)";
+			DataColumn[] colArray = {table.Columns[0]};
+			table.PrimaryKey = colArray;
+			table.ExtendedProperties.Add ("TimeStamp", DateTime.Now);
+			CultureInfo cultureInfo = new CultureInfo ("en-gb");
+			table.Locale = cultureInfo;
+
+			row = table1.NewRow ();
+			row ["Name"] = "Abc";
+			row ["Id"] = 147;
+			table1.Rows.Add (row);
+
+			row = table1.NewRow ();
+			row ["Id"] = 47;
+			row ["Name"] = "Efg";
+			table1.Rows.Add (row);
+                
+			DataRelation dr = new DataRelation ("DR", table.Columns[0], table1.Columns[0]);
+			set.Relations.Add (dr);
+
+			//Testing properties of clone
+			DataTable cloneTable = table.Clone ();
+			AssertEquals ("#A01",true ,cloneTable.CaseSensitive);
+			AssertEquals ("#A02", 0 , cloneTable.ChildRelations.Count);
+			AssertEquals ("#A03", 0 , cloneTable.ParentRelations.Count);
+			AssertEquals ("#A04", 2,  cloneTable.Columns.Count);
+			AssertEquals ("#A05", 1, cloneTable.Constraints.Count);
+			AssertEquals ("#A06", "Id / Name + (Id * Id)", cloneTable.DisplayExpression);
+			AssertEquals ("#A07", 1 ,cloneTable.ExtendedProperties.Count);
+			AssertEquals ("#A08", false ,cloneTable.HasErrors);
+			AssertEquals ("#A09", 2057, cloneTable.Locale.LCID);
+			AssertEquals ("#A10", 100, cloneTable.MinimumCapacity);
+			AssertEquals ("#A11","Namespace#1", cloneTable.Namespace);
+			AssertEquals ("#A12", "PrefixNo:1",cloneTable.Prefix);
+			AssertEquals ("#A13", "Id",  cloneTable.PrimaryKey[0].ColumnName);
+			AssertEquals ("#A14",0 , cloneTable.Rows.Count );
+			AssertEquals ("#A15", "Table#1", cloneTable.TableName);
+
+			//Testing properties of copy
+			DataTable copyTable = table.Copy ();
+			AssertEquals ("#A16",true ,copyTable.CaseSensitive);
+			AssertEquals ("#A17", 0 , copyTable.ChildRelations.Count);
+			AssertEquals ("#A18", 0 , copyTable.ParentRelations.Count);
+			AssertEquals ("#A19", 2,  copyTable.Columns.Count);
+			AssertEquals ("#A20", 1, copyTable.Constraints.Count);
+			AssertEquals ("#A21", "Id / Name + (Id * Id)", copyTable.DisplayExpression);
+			AssertEquals ("#A22", 1 ,copyTable.ExtendedProperties.Count);
+			AssertEquals ("#A23", true ,copyTable.HasErrors);
+			AssertEquals ("#A24", 2057, copyTable.Locale.LCID);
+			AssertEquals ("#A25", 100, copyTable.MinimumCapacity);
+			AssertEquals ("#A26","Namespace#1", copyTable.Namespace);
+			AssertEquals ("#A27", "PrefixNo:1",copyTable.Prefix);
+			AssertEquals ("#A28", "Id",  copyTable.PrimaryKey[0].ColumnName);
+			AssertEquals ("#A29", 2 , copyTable.Rows.Count );
+			AssertEquals ("#A30", "Table#1", copyTable.TableName);
+		}
+
+		[Test]
+		public void LoadDataException ()
+		{
+			DataTable table = new DataTable ();
+			DataColumn col = new DataColumn ();
+			col.ColumnName = "Id";
+			col.DataType = System.Type.GetType ("System.Int32");
+			col.DefaultValue = 47;
+			table.Columns.Add (col);
+			UniqueConstraint uc = new UniqueConstraint ("UK1", table.Columns[0] );
+			table.Constraints.Add (uc);
+                
+			col = new DataColumn ();
+			col.ColumnName = "Name";
+			col.DataType = System.Type.GetType ("System.String");
+			col.DefaultValue = "Hello";
+			table.Columns.Add (col);
+                
+			table.BeginLoadData();
+			object[] row = {147, "Abc"};
+			DataRow newRow = table.LoadDataRow (row, true);
+                
+			object[] row1 = {147, "Efg"};
+			DataRow newRow1 = table.LoadDataRow (row1, true);
+                                                                                                                             
+			object[] row2 = {143, "Hij"};
+			DataRow newRow2 = table.LoadDataRow (row2, true);
+                                                                                                                             
+			try {
+				table.EndLoadData ();
+				Fail ("#A01");
+			}
+			catch (Exception e) {
+				if (e.GetType () != typeof (AssertionException))
+					AssertEquals ("#A02", "Column 'Id + ' contains non-unique values",e.Message);
+                                else
+                                        Console.WriteLine (e);
+
+			}
+		}
+		[Test]
+		public void GetChanges ()
+		{
+			DataTable table = new DataTable ();
 
+			DataColumn col = new DataColumn ();
+			col.ColumnName = "Id";
+			col.DataType = System.Type.GetType ("System.Int32");
+			table.Columns.Add (col);
+			UniqueConstraint uc = new UniqueConstraint ("UK1", table.Columns[0] );
+			table.Constraints.Add (uc);
+                                                                                                                             
+			col = new DataColumn ();
+			col.ColumnName = "Name";
+			col.DataType = System.Type.GetType ("System.String");
+			table.Columns.Add (col);			
+
+			DataRow row = table.NewRow ();
+			row ["Id"] = 147;
+			row ["name"] = "Abc";
+			table.Rows.Add (row);
+			table.AcceptChanges ();
+                        
+			row = table.NewRow ();
+			row ["Id"] = 47;
+			row ["name"] = "Efg";
+			table.Rows.Add (row);
+
+			DataTable changesTable = table.GetChanges ();
+			AssertEquals ("#A01", 1 ,changesTable.Rows.Count);
+ 			AssertEquals ("#A02","Efg" ,changesTable.Rows[0]["Name"]);               	
+			table.AcceptChanges ();
+			changesTable = table.GetChanges ();
+			try {
+				int cnt = changesTable.Rows.Count;
+			}
+			catch(Exception e) {
+				if (e.GetType () != typeof (AssertionException))
+					AssertEquals ("#A03",typeof(NullReferenceException) ,e.GetType ());
+				else
+					Console.WriteLine (e);
+			}
+		}
 	}
-}
+
