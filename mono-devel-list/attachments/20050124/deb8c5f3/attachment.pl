Index: DataTable.cs
===================================================================
--- DataTable.cs	(revision 39396)
+++ DataTable.cs	(working copy)
@@ -195,15 +195,6 @@
 			}
 		}
 
-		internal bool VirginCaseSensitive {
-			get { return _virginCaseSensitive; }
-			set { _virginCaseSensitive = value; }
-		}
-
-		internal ArrayList Indexes{
-			get { return _indexes; }
-		}
-
 		internal void ChangedDataColumn (DataRow dr, DataColumn dc, object pv) 
 		{
 			DataColumnChangeEventArgs e = new DataColumnChangeEventArgs (dr, dc, pv);
@@ -750,7 +741,7 @@
 		{
 					
 			Copy.CaseSensitive = CaseSensitive;
-			Copy.VirginCaseSensitive = VirginCaseSensitive;
+			Copy._virginCaseSensitive = _virginCaseSensitive;
 
 			// Copy.ChildRelations
 			// Copy.Constraints
@@ -1285,7 +1276,15 @@
 				Parser parser = new Parser ();
 				filter = parser.Compile (filterExpression);
 			}
+			SortableColumn[] sortableColumns = null;
+			if (sort != null && !sort.Equals(String.Empty))
+				sortableColumns = SortableColumn.ParseSortString (this, sort, true);
 
+			return Select (filter, sortableColumns, recordStates);
+		}
+
+		internal DataRow [] Select (IExpression filter, SortableColumn [] sortableColumns, DataViewRowState recordStates)
+		{
 			ArrayList rowList = new ArrayList();
 			int recordStateFilter = GetRowStateFilter(recordStates);
 			foreach (DataRow row in Rows) {
@@ -1298,16 +1297,7 @@
 
 			DataRow[] dataRows = (DataRow[])rowList.ToArray(typeof(DataRow));
 
-			if (sort != null && !sort.Equals(String.Empty)) 
-			{
-				SortableColumn[] sortableColumns = null;
-
-				sortableColumns = ParseTheSortString (sort);
-				if (sortableColumns == null)
-					throw new Exception ("sort expression result is null");
-				if (sortableColumns.Length == 0)
-					throw new Exception("sort expression result is 0");
-
+			if (sortableColumns != null) {
 				RowSorter rowSorter = new RowSorter (this, dataRows, sortableColumns);
 				dataRows = rowSorter.SortRows ();
 
@@ -1315,7 +1305,6 @@
 				rowSorter = null;
 			}
 
-			
 			return dataRows;
 		}
 
@@ -1673,82 +1662,6 @@
 			UniqueConstraint.SetAsPrimaryKey(this.Constraints, null);
 		}
 
-		// to parse the sort string for DataTable:Select(expression,sort)
-		// into sortable columns (think ORDER BY, 
-		// such as, "customer ASC, price DESC" )
-		internal SortableColumn[] ParseTheSortString (string sort) 
-		{
-			SortableColumn[] sortColumns = null;
-			ArrayList columns = null;
-		
-			if (sort != null && !sort.Equals ("")) {
-				columns = new ArrayList ();
-				string[] columnExpression = sort.Trim ().Split (new char[1] {','});
-			
-				for (int c = 0; c < columnExpression.Length; c++) {
-					string[] columnSortInfo = columnExpression[c].Trim ().Split (new char[1] {' '});
-				
-					string columnName = columnSortInfo[0].Trim ();
-					string sortOrder = "ASC";
-					if (columnSortInfo.Length > 1) 
-						sortOrder = columnSortInfo[1].Trim ().ToUpper (Locale);
-					
-					ListSortDirection sortDirection = ListSortDirection.Ascending;
-					switch (sortOrder) {
-					case "ASC":
-						sortDirection = ListSortDirection.Ascending;
-						break;
-					case "DESC":
-						sortDirection = ListSortDirection.Descending;
-						break;
-					default:
-						throw new IndexOutOfRangeException ("Could not find column: " + columnExpression[c]);
-					}
-					Int32 ord = 0;
-					try {
-						ord = Int32.Parse (columnName);
-					}
-					catch (FormatException) {
-						ord = -1;
-					}
-					DataColumn dc = null;
-					if (ord == -1)				
-						dc = _columnCollection[columnName];
-					else
-						dc = _columnCollection[ord];
-					SortableColumn sortCol = new SortableColumn (dc,sortDirection);
-					columns.Add (sortCol);
-				}	
-				sortColumns = (SortableColumn[]) columns.ToArray (typeof (SortableColumn));
-			}		
-			return sortColumns;
-		}
-	
-		internal class SortableColumn 
-		{
-			private DataColumn col;
-			private ListSortDirection dir;
-
-			internal SortableColumn (DataColumn column, 
-						ListSortDirection direction) 
-			{
-				col = column;
-				dir = direction;
-			}
-
-			public DataColumn Column {
-				get {
-					return col;
-				}
-			}
-
-			public ListSortDirection SortDirection {
-				get {
-					return dir;
-				}
-			}
-		}
-
 		private class RowSorter : IComparer 
 		{
 			private DataTable table;
@@ -1912,4 +1825,88 @@
 			}
 		}
 	}
