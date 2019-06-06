mcs/class/Managed.Windows.Forms/System.Windows.Forms:

2007-05-08  Randolph Chung  <tausq@debian.org>

	* DataGridViewRowCollection.cs: Properly create rows and cells from
	their templates and set their owning column attributes. Update handling
	of adding rows without columns and shared rows so that it matches the 
	MS.NET behavior.
	
	* DataGridViewColumnCollection: Create new columns as TextBox columns
	instead of generic (unpaintable) columns.

	* DataGridViewRow.cs: Do not allow balues to be set on a shared row.
	Do not spontaneously create cells in SetValues () if the cells do not
	already exist. Properly set the return value according to what got
	added to the row.

	* DataGridViewCell.cs: Remove uninitialized dataGridViewOwner attribute.
	Use the base class' DataGridView properly where required.

mcs/class/Managed.Windows.Forms/Test/System.Windows.Forms:

2007-05-08  Randolph Chung  <tausq@debian.org>

	* DataGridViewRowTest.cs: Update existing tests based on changes to
	row behavior. Add new tests for new error checks and return values.

Index: DataGridViewRowCollection.cs
===================================================================
--- DataGridViewRowCollection.cs	(revision 76876)
+++ DataGridViewRowCollection.cs	(working copy)
@@ -87,26 +87,41 @@
 
 		public event CollectionChangeEventHandler CollectionChanged;
 
+		private DataGridViewRow CreateRowFromTemplate () {
+			DataGridViewRow row = dataGridView.RowTemplate.Clone () as DataGridViewRow;
+			row.SetDataGridView (dataGridView);
+			foreach (DataGridViewColumn col in dataGridView.Columns) {
+				DataGridViewCell cell = col.CellTemplate.Clone () as DataGridViewCell;
+				cell.SetOwningColumn (col);
+				row.Cells.Add (cell);
+			}
+			return row;
+		}
+
 		[DesignerSerializationVisibility (DesignerSerializationVisibility.Hidden)]
 		public virtual int Add ()
 		{
-			return Add(dataGridView.RowTemplate.Clone() as DataGridViewRow);
+			return Add(CreateRowFromTemplate(), true);
 		}
 
 		int IList.Add(object o)
 		{
-			return Add(o as DataGridViewRow);
+			return Add(o as DataGridViewRow, false);
 		}
 
-		public virtual int Add (DataGridViewRow dataGridViewRow)
+		private int Add (DataGridViewRow dataGridViewRow, bool fromTemplate)
 		{
+			if (dataGridView.Columns.Count == 0) {
+				throw new InvalidOperationException ("No row can be added to a DataGridView control that does not have columns. Columns must be added first.");
+			}
 			if (dataGridView.DataSource != null) {
 				throw new InvalidOperationException("DataSource of DataGridView is not null.");
 			}
 			if (dataGridView.Columns.Count == 0) {
 				throw new InvalidOperationException("DataGridView has no columns.");
 			}
-			dataGridViewRow.SetIndex(list.Count);
+			if (fromTemplate)
+				dataGridViewRow.SetIndex(list.Count);
 			dataGridViewRow.SetDataGridView(dataGridView);
 			int result = list.Add(dataGridViewRow);
 			OnCollectionChanged(new CollectionChangeEventArgs(CollectionChangeAction.Add, dataGridViewRow));
@@ -116,6 +131,11 @@
 			return result;
 		}
 
+		public virtual int Add (DataGridViewRow dataGridViewRow)
+		{
+			return Add (dataGridViewRow, false);
+		}
+
 		[DesignerSerializationVisibility (DesignerSerializationVisibility.Hidden)]
 		public virtual int Add (int count)
 		{
@@ -131,7 +151,7 @@
 			raiseEvent = false;
 			int result = 0;
 			for (int i = 0; i < count; i++) {
-				result = Add(dataGridView.RowTemplate.Clone() as DataGridViewRow);
+				result = Add ();
 			}
 			DataGridView.OnRowsAdded(new DataGridViewRowsAddedEventArgs(result - count + 1, count));
 			raiseEvent = true;
@@ -147,8 +167,8 @@
 			if (dataGridView.VirtualMode) {
 				throw new InvalidOperationException("DataGridView is in virtual mode.");
 			}
-			DataGridViewRow row = new DataGridViewRow();
-			int result = Add(row);
+			DataGridViewRow row = CreateRowFromTemplate();
+			int result = Add (row, true);
 			row.SetValues(values);
 			return result;
 		}
