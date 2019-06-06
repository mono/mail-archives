Index: System.Data.Common/DbEnumerator.cs
===================================================================
--- System.Data.Common/DbEnumerator.cs	(revision 118952)
+++ System.Data.Common/DbEnumerator.cs	(working copy)
@@ -69,7 +69,7 @@
 		public object Current {
 			get { 
 				reader.GetValues (values);
-				return new DbDataRecord (schema, values); 
+				return new DbDataRecordImpl (schema, values); 
 			}
 		}
 
Index: System.Data.Common/DbDataRecord.cs
===================================================================
--- System.Data.Common/DbDataRecord.cs	(revision 118952)
+++ System.Data.Common/DbDataRecord.cs	(working copy)
@@ -37,8 +37,139 @@
 
 namespace System.Data.Common
 {
-	public class DbDataRecord : IDataRecord, ICustomTypeDescriptor
+	public abstract class DbDataRecord : IDataRecord, ICustomTypeDescriptor
 	{
+		protected DbDataRecord ()
+		{
+		}
+
+		public abstract int FieldCount { get; }
+		public abstract object this [string name] { get; }
+		public abstract object this [int i] { get; }
+
+		public abstract bool GetBoolean (int i);
+		public abstract byte GetByte (int i);
+		public abstract long GetBytes (int i, long dataIndex, byte [] buffer, int bufferIndex,int length);
+		public abstract char GetChar (int i);
+		public abstract long GetChars (int i, long dataIndex, char [] buffer, int bufferIndex, int length);
+		public abstract string GetDataTypeName (int i);
+#if NET_2_0
+		protected abstract DbDataReader GetDbDataReader (int i);
+#endif
+		public abstract DateTime GetDateTime (int i);
+		public abstract decimal GetDecimal (int i);
+		public abstract double GetDouble (int i);
+		public abstract Type GetFieldType (int i);
+		public abstract float GetFloat (int i);
+		public abstract Guid GetGuid (int i);
+		public abstract short GetInt16 (int i);
+		public abstract int GetInt32 (int i);
+		public abstract long GetInt64 (int i);
+		public abstract string GetName (int i);
+		public abstract int GetOrdinal (string name);
+		public abstract string GetString (int i);
+		public abstract object GetValue (int i);
+		public abstract int GetValues (object [] values);
+		public abstract bool IsDBNull (int i);
+
+		public IDataReader GetData (int i)
+		{
+			return (IDataReader) GetValue (i);
+		}
+
+		[MonoTODO]
+		AttributeCollection ICustomTypeDescriptor.GetAttributes ()
+		{
+			return new AttributeCollection (null);
+		}
+
+		[MonoTODO]
+		string ICustomTypeDescriptor.GetClassName ()
+		{
+			return string.Empty;
+		}
+
+		[MonoTODO]
+		string ICustomTypeDescriptor.GetComponentName ()
+		{
+			return null;
+		}
+
+		[MonoTODO]
+		TypeConverter ICustomTypeDescriptor.GetConverter ()
+		{
+			return null;
+		}
+
+		[MonoTODO]
+		EventDescriptor ICustomTypeDescriptor.GetDefaultEvent ()
+		{
+			return null;
+		}
+
+		[MonoTODO]
+		PropertyDescriptor ICustomTypeDescriptor.GetDefaultProperty ()
+		{
+			return null;
+		}
+
+		[MonoTODO]
+		object ICustomTypeDescriptor.GetEditor (Type editorBaseType)
+		{
+			return null;
+		}
+
+		[MonoTODO]
+		EventDescriptorCollection ICustomTypeDescriptor.GetEvents ()
+		{
+			return new EventDescriptorCollection (null);
+		}
+
+		[MonoTODO]
+		EventDescriptorCollection ICustomTypeDescriptor.GetEvents (Attribute [] attributes)
+		{
+			return new EventDescriptorCollection (null);
+		}
+
+		[MonoTODO]
+		PropertyDescriptorCollection ICustomTypeDescriptor.GetProperties ()
+		{
+			DataColumnPropertyDescriptor[] descriptors = 
+				new DataColumnPropertyDescriptor [FieldCount];
+
+			DataColumnPropertyDescriptor descriptor;
+			for (int col = 0; col < FieldCount; col++) {
+				descriptor = new DataColumnPropertyDescriptor(
+					GetName (col), col, null);
+				descriptor.SetComponentType (typeof (DbDataRecord));
+				descriptor.SetPropertyType (GetFieldType (col));
+				descriptors [col] = descriptor;
+			}
+
+			return new PropertyDescriptorCollection (descriptors);
+		}
+
+		[MonoTODO]
+		PropertyDescriptorCollection ICustomTypeDescriptor.GetProperties (Attribute [] attributes)
+		{
+			PropertyDescriptorCollection descriptors;
+			descriptors = ((ICustomTypeDescriptor) this).GetProperties ();
+			// TODO: filter out descriptors which do not contain
+			//       any of those attributes
+			//       except, those descriptors 
+			//       that contain DefaultMemeberAttribute
+			return descriptors;
+		}
+
+		[MonoTODO]
+		object ICustomTypeDescriptor.GetPropertyOwner (PropertyDescriptor pd)
+		{
+			return this;
+		}
+	}
+
+	class DbDataRecordImpl : DbDataRecord
+	{
 		#region Fields
 
 		readonly SchemaInfo [] schema;
@@ -49,7 +180,10 @@
 		
 		#region Constructors
 
-		internal DbDataRecord (SchemaInfo[] schema, object[] values)
+		// FIXME: this class should actually be reimplemented to be one
+		// of the derived classes of DbDataRecord, which should become
+		// almost abstract.
+		internal DbDataRecordImpl (SchemaInfo[] schema, object[] values)
 		{
 			this.schema = schema;
 			this.values = values;
@@ -60,16 +194,15 @@
 
 		#region Properties
 
-		public int FieldCount {
+		public override int FieldCount {
 			get { return fieldCount; }
 		}
 
-		public object this [string name] {
+		public override object this [string name] {
 			get { return this [GetOrdinal (name)]; }
 		}
 
-		[IndexerName ("Item")]
-		public object this [int i] {
+		public override object this [int i] {
 			get { return GetValue (i); }
 		}
 
@@ -77,17 +210,17 @@
 
 		#region Methods
 
-		public bool GetBoolean (int i)
+		public override bool GetBoolean (int i)
 		{
 			return (bool) GetValue (i);
 		}
 
-		public byte GetByte (int i)
+		public override byte GetByte (int i)
 		{
 			return (byte) GetValue (i);
 		}
 
-		public long GetBytes (int i, long dataIndex, byte[] buffer, int bufferIndex, int length)
+		public override long GetBytes (int i, long dataIndex, byte[] buffer, int bufferIndex, int length)
 		{
 			object value = GetValue (i);
 			if (!(value is byte []))
@@ -103,12 +236,12 @@
 			}
 		}
 
-		public char GetChar (int i)
+		public override char GetChar (int i)
 		{
 			return (char) GetValue (i);
 		}
 
-		public long GetChars (int i, long dataIndex, char[] buffer, int bufferIndex, int length)
+		public override long GetChars (int i, long dataIndex, char[] buffer, int bufferIndex, int length)
 		{
 			object value = GetValue (i);
 			char [] valueBuffer;
@@ -130,67 +263,70 @@
 			}
 		}
 
-		public IDataReader GetData (int i)
+		public override string GetDataTypeName (int i)
 		{
-			return (IDataReader) GetValue (i);
+			return schema[i].DataTypeName;
 		}
 
-		public string GetDataTypeName (int i)
+		public override DateTime GetDateTime (int i)
 		{
-			return schema[i].DataTypeName;
+			return (DateTime) GetValue (i);
 		}
 
-		public DateTime GetDateTime (int i)
+#if NET_2_0
+		[MonoTODO]
+		protected override DbDataReader GetDbDataReader (int ordinal)
 		{
-			return (DateTime) GetValue (i);
+			throw new NotImplementedException ();
 		}
+#endif
 
-		public decimal GetDecimal (int i)
+		public override decimal GetDecimal (int i)
 		{
 			return (decimal) GetValue (i);
 		}
 
-		public double GetDouble (int i)
+		public override double GetDouble (int i)
 		{
 			return (double) GetValue (i);
 		}
 
-		public Type GetFieldType (int i)
+		public override Type GetFieldType (int i)
 		{
 			return schema[i].FieldType;
 		}
 
-		public float GetFloat (int i)
+		public override float GetFloat (int i)
 		{
 			return (float) GetValue (i);
 		}
 		
-		public Guid GetGuid (int i)
+		public override Guid GetGuid (int i)
 		{
 			return (Guid) GetValue (i);
 		}
 		
-		public short GetInt16 (int i)
+		public override short GetInt16 (int i)
 		{
 			return (short) GetValue (i);
 		}
 	
-		public int GetInt32 (int i)
+		public override int GetInt32 (int i)
 		{
 			return (int) GetValue (i);
 		}
 
-		public long GetInt64 (int i)
+		public override long GetInt64 (int i)
 		{
 			return (long) GetValue (i);
 		}
 
-		public string GetName (int i)
+		public override string GetName (int i)
 		{
 			return schema [i].ColumnName;
 		}
 
-		public int GetOrdinal (string name)
+		public override int GetOrdinal (string name)
 		{
 			for (int i = 0; i < FieldCount; i++)
 				if (schema [i].ColumnName == name)
@@ -198,19 +334,19 @@
 			return -1;
 		}
 
-		public string GetString (int i)
+		public override string GetString (int i)
 		{
 			return (string) GetValue (i);
 		}
 
-		public object GetValue (int i)
+		public override object GetValue (int i)
 		{
 			if (i < 0 || i > fieldCount)
 				throw new IndexOutOfRangeException ();
 			return values [i];
 		}
 
-		public int GetValues (object[] values)
+		public override int GetValues (object[] values)
 		{
 			if (values == null)
 				throw new ArgumentNullException("values");
@@ -221,98 +357,8 @@
 			return count;
 		}
 
-		[MonoTODO]
-		AttributeCollection ICustomTypeDescriptor.GetAttributes ()
+		public override bool IsDBNull (int i)
 		{
-			return new AttributeCollection (null);
-		}
-
-		[MonoTODO]
-		string ICustomTypeDescriptor.GetClassName ()
-		{
-			return string.Empty;
-		}
-
-		[MonoTODO]
-		string ICustomTypeDescriptor.GetComponentName ()
-		{
-			return null;
-		}
-
-		[MonoTODO]
-		TypeConverter ICustomTypeDescriptor.GetConverter ()
-		{
-			return null;
-		}
-
-		[MonoTODO]
-		EventDescriptor ICustomTypeDescriptor.GetDefaultEvent ()
-		{
-			return null;
-		}
-
-		[MonoTODO]
-		PropertyDescriptor ICustomTypeDescriptor.GetDefaultProperty ()
-		{
-			return null;
-		}
-
-		[MonoTODO]
-		object ICustomTypeDescriptor.GetEditor (Type editorBaseType)
-		{
-			return null;
-		}
-
-		[MonoTODO]
-		EventDescriptorCollection ICustomTypeDescriptor.GetEvents ()
-		{
-			return new EventDescriptorCollection (null);
-		}
-
-		[MonoTODO]
-		EventDescriptorCollection ICustomTypeDescriptor.GetEvents (Attribute [] attributes)
-		{
-			return new EventDescriptorCollection (null);
-		}
-
-		[MonoTODO]
-		PropertyDescriptorCollection ICustomTypeDescriptor.GetProperties ()
-		{
-			DataColumnPropertyDescriptor[] descriptors = 
-				new DataColumnPropertyDescriptor [FieldCount];
-
-			DataColumnPropertyDescriptor descriptor;
-			for (int col = 0; col < FieldCount; col++) {
-				descriptor = new DataColumnPropertyDescriptor(
-					GetName (col), col, null);
-				descriptor.SetComponentType (typeof (DbDataRecord));
-				descriptor.SetPropertyType (GetFieldType (col));
-				descriptors [col] = descriptor;
-			}
-
-			return new PropertyDescriptorCollection (descriptors);
-		}
-
-		[MonoTODO]
-		PropertyDescriptorCollection ICustomTypeDescriptor.GetProperties (Attribute [] attributes)
-		{
-			PropertyDescriptorCollection descriptors;
-			descriptors = ((ICustomTypeDescriptor) this).GetProperties ();
-			// TODO: filter out descriptors which do not contain
-			//       any of those attributes
-			//       except, those descriptors 
-			//       that contain DefaultMemeberAttribute
-			return descriptors;
-		}
-
-		[MonoTODO]
-		object ICustomTypeDescriptor.GetPropertyOwner (PropertyDescriptor pd)
-		{
-			return this;
-		}
-
-		public bool IsDBNull (int i)
-		{
 			return GetValue (i) == DBNull.Value;
 		}
 