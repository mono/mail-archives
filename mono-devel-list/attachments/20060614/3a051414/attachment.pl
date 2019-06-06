Index: appdomain.c
===================================================================
--- appdomain.c (revision 61712)
+++ appdomain.c (working copy)
@@ -496,12 +496,8 @@

        mono_context_init (data);

-       /* The new appdomain should have all assemblies loaded */
-       mono_domain_assemblies_lock (domain);
-       /*g_print ("copy assemblies from domain %p (%s)\n", domain, domain->friendly_name);*/
-       for (tmp = domain->domain_assemblies; tmp; tmp = tmp->next)
-               add_assemblies_to_domain (data, tmp->data, NULL);
-       mono_domain_assemblies_unlock (domain);
+       /* Load only the corlib into the new domain */
+       add_assemblies_to_domain (data, mono_defaults.corlib->assembly, NULL);

        return ad;
 }