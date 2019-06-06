Index: SqliteTransaction.cs
===================================================================
--- SqliteTransaction.cs	(revision 42995)
+++ SqliteTransaction.cs	(working copy)
@@ -100,7 +100,7 @@
 			try 
 			{
 				SqliteCommand cmd = _connection.CreateCommand();
-				cmd.CommandText = "COMMIT";
+				cmd.CommandText = "ROLLBACK";
 				cmd.ExecuteNonQuery();
 				_open = false;
 			}