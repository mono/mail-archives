Index: System.Web.UI/TemplateControl.cs
===================================================================
--- System.Web.UI/TemplateControl.cs	(revision 74928)
+++ System.Web.UI/TemplateControl.cs	(working copy)
@@ -203,6 +203,17 @@
 				throw new HttpException ("virtualPath is null");
 #endif
 			Type type = GetTypeFromControlPath (virtualPath);
+			return LoadControl (type, null);
+		}
+
+#if NET_2_0
+		public
+#endif
+		Control LoadControl (Type type, object [] parameters)
+		{
+			if (type == null)
+				throw new ArgumentNullException ("type");
+
 			object [] attrs = type.GetCustomAttributes (typeof (PartialCachingAttribute), true);
 			if (attrs != null && attrs.Length == 1) {
 				PartialCachingAttribute attr = (PartialCachingAttribute) attrs [0];
@@ -213,7 +224,7 @@
 				return ctrl;
 			}
 
-			object control = Activator.CreateInstance (type);
+			object control = Activator.CreateInstance (type, parameters);
 			if (control is UserControl)
 				((UserControl) control).InitializeAsUserControl (Page);
 