+
+	// to parse the sort string for DataTable:Select(expression,sort)
+	// into sortable columns (think ORDER BY, 
+	// such as, "customer ASC, price DESC" ), as well as DataView.Sort.
+	internal class SortableColumn 
+	{
+		private DataColumn col;
+		private ListSortDirection dir;
+
+		internal SortableColumn (DataColumn column, 
+					ListSortDirection direction) 
+		{
+			col = column;
+			dir = direction;
+		}
+
+		public DataColumn Column {
+			get {
+				return col;
+			}
+		}
+
+		public ListSortDirection SortDirection {
+			get {
+				return dir;
+			}
+		}
+
+		internal static SortableColumn[] ParseSortString (DataTable table, string sort, bool rejectNoResult)
+		{
+			SortableColumn[] sortColumns = null;
+			ArrayList columns = null;
+		
+			if (sort != null && !sort.Equals ("")) {
+				columns = new ArrayList ();
+				string[] columnExpression = sort.Trim ().Split (new char[1] {','});
+			
+				for (int c = 0; c < columnExpression.Length; c++) {
+					string[] columnSortInfo = columnExpression[c].Trim ().Split (new char[1] {' '});
+				
+					string columnName = columnSortInfo[0].Trim ();
+					string sortOrder = "ASC";
+					if (columnSortInfo.Length > 1) 
+						sortOrder = columnSortInfo[1].Trim ().ToUpper (table.Locale);
+					
+					ListSortDirection sortDirection = ListSortDirection.Ascending;
+					switch (sortOrder) {
+					case "ASC":
+						sortDirection = ListSortDirection.Ascending;
+						break;
+					case "DESC":
+						sortDirection = ListSortDirection.Descending;
+						break;
+					default:
+						throw new IndexOutOfRangeException ("Could not find column: " + columnExpression[c]);
+					}
+					Int32 ord = 0;
+					try {
+						ord = Int32.Parse (columnName);
+					}
+					catch (FormatException) {
+						ord = -1;
+					}
+					DataColumn dc = null;
+					if (ord == -1)				
+						dc = table.Columns [columnName];
+					else
+						dc = table.Columns [ord];
+					SortableColumn sortCol = new SortableColumn (dc,sortDirection);
+					columns.Add (sortCol);
+				}	
+				sortColumns = (SortableColumn[]) columns.ToArray (typeof (SortableColumn));
+			}		
+
+			if (rejectNoResult) {
+				if (sortColumns == null)
+					throw new Exception ("sort expression result is null");
+				if (sortColumns.Length == 0)
+					throw new Exception("sort expression result is 0");
+			}
+			return sortColumns;
+		}
+	}
+
 }
Index: DataView.cs
===================================================================
--- DataView.cs	(revision 39396)
+++ DataView.cs	(working copy)
@@ -13,6 +13,7 @@
 using System.Collections;
 using System.ComponentModel;
 using System.Reflection;
