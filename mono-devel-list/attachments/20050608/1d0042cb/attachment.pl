Index: CacheDependency.cs
===================================================================
--- CacheDependency.cs	(revision 45568)
+++ CacheDependency.cs	(working copy)
@@ -58,8 +58,12 @@
 		bool disposed;
 		CacheEntry [] entries;
 		CacheItemRemovedCallback removedDelegate;
+
+#if !TARGET_J2EE
+
 		FileSystemWatcher [] watchers;
 
+#endif
 		private CacheDependency ()
 		{
 		}
@@ -157,13 +161,17 @@
 				}
 			}
 
+#if !TARGET_J2EE
+
 			if (filenames.Length > 0) {
 				watchers = new FileSystemWatcher [filenames.Length];
 				for (int i=0; i<filenames.Length; i++)
 					watchers [i] = CreateWatcher (filenames [i]);
 			}
+#endif
 		}
 
+#if !TARGET_J2EE
 		private FileSystemWatcher CreateWatcher (string file)
 		{
 			FileSystemWatcher watcher = new FileSystemWatcher ();
@@ -184,6 +192,7 @@
 		{
 			OnChanged (sender, e);
 		}
+#endif
 
 		void CacheItemRemoved (string key, object value, CacheItemRemovedReason reason)
 		{
@@ -200,11 +209,17 @@
 				Changed (this, new CacheDependencyChangedArgs (null));
 		}
 
+#if TARGET_J2EE
+		public void Dispose ()
+		{
+		}
+#else
 		public void Dispose ()
 		{
 			for (int i=0; i<watchers.Length; i++)
 				watchers [i].Dispose ();
 		}
+#endif
 
 		public bool HasChanged
 		{
Index: ChangeLog
===================================================================
--- ChangeLog	(revision 45568)
+++ ChangeLog	(working copy)
@@ -1,3 +1,9 @@
+2005-06-08 Ilya Kharmatsky <ilyak-at-mainsoft.com>
+	
+	* CacheDependency.cs - added TARGET_JVM directives in places,
+	  where file watching is using (Mainsoft's implementation currently
+	  doesn't support the feature).
+	  
 2005-05-09 Gonzalo Paniagua Javier <gonzalo@ximian.com>
 
 	* CacheEntry.cs: credits for this patch should go to mcs. it catched
