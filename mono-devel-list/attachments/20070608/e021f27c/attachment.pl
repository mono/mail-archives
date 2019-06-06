Index: SqlDataReader.cs
===================================================================
--- SqlDataReader.cs	(revision 78931)
+++ SqlDataReader.cs	(working copy)
@@ -180,7 +180,6 @@
 			while (NextResult ())
 				;
 			isClosed = true;
-			command.Connection.DataReader = null;
 			command.CloseDataReader (moreResults);
 		}
 
@@ -1150,19 +1149,14 @@
 				readResultUsed = true;
 				return true;
 			}
-			
-			
 			return (ReadRecord ());
-
 		}
 
 		internal bool ReadRecord ()
 		{
-			
 			bool result = command.Tds.NextRow ();
 			
 			rowsRead += 1;
-			
 			return result;
 		}
 		
Index: SqlCommand.cs
===================================================================
--- SqlCommand.cs	(revision 78931)
+++ SqlCommand.cs	(working copy)
@@ -581,9 +581,8 @@
 			if (disposed) return;
 			if (disposing) {
 				parameters.Clear();
-				transaction = null;
-				connection = null;
 			}
+			base.Dispose (disposing);
 			disposed = true;
 		}
 #endif
