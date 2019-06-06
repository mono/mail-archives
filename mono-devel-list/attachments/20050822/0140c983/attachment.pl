Index: threads.c
===================================================================
--- threads.c	(revision 48630)
+++ threads.c	(working copy)
@@ -823,6 +823,43 @@
 	mono_monitor_exit (this->synch_lock);
 }
 
+MonoObject*
+ves_icall_System_Threading_Thread_GetCachedCurrentRegion (MonoThread *this)
+{
+	MonoObject *res;
+	MonoDomain *domain;
+	int i;
+
+	/* No need to lock here */
+	if (this->region_info) {
+		domain = mono_domain_get ();
+		res = this->region_info;
+		if (res && res->vtable->domain == domain)
+			return res;
+	}
+
+	return NULL;
+}
+
+void
+ves_icall_System_Threading_Thread_SetCachedCurrentRegion (MonoThread *this, MonoObject *region)
+{
+	int i;
+	MonoDomain *domain = mono_domain_get ();
+
+	mono_monitor_enter (this->synch_lock);
+
+	if (this->region_info) {
+		if (this->region_info->vtable->domain == domain)
+			/* Replace */
+			this->region_info = region;
+	}
+	else
+		/* Free entry */
+		this->region_info = region;
+	mono_monitor_exit (this->synch_lock);
+}
+
 /* the jit may read the compiled code of this function */
 MonoThread *
 mono_thread_current (void)
Index: object-internals.h
===================================================================
--- object-internals.h	(revision 48630)
+++ object-internals.h	(working copy)
@@ -223,6 +223,7 @@
 	HANDLE	    handle;
 	MonoObject **culture_info;
 	MonoObject **ui_culture_info;
+	MonoObject *region_info;
 	MonoBoolean threadpool_thread;
 	gunichar2  *name;
 	guint32	    name_len;
Index: threads-types.h
===================================================================
--- threads-types.h	(revision 48630)
+++ threads-types.h	(working copy)
@@ -48,6 +48,8 @@
 extern MonoArray* ves_icall_System_Threading_Thread_GetSerializedCurrentUICulture (MonoThread *this_obj);
 extern void ves_icall_System_Threading_Thread_SetCachedCurrentUICulture (MonoThread *this_obj, MonoObject *culture);
 void ves_icall_System_Threading_Thread_SetSerializedCurrentUICulture (MonoThread *this_obj, MonoArray *arr);
+extern MonoObject* ves_icall_System_Threading_Thread_GetCachedCurrentRegion (MonoThread *this_obj);
+extern void ves_icall_System_Threading_Thread_SetCachedCurrentRegion (MonoThread *this_obj, MonoObject *culture);
 extern HANDLE ves_icall_System_Threading_Mutex_CreateMutex_internal(MonoBoolean owned, MonoString *name, MonoBoolean *created);
 extern void ves_icall_System_Threading_Mutex_ReleaseMutex_internal (HANDLE handle );
 extern HANDLE ves_icall_System_Threading_Events_CreateEvent_internal (MonoBoolean manual, MonoBoolean initial, MonoString *name);
Index: icall.c
===================================================================
--- icall.c	(revision 48630)
+++ icall.c	(working copy)
@@ -6884,6 +6884,7 @@
 	{"ClrState", ves_icall_System_Threading_Thread_ClrState},
 	{"CurrentThread_internal", mono_thread_current},
 	{"GetCachedCurrentCulture", ves_icall_System_Threading_Thread_GetCachedCurrentCulture},
+	{"GetCachedCurrentRegion", ves_icall_System_Threading_Thread_GetCachedCurrentRegion},
 	{"GetCachedCurrentUICulture", ves_icall_System_Threading_Thread_GetCachedCurrentUICulture},
 	{"GetDomainID", ves_icall_System_Threading_Thread_GetDomainID},
 	{"GetName_internal", ves_icall_System_Threading_Thread_GetName_internal},
@@ -6894,6 +6895,7 @@
 	{"ResetAbort_internal()", ves_icall_System_Threading_Thread_ResetAbort},
 	{"Resume_internal()", ves_icall_System_Threading_Thread_Resume},
 	{"SetCachedCurrentCulture", ves_icall_System_Threading_Thread_SetCachedCurrentCulture},
+	{"SetCachedCurrentRegion", ves_icall_System_Threading_Thread_SetCachedCurrentRegion},
 	{"SetCachedCurrentUICulture", ves_icall_System_Threading_Thread_SetCachedCurrentUICulture},
 	{"SetName_internal", ves_icall_System_Threading_Thread_SetName_internal},
 	{"SetSerializedCurrentCulture", ves_icall_System_Threading_Thread_SetSerializedCurrentCulture},
