Index: Mono.Data.SqliteClient/SqliteParameterCollection.cs
===================================================================
--- Mono.Data.SqliteClient/SqliteParameterCollection.cs	(revision 44904)
+++ Mono.Data.SqliteClient/SqliteParameterCollection.cs	(working copy)
@@ -4,8 +4,11 @@
 // Represents a collection of parameters relevant to a SqliteCommand as well as 
 // their respective mappings to columns in a DataSet.
 //
-// Author(s): Vladimir Vukicevic  <vladimir@pobox.com>
-//            Everaldo Canuto  <everaldo_canuto@yahoo.com.br>
+//Author(s):		Vladimir Vukicevic  <vladimir@pobox.com>
+//			Everaldo Canuto  <everaldo_canuto@yahoo.com.br>
+//			Chris Turchin <chris@turchin.net>
+//			Jeroen Zwartepoorte <jeroen@xs4all.net>
+//			Thomas Zoechling <thomas.zoechling@gmx.at>
 //
 // Copyright (C) 2002  Vladimir Vukicevic
 //
@@ -46,85 +49,148 @@
 		#endregion
 
 		#region Private Methods
-		
+
 		private void CheckSqliteParam (object value)
 		{
 			if (!(value is SqliteParameter))
-				throw new InvalidCastException("Can only use SqliteParameter objects");
-		}
+				throw new InvalidCastException ("Can only use SqliteParameter objects");
+			SqliteParameter sqlp = value as SqliteParameter;
+			if (sqlp.ParameterName == null || sqlp.ParameterName.Length == 0)
+				sqlp.ParameterName = this.GenerateParameterName();
+                 }
 
 		private void RecreateNamedHash ()
 		{
-			for (int i = 0; i < numeric_param_list.Count; i++) {
+			for (int i = 0; i < numeric_param_list.Count; i++) 
+			{
 				named_param_hash[((SqliteParameter) numeric_param_list[i]).ParameterName] = i;
 			}
 		}
-		
+
+		//FIXME: if the user is calling Insert at various locations with unnamed parameters, this is not going to work....
+		private string GenerateParameterName()
+		{
+			int		index	= this.Count + 1;
+			string	name	= String.Empty;
+
+			while (index > 0)
+			{
+				name = ":" + index.ToString();
+					if (this.IndexOf(name) == -1)
+					index = -1;
+				else
+				index++;
+			}
+			return name;
+		}
+
 		#endregion
 
 		#region Properties
 		
 		object IList.this[int index] {
-			get {
+			get 
+			{
 				return this[index];
 			}
-			set {
+			set 
+			{
 				CheckSqliteParam (value);
 				this[index] = (SqliteParameter) value;
 			}
 		}
 		
 		object IDataParameterCollection.this[string parameterName] {
-			get {
+			get 
+			{
 				return this[parameterName];
 			}
-			set {
+			set 
+			{
 				CheckSqliteParam (value);
 				this[parameterName] = (SqliteParameter) value;
 			}
 		}
 		
-		public SqliteParameter this[string parameterName] {
-			get {
-				return this[(int) named_param_hash[parameterName]];
+		public SqliteParameter this[string parameterName] 
+		{
+			get 
+			{
+				if (this.Contains(parameterName))
+					return this[(int) named_param_hash[parameterName]];
+				else
+					throw new IndexOutOfRangeException("The specified name does not exist: " + parameterName);
 			}
-			set {
-				if (this.Contains (parameterName))
+			set
+			{
+				if (this.Contains(parameterName))
 					numeric_param_list[(int) named_param_hash[parameterName]] = value;
-				else          // uhm, do we add it if it doesn't exist? what does ms do?
-					Add (value);
+				else
+					throw new IndexOutOfRangeException("The specified name does not exist: " + parameterName);
 			}
 		}
-		
-		public SqliteParameter this[int parameterIndex] {
-			get {
-				return (SqliteParameter) numeric_param_list[parameterIndex];
+
+		public SqliteParameter this[int parameterIndex]
+		{
+			get
+			{
+				if (this.Count >= parameterIndex+1)
+					return (SqliteParameter) numeric_param_list[parameterIndex];
+				else          
+					throw new IndexOutOfRangeException("The specified parameter index does not exist: " + parameterIndex.ToString());
 			}
-			set {
-				numeric_param_list[parameterIndex] = value;
+			set
+			{
+				if (this.Count >= parameterIndex+1)
+					numeric_param_list[parameterIndex] = value;
+				else          
+					throw new IndexOutOfRangeException("The specified parameter index does not exist: " + parameterIndex.ToString());
 			}
 		}
-		
-		public int Count {
-			get { return numeric_param_list.Count; }
+
+
+		public int Count 
+		{
+			get
+			{
+				return this.numeric_param_list.Count;
+			}
 		}
-		
-		public bool IsFixedSize {
-			get { return false; }
+
+		bool IList.IsFixedSize
+		{
+			get
+			{
+				return this.numeric_param_list.IsFixedSize;
+			}
 		}
-		
-		public bool IsReadOnly {
-			get { return false; }
+
+		bool IList.IsReadOnly
+		{
+			get
+			{
+				return this.numeric_param_list.IsReadOnly;
+			}
 		}
-		
-		public bool IsSynchronized {
-			get { return false; }
+
+
+		bool ICollection.IsSynchronized 
+		{
+			get
+			{
+				return this.numeric_param_list.IsSynchronized;
+			}
 		}
 		
-		public object SyncRoot {
-			get { return null; }
+
+		object ICollection.SyncRoot 
+		{
+			get
+			{
+				return this.numeric_param_list.SyncRoot;
+			}
 		}
-		
+
 		#endregion
 
 		#region Public Methods
@@ -132,15 +198,13 @@
 		public int Add (object value)
 		{
 			CheckSqliteParam (value);
-			SqliteParameter sqlp = (SqliteParameter) value;
+			SqliteParameter sqlp = value as SqliteParameter;
 			if (named_param_hash.Contains (sqlp.ParameterName))
-				throw new DuplicateNameException ("Parameter collection already contains given value.");
-			
-			named_param_hash[value] = numeric_param_list.Add (value);
-			
-			return (int) named_param_hash[value];
+				throw new DuplicateNameException ("Parameter collection already contains the a SqliteParameter with the given ParameterName.");
+			named_param_hash[sqlp.ParameterName] = numeric_param_list.Add(value);
+				return (int) named_param_hash[sqlp.ParameterName];
 		}
-		
+
 		public SqliteParameter Add (SqliteParameter param)
 		{
 			Add ((object)param);
@@ -165,7 +229,7 @@
 		
 		public void CopyTo (Array array, int index)
 		{
-			throw new NotImplementedException ();
+			this.numeric_param_list.CopyTo(array, index);
 		}
 		
 		bool IList.Contains (object value)
@@ -185,7 +249,7 @@
 		
 		public IEnumerator GetEnumerator ()
 		{
-			throw new NotImplementedException ();
+			return this.numeric_param_list.GetEnumerator();
 		}
 		
 		int IList.IndexOf (object param)
@@ -195,7 +259,10 @@
 		
 		public int IndexOf (string parameterName)
 		{
-			return (int) named_param_hash[parameterName];
+			if (named_param_hash.Contains(parameterName))
+				return (int) named_param_hash[parameterName];
+			else
+				return -1;
 		}
 		
 		public int IndexOf (SqliteParameter param)
@@ -206,7 +273,8 @@
 		public void Insert (int index, object value)
 		{
 			CheckSqliteParam (value);
-			if (numeric_param_list.Count == index) {
+			if (numeric_param_list.Count == index) 
+			{
 				Add (value);
 				return;
 			}
@@ -245,4 +313,3 @@
 		#endregion
 	}
 }
-                
Index: Mono.Data.SqliteClient/SqliteCommand.cs
===================================================================
--- Mono.Data.SqliteClient/SqliteCommand.cs	(revision 44904)
+++ Mono.Data.SqliteClient/SqliteCommand.cs	(working copy)
@@ -4,8 +4,11 @@
 // Represents a Transact-SQL statement or stored procedure to execute against 
 // a Sqlite database file.
 //
-// Author(s): Vladimir Vukicevic  <vladimir@pobox.com>
-//            Everaldo Canuto  <everaldo_canuto@yahoo.com.br>
+// Author(s): 	Vladimir Vukicevic  <vladimir@pobox.com>
+//		Everaldo Canuto  <everaldo_canuto@yahoo.com.br>
+//		Chris Turchin <chris@turchin.net>
+//		Jeroen Zwartepoorte <jeroen@xs4all.net>
+//		Thomas Zoechling <thomas.zoechling@gmx.at>
 //
 // Copyright (C) 2002  Vladimir Vukicevic
 //
@@ -32,13 +35,14 @@
 using System;
 using System.Text;
 using System.Runtime.InteropServices;
+using System.Text.RegularExpressions;
 using System.Data;
+using System.Diagnostics; 
 
 namespace Mono.Data.SqliteClient 
 {
 	public class SqliteCommand : IDbCommand
 	{
-
 		#region Fields
 		
 		private SqliteConnection parent_conn;
@@ -49,7 +53,9 @@
 		private CommandType type;
 		private UpdateRowSource upd_row_source;
 		private SqliteParameterCollection sql_params;
-		
+		private bool prepared = false;
+		private IntPtr pStmt;
+
 		#endregion
 
 		#region Constructors and destructors
@@ -59,7 +65,7 @@
 			sql = "";
 			sql_params = new SqliteParameterCollection ();
 		}
-		
+				
 		public SqliteCommand (string sqlText)
 		{
 			sql = sqlText;
@@ -89,50 +95,64 @@
 
 		#region Properties
 		
-		public string CommandText {
+		public string CommandText 
+		{
 			get { return sql; }
 			set { sql = value; }
 		}
 		
-		public int CommandTimeout {
+		public int CommandTimeout
+		{
 			get { return timeout; }
 			set { timeout = value; }
 		}
 		
-		public CommandType CommandType {
+		public CommandType CommandType 
+		{
 			get { return type; }
 			set { type = value; }
 		}
 		
-		IDbConnection IDbCommand.Connection {
-			get { return parent_conn; }
-			set {
-					if (!(value is SqliteConnection)) {
-						throw new InvalidOperationException ("Can't set Connection to something other than a SqliteConnection");
-					}
-					parent_conn = (SqliteConnection) value;
+		IDbConnection IDbCommand.Connection 
+		{
+			get 
+			{ 
+				return parent_conn; 
 			}
+			set 
+			{
+				if (!(value is SqliteConnection)) 
+				{
+					throw new InvalidOperationException ("Can't set Connection to something other than a SqliteConnection");
+				}
+				parent_conn = (SqliteConnection) value;
+			}
 		}
 		
-		public SqliteConnection Connection {
+		public SqliteConnection Connection
+		{
 			get { return parent_conn; }
 			set { parent_conn = value; }
 		}
 		
-		IDataParameterCollection IDbCommand.Parameters {
+		IDataParameterCollection IDbCommand.Parameters 
+		{
 			get { return Parameters; }
 		}
 		
-		public SqliteParameterCollection Parameters {
+		public SqliteParameterCollection Parameters 
+		{
 			get { return sql_params; }
 		}
 		
-		public IDbTransaction Transaction {
+		public IDbTransaction Transaction 
+		{
 			get { return transaction; }
 			set { transaction = value; }
 		}
 		
-		public UpdateRowSource UpdatedRowSource {
+		public UpdateRowSource UpdatedRowSource 
+		{
 			get { return upd_row_source; }
 			set { upd_row_source = value; }
 		}
@@ -149,6 +169,29 @@
 				return Sqlite.sqlite_changes(parent_conn.Handle);
 		}
 		
+		private string ReplaceParams(Match m)
+		{
+			string input = m.Value;                                                                                                                
+			if (m.Groups["param"].Success)
+			{
+				Group g = m.Groups["param"];
+				string find = g.Value;
+				//FIXME: sqlite works internally only with strings, so this assumtion is mostly legit, but what about date formatting, etc?
+				//Need to fix SqlLiteDataReader first to acurately describe the tables
+				SqliteParameter sqlp = Parameters[find];
+				string replace = Convert.ToString(sqlp.Value);
+				if(sqlp.DbType == DbType.String)
+				{
+					replace =  "\"" + replace + "\"";
+				}
+				
+				input = Regex.Replace(input,find,replace);
+				return input;
+			}
+			else
+			return m.Value;
+		}
+		
 		#endregion
 
 		#region Public Methods
@@ -157,11 +200,136 @@
 		{
 		}
 		
+		public string ProcessParameters()
+		{
+			string processedText = sql;
+			//Regex looks odd perhaps, but it works - same impl. as in the firebird db provider
+			//the named parameters are using the ADO.NET standard @-prefix but sqlite is considering ":" as a prefix for v.3...
+			//ref: http://www.mail-archive.com/sqlite-users@sqlite.org/msg01851.html
+			//Regex r = new Regex(@"(('[^']*?\@[^']*')*[^'@]*?)*(?<param>@\w+)+([^'@]*?('[^']*?\@[^']*'))*",RegexOptions.ExplicitCapture);
+			
+			//The above statement is true for the commented regEx, but I changed it to use the :-prefix, because now (12.05.2005 sqlite3) 
+			//sqlite is using : as Standard Parameterprefix
+			
+			Regex r = new Regex(@"(('[^']*?\:[^']*')*[^':]*?)*(?<param>:\w+)+([^':]*?('[^']*?\:[^']*'))*",RegexOptions.ExplicitCapture);
+			MatchEvaluator me = new MatchEvaluator(ReplaceParams);
+			processedText = r.Replace(sql, me);
+			Console.WriteLine("Processed:" + processedText);
+			return processedText;
+		}
+		
 		public void Prepare ()
 		{
+			SqliteError err = SqliteError.OK;
+			IntPtr pzTail = IntPtr.Zero;
+			pStmt = IntPtr.Zero;	
+			if (parent_conn.Version == 3)  
+			{
+				err = Sqlite.sqlite3_prepare (parent_conn.Handle, sql, sql.Length, out pStmt, out pzTail);
+				if (err != SqliteError.OK)
+					throw new ApplicationException ("Sqlite error in prepare " + err);
+				int pcount = Sqlite.sqlite3_bind_parameter_count (pStmt);
+
+				for (int i = 1; i <= pcount; i++) 
+				{
+					String name = Sqlite.sqlite3_bind_parameter_name (pStmt, i);
+					SqliteParameter param = sql_params[name];
+					Type ptype = param.Value.GetType ();
+					
+					if (ptype.Equals (typeof (String))) 
+					{
+						String s = (String)param.Value;
+						err = Sqlite.sqlite3_bind_text (pStmt, i, s, s.Length, (IntPtr)(-1));
+					} 
+					else if (ptype.Equals (typeof (DBNull))) 
+					{
+						err = Sqlite.sqlite3_bind_null (pStmt, i);
+					}
+					else if (ptype.Equals (typeof (Boolean))) 
+					{
+						bool b = (bool)param.Value;
+						err = Sqlite.sqlite3_bind_int (pStmt, i, b ? 1 : 0);
+					} else if (ptype.Equals (typeof (Byte))) 
+					{
+						err = Sqlite.sqlite3_bind_int (pStmt, i, (Byte)param.Value);
+					}
+					else if (ptype.Equals (typeof (Char))) 
+					{
+						err = Sqlite.sqlite3_bind_int (pStmt, i, (Char)param.Value);
+					} 
+					else if (ptype.Equals (typeof (Int16))) 
+					{
+						err = Sqlite.sqlite3_bind_int (pStmt, i, (Int16)param.Value);
+					} 
+					else if (ptype.Equals (typeof (Int32))) 
+					{
+						err = Sqlite.sqlite3_bind_int (pStmt, i, (Int32)param.Value);
+					}
+					else if (ptype.Equals (typeof (SByte))) 
+					{
+						err = Sqlite.sqlite3_bind_int (pStmt, i, (SByte)param.Value);
+					} 
+					else if (ptype.Equals (typeof (UInt16))) 
+					{
+						err = Sqlite.sqlite3_bind_int (pStmt, i, (UInt16)param.Value);
+					}
+					else if (ptype.Equals (typeof (DateTime))) 
+					{
+						DateTime dt = (DateTime)param.Value;
+						err = Sqlite.sqlite3_bind_int64 (pStmt, i, dt.ToFileTime ());
+					} 
+					else if (ptype.Equals (typeof (Double))) 
+					{
+						err = Sqlite.sqlite3_bind_double (pStmt, i, (Double)param.Value);
+					}
+					else if (ptype.Equals (typeof (Single))) 
+					{
+						err = Sqlite.sqlite3_bind_double (pStmt, i, (Single)param.Value);
+					} 
+					else if (ptype.Equals (typeof (UInt32))) 
+					{
+						err = Sqlite.sqlite3_bind_int64 (pStmt, i, (UInt32)param.Value);
+					}
+					else if (ptype.Equals (typeof (Int64))) 
+					{
+						err = Sqlite.sqlite3_bind_int64 (pStmt, i, (Int64)param.Value);
+					} 
+					else 
+					{
+						throw new ApplicationException("Unkown Parameter Type");
+					}
+					if (err != SqliteError.OK) 
+					{
+						throw new ApplicationException ("Sqlite error in bind " + err);
+					}
+				}
+			}
+			else 
+			{
+				IntPtr errMsg = IntPtr.Zero;
+				string msg = "";
+				string sqlData = sql;
+				if (Parameters.Count > 0)
+				{
+					sqlData = ProcessParameters();
+				}
+				err = Sqlite.sqlite_compile (parent_conn.Handle, sqlData, out pzTail, out pStmt, out errMsg);
+				
+				if (err != SqliteError.OK) 
+				{
+					if (errMsg != IntPtr.Zero) 
+					{
+						msg = Marshal.PtrToStringAnsi (errMsg);
+						Sqlite.sqliteFree (errMsg);
+					}
+					throw new ApplicationException ("Sqlite error " + msg);
+				}
+			}
+			prepared=true;
 		}
 		
-		IDbDataParameter IDbCommand.CreateParameter ()
+		
+		IDbDataParameter IDbCommand.CreateParameter()
 		{
 			return CreateParameter ();
 		}
@@ -215,46 +383,66 @@
 			SqliteDataReader reader = null;
 			SqliteError err = SqliteError.OK;
 			IntPtr errMsg = IntPtr.Zero; 
-			
 			parent_conn.StartExec ();
-			
+		  
 			string msg = "";
-
-			try {
-				if (want_results) {
-					IntPtr pVm = IntPtr.Zero;
-					IntPtr pzTail = IntPtr.Zero;
-					if (parent_conn.Version == 3)
-						err = Sqlite.sqlite3_prepare (parent_conn.Handle, sql, sql.Length, out pVm, out pVm);
-					else
-						err = Sqlite.sqlite_compile (parent_conn.Handle, sql, out pzTail, out pVm, out errMsg);
-					if (err == SqliteError.OK)
-						reader = new SqliteDataReader (this, pVm, parent_conn.Version);
-					if (parent_conn.Version == 3)
-						err = Sqlite.sqlite3_finalize (pVm, out errMsg);
-					else
-						err = Sqlite.sqlite_finalize (pVm, out errMsg);
-				} else {
-					if (parent_conn.Version == 3)
-						err = Sqlite.sqlite3_exec (parent_conn.Handle, sql, IntPtr.Zero, IntPtr.Zero, out errMsg);
-					else
-						err = Sqlite.sqlite_exec (parent_conn.Handle, sql, IntPtr.Zero, IntPtr.Zero, out errMsg);
+			try 
+			{
+				if (!prepared)
+				{
+					Prepare ();
 				}
-			} finally {			
+				if (want_results) 
+				{
+					reader = new SqliteDataReader (this, pStmt, parent_conn.Version);
+				} 
+				else 
+				{
+					if (parent_conn.Version == 3) 
+					{
+						err = Sqlite.sqlite3_step (pStmt);
+					} 
+					else 
+					{
+						int cols;
+						IntPtr pazValue = IntPtr.Zero;
+						IntPtr pazColName = IntPtr.Zero;
+						err = Sqlite.sqlite_step (pStmt, out cols, out pazValue, out pazColName);
+					}
+				}
+			}
+			finally 
+			{	
+				if (parent_conn.Version == 3) 
+				{}
+				else
+				{
+					err = Sqlite.sqlite_finalize (pStmt, out errMsg);
+				}
 				parent_conn.EndExec ();
+				prepared = false;
 			}
-
-			if (err != SqliteError.OK) {
-				if (errMsg != IntPtr.Zero) {
-					msg = Marshal.PtrToStringAnsi (errMsg);
-					if (parent_conn.Version != 3)
+			
+			if (err != SqliteError.OK &&
+			    err != SqliteError.DONE &&
+			    err != SqliteError.ROW) 
+			{
+ 				if (errMsg != IntPtr.Zero) 
+				{
+ 					//msg = Marshal.PtrToStringAnsi (errMsg);
+					if (parent_conn.Version == 3)
+					{
+						err = Sqlite.sqlite3_finalize (pStmt, out errMsg);
+					}
+					else
+					{
+						err = Sqlite.sqlite_finalize (pStmt, out errMsg);
 						Sqlite.sqliteFree (errMsg);
+					}
 				}
 				throw new ApplicationException ("Sqlite error " + msg);
 			}
-			
 			rows_affected = NumChanges ();
-			
 			return reader;
 		}
 		
@@ -265,8 +453,6 @@
 			else
 				return Sqlite.sqlite_last_insert_rowid(parent_conn.Handle);
 		}
-		
-		#endregion
-
+	#endregion
 	}
 }
Index: Mono.Data.SqliteClient/Sqlite.cs
===================================================================
--- Mono.Data.SqliteClient/Sqlite.cs	(revision 44904)
+++ Mono.Data.SqliteClient/Sqlite.cs	(working copy)
@@ -3,7 +3,10 @@
 //
 // Provides C# bindings to the library sqlite.dll
 //
-// Author(s): Everaldo Canuto  <everaldo_canuto@yahoo.com.br>
+//            	Everaldo Canuto  <everaldo_canuto@yahoo.com.br>
+//			Chris Turchin <chris@turchin.net>
+//			Jeroen Zwartepoorte <jeroen@xs4all.net>
+//			Thomas Zoechling <thomas.zoechling@gmx.at>
 //
 // Copyright (C) 2004  Everaldo Canuto
 //
@@ -129,7 +132,7 @@
 		internal static extern SqliteError sqlite_finalize (IntPtr pVm, out IntPtr pzErrMsg);
 
 		[DllImport ("sqlite")]
-                internal static extern SqliteError sqlite_exec (IntPtr handle, string sql, IntPtr callback, IntPtr user_data, out IntPtr errstr_ptr);
+		internal static extern SqliteError sqlite_exec (IntPtr handle, string sql, IntPtr callback, IntPtr user_data, out IntPtr errstr_ptr);
 		
 		[DllImport("sqlite3")]
 		internal static extern int sqlite3_open (string dbname, out IntPtr handle);
@@ -156,24 +159,60 @@
 		internal static extern SqliteError sqlite3_finalize (IntPtr pVm, out IntPtr pzErrMsg);
 
 		[DllImport ("sqlite3")]
-                internal static extern SqliteError sqlite3_exec (IntPtr handle, string sql, IntPtr callback, IntPtr user_data, out IntPtr errstr_ptr);
+		internal static extern SqliteError sqlite3_exec (IntPtr handle, string sql, IntPtr callback, IntPtr user_data, out IntPtr errstr_ptr);
 	
 		[DllImport ("sqlite3")]
 		internal static extern IntPtr sqlite3_column_name (IntPtr pVm, int col);
+		
 		[DllImport ("sqlite3")]
 		internal static extern IntPtr sqlite3_column_text (IntPtr pVm, int col);
+		
 		[DllImport ("sqlite3")]
 		internal static extern IntPtr sqlite3_column_blob (IntPtr pVm, int col);
+		
 		[DllImport ("sqlite3")]
 		internal static extern int sqlite3_column_bytes (IntPtr pVm, int col);
+		
 		[DllImport ("sqlite3")]
 		internal static extern int sqlite3_column_count (IntPtr pVm);
+		
 		[DllImport ("sqlite3")]
 		internal static extern int sqlite3_column_type (IntPtr pVm, int col);
+		
 		[DllImport ("sqlite3")]
 		internal static extern Int64 sqlite3_column_int64 (IntPtr pVm, int col);
+		
 		[DllImport ("sqlite3")]
 		internal static extern double sqlite3_column_double (IntPtr pVm, int col);
+		
+ 		[DllImport ("sqlite3")]
+		internal static extern int sqlite3_bind_parameter_count (IntPtr pStmt);
+
+		[DllImport ("sqlite3")]
+		internal static extern String sqlite3_bind_parameter_name (IntPtr pStmt, int n);
+
+		[DllImport ("sqlite3")]
+		internal static extern SqliteError sqlite3_bind_blob (IntPtr pStmt, int n, byte[] blob, int length, IntPtr freetype);
+
+		[DllImport ("sqlite3")]
+		internal static extern SqliteError sqlite3_bind_double (IntPtr pStmt, int n, double value);
+
+		[DllImport ("sqlite3")]
+		internal static extern SqliteError sqlite3_bind_int (IntPtr pStmt, int n, int value);
+
+		[DllImport ("sqlite3")]
+		internal static extern SqliteError sqlite3_bind_int64 (IntPtr pStmt, Int64 n, long value);
+
+		[DllImport ("sqlite3")]
+		internal static extern SqliteError sqlite3_bind_null (IntPtr pStmt, int n);
+
+		[DllImport ("sqlite3")]
+		internal static extern SqliteError sqlite3_bind_text (IntPtr pStmt, int n, string value, int length, IntPtr freetype);
+
+		[DllImport ("sqlite3")]
+		internal static extern SqliteError sqlite3_bind_text16 (IntPtr pStmt, int n, byte[] value, int length, IntPtr freetype);
+		
 		#endregion
+
 	}
 }
Index: Mono.Data.SqliteClient/SqliteTransaction.cs
===================================================================
--- Mono.Data.SqliteClient/SqliteTransaction.cs	(revision 44904)
+++ Mono.Data.SqliteClient/SqliteTransaction.cs	(working copy)
@@ -100,7 +100,7 @@
 			try 
 			{
 				SqliteCommand cmd = _connection.CreateCommand();
-				cmd.CommandText = "COMMIT";
+				cmd.CommandText = "ROLLBACK";
 				cmd.ExecuteNonQuery();
 				_open = false;
 			}
Index: Test/SqliteTest.cs
===================================================================
--- Test/SqliteTest.cs	(revision 44904)
+++ Test/SqliteTest.cs	(working copy)
@@ -1,106 +1,300 @@
 //
-// SqliteTest.cs - Test for the Sqlite ADO.NET Provider in Mono.Data.SqliteClient
-//                 This provider works on Linux and Windows and uses the native
-//                 sqlite.dll or sqlite.so library.
+// SqliteTest.cs
 //
-// Modify or add to this test as needed...
+// Author(s): 	Daniel Morgan <danmorg@sc.rr.com>
+//		Chris Turchin <chris@turchin.net>
+//		Thomas Zoechling <thomas.zoechling@gmx.at>
 //
-// SQL Lite can be downloaded from
-// http://www.hwaci.com/sw/sqlite/download.html
-//
-// There are binaries for Windows and Linux.
-//
-// To compile:
-//  mcs SqliteTest.cs -r System.Data.dll -r Mono.Data.SqliteClient.dll
-//
-// Author:
-//     Daniel Morgan <danmorg@sc.rr.com>
-//
 
 using System;
 using System.Data;
+using System.Data.Common;
+using System.IO;
 using Mono.Data.SqliteClient;
 
 namespace Test.Mono.Data.SqliteClient
 {
 	class SqliteTest
 	{
+		//static string connectionString = "Version=3,URI=file:SqliteTest.db";
+		static string connectionString = "Version=3,URI=file:SqliteTest.db";
+		static SqliteConnection dbcon = new SqliteConnection();
+		static SqliteCommand dbcmd = new SqliteCommand();
+
 		[STAThread]
 		static void Main(string[] args)
 		{
-			Console.WriteLine("If this test works, you should get:");
-			Console.WriteLine("Data 1: 5");
-			Console.WriteLine("Data 2: Mono");
-
-			Console.WriteLine("create SqliteConnection...");
-			SqliteConnection dbcon = new SqliteConnection();
+			Console.WriteLine("setting ConnectionString using: " + connectionString);
+			dbcon.ConnectionString = connectionString;
 			
-			// the connection string is a URL that points
-			// to a file.  If the file does not exist, a 
-			// file is created.
-
-			// "URI=file:some/path"
-			string connectionString =
-				"URI=file:SqliteTest.db";
-			Console.WriteLine("setting ConnectionString using: " + 
-				connectionString);
-			dbcon.ConnectionString = connectionString;
-				
+			if (File.Exists("SqliteTest.db"))
+			File.Delete("SqliteTest.db");
+			
 			Console.WriteLine("open the connection...");
 			dbcon.Open();
-
-			Console.WriteLine("create SqliteCommand to CREATE TABLE MONO_TEST");
-			SqliteCommand dbcmd = new SqliteCommand();
 			dbcmd.Connection = dbcon;
+			SetupDB();
 			
-			dbcmd.CommandText = 
-				"CREATE TABLE MONO_TEST ( " +
-				"NID INT, " +
-				"NDESC TEXT )";
-			Console.WriteLine("execute command...");
-			dbcmd.ExecuteNonQuery();
+			Console.WriteLine("SELECTING DATA FROM MONO_TEST");
+			
+			TestWithoutParameters();
+			TestSingleParameter();
+			TestMultipleParameters();
+			TestUsingDataAdapter();
+			TestUpdateWithParamsAndEvents(); 
+			
+			dbcmd.Dispose();
+			dbcon.Close();
+			
+			Console.WriteLine("Done.");
+		}
 
-			Console.WriteLine("set and execute command to INSERT INTO MONO_TEST");
-			dbcmd.CommandText =
-				"INSERT INTO MONO_TEST  " +
-				"(NID, NDESC )"+
-				"VALUES(5,'Mono')";
+		static void SetupDB()
+		{
+			dbcmd.CommandText = "CREATE TABLE MONO_TEST ( NID INT, NDESC TEXT, EMAIL TEXT)";
+			Console.WriteLine("execute SqliteCommand to CREATE TABLE MONO_TEST: " + dbcmd.CommandText );
 			dbcmd.ExecuteNonQuery();
+			
+			Console.WriteLine("inserting data into MONO_TEST...");
+			dbcmd.CommandText = "INSERT INTO MONO_TEST  (NID, NDESC, EMAIL ) VALUES(1,'Mono 1','chris@turchin.net')";
+			dbcmd.ExecuteNonQuery();
+			
+			dbcmd.CommandText ="INSERT INTO MONO_TEST  (NID, NDESC, EMAIL ) VALUES(2,'Mono 2','test@test')";
+			dbcmd.ExecuteNonQuery();
+			
+			dbcmd.CommandText = "INSERT INTO MONO_TEST  (NID, NDESC ) VALUES(3,'Mono 3')";
+			dbcmd.ExecuteNonQuery();
+			
+			dbcmd.CommandText ="INSERT INTO MONO_TEST (NID, NDESC ) VALUES(4,'Mono 4')";
+			dbcmd.ExecuteNonQuery();
+			
+			dbcmd.CommandText = "INSERT INTO MONO_TEST (NID, NDESC, EMAIL ) VALUES(5,'Mono 5','test@test')";
+			dbcmd.ExecuteNonQuery();
+		}
 
-			Console.WriteLine("set command to SELECT FROM MONO_TEST");
-			dbcmd.CommandText =
-				"SELECT * FROM MONO_TEST";
-			SqliteDataReader reader;
-			Console.WriteLine("execute reader...");
-			reader = dbcmd.ExecuteReader();
+		static void TestUsingDataAdapter()
+		{
+			Console.WriteLine("read and display data using DataAdapter...");
+                        SqliteDataAdapter adapter = new SqliteDataAdapter("SELECT * FROM MONO_TEST", connectionString);
+                        DataSet dataset = new DataSet();
+                        adapter.Fill(dataset);
 
-			Console.WriteLine("read and display data...");
-			while(reader.Read()) {
-				Console.WriteLine("Data 1: " + reader[0].ToString());
-				Console.WriteLine("Data 2: " + reader[1].ToString());
-			}
+			DisplayDataSet(dataset);
+	
+			Console.WriteLine("next test...");
+			Console.WriteLine("Insert and change data using dataset...");
+			DataRow dataRow = dataset.Tables[0].NewRow();
+			dataRow["NID"] = "6";
+			dataRow["NDESC"] = "New via dataset";
+			dataRow["EMAIL"] = "chris@turchin.net";
+			dataset.Tables[0].Rows.Add(dataRow);
+			dataset.Tables[0].Rows[0]["EMAIL"]="thomas.zoechling@gmx.at";
+	
+			DisplayDataSet(dataset);
+			Console.WriteLine("next test...");
+			Console.WriteLine("Custom data adapter and data adapter events.");
+	
+			SqliteCommand dbcmd2 = new SqliteCommand("SELECT NID, NDESC, EMAIL FROM MONO_TEST where NID > :NID",dbcon);
+	
+			SqliteParameter param = new SqliteParameter();
+			param.ParameterName = ":NID";
+			param.Value = 3;
+			param.DbType = DbType.Int32;
+			dbcmd2.Parameters.Add(param);
+	
+			SqliteDataAdapter custDA = new SqliteDataAdapter(dbcmd2);
+			
+			/*
+			//FIXME SqliteCommandBuilder not yet implemented...
+			SqliteCommandBuilder custCB = new SqliteCommandBuilder(custDA);
+			Console.WriteLine(custCB.GetUpdateCommand().CommandText);
+			*/
+	
+			DataSet custDS = new DataSet();
+			custDA.Fill(custDS);
+	
+			//custDS.Tables[0].Rows[1]["EMAIL"]="devnull@dev.null";
+			DisplayDataSet(custDS);
+	
+			Console.WriteLine("next test...");
+			Console.WriteLine("read and display data as XML");
+			Console.WriteLine(dataset.GetXml());
+		}
 
-			Console.WriteLine("read and display data using DataAdapter...");
-			SqliteDataAdapter adapter = new SqliteDataAdapter("SELECT * FROM MONO_TEST", connectionString);
+
+
+		static void TestUpdateWithParamsAndEvents()
+		{
+			dbcmd.CommandText = "SELECT NID, NDESC, EMAIL FROM MONO_TEST";
+			SqliteCommand update = new SqliteCommand("UPDATE MONO_TEST SET NID = :NID, NDESC = :NDESC, EMAIL = :EMAIL WHERE NID = :NID ");
+			update.Connection=dbcon;
+			SqliteCommand delete = new SqliteCommand("DELETE FROM MONO_TEST WHERE NID = :NID");
+			delete.Connection=dbcon;
+			SqliteCommand insert = new SqliteCommand("INSERT INTO MONO_TEST  (NID, NDESC, EMAIL ) VALUES(:NID,:NDESC,:EMAIL)");
+			insert.Connection=dbcon;
+			SqliteDataAdapter custDA = new SqliteDataAdapter(dbcmd);
+			
+			custDA.RowUpdating += new SqliteRowUpdatingEventHandler(OnRowUpdating);
+			custDA.RowUpdated += new SqliteRowUpdatedEventHandler(OnRowUpdated);
+			
+			SqliteParameter nid = new SqliteParameter();
+			nid.ParameterName = ":NID";
+			nid.DbType = DbType.Int32;
+			nid.SourceColumn = "NID";
+			nid.SourceVersion = DataRowVersion.Current;
+			
+			SqliteParameter ndesc = new SqliteParameter();
+			ndesc.ParameterName = ":NDESC";
+			ndesc.DbType = DbType.String;
+			ndesc.SourceColumn = "NDESC";
+			ndesc.SourceVersion = DataRowVersion.Current;
+			
+			SqliteParameter email = new SqliteParameter();
+			email.ParameterName =":EMAIL";
+			email.DbType = DbType.String;
+			email.SourceColumn = "EMAIL";
+			email.SourceVersion = DataRowVersion.Current;
+			
+			update.Parameters.Add(nid);
+			update.Parameters.Add(ndesc);
+			update.Parameters.Add(email);
+			
+			delete.Parameters.Add(nid);
+			
+			insert.Parameters.Add(nid);
+			insert.Parameters.Add(ndesc);
+			insert.Parameters.Add(email);
+			
+			custDA.UpdateCommand = update;
+			custDA.DeleteCommand = delete;
+			custDA.InsertCommand = insert;
+
 			DataSet dataset = new DataSet();
-			adapter.Fill(dataset);
-			foreach(DataTable myTable in dataset.Tables){
-				foreach(DataRow myRow in myTable.Rows){
-					foreach (DataColumn myColumn in myTable.Columns){
-						Console.WriteLine(myRow[myColumn]);
-					}
+			custDA.Fill(dataset);
+			dataset.AcceptChanges();
+			DisplayDataSet(dataset);
+			
+			DataRow dataRow = dataset.Tables[0].Rows[0];
+			dataRow["NDESC"] = "CHANGED";
+			
+			DataRow newRow = dataset.Tables[0].NewRow();
+			newRow["NID"] = 999;
+			newRow["NDESC"]   = "newDesc";
+			newRow["EMAIL"]   = "new@Desc.at";
+			dataset.Tables[0].Rows.Add(newRow);
+			
+			DataRow victim = dataset.Tables[0].Rows[3];
+			victim.Delete();
+			
+			Console.WriteLine("Rows affected: " + custDA.Update(dataset).ToString());
+			
+			dataset.Clear();
+			custDA.Fill(dataset);
+			DisplayDataSet(dataset);
+			
+			custDA.RowUpdating -= new SqliteRowUpdatingEventHandler(OnRowUpdating);
+			custDA.RowUpdated -= new SqliteRowUpdatedEventHandler(OnRowUpdated);
+		}
+
+		protected static void OnRowUpdating(object sender, RowUpdatingEventArgs args)
+		{
+			Console.WriteLine("OnRowUpdating fired...");
+		}
+
+		protected static void OnRowUpdated(object sender, RowUpdatedEventArgs args)
+		{
+			Console.WriteLine("OnRowUpdated fired...");
+		}
+
+		static void TestWithoutParameters()
+		{
+			dbcmd.CommandText = "SELECT * FROM MONO_TEST where NID >  2";
+			Console.WriteLine("TestWithoutParameters: " + dbcmd.CommandText + "\n\nexecute reader...");
+			ShowData( dbcmd.ExecuteReader());
+			Console.WriteLine("next test...");
+		}
+
+		static void TestSingleParameter()
+		{
+			dbcmd.CommandText = "SELECT * FROM MONO_TEST where NID >  :1";
+			
+			SqliteParameter param = new SqliteParameter();
+			param.ParameterName = ":1";
+			param.Value = 1;
+			param.DbType = DbType.Int32;
+			dbcmd.Parameters.Add(param);
+			
+			Console.WriteLine("TestSingleParameter: " + dbcmd.CommandText + "\n\nexecute reader...");
+			
+			ShowData( dbcmd.ExecuteReader());
+			dbcmd.Parameters.Clear();
+			Console.WriteLine("next test...");
+		}
+
+
+		static void TestMultipleParameters()
+		{
+			dbcmd.CommandText = "SELECT * FROM MONO_TEST where NID >=  :nid AND NDESC LIKE :ndesc and (EMAIL LIKE '%@test' or EMAIL = :email)";
+			
+			dbcmd.Parameters.Add(new SqliteParameter(":nid" , 1) );
+			dbcmd.Parameters.Add(new SqliteParameter(":ndesc", "_ono%") );
+			dbcmd.Parameters.Insert(1,new SqliteParameter(":email","chris@turchin.net"));
+			
+			Console.WriteLine("TestMultipleParameters: " + dbcmd.CommandText + "\n\nexecute reader...");
+			ShowData( dbcmd.ExecuteReader());
+			dbcmd.Parameters.Clear();
+			Console.WriteLine("next test...");
+		}
+
+		static void TestUnnamedParameters()
+		{
+			dbcmd.CommandText = "SELECT * FROM MONO_TEST where NID >  :1 AND NDESC LIKE :2 and (EMAIL LIKE '%@test' or EMAIL = :3)";
+			
+			SqliteParameter param = new SqliteParameter();
+			SqliteParameter param2 = new SqliteParameter();
+			
+			param.Value = 1;
+			param.DbType = DbType.Int32;
+			param2.Value = "_ono 5";
+
+			dbcmd.Parameters.Add(param);
+			dbcmd.Parameters.Add(param2);
+			dbcmd.Parameters.Insert(1,new SqliteParameter(":3","chris@turchin.net"));
+			Console.WriteLine("TestUnnamedParameters: " + dbcmd.CommandText + "\n\nexecute reader...");
+			ShowData(dbcmd.ExecuteReader());
+			dbcmd.Parameters.Clear();
+			Console.WriteLine("next test...");
+		}
+
+		static void DisplayDataSet(DataSet dataset)
+		{
+			foreach(DataTable myTable in dataset.Tables)
+			{
+				foreach(DataRow myRow in myTable.Rows)
+				{
+					Console.Write("datarow:\t");
+					string data = myRow["NID"] + "|\t" + myRow["NDESC"] + "|\t" + myRow["EMAIL"] ;
+					Console.WriteLine(data);
 				}
 			}
+		}
 
+		static void ShowData(SqliteDataReader reader)
+		{
+			Console.WriteLine("read and display data...");
 			
-			Console.WriteLine("clean up...");
-			dataset.Dispose();
-			adapter.Dispose();
+			while(reader.Read()) 
+			{
+				Console.Write("datarow:\t" + reader[0].ToString());
+				Console.Write("|\t" + reader[1].ToString());
+				string email;
+				if (reader[2]==null)
+				    email = "(null)";
+				else
+				    email = reader[2].ToString();
+				Console.Write("|\t" + email + "\n");
+			}
 			reader.Close();
-			dbcmd.Dispose();
-			dbcon.Close();
-
-			Console.WriteLine("Done.");
 		}
 	}
 }
Index: Test/SqliteUnitTests.cs
===================================================================
--- Test/SqliteUnitTests.cs	(revision 0)
+++ Test/SqliteUnitTests.cs	(revision 0)
@@ -0,0 +1,410 @@
+//
+// SqliteUnitTest.cs
+//
+// Author(s): 	Chris Turchin <chris@turchin.net>
+//		Thomas Zoechling <thomas.zoechling@gmx.at>
+//
+
+
+using System;
+using System.Data;
+using System.Data.Common;
+using System.IO;
+using Mono.Data.SqliteClient;
+using Mono.Unix;
+using NUnit.Framework;
+
+namespace Test.Mono.Data.SqliteClient
+{
+    [TestFixture]
+    public class SqliteUnitTests
+    {
+        static string connectionString = "version=2,URI=file:SqliteTest.db";
+        static SqliteConnection dbcon = new SqliteConnection();
+        static SqliteCommand dbcmd = new SqliteCommand();
+
+        static bool updatingFired = false;
+        static bool updatedFired = false;
+
+        [TestFixtureSetUp]
+        public void Init()
+        {
+		Console.WriteLine("setting ConnectionString using: " + connectionString);
+		dbcon.ConnectionString = connectionString;
+		
+		if (File.Exists("SqliteTest.db"))
+		File.Delete("SqliteTest.db");
+		
+		Console.WriteLine("open the connection...");
+		dbcon.Open();
+		dbcmd.Connection = dbcon;
+		
+		dbcmd.CommandText = "CREATE TABLE MONO_TEST ( NID INTEGER PRIMARY KEY, NDESC TEXT, EMAIL TEXT)";
+		Console.WriteLine("execute SqliteCommand to CREATE TABLE MONO_TEST: " + dbcmd.CommandText );
+		dbcmd.ExecuteNonQuery();
+        }
+
+        [SetUp]
+        public void RefreshCmd()
+        {
+		dbcmd = new SqliteCommand();
+		dbcmd.Connection = dbcon;
+        }
+
+        [TearDown]
+        public void ResetCmd()
+        {
+		Console.WriteLine("Resetting...\n");
+		dbcmd = null;
+        }
+
+        [TestFixtureTearDown]
+        public void Dispose()
+        {
+		try
+		{
+			dbcmd.Dispose();
+			dbcmd = null;
+			dbcon.Close();
+		}
+		catch(Exception){}
+		Console.WriteLine("Done.");
+        }
+
+        [Test]
+        public void InsertData()
+        {
+		Console.WriteLine("inserting data into MONO_TEST...");
+		dbcmd.CommandText =	"INSERT INTO MONO_TEST  (NID, NDESC, EMAIL ) VALUES(1,'Mono 1','chris@turchin.net')";
+		dbcmd.ExecuteNonQuery();
+		
+		dbcmd.CommandText ="INSERT INTO MONO_TEST  (NID, NDESC, EMAIL ) VALUES(2,'Mono 2','test@test')";
+		dbcmd.ExecuteNonQuery();
+		
+		dbcmd.CommandText = "INSERT INTO MONO_TEST  (NID, NDESC ) VALUES(3,'Mono 3')";
+		dbcmd.ExecuteNonQuery();
+		
+		dbcmd.CommandText ="INSERT INTO MONO_TEST (NID, NDESC ) VALUES(4,'Mono 4')";
+		dbcmd.ExecuteNonQuery();
+		
+		dbcmd.CommandText = "INSERT INTO MONO_TEST (NID, NDESC, EMAIL ) VALUES(5,'Mono 5','test@test')";
+		dbcmd.ExecuteNonQuery();
+		
+		Console.WriteLine("rows: " + GetRowCount().ToString());
+        }
+
+        [Test]
+        public void InsertWithPrimaryKey()
+        {
+		dbcmd.CommandText = "INSERT INTO MONO_TEST (NDESC, EMAIL ) VALUES('Mono with key','test@key.test')";
+		dbcmd.ExecuteNonQuery();
+        }
+
+        [Test]
+        public void InsertWithParameter()
+        {
+		dbcmd.CommandText = "INSERT INTO MONO_TEST (NDESC, EMAIL ) VALUES(:ndesc,'test@key.test')";
+		dbcmd.Parameters.Add(new SqliteParameter(":ndesc", "Mono as param") );
+		dbcmd.ExecuteNonQuery();
+        }
+
+        [Test]
+        public void SelectWithoutParameters()
+        {
+		dbcmd.CommandText =	"SELECT * FROM MONO_TEST where NID >  2";
+		Console.WriteLine("SelectWithoutParameters: " + dbcmd.CommandText + "\n\nexecute reader...");
+		ShowData( dbcmd.ExecuteReader());
+		Console.WriteLine("next test...");
+        }
+
+        [Test]
+        public void SelectWithMultipleParameters()
+        {
+		SqliteCommand dbcmdMulti= new SqliteCommand();
+		dbcmdMulti.Connection=dbcon;
+		dbcmdMulti.CommandText ="SELECT * FROM MONO_TEST where NID >=  :nid AND NDESC LIKE :ndesc and (EMAIL LIKE '%@test' or EMAIL = :email)";
+		
+		dbcmdMulti.Parameters.Add(new SqliteParameter(":nid" , 1) );
+		dbcmdMulti.Parameters.Add(new SqliteParameter(":ndesc", "_ono%") );
+		dbcmdMulti.Parameters.Insert(1,new SqliteParameter(":email","chris@turchin.net"));
+		
+		Console.WriteLine("SelectWithMultipleParameters: " + dbcmdMulti.CommandText + "\n\nexecute reader...");
+		ShowData( dbcmdMulti.ExecuteReader());
+		Console.WriteLine("next test...");
+        }
+
+        [Test]
+        public void SelectWithUnnamedParameters()
+        {
+		SqliteCommand dbcmdUnnamed= new SqliteCommand("SELECT * FROM MONO_TEST where NID >  :1 AND NDESC LIKE :2 and (EMAIL LIKE '%@test' or EMAIL = :3)");
+		dbcmdUnnamed.Connection=dbcon;
+		SqliteParameter param = new SqliteParameter();
+		SqliteParameter param2 = new SqliteParameter();
+		
+		param.Value = 1;
+		param.DbType = DbType.Int32;
+		param2.Value = "_ono 5";
+		
+		dbcmdUnnamed.Parameters.Add(param);
+		dbcmdUnnamed.Parameters.Add(param2);
+		dbcmdUnnamed.Parameters.Insert(1,new SqliteParameter(":3","chris@turchin.net"));
+		
+		Console.WriteLine("SelectWithUnnamedParameters: " + dbcmdUnnamed.CommandText + "\n\nexecute reader...");
+		
+		ShowData( dbcmdUnnamed.ExecuteReader());
+		//Console.WriteLine(dbcmdUnnamed.Parameters[0].ParameterName);
+		Console.WriteLine("next test...");
+        }
+
+
+        [Test]
+        public void TransactionCommit()
+        {
+		Console.WriteLine("reopen the connection for transaction tests...");
+		int rowCount = GetRowCount();
+		
+		dbcon.Close();
+		dbcon.ConnectionString = connectionString;
+		dbcon.Open();
+		
+		SqliteTransaction trans = (SqliteTransaction)dbcon.BeginTransaction();
+		
+		dbcmd.CommandText = "INSERT INTO MONO_TEST (NDESC, EMAIL ) VALUES('Mono trans1 ','tran@key.test')";
+		dbcmd.ExecuteNonQuery();
+		
+		dbcmd.CommandText = "INSERT INTO MONO_TEST (NDESC, EMAIL ) VALUES('Mono trans2','tran@key.test')";
+		dbcmd.ExecuteNonQuery();
+		
+		trans.Commit();
+		int rowCountAfter =GetRowCount();
+		Console.WriteLine(rowCount+2 +" == " + rowCountAfter);
+		Assert.AreEqual(rowCount+2,rowCountAfter);
+        }
+
+
+        [Test]
+        public void TransactionRollback()
+        {
+		Console.WriteLine("reopen the connection for transaction tests...");
+		int rowCount = GetRowCount();
+		
+		dbcon.Close();
+		dbcon.ConnectionString = connectionString;
+		dbcon.Open();
+		
+		SqliteTransaction trans = (SqliteTransaction)dbcon.BeginTransaction();
+		
+		dbcmd.CommandText = "INSERT INTO MONO_TEST (NDESC, EMAIL ) VALUES('Mono trans1 ','tran@key.test')";
+		dbcmd.ExecuteNonQuery();
+		
+		dbcmd.CommandText = "INSERT INTO MONO_TEST (NDESC, EMAIL ) VALUES('Mono trans2','tran@key.test')";
+		dbcmd.ExecuteNonQuery();
+		
+		trans.Rollback();
+		int rowCountAfter =GetRowCount();
+		Console.WriteLine(rowCount +" == " + rowCountAfter);
+		Assert.AreEqual(rowCount,rowCountAfter);
+        }
+
+        [Test]
+        public void CustomDataAdapterSelect()
+        {
+		DataAdapter custDA = PrepareDataAdapter();
+		DataSet dataset = new DataSet();
+		custDA.Fill(dataset);
+		dataset.AcceptChanges();
+		DisplayDataSet(dataset);
+		
+		//clear and reload
+		dataset.Clear();
+		custDA.Fill(dataset);
+		DisplayDataSet(dataset);
+        }
+
+        [Test]
+        public void DataSetAsXml()
+        {
+		DataAdapter custDA = PrepareDataAdapter();
+		DataSet dataset = new DataSet();
+		custDA.Fill(dataset);
+		//now as xml
+		Console.WriteLine("read and display data as XML");
+		Console.WriteLine(dataset.GetXml());
+        }
+
+        [Test]
+        public void DataAdapterAddRow()
+        {
+		DataAdapter custDA = PrepareDataAdapter();
+		
+		//Add a Row
+		DataSet dataset = new DataSet();
+		custDA.Fill(dataset);
+		DataRow newRow = dataset.Tables[0].NewRow();
+		newRow["NID"] = 999;
+		newRow["NDESC"]   = "newDesc";
+		newRow["EMAIL"]   = "new@Desc.at";
+		dataset.Tables[0].Rows.Add(newRow);
+		
+		int rowsAffected = custDA.Update(dataset);
+		Stdlib.printf("AddRow affected: "  + rowsAffected);
+		Assert.AreEqual(1,rowsAffected);
+        }
+
+        [Test]
+        public void DataAdapterChangeRow()
+        {
+		updatingFired = false;
+		updatedFired = false;
+		
+		SqliteDataAdapter custDA = (SqliteDataAdapter)PrepareDataAdapter();
+		DataSet dataset = new DataSet();
+		custDA.Fill(dataset);
+		// Add handlers.
+		custDA.RowUpdating += new SqliteRowUpdatingEventHandler(OnRowUpdating);
+		custDA.RowUpdated += new SqliteRowUpdatedEventHandler(OnRowUpdated);
+		
+		//Change one Row
+		DataRow dataRow = dataset.Tables[0].Rows[0];
+		dataRow["NDESC"] = "CHANGED";
+		
+		
+		int rowsAffected = custDA.Update(dataset);
+		Assert.AreEqual(1,rowsAffected);
+		
+		//remove handlers
+		
+		Assert.IsTrue(updatingFired);
+		Assert.IsTrue(updatedFired);
+		
+		custDA.RowUpdating -= new SqliteRowUpdatingEventHandler(OnRowUpdating);
+		custDA.RowUpdated -= new SqliteRowUpdatedEventHandler(OnRowUpdated);
+        }
+
+
+        [Test]
+        public void DataAdapterRemoveRow()
+        {
+		DataAdapter custDA = PrepareDataAdapter();
+		DataSet dataset = new DataSet();
+		custDA.Fill(dataset);
+		DataRow victim = dataset.Tables[0].Rows[3];
+		victim.Delete();
+		
+		int rowsAffected = custDA.Update(dataset);
+		Assert.AreEqual(1,rowsAffected);
+		Console.WriteLine("Rows affected: " + rowsAffected.ToString());
+        }
+
+        public void OnRowUpdating(object sender, RowUpdatingEventArgs args)
+        {
+            Console.WriteLine("OnRowUpdating fired...");
+            IDbCommand cmd = args.Command;
+            Console.WriteLine(cmd.CommandText);
+            Console.WriteLine(cmd.Parameters.Count);
+            for (int x=0;x<cmd.Parameters.Count;x++)
+                Console.WriteLine(((SqliteParameter)cmd.Parameters[x]).ParameterName);
+
+            updatingFired=true;
+        }
+
+        public void OnRowUpdated(object sender, RowUpdatedEventArgs args)
+        {
+            Console.WriteLine("OnRowUpdated fired...");
+
+            updatedFired=true;
+        }
+
+        // HELPER FUNCTIONS BELOW HERE
+
+        static DataAdapter PrepareDataAdapter()
+        {
+		dbcmd.CommandText = "SELECT NID, NDESC, EMAIL FROM MONO_TEST";
+		SqliteCommand update = new SqliteCommand("UPDATE MONO_TEST SET NID = :NID, NDESC = :NDESC, EMAIL = :EMAIL WHERE NID = :NID ");
+		update.Connection=dbcon;
+		SqliteCommand delete = new SqliteCommand("DELETE FROM MONO_TEST WHERE NID = :NID");
+		delete.Connection=dbcon;
+		SqliteCommand insert = new SqliteCommand("INSERT INTO MONO_TEST  (NID, NDESC, EMAIL ) VALUES(:NID,:NDESC,:EMAIL)");
+		insert.Connection=dbcon;
+		SqliteDataAdapter custDA = new SqliteDataAdapter(dbcmd);
+		
+		SqliteParameter nid = new SqliteParameter();
+		nid.ParameterName = ":NID";
+		nid.DbType = DbType.Int32;
+		nid.SourceColumn = "NID";
+		nid.SourceVersion = DataRowVersion.Current;
+		
+		SqliteParameter ndesc = new SqliteParameter();
+		ndesc.ParameterName = ":NDESC";
+		ndesc.DbType = DbType.String;
+		ndesc.SourceColumn = "NDESC";
+		ndesc.SourceVersion = DataRowVersion.Current;
+		
+		SqliteParameter email = new SqliteParameter();
+		email.ParameterName =":EMAIL";
+		email.DbType = DbType.String;
+		email.SourceColumn = "EMAIL";
+		email.SourceVersion = DataRowVersion.Current;
+		
+		update.Parameters.Add(nid);
+		update.Parameters.Add(ndesc);
+		update.Parameters.Add(email);
+		
+		delete.Parameters.Add(nid);
+		
+		insert.Parameters.Add(nid);
+		insert.Parameters.Add(ndesc);
+		insert.Parameters.Add(email);
+		
+		custDA.UpdateCommand = update;
+		custDA.DeleteCommand = delete;
+		custDA.InsertCommand = insert;
+		
+		return custDA;
+        }
+
+        static int GetRowCount()
+        {
+		dbcmd.CommandText =	"SELECT count(*) FROM MONO_TEST";
+		SqliteDataReader reader =(SqliteDataReader)dbcmd.ExecuteReader();
+		int result = -1;
+		while(reader.Read())
+		result = Convert.ToInt32(reader[0]);
+		
+		return result;
+        }
+
+        //Display data from DataSet
+        static void DisplayDataSet(DataSet dataset)
+        {
+		foreach(DataTable myTable in dataset.Tables)
+		{
+			foreach(DataRow myRow in myTable.Rows)
+			{
+				Console.Write("datarow:\t");
+				string data = myRow["NID"] + "|\t" + myRow["NDESC"] + "|\t" + myRow["EMAIL"] ;
+				Console.WriteLine(data);
+			}
+		}
+        }
+
+        //display data from datareader
+        static void ShowData(SqliteDataReader reader)
+        {
+		Console.WriteLine("read and display data...");
+		while(reader.Read()) 
+		{
+			Console.Write("datarow:\t" + reader[0].ToString());
+			Console.Write("|\t" + reader[1].ToString());
+			string email;
+			if (reader[2]==null)
+			email = "(null)";
+			else
+			email = reader[2].ToString();
+			Console.Write("|\t" + email + "\n");
+		}
+		reader.Close();
+		Console.WriteLine("current row count: " + GetRowCount().ToString());
+        }
+    }
+}
Index: Test/Makefile
===================================================================
--- Test/Makefile	(revision 0)
+++ Test/Makefile	(revision 0)
@@ -0,0 +1,20 @@
+all:
+	mcs --debug -r:System.Data -r:Mono.Data.SqliteClient SqliteTest.cs
+
+test:
+	make all
+	mono --debug SqliteTest.exe
+
+gnunit:
+	mcs /t:library -r:System.Data -r:Mono.Data.SqliteClient -r:nunit.framework SqliteUnitTests.cs
+	gnunit SqliteUnitTests.dll
+
+nunit:
+	mcs -debug /t:library -r:System.Data -r:Mono.Data.SqliteClient,Mono.Posix,nunit.framework SqliteUnitTests.cs
+	mono --debug nunit-console.exe SqliteUnitTests.dll
+
+clean: 
+	rm *dll
+	rm *exe
+	rm *db
+
