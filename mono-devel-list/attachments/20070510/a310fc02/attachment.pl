Index: Mono.Data.Tds/Mono.Data.Tds/TdsMetaParameter.cs
===================================================================
--- Mono.Data.Tds/Mono.Data.Tds/TdsMetaParameter.cs	(revision 77105)
+++ Mono.Data.Tds/Mono.Data.Tds/TdsMetaParameter.cs	(working copy)
@@ -194,7 +194,10 @@
 
 			switch (Value.GetType ().ToString ()) {
 			case "System.String":
-				return ((string) value).Length;
+				int len = ((string)value).Length;
+				if (TypeName == "nvarchar" || TypeName == "nchar" || TypeName == "ntext")
+					len *= 2;
+				return len ;	
 			case "System.Byte[]":
 				return ((byte[]) value).Length;
 			}
@@ -203,45 +206,91 @@
 
 		private int GetSize ()
 		{
-			if (IsNullable) {
-				switch (TypeName) {
-				case "bigint":
-					return 8;
-				case "datetime":
-					return 8;
-				case "float":
-					return 8;
-				case "int":
-					return 4;
-				case "real":
-					return 4;
-				case "smalldatetime":
-					return 4;
-				case "smallint":
-					return 2;
-				case "tinyint":
-					return 1;
-				}
+			switch (TypeName) {
+			case "decimal":
+				return 17;
+			case "uniqueidentifier":
+				return 16;
+			case "bigint":
+			case "datetime":
+			case "float":
+			case "money":
+				return 8;
+			case "int":
+			case "real":
+			case "smalldatetime":
+			case "smallmoney":
+				return 4;
+			case "smallint":
+				return 2;
+			case "tinyint":
+			case "bit":
+				return 1;
+			/*
+			case "nvarchar" :
+			*/
+			case "nchar" :
+			case "ntext" :
+				return size*2 ;
 			}
 			return size;
 		}
 
+		internal byte[] GetBytes ()
+		{
+			byte[] result = {};
+			if (Value == DBNull.Value || Value == null)
+				return result;
+
+			switch (TypeName)
+			{
+				case "nvarchar" :
+				case "nchar" :
+				case "ntext" :
+					return Encoding.Unicode.GetBytes ((string)Value);
+				case "varchar" :
+				case "char" :
+				case "text" :
+					return Encoding.ASCII.GetBytes ((string)Value);
+				default :
+					return ((byte[]) Value);
+			}
+		}
+
 		internal TdsColumnType GetMetaType ()
 		{
 			switch (TypeName) {
 			case "binary":
-				return TdsColumnType.Binary;
+				return TdsColumnType.BigBinary;
 			case "bit":
+				if (IsNullable)
+					return TdsColumnType.BitN;
 				return TdsColumnType.Bit;
+			case "bigint":
+				return TdsColumnType.IntN;
 			case "char":
 				return TdsColumnType.Char;
+			case "money":
+				if (IsNullable)
+					return TdsColumnType.MoneyN;
+				return TdsColumnType.Money;
+			case "smallmoney":
+				if (IsNullable)
+					return TdsColumnType.MoneyN ;
+				return TdsColumnType.Money4;
 			case "decimal":
 				return TdsColumnType.Decimal;
 			case "datetime":
 				if (IsNullable)
 					return TdsColumnType.DateTimeN;
 				return TdsColumnType.DateTime;
+			case "smalldatetime":
+				if (IsNullable)
+					return TdsColumnType.DateTimeN;
+				return TdsColumnType.DateTime4;
 			case "float":
+				if (IsNullable)
+					return TdsColumnType.FloatN ;
 				return TdsColumnType.Float8;
 			case "image":
 				return TdsColumnType.Image;
@@ -256,8 +305,10 @@
 			case "ntext":
 				return TdsColumnType.NText;
 			case "nvarchar":
-				return TdsColumnType.NVarChar;
+				return TdsColumnType.BigNVarChar;
 			case "real":
+				if (IsNullable)
+					return TdsColumnType.FloatN ;
 				return TdsColumnType.Real;
 			case "smallint":
 				if (IsNullable)
@@ -272,11 +323,11 @@
 			case "uniqueidentifier":
 				return TdsColumnType.UniqueIdentifier;
 			case "varbinary":
-				return TdsColumnType.VarBinary;
+				return TdsColumnType.BigVarBinary;
 			case "varchar":
-				return TdsColumnType.VarChar;
+				return TdsColumnType.BigVarChar;
 			default:
-				throw new NotSupportedException ();
+				throw new NotSupportedException ("Unknown Type : " + TypeName);
 			}
 		}
 
Index: Mono.Data.Tds/Mono.Data.Tds.Protocol/Tds70.cs
===================================================================
--- Mono.Data.Tds/Mono.Data.Tds.Protocol/Tds70.cs	(revision 77105)
+++ Mono.Data.Tds/Mono.Data.Tds.Protocol/Tds70.cs	(working copy)
@@ -170,11 +170,11 @@
 			byte[] domainMagic =  {	6, 0x7d, 0x0f, 0xfd, 0xff, 0x0, 0x0, 0x0,
 									0x0, 0xe0, 0x83, 0x0, 0x0,
 									0x68, 0x01, 0x00, 0x00, 0x09, 0x04, 0x00, 0x00 };
-			byte[] sqlserverMagic = { 6, 0x83, 0xf2, 0xf8,
-										0xff, 0x0, 0x0, 0x0,
+			byte[] sqlserverMagic = { 6, 0x0, 0x0, 0x0,
+										0x0, 0x0, 0x0, 0x0,
 										0x0, 0xe0, 0x03, 0x0,
-										0x0, 0x88, 0xff, 0xff, 0xff, 0x36, 
-										0x04, 0x00, 0x00 };
+										0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 
+										0x0, 0x0, 0x0 };
 			byte[] magic = null;
 			
 			if (connectionParameters.DomainLogin == true)
@@ -219,8 +219,9 @@
 			
 			Comm.Append (totalPacketSize);
 
-			Comm.Append (empty, 3, pad);
-			Comm.Append ((byte) 0x70); // TDS Version 7
+			//Comm.Append (empty, 3, pad);
+			byte[] version = {0x00, 0x0, 0x0, 0x70};
+			Comm.Append (version); // TDS Version 7
 			Comm.Append ((int)this.PacketSize); // Set the Block Size
 			Comm.Append (empty, 3, pad);
 			Comm.Append (magic);
@@ -263,8 +264,8 @@
 			curPos += (short) (DataSource.Length * 2);
 
 			// Unknown
+			Comm.Append ((short) curPos);
 			Comm.Append ((short) 0);
-			Comm.Append ((short) 0);
 
 			// Library Name
 			Comm.Append (curPos);
@@ -383,12 +384,8 @@
 			
 		public override void ExecProc (string commandText, TdsMetaParameterCollection parameters, int timeout, bool wantResults)
 		{
-			if (parameters != null && parameters.Count > 0) {
-				Parameters = parameters;
-				ExecuteQuery (BuildProcedureCall (commandText), timeout, wantResults);
-			} else {
-				ExecRPC (commandText, parameters, timeout, wantResults);
-			}
+			Parameters = parameters;
+			ExecRPC (commandText, parameters, timeout, wantResults);
 		}
 
 		protected override void ExecRPC (string rpcName, TdsMetaParameterCollection parameters, 
@@ -396,15 +393,24 @@
 		{
 			// clean up 
 			InitExec ();
-			
 			Comm.StartPacket (TdsPacketType.RPC);
 
 			Comm.Append ( (short) rpcName.Length);
 			Comm.Append (rpcName);
 			Comm.Append ( (short) 0); //no meta data
-
-			// FIXME : support parameters here
-
+			if (parameters != null) {
+			foreach (TdsMetaParameter param in parameters) {
+				if (param.Direction == TdsParameterDirection.ReturnValue) 
+					continue;
+				Comm.Append ( (byte) param.ParameterName.Length );
+				Comm.Append (param.ParameterName);
+				short status = 0; // unused
+				if (param.Direction != TdsParameterDirection.Input)
+					status |= 0x01; // output
+				Comm.Append ( (byte) status);
+				WriteParameterInfo (param);
+			}
+			}
 			Comm.SendPacket ();
 			CheckForData (timeout);
 			if (!wantResults) 
@@ -412,6 +418,96 @@
 
 		}
 
+		private void WriteParameterInfo (TdsMetaParameter param)
+		{
+			/*
+			Ms.net send non-nullable datatypes as nullable and allows setting null values
+			to int/float etc.. So, using Nullable form of type for all data
+			*/
+			param.IsNullable = true;
+			TdsColumnType colType = param.GetMetaType ();
+			param.IsNullable = false;
+
+			Comm.Append ((byte)colType); // type
+				
+			int size = 0 ;
+			if (param.Size == 0)
+				size = param.GetActualSize ();
+			else
+				size = param.Size;
+
+			/*
+			  If column type is SqlDbType.NVarChar the size of parameter is multiplied by 2
+			  FIXME: Need to check for other types
+			 */
+			if (colType == TdsColumnType.BigNVarChar)
+				size <<= 1;
+			if (IsLargeType (colType))
+				Comm.Append ((short)size); // Parameter size passed in SqlParameter
+			else if (IsBlobType (colType))
+				Comm.Append (size); // Parameter size passed in SqlParameter
+			else 
+				Comm.Append ((byte)size);
+
+			// Precision and Scale are non-zero for only decimal/numeric
+			if ( param.TypeName == "decimal" || param.TypeName == "numeric") {
+				Comm.Append ((param.Precision!=0)?param.Precision:(byte)28);
+				Comm.Append (param.Scale);
+			}
+
+			size = param.GetActualSize ();
+			if (IsLargeType (colType))
+				Comm.Append ((short)size);
+			else if (IsBlobType (colType))
+				Comm.Append (size);
+			else
+				Comm.Append ((byte)size);
+
+			if (size > 0) {
+			switch (param.TypeName) { 
+			case "money" :
+				{
+					Decimal val = (decimal) param.Value;
+					int[]  arr = Decimal.GetBits (val);
+					int sign = (val>0 ? 1: -1);
+					Comm.Append (sign * arr[1]);
+					Comm.Append (sign * arr[0]);
+				}
+				break;
+			case "smallmoney":
+				{
+					Decimal val = (decimal) param.Value;
+					int[]  arr = Decimal.GetBits (val);
+					int sign = (val>0 ? 1: -1);
+					Comm.Append (sign * arr[0]);
+				}
+				break;
+			case "datetime":
+				Comm.Append ((DateTime)param.Value, 8);
+				break;
+			case "smalldatetime":
+				Comm.Append ((DateTime)param.Value, 4);
+				break;
+			case "varchar" :
+			case "nvarchar" :
+			case "char" :
+			case "nchar" :
+			case "text" :
+			case "ntext" :
+				byte [] tmp = param.GetBytes ();
+				Comm.Append (tmp);
+				break;
+			case "uniqueidentifier" :
+				Comm.Append (((Guid)param.Value).ToByteArray());
+				break;
+			default : 
+				Comm.Append (param.Value);
+				break;
+			}
+			}
+			return;
+		}
+
 		public override void Execute (string commandText, TdsMetaParameterCollection parameters, int timeout, bool wantResults)
 		{
 			Parameters = parameters;
@@ -428,7 +524,7 @@
 
                 private bool IsLargeType (TdsColumnType columnType)
 		{
-			return (columnType == TdsColumnType.NChar || (byte) columnType > 128);
+			return ((byte) columnType > 128);
 		}
 
 		private string FormatParameter (TdsMetaParameter parameter)
@@ -504,25 +600,26 @@
 			Parameters = parameters;
 
 			TdsMetaParameterCollection parms = new TdsMetaParameterCollection ();
-			TdsMetaParameter parm = new TdsMetaParameter ("@P1", "int", null);
+			TdsMetaParameter parm = new TdsMetaParameter ("@Handle", "int", null);
 			parm.Direction = TdsParameterDirection.Output;
 			parms.Add (parm);
 
-			parms.Add (new TdsMetaParameter ("@P2", "nvarchar", BuildPreparedParameters ()));
-			parms.Add (new TdsMetaParameter ("@P3", "nvarchar", commandText));
+			parms.Add (new TdsMetaParameter ("@VarDecl", "nvarchar", BuildPreparedParameters ()));
+			parms.Add (new TdsMetaParameter ("@Query", "nvarchar", commandText));
 
 			ExecProc ("sp_prepare", parms, 0, true);
 			SkipToEnd ();	
-			if (ColumnValues [0] == null || ColumnValues [0] == DBNull.Value)
-				throw new TdsInternalException ();
-			return ColumnValues [0].ToString ();
+			return OutputParameters[0].ToString () ;
+			//if (ColumnValues == null || ColumnValues [0] == null || ColumnValues [0] == DBNull.Value)
+			//	throw new TdsInternalException ();
+			//return "" ;
+			//return ColumnValues [0].ToString ();
 		}
 
 		protected override TdsDataColumnCollection ProcessColumnInfo ()
 		{
 			TdsDataColumnCollection result = new TdsDataColumnCollection ();
 			int numColumns = Comm.GetTdsShort ();
-
 			for (int i = 0; i < numColumns; i += 1) {
 				byte[] flagData = new byte[4];
 				for (int j = 0; j < 4; j += 1) 
@@ -537,7 +634,7 @@
 				TdsColumnType columnType = (TdsColumnType) (Comm.GetByte () & 0xff);
 				if ((byte) columnType == 0xef)
 					columnType = TdsColumnType.NChar;
-			
+
 				byte xColumnType = 0;
 				if (IsLargeType (columnType)) {
 					xColumnType = (byte) columnType;
@@ -567,17 +664,20 @@
 				case TdsColumnType.NText:
 				case TdsColumnType.NChar:
 				case TdsColumnType.NVarChar:
+				  /**/
 					columnSize /= 2;
 					break;
 				case TdsColumnType.Decimal:
 				case TdsColumnType.Numeric:
+				  /*
+					Comm.Skip (1);
+				  */
 					precision = Comm.GetByte ();
 					scale = Comm.GetByte ();
 					break;
 				}
 
 				string columnName = Comm.GetString (Comm.GetByte ());
-
 				int index = result.Add (new TdsDataColumn ());
 				result[index]["AllowDBNull"] = nullable;
 				result[index]["ColumnName"] = columnName;
@@ -590,7 +690,6 @@
 				result[index]["NumericScale"] = scale;
 				result[index]["BaseTableName"] = tableName;
 			}
-
 			return result;
 		}
 
@@ -608,6 +707,19 @@
 			return true; 
 		}
 
+		protected override void ProcessReturnStatus ()
+		{
+			int result = Comm.GetTdsInt ();
+			if( Parameters != null ) {
+			foreach (TdsMetaParameter param in Parameters) {
+				if (param.Direction == TdsParameterDirection.ReturnValue){
+					param.Value = result;
+					break;
+				}
+			}
+		}
+		}
+
 		#endregion // Methods
 
 #if NET_2_0
Index: Mono.Data.Tds/Mono.Data.Tds.Protocol/TdsDataRow.cs
===================================================================
--- Mono.Data.Tds/Mono.Data.Tds.Protocol/TdsDataRow.cs	(revision 77105)
+++ Mono.Data.Tds/Mono.Data.Tds.Protocol/TdsDataRow.cs	(working copy)
@@ -80,7 +80,7 @@
 
 		public object this[int index] {
 			get { 
-				if (index > list.Count)
+				if (index >= list.Count)
 					throw new IndexOutOfRangeException ();
 				return list[index]; 
 			}
Index: Mono.Data.Tds/Mono.Data.Tds.Protocol/Tds.cs
===================================================================
--- Mono.Data.Tds/Mono.Data.Tds.Protocol/Tds.cs	(revision 77105)
+++ Mono.Data.Tds/Mono.Data.Tds.Protocol/Tds.cs	(working copy)
@@ -75,7 +75,7 @@
 		ArrayList tableNames;
 		ArrayList columnNames;
 
-		TdsMetaParameterCollection parameters;
+		TdsMetaParameterCollection parameters = new TdsMetaParameterCollection ();
 
 		bool queryInProgress;
 		int cancelsRequested;
@@ -624,15 +624,36 @@
 				element = GetStringValue (false, false);
 				break;
 			case TdsColumnType.BigVarBinary :
-				comm.GetTdsShort ();
+				if (outParam)
+					comm.Skip (1);
 				len = comm.GetTdsShort ();
 				element = comm.GetBytes (len, true);
 				break;
+				/*
+			case TdsColumnType.BigBinary :
+				if (outParam)
+					comm.Skip (2);
+				len = comm.GetTdsShort ();
+				element = comm.GetBytes (len, true);
+				break;
+				*/
+			case TdsColumnType.BigBinary :
+				if (outParam)
+					comm.Skip (2);
+				element = GetBinaryValue ();
+				break;
+			case TdsColumnType.BigChar :
 			case TdsColumnType.BigVarChar :
-				comm.Skip (2);
+				if (outParam)
+					comm.Skip (2);
 				element = GetStringValue (false, false);
 				break;
 			case TdsColumnType.NChar :
+			case TdsColumnType.BigNVarChar :
+				if (outParam)
+					comm.Skip(2);
+				element = GetStringValue (true, false);
+				break;
 			case TdsColumnType.NVarChar :
 				if (outParam) 
 					comm.Skip (1);
@@ -701,10 +722,13 @@
 				break;
 			case TdsColumnType.UniqueIdentifier :
 				if (comm.Peek () != 16) { // If it's null, then what to do?
-					/*byte swallowed =*/ comm.GetByte();	
+					/*byte swallowed =*/ comm.GetByte();
 					element = DBNull.Value;
 					break;
 				}
+				if (outParam)
+					comm.Skip (1);
+				
 				len = comm.GetByte () & 0xff;
 				if (len > 0) {
 					byte[] guidBytes = comm.GetBytes (len, true);
@@ -726,7 +750,6 @@
 			default :
 				return DBNull.Value;
 			}
-
 			return element;
 		}
 
@@ -734,16 +757,17 @@
 		{
 			int len;
 			object result = DBNull.Value;
+
 			if (tdsVersion == TdsVersion.tds70) {
 				len = comm.GetTdsShort ();
 				if (len != 0xffff && len > 0)
 					result = comm.GetBytes (len, true);
-			} 
-			else {
+			} else {
 				len = (comm.GetByte () & 0xff);
 				if (len != 0)
 					result = comm.GetBytes (len, true);
 			}
+
 			return result;
 		}
 
@@ -810,13 +834,12 @@
 				return DBNull.Value;
 			
 			bool positive = (comm.GetByte () == 1);
-
 			if (len > 16)
 				throw new OverflowException ();
 
 			for (int i = 0, index = 0; i < len && i < 16; i += 4, index += 1) 
 				bits[index] = comm.GetTdsInt ();
-
+			
 			if (bits [3] != 0) 
 				return new TdsBigDecimal (precision, scale, !positive, bits);
 			else
@@ -935,11 +958,9 @@
 			}
 		}
 
