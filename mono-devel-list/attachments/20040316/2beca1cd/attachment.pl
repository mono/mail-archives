? culture-info-tables.h
? culture-info.h
Index: icall.c
===================================================================
RCS file: /cvs/public/mono/mono/metadata/icall.c,v
retrieving revision 1.433
diff -u -b -r1.433 icall.c
--- icall.c	15 Mar 2004 21:19:01 -0000	1.433
+++ icall.c	16 Mar 2004 07:55:42 -0000
@@ -4884,7 +4884,8 @@
 
 static const IcallEntry cultureinfo_icalls [] = {
 	{"construct_compareinfo(object,string)", ves_icall_System_Globalization_CompareInfo_construct_compareinfo},
-	{"construct_internal_locale(string)", ves_icall_System_Globalization_CultureInfo_construct_internal_locale}
+	{"construct_internal_locale(string)", ves_icall_System_Globalization_CultureInfo_construct_internal_locale},
+	{"construct_internal_locale_from_lcid", ves_icall_System_Globalization_CultureInfo_construct_internal_locale_from_lcid}
 };
 
 static const IcallEntry compareinfo_icalls [] = {
Index: locales.c
===================================================================
RCS file: /cvs/public/mono/mono/metadata/locales.c,v
retrieving revision 1.12
diff -u -b -r1.12 locales.c
--- locales.c	29 Feb 2004 14:48:43 -0000	1.12
+++ locales.c	16 Mar 2004 07:55:43 -0000
@@ -19,6 +19,8 @@
 #include <mono/metadata/exception.h>
 #include <mono/metadata/monitor.h>
 #include <mono/metadata/locales.h>
+#include <mono/metadata/culture-info.h>
+#include <mono/metadata/culture-info-tables.h>
 
 #undef DEBUG
 
@@ -353,6 +355,182 @@
 	return(icu_locale);
 }
 
