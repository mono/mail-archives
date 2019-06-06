*** wrapper/wrapper.c	Mon Apr 26 15:14:27 2004
--- wrapper/wrapper_new.c	Tue Nov  2 07:34:29 2004
***************
*** 3,8 ****
--- 3,9 ----
  #include <mono/metadata/verify.h>
  #include <mono/metadata/threads.h>
  #include <mono/metadata/mono-debug.h>
+ #include <mono/metadata/mono-debug-debugger.h>
  #define IN_MONO_DEBUGGER
  #include <mono/private/libgc-mono-debugger.h>
  #include <unistd.h>
***************
*** 118,124 ****
  {
  	MonoClass *klass = GUINT_TO_POINTER ((guint32) value);
  	MonoVTable *vtable = mono_class_vtable (mono_domain_get (), klass);
! 	return GPOINTER_TO_UINT (vtable->data);
  }
  
  static void
--- 119,125 ----
  {
  	MonoClass *klass = GUINT_TO_POINTER ((guint32) value);
  	MonoVTable *vtable = mono_class_vtable (mono_domain_get (), klass);
! 	return mono_vtable_get_static_field_data(vtable);
  }
  
  static void
***************
*** 130,135 ****
--- 131,137 ----
  		break;
  
  	case MONO_DEBUGGER_EVENT_BREAKPOINT:
+ 	case MONO_DEBUGGER_EVENT_UNHANDLED_EXCEPTION:
  		mono_debugger_notification_function (NOTIFICATION_JIT_BREAKPOINT, data, arg);
  		break;
  	}
***************
*** 200,206 ****
  {
  	MainThreadArgs main_args;
  	MonoAssembly *assembly;
! 
  	initialize_debugger_support ();
  
  	mono_debugger_init_icalls ();
--- 202,209 ----
  {
  	MainThreadArgs main_args;
  	MonoAssembly *assembly;
! 	MonoImage    *image;
! 	
  	initialize_debugger_support ();
  
  	mono_debugger_init_icalls ();
***************
*** 222,229 ****
  	 * Get and compile the main function.
  	 */
  
  	debugger_main_method = mono_get_method (
! 		assembly->image, mono_image_get_entry_point (assembly->image), NULL);
  	MONO_DEBUGGER__manager.main_function = mono_compile_method (debugger_main_method);
  
  	/*
--- 225,233 ----
  	 * Get and compile the main function.
  	 */
  
+ 	image = mono_assembly_get_image(assembly);
  	debugger_main_method = mono_get_method (
! 		image, mono_image_get_entry_point (image), NULL);
  	MONO_DEBUGGER__manager.main_function = mono_compile_method (debugger_main_method);
  
  	/*