-		[MonoTODO]
 		private object GetMoneyValue (TdsColumnType type)
 		{
 			int len;
-			object result = null;
 
 			switch (type) {
 			case TdsColumnType.SmallMoney :
@@ -1039,24 +1060,11 @@
 				case TdsColumnType.SmallMoney :
 				case TdsColumnType.Real :
 				case TdsColumnType.DateTime4 :
+				  /*
+				case TdsColumnType.Decimal:
+				case TdsColumnType.Numeric:
+				  */
 					return true;
-				case TdsColumnType.IntN :
-				case TdsColumnType.MoneyN :
-				case TdsColumnType.VarChar :
-				case TdsColumnType.NVarChar :
-				case TdsColumnType.DateTimeN :
-				case TdsColumnType.FloatN :
-				case TdsColumnType.Char :
-				case TdsColumnType.NChar :
-				case TdsColumnType.NText :
-				case TdsColumnType.Image :
-				case TdsColumnType.VarBinary :
-				case TdsColumnType.Binary :
-				case TdsColumnType.Decimal :
-				case TdsColumnType.Numeric :
-				case TdsColumnType.BitN :
-				case TdsColumnType.UniqueIdentifier :
-					return false;
 				default :
 					return false;
 			}
@@ -1268,7 +1276,7 @@
 			switch (type) {
 			case TdsEnvPacketSubType.BlockSize :
 				string blockSize;
-				cLen = comm.GetByte () & 0xff;
+				cLen = comm.GetByte ();
 				blockSize = comm.GetString (cLen);
 
 				if (tdsVersion == TdsVersion.tds70) 
@@ -1280,7 +1288,7 @@
 				comm.ResizeOutBuf (packetSize);
 				break;
 			case TdsEnvPacketSubType.CharSet :
-				cLen = comm.GetByte () & 0xff;
+				cLen = comm.GetByte ();
 				if (tdsVersion == TdsVersion.tds70) {
 					SetCharset (comm.GetString (cLen));
 					comm.Skip (len - 2 - cLen * 2);
@@ -1292,7 +1300,7 @@
 
 				break;
 			case TdsEnvPacketSubType.Database :
-				cLen = comm.GetByte () & 0xff;
+				cLen = comm.GetByte ();
 				string newDB = comm.GetString (cLen);
 				cLen = comm.GetByte () & 0xff;
 				comm.GetString (cLen);
@@ -1388,12 +1396,11 @@
 		protected void ProcessOutputParam ()
 		{
 			GetSubPacketLength ();
-			comm.GetString (comm.GetByte () & 0xff);
+			/*string paramName = */comm.GetString (comm.GetByte () & 0xff);
 			comm.Skip (5);
 
 			TdsColumnType colType = (TdsColumnType) comm.GetByte ();
 			object value = GetColumnValue (colType, true);
-
 			outputParameters.Add (value);
 		}
 
@@ -1440,7 +1447,7 @@
 				ProcessAuthentication ();
 				break;
 			case TdsPacketSubType.ReturnStatus :
-				Comm.Skip (4);
+				ProcessReturnStatus ();
 				break;
 			case TdsPacketSubType.ProcId:
 				Comm.Skip (8);
@@ -1526,6 +1533,11 @@
 			this.language = language;
 		}
 
+		protected virtual void ProcessReturnStatus () 
+		{
+			comm.Skip(4);
+		}
+
 		#endregion // Private Methods
 
 #if NET_2_0
Index: Mono.Data.Tds/Mono.Data.Tds.Protocol/TdsComm.cs
===================================================================
--- Mono.Data.Tds/Mono.Data.Tds.Protocol/TdsComm.cs	(revision 77105)
+++ Mono.Data.Tds/Mono.Data.Tds.Protocol/TdsComm.cs	(working copy)
@@ -148,29 +148,50 @@
 		}
 		public void Append (object o)
 		{
-			switch (o.GetType ().ToString ()) {
-			case "System.Byte":
+			if (o == null || o == DBNull.Value) {
+				Append ((byte)0);
+				return ;
+			}
+			switch (Type.GetTypeCode (o.GetType ())) {
+			case TypeCode.Byte :
 				Append ((byte) o);
 				return;
-			case "System.Byte[]":
-				Append ((byte[]) o);
+			case TypeCode.Boolean:
+				if ((bool)o == true)
+					Append ((byte)1);
+				else
+					Append ((byte)0);
 				return;
-			case "System.Int16":
+			case TypeCode.Object :
+				if (o is byte[])
+					Append ((byte[]) o);
+				return;
+			case TypeCode.Int16 :
 				Append ((short) o);
 				return;
-			case "System.Int32":
+			case TypeCode.Int32 :
 				Append ((int) o);
 				return;
-			case "System.String":
+			case TypeCode.String :
 				Append ((string) o);
 				return;
-			case "System.Double":
+			case TypeCode.Double :
 				Append ((double) o);
 				return;
-			case "System.Int64":
+			case TypeCode.Single :
+				Append ((float) o);
+				return;
+			case TypeCode.Int64 :
 				Append ((long) o);
 				return;
+			case TypeCode.Decimal:
+				Append ((decimal) o, 17);
+				return;
+			case TypeCode.DateTime:
+				Append ((DateTime) o, 8);
+				return;
 			}
+			throw new InvalidOperationException (String.Format ("Object Type :{0} , not being appended", o.GetType ()));
 		}
 
 		public void Append (byte b)
@@ -182,7 +203,29 @@
 			Store (nextOutBufferIndex, b);
 			nextOutBufferIndex++;
 		}	
-		
+
+		public void Append (DateTime t, int bytes)
+		{
+			DateTime epoch = new DateTime (1900,1,1);
+			
+			TimeSpan span = t - epoch;
+			int days = span.Days ;
+			int val = 0;	
+
+			if (bytes == 8) {
+				long ms = (span.Hours * 3600 + span.Minutes * 60 + span.Seconds)*1000L + (long)span.Milliseconds;
+				val = (int) ((ms*300)/1000);
+				Append ((int) days);
+				Append ((int) val);
+			} else if (bytes ==4) {
+				val = span.Hours * 60 + span.Minutes;
+				Append ((ushort) days);
+				Append ((short) val);
+			} else {
+				throw new Exception ("Invalid No of bytes");
+			}
+		}
+
 		public void Append (byte[] b)
 		{
 			Append (b, b.Length, (byte) 0);
@@ -206,6 +249,14 @@
 				Append (BitConverter.GetBytes (s));
 		}
 
+		public void Append (ushort s)
+		{
+			if(!BitConverter.IsLittleEndian)
+				Append (Swap (BitConverter.GetBytes(s)));
+			else 
+				Append (BitConverter.GetBytes (s));
+		}
+
 		public void Append (int i)
 		{
 			if(!BitConverter.IsLittleEndian)
@@ -239,28 +290,39 @@
 
 		public void Append (double value)
 		{
-			Append (BitConverter.DoubleToInt64Bits (value));
+			if (!BitConverter.IsLittleEndian)
+				Append (Swap (BitConverter.GetBytes (value)));
+			else
+				Append (BitConverter.GetBytes (value));
 		}
 
+		public void Append (float value)
+		{
+			if (!BitConverter.IsLittleEndian)
+				Append (Swap (BitConverter.GetBytes (value)));
+			else
+				Append (BitConverter.GetBytes (value));
+		}
+
 		public void Append (long l)
 		{
-			if (tdsVersion < TdsVersion.tds70) {
-				Append ((byte) (((byte) (l >> 56)) & 0xff));
-				Append ((byte) (((byte) (l >> 48)) & 0xff));
-				Append ((byte) (((byte) (l >> 40)) & 0xff));
-				Append ((byte) (((byte) (l >> 32)) & 0xff));
-				Append ((byte) (((byte) (l >> 24)) & 0xff));
-				Append ((byte) (((byte) (l >> 16)) & 0xff));
-				Append ((byte) (((byte) (l >> 8)) & 0xff));
-				Append ((byte) (((byte) (l >> 0)) & 0xff));
-			}
-			else 
-				if (!BitConverter.IsLittleEndian)
-					Append (Swap (BitConverter.GetBytes (l)));
-				else
-					Append (BitConverter.GetBytes (l));
+			if (!BitConverter.IsLittleEndian)
+				Append (Swap (BitConverter.GetBytes (l)));
+			else
+				Append (BitConverter.GetBytes (l));
 		}
 
+		public void Append (decimal d, int bytes)
+		{
+			int[] arr = Decimal.GetBits (d);
+			byte sign =  (d > 0 ? (byte)1 : (byte)0);
+			Append (sign) ;
+			Append (arr[0]);
+			Append (arr[1]);
+			Append (arr[2]);
+			Append ((int)0);
+		}
+
 		public void Close ()
 		{
 			stream.Close ();
Index: Mono.Data.Tds/Mono.Data.Tds.Protocol/TdsColumnType.cs
===================================================================
--- Mono.Data.Tds/Mono.Data.Tds.Protocol/TdsColumnType.cs	(revision 77105)
+++ Mono.Data.Tds/Mono.Data.Tds.Protocol/TdsColumnType.cs	(working copy)
@@ -61,7 +61,9 @@
 		BigBinary = 0xad,
 		BigVarBinary = 0xa5,
 		BigVarChar = 0xa7,
+		BigNVarChar = 0xe7,
 		BigChar = 0xaf,
-		SmallMoney = 0x7a
+		SmallMoney = 0x7a,
+		Variant = 0x62
 	}
 }
Index: System.Data/Test/ProviderTests/Common/DBHelper.cs
===================================================================
--- System.Data/Test/ProviderTests/Common/DBHelper.cs	(revision 77105)
+++ System.Data/Test/ProviderTests/Common/DBHelper.cs	(working copy)
@@ -51,7 +51,7 @@
 			int result = -1;
 			try {
 				result = command.ExecuteNonQuery ();
-			} catch (Exception e) {
+			} catch {
 				return -2;
 			}
 			return result;
@@ -65,7 +65,7 @@
 			int result = -1;
 			try {
 				result = command.ExecuteNonQuery ();
-			} catch (Exception e) {
+			} catch {
 				return -2;
 			}
 			return result;
Index: System.Data/Test/ProviderTests/System.Data.SqlClient/SqlDataReaderTest.cs
===================================================================
--- System.Data/Test/ProviderTests/System.Data.SqlClient/SqlDataReaderTest.cs	(revision 77105)
+++ System.Data/Test/ProviderTests/System.Data.SqlClient/SqlDataReaderTest.cs	(working copy)
@@ -977,9 +977,10 @@
 			reader = cmd.ExecuteReader ();
 
 			while (reader.Read ()){
-				for (int j=1; j< noOfColumns ; ++j)
+				for (int j=1; j< noOfColumns ; ++j) {
 					Assert.AreEqual (table.Rows[i][j], reader[j],
 						String.Format (fmt, table.TableName, i+1, j));
+				}
 				
 				i++;
 			}
Index: System.Data/Test/ProviderTests/System.Data.SqlClient/SqlCommandTest.cs
===================================================================
--- System.Data/Test/ProviderTests/System.Data.SqlClient/SqlCommandTest.cs	(revision 77105)
+++ System.Data/Test/ProviderTests/System.Data.SqlClient/SqlCommandTest.cs	(working copy)
@@ -410,12 +410,13 @@
 	
 			// Test Connection  cannot be modified when reader is in use
 			// NOTE : msdotnet contradicts documented behavior 	
+			/*
 			cmd.CommandText = "select * from numeric_family where id=1";
 			reader = cmd.ExecuteReader ();
 			reader.Read ();
 			conn.Close (); // valid operation 
 			conn = new SqlConnection (connectionString);
-
+			*/
 			/*
 			// NOTE msdotnet contradcits documented behavior 
 			// If the above testcase fails, then this shud be tested 	
@@ -910,7 +911,318 @@
 			Assert.AreEqual(2, cmd.Parameters.Count);
 		}
 
+		[Test]
+		public void StoredProc_NoParameterTest ()
+		{
+			string query = "create procedure #tmp_sp_proc as begin";
+			query += " select 'data' end";
+			SqlConnection conn = new SqlConnection (connectionString);
+			SqlCommand cmd = conn.CreateCommand ();
+			cmd.CommandText = query ;
+			conn.Open ();
+			cmd.ExecuteNonQuery ();
+	
+			cmd.CommandType = CommandType.StoredProcedure;
+			cmd.CommandText = "#tmp_sp_proc";
+			using (SqlDataReader reader = cmd.ExecuteReader()) {
+				if (reader.Read ())
+					Assert.AreEqual ("data", reader.GetString(0),"#1");
+				else
+					Assert.Fail ("#2 Select shud return data");
+			}
+			conn.Close ();
+		}
+	
+		[Test]
+		public void StoredProc_ParameterTest ()
+		{
+			string create_query  = CREATE_TMP_SP_PARAM_TEST;
+			string drop_query = DROP_TMP_SP_PARAM_TEST;
 
+			SqlConnection conn = new SqlConnection (connectionString);
+			
+			conn.Open ();
+			SqlCommand cmd = conn.CreateCommand ();
+			int label = 0 ;
+			string error = "";
+			while (label != -1) {
+				try {
+					switch (label) {
+						case 0 :
+							// Test BigInt Param	
+							DBHelper.ExecuteNonQuery (conn,
+									String.Format(create_query, "bigint"));
+							rpc_helper_function (cmd, SqlDbType.BigInt, 0, Int64.MaxValue);
+							rpc_helper_function (cmd, SqlDbType.BigInt, 0, Int64.MinValue);
+							break;
+						case 1 :
+							// Test Binary Param 
+							DBHelper.ExecuteNonQuery (conn,
+									String.Format(create_query, "binary(5)"));
+							//rpc_helper_function (cmd, SqlDbType.Binary, 0, new byte[] {});
+							rpc_helper_function (cmd, SqlDbType.Binary, 5, new byte[] {1,2,3,4,5});
+							break;
+						case 2 :
+							// Test Bit Param
+							DBHelper.ExecuteNonQuery (conn,
+									String.Format(create_query, "bit"));
+							rpc_helper_function (cmd, SqlDbType.Bit, 0, true);
+							rpc_helper_function (cmd, SqlDbType.Bit, 0, false);
+							break;
+						case 3 :
+							// Testing Char 
+							DBHelper.ExecuteNonQuery (conn,
+									String.Format(create_query, "char(10)"));
+							rpc_helper_function (cmd, SqlDbType.Char, 10, "characters");
+							/*
+							rpc_helper_function (cmd, SqlDbType.Char, 10, "");
+							rpc_helper_function (cmd, SqlDbType.Char, 10, null);
+							*/
+							break;
+						case 4 :
+							// Testing DateTime
+							DBHelper.ExecuteNonQuery (conn,
+									String.Format(create_query, "datetime"));
+							rpc_helper_function (cmd, SqlDbType.DateTime, 0, "2079-06-06 23:59:00");
+							/*
+							rpc_helper_function (cmd, SqlDbType.DateTime, 10, "");
+							rpc_helper_function (cmd, SqlDbType.DateTime, 10, null);
+							*/
+							break;
+						case 5 :
+							// Test Decimal Param
+							DBHelper.ExecuteNonQuery (conn, 
+									String.Format(create_query,"decimal(10,2)"));
+							/*
+							rpc_helper_function (cmd, SqlDbType.Decimal, 0, 10.01);
+							rpc_helper_function (cmd, SqlDbType.Decimal, 0, -10.01);
+							*/
+							break;
+						case 6 :
+							// Test Float Param
+							DBHelper.ExecuteNonQuery (conn, 
+									String.Format(create_query,"float"));
+							rpc_helper_function (cmd, SqlDbType.Float, 0, 10.0);
+							rpc_helper_function (cmd, SqlDbType.Float, 0, 0);
+							/*
+							rpc_helper_function (cmd, SqlDbType.Float, 0, null);
+							*/
+							break;
+						case 7 :
+							// Testing Image
+							/* NOT WORKING
+							   DBHelper.ExecuteNonQuery (conn,
+							   String.Format(create_query, "image"));
+							   rpc_helper_function (cmd, SqlDbType.Image, 0, );
+							   rpc_helper_function (cmd, SqlDbType.Image, 0, );
+							   rpc_helper_function (cmd, SqlDbType.Image, 0, );
+							   /* NOT WORKING*/
+							break;
+						case 8 :
+							// Test Integer Param	
+							DBHelper.ExecuteNonQuery (conn,
+							String.Format(create_query,"int"));
+							rpc_helper_function (cmd, SqlDbType.Int, 0, 10);
+							/*
+							rpc_helper_function (cmd, SqlDbType.Int, 0, null);
+							*/
+							break;
+						case 9 :
+							// Test Money Param	
+							DBHelper.ExecuteNonQuery (conn,
+									String.Format(create_query,"money"));
+							/*
+							rpc_helper_function (cmd, SqlDbType.Money, 0, 10.0);
+							rpc_helper_function (cmd, SqlDbType.Money, 0, null);
+							*/
+							break;
+						case 23 :
+							// Test NChar Param	
+							DBHelper.ExecuteNonQuery (conn,
+									String.Format(create_query,"nchar(10)"));
+							/*
+							rpc_helper_function (cmd, SqlDbType.NChar, 10, "nchar");
+							rpc_helper_function (cmd, SqlDbType.NChar, 10, "");
+							rpc_helper_function (cmd, SqlDbType.NChar, 10, null); 
+							*/
+							break;
+						case 10 :
+							// Test NText Param	
+							DBHelper.ExecuteNonQuery (conn,
+									String.Format(create_query,"ntext"));
+							/*
+							rpc_helper_function (cmd, SqlDbType.NText, 0, "ntext");
+							rpc_helper_function (cmd, SqlDbType.NText, 0, "");
+							rpc_helper_function (cmd, SqlDbType.NText, 0, null); 
+							*/
+							break;
+						case 11 :
+							// Test NVarChar Param	
+							DBHelper.ExecuteNonQuery (conn,
+									String.Format(create_query,"nvarchar(10)"));
+							rpc_helper_function (cmd, SqlDbType.NVarChar, 10, "nvarchar");
+							rpc_helper_function (cmd, SqlDbType.NVarChar, 10, "");
+							//rpc_helper_function (cmd, SqlDbType.NVarChar, 10, null); 
+							break;
+						case 12 :
+							// Test Real Param	
+							DBHelper.ExecuteNonQuery (conn,
+							String.Format(create_query,"real"));
+							rpc_helper_function (cmd, SqlDbType.Real, 0, 10.0);
+							//rpc_helper_function (cmd, SqlDbType.Real, 0, null); 
+							break;
+						case 13 :
+							// Test SmallDateTime Param	
+							DBHelper.ExecuteNonQuery (conn,
+									String.Format(create_query,"smalldatetime"));
+							rpc_helper_function (cmd, SqlDbType.SmallDateTime, 0, "6/6/2079 11:59:00 PM");
+							/*
+							rpc_helper_function (cmd, SqlDbType.SmallDateTime, 0, "");
+							rpc_helper_function (cmd, SqlDbType.SmallDateTime, 0, null);
+							*/
+							break;
+						case 14 :
+							// Test SmallInt Param	
+							DBHelper.ExecuteNonQuery (conn,
+							String.Format(create_query,"smallint"));
+							rpc_helper_function (cmd, SqlDbType.SmallInt, 0, 10);
+							rpc_helper_function (cmd, SqlDbType.SmallInt, 0, -10);
+							//rpc_helper_function (cmd, SqlDbType.SmallInt, 0, null);
+							break;
+						case 15 :
+							// Test SmallMoney Param	
+							DBHelper.ExecuteNonQuery (conn,
+									String.Format(create_query,"smallmoney"));
+							/*
+							rpc_helper_function (cmd, SqlDbType.SmallMoney, 0, 10.0);
+							rpc_helper_function (cmd, SqlDbType.SmallMoney, 0, -10.0);
+							rpc_helper_function (cmd, SqlDbType.SmallMoney, 0, null);
+							*/
+							break;
+						case 16 :
+							// Test Text Param	
+							DBHelper.ExecuteNonQuery (conn,
+									String.Format(create_query,"text"));
+							/*
+							rpc_helper_function (cmd, SqlDbType.Text, 0, "text");
+							rpc_helper_function (cmd, SqlDbType.Text, 0, "");
+							rpc_helper_function (cmd, SqlDbType.Text, 0, null);
+							*/
+							break;
+						case 17 :
+							// Test TimeStamp Param	
+							/* NOT WORKING
+							   DBHelper.ExecuteNonQuery (conn,
+							   String.Format(create_query,"timestamp"));
+							   rpc_helper_function (cmd, SqlDbType.TimeStamp, 0, "");
+							   rpc_helper_function (cmd, SqlDbType.TimeStamp, 0, "");
+							   rpc_helper_function (cmd, SqlDbType.TimeStamp, 0, null); 
+							 */
+							break;
+						case 18 :
+							// Test TinyInt Param	
+							DBHelper.ExecuteNonQuery (conn,
+									String.Format(create_query,"tinyint"));
+							/*
+							rpc_helper_function (cmd, SqlDbType.TinyInt, 0, 10);
+							rpc_helper_function (cmd, SqlDbType.TinyInt, 0, -10);
+							rpc_helper_function (cmd, SqlDbType.TinyInt, 0, null);
+							*/
+							break;
+						case 19 :
+							// Test UniqueIdentifier Param	
+							/*
+							DBHelper.ExecuteNonQuery (conn,
+									String.Format(create_query,"uniqueidentifier"));
+							rpc_helper_function (cmd, SqlDbType.UniqueIdentifier, 0, "0f159bf395b1d04f8c2ef5c02c3add96");
+							rpc_helper_function (cmd, SqlDbType.UniqueIdentifier, 0, null); 
+							*/
+							break;
+						case 20 :
+							// Test VarBinary Param	
+							/* NOT WORKING
+							   DBHelper.ExecuteNonQuery (conn,
+							   String.Format(create_query,"varbinary (10)"));
+							   rpc_helper_function (cmd, SqlDbType.VarBinary, 0,);
+							   rpc_helper_function (cmd, SqlDbType.VarBinary, 0,);
+							   rpc_helper_function (cmd, SqlDbType.VarBinary, 0, null); 
+							 */
+							break;
+						case 21 :
+							// Test Varchar Param
+							DBHelper.ExecuteNonQuery (conn,
+									String.Format(create_query,"varchar(10)"));
+							rpc_helper_function (cmd, SqlDbType.VarChar, 10, "VarChar");
+							break;
+						case 22 :
+							// Test Variant Param	
+							/* NOT WORKING
+							   DBHelper.ExecuteNonQuery (conn,
+							   String.Format(create_query,"variant"));
+							   rpc_helper_function (cmd, SqlDbType.Variant, 0, );
+							   rpc_helper_function (cmd, SqlDbType.Variant, 0, );
+							   rpc_helper_function (cmd, SqlDbType.Variant, 0, null); 
+							 */
+							break; 
+						default :
+							label = -2;
+							break; 
+					}
+				}catch (AssertionException e) {
+					error += String.Format (" Case {0} INCORRECT VALUE : {1}\n",label, e.Message);
+				}catch (Exception e) {
+					error += String.Format (" Case {0} NOT WORKING : {1}\n",label, e.Message);
+				}
+
+				label++;
+				if (label != -1)
+					DBHelper.ExecuteNonQuery (conn, drop_query);
+			}
+			if (error != String.Empty)
+				Assert.Fail (error);
+		}
+
+		private void rpc_helper_function (SqlCommand cmd, SqlDbType type, int size, object val)
+		{
+				cmd.Parameters.Clear ();
+				SqlParameter param1 ;
+				SqlParameter param2 ;
+				if (size != 0) {
+					param1 = new SqlParameter ("@param1", type, size);
+					param2 = new SqlParameter ("@param2", type, size);
+				}
+				else {
+					param1 = new SqlParameter ("@param1", type);
+					param2 = new SqlParameter ("@param2", type);
+				}
+
+				SqlParameter retval = new SqlParameter ("retval", SqlDbType.Int);
+				param1.Value = val;
+				param1.Direction = ParameterDirection.Input;
+				param2.Direction = ParameterDirection.Output;
+				retval.Direction = ParameterDirection.ReturnValue;
+				cmd.Parameters.Add (param1);
+				cmd.Parameters.Add (param2);
+				cmd.Parameters.Add (retval);
+				cmd.CommandText = "#tmp_sp_param_test";
+				cmd.CommandType = CommandType.StoredProcedure;
+				using (SqlDataReader reader = cmd.ExecuteReader ()) {
+					while (reader.Read ()) {
+						if (param1.Value != null && param1.Value.GetType () == typeof (string))
+							Assert.AreEqual (param1.Value,
+									 reader.GetValue(0).ToString (),"#1");
+						else
+							Assert.AreEqual (param1.Value,
+									 reader.GetValue(0),"#1");
+					}
+				}
+				if (param1.Value != null && param1.Value.GetType () == typeof (string) && param2.Value != null)
+					Assert.AreEqual (param1.Value.ToString (), param2.Value.ToString (), "#2");
+				else
+					Assert.AreEqual (param1.Value, param2.Value, "#2");
+				Assert.AreEqual (5, retval.Value, "#3");
+		}
+
 		[Test]
 		[ExpectedException (typeof (InvalidOperationException))]
 		public void OutputParamSizeTest1 ()
