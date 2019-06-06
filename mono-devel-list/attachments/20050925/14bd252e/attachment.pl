Index: System.Web.UI.WebControls/ListControl.cs
===================================================================
--- System.Web.UI.WebControls/ListControl.cs	(revision 50711)
+++ System.Web.UI.WebControls/ListControl.cs	(working copy)
@@ -328,7 +328,7 @@
 					text = DataBinder.Eval (container,
 							DataTextField).ToString ();
 				} else {
-					text = String.Empty;
+					text = container.ToString ();
 				}
 
 				if (DataValueField != String.Empty) {
@@ -338,12 +338,7 @@
 					value = text;
 				}
 
-				if (text == String.Empty) {
-					if (value != String.Empty)
-						text = value;
-				} else if (DataTextFormatString != String.Empty) {
-					// Dont apply the format string if we don't actually 
-					// have a textfield
+				if (DataTextFormatString != String.Empty) {
 					text = String.Format (DataTextFormatString, text);
 				}
 
