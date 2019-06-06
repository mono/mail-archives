Index: DbDataReaderBase.cs
===================================================================
--- DbDataReaderBase.cs	(revision 44908)
+++ DbDataReaderBase.cs	(working copy)
@@ -3,6 +3,7 @@
 //
 // Author:
 //   Tim Coleman (tim@timcoleman.com)
+//	 Boris Kirzner (borisk@mainsoft.com)
 //
 // Copyright (C) Tim Coleman, 2003
 //
@@ -30,7 +31,7 @@
 // WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 //
 
-#if NET_2_0
+#if NET_2_0 || TARGET_JVM
 
 using System.Collections;
 using System.Data.Common;
@@ -60,9 +61,9 @@
 			get { return behavior; }
 		}
 
-		[MonoTODO]
 		public override int Depth {
-			get { throw new NotImplementedException (); }
+			// default value to be overriden by user
+			get { return 0; }
 		}
 
 		[MonoTODO]
@@ -80,7 +81,9 @@
 			get { throw new NotImplementedException (); }
 		}
 
+#if NET_2_0
 		protected abstract bool IsValidRow { get; }
+#endif
 
 		[MonoTODO]
 		public override object this [[Optional] int index] {
@@ -131,10 +134,9 @@
 			throw new NotImplementedException ();
 		}
 
-		[MonoTODO]
 		public override void Dispose ()
 		{
-			throw new NotImplementedException ();
+			Close();
 		}
 
 		[MonoTODO]
@@ -197,10 +199,10 @@
 			throw new NotImplementedException ();
 		}
 
-		[MonoTODO]
 		public override IEnumerator GetEnumerator ()
 		{
-			throw new NotImplementedException ();
+			bool closeReader = (CommandBehavior & CommandBehavior.CloseConnection) != 0;
+			return new DbEnumerator (this , closeReader);
 		}
 
 		[MonoTODO]
Index: DbParameterCollectionBase.cs
===================================================================
--- DbParameterCollectionBase.cs	(revision 44908)
+++ DbParameterCollectionBase.cs	(working copy)
@@ -3,6 +3,7 @@
 //
 // Author:
 //   Tim Coleman (tim@timcoleman.com)
+//	 Boris Kirzner (borisk@mainsoft.com)
 //
 // Copyright (C) Tim Coleman, 2003
 //
@@ -30,7 +31,7 @@
 // WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 //
 
-#if NET_2_0
+#if NET_2_0 || TARGET_JVM
 
 using System.Collections;
 using System.Data.Common;
