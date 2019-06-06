Index: object-internals.h
===================================================================
--- object-internals.h	(revision 48380)
+++ object-internals.h	(working copy)
@@ -373,6 +373,18 @@
 
 typedef struct {
 	MonoObject obj;
+	gint32 region_id;
+	MonoString *iso2name;
+	MonoString *iso3name;
+	MonoString *win3name;
+	MonoString *english_name;
+	MonoString *currency_symbol;
+	MonoString *iso_currency_symbol;
+	MonoString *currency_english_name;
+} MonoRegionInfo;
+
+typedef struct {
+	MonoObject obj;
 	MonoString *str;
 	gint32 options;
 	MonoArray *key;
Index: locales.c
===================================================================
--- locales.c	(revision 48380)
+++ locales.c	(working copy)
@@ -45,6 +45,8 @@
 
 static const CultureInfoEntry* culture_info_entry_from_lcid (int lcid);
 
+static const RegionInfoEntry* region_info_entry_from_lcid (int lcid);
+
 static int
 culture_lcid_locator (const void *a, const void *b)
 {
@@ -55,6 +57,15 @@
 }
 
 static int
+region_lcid_locator (const void *a, const void *b)
+{
+	const int *lcid = a;
+	const RegionLCIDMap *bb = b;
+
+	return *lcid - bb->lcid;
+}
+
+static int
 culture_name_locator (const void *a, const void *b)
 {
 	const char *aa = a;
@@ -66,6 +77,18 @@
 	return ret;
 }
 
+static int
+region_name_locator (const void *a, const void *b)
+{
+	const char *aa = a;
+	const RegionInfoNameEntry *bb = b;
+	int ret;
+	
+	ret = strcmp (aa, idx2string (bb->name));
+
+	return ret;
+}
+
 static MonoArray*
 create_group_sizes_array (const gint *gs, gint ml)
 {
@@ -236,6 +259,23 @@
 	return TRUE;
 }
 
+static MonoBoolean
+construct_region (MonoRegionInfo *this, const RegionInfoEntry *ri)
+{
+	MonoDomain *domain = mono_domain_get ();
+
+	this->region_id = ri->region_id;
+	this->iso2name = mono_string_new (domain, idx2string (ri->iso2name));
+	this->iso3name = mono_string_new (domain, idx2string (ri->iso3name));
+	this->win3name = mono_string_new (domain, idx2string (ri->win3name));
+	this->english_name = mono_string_new (domain, idx2string (ri->english_name));
+	this->currency_symbol = mono_string_new (domain, idx2string (ri->currency_symbol));
+	this->iso_currency_symbol = mono_string_new (domain, idx2string (ri->iso_currency_symbol));
+	this->currency_english_name = mono_string_new (domain, idx2string (ri->currency_english_name));
+	
+	return TRUE;
+}
+
 static gboolean
 construct_culture_from_specific_name (MonoCultureInfo *ci, gchar *name)
 {
@@ -259,6 +299,25 @@
 	return construct_culture (ci, entry);
 }
 
+static gboolean
+construct_region_from_specific_name (MonoRegionInfo *ri, gchar *name)
+{
+	const RegionInfoEntry *entry;
+	const RegionInfoNameEntry *ne;
+
+	MONO_ARCH_SAVE_REGS;
+
+	ne = bsearch (name, region_name_entries, NUM_REGION_ENTRIES,
+			sizeof (RegionInfoNameEntry), region_name_locator);
+
+	if (ne == NULL)
+		return FALSE;
+
+	entry = &region_entries [ne->region_entry_index];
+
+	return construct_region (ri, entry);
+}
+
 static const CultureInfoEntry*
 culture_info_entry_from_lcid (int lcid)
 {
@@ -271,6 +330,25 @@
 	return ci;
 }
 
+static const RegionInfoEntry*
+region_info_entry_from_lcid (int lcid)
+{
+	const RegionInfoEntry *entry;
+	const RegionLCIDMap *ne;
+
+	MONO_ARCH_SAVE_REGS;
+
+	ne = bsearch (&lcid, region_lcid_map, NUM_REGION_LCID_MAP,
+			sizeof (RegionLCIDMap), region_lcid_locator);
+
+	if (ne == NULL)
+		return FALSE;
+
+	entry = &region_entries [ne->region_entry_index];
+
+	return entry;
+}
+
 /*
  * The following two methods are modified from the ICU source code. (http://oss.software.ibm.com/icu)
  * Copyright (c) 1995-2003 International Business Machines Corporation and others
@@ -434,6 +512,44 @@
 	return ret;
 }
 
+MonoBoolean
+ves_icall_System_Globalization_RegionInfo_construct_internal_region_from_lcid (MonoRegionInfo *this,
+		gint lcid)
+{
+	const RegionInfoEntry *ri;
+	
+	MONO_ARCH_SAVE_REGS;
+
+	ri = region_info_entry_from_lcid (lcid);
+	if(ri == NULL)
+		return FALSE;
+
+	return construct_region (this, ri);
+}
+
+MonoBoolean
+ves_icall_System_Globalization_RegionInfo_construct_internal_region_from_name (MonoRegionInfo *this,
+		MonoString *name)
+{
+	const RegionInfoNameEntry *ne;
+	char *n;
+	
+	MONO_ARCH_SAVE_REGS;
+
+	n = mono_string_to_utf8 (name);
+	ne = bsearch (n, region_name_entries, NUM_REGION_ENTRIES,
+			sizeof (RegionInfoNameEntry), region_name_locator);
+
+	if (ne == NULL) {
+                /*g_print ("ne (%s) is null\n", n);*/
+        	g_free (n);
+		return FALSE;
+        }
+        g_free (n);
+
+	return construct_region (this, &region_entries [ne->region_entry_index]);
+}
+
 MonoArray*
 ves_icall_System_Globalization_CultureInfo_internal_get_cultures (MonoBoolean neutral,
 		MonoBoolean specific, MonoBoolean installed)
