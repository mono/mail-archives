Index: locales.c
===================================================================
--- locales.c	(revision 47945)
+++ locales.c	(working copy)
@@ -21,6 +21,7 @@
 #include <mono/metadata/locales.h>
 #include <mono/metadata/culture-info.h>
 #include <mono/metadata/culture-info-tables.h>
+#include <mono/metadata/normalization-tables.h>
 
 
 #include <locale.h>
@@ -511,6 +512,17 @@
 	return TRUE;
 }
 
+void ves_icall_Mono_Globalization_Unicode_Normalization_load_normalization_resource (guint8 **argProps, guint8** argMappedChars, guint8** argCharMapIndex, guint8** argHelperIndex, guint8** argMapIdxToComposite, guint8** argCombiningClass)
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
 #ifdef HAVE_ICU
 
 #include <unicode/utypes.h>
Index: locales.h
===================================================================
--- locales.h	(revision 47945)
+++ locales.h	(working copy)
@@ -38,6 +38,7 @@
 extern void ves_icall_System_Globalization_CompareInfo_construct_compareinfo (MonoCompareInfo *comp, MonoString *locale);
 extern int ves_icall_System_Globalization_CompareInfo_internal_compare (MonoCompareInfo *this, MonoString *str1, gint32 off1, gint32 len1, MonoString *str2, gint32 off2, gint32 len2, gint32 options);
 extern void ves_icall_System_Globalization_CompareInfo_free_internal_collator (MonoCompareInfo *this);
+extern void ves_icall_Mono_Globalization_Unicode_Normalization_load_normalization_resource (guint8 **argProps, guint8** argMappedChars, guint8** argCharMapIndex, guint8** argHelperIndex, guint8** argMapIdxToComposite, guint8** argCombiningClass);
 extern void ves_icall_System_Globalization_CompareInfo_assign_sortkey (MonoCompareInfo *this, MonoSortKey *key, MonoString *source, gint32 options);
 extern int ves_icall_System_Globalization_CompareInfo_internal_index (MonoCompareInfo *this, MonoString *source, gint32 sindex, gint32 count, MonoString *value, gint32 options, MonoBoolean first);
 extern int ves_icall_System_Globalization_CompareInfo_internal_index_char (MonoCompareInfo *this, MonoString *source, gint32 sindex, gint32 count, gunichar2 value, gint32 options, MonoBoolean first);
Index: icall.c
===================================================================
--- icall.c	(revision 47945)
+++ icall.c	(working copy)
@@ -6332,6 +6332,10 @@
 	{"internal_index(string,int,int,string,System.Globalization.CompareOptions,bool)", ves_icall_System_Globalization_CompareInfo_internal_index}
 };
 
+static const IcallEntry normalization_icalls [] = {
+	{"load_normalization_resource(byte**,byte**,byte**,byte**,byte**,byte**)", ves_icall_Mono_Globalization_Unicode_Normalization_load_normalization_resource}
+};
+
 static const IcallEntry gc_icalls [] = {
 	{"GetTotalMemory", ves_icall_System_GC_GetTotalMemory},
 	{"InternalCollect", ves_icall_System_GC_InternalCollect},
@@ -7006,6 +7010,7 @@
 
 /* keep the entries all sorted */
 static const IcallMap icall_entries [] = {
+	{"Mono.Globalization.Unicode.Normalization", normalization_icalls, G_N_ELEMENTS (normalization_icalls)},
 	{"Mono.Runtime", runtime_icalls, G_N_ELEMENTS (runtime_icalls)},
 	{"Mono.Security.Cryptography.KeyPairPersistence", keypair_icalls, G_N_ELEMENTS (keypair_icalls)},
 	{"System.Activator", activator_icalls, G_N_ELEMENTS (activator_icalls)},