@@ -40,16 +41,15 @@
 	{
 		#region Fields
 
-		ArrayList list;
+		private ArrayList _list;
 
 		#endregion // Fields
 
 		#region Constructors
 	
-		[MonoTODO]
 		protected DbParameterBaseCollection ()
 		{
-			list = new ArrayList ();
+			_list = new ArrayList();
 		}
 
 		#endregion // Constructors
@@ -57,42 +57,46 @@
 		#region Properties
 
 		public override int Count {
-			get { return list.Count; }
+			get { return _list.Count; }
 		}
 
 		public override bool IsFixedSize {
-			get { return list.IsFixedSize; }
+			get { return _list.IsFixedSize; }
 		}
 
 		public override bool IsReadOnly {
-			get { return list.IsReadOnly; }
+			get { return _list.IsReadOnly; }
 		}
 
 		public override bool IsSynchronized {
-			get { return list.IsSynchronized; }
+			get { return _list.IsSynchronized; }
 		}
 
 		protected abstract Type ItemType { get; }
 
+#if NET_2_0
 		[MonoTODO]
 		protected virtual string ParameterNamePrefix {
 			get { throw new NotImplementedException (); }
 		}
+#endif
 
 		public override object SyncRoot {
-			get { return list.SyncRoot; }
+			get { return _list.SyncRoot; }
 		}
 
 		#endregion // Properties
 
 		#region Methods
 
-		public override int Add (object value)
-		{
-			ValidateType (value);
-                        return list.Add (value);
-		}
+		public override int Add (object value)
+        {
+            Validate(-1, value);
+            ((DbParameterBase)value).Parent = this;
+            return _list.Add(value);
+        }
 
+#if NET_2_0
 		public override void AddRange (Array values)
 		{
 			foreach (object value in values)
@@ -104,106 +108,180 @@
 		{
 			throw new NotImplementedException ();
 		}
+#endif
 
-		public override void Clear ()
-		{
-			list.Clear ();
-		}
+		public override void Clear ()
+        {
+            if (_list != null && Count != 0) {
+				for (int i = 0; i < _list.Count; i++) {
+					((DbParameterBase)_list[i]).Parent = null;
+				}
+				_list.Clear();
+            }
+        }
 
-		public override bool Contains (object value)
-		{
-			return list.Contains (value);
-		}
+		public override bool Contains (object value)
+        {
+            if (IndexOf(value) != -1)
+                return true;
+            else
+                return false;
+        }
 
-		[MonoTODO]
-		public override bool Contains (string value)
-		{
-			throw new NotImplementedException ();
-		}
+		public override bool Contains (string value)
+        {
+            if (IndexOf(value) != -1)
+                return true;
+            else
+                return false;
+        }
 
 		public override void CopyTo (Array array, int index)
 		{
-			list.CopyTo (array, index);
+			_list.CopyTo(array, index);
 		}
 
 		public override IEnumerator GetEnumerator ()
 		{
-			return list.GetEnumerator ();
+			return _list.GetEnumerator();
 		}
 
 		protected override DbParameter GetParameter (int index)
 		{
-			return (DbParameter) list [index];
+			return (DbParameter) _list[index];
 		}
 
-		public override int IndexOf (object value)
-		{
-			return list.IndexOf (value);
-		}
 
-		[MonoTODO]
-		public override int IndexOf (string parameterName)
-		{
-			throw new NotImplementedException ();
-		}
+		public override int IndexOf (object value)
+        {
+            ValidateType(value);
+            return _list.IndexOf(value);
+        }
 
+		public override int IndexOf (string parameterName)
+        {
+            if (_list == null)
+                return -1;
+
+            for (int i = 0; i < _list.Count; i++) {
+                string name = ((DbParameterBase)_list[i]).ParameterName;
+                if (name == parameterName) {
+                    return i;
+                }
+            }
+            return -1;
+        }
+
+#if NET_2_0
 		[MonoTODO]
 		protected internal static int IndexOf (IEnumerable items, string parameterName)
 		{
 			throw new NotImplementedException ();
 		}
+#endif
 
-		public override void Insert (int index, object value)
-		{
-			list.Insert (index, value);
-		}
+		public override void Insert (int index, object value)
+        {
+            Validate(-1, (DbParameterBase)value);
+            ((DbParameterBase)value).Parent = this;
+            _list.Insert(index, value);
+        }
 
+#if NET_2_0
 		[MonoTODO]
 		protected virtual void OnChange ()
 		{
 			throw new NotImplementedException ();
 		}
+#endif
 
-		public override void Remove (object value)
-		{
-			list.Remove (value);
-		}
+		public override void Remove (object value)
+        {
+            ValidateType(value);
+			int index = IndexOf(value);
+            RemoveIndex(index);
+        }
 
-		public override void RemoveAt (int index)
-		{
-			list.RemoveAt (index);
-		}
+		public override void RemoveAt (int index)
+        {
+            RemoveIndex(index);
+        }
 
-		[MonoTODO]
-		public override void RemoveAt (string parameterName)
-		{
-			throw new NotImplementedException ();
-		}
+		public override void RemoveAt (string parameterName)
+        {
+            int index = IndexOf(parameterName);
+            RemoveIndex(index);
+        }
 
 		protected override void SetParameter (int index, DbParameter value)
 		{
-			list [index] = value;
+			Replace(index, value);
 		}
 
-		[MonoTODO]
-		protected virtual void Validate (int index, object value)
-		{
-			throw new NotImplementedException ();
-		}
+		protected virtual void Validate (int index, object value)
+        {           
+			ValidateType(value);
+			DbParameterBase parameter = (DbParameterBase) value;
+
+            if (parameter.Parent != null) {
+                if (parameter.Parent.Equals(this)) {
+                    if (IndexOf(parameter) != index) {
+                        throw ExceptionHelper.CollectionAlreadyContains(ItemType,"ParameterName",parameter.ParameterName,this);
+                    }
+                }
+                else {
+					// FIXME :  The OleDbParameter with ParameterName 'MyParam2' is already contained by another OleDbParameterCollection.
+                    throw new ArgumentException("");
+                }
+            }
+
+            if (parameter.ParameterName == null  || parameter.ParameterName == String.Empty) {
+				int newIndex = 1;
+				string parameterName;
+				
+				do {
+					parameterName = "Parameter" + newIndex;
+					newIndex++;
+				}
+				while(IndexOf(parameterName) != -1);
+
+                parameter.ParameterName = parameterName;
+            }
+        }		
 
 		protected virtual void ValidateType (object value)
 		{
+			if (value == null) {
+                throw ExceptionHelper.CollectionNoNullsAllowed(this,ItemType);
+            }
+
 			Type objectType = value.GetType ();
 			Type itemType = ItemType;
 
-			if (objectType != itemType)
-			{
+			if (itemType.IsInstanceOfType(objectType)) {
 				Type thisType = this.GetType ();
 				string err = String.Format ("The {0} only accepts non-null {1} type objects, not {2} objects.", thisType.Name, itemType.Name, objectType.Name);
 				throw new InvalidCastException (err);
 			}
 		}
 
+		private void RemoveIndex (int index)
+        {
+			DbParameterBase oldItem = (DbParameterBase)_list[index];
+            oldItem.Parent = null;
+            _list.RemoveAt(index);
+        }		
+
+		private void Replace (int index, DbParameter value)
+        {
+            Validate(index, value);
+            DbParameterBase oldItem = (DbParameterBase)this[index];
+            oldItem.Parent = null;
+
+            ((DbParameterBase)value).Parent = this;
+            _list[index] = value;
+        }
+
 		#endregion // Methods
 	}
 }
Index: DbCommandBase.cs
===================================================================
--- DbCommandBase.cs	(revision 44908)
+++ DbCommandBase.cs	(working copy)
@@ -3,6 +3,7 @@
 //
 // Author:
 //   Tim Coleman (tim@timcoleman.com)
+//	 Boris Kirzner (borisk@mainsoft.com)
 //
 // Copyright (C) Tim Coleman, 2003
 //
@@ -30,7 +31,7 @@
 // WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 //
 
-#if NET_2_0
+#if NET_2_0 || TARGET_JVM
 
 using System.Data.Common;
 
@@ -39,11 +40,11 @@
 	{
 		#region Fields
 		
-		string commandText;
-		int commandTimeout;
-		CommandType commandType;
-		bool designTimeVisible;
-		UpdateRowSource updatedRowSource;
+		string _commandText;
+		int _commandTimeout;
+		CommandType _commandType;
+		bool _designTimeVisible;
+		UpdateRowSource _updatedRowSource;
 
 		#endregion // Fields
 
@@ -51,15 +52,20 @@
 		
 		protected DbCommandBase ()
 		{
-			CommandText = String.Empty;
-			CommandTimeout = 30;
-			CommandType = CommandType.Text;
-			DesignTimeVisible = true;
-			UpdatedRowSource = UpdateRowSource.Both;
+			_commandText = String.Empty;
+			_commandTimeout = 30;
+			_commandType = CommandType.Text;
+			_designTimeVisible = true;
+			_updatedRowSource = UpdateRowSource.Both;
 		}
 
 		protected DbCommandBase (DbCommandBase from)
 		{
+			_commandText = from._commandText;
+			_commandTimeout = from._commandTimeout;
+			_commandType = from._commandType;
+			_updatedRowSource = from._updatedRowSource;
+			_designTimeVisible = from._designTimeVisible;
 		}
 
 		#endregion // Constructors
@@ -67,28 +73,27 @@
 		#region Properties
 
 		public override string CommandText {
-			get { return commandText; }
-			set { commandText = value; }
+			get { return _commandText; }
+			set { _commandText = value; }
 		}
-
 		public override int CommandTimeout {
-			get { return commandTimeout; }
-			set { commandTimeout = value; }
+			get { return _commandTimeout; }
+			set { _commandTimeout = value; }
 		}
 
 		public override CommandType CommandType {
-			get { return commandType; }
-			set { commandType = value; }
+			get { return _commandType; }
+			set { _commandType = value; }
 		}
 
 		public override bool DesignTimeVisible {
-			get { return designTimeVisible; }
-			set { designTimeVisible = value; }
-		}
+			get { return _designTimeVisible; }
+			set { _designTimeVisible = value; }
+		}	
 
 		public override UpdateRowSource UpdatedRowSource {
-			get { return updatedRowSource; }
-			set { updatedRowSource = value; }
+			get { return _updatedRowSource; }
+			set { _updatedRowSource = value; }
 		}
 
 		#endregion // Properties
@@ -101,25 +106,36 @@
 			throw new NotImplementedException ();
 		}
 