@@ -511,6 +627,7 @@
 	return TRUE;
 }
 
+
 #ifdef HAVE_ICU
 
 #include <unicode/utypes.h>
Index: locales.h
===================================================================
--- locales.h	(revision 48380)
+++ locales.h	(working copy)
@@ -38,6 +38,11 @@
 extern void ves_icall_System_Globalization_CompareInfo_construct_compareinfo (MonoCompareInfo *comp, MonoString *locale);
 extern int ves_icall_System_Globalization_CompareInfo_internal_compare (MonoCompareInfo *this, MonoString *str1, gint32 off1, gint32 len1, MonoString *str2, gint32 off2, gint32 len2, gint32 options);
 extern void ves_icall_System_Globalization_CompareInfo_free_internal_collator (MonoCompareInfo *this);
+extern MonoBoolean
+ves_icall_System_Globalization_RegionInfo_construct_internal_region_from_lcid (MonoRegionInfo *this, gint lcid);
+extern MonoBoolean
+ves_icall_System_Globalization_RegionInfo_construct_internal_region_from_name (MonoRegionInfo *this,
+ MonoString *name);
 extern void ves_icall_System_Globalization_CompareInfo_assign_sortkey (MonoCompareInfo *this, MonoSortKey *key, MonoString *source, gint32 options);
 extern int ves_icall_System_Globalization_CompareInfo_internal_index (MonoCompareInfo *this, MonoString *source, gint32 sindex, gint32 count, MonoString *value, gint32 options, MonoBoolean first);
 extern int ves_icall_System_Globalization_CompareInfo_internal_index_char (MonoCompareInfo *this, MonoString *source, gint32 sindex, gint32 count, gunichar2 value, gint32 options, MonoBoolean first);
Index: culture-info.h
===================================================================
--- culture-info.h	(revision 48380)
+++ culture-info.h	(working copy)
@@ -115,5 +115,28 @@
 	gint16 culture_entry_index;
 } CultureInfoNameEntry;
 
+typedef struct {
+	gint16 region_id;
+	/* gint8 measurement_system; // 0:metric 1:US 2:UK */
+	/* gint16 geo_id; */
+	const stridx_t iso2name;
+	const stridx_t iso3name;
+	const stridx_t win3name;
+	const stridx_t english_name;
+	const stridx_t currency_symbol;
+	const stridx_t iso_currency_symbol;
+	const stridx_t currency_english_name;
+} RegionInfoEntry;
+
+typedef struct {
+	const stridx_t name;
+	gint16 region_entry_index;
+} RegionInfoNameEntry;
+
+typedef struct {
+	gint16 lcid;
+	gint16 region_entry_index;
+} RegionLCIDMap;
+
 #endif
 
Index: icall.c
===================================================================
--- icall.c	(revision 48380)
+++ icall.c	(working copy)
@@ -6333,6 +6333,11 @@
 	{"internal_is_lcid_neutral", ves_icall_System_Globalization_CultureInfo_internal_is_lcid_neutral}
 };
 
+static const IcallEntry regioninfo_icalls [] = {
+	{"construct_internal_region_from_lcid", ves_icall_System_Globalization_RegionInfo_construct_internal_region_from_lcid},
+	{"construct_internal_region_from_name", ves_icall_System_Globalization_RegionInfo_construct_internal_region_from_name}
+};
+
 static const IcallEntry compareinfo_icalls [] = {
 	{"assign_sortkey(object,string,System.Globalization.CompareOptions)", ves_icall_System_Globalization_CompareInfo_assign_sortkey},
 	{"construct_compareinfo(string)", ves_icall_System_Globalization_CompareInfo_construct_compareinfo},
@@ -7044,6 +7049,7 @@
 	{"System.GC", gc_icalls, G_N_ELEMENTS (gc_icalls)},
 	{"System.Globalization.CompareInfo", compareinfo_icalls, G_N_ELEMENTS (compareinfo_icalls)},
 	{"System.Globalization.CultureInfo", cultureinfo_icalls, G_N_ELEMENTS (cultureinfo_icalls)},
+	{"System.Globalization.RegionInfo", regioninfo_icalls, G_N_ELEMENTS (regioninfo_icalls)},
 	{"System.IO.FAMWatcher", famwatcher_icalls, G_N_ELEMENTS (famwatcher_icalls)},
 	{"System.IO.FileSystemWatcher", filewatcher_icalls, G_N_ELEMENTS (filewatcher_icalls)},
 	{"System.IO.MonoIO", monoio_icalls, G_N_ELEMENTS (monoio_icalls)},