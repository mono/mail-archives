Index: class/System.Data.OracleClient/System.Data.OracleClient/OracleConnection.cs
===================================================================
RCS file: /mono/mcs/class/System.Data.OracleClient/System.Data.OracleClient/OracleConnection.cs,v
retrieving revision 1.9
diff -u -p -r1.9 OracleConnection.cs
--- class/System.Data.OracleClient/System.Data.OracleClient/OracleConnection.cs	8 Mar 2003 22:37:09 -0000	1.9
+++ class/System.Data.OracleClient/System.Data.OracleClient/OracleConnection.cs	7 Apr 2003 19:27:40 -0000
@@ -63,7 +63,7 @@ namespace System.Data.OracleClient 
 		public OracleConnection (string connectionString) 
 			: this() 
 		{
-			this.connectionString = connectionString;
+			SetConnectionString (connectionString);
 		}
 
 		#endregion // Constructors
