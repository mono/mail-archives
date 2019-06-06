Index: ChangeLog
===================================================================
--- ChangeLog	(revision 44908)
+++ ChangeLog	(working copy)
@@ -1,3 +1,8 @@
+2005-05-23 Boris Kirzner <borisk@mainsoft.com>
+	* DbCommand.cs - added #ifdef NET_2_0 on DbCommandOptionalFeatures. 
+	* ExceptionHelper.cs - removed jave references. Exceptions created on formatted text messages.
+	* DbParameterCollection.cs - implemented indexer properties.
+	
 2005-05-20 Umadevi S <sumadevi@novell.com>
 	* Added file DbProviderSpecificTypePropertyAttribute.cs
 
Index: DbCommand.cs
===================================================================
--- DbCommand.cs	(revision 44908)
+++ DbCommand.cs	(working copy)
@@ -72,10 +72,12 @@
 			set { Transaction = (DbTransaction) value; }
 		}
 
+#if NET_2_0
 		[MonoTODO]
 		public virtual DbCommandOptionalFeatures OptionalFeatures { 
 			get { throw new NotImplementedException (); }
 		}
+#endif
 
 		public DbParameterCollection Parameters {
 			get { return DbParameterCollection; }
Index: ExceptionHelper.cs
===================================================================
--- ExceptionHelper.cs	(revision 44908)
+++ ExceptionHelper.cs	(working copy)
@@ -7,59 +7,31 @@
 
 using System;
 
-using java.util;
-
 namespace System.Data.Common
 {
 	internal sealed class ExceptionHelper
-	{
-		sealed class ResourceManager
-		{
-			private static readonly ResourceBundle _resourceBundle = ResourceBundle.getBundle("SystemData");
-			
-			internal ResourceManager()
-			{				
-			}
-			
-			internal string GetString(string key)
-			{
-				return _resourceBundle.getString(key);
-			}
-		}
-
-		static ResourceManager _resourceManager = new ResourceManager();
-		
+	{	
 		internal static ArgumentException InvalidSizeValue(int value)
 		{
 			string[] args = new string[] {value.ToString()};
-			return new ArgumentException(GetExceptionMessage("ADP_InvalidSizeValue",args));
+			return new ArgumentException(GetExceptionMessage("Invalid parameter Size value '{0}'. The value must be greater than or equal to 0.",args));
 		}
 
 		internal static ArgumentOutOfRangeException InvalidDataRowVersion(DataRowVersion value)
-		{
-			return InvalidEnumerationValue(typeof(DataRowVersion), (int) value);
+		{			
+			object[] args = new object[] { "DataRowVersion", value.ToString() } ;
+			return new ArgumentOutOfRangeException(GetExceptionMessage("{0}: Invalid DataRow Version enumeration value: {1}",args));
 		}
-		 
-		internal static ArgumentOutOfRangeException InvalidEnumerationValue(Type type, int value)
-		{
-			object[] args = new object[] { type.Name, value.ToString() } ;
-			return new ArgumentOutOfRangeException(GetExceptionMessage("ADP_InvalidEnumerationValue",args));
-		}
- 
-		internal static ArgumentException InvalidOffsetValue(int value)
-		{
-			string[] args = new string[] {value.ToString()};
-			return new ArgumentException(GetExceptionMessage("ADP_InvalidOffsetValue",args));
-		}
 
 		internal static ArgumentOutOfRangeException InvalidParameterDirection(ParameterDirection value)
 		{
-			return InvalidEnumerationValue(typeof(ParameterDirection), (int) value);
+			object[] args = new object[] { "ParameterDirection", value.ToString() } ;
+			return new ArgumentOutOfRangeException(GetExceptionMessage("Invalid direction '{0}' for '{1}' parameter.",args));
 		}
 
 		internal static InvalidOperationException NoStoredProcedureExists(string procedureName) {
 			object[] args = new object[1] { procedureName } ;
-			return new InvalidOperationException(GetExceptionMessage("ADP_NoStoredProcedureExists", args));
+			return new InvalidOperationException(GetExceptionMessage("The stored procedure '{0}' doesn't exist.", args));
 		}
 
 		internal static ArgumentNullException ArgumentNull(string parameter)
@@ -69,111 +41,111 @@
 
 		internal static InvalidOperationException TransactionRequired()
 		{
-			return new InvalidOperationException(GetExceptionMessage("ADP_TransactionRequired_Execute"));
+			return new InvalidOperationException(GetExceptionMessage("Execute requires the command to have a transaction object when the connection assigned to the command is in a pending local transaction.  The Transaction property of the command has not been initialized."));
 		}
 
 		internal static ArgumentOutOfRangeException InvalidOleDbType(int value)
 		{
 			string[] args = new string[] {value.ToString()};
-			return new ArgumentOutOfRangeException(GetExceptionMessage("OleDb_InvalidOleDbType",args));
+			return new ArgumentOutOfRangeException(GetExceptionMessage("Invalid OleDbType enumeration value: {0}",args));
 		}
  
 		internal static ArgumentException InvalidDbType(int value)
 		{
 			string[] args = new string[] {value.ToString()};
-			return new ArgumentException(GetExceptionMessage("ADP_UnknownDataType",args));
+			return new ArgumentException(GetExceptionMessage("No mapping exists from DbType {0} to a known {1}.",args));
 		}
 
 		internal static InvalidOperationException DeriveParametersNotSupported(Type type,CommandType commandType)
 		{
 			string[] args = new string[] {type.ToString(),commandType.ToString()};
-			return new InvalidOperationException(GetExceptionMessage("ADP_DeriveParametersNotSupported",args));
+			return new InvalidOperationException(GetExceptionMessage("{0} DeriveParameters only supports CommandType.StoredProcedure, not CommandType.{1}.",args));
 		}
 
 		internal static InvalidOperationException ReaderClosed(string mehodName)
 		{
 			string[] args = new string[] {mehodName};
-			return new InvalidOperationException(GetExceptionMessage("ADP_DataReaderClosed",args));
+			return new InvalidOperationException(GetExceptionMessage("Invalid attempt to {0} when reader is closed.",args));
 		}
 
 		internal static ArgumentOutOfRangeException InvalidSqlDbType(int value)
 		{
 			string[] args = new string[] {value.ToString()};
-			return new ArgumentOutOfRangeException(GetExceptionMessage("SQL_InvalidSqlDbType",args));
+			return new ArgumentOutOfRangeException(GetExceptionMessage("{0}: Invalid SqlDbType enumeration value: {1}.",args));
 		}
 
 		internal static ArgumentException UnknownDataType(string type1, string type2)
 		{
 			string[] args = new string[] {type1, type2};
-			return new ArgumentException(GetExceptionMessage("ADP_UnknownDataType",args));
+			return new ArgumentException(GetExceptionMessage("No mapping exists from DbType {0} to a known {1}.",args));
 		}
 
 		internal static InvalidOperationException TransactionNotInitialized()
 		{
-			return new InvalidOperationException(GetExceptionMessage("ADP_TransactionRequired_Execute"));
+			return new InvalidOperationException(GetExceptionMessage("Execute requires the command to have a transaction object when the connection assigned to the command is in a pending local transaction.  The Transaction property of the command has not been initialized."));
 		}
 
 		internal static InvalidOperationException ParametersNotInitialized(int parameterPosition,string parameterName,string parameterType)
 		{
 			object[] args = new object[] {parameterPosition,parameterName,parameterType};
-			return new InvalidOperationException(GetExceptionMessage("OleDb_UninitializedParameters",args));
+			return new InvalidOperationException(GetExceptionMessage("Parameter {0}: '{1}', the property DbType is uninitialized: OleDbType.{2}.",args));
 		}
 
 		internal static InvalidOperationException WrongParameterSize(string provider)
 		{
 			string[] args = new string[] {provider};
-			return new InvalidOperationException(GetExceptionMessage("ADP_PrepareParameterSize",args));
+			return new InvalidOperationException(GetExceptionMessage("{0}.Prepare method requires all variable length parameters to have an explicitly set non-zero Size.",args));
 		}
 
 		internal static InvalidOperationException ConnectionNotOpened(string operationName, string connectionState)
 		{
 			object[] args = new object[] {operationName,connectionState};
-			return new InvalidOperationException(GetExceptionMessage("ADP_OpenConnectionRequired_PropertySet",args));
+			return new InvalidOperationException(GetExceptionMessage("{0} requires an open and available Connection. The connection's current state is {1}.",args));
 		}
 
 		internal static InvalidOperationException ConnectionNotInitialized(string methodName)
 		{
 			object[] args = new object[] {methodName};
-			return new InvalidOperationException(GetExceptionMessage("ADP_ConnectionRequired_ExecuteReader",args));
+			return new InvalidOperationException(GetExceptionMessage("{0}: Connection property has not been initialized.",args));
 		}
 
 		internal static InvalidOperationException OpenConnectionRequired(string methodName, object connectionState)
 		{
 			object[] args = new object[] {methodName, connectionState};
-			return new InvalidOperationException(GetExceptionMessage("ADP_OpenConnectionRequired_Fill",args));
+			return new InvalidOperationException(GetExceptionMessage("{0} requires an open and available Connection. The connection's current state is {1}.",args));
 		}
 
 		internal static InvalidOperationException OpenedReaderExists()
 		{
-			return new InvalidOperationException(GetExceptionMessage("ADP_OpenReaderExists"));
+			return new InvalidOperationException(GetExceptionMessage("There is already an open DataReader associated with this Connection which must be closed first."));
 		}
 
 		internal static InvalidOperationException ConnectionAlreadyOpen(object connectionState)
 		{
 			object[] args = new object[] {connectionState};
-			return new InvalidOperationException(GetExceptionMessage("ADP_ConnectionAlreadyOpen",args));
+			return new InvalidOperationException(GetExceptionMessage("The connection is already Open (state={0}).",args));
 		}
 
 		internal static InvalidOperationException ConnectionStringNotInitialized()
 		{
-			return new InvalidOperationException(GetExceptionMessage("ADP_NoConnectionString"));
+			return new InvalidOperationException(GetExceptionMessage("The ConnectionString property has not been initialized."));
 		}
 
 		internal static InvalidOperationException ConnectionIsBusy(object commandType,object connectionState)
 		{
 			object[] args = new object[] {commandType.ToString(), connectionState.ToString()};
-			return new InvalidOperationException(GetExceptionMessage("ADP_CommandIsActive",args));
+			return new InvalidOperationException(GetExceptionMessage("The {0} is currently busy {1}.",args));
 		}
 
 		internal static InvalidOperationException NotAllowedWhileConnectionOpen(string propertyName, object connectionState)
 		{
 			object[] args = new object[] {propertyName,connectionState};
-			return new InvalidOperationException(GetExceptionMessage("ADP_OpenConnectionPropertySet",args));
+			return new InvalidOperationException(GetExceptionMessage("Not allowed to change the '{0}' property while the connection (state={1}).",args));
 		}
 
 		internal static ArgumentException OleDbNoProviderSpecified()
 		{
-			return new ArgumentException(GetExceptionMessage("OleDb_NoProviderSpecified"));
+			return new ArgumentException(GetExceptionMessage("An OLE DB Provider was not specified in the ConnectionString.  An example would be, 'Provider=SQLOLEDB;'."));
 		}
 
 		internal static ArgumentException InvalidValueForKey(string key)
@@ -185,29 +157,40 @@
 		internal static InvalidOperationException ParameterSizeNotInitialized(int parameterIndex, string parameterName,string parameterType,int parameterSize)
 		{
 			object[] args = new object[] { parameterIndex.ToString(),parameterName,parameterType,parameterSize.ToString()};
-			return new InvalidOperationException(GetExceptionMessage("ADP_UninitializedParameterSize",args));
+			return new InvalidOperationException(GetExceptionMessage("Parameter {0}: '{1}' of type: {2}, the property Size has an invalid size: {3}",args));
 		}
 
 		internal static ArgumentException InvalidUpdateStatus(UpdateStatus status)
 		{
 			object[] args = new object[] { status };
-			return new ArgumentException(GetExceptionMessage("ADP_InvalidUpdateStatus",args));
+			return new ArgumentException(GetExceptionMessage("Invalid UpdateStatus: {0}",args));
 		}
 
 		internal static InvalidOperationException UpdateRequiresCommand(string command)
 		{
-			return new InvalidOperationException(GetExceptionMessage("ADP_UpdateRequiresCommand" + command));
+			object[] args = new object[] { command };
+			return new InvalidOperationException(GetExceptionMessage("Auto SQL generation during {0} requires a valid SelectCommand.",args));
 		}
 
 		internal static DataException RowUpdatedError()
 		{
-			return new DataException(GetExceptionMessage("ADP_RowUpdatedErrors"));
+			return new DataException(GetExceptionMessage("RowUpdatedEvent: Errors occurred; no additional is information available."));
 		}
 
-		internal static string GetExceptionMessage(string key,object[] args)
+		internal static ArgumentNullException CollectionNoNullsAllowed(object collection, object objectsType)
 		{
-			string exceptionMessage = _resourceManager.GetString(key);
+			object[] args = new object[] {collection.GetType().ToString(), objectsType.ToString()};
+			return new ArgumentNullException(GetExceptionMessage("The {0} only accepts non-null {1} type objects."));
+		}
 
+		internal static ArgumentException CollectionAlreadyContains(object objectType,string propertyName, object propertyValue, object collection)
+		{
+			object[] args = new object[] {objectType.ToString(), propertyName, propertyValue, collection.GetType().ToString()};
+			return new ArgumentException(GetExceptionMessage("The {0} with {1} '{2}' is already contained by this {3}.",args));
+		}
+
+		internal static string GetExceptionMessage(string exceptionMessage,object[] args)
+		{
 			if ((args == null) || (args.Length == 0)) {
 				return exceptionMessage;
 			}
@@ -216,9 +199,9 @@
 			}
 		}
 
-		internal static string GetExceptionMessage(string key)
+		internal static string GetExceptionMessage(string exceptionMessage)
 		{
-			return GetExceptionMessage(key,null);
+			return GetExceptionMessage(exceptionMessage,null);
 		}
 	}
 }
Index: DbParameterCollection.cs
===================================================================
--- DbParameterCollection.cs	(revision 44908)
+++ DbParameterCollection.cs	(working copy)
@@ -56,25 +56,29 @@
 			set { this [parameterName] = (DbParameter) value; }
 		}
 
-		object IList.this [int objA] {
-			get { return this [objA]; }
-			set { this [objA] = (DbParameter) value; }
+		object IList.this [int index] {
+			get { return this [index]; }
+			set { this [index] = (DbParameter) value; }
 		}
 
 		public abstract bool IsFixedSize { get; }
 		public abstract bool IsReadOnly { get; }
 		public abstract bool IsSynchronized { get; }
 
-		[MonoTODO]
-		public DbParameter this [string ulAdd] { 
-			get { throw new NotImplementedException (); }
-			set { throw new NotImplementedException (); }
+		public DbParameter this [string parameterName] { 
+			get { 
+				int index = IndexOf(parameterName);
+				return this[index];
+			}
+			set { 
+                int index = IndexOf(parameterName);
+				this[index] = value;
+			}
 		}
 
-		[MonoTODO]
-		public DbParameter this [[Optional] int ulAdd] { 
-			get { throw new NotImplementedException (); }
-			set { throw new NotImplementedException (); }
+		public DbParameter this [[Optional] int index] { 
+			get { return GetParameter(index); }
+			set { SetParameter(index,value); }
 		}
 
 		public abstract object SyncRoot { get; } 
@@ -84,8 +88,12 @@
 		#region Methods
 
 		public abstract int Add (object value);
+
+#if NET_2_0
 		public abstract void AddRange (Array values);
 		protected abstract int CheckName (string parameterName);
+#endif
+
 		public abstract void Clear ();
 		public abstract bool Contains (object value);
 		public abstract bool Contains (string value);
