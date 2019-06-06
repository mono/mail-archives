--- mono.head/mcs/class/System.Data/System.Data.SqlClient/SqlDataReader.cs	2010-04-09 17:10:19.000000000 +0200
+++ mono/mcs/class/System.Data/System.Data.SqlClient/SqlDataReader.cs	2010-04-09 17:22:35.000000000 +0200
@@ -1439,15 +1439,25 @@
 				throw new ArgumentNullException ("values");
 
 			int len = values.Length;
+			if( command.Tds.ColumnValues != null ) {
 			int bigDecimalIndex = command.Tds.ColumnValues.BigDecimalIndex;
 
 			// If a four-byte decimal is stored, then we can't convert to
 			// a native type.  Throw an OverflowException.
 			if (bigDecimalIndex >= 0 && bigDecimalIndex < len)
 				throw new OverflowException ();
+			}
+			
 			try {
-				command.Tds.ColumnValues.CopyTo (0, values, 0,
-								 len > command.Tds.ColumnValues.Count ? command.Tds.ColumnValues.Count : len);
+				if (len > command.Tds.Columns.Count)
+					len = command.Tds.Columns.Count;
+
+				if ((command.CommandBehavior & CommandBehavior.SequentialAccess) != 0) {
+					for( int colIdx=0; colIdx<len; colIdx++ )
+						values[colIdx] = ((Tds)command.Tds).GetSequentialColumnValue (colIdx);
+                		}
+				else
+					command.Tds.ColumnValues.CopyTo (0, values, 0, len);
 			} catch (TdsInternalException ex) {
 				command.Connection.Close ();
 				throw SqlException.FromTdsInternalException ((TdsInternalException) ex);