+using Mono.Data.SqlExpressions;
 
 namespace System.Data 
 {
@@ -31,11 +32,12 @@
 	{
 		DataTable dataTable = null;
 		string rowFilter = "";
+		IExpression rowFilterExpr;
 		string sort = "";
+		SortableColumn [] sortedColumns = null;
 		DataViewRowState rowState;
 		DataRowView[] rowCache = new DataRowView[0];
-		
-		
+
 		bool allowNew = true; 
 		bool allowEdit = true;
 		bool allowDelete = true;
@@ -67,8 +69,8 @@
 		{
 			dataTable = table;
 			rowState = DataViewRowState.CurrentRows;
-			rowFilter = RowFilter;
-			sort = Sort;
+			this.RowFilter = RowFilter;
+			this.Sort = Sort;
 			rowState = RowState;
 			Open();
 		}
@@ -127,7 +129,8 @@
 				if (applyDefaultSort == true && (sort == null || sort == string.Empty)) {
 					foreach (Constraint c in dataTable.Constraints)	{
 						if (c is UniqueConstraint) {
-							sort = GetSortString ((UniqueConstraint) c);
+							// FIXME: Compute SortableColumns[] directly.
+							Sort = GetSortString ((UniqueConstraint) c);
 							break;
 						}
 					}
@@ -178,6 +181,14 @@
 			
 			[MonoTODO]
 			set {
+				if (value == null)
+					value = String.Empty;
+				if (value == String.Empty) 
+					rowFilterExpr = null;
+				else {
+					Parser parser = new Parser ();
+					rowFilterExpr = parser.Compile (value);
+				}
 				rowFilter = value;
 				UpdateIndex ();
 				OnListChanged (new ListChangedEventArgs (ListChangedType.Reset, - 1, -1));
@@ -219,7 +230,8 @@
 					if (ApplyDefaultSort == true) {
 						foreach (Constraint c in dataTable.Constraints) {
 							if (c is UniqueConstraint) {
-								sort = GetSortString ((UniqueConstraint)c);
+								// FIXME: Compute SortableColumns[] directly.
+								Sort = GetSortString ((UniqueConstraint)c);
 								break;
 							}
 						}
@@ -231,6 +243,7 @@
 					/* sort is set to value specified */
 					useDefaultSort = false;
 					sort = value;
+					sortedColumns = SortableColumn.ParseSortString (dataTable, value, true);
 				}
 				UpdateIndex ();
 				OnListChanged (new ListChangedEventArgs (ListChangedType.Reset, - 1, -1));
@@ -344,8 +357,7 @@
 			if (sort == null || sort == string.Empty)
 				throw new ArgumentException ("Find finds a row based on a Sort order, and no Sort order is specified");
 			else {
-				DataTable.SortableColumn [] sortedColumns = null;
-				sortedColumns = dataTable.ParseTheSortString (sort);
+				// FIXME: maybe some of those thecks could be removel.
 				if (sortedColumns == null)
 					throw new Exception ("sort expression result is null");
 				if (sortedColumns.Length == 0)
@@ -604,7 +616,7 @@
 			DataRowView[] newRowCache = null;
 			DataRow[] rows = null;
 			
-			rows = dataTable.Select (RowFilter, Sort, RowStateFilter);
+			rows = dataTable.Select (rowFilterExpr, sortedColumns, RowStateFilter);
 
 			newRowCache = new DataRowView[rows.Length];
 			for (int r = 0; r < rows.Length; r++) {
@@ -857,13 +869,11 @@
 		
 		private object [] GetSearchKey (DataRow dr)
 		{
-			DataTable.SortableColumn [] sortedColumns = null;
-			sortedColumns = dataTable.ParseTheSortString (sort);
 			if (sortedColumns == null) 
 				return null;
 			object [] keys = new object [sortedColumns.Length];
 			int i = 0;
-			foreach (DataTable.SortableColumn sc in sortedColumns) {
+			foreach (SortableColumn sc in sortedColumns) {
 				keys [i] = dr [sc.Column];
 				i++;
 			}
@@ -908,15 +918,15 @@
 		
 		private class RowComparer : IComparer 
 		{
-			private DataTable.SortableColumn [] sortColumns;
+			private SortableColumn [] sortColumns;
 			private DataTable table;
-			public RowComparer(DataTable table, DataTable.SortableColumn[] sortColumns) 
+			public RowComparer(DataTable table, SortableColumn[] sortColumns) 
 			{
 				this.table = table;			
 				this.sortColumns = sortColumns;
 			}
 
-			public DataTable.SortableColumn[] SortedColumns {
+			public SortableColumn[] SortedColumns {
 				get {
 					return sortColumns;
 				}
@@ -931,7 +941,7 @@
 				DataRowView rowView = (DataRowView) y;
 				object [] keys = (object [])x;
 				for(int i = 0; i < sortColumns.Length; i++) {
-					DataTable.SortableColumn sortColumn = sortColumns [i];
+					SortableColumn sortColumn = sortColumns [i];
 					DataColumn dc = sortColumn.Column;
 
 					IComparable row = (IComparable) rowView.Row [dc];
Index: ChangeLog
===================================================================
--- ChangeLog	(revision 39401)
+++ ChangeLog	(working copy)
@@ -1,5 +1,13 @@
 2005-01-24  Atsushi Enomoto  <atsushi@ximian.com>
 
+	* DataTable.cs, DataView.cs :
+	  Optimized DataView to compile only once RowFilter and Sort when 
+	  those properties are set. To make it possible, extracted 
+	  SortableColumn out of DataTable and added internal DataTable.Select()
+	  that accepts precompiled IExpression and SortableColumns[].
+
+2005-01-24  Atsushi Enomoto  <atsushi@ximian.com>
+
 	* DataColumn.cs : set_MaxLength is not allowed when it is mapped to
 	  SimpleContent. (However, it is weird but it never fails when we set
 	  ColumnMapping = MappingType.SimpleContent when we have MaxLength.)