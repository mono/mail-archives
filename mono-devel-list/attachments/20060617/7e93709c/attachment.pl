Index: mcs/class/corlib/System.Runtime.Remoting.Messaging/CADMessages.cs
===================================================================
--- mcs/class/corlib/System.Runtime.Remoting.Messaging/CADMessages.cs	(revision 61823)
+++ mcs/class/corlib/System.Runtime.Remoting.Messaging/CADMessages.cs	(working copy)
@@ -51,19 +51,19 @@
 	
 	internal class CADObjRef {
 		ObjRef objref;
-		public int SourceDomain;
+		int _sourceDomain;
 
 		public CADObjRef (ObjRef o, int sourceDomain) {
 			objref = o;
-			SourceDomain = sourceDomain;
+			_sourceDomain = sourceDomain;
 		}
-		
-		public string TypeName {
-			get { return objref.TypeInfo.TypeName; }
+
+		public ObjRef ObjRef {
+			get { return objref; }
 		}
-		
-		public string URI {
-			get { return objref.URI; }
+
+		public int SourceDomain {
+			get { return _sourceDomain; }
 		}
 	}
 
@@ -170,12 +170,8 @@
 
 			CADObjRef objref = arg as CADObjRef;
 			if (null != objref) {
-				string typeName = string.Copy (objref.TypeName);
-				string uri = string.Copy (objref.URI);
-				int domid = objref.SourceDomain;
-				
-				ChannelInfo cinfo = new ChannelInfo (new CrossAppDomainData (domid));
-				ObjRef localRef = new ObjRef (typeName, uri, cinfo);
+				ChannelInfo cinfo = new ChannelInfo (new CrossAppDomainData (objref.SourceDomain));
+				ObjRef localRef = new ObjRef (objref.ObjRef, cinfo);
 				return RemotingServices.Unmarshal (localRef);
 			}
 			
Index: mcs/class/corlib/System.Runtime.Remoting/ChangeLog
===================================================================
--- mcs/class/corlib/System.Runtime.Remoting/ChangeLog	(revision 61823)
+++ mcs/class/corlib/System.Runtime.Remoting/ChangeLog	(working copy)
@@ -1,3 +1,9 @@
+2006-06-17  Brian Crowell  <brian@fluggo.com>
+	
+	* CADMessages.cs: Fixed the use of CADObjRef. The ObjRef is capable of
+	serializing itself, so there should be no need to re-derive its
+	properties on the other end.
+
 2006-04-27  Robert Jordan  <robertj@gmx.net>
 
 	* RemotingServices.cs (IsObjectOutOfAppDomain, IsObjectOutOfContext):
Index: mcs/class/corlib/System.Runtime.Remoting/TypeInfo.cs
===================================================================
--- mcs/class/corlib/System.Runtime.Remoting/TypeInfo.cs	(revision 61823)
+++ mcs/class/corlib/System.Runtime.Remoting/TypeInfo.cs	(working copy)
@@ -42,6 +42,9 @@
 
 		public TypeInfo(Type type)
 		{
+			if (type == null)
+				throw new ArgumentNullException( "type" );
+		
 			if (type.IsInterface)
 			{
 				serverType = typeof (MarshalByRefObject).AssemblyQualifiedName;
Index: mcs/class/corlib/System.Runtime.Remoting/ObjRef.cs
===================================================================
--- mcs/class/corlib/System.Runtime.Remoting/ObjRef.cs	(revision 61823)
+++ mcs/class/corlib/System.Runtime.Remoting/ObjRef.cs	(working copy)
@@ -65,11 +65,13 @@
 			UpdateChannelInfo();
 		}
 
-		internal ObjRef (string typeName, string uri, IChannelInfo cinfo) 
+		internal ObjRef (ObjRef o, IChannelInfo cinfo) 
 		{
-			this.uri = uri;
+			uri = o.uri;
+			typeInfo = o.typeInfo;
+			envoyInfo = o.envoyInfo;
+			flags = o.flags;
 			channel_info = cinfo;
-			typeInfo = new TypeInfo (Type.GetType (typeName));
 		}
 
 		internal ObjRef (ObjRef o, bool unmarshalAsProxy) {
Index: mono/mono/metadata/appdomain.c
===================================================================
--- mono/mono/metadata/appdomain.c	(revision 61823)
+++ mono/mono/metadata/appdomain.c	(working copy)
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
Index: mono/mono/metadata/ChangeLog
===================================================================
--- mono/mono/metadata/ChangeLog	(revision 61823)
+++ mono/mono/metadata/ChangeLog	(working copy)
@@ -1,3 +1,20 @@
+2006-06-17  Brian Crowell  <brian@fluggo.com>
+
+	* appdomain.c (ves_icall_System_AppDomain_createDomain): Only one assembly
+	  should be present in a newly-created domain, and that's the corlib.
+	  Fixes #76757. Be on the lookout for code that relies on this bug.
+	  
+	* marshal.c (mono_marshal_get_xappdomain_invoke): This function and related
+	  functions make many assumptions about the equivalence of types and method
+	  bodies in different domains. I started to modify the code to find types
+	  correctly, but I saw it was just easier to disable that branch and send
+	  cross-domain calls through the normal CrossAppDomainChannel. If anyone
+	  wants to attempt repairs someday, they would do well to borrow the type
+	  comparison code from metadata.c and modify
+	  mono_marshal_emit_load_domain_method to find its target by name instead of
+	  by pointer. I started on that and you can find my proposed changes in the
+	  mono-devel list.
+
 2006-06-15  Zoltan Varga  <vargaz@gmail.com>
 
 	* marshal.c (mono_ftnptr_to_delegate): Avoid allocating signature from mempool
Index: mono/mono/metadata/marshal.c
===================================================================
--- mono/mono/metadata/marshal.c	(revision 61823)
+++ mono/mono/metadata/marshal.c	(working copy)
@@ -15,6 +15,7 @@
 #include "metadata/tabledefs.h"
 #include "metadata/exception.h"
 #include "metadata/appdomain.h"
+#include "metadata/assembly.h"
 #include "mono/metadata/debug-helpers.h"
 #include "mono/metadata/threadpool.h"
 #include "mono/metadata/threads.h"
@@ -2766,6 +2767,7 @@
 	return NULL;
 }
 
+#if UNUSED
 /* mono_marshal_xdomain_copy_out_value()
  * Copies the contents of the src instance into the dst instance. src and dst
  * must have the same type, and if they are arrays, the same size.
@@ -2828,7 +2830,9 @@
 	return !method->klass->contextbound &&
 		   !((method->flags & METHOD_ATTRIBUTE_SPECIAL_NAME) && (strcmp (".ctor", method->name) == 0));
 }
+#endif
 
+#if UNUSED
 static gint32
 mono_marshal_set_domain_by_id (gint32 id, MonoBoolean push)
 {
@@ -3137,6 +3141,7 @@
 
 	return res;
 }
+#endif
 
 /* mono_marshal_get_xappdomain_invoke ()
  * Generates a fast remoting wrapper for cross app domain calls.
@@ -3147,14 +3152,15 @@
 	MonoMethodSignature *sig;
 	MonoMethodBuilder *mb;
 	MonoMethod *res;
-	int i, j, complex_count, complex_out_count, copy_locals_base;
+	/* int i, j, complex_count, complex_out_count, copy_locals_base; */
+	int i, complex_count, complex_out_count;
 	int *marshal_types;
 	MonoClass *ret_class = NULL;
-	MonoMethod *xdomain_method;
+	/* MonoMethod *xdomain_method; */
 	int ret_marshal_type = MONO_MARSHAL_NONE;
 	int loc_array=0, loc_serialized_data=-1, loc_real_proxy;
 	int loc_old_domainid, loc_return=0, loc_serialized_exc=0, loc_context;
-	int pos, pos_noex;
+	/* int pos, pos_noex; */
 	gboolean copy_return = FALSE;
 
 	g_assert (method);
@@ -3217,6 +3223,10 @@
 	loc_serialized_exc = mono_mb_add_local (mb, &byte_array_class->byval_arg);
 	loc_context = mono_mb_add_local (mb, &mono_defaults.object_class->byval_arg);
 
+#if UNUSED
+	/* The CrossAppDomainChannel takes care of this when it's used; otherwise
+	   the unused code in the alternate branch below needs it */
+
 	/* Save thread domain data */
 
 	mono_mb_emit_icall (mb, mono_context_get);
@@ -3230,6 +3240,7 @@
 	mono_mb_emit_byte (mb, CEE_BRFALSE_S);
 	pos = mb->pos;
 	mono_mb_emit_byte (mb, 0);
+#endif
 	
 	mono_mb_emit_ldarg (mb, 0);
 	for (i = 0; i < sig->param_count; i++)
@@ -3237,6 +3248,8 @@
 	
 	mono_mb_emit_managed_call (mb, mono_marshal_get_remoting_invoke (method), NULL);
 	mono_mb_emit_byte (mb, CEE_RET);
+
+#ifdef UNUSED
 	mono_mb_patch_addr_s (mb, pos, mb->pos - pos - 1);
 
 	/* Create the array that will hold the parameters to be serialized */
@@ -3460,6 +3473,7 @@
 	}
 
 	mono_mb_emit_byte (mb, CEE_RET);
+#endif
 
 	res = mono_remoting_mb_create_and_cache (method, mb, sig, sig->param_count + 16);
 	mono_mb_free (mb);
