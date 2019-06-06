Index: appdomain.c
===================================================================
--- appdomain.c	(revision 61712)
+++ appdomain.c	(working copy)
@@ -467,11 +467,9 @@
 MonoAppDomain *
 ves_icall_System_AppDomain_createDomain (MonoString *friendly_name, MonoAppDomainSetup *setup)
 {
-	MonoDomain *domain = mono_domain_get ();
 	MonoClass *adclass;
 	MonoAppDomain *ad;
 	MonoDomain *data;
-	GSList *tmp;
 	
 	MONO_ARCH_SAVE_REGS;
 
@@ -496,12 +494,8 @@
 
 	mono_context_init (data);
 
-	/* The new appdomain should have all assemblies loaded */
-	mono_domain_assemblies_lock (domain);
-	/*g_print ("copy assemblies from domain %p (%s)\n", domain, domain->friendly_name);*/
-	for (tmp = domain->domain_assemblies; tmp; tmp = tmp->next)
-		add_assemblies_to_domain (data, tmp->data, NULL);
-	mono_domain_assemblies_unlock (domain);
+	/* Load only the corlib into the new domain */
+	add_assemblies_to_domain (data, mono_defaults.corlib->assembly, NULL);
 
 	return ad;
 }
