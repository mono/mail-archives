Index: mcs/class/System.Web/System.Web.UI.WebControls/HyperLinkColumn.cs
===================================================================
RCS file: /mono/mcs/class/System.Web/System.Web.UI.WebControls/HyperLinkColumn.cs,v
retrieving revision 1.8
diff -u -p -r1.8 HyperLinkColumn.cs
--- mcs/class/System.Web/System.Web.UI.WebControls/HyperLinkColumn.cs	1 Aug 2003 11:54:11 -0000	1.8
+++ mcs/class/System.Web/System.Web.UI.WebControls/HyperLinkColumn.cs	15 Aug 2003 01:34:28 -0000
@@ -171,24 +171,28 @@ namespace System.Web.UI.WebControls
 			HyperLink link = (HyperLink) sender;
 			object item    = ((DataGridItem) link.NamingContainer).DataItem;
 
-			if (textFieldDescriptor == null && urlFieldDescriptor == null) {
-				PropertyDescriptorCollection properties = TypeDescriptor.GetProperties (item);
-				textFieldDescriptor = properties.Find (DataTextField, true);
-				if (textFieldDescriptor == null && !DesignMode)
-					throw new HttpException (HttpRuntime.FormatResourceString (
-									"Field_Not_Found", DataTextField));
-
-				urlFieldDescriptor = properties.Find (DataNavigateUrlField, true);
-				if (urlFieldDescriptor == null && !DesignMode)
-					throw new HttpException (HttpRuntime.FormatResourceString (
-									"Field_Not_Found", DataNavigateUrlField));
-			}
-
-			if (textFieldDescriptor != null) {
-				link.Text = FormatDataTextValue (textFieldDescriptor.GetValue (item));
-			} else {
-				link.Text = "Sample_DataBound_Text";
-			}
+			PropertyDescriptorCollection properties = TypeDescriptor.GetProperties (item);
+			if (textFieldDescriptor == null)
+				textFieldDescriptor = properties.Find (DataTextField, true);
+
+			if (urlFieldDescriptor == null)
+				urlFieldDescriptor = properties.Find (DataNavigateUrlField, true);
+
+			if (DataTextField.Length > 0 && textFieldDescriptor == null && !DesignMode)
+				throw new HttpException (HttpRuntime.FormatResourceString (
+								"Field_Not_Found", DataTextField));
+
+			if (DataNavigateUrlField.Length > 0 && urlFieldDescriptor == null && !DesignMode)
+				throw new HttpException (HttpRuntime.FormatResourceString (
+								"Field_Not_Found", DataNavigateUrlField));
+
+			if (textFieldDescriptor != null) {
+				link.Text = FormatDataTextValue (textFieldDescriptor.GetValue (item));
+			} else if ( Text != String.Empty ) {
+				link.Text = Text;
+			} else {
+				link.Text = "Sample_DataBound_Text";
+			}
 
 			if (urlFieldDescriptor != null) {
 				link.NavigateUrl = FormatDataNavigateUrlValue (urlFieldDescriptor.GetValue (item));
