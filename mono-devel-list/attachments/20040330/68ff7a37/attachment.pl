? file.diff
Index: DataTable.cs
===================================================================
RCS file: /mono/mcs/class/System.Data/System.Data/DataTable.cs,v
retrieving revision 1.49
diff -u -r1.49 DataTable.cs
--- DataTable.cs	29 Mar 2004 07:56:47 -0000	1.49
+++ DataTable.cs	30 Mar 2004 06:23:29 -0000
@@ -31,6 +31,8 @@
 	[DefaultEvent ("RowChanging")]
 	[DefaultProperty ("TableName")]
 	[DesignTimeVisible (false)]
+	[EditorAttribute ("Microsoft.VSDesigner.Data.Design.DataTableEditor, "+ Consts.AssemblyMicrosoft_VSDesigner, "System.Drawing.Design.UITypeEditor, "+ Consts.AssemblySystem_Drawing )]
+	[TypeConverterAttribute("System.ComponentModel.ComponentConverter, System, Version=1.0.5000.0, Culture=neutral, PublicKeyToken=b77a5c561934e089")]
 	[Serializable]
 	public class DataTable : MarshalByValueComponent, IListSource, ISupportInitialize, ISerializable 
 	{
@@ -58,6 +60,8 @@
 		private string _encodedTableName;
 		internal bool _duringDataLoad;
 		private bool dataSetPrevEnforceConstraints;
+		private bool dataTablePrevEnforceConstraints;
+		private bool enforceConstraints = true;
 		private DataRowBuilder _rowBuilder;
 		private ArrayList _indexes;
 
@@ -136,7 +140,10 @@
 		[DataSysDescription ("Indicates whether comparing strings within the table is case sensitive.")]	
 		public bool CaseSensitive {
 			get { return _caseSensitive; }
-			set { 
+			set {
+				if (_childRelations.Count > 0 || _parentRelations.Count > 0) {
+					throw new ArgumentException ("Cannot change CaseSensitive or Locale property. This change would lead to at least one DataRelation or Constraint to have different Locale or CaseSensitive settings between its related tables.");
+				}
 				_virginCaseSensitive = false;
 				_caseSensitive = value; 
 			}
@@ -302,6 +309,9 @@
 				return CultureInfo.CurrentCulture;
 			}
 			set { 
+				if (_childRelations.Count > 0 || _parentRelations.Count > 0) {
+					throw new ArgumentException ("Cannot change CaseSensitive or Locale property. This change would lead to at least one DataRelation or Constraint to have different Locale or CaseSensitive settings between its related tables.");
+				}
 				if (_locale == null || !_locale.Equals(value))
 					_locale = value; 
 			}
@@ -351,7 +361,14 @@
 		[DefaultValue ("")]
 		public string Prefix {
 			get { return "" + _prefix; }
-			set { _prefix = value; }
+			set {
+				// Prefix cannot contain any special characters other than '_' and ':'
+				for (int i = 0; i < value.Length; i++) {
+					if (!(Char.IsLetterOrDigit (value [i])) && (value [i] != '_') && (value [i] != ':'))
+						throw new DataException ("Prefix '" + value + "' is not valid, because it contains special characters.");
+				}
+				_prefix = value;
+			}
 		}
 
 		/// <summary>
@@ -360,6 +377,8 @@
 		/// </summary>
 		[DataCategory ("Data")]
 		[DataSysDescription ("Indicates the column(s) that represent the primary key for this table.")]
+		[EditorAttribute ("Microsoft.VSDesigner.Data.Design.PrimaryKeyEditor, "+ Consts.AssemblyMicrosoft_VSDesigner, "System.Drawing.Design.UITypeEditor, "+ Consts.AssemblySystem_Drawing )]
+		[TypeConverterAttribute ("System.Data.PrimaryKeyTypeConverter, System.Data, Version=1.0.5000.0, Culture=neutral, PublicKeyToken=b77a5c561934e089")]
 		public DataColumn[] PrimaryKey {
 			get {
 				UniqueConstraint uc = UniqueConstraint.GetPrimaryKeyConstraint( Constraints);
@@ -463,6 +482,23 @@
 				return false;
 			}
 		}
+		
+		private bool EnforceConstraints {
+			get { return enforceConstraints; }
+			set {
+				if (value != enforceConstraints) {
+					if (value) {
+						// first assert all unique constraints
+						foreach (UniqueConstraint uc in this.Constraints.UniqueConstraints)
+						uc.AssertConstraint ();
+						// then assert all foreign keys
+						foreach (ForeignKeyConstraint fk in this.Constraints.ForeignKeyConstraints)
+							fk.AssertConstraint ();
+					}
+					enforceConstraints = value;
+				}
+			}
+		}
 
 		public bool RowsExist(Object[] columns, Object[] relatedColumns,DataRow row)
 		{
@@ -555,6 +591,11 @@
 					this.dataSetPrevEnforceConstraints = this.dataSet.EnforceConstraints;
 					this.dataSet.EnforceConstraints = false;
 				}
+				else {
+					//if table does not belong to any data set use EnforceConstraints of the table
+					this.dataTablePrevEnforceConstraints = this.EnforceConstraints;
+					this.EnforceConstraints = false;
+				}
 			}
 			return;
 		}
