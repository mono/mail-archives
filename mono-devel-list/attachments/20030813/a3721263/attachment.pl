--- mcs/class/System.Web/System.Web.UI.WebControls/ListControl.cs	2003-08-11 14:28:50.000000000 +0300
+++ mcs/class/System.Web/System.Web.UI.WebControls/ListControl.cs	2003-08-11 15:26:29.000000000 +0300
@@ -32,6 +32,7 @@
 		private ListItemCollection items;
 
 		private int cachedSelectedIndex = -1;
+		private string cachedSelectedValue;
 
 		public ListControl(): base(HtmlTextWriterTag.Select)
 		{
@@ -97,13 +98,10 @@
 			}
 			set
 			{
-				if(value != null)
+				if(value == null || value is IListSource || value is IEnumerable)
 				{
-					if(value is IListSource || value is IEnumerable)
-					{
-						dataSource = value;
-						return;
-					}
+					dataSource = value;
+					return;
 				}
 				throw new ArgumentException(HttpRuntime.FormatResourceString(ID, "Invalid DataSource Type"));
 			}
@@ -235,9 +233,17 @@
 				ListItem item = null;
 
 				if (value != null) {
-					item = Items.FindByValue (value);
-					if (item == null)
-						throw new ArgumentOutOfRangeException (value);
+					if (Items.Count > 0)
+					{
+						item = Items.FindByValue (value);
+						if (item == null)
+							throw new ArgumentOutOfRangeException (value);
+					}
+					else
+					{
+						cachedSelectedValue = value;
+						return;
+					}
 				}
 
 				ClearSelection ();
@@ -310,11 +316,11 @@
 
 				Items.Clear();
 
-				bool useProperties = (dtf.Length > 0 && dvf.Length > 0);
+				bool dontUseProperties = (dtf.Length == 0 && dvf.Length == 0);
 
 				foreach (object current in ds) {
 					ListItem li = new ListItem();
-					if (!useProperties){
+					if (dontUseProperties){
 						li.Text  = String.Format (dtfs, current);
 						li.Value = current.ToString ();
 						Items.Add (li);
@@ -336,6 +342,24 @@
 				}
 			}
 
+			if(cachedSelectedValue != null)
+			{
+				int index = Items.FindByValueInternal(cachedSelectedValue);
+				if(index == -1)
+				{
+					throw new ArgumentOutOfRangeException("value");
+				}
+				if(cachedSelectedIndex != -1 && cachedSelectedIndex != index)
+				{
+					throw new ArgumentException(HttpRuntime.FormatResourceString(
+						"Attributes_mutually_exclusive", "Selected Index", "Selected Value"));
+				}
+				SelectedIndex = index;
+				cachedSelectedIndex = -1;
+				cachedSelectedValue = null;
+				return;
+			}
+
 			if (cachedSelectedIndex != -1) {
 				SelectedIndex = cachedSelectedIndex;
 				cachedSelectedIndex = -1;