-		[MonoTODO]
+		
 		public override int ExecuteNonQuery ()
 		{
-			DbDataReader reader = ExecuteReader ();
-			reader.Close ();
+			IDataReader reader = null;
+			try {
+				reader = ExecuteReader();
+			}
+			finally {
+				if (reader != null) {
+					reader.Close ();				
+				}
+			}
 			return reader.RecordsAffected;
 		}
 
 		public override object ExecuteScalar ()
 		{
-                        object val = null;
-                        DbDataReader reader=ExecuteReader();
+			IDataReader reader = ExecuteReader(CommandBehavior.SingleRow | CommandBehavior.SequentialAccess);
+			
 			try {
-				if (reader.Read ())
-					val=reader[0];
+				do {
+					if (reader.FieldCount > 0 && reader.Read()) {
+						return reader.GetValue(0);			
+					}
+				}
+				while (reader.NextResult());
+				return null;
 			} finally {
 				reader.Close();
 			}
-                        return val;
 		}
 
 		[MonoTODO]
@@ -128,16 +144,13 @@
 			throw new NotImplementedException ();
 		}
 
-		[MonoTODO]
 		public virtual void PropertyChanging ()
 		{
-			throw new NotImplementedException ();
 		}
 
-		[MonoTODO]
 		public virtual void ResetCommandTimeout ()
 		{
-			throw new NotImplementedException ();
+			_commandTimeout = 30;
 		}
 
 		[MonoTODO]
