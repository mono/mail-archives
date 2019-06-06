Index: Test/System.Data/DataRowTest2.cs
===================================================================
--- Test/System.Data/DataRowTest2.cs	(revision 47411)
+++ Test/System.Data/DataRowTest2.cs	(working copy)
@@ -1283,5 +1283,40 @@
 			// ToString
 			Assert.AreEqual(true, dr.ToString().ToLower().StartsWith("system.data.datarow") , "DRW123");
 		}
+		
+		[Test] public void DataRow_RowError()
+		{
+			DataTable dt = new DataTable ("myTable"); 
+			DataRow dr = dt.NewRow ();
+	
+			Assert.AreEqual ( dr.RowError, string.Empty );
+						
+			dr.RowError = "Err";
+	        Assert.AreEqual ( dr.RowError , "Err" );
+		}
+		
+		[Test] 
+		[ExpectedException (typeof (ConstraintException))]
+		public void DataRow_RowError2()
+		{
+			DataTable dt1 = DataProvider.CreateUniqueConstraint();
+
+			dt1.BeginLoadData();
+
+			DataRow  dr = dt1.NewRow();
+			dr[0] = 3;
+			dt1.Rows.Add(dr);
+			dt1.EndLoadData();
+		}
+		
+		[Test] 
+		[ExpectedException (typeof (ConstraintException))]
+		public void DataRow_RowError3()
+		{
+			DataSet ds= DataProvider.CreateForigenConstraint();
+			ds.Tables[0].BeginLoadData();
+			ds.Tables[0].Rows[0][0] = 10; 
+			ds.Tables[0].EndLoadData(); //Foreign constraint violation
+		}
 	}
 }
Index: System.Data/ForeignKeyConstraint.cs
===================================================================
--- System.Data/ForeignKeyConstraint.cs	(revision 47411)
+++ System.Data/ForeignKeyConstraint.cs	(working copy)
@@ -478,7 +478,7 @@
 			if (Table.DataSet == null || RelatedTable.DataSet == null) 
 				return false;
 			
-			if (!Table.DataSet.EnforceConstraints)
+			if (!Table.DataSet.EnforceConstraints && !Table.EnforceConstraints)
 				return false;
 				
 			bool hasErrors = false;
Index: System.Data/DataTable.cs
===================================================================
--- System.Data/DataTable.cs	(revision 47411)
+++ System.Data/DataTable.cs	(working copy)
@@ -559,7 +559,7 @@
 			}
 		}
 		
-		private bool EnforceConstraints {
+		internal bool EnforceConstraints {
 			get { return enforceConstraints; }
 			set {
 				if (value != enforceConstraints) {
