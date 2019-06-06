Index: OdbcDataReader.cs
===================================================================
--- OdbcDataReader.cs	(revision 107477)
+++ OdbcDataReader.cs	(working copy)
@@ -75,7 +75,7 @@
 			short colcount = 0;
 			libodbc.SQLNumResultCols (hstmt, ref colcount);
 			cols = new OdbcColumn [colcount];
-			GetSchemaTable ();
+			GetColumns ();
 		}
 
 		internal OdbcDataReader (OdbcCommand command, CommandBehavior behavior,
@@ -225,6 +225,13 @@
 			}
 			return cols [ordinal];
 		}
+		
+		// Load all column descriptions
+		private void GetColumns ()
+		{
+			for(int i = 0; i < cols.Length; i++)
+				GetColumn (i);
+		}
 
 		public
 #if NET_2_0
@@ -913,7 +920,7 @@
 				libodbc.SQLNumResultCols (hstmt, ref colcount);
 				cols = new OdbcColumn [colcount];
 				_dataTableSchema = null; // force fresh creation
-				GetSchemaTable ();
+				GetColumns ();
 			}
 			return (ret == OdbcReturn.Success);
 		}