+static const CultureInfoEntry*
+culture_info_from_lcid (const gint lcid)
+{
+	const CultureInfoEntry *cur_info = &culture_entries [0];
+	
+	while (cur_info->lcid != -1) {
+		if (lcid == cur_info->lcid)
+			return cur_info;
+		cur_info++;
+	}
+	return NULL;
+}
+
+static MonoArray*
+create_group_sizes_array (const gint *gs, gint ml)
+{
+	MonoArray *ret;
+	int i, len = 0;
+
+	for (i = 0; i < ml; i++) {
+		if (gs [i] == -1)
+			break;
+		len++;
+	}
+	
+	ret = mono_array_new (mono_domain_get (),
+			mono_defaults.int32_class, len);
+
+	for(i = 0; i < len; i++)
+		mono_array_set (ret, gint32, i, gs [i]);
+
+	return ret;
+}
+
+static MonoArray*
+create_names_array (const gchar **names, int ml)
+{
+	MonoArray *ret;
+	MonoDomain *domain;
+	int i, len = 0;
+
+	if (names == NULL)
+		return NULL;
+
+	domain = mono_domain_get ();
+
+	for (i = 0; i < ml; i++) {
+		if (names [i] == NULL)
+			break;
+		len++;
+	}
+
+	ret = mono_array_new (mono_domain_get (), mono_defaults.string_class, len);
+
+	for(i = 0; i < len; i++)
+		mono_array_set (ret, MonoString *, i, mono_string_new (domain, names [i]));
+
+	return ret;
+}
+
+static MonoDateTimeFormatInfo*
+create_datetime_format_info (MonoCultureInfo *ci, int dfidx)
+{
+	MonoDateTimeFormatInfo *df;
+	MonoClass *class;
+	MonoDomain *domain;
+	const DateTimeFormatEntry dfe = datetime_format_entries [dfidx];
+
+	domain = mono_domain_get ();
+	class = mono_class_from_name (mono_defaults.corlib,
+			"System.Globalization", "DateTimeFormatInfo");
+	df = (MonoDateTimeFormatInfo *) mono_object_new (domain, class);
+	mono_runtime_object_init ((MonoObject *) df);
+
+	df->AbbreviatedDayNames = create_names_array (dfe.abbreviated_day_names, NUM_OF_DAYS);
+	df->AbbreviatedMonthNames = create_names_array (dfe.abbreviated_month_names, MAX_NUM_MONTHS);
+	df->AMDesignator = mono_string_new (domain, dfe.am_designator);
+	df->CalendarWeekRule = dfe.calendar_week_rule;
+	df->DateSeparator = mono_string_new (domain, dfe.date_separator);
+	df->DayNames = create_names_array (dfe.day_names, NUM_OF_DAYS);
+	df->FirstDayOfWeek = dfe.first_day_of_week;
+	df->FullDateTimePattern = mono_string_new (domain, dfe.full_date_time_pattern);
+	df->LongDatePattern = mono_string_new (domain, dfe.long_date_pattern);
+	df->LongTimePattern = mono_string_new (domain, dfe.long_time_pattern);
+	df->MonthDayPattern = mono_string_new (domain, dfe.month_day_pattern);
+	df->MonthNames = create_names_array (dfe.month_names, MAX_NUM_MONTHS);
+	df->PMDesignator = mono_string_new (domain, dfe.pm_designator);
+	df->ShortDatePattern = mono_string_new (domain, dfe.short_date_pattern);
+	df->ShortTimePattern = mono_string_new (domain, dfe.short_time_pattern);
+	df->TimeSeparator = mono_string_new (domain, dfe.time_separator);
+	df->YearMonthPattern = mono_string_new (domain, dfe.year_month_pattern);
+
+	return df;
+}
+
+static MonoNumberFormatInfo*
+create_number_format_info (MonoCultureInfo *ci, int nfidx)
+{
+	MonoNumberFormatInfo *nf;
+	MonoClass *class;
+	MonoDomain *domain;
+	const NumberFormatEntry nfe = number_format_entries [nfidx];
+
+	domain = mono_domain_get ();
+	class = mono_class_from_name (mono_defaults.corlib,
+			"System.Globalization", "NumberFormatInfo");
+	nf = (MonoNumberFormatInfo *) mono_object_new (domain, class);
+	mono_runtime_object_init ((MonoObject *) nf);
+
+	nf->currencyDecimalDigits = nfe.currency_decimal_digits;
+	nf->currencyDecimalSeparator = mono_string_new (domain, nfe.currency_decimal_separator);
+	nf->currencyGroupSeparator = mono_string_new (domain, nfe.currency_group_separator);
+	nf->currencyGroupSizes = create_group_sizes_array (nfe.currency_group_sizes, MAX_GROUP_SIZE);
+	nf->currencyNegativePattern = nfe.currency_negative_pattern;
+	nf->currencyPositivePattern = nfe.currency_positive_pattern;
+	nf->currencySymbol = mono_string_new (domain, nfe.currency_symbol);
+	nf->negativeInfinitySymbol = mono_string_new (domain, nfe.currency_symbol);
+	nf->naNSymbol = mono_string_new (domain, nfe.nan_symbol);
+	nf->negativeInfinitySymbol = mono_string_new (domain, nfe.negative_infinity_symbol);
+	nf->negativeSign = mono_string_new (domain, nfe.negative_sign);
+	nf->numberDecimalDigits = nfe.number_decimal_digits;
+	nf->numberDecimalSeparator = mono_string_new (domain, nfe.number_decimal_separator);
+	nf->numberGroupSeparator = mono_string_new (domain, nfe.number_group_separator);
+	nf->numberGroupSizes = create_group_sizes_array (nfe.number_group_sizes, MAX_GROUP_SIZE);
+	nf->numberNegativePattern = nfe.number_negative_pattern;
+	nf->percentDecimalDigits = nfe.percent_decimal_digits;
+	nf->percentDecimalSeparator = mono_string_new (domain, nfe.percent_decimal_separator);
+	nf->percentGroupSeparator = mono_string_new (domain, nfe.percent_group_separator);
+	nf->percentGroupSizes = create_group_sizes_array (nfe.percent_group_sizes, MAX_GROUP_SIZE);
+	nf->percentNegativePattern = nfe.percent_negative_pattern;
+	nf->percentPositivePattern = nfe.percent_positive_pattern;
+	nf->percentSymbol = mono_string_new (domain, nfe.percent_symbol);
+	nf->perMilleSymbol = mono_string_new (domain, nfe.per_mille_symbol);
+	nf->positiveInfinitySymbol = mono_string_new (domain, nfe.positive_infinity_symbol);
+	nf->positiveSign = mono_string_new (domain, nfe.positive_sign);
+
+	return nf;
+}
+
+void ves_icall_System_Globalization_CultureInfo_construct_internal_locale_from_lcid (MonoCultureInfo *this, gint lcid)
+{
+	const CultureInfoEntry *ci;
+	MonoDomain *domain;
+	
+	MONO_ARCH_SAVE_REGS;
+
+	domain = mono_domain_get ();
+	
+	/**
+	 * It would be faster to search a tree, but the overhead of creating
+	 * the tree and locking might not be worth it. How many times to
+	 * people lookup a CultureInfo normally?
+	 *
+	 * NOTE: Not using bsearch because it doesn't break on the first match.
+	 */
+	ci = culture_info_from_lcid (lcid);
+
+	if(ci == NULL) {
+		/* Locale for lcid not found */
+		mono_raise_exception((MonoException *)mono_exception_from_name(
+					     mono_defaults.corlib, "System", "SystemException"));
+		return;
+	}
+
+	this->displayname = mono_string_new (domain, ci->displayname);
+	this->englishname = mono_string_new (domain, ci->englishname);
+	this->nativename = mono_string_new (domain, ci->nativename);
+	this->iso3lang = mono_string_new (domain, ci->iso3lang);
+	this->iso2lang = mono_string_new (domain, ci->iso2lang);
+
+	if (ci->datetime_format_index > 0)
+		this->datetime_format = create_datetime_format_info (this, ci->datetime_format_index);
+	if (ci->number_format_index > 0)
+		this->number_format = create_number_format_info (this, ci->number_format_index);
+}
+
 void ves_icall_System_Globalization_CultureInfo_construct_internal_locale (MonoCultureInfo *this, MonoString *locale)
 {
 	UChar *ustr;
Index: locales.h
===================================================================
RCS file: /cvs/public/mono/mono/metadata/locales.h,v
retrieving revision 1.5
diff -u -b -r1.5 locales.h
--- locales.h	6 Dec 2003 16:54:11 -0000	1.5
+++ locales.h	16 Mar 2004 07:55:43 -0000
@@ -27,6 +27,7 @@
 } MonoCompareOptions;
 
 extern void ves_icall_System_Globalization_CultureInfo_construct_internal_locale (MonoCultureInfo *this, MonoString *locale);
+extern void ves_icall_System_Globalization_CultureInfo_construct_internal_locale_from_lcid (MonoCultureInfo *this, gint lcid);
 extern void ves_icall_System_Globalization_CompareInfo_construct_compareinfo (MonoCompareInfo *comp, MonoString *locale);
 extern int ves_icall_System_Globalization_CompareInfo_internal_compare (MonoCompareInfo *this, MonoString *str1, gint32 off1, gint32 len1, MonoString *str2, gint32 off2, gint32 len2, gint32 options);
 extern void ves_icall_System_Globalization_CompareInfo_free_internal_collator (MonoCompareInfo *this);
