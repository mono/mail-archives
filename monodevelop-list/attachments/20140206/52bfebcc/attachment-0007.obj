--- extras/MonoDevelop.Profiling/MonoDevelop.Profiling/ProfilingService.cs.orig	2014-01-24 14:21:19.863807026 -0600
+++ extras/MonoDevelop.Profiling/MonoDevelop.Profiling/ProfilingService.cs	2014-01-24 14:21:50.284143562 -0600
@@ -66,7 +66,7 @@
 			stateHandler = new ProfilerStateEventHandler (HandleStateChanged);
 			snapshotFailedHandler = new EventHandler (HandleSnapshotFailed);
 			
-			string configFile = Path.Combine (PropertyService.Locations.Config, "MonoDevelop.Profiling.xml");
+			string configFile = UserProfile.Current.ConfigDir.Combine("MonoDevelop.Profiling.xml");
 			profilingSnapshots = new ProfilingSnapshotCollection (configFile);
 			profilingSnapshots.Load ();
 		}
