--- mono.head/mcs/class/System.Data/System.Data.SqlClient/SqlDataReader.cs	2010-04-09 14:53:12.000000000 +0200
+++ mono/mcs/class/System.Data/System.Data.SqlClient/SqlDataReader.cs	2010-04-09 07:11:45.000000000 +0200
@@ -1430,29 +1430,40 @@
 #if NET_2_0
 		override
 #endif // NET_2_0
-		int GetValues (object[] values)
-		{
-			ValidateState ();
-			EnsureDataAvailable ();
-
-			if (values == null)
-				throw new ArgumentNullException ("values");
-
-			int len = values.Length;
-			int bigDecimalIndex = command.Tds.ColumnValues.BigDecimalIndex;
-
-			// If a four-byte decimal is stored, then we can't convert to
-			// a native type.  Throw an OverflowException.
-			if (bigDecimalIndex >= 0 && bigDecimalIndex < len)
-				throw new OverflowException ();
-			try {
-				command.Tds.ColumnValues.CopyTo (0, values, 0,
-								 len > command.Tds.ColumnValues.Count ? command.Tds.ColumnValues.Count : len);
-			} catch (TdsInternalException ex) {
-				command.Connection.Close ();
-				throw SqlException.FromTdsInternalException ((TdsInternalException) ex);
+		int GetValues (object[] values)
+		{
+			ValidateState ();
+			EnsureDataAvailable ();
+
+			if (values == null)
+				throw new ArgumentNullException ("values");
+
+			int len = values.Length;
+			if( command.Tds.ColumnValues != null )
+			{
+				int bigDecimalIndex = command.Tds.ColumnValues.BigDecimalIndex;
+	
+				// If a four-byte decimal is stored, then we can't convert to
+				// a native type.  Throw an OverflowException.
+				if (bigDecimalIndex >= 0 && bigDecimalIndex < len)
+					throw new OverflowException ();
 			}
-			return (len < FieldCount ? len : FieldCount);
+			
+			try {
+                		if (len > command.Tds.Columns.Count)
+                    			len = command.Tds.Columns.Count;
+
+                		if ((command.CommandBehavior & CommandBehavior.SequentialAccess) != 0) {
+                    			for( int colIdx=0; colIdx<len; colIdx++ )
+                        			values[colIdx] = ((Tds)command.Tds).GetSequentialColumnValue (colIdx);
+                		}
+				else
+					command.Tds.ColumnValues.CopyTo (0, values, 0, len);
+			} catch (TdsInternalException ex) {
+				command.Connection.Close ();
+				throw SqlException.FromTdsInternalException ((TdsInternalException) ex);
+			}
+			return (len < FieldCount ? len : FieldCount);
 		}
 
 #if !NET_2_0