@@ -600,7 +641,6 @@
 		/// Clones the structure of the DataTable, including
 		///  all DataTable schemas and constraints.
 		/// </summary>
-		[MonoTODO]
 		public virtual DataTable Clone () 
 		{
 			DataTable Copy = new DataTable ();			
@@ -631,7 +671,6 @@
 		/// <summary>
 		/// Copies both the structure and data for this DataTable.
 		/// </summary>
-		[MonoTODO]	
 		public DataTable Copy () 
 		{
 			DataTable Copy = new DataTable ();
@@ -649,7 +688,6 @@
 			return Copy;
 		}
 
-		[MonoTODO]
 		private void CopyProperties (DataTable Copy) 
 		{
 					
@@ -662,7 +700,11 @@
 			// Copy.DefaultView
 			// Copy.DesignMode
 			Copy.DisplayExpression = DisplayExpression;
-			// Copy.ExtendedProperties
+			//  Cannot copy extended properties directly as the property does not have a set accessor
+			Array tgtArray = Array.CreateInstance( typeof (object), ExtendedProperties.Count);
+			ExtendedProperties.Keys.CopyTo (tgtArray, 0);
+			for (int i=0; i < ExtendedProperties.Count; i++)
+				Copy.ExtendedProperties.Add (tgtArray.GetValue (i), ExtendedProperties[tgtArray.GetValue (i)]);
 			Copy.Locale = Locale;
 			Copy.MinimumCapacity = MinimumCapacity;
 			Copy.Namespace = Namespace;
@@ -724,20 +766,21 @@
 		/// Turns on notifications, index maintenance, and 
 		/// constraints after loading data.
 		/// </summary>
-		[MonoTODO]
 		public void EndLoadData() 
 		{
 			int i = 0;
 			if (this._duringDataLoad) 
 			{
-				//Returning from loading mode, raising exceptions as usual
-				this._duringDataLoad = false;
 				
 				if (this.dataSet !=null)
 				{
 					//Getting back to previous EnforceConstraint state
 					this.dataSet.EnforceConstraints = this.dataSetPrevEnforceConstraints;
 				}
+				else {
+					//Getting back to the table's previous EnforceConstraint state
+					this.EnforceConstraints = this.dataTablePrevEnforceConstraints;
+				}
 				for (i=0 ; i<this.Rows.Count ; i++)
 				{
 					if (this.Rows[i]._nullConstraintViolation )
@@ -746,6 +789,8 @@
 					}
 						
 				}
+				//Returning from loading mode, raising exceptions as usual
+				this._duringDataLoad = false;
 
 			}
 
@@ -756,7 +801,6 @@
 		///  changes made to it since it was loaded or 
 		///  AcceptChanges was last called.
 		/// </summary>
-		[MonoTODO]
 		public DataTable GetChanges() 
 		{
 			return GetChanges(DataRowState.Added | DataRowState.Deleted | DataRowState.Modified);
@@ -767,7 +811,6 @@
 		/// changes made to it since it was last loaded, or 
 		/// since AcceptChanges was called, filtered by DataRowState.
 		/// </summary>
-		[MonoTODO]	
 		public DataTable GetChanges(DataRowState rowStates) 
 		{
 			DataTable copyTable = null;
@@ -775,12 +818,14 @@
 			IEnumerator rowEnumerator = Rows.GetEnumerator();
 			while (rowEnumerator.MoveNext()) {
 				DataRow row = (DataRow)rowEnumerator.Current;
+				// The spec says relationship constraints may cause Unchanged parent rows to be included but
+				// MS .NET 1.1 does not include Unchanged rows even if their child rows are changed.
 				if (row.IsRowChanged(rowStates)) {
 					if (copyTable == null)
 						copyTable = Clone();
 					DataRow newRow = copyTable.NewRow();
-					copyTable.Rows.Add(newRow);
 					row.CopyValuesToRow(newRow);
+					copyTable.Rows.Add (newRow);
 				}
 			}
 			 
