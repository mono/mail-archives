Index: marshal.c
===================================================================
RCS file: /mono/mono/mono/metadata/marshal.c,v
retrieving revision 1.209
diff -u -p -r1.209 marshal.c
--- marshal.c	18 Oct 2004 22:22:49 -0000	1.209
+++ marshal.c	19 Oct 2004 18:52:06 -0000
@@ -218,11 +218,13 @@ delegate_hash_table_add (MonoDelegate *d
 MonoDelegate*
 mono_ftnptr_to_delegate (MonoClass *klass, gpointer ftn)
 {
+	MonoDelegate *d;
+	
 	EnterCriticalSection (&marshal_mutex);
 	if (delegate_hash_table == NULL)
 		delegate_hash_table = delegate_hash_table_new ();
 
-	MonoDelegate *d = g_hash_table_lookup (delegate_hash_table, ftn);
+	d = g_hash_table_lookup (delegate_hash_table, ftn);
 	LeaveCriticalSection (&marshal_mutex);
 	if (d == NULL)
 		mono_raise_exception (mono_get_exception_argument (NULL, "Additional information: Function pointer was not created by a delegate."));
