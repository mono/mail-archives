Index: mod_mono.c
===================================================================
--- mod_mono.c	(Revision 52943)
+++ mod_mono.c	(Arbeitskopie)
@@ -82,6 +82,8 @@
 	char auto_app_set;
 } module_cfg;
 
+static void start_xsp (module_cfg *config, int is_restart, char *alias);
+
 /* */
 static int
 search_for_alias (const char *alias, module_cfg *config)
@@ -1374,6 +1376,10 @@
 #ifdef APACHE13
 	sock = apr_pcalloc (r->pool, sizeof (apr_socket_t));
 #endif
+
+	if (config->servers [idx].status == FORK_NONE)
+		 start_xsp (config, 0, NULL);
+
 	rv = setup_socket (&sock, &config->servers [idx], r->pool);
 	DEBUG_PRINT (2, "After setup_socket");
 	if (rv != APR_SUCCESS)
@@ -1539,6 +1545,7 @@
 			/* Give some time for clean up */
 			fork_mod_mono_server (pconf, xsp);
 			xsp->status = FORK_SUCCEEDED;
+			continue;
 		}
 	}
 }
@@ -1717,8 +1724,6 @@
 
 	DEBUG_PRINT (0, "Mono Child Init");
 	config = ap_get_module_config (s->module_config, &mono_module);
-
-	start_xsp (config, 0, NULL);
 }
 
 #ifdef APACHE13
