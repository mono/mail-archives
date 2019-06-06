Index: SqlDataReader.cs
===================================================================
--- SqlDataReader.cs	(revision 78706)
+++ SqlDataReader.cs	(working copy)
@@ -180,7 +180,7 @@
 			while (NextResult ())
 				;
 			isClosed = true;
-			command.Connection.DataReader = null;
+			//command.Connection.DataReader = null;
 			command.CloseDataReader (moreResults);
 		}
 
Index: SqlCommand.cs
===================================================================
--- SqlCommand.cs	(revision 78717)
+++ SqlCommand.cs	(working copy)
@@ -579,6 +579,7 @@
 		protected override void Dispose (bool disposing)
 		{
 			if (disposed) return;
+			base.Dispose (disposing);
 			if (disposing) {
 				parameters.Clear();
 				transaction = null;
