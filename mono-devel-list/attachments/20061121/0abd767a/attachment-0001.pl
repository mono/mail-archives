Index: appdomain.c
===================================================================
--- appdomain.c	(revision 68265)
+++ appdomain.c	(working copy)
@@ -35,7 +35,7 @@
 #include <mono/utils/mono-path.h>
 #include <mono/utils/mono-stdlib.h>
 
-#define MONO_CORLIB_VERSION 54
+#define MONO_CORLIB_VERSION 55
 
 CRITICAL_SECTION mono_delegate_section;
 
Index: ChangeLog
===================================================================
--- ChangeLog	(revision 68265)
+++ ChangeLog	(working copy)
@@ -1,3 +1,10 @@
+2006-11-21  Marek Safar  <marek.safar@gmail.com>
+
+	* icall-def.h,
+	* string-icalls.h,
+	* string-icalls.c (ves_icall_System_String_InternalReplace_Char):
+	Add start index to skip already tested characters.
+
 2006-11-13  Dick Porter  <dick@ximian.com>
 
 	* file-io.c (get_file_attributes): If the file is a symlink try
Index: icall-def.h
===================================================================
--- icall-def.h	(revision 68265)
+++ icall-def.h	(working copy)
@@ -669,7 +669,7 @@
 ICALL(STRING_17, "InternalLastIndexOfAny", ves_icall_System_String_InternalLastIndexOfAny)
 ICALL(STRING_18, "InternalPad", ves_icall_System_String_InternalPad)
 ICALL(STRING_19, "InternalRemove", ves_icall_System_String_InternalRemove)
-ICALL(STRING_20, "InternalReplace(char,char)", ves_icall_System_String_InternalReplace_Char)
+ICALL(STRING_20, "InternalReplace(char,char,int)", ves_icall_System_String_InternalReplace_Char)
 ICALL(STRING_21, "InternalReplace(string,string,System.Globalization.CompareInfo)", ves_icall_System_String_InternalReplace_Str_Comp)
 ICALL(STRING_22, "InternalSplit", ves_icall_System_String_InternalSplit)
 ICALL(STRING_23, "InternalStrcpy(string,int,char[])", ves_icall_System_String_InternalStrcpy_Chars)
Index: string-icalls.c
===================================================================
--- string-icalls.c	(revision 68265)
+++ string-icalls.c	(working copy)
@@ -326,7 +326,7 @@
 }
 
 MonoString * 
-ves_icall_System_String_InternalReplace_Char (MonoString *me, gunichar2 oldChar, gunichar2 newChar)
+ves_icall_System_String_InternalReplace_Char (MonoString *me, gunichar2 oldChar, gunichar2 newChar, gint32 startIndex)
 {
 	MonoString *ret;
 	gunichar2 *src;
@@ -341,7 +341,11 @@
 	ret = mono_string_new_size( mono_domain_get (), srclen);
 	dest = mono_string_chars(ret);
 
-	for (i = 0; i != srclen; i++) {
+	for (i = 0; i != startIndex; i++) {
+		dest[i] = src[i];
+	}
+
+	for (i = startIndex; i != srclen; i++) {
 		if (src[i] == oldChar)
 			dest[i] = newChar;
 		else
Index: string-icalls.h
===================================================================
--- string-icalls.h	(revision 68265)
+++ string-icalls.h	(working copy)
@@ -48,7 +48,7 @@
 ves_icall_System_String_InternalInsert (MonoString *me, gint32 sindex, MonoString *value) MONO_INTERNAL;
 
 MonoString * 
-ves_icall_System_String_InternalReplace_Char (MonoString *me, gunichar2 oldChar, gunichar2 newChar) MONO_INTERNAL;
+ves_icall_System_String_InternalReplace_Char (MonoString *me, gunichar2 oldChar, gunichar2 newChar, gint32 startIndex) MONO_INTERNAL;
 
 MonoString * 
 ves_icall_System_String_InternalRemove (MonoString *me, gint32 sindex, gint32 count) MONO_INTERNAL;
