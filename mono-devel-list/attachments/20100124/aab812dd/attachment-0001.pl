Index: metadata/domain.c
===================================================================
--- metadata/domain.c	(revision 150087)
+++ metadata/domain.c	(working copy)
@@ -128,9 +128,6 @@
 /* This is the list of runtime versions supported by this JIT.
  */
 static const MonoRuntimeInfo supported_runtimes[] = {
-	{"v1.0.3705", "1.0", { {1,0,5000,0}, {7,0,5000,0} }	},
-	{"v1.1.4322", "1.0", { {1,0,5000,0}, {7,0,5000,0} }	},
-	{"v2.0.50215","2.0", { {2,0,0,0},    {8,0,0,0} }	},
 	{"v2.0.50727","2.0", { {2,0,0,0},    {8,0,0,0} }	},
 	{"v4.0.21006","4.0", { {4,0,0,0},    {10,0,0,0} }   },
 	{"moonlight", "2.1", { {2,0,5,0},    {9,0,0,0} }    },
@@ -1312,8 +1309,9 @@
 		const MonoRuntimeInfo *default_runtime = get_runtime_by_version (DEFAULT_RUNTIME_VERSION);
 		runtimes [0] = default_runtime;
 		runtimes [1] = NULL;
-		g_print ("WARNING: The runtime version supported by this application is unavailable.\n");
-		g_print ("Using default runtime: %s\n", default_runtime->runtime_version); 
+		g_printerr ("WARNING: The runtime version supported by this application is unavailable.\n");
+		g_printerr ("Using default runtime: %s\n", default_runtime->runtime_version); 
+		g_printerr ("\nThis warning can be suppressed with mono's --runtime=%s option\nor by adding <startup><supportedRuntime version=\"%s\"/></startup>\nto application's configuration file (app.config).\n", default_runtime->runtime_version, default_runtime->runtime_version);
 	}
 
 	/* The selected runtime will be the first one for which there is a mscrolib.dll */