@@ -167,7 +187,7 @@
 
 		public virtual int AddCopy (int indexSource)
 		{
-			return Add((list[indexSource] as DataGridViewRow).Clone() as DataGridViewRow);
+			return Add((list[indexSource] as DataGridViewRow).Clone() as DataGridViewRow, true);
 		}
 
 		[DesignerSerializationVisibility (DesignerSerializationVisibility.Hidden)]
@@ -177,7 +197,7 @@
 			int count = 0;
 			int lastIndex = -1;
 			foreach (DataGridViewRow row in dataGridViewRows) {
-				lastIndex = Add(row);
+				lastIndex = Add(row, false);
 				count++;
 			}
 			DataGridView.OnRowsAdded(new DataGridViewRowsAddedEventArgs(lastIndex - count + 1, count));
@@ -335,6 +355,9 @@
 
 		public virtual void Insert (int rowIndex, DataGridViewRow dataGridViewRow)
 		{
+			if (dataGridView.Columns.Count == 0) {
+				throw new InvalidOperationException ("No row can be added to a DataGridView control that does not have columns. Columns must be added first.");
+			}
 			dataGridViewRow.SetIndex(rowIndex);
 			dataGridViewRow.SetDataGridView(dataGridView);
 			list[rowIndex] = dataGridViewRow;
@@ -349,7 +372,7 @@
 			int index = rowIndex;
 			raiseEvent = false;
 			for (int i = 0; i < count; i++) {
-				Insert(index++, dataGridView.RowTemplate.Clone());
+				Insert(index++, CreateRowFromTemplate());
 			}
 			DataGridView.OnRowsAdded(new DataGridViewRowsAddedEventArgs(rowIndex, count));
 			raiseEvent = true;
Index: DataGridViewColumnCollection.cs
===================================================================
--- DataGridViewColumnCollection.cs	(revision 76876)
+++ DataGridViewColumnCollection.cs	(working copy)
@@ -80,7 +80,7 @@
 
 		[DesignerSerializationVisibility (DesignerSerializationVisibility.Hidden)]
 		public virtual int Add (string columnName, string headerText) {
-			DataGridViewColumn col = new DataGridViewColumn();
+			DataGridViewColumn col = new DataGridViewTextBoxColumn();
 			col.Name = columnName;
 			col.HeaderText = headerText;
 			return Add(col);
Index: DataGridViewRow.cs
===================================================================
--- DataGridViewRow.cs	(revision 76876)
+++ DataGridViewRow.cs	(working copy)
@@ -346,21 +346,26 @@
 
 		public bool SetValues (params object[] values)
 		{
+			if (Index == -1) {
+				throw new InvalidOperationException("Operation cannot be performed on a shared row");
+			}
 			if (values == null) {
 				throw new ArgumentNullException("vues is null");
 			}
 			if (DataGridView != null && DataGridView.VirtualMode) {
 				throw new InvalidOperationException("DataGridView is operating in virtual mode");
 			}
-			/////// COLUMNAS //////////
+
+			bool ret = true;
 			for (int i = 0; i < values.Length; i++) {
-				DataGridViewCell cell = new DataGridViewTextBoxCell();
-				cell.Value = values[i];
-				cells.Add(cell);
+				if (i >= cells.Count) {
+					ret = false;
+					break;
+				}
+				cells[i].Value = values[i];
 			}
 			
-			// XXX
-			return true;
+			return ret;
 		}
 
 		public override string ToString ()
Index: DataGridViewCell.cs
===================================================================
--- DataGridViewCell.cs	(revision 76876)
+++ DataGridViewCell.cs	(working copy)
@@ -36,8 +36,6 @@
 	// XXX [TypeConverter (typeof (DataGridViewCellConverter))]
 	public abstract class DataGridViewCell : DataGridViewElement, ICloneable, IDisposable
 	{
-		private DataGridView dataGridViewOwner;
-
 		private AccessibleObject accessibilityObject;
 		private int columnIndex;
 		private Rectangle contentBounds;
@@ -976,6 +974,10 @@
 			owningRow = row;
 		}
 
+		internal void SetOwningColumn (DataGridViewColumn column) {
+			owningColumn = column;
+		}
+
 		internal void SetColumnIndex (int index) {
 			columnIndex = index;
 		}
@@ -1108,16 +1110,16 @@
 			public override void Select (AccessibleSelection flags) {
 				switch (flags) {
 					case AccessibleSelection.TakeFocus:
-						dataGridViewCell.dataGridViewOwner.Focus();
+						dataGridViewCell.DataGridView.Focus();
 						break;
 					case AccessibleSelection.TakeSelection:
 						//dataGridViewCell.Focus();
 						break;
 					case AccessibleSelection.AddSelection:
-						dataGridViewCell.dataGridViewOwner.SelectedCells.InternalAdd(dataGridViewCell);
+						dataGridViewCell.DataGridView.SelectedCells.InternalAdd(dataGridViewCell);
 						break;
 					case AccessibleSelection.RemoveSelection:
-						dataGridViewCell.dataGridViewOwner.SelectedCells.InternalRemove(dataGridViewCell);
+						dataGridViewCell.DataGridView.SelectedCells.InternalRemove(dataGridViewCell);
 						break;
 				}
 			}
Index: System.Windows.Forms/DataGridViewRowTest.cs
===================================================================
--- System.Windows.Forms/DataGridViewRowTest.cs	(revision 76876)
+++ System.Windows.Forms/DataGridViewRowTest.cs	(working copy)
@@ -51,12 +51,63 @@
 		[ExpectedException(typeof(InvalidOperationException))]
 		public void TestVisibleInvalidOperationException () {
 			DataGridView grid = new DataGridView();
+			grid.Columns.Add(new DataGridViewTextBoxColumn());
 			DataGridViewRow row = new DataGridViewRow();
 			grid.Rows.Add(row);
 			row.Visible = false;
 		}
 
 		[Test]
+		[ExpectedException(typeof(InvalidOperationException))]
+		public void AddRowWithoutColumns()
+		{
+			DataGridView grid = new DataGridView ();
+			DataGridViewRow row = new DataGridViewRow ();
+			// Cannot add row without columns
+			grid.Rows.Add(row);
+		}
+
+		[Test]
+		[ExpectedException(typeof(InvalidOperationException))]
+		public void SharedRowSetData ()
+		{
+			DataGridView grid = new DataGridView ();
+			DataGridViewTextBoxColumn col = new DataGridViewTextBoxColumn ();
+			grid.Columns.Add (col);
+			DataGridViewRow row = new DataGridViewRow ();
+			grid.Rows.Add (row);
+			// Cannot set values on shared row. Note that the row is 
+			// "shared" even after it is added to the grid!
+			row.SetValues (new string[] { "a" });
+		}
+
+		[Test]
+		public void RowSetValueCheckReturnValue ()
+		{
+			DataGridView grid = new DataGridView ();
+			grid.Columns.Add ("key", "key");
+			grid.Columns.Add ("value", "value");
+			grid.Rows.Add ();
+			DataGridViewRow row = grid.Rows [grid.Rows.Count - 1];
+			Assert.IsTrue(row.SetValues(new string[] { "a" }));
+			Assert.IsTrue(row.SetValues(new string[] { "a", "b" }));
+			Assert.IsFalse(row.SetValues(new string[] { "a", "b", "c" }));
+		}
+
+		[Test]
+		public void GetCellByName ()
+		{
+			DataGridView grid = new DataGridView ();
+			grid.Columns.Add ("key", "key");
+			grid.Columns.Add ("value", "value");
+			grid.Rows.Add (new string[] { "key1", "value1" });
+			grid.Rows.Add (new string[] { "key2", "value2" });
+			DataGridViewRow row = grid.Rows [0];
+			Assert.AreEqual (row.Cells [0], row.Cells ["key"]);
+			Assert.AreEqual (row.Cells [1], row.Cells ["value"]);
+		}
+
+		[Test]
 		public void Height ()
 		{
 			DataGridViewRow row = new DataGridViewRow();

