Index: locales.c
===================================================================
--- locales.c	(revision 47595)
+++ locales.c	(working copy)
@@ -12,6 +12,7 @@
 #include <config.h>
 #include <glib.h>
 #include <string.h>
+#include <sys/stat.h>
 
 #include <mono/metadata/debug-helpers.h>
 #include <mono/metadata/object.h>
@@ -21,6 +22,7 @@
 #include <mono/metadata/locales.h>
 #include <mono/metadata/culture-info.h>
 #include <mono/metadata/culture-info-tables.h>
+#include <mono/metadata/domain-internals.h>
 
 
 #include <locale.h>
@@ -511,6 +513,59 @@
 	return TRUE;
 }
 
+static const char* collation_resource_filenames [] = {"collation.core.bin",
+	"collation.cjkCHS.bin",
+	"collation.cjkCHT.bin",
+	"collation.cjkJA.bin",
+	"collation.cjkKO.bin",
+	"collation.cjkKOlv2.bin",
+	"collation.tailoring.bin"
+};
+
+static guint8* collation_resources [] = {NULL, NULL, NULL, NULL, NULL, NULL, NULL};
+static guint32 collation_resource_sizes [] = {0, 0, 0, 0, 0, 0, 0};
+
+void ves_icall_Mono_Globalization_Unicode_MSCompatUnicodeTable_load_collation_resource (MonoString *path, guint32 resource_index, guint8 **location, guint32 *size)
+{
+	const MonoRuntimeInfo *current_runtime;
+	FILE *filed;
+	struct stat stat_buf;
+
+	g_assert (resource_index >= 0 && resource_index < 7);
+
+	if (collation_resources [resource_index] == NULL) {
+
+		current_runtime = mono_get_runtime_info ();
+
+		char *dirname = g_path_get_dirname (mono_string_to_utf8 (path));
+		char *fname = g_build_filename (dirname, collation_resource_filenames [resource_index], NULL);
+		g_free (dirname);
+
+		filed = fopen (fname, "rb");
+		g_free (fname);
+
+		if (filed == NULL){
+#if 0
+			g_print ("collation resource file %s was not found.", fname);
+#endif
+			return;
+		}
+
+		if (!fstat (fileno (filed), &stat_buf)) {
+			collation_resources [resource_index] = mono_raw_buffer_load (fileno (filed), FALSE, 0, stat_buf.st_size);
+;
+			collation_resource_sizes [resource_index] = stat_buf.st_size;
+		}
+#if 0
+		else
+			g_print ("collation resource file %s could not be opened.", fname);
+#endif
+		fclose (filed);
+	}
+	*location = collation_resources [resource_index];
+	*size = collation_resource_sizes [resource_index];
+}
+
 #ifdef HAVE_ICU
 
 #include <unicode/utypes.h>
Index: locales.h
===================================================================
--- locales.h	(revision 47595)
+++ locales.h	(working copy)
@@ -38,6 +38,7 @@
 extern void ves_icall_System_Globalization_CompareInfo_construct_compareinfo (MonoCompareInfo *comp, MonoString *locale);
 extern int ves_icall_System_Globalization_CompareInfo_internal_compare (MonoCompareInfo *this, MonoString *str1, gint32 off1, gint32 len1, MonoString *str2, gint32 off2, gint32 len2, gint32 options);
 extern void ves_icall_System_Globalization_CompareInfo_free_internal_collator (MonoCompareInfo *this);
+extern void ves_icall_Mono_Globalization_Unicode_MSCompatUnicodeTable_load_collation_resource (MonoString *path, guint32 resource_index, guint8 **location, guint32 *size);
 extern void ves_icall_System_Globalization_CompareInfo_assign_sortkey (MonoCompareInfo *this, MonoSortKey *key, MonoString *source, gint32 options);
 extern int ves_icall_System_Globalization_CompareInfo_internal_index (MonoCompareInfo *this, MonoString *source, gint32 sindex, gint32 count, MonoString *value, gint32 options, MonoBoolean first);
 extern int ves_icall_System_Globalization_CompareInfo_internal_index_char (MonoCompareInfo *this, MonoString *source, gint32 sindex, gint32 count, gunichar2 value, gint32 options, MonoBoolean first);
Index: icall.c
===================================================================
--- icall.c	(revision 47595)
+++ icall.c	(working copy)
@@ -6342,6 +6342,10 @@
 	{"internal_index(string,int,int,string,System.Globalization.CompareOptions,bool)", ves_icall_System_Globalization_CompareInfo_internal_index}
 };
 
+static const IcallEntry mscompatunicodetable_icalls [] = {
+	{"load_collation_resource(string,int,byte**,int*)", ves_icall_Mono_Globalization_Unicode_MSCompatUnicodeTable_load_collation_resource}
+};
+
 static const IcallEntry gc_icalls [] = {
 	{"GetTotalMemory", ves_icall_System_GC_GetTotalMemory},
 	{"InternalCollect", ves_icall_System_GC_InternalCollect},
@@ -7016,6 +7020,7 @@
 
 /* keep the entries all sorted */
 static const IcallMap icall_entries [] = {
+	{"Mono.Globalization.Unicode.MSCompatUnicodeTable", mscompatunicodetable_icalls, G_N_ELEMENTS (mscompatunicodetable_icalls)},
 	{"Mono.Runtime", runtime_icalls, G_N_ELEMENTS (runtime_icalls)},
 	{"Mono.Security.Cryptography.KeyPairPersistence", keypair_icalls, G_N_ELEMENTS (keypair_icalls)},
 	{"System.Activator", activator_icalls, G_N_ELEMENTS (activator_icalls)},
