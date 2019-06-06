Index: ChangeLog
===================================================================
--- ChangeLog	(revision 45568)
+++ ChangeLog	(working copy)
@@ -1,3 +1,12 @@
+2005-06-08 Ilya Kharmatsky <ilyak-at-mainsoft.com>
+
+    * SessionStateMode.cs: Added TARGET_J2EE directive in order
+    to provide in J2EE configuration additional mode - J2EE
+    * SessionStateModule.cs: Added TARGET_JVM directives in order
+    to resolve unsupported in Ghrasshopper "static variables" issue
+    (When static variable are stored in general place, instead of
+    storing such variables per AppDomain).
+    
 2005-05-27 Gonzalo Paniagua Javier <gonzalo@ximian.com>
 
 	* RemoteStateServer.cs:
Index: SessionStateMode.cs
===================================================================
--- SessionStateMode.cs	(revision 45568)
+++ SessionStateMode.cs	(working copy)
@@ -35,6 +35,9 @@
 	InProc = 1,
 	StateServer = 2,
 	SQLServer = 3
+#if TARGET_J2EE
+	,J2ee = 4
+#endif
 }
 
 }
Index: SessionStateModule.cs
===================================================================
--- SessionStateModule.cs	(revision 45568)
+++ SessionStateModule.cs	(working copy)
@@ -42,8 +42,27 @@
 		internal static readonly string CookieName = "ASPSESSION";
 		internal static readonly string HeaderName = "AspFilterSessionId";
 		
+#if !TARGET_J2EE		
 		static SessionConfig config;
 		static Type handlerType;
+#else
+		static private SessionConfig config {
+			get {
+				return (SessionConfig)AppDomain.CurrentDomain.GetData("SessionStateModule.config");
+			}
+			set {
+				AppDomain.CurrentDomain.SetData("SessionStateModule.config", value);
+			}
+		}
+		static private Type handlerType {
+			get {
+				return (Type)AppDomain.CurrentDomain.GetData("SessionStateModule.handlerType");
+			}
+			set {
+				AppDomain.CurrentDomain.SetData("SessionStateModule.handlerType", value);
+			}
+		}
+#endif		
 		ISessionHandler handler;
 		bool sessionForStaticFiles;
 		
@@ -197,8 +216,10 @@
 
 		internal void OnEnd ()
 		{
+#if !TARGET_J2EE			
 			if (End != null)
 				End (this, EventArgs.Empty);
+#endif				
 		}
 		
 		public event EventHandler Start;