@@ -1106,6 +1418,9 @@
 			Error = 3
 		}
 
+		private readonly string CREATE_TMP_SP_PARAM_TEST = "create procedure #tmp_sp_param_test (@param1 {0}, @param2 {0} output) as begin select @param1 set @param2=@param1 return 5 end";
+		private readonly string DROP_TMP_SP_PARAM_TEST = "drop procedure #tmp_sp_param_test";
+
 		private readonly string CREATE_TMP_SP_TEMP_INSERT_PERSON = ("create procedure #sp_temp_insert_employee ( " + Environment.NewLine + 
 									    "@fname varchar (20)) " + Environment.NewLine + 
 									    "as " + Environment.NewLine + 
Index: System.Data/Test/ProviderTests/sql/sqlserver.sql
===================================================================
--- System.Data/Test/ProviderTests/sql/sqlserver.sql	(revision 77105)
+++ System.Data/Test/ProviderTests/sql/sqlserver.sql	(working copy)
@@ -1,10 +1,3 @@
-if exists (select name from sysdatabases where
-        name = 'mono-test') 
-        drop database [mono-test];
-create database [mono-test];
-grant all privileges on [mono-test] to monotester;
-go
-
 use monotest;
 
 -- =================================== OBJECT NUMERIC_FAMILY============================
@@ -61,7 +54,7 @@
 grant all privileges on binary_family to monotester;
 go
 
-insert into binary_family values (1, convert (binary, '555555'), convert (varbinary, '0123456789012345678901234567890123456789012345678901234567890123456789'), 
+insert into binary_family values (1, convert (binary, '5'), convert (varbinary, '0123456789012345678901234567890123456789012345678901234567890123456789'), 
 					convert (image, '66666666'), convert (image, '777777'), 
 					convert (image, '888888'), convert (image, '999999'));
 --insert into binary_family values (2,
@@ -92,7 +85,7 @@
 grant all privileges on string_family to monotester;
 go
 
-insert into string_family values (1,newid(),"char","varchar","text","ntext");
+insert into string_family values (1,newid(),'char','varchar','text','ntext');
 insert into string_family values (4,null,null,null,null,null);
 go
 -- =================================== END OBJECT STRING_FAMILY ========================
@@ -114,7 +107,7 @@
 
 grant all privileges on datetime_family to monotester;
 go
-insert into datetime_family values (1,'2079-06-06 23:59:00','9999-12-31 23:59:59.997');
+insert into datetime_family values (1,'2079-06-06 23:59:00','9999-12-31 23:59:59:00');
 insert into datetime_family values (4,null,null);
 go
 
Index: System.Data/System.Data.SqlClient/SqlDataReader.cs
===================================================================
--- System.Data/System.Data.SqlClient/SqlDataReader.cs	(revision 77105)
+++ System.Data/System.Data.SqlClient/SqlDataReader.cs	(working copy)
@@ -568,7 +568,7 @@
 				DataRow row = schemaTable.NewRow ();
 
 				row ["ColumnName"]		= GetSchemaValue (schema, "ColumnName");
-				row ["ColumnSize"]		= GetSchemaValue (schema, "ColumnSize"); 
+				row ["ColumnSize"]		= GetSchemaValue (schema, "ColumnSize");
 				row ["ColumnOrdinal"]		= GetSchemaValue (schema, "ColumnOrdinal");
 				row ["NumericPrecision"]	= GetSchemaValue (schema, "NumericPrecision");
 				row ["NumericScale"]		= GetSchemaValue (schema, "NumericScale");
Index: System.Data/System.Data.SqlClient/SqlConnection.cs
===================================================================
--- System.Data/System.Data.SqlClient/SqlConnection.cs	(revision 77105)
+++ System.Data/System.Data.SqlClient/SqlConnection.cs	(working copy)
@@ -1370,8 +1370,8 @@
 			if (cName == null)
 				throw new ArgumentException ("The requested collection ('" + collectionName + "') is not defined.");
 
-			SqlCommand command     = null;
-			DataTable dataTable    = new DataTable ();
+			SqlCommand command  = null;
+			DataTable dataTable = new DataTable ();
 			SqlDataAdapter dataAdapter = new SqlDataAdapter ();
 
 			switch (cName)
Index: System.Data/System.Data.SqlClient/SqlParameter.cs
===================================================================
--- System.Data/System.Data.SqlClient/SqlParameter.cs	(revision 77105)
+++ System.Data/System.Data.SqlClient/SqlParameter.cs	(working copy)
@@ -90,9 +90,10 @@
 
 		public SqlParameter (string parameterName, object value) 
 		{
-			metaParameter = new TdsMetaParameter (parameterName, SqlTypeToFrameworkType (value));
+ 			metaParameter = new TdsMetaParameter (parameterName, value);
+ 			InferSqlType (value);
+ 			metaParameter.Value =  SqlTypeToFrameworkType(value);
 			this.sourceVersion = DataRowVersion.Current;
-			InferSqlType (value);
 		}
 		
 		public SqlParameter (string parameterName, SqlDbType dbType) 
@@ -116,8 +117,10 @@
 			metaParameter = new TdsMetaParameter (parameterName, size, 
 							      isNullable, precision, 
 							      scale, 
-							      SqlTypeToFrameworkType (value));
-			SqlDbType = dbType;
+							      value);
+			if (dbType != SqlDbType.Variant) 
+				SqlDbType = dbType;
+			metaParameter.Value = SqlTypeToFrameworkType (value);
 			Direction = direction;
 			SourceColumn = sourceColumn;
 			SourceVersion = sourceVersion;
@@ -460,7 +463,6 @@
 			}
 
 			Type type = value.GetType ();
-
 			string exception = String.Format ("The parameter data type of {0} is invalid.", type.Name);
 
 			switch (type.FullName) {
@@ -690,6 +692,9 @@
 			case "varchar":
 				SqlDbType = SqlDbType.VarChar;
 				break;
+			case "sql_variant":
+				SqlDbType = SqlDbType.Variant;
+				break;
 			default:
 				SqlDbType = SqlDbType.Variant;
 				break;
@@ -822,8 +827,8 @@
 
 		private object SqlTypeToFrameworkType (object value)
 		{
-			if (! (value is INullable)) // if the value is not SqlType
-				return value;
+			if (! (value is INullable))  // if the value is not SqlType
+				return ConvertToFrameworkType (value);
 
 			// Map to .net type, as Mono TDS respects only types from .net
 			switch (value.GetType ().FullName) {
@@ -857,6 +862,56 @@
 			return value;
 		}
 
+		private object ConvertToFrameworkType (object value)
+		{
+			if (value == null || value == DBNull.Value)
+				return value;
+			switch (sqlDbType)  {
+			case SqlDbType.BigInt :
+				return Convert.ChangeType (value, typeof (Int64));
+			case SqlDbType.Binary:
+			case SqlDbType.VarBinary:
+				if (value is byte[])
+					return value;
+				break;
+			case SqlDbType.Bit:
+				return Convert.ChangeType (value, typeof (bool));
+			case SqlDbType.Int:
+				return Convert.ChangeType (value, typeof (Int32));
+			case SqlDbType.SmallInt :
+				return Convert.ChangeType (value, typeof (Int16));
+			case SqlDbType.TinyInt :
+				return Convert.ChangeType (value, typeof (byte));
+			case SqlDbType.Float:
+				return Convert.ChangeType (value, typeof (Double));
+			case SqlDbType.Real:
+				return Convert.ChangeType (value, typeof (Single));
+			case SqlDbType.Decimal:
+				return Convert.ChangeType (value, typeof (Decimal));
+			case SqlDbType.Money:
+			case SqlDbType.SmallMoney:
+				{
+					Decimal val = (Decimal)Convert.ChangeType (value, typeof (Decimal));
+					return Decimal.Round(val, 4);
+				}
+			case SqlDbType.DateTime:
+			case SqlDbType.SmallDateTime:
+				return Convert.ChangeType (value, typeof (DateTime));
+			case SqlDbType.VarChar:
+			case SqlDbType.NVarChar:
+			case SqlDbType.Char:
+			case SqlDbType.NChar:
+			case SqlDbType.Text:
+			case SqlDbType.NText:
+				return Convert.ChangeType (value,  typeof (string));
+			case SqlDbType.UniqueIdentifier:
+				return Convert.ChangeType (value,  typeof (Guid));
+			case SqlDbType.Variant:
+				return metaParameter.Value;
+			}
+			throw new  NotImplementedException ("Type Not Supported : " + sqlDbType.ToString());
+		}
+
 #if NET_2_0
 		
                 public override void ResetDbType ()
