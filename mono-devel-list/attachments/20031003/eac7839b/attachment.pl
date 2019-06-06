Index: Mono.Data.Tds/Mono.Data.Tds.Protocol/Tds70.cs
===================================================================
RCS file: /mono/mcs/class/Mono.Data.Tds/Mono.Data.Tds.Protocol/Tds70.cs,v
retrieving revision 1.19
diff -u -b -w -p -u -r1.19 Tds70.cs
--- Mono.Data.Tds/Mono.Data.Tds.Protocol/Tds70.cs	20 Jan 2003 17:57:06 -0000	1.19
+++ Mono.Data.Tds/Mono.Data.Tds.Protocol/Tds70.cs	3 Oct 2003 10:45:15 -0000
@@ -3,6 +3,7 @@
 //
 // Author:
 //   Tim Coleman (tim@timcoleman.com)
+//   Diego Caravana (diego@toth.it)
 //
 // Copyright (C) 2002 Tim Coleman
 //
@@ -51,10 +52,15 @@ namespace Mono.Data.Tds.Protocol {
 
 			StringBuilder result = new StringBuilder ();
 			foreach (TdsMetaParameter p in Parameters) {
+				if (p.Direction != TdsParameterDirection.ReturnValue) {
 				if (result.Length > 0)
 					result.Append (", ");
+					if (p.Direction == TdsParameterDirection.InputOutput)
+						result.Append (String.Format("{0}={0} output", p.ParameterName));
+					else
 				result.Append (FormatParameter (p));
 			}
+			}
 			return result.ToString ();
 		}
 