Index: DbParameterBase.cs
===================================================================
--- DbParameterBase.cs	(revision 44908)
+++ DbParameterBase.cs	(working copy)
@@ -4,6 +4,7 @@
 // Author:
 //   Sureshkumar T (tsureshkumar@novell.com)
 //   Tim Coleman (tim@timcoleman.com)
+//   Boris Kirzner <borisk@mainsoft.com>
 //
 // Copyright (C) Tim Coleman, 2003
 //
@@ -30,27 +31,30 @@
 // WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 //
 
-#if NET_2_0
+#if NET_2_0 || TARGET_JVM
 
 using System.Data.Common;
 
 namespace System.Data.ProviderBase {
 	public abstract class DbParameterBase : DbParameter
 	{
+		#region Fields
 
-                #region Fields
-                string _name;
-                ParameterDirection _direction = ParameterDirection.Input;
-                bool _isNullable = false;
+		string _parameterName;
 		int _size;
+#if NET_2_0
 		byte _precision;
 		byte _scale;
-                object _paramValue;
-                int _offset;
 		DataRowVersion _sourceVersion;
+#endif
+		object _value;
+		ParameterDirection _direction;
+		bool _isNullable;
+		int _offset;
 		string _sourceColumn;
+		DbParameterCollection _parent = null;
 
-                #endregion // Fields
+		#endregion // Fields
 
 		#region Constructors
 	
@@ -59,11 +63,19 @@
 		{
 		}
 
-		[MonoTODO]
 		protected DbParameterBase (DbParameterBase source)
 		{
+			if (source == null) {
+				throw ExceptionHelper.ArgumentNull("source");
+			}
+
+			source.CopyTo(this);
+			ICloneable cloneable = source._value as ICloneable;
+			if (cloneable != null) 	{
+				_value = cloneable.Clone();
+			}
 		}
-
+        
 		#endregion // Constructors
 
 		#region Properties
@@ -73,9 +85,29 @@
 			get { throw new NotImplementedException (); }
 		}
 
-                public override ParameterDirection Direction {
-			get { return _direction; }
-			set { _direction = value; }
+		public override ParameterDirection Direction {
+			get {
+				if (_direction == ((ParameterDirection) 0)) {
+						return ParameterDirection.Input;
+				}
+				return _direction;
+			}
+			set {
+				if (_direction != value) {
+					switch (value) {
+							case ParameterDirection.Input:
+							case ParameterDirection.Output:
+							case ParameterDirection.InputOutput:
+							case ParameterDirection.ReturnValue:
+							{
+								PropertyChanging();
+								_direction = value;
+								return;
+							}
+					}
+					throw ExceptionHelper.InvalidParameterDirection(value);
+				}
+			}
 		}
 
 		public override bool IsNullable {
@@ -90,10 +122,21 @@
 		}
 
 		public override string ParameterName {
-			get { return _name; }
-			set { _name = value; }
+			get {
+				if (_parameterName == null) {
+						return String.Empty;
+				}
+				return _parameterName;
+			}
+			set {
+				if (_parameterName != value) {
+					PropertyChanging();
+					_parameterName = value;
+				}
+			}
 		}
 
+#if NET_2_0
 		public override byte Precision {
 			get { return _precision; }
 			set { _precision = value; }
@@ -105,30 +148,53 @@
 			set { _scale = value; }
 
 		}
+#endif
 
 		public override int Size {
 			get { return _size; }
-			set { _size = value; }
+
+			set {
+				if (_size != value) {
+					if (value < -1) {
+						throw ExceptionHelper.InvalidSizeValue(value);
+					}
+					PropertyChanging();
+					_size = value;
+				}
+			}
 		}
 
 		
 		public override string SourceColumn {
-			get { return _sourceColumn; }
-			set { _sourceColumn = value; }
+			get { 
+				if (_sourceColumn == null) {
+					return String.Empty;
+				}
+				return _sourceColumn;
+			}
+
+			set	{ _sourceColumn = value; }
 		}
 
-		
+#if NET_2_0		
 		public override DataRowVersion SourceVersion {
 			get { return _sourceVersion; }
 			set { _sourceVersion = value; }
 		}
+#endif		
 
 		
 		public override object Value {
-			get { return _paramValue; }
-			set { _paramValue = value; }
+			get { return _value; }
+			set { _value = value; }
 		}
 
+		internal DbParameterCollection Parent
+		{
+			get { return _parent; }
+			set { _parent = value; }
+		}
+
 		#endregion // Properties
 
 		#region Methods
@@ -136,15 +202,30 @@
 		[MonoTODO]
 		public override void CopyTo (DbParameter destination)
 		{
-			throw new NotImplementedException ();
-		}
+			if (destination == null) {
+				throw ExceptionHelper.ArgumentNull("destination");
+			}
 
-		[MonoTODO]
+			DbParameterBase t = (DbParameterBase)destination;
+			t._parameterName = _parameterName;			
+			t._size = _size;
+			t._offset = _offset;
+			t._isNullable = _isNullable;
+			t._sourceColumn = _sourceColumn;
+			t._direction = _direction;
+
+			if (_value is ICloneable)
+                t._value = ((ICloneable) _value).Clone();
+            else
+                t._value = this._value;
+		}		
+
 		public virtual void PropertyChanging ()
 		{
-			throw new NotImplementedException ();
 		}
 
+#if NET_2_0
+
 		[MonoTODO]
 		protected void ResetCoercedValue ()
 		{
@@ -174,13 +255,14 @@
 		{
 			throw new NotImplementedException ();
 		}
-
-		[MonoTODO]
+#endif	
+	
 		protected bool ShouldSerializeSize ()
 		{
-			throw new NotImplementedException ();
+			return (_size != 0);
 		}
 
+#if NET_2_0
 		[MonoTODO]
 		public override string ToString ()
 		{
@@ -204,6 +286,7 @@
 		{
 			throw new NotImplementedException ();
 		}
+#endif
 
 		#endregion // Methods
 	}
Index: ChangeLog
===================================================================
--- ChangeLog	(revision 44908)
+++ ChangeLog	(working copy)
@@ -1,3 +1,23 @@
+2005-05-23 Boris Kirzner <borisk@mainsoft.com>
+	* DbCommandBase.cs 
+		- Private members names changed to suite naming conventions.
+		- Implemented ExsecuteScalar, ExecuteNonQuery, PropertyChanging and ResetCommandTimeout.
+		- Implemented copy ctor.
+	* DbDataReaderBase.cs
+		- Implemented Depth property.
+		- Added #ifdef NET_2_0 on ISValidRow.
+		- Implemented Dispose and GetEnumerator
+	* DbParameterBase.cs
+		- Private members names changed to suite naming conventions.
+		- Implemented copy ctor.
+		- Reimplemented Direction, ParameterName, Size and SourceColumn properties.
+		- Added #ifdef NET_2_0 on methods not used in NET_1_1
+		- Implemented CopyTo and ShouldSerializeSize methods
+		- Added internal Parent property (used by DbParameterCollectionBase)
+	* DbParameterCollectionBase.cs
+		- Private members names changed to suite naming conventions.
+		- Re/Implemented public methods and added private ones.
+	
 2005-03-11  Sureshkumar T  <tsureshkumar@novell.com>
 
 	* DbConnectionBase.cs : Implemented OnStateChange.
