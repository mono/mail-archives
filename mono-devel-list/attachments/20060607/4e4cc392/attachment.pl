Index: ChangeLog
===================================================================
--- ChangeLog	(revision 61521)
+++ ChangeLog	(working copy)
@@ -1,3 +1,7 @@
+2006-06-07  Robert Jordan  <robertj@gmx.net>
+
+	* mono-service.cs: Fixed entry point invocation.
+
 2005-12-27  Jonathan Pryor  <jonpryor@vt.edu>
 
 	* mono-service.cs: Use non-obsolete Mono.Posix.dll types.
Index: mono-service.cs
===================================================================
--- mono-service.cs	(revision 61521)
+++ mono-service.cs	(working copy)
@@ -207,9 +207,11 @@
 				error (logname, "Entry point not defined in service");
 				return 1;
 			}
-	
-			string [] service_args = new string [0];
-			entry.Invoke (null, service_args);
+
+			if (entry.GetParameters ().Length == 0)
+				entry.Invoke (null, null);
+			else
+				entry.Invoke (null, new object [] { new string [0] });
 			
 			return 0;
 			