@@ -78,28 +84,42 @@ namespace Mono.Data.Tds.Protocol {
 
 		private string BuildProcedureCall (string procedure)
 		{
+			string exec = String.Empty;
+
 			StringBuilder declare = new StringBuilder ();
 			StringBuilder select = new StringBuilder ();
 			StringBuilder set = new StringBuilder ();
+			
 			int count = 0;
 			if (Parameters != null) {
 				foreach (TdsMetaParameter p in Parameters) {
-					if (p.Direction == TdsParameterDirection.Output) {
-						declare.Append (String.Format ("declare {0}\n", p.Prepare ()));
+					if (p.Direction != TdsParameterDirection.Input) {
+
 						if (count == 0)
 							select.Append ("select ");
 						else
 							select.Append (", ");
+						select.Append (p.ParameterName);
 							
+						declare.Append (String.Format ("declare {0}\n", p.Prepare ()));
+
+						if (p.Direction != TdsParameterDirection.ReturnValue) {
+							if( p.Direction == TdsParameterDirection.InputOutput )
+								set.Append (String.Format ("set {0}\n", FormatParameter(p)));
+							else
 						set.Append (String.Format ("set {0}=NULL\n", p.ParameterName));
-						select.Append (p.ParameterName);
+						}
+					
 						count += 1;
 					}
+					
+					if (p.Direction == TdsParameterDirection.ReturnValue) {
+						exec = p.ParameterName + "=";
+					}
 				}
 			}
-			string exec = String.Empty;
-			if (count > 0)
-				exec = "exec ";
+			if (count > 0 || exec.Length > 0)
+				exec = "exec " + exec;
 
 			return String.Format ("{0}{1}{2}{3} {4}\n{5}", declare.ToString (), set.ToString (), exec, procedure, BuildParameters (), select.ToString ());	
 		}
Index: System.Data/System.Data.SqlClient/SqlCommand.cs
===================================================================
RCS file: /mono/mcs/class/System.Data/System.Data.SqlClient/SqlCommand.cs,v
retrieving revision 1.52
diff -u -b -w -p -u -r1.52 SqlCommand.cs
--- System.Data/System.Data.SqlClient/SqlCommand.cs	22 Aug 2003 04:37:10 -0000	1.52
+++ System.Data/System.Data.SqlClient/SqlCommand.cs	3 Oct 2003 10:45:15 -0000
@@ -5,6 +5,7 @@
 //   Rodrigo Moya (rodrigo@ximian.com)
 //   Daniel Morgan (danmorg@sc.rr.com)
 //   Tim Coleman (tim@timcoleman.com)
+//   Diego Caravana (diego@toth.it)
 //
 // (C) Ximian, Inc 2002 http://www.ximian.com/
 // (C) Daniel Morgan, 2002
@@ -307,6 +308,7 @@ namespace System.Data.SqlClient {
 			catch (TdsTimeoutException e) {
 				throw SqlException.FromTdsInternalException ((TdsInternalException) e);
 			}
+
 			Connection.DataReader = new SqlDataReader (this);
 			return Connection.DataReader;
 		}
@@ -350,6 +352,7 @@ namespace System.Data.SqlClient {
 			IList list = Connection.Tds.OutputParameters;
 
 			if (list != null && list.Count > 0) {
+
 				int index = 0;
 				foreach (SqlParameter parameter in parameters) {
 					if (parameter.Direction != ParameterDirection.Input) {
Index: System.Data/System.Data.SqlClient/SqlConnection.cs
===================================================================
RCS file: /mono/mcs/class/System.Data/System.Data.SqlClient/SqlConnection.cs,v
retrieving revision 1.41
diff -u -b -w -p -u -r1.41 SqlConnection.cs
--- System.Data/System.Data.SqlClient/SqlConnection.cs	15 Mar 2003 10:18:39 -0000	1.41
+++ System.Data/System.Data.SqlClient/SqlConnection.cs	3 Oct 2003 10:45:15 -0000
@@ -6,6 +6,7 @@
 //   Daniel Morgan (danmorg@sc.rr.com)
 //   Tim Coleman (tim@timcoleman.com)
 //   Phillip Jerkins (Phillip.Jerkins@morgankeegan.com)
+//   Diego Caravana (diego@toth.it)
 //
 // Copyright (C) Ximian, Inc 2002
 // Copyright (C) Daniel Morgan 2002, 2003
@@ -256,18 +257,20 @@ namespace System.Data.SqlClient {
 				transaction.Rollback ();
 
 			if (dataReader != null || xmlReader != null) {
-				tds.SkipToEnd ();
+				if(tds != null) tds.SkipToEnd ();
 				dataReader = null;
 				xmlReader = null;
 			}
 
 			if (pooling)
-				pool.ReleaseConnection (tds);
+				if(pool != null) pool.ReleaseConnection (tds);
 			else
-				tds.Disconnect ();
+				if(tds != null) tds.Disconnect ();
 
+			if(tds != null) {
 			tds.TdsErrorMessage -= new TdsInternalErrorMessageEventHandler (ErrorHandler);
 			tds.TdsInfoMessage -= new TdsInternalInfoMessageEventHandler (MessageHandler);
+			}
 
 			ChangeState (ConnectionState.Closed);
 		}
Index: System.Data/System.Data.SqlClient/SqlParameter.cs
===================================================================
RCS file: /mono/mcs/class/System.Data/System.Data.SqlClient/SqlParameter.cs,v
retrieving revision 1.23
diff -u -b -w -p -u -r1.23 SqlParameter.cs
--- System.Data/System.Data.SqlClient/SqlParameter.cs	26 Nov 2002 06:33:28 -0000	1.23
+++ System.Data/System.Data.SqlClient/SqlParameter.cs	3 Oct 2003 10:45:15 -0000
@@ -5,6 +5,7 @@
 //   Rodrigo Moya (rodrigo@ximian.com)
 //   Daniel Morgan (danmorg@sc.rr.com)
 //   Tim Coleman (tim@timcoleman.com)
+//   Diego Caravana (diego@toth.it)
 //
 // (C) Ximian, Inc. 2002
 // Copyright (C) Tim Coleman, 2002
@@ -146,8 +147,17 @@ namespace System.Data.SqlClient {
 			get { return direction; }
 			set { 
 				direction = value; 
-				if (direction == ParameterDirection.Output)
+				switch( direction ) {
+					case ParameterDirection.Output:
 					MetaParameter.Direction = TdsParameterDirection.Output;
+						break;
+					case ParameterDirection.InputOutput:
+						MetaParameter.Direction = TdsParameterDirection.InputOutput;
+						break;
+					case ParameterDirection.ReturnValue:
+						MetaParameter.Direction = TdsParameterDirection.ReturnValue;
+						break;
+				}
 			}
 		}
 
Index: System.Data/System.Data.SqlClient/SqlParameterCollection.cs
===================================================================
RCS file: /mono/mcs/class/System.Data/System.Data.SqlClient/SqlParameterCollection.cs,v
retrieving revision 1.16
diff -u -b -w -p -u -r1.16 SqlParameterCollection.cs
--- System.Data/System.Data.SqlClient/SqlParameterCollection.cs	26 Nov 2002 06:33:28 -0000	1.16
+++ System.Data/System.Data.SqlClient/SqlParameterCollection.cs	3 Oct 2003 10:45:15 -0000
@@ -5,6 +5,7 @@
 //   Rodrigo Moya (rodrigo@ximian.com)
 //   Daniel Morgan (danmorg@sc.rr.com)
 //   Tim Coleman (tim@timcoleman.com)
+//   Diego Caravana (diego@toth.it)
 //
 // (C) Ximian, Inc 2002
 // Copyright (C) Tim Coleman, 2002
@@ -187,7 +188,13 @@ namespace System.Data.SqlClient {
 		
 		public int IndexOf (string parameterName)
 		{
-			return list.IndexOf (parameterName);
+			int i=0;
+			for( ; i < list.Count; i++ ) {
+				if (((SqlParameter )list[i]).ParameterName.Equals (parameterName))
+					break;
+			}
+
+			return i;
 		}
 
 		public void Insert (int index, object value)
