Index: src/mod_mono.c
===================================================================
--- src/mod_mono.c	(revision 57897)
+++ src/mod_mono.c	(working copy)
@@ -82,6 +82,9 @@
 	char auto_app_set;
 } module_cfg;
 
+static int
+restart_xsp (request_rec *r, module_cfg *config, char *alias);
+
 /* */
 static int
 search_for_alias (const char *alias, module_cfg *config)
@@ -790,6 +793,11 @@
 {
 	return apr_pstrcat (pool, base, "_", alias == NULL ? "default" : alias, NULL);
 }
+static char *
+get_default_socket_lock_name (apr_pool_t *pool, const char *alias, const char *base)
+{
+	return apr_pstrcat (pool, base, "_", alias == NULL ? "default" : alias, ".mutex", NULL);
+}
 
 static apr_status_t 
 try_connect (xsp_data *conf, apr_socket_t **sock, apr_pool_t *pool)
@@ -1387,14 +1395,21 @@
 #endif
 	rv = setup_socket (&sock, &config->servers [idx], r->pool);
 	DEBUG_PRINT (2, "After setup_socket");
-	if (rv != APR_SUCCESS)
+	if (rv != APR_SUCCESS) {
+		/* recoverable? */
+		if (rv == -1) {
+			restart_xsp (r, config, config->servers [idx].alias);
+		}
+		apr_table_addn (r->headers_out, "Retry-After", "10");
 		return HTTP_SERVICE_UNAVAILABLE;
+	}
 
 	DEBUG_PRINT (2, "Sending init data");
 	if (send_initial_data (r, sock, auto_app) != 0) {
 		int err = errno;
 		DEBUG_PRINT (1, "%d: %s", err, strerror (err));
 		apr_socket_close (sock);
+		apr_table_addn (r->headers_out, "Retry-After", "10");
 		return HTTP_SERVICE_UNAVAILABLE;
 	}
 	
@@ -1611,6 +1626,23 @@
 }
 
 static int
+restart_xsp (request_rec *r, module_cfg *config, char *alias)
+{
+    	char *mutex = get_default_socket_lock_name (r->pool,
+		alias ? alias : "global", SOCKET_FILE);
+
+	int fd = open (mutex, O_CREAT|O_EXCL, S_IRUSR|S_IWUSR);
+	if (fd == -1) return FALSE;
+
+	terminate_xsp2 (r->server, alias); 
+	start_xsp (config, 1, alias);
+	close (fd);
+	unlink (mutex);
+
+	return TRUE;
+}
+
+static int
 mono_control_panel_handler (request_rec *r)
 {
 	module_cfg *config;
@@ -1654,8 +1686,9 @@
 			char *alias = uri->query + 8; /* +8 == .Substring(8) */
 			if (!strcmp (alias, "ALL"))
 				alias = NULL;
-			terminate_xsp2 (r->server, alias); 
-			start_xsp (config, 1, alias);
+
+			restart_xsp (r, config, alias);
+
 			request_send_response_string (r, "<div style=\"text-align: center;\">mod-mono-server processes restarted.</div><br>\n");
 		} else {
 			/* Invalid command. */
