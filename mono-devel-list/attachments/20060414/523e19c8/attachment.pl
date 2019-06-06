Index: locales.c
===================================================================
--- locales.c	(revision 59305)
+++ locales.c	(working copy)
@@ -21,6 +21,7 @@
 #include <mono/metadata/locales.h>
 #include <mono/metadata/culture-info.h>
 #include <mono/metadata/culture-info-tables.h>
+#include <mono/metadata/normalization-tables.h>
 
 
 #include <locale.h>
@@ -938,3 +939,19 @@
 	}
 }
 
+void load_normalization_resource (guint8 **argProps,
+				  guint8 **argMappedChars,
+				  guint8 **argCharMapIndex,
+				  guint8 **argHelperIndex,
+				  guint8 **argMapIdxToComposite,
+				  guint8 **argCombiningClass)
+{
+	*argProps = props;
+	*argMappedChars = (guint8*) mappedChars;
+	*argCharMapIndex = (guint8*) charMapIndex;
+	*argHelperIndex = (guint8*) helperIndex;
+	*argMapIdxToComposite = (guint8*) mapIdxToComposite;
+	*argCombiningClass = combiningClass;
+}
+
+
Index: locales.h
===================================================================
--- locales.h	(revision 59305)
+++ locales.h	(working copy)
@@ -52,5 +52,6 @@
 extern MonoString *ves_icall_System_String_InternalToUpper_Comp (MonoString *this, MonoCultureInfo *cult);
 extern gunichar2 ves_icall_System_Char_InternalToUpper_Comp (gunichar2 c, MonoCultureInfo *cult);
 extern gunichar2 ves_icall_System_Char_InternalToLower_Comp (gunichar2 c, MonoCultureInfo *cult);
+extern void load_normalization_resource (guint8 **argProps, guint8** argMappedChars, guint8** argCharMapIndex, guint8** argHelperIndex, guint8** argMapIdxToComposite, guint8** argCombiningClass);
 
 #endif /* _MONO_METADATA_FILEIO_H_ */
Index: icall.c
===================================================================
--- icall.c	(revision 59305)
+++ icall.c	(working copy)
@@ -6547,6 +6547,10 @@
 	{"internal_index(string,int,int,string,System.Globalization.CompareOptions,bool)", ves_icall_System_Globalization_CompareInfo_internal_index}
 };
 
+static const IcallEntry normalization_icalls [] = {
+	{"load_normalization_resource(intptr&,intptr&,intptr&,intptr&,intptr&,intptr&)", load_normalization_resource}
+};
+
 static const IcallEntry gc_icalls [] = {
 	{"GetTotalMemory", ves_icall_System_GC_GetTotalMemory},
 	{"InternalCollect", ves_icall_System_GC_InternalCollect},
@@ -7226,6 +7230,7 @@
 
 /* keep the entries all sorted */
 static const IcallMap icall_entries [] = {
+	{"Mono.Globalization.Unicode.Normalization", normalization_icalls, G_N_ELEMENTS (normalization_icalls)},
 	{"Mono.Runtime", runtime_icalls, G_N_ELEMENTS (runtime_icalls)},
 	{"Mono.Security.Cryptography.KeyPairPersistence", keypair_icalls, G_N_ELEMENTS (keypair_icalls)},
 	{"System.Activator", activator_icalls, G_N_ELEMENTS (activator_icalls)},
Index: Makefile.am
===================================================================
--- Makefile.am	(revision 59305)
+++ Makefile.am	(working copy)
@@ -91,6 +91,7 @@
 	environment.h	\
 	locales.c	\
 	locales.h	\
+	normalization-tables.h	\
 	filewatcher.c	\
 	filewatcher.h	\
 	culture-info.h  \