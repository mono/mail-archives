17a18
> #include "metadata/assembly.h"
2491a2493,2738
> /* The following functions are stolen from metadata.c. They have been modified to consider
>  * equality based on name.
>  *
>  * Note that, especially in generic cases, these functions don't do all the correct comparisons
>  * because of assumptions about pointers. These were present in the originals.
>  */
> 
> static gboolean mono_marshal_class_equal (MonoClass *, MonoClass *);
> static gboolean do_mono_marshal_type_equal (MonoType *, MonoType *);
> 
> static gboolean
> _mono_marshal_generic_class_equal (const MonoGenericClass *g1, const MonoGenericClass *g2)
> {
> 	int i;
> 
> 	if ((g1->inst->type_argc != g2->inst->type_argc) || (g1->is_dynamic != g2->is_dynamic) ||
> 	    (g1->inst->is_reference != g2->inst->is_reference))
> 		return FALSE;
> 	if (!mono_marshal_class_equal (g1->container_class, g2->container_class))
> 		return FALSE;
> 	for (i = 0; i < g1->inst->type_argc; ++i) {
> 		if (!do_mono_marshal_type_equal (g1->inst->type_argv [i], g2->inst->type_argv [i]))
> 			return FALSE;
> 	}
> 	return TRUE;
> }
> 
> static gboolean
> mono_marshal_generic_method_equal (MonoGenericMethod *g1, MonoGenericMethod *g2)
> {
> 	return (g1->container == g2->container) && (g1->generic_class == g2->generic_class) &&
> 		(g1->inst == g2->inst);
> }
> 
> static gboolean
> mono_marshal_generic_param_equal (MonoGenericParam *p1, MonoGenericParam *p2)
> {
> 	if (p1 == p2)
> 		return TRUE;
> 	if (p1->num != p2->num)
> 		return FALSE;
> 
> 	if (p1->owner == p2->owner)
> 		return TRUE;
> 
> 	return FALSE;
> }
> 
> static gboolean
> mono_marshal_class_equal (MonoClass *c1, MonoClass *c2)
> {
> 	if (c1 == c2)
> 		return TRUE;
> 
> 	if (!strcmp (c1->name, c2->name))
> 		return TRUE;
> 		
> 	if (c1->generic_class && c2->generic_class)
> 		return _mono_marshal_generic_class_equal (c1->generic_class, c2->generic_class);
> 	if ((c1->byval_arg.type == MONO_TYPE_VAR) && (c2->byval_arg.type == MONO_TYPE_VAR))
> 		return mono_marshal_generic_param_equal (
> 			c1->byval_arg.data.generic_param, c2->byval_arg.data.generic_param);
> 	if ((c1->byval_arg.type == MONO_TYPE_MVAR) && (c2->byval_arg.type == MONO_TYPE_MVAR))
> 		return mono_marshal_generic_param_equal (
> 			c1->byval_arg.data.generic_param, c2->byval_arg.data.generic_param);
> 	if ((c1->byval_arg.type == MONO_TYPE_SZARRAY) && (c2->byval_arg.type == MONO_TYPE_SZARRAY))
> 		return mono_marshal_class_equal (c1->byval_arg.data.klass, c2->byval_arg.data.klass);
> 	return FALSE;
> }
> 
> /*
>  * mono_marshal_type_equal:
>  * @t1: a type
>  * @t2: another type
>  *
>  * Determine if @t1 and @t2 represent the same type (or close enough for remoting purposes).
>  * Returns: #TRUE if @t1 and @t2 are equal.
>  */
> static gboolean
> do_mono_marshal_type_equal (MonoType *t1, MonoType *t2)
> {
> 	if (t1->type != t2->type || t1->byref != t2->byref)
> 		return FALSE;
> 
> 	switch (t1->type) {
> 	case MONO_TYPE_VOID:
> 	case MONO_TYPE_BOOLEAN:
> 	case MONO_TYPE_CHAR:
> 	case MONO_TYPE_I1:
> 	case MONO_TYPE_U1:
> 	case MONO_TYPE_I2:
> 	case MONO_TYPE_U2:
> 	case MONO_TYPE_I4:
> 	case MONO_TYPE_U4:
> 	case MONO_TYPE_I8:
> 	case MONO_TYPE_U8:
> 	case MONO_TYPE_R4:
> 	case MONO_TYPE_R8:
> 	case MONO_TYPE_STRING:
> 	case MONO_TYPE_I:
> 	case MONO_TYPE_U:
> 	case MONO_TYPE_OBJECT:
> 	case MONO_TYPE_TYPEDBYREF:
> 		return TRUE;
> 	case MONO_TYPE_VALUETYPE:
> 	case MONO_TYPE_CLASS:
> 	case MONO_TYPE_SZARRAY:
> 		return mono_marshal_class_equal (t1->data.klass, t2->data.klass);
> 	case MONO_TYPE_PTR:
> 		return do_mono_marshal_type_equal (t1->data.type, t2->data.type);
> 	case MONO_TYPE_ARRAY:
> 		if (t1->data.array->rank != t2->data.array->rank)
> 			return FALSE;
> 		return mono_marshal_class_equal (t1->data.array->eklass, t2->data.array->eklass);
> 	case MONO_TYPE_GENERICINST:
> 		return _mono_marshal_generic_class_equal (
> 			t1->data.generic_class, t2->data.generic_class);
> 	case MONO_TYPE_VAR:
> 		return mono_marshal_generic_param_equal (
> 			t1->data.generic_param, t2->data.generic_param);
> 	case MONO_TYPE_MVAR:
> 		return mono_marshal_generic_param_equal (
> 			t1->data.generic_param, t2->data.generic_param);
> 	default:
> 		g_error ("implement type compare for %0x!", t1->type);
> 		return FALSE;
> 	}
> 
> 	return FALSE;
> }
> 
> /**
>  * mono_marshal_signature_equal:
>  * @sig1: a signature
>  * @sig2: another signature
>  *
>  * Determine if @sig1 and @sig2 represent the same signature, with the
>  * same number of arguments and the same types.
>  * Returns: #TRUE if @sig1 and @sig2 are equal.
>  */
> static gboolean
> mono_marshal_signature_equal (MonoMethodSignature *sig1, MonoMethodSignature *sig2)
> {
> 	int i;
> 
> 	if (sig1->hasthis != sig2->hasthis || sig1->param_count != sig2->param_count) {
> 		printf( "sig1: %s %d\nsig2: %s %d", sig1->hasthis ? "hasthis" : "nohasthis",
> 			sig1->param_count, sig2->hasthis ? "hasthis" : "nohasthis", sig2->param_count );
> 	
> 		return FALSE;
> 	}
> 
> 	/*
> 	 * We're just comparing the signatures of two methods here:
> 	 *
> 	 * If we have two generic methods `void Foo<U> (U u)' and `void Bar<V> (V v)',
> 	 * U and V are equal here.
> 	 *
> 	 * That's what the `signature_only' argument of do_mono_metadata_type_equal() is for.
> 	 */
> 
> 	for (i = 0; i < sig1->param_count; i++) { 
> 		MonoType *p1 = sig1->params[i];
> 		MonoType *p2 = sig2->params[i];
> 		
> 		/* if (p1->attrs != p2->attrs)
> 			return FALSE;
> 		*/
> 		if (!do_mono_marshal_type_equal (p1, p2)) {
> 			printf( "Parameter pair %d failed the check.\n", i );
> 			return FALSE;
> 		}
> 	}
> 
> 	if (!do_mono_marshal_type_equal (sig1->ret, sig2->ret)) {
> 		printf( "Return value failed the check.\n" );
> 		return FALSE;
> 	}
> 	
> 	return TRUE;
> }
> 
> static gpointer
> mono_marshal_find_domainlocal_method (MonoMethod *method)
> {
> 	MonoAssembly *targetAssem;
> 	MonoMethodSignature *sig;
> 	MonoException *ex;
> 	MonoClass *klass;
> 	char *tmp;
> 	int i;
> 
> 	g_assert (method != NULL);
> 
> 	targetAssem = mono_assembly_load (&method->klass->image->assembly->aname, NULL, NULL);
> 
> 	if (!targetAssem) {
> 		mono_raise_exception (mono_get_exception_file_not_found (mono_string_new_wrapper (method->klass->image->assembly->aname.name)));
> 	}
> 
> 	printf( "Resolved to assembly %s\n", targetAssem->aname.name );
> 	printf( "Method in %s.%s\n", method->klass->name_space, method->klass->name );
> 	klass = mono_class_from_name (targetAssem->image, method->klass->name_space, method->klass->name);
> 	
> 	if (!klass) {
> 		char *tmp2;
> 		printf( "Preparing TypeLoadException...\n" );
> 
> 		tmp = g_strdup (method->klass->image->assembly->aname.name);
> 		tmp2 = g_strdup_printf ("%s.%s", method->klass->name_space, method->klass->name);
> 		ex = mono_get_exception_type_load (mono_string_new_wrapper (tmp2), tmp);
> 		g_free (tmp);
> 		g_free (tmp2);
> 		
> 		mono_raise_exception (ex);
> 	}
> 	
> 	/* Scan the class's method table to find the equivalent method */
> 	printf( "Scanning methods and signatures...\n" );
> 	sig = signature_no_pinvoke (mono_method_signature (method));
> 	mono_class_setup_methods (klass);
> 
> 	for (i = 0; i < klass->method.count; i++) {
> 		MonoMethod *foundMethod = klass->methods [i];
> 		printf( "Checking method %d of %d (%s)\n", i + 1, klass->method.count, foundMethod->name );
> 
> 		if( mono_marshal_signature_equal (sig, mono_method_signature (foundMethod)) )
> 			printf( "Match on signature\n" );
> 		
> 		if ((method->name [0] == foundMethod->name [0]) &&
> 				!strcmp (method->name, foundMethod->name) &&
> 				mono_marshal_signature_equal (sig, mono_method_signature (foundMethod)) ) {
> 
> 			return mono_compile_method (foundMethod);
> 		}
> 	}
> 
> 	tmp = g_strdup_printf( "%s.%s", method->klass->name_space, method->klass->name );
> 	ex = mono_get_exception_missing_method (tmp, method->name);
> 	g_free (tmp);
> 	
> 	mono_raise_exception (ex);
> 
> 	return NULL;
> }
> 
2513c2760,2762
< 	mono_mb_emit_native_call (mb, csig, mono_compile_method);
---
> 	mono_mb_emit_native_call (mb, csig, mono_marshal_find_domainlocal_method);
> 
> 	/* BJC: Not done here */
2598a2848,2858
> 	/****** BJC: My additions ******/
> {
> 	MonoClass *klass = mono_class_from_name( mono_defaults.corlib, "System", "Console" );
> 	
> 	mono_mb_emit_ldstr( mb, "Target: {0}" );
> 	mono_mb_emit_ldarg (mb, 0);
> 	mono_mb_emit_managed_call (mb, method_rs_appdomain_target, NULL);
> 	mono_mb_emit_managed_call (mb, mono_class_get_method_from_name( klass, "WriteLine", 2 ), NULL);
> }
> 	printf( "xdomain-wrapper, %s, %d parameters\n", method->name, sig->param_count );
> 
2675a2936,2944
> 	/****** BJC: My additions ******/
> {
> 	MonoClass *klass = mono_class_from_name( mono_defaults.corlib, "System", "Console" );
> 	
> 	mono_mb_emit_ldstr( mb, "Checkpoint Alpha" );
> 	mono_mb_emit_byte (mb, CEE_LDNULL);
> 	mono_mb_emit_managed_call (mb, mono_class_get_method_from_name( klass, "WriteLine", 2 ), NULL);
> }
> 	
2681a2951,2958
> 	/****** BJC: My additions ******/
> {
> 	MonoClass *klass = mono_class_from_name( mono_defaults.corlib, "System", "Console" );
> 	
> 	mono_mb_emit_ldstr( mb, "Checkpoint Beta" );
> 	mono_mb_emit_byte (mb, CEE_LDNULL);
> 	mono_mb_emit_managed_call (mb, mono_class_get_method_from_name( klass, "WriteLine", 2 ), NULL);
> }
2697a2975,2982
> 	/****** BJC: My additions ******/
> {
> 	MonoClass *klass = mono_class_from_name( mono_defaults.corlib, "System", "Console" );
> 	
> 	mono_mb_emit_ldstr( mb, "Checkpoint Charlie" );
> 	mono_mb_emit_byte (mb, CEE_LDNULL);
> 	mono_mb_emit_managed_call (mb, mono_class_get_method_from_name( klass, "WriteLine", 2 ), NULL);
> }
2744a3030,3037
> 	/****** BJC: My additions ******/
> {
> 	MonoClass *klass = mono_class_from_name( mono_defaults.corlib, "System", "Console" );
> 	
> 	mono_mb_emit_ldstr( mb, "Checkpoint Delta" );
> 	mono_mb_emit_byte (mb, CEE_LDNULL);
> 	mono_mb_emit_managed_call (mb, mono_class_get_method_from_name( klass, "WriteLine", 2 ), NULL);
> }
2882c3175
< 	mono_mb_emit_native_call (mb, sig_context_get, mono_context_get);
---
> /*	mono_mb_emit_native_call (mb, sig_context_get, mono_context_get);
2884c3177
< 	mono_mb_emit_stloc (mb, loc_context);
---
> 	mono_mb_emit_stloc (mb, loc_context);*/
2889c3182
< 	mono_mb_emit_managed_call (mb, method_needs_context_sink, NULL);
---
> 	/*mono_mb_emit_managed_call (mb, method_needs_context_sink, NULL);
2892c3185
< 	mono_mb_emit_byte (mb, 0);
---
> 	mono_mb_emit_byte (mb, 0);*/
2899a3193,3194
> 
> #ifdef UNUSED
3123c3418
< 
---
> #endif
