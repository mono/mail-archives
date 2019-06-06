Index: mono/metadata/icall-def.h
===================================================================
--- mono/metadata/icall-def.h	(revision 122555)
+++ mono/metadata/icall-def.h	(working copy)
@@ -283,6 +283,9 @@
 ICALL(REGINF_1, "construct_internal_region_from_lcid", ves_icall_System_Globalization_RegionInfo_construct_internal_region_from_lcid)
 ICALL(REGINF_2, "construct_internal_region_from_name", ves_icall_System_Globalization_RegionInfo_construct_internal_region_from_name)
 
+ICALL_TYPE(IODRIVEINFO, "System.IO.DriveInfo", IODRIVEINFO_1)
+ICALL(IODRIVEINFO_1, "GetDiskFreeSpaceInternal", ves_icall_System_IO_DriveInfo_GetDiskFreeSpace)
+
 ICALL_TYPE(FAMW, "System.IO.FAMWatcher", FAMW_1)
 ICALL(FAMW_1, "InternalFAMNextEvent", ves_icall_System_IO_FAMW_InternalFAMNextEvent)
 
Index: mono/metadata/icall.c
===================================================================
--- mono/metadata/icall.c	(revision 122555)
+++ mono/metadata/icall.c	(working copy)
@@ -6854,6 +6854,37 @@
 	return mono_string_new (mono_domain_get (), g_get_tmp_dir ());
 }
 
+static MonoBoolean
+ves_icall_System_IO_DriveInfo_GetDiskFreeSpace (MonoString *directory_name, guint64 *free_bytes_avail,
+						guint64 *total_number_of_bytes, guint64 *total_number_of_free_bytes,
+						gint32 *error)
+{
+	gboolean result;
+	ULARGE_INTEGER wapi_free_bytes_avail;
+	ULARGE_INTEGER wapi_total_number_of_bytes;
+	ULARGE_INTEGER wapi_total_number_of_free_bytes;
+
+	MONO_ARCH_SAVE_REGS;
+
+	*error=ERROR_SUCCESS;
+	
+	result = GetDiskFreeSpaceEx (mono_string_chars (directory_name), &wapi_free_bytes_avail, &wapi_total_number_of_bytes,
+				     &wapi_total_number_of_free_bytes);
+
+	if (result) {
+		*free_bytes_avail = wapi_free_bytes_avail.QuadPart;
+		*total_number_of_bytes = wapi_total_number_of_bytes.QuadPart;
+		*total_number_of_free_bytes = wapi_total_number_of_free_bytes.QuadPart;
+	} else {
+		*free_bytes_avail = 0;
+		*total_number_of_bytes = 0;
+		*total_number_of_free_bytes = 0;
+		*error=GetLastError ();
+	}
+
+	return result;
+}
+
 static gpointer
 ves_icall_RuntimeMethod_GetFunctionPointer (MonoMethod *method)
 {
Index: mono/io-layer/uglify.h
===================================================================
--- mono/io-layer/uglify.h	(revision 122555)
+++ mono/io-layer/uglify.h	(working copy)
@@ -63,6 +63,8 @@
 typedef WapiWSABuf *LPWSABUF;
 typedef WapiLargeInteger LARGE_INTEGER;
 typedef WapiLargeInteger *PLARGE_INTEGER;
+typedef WapiULargeInteger ULARGE_INTEGER;
+typedef WapiULargeInteger *PULARGE_INTEGER;
 typedef WapiSystemInfo SYSTEM_INFO;
 typedef WapiSystemInfo *LPSYSTEM_INFO;
 typedef WapiFloatingSaveArea FLOATING_SAVE_AREA;
Index: mono/io-layer/io.c
===================================================================
--- mono/io-layer/io.c	(revision 122555)
+++ mono/io-layer/io.c	(working copy)
@@ -15,6 +15,7 @@
 #include <errno.h>
 #include <string.h>
 #include <sys/stat.h>
+#include <sys/statvfs.h>
 #include <sys/types.h>
 #include <dirent.h>
 #include <fnmatch.h>
@@ -3700,6 +3701,75 @@
 #endif
 }
 
+gboolean GetDiskFreeSpaceEx(const gunichar2 *directory_name, WapiULargeInteger *free_bytes_avail,
+			    WapiULargeInteger *total_number_of_bytes,
+			    WapiULargeInteger *total_number_of_free_bytes)
+{
+	struct statvfs fsstat;
+	gchar *utf8_name;
+	int ret;
+
+	if (directory_name == NULL) {
+		utf8_name = g_strdup (g_get_current_dir());
+		if (utf8_name == NULL) {
+			SetLastError (ERROR_DIRECTORY);
+			return(FALSE);
+		}
+	}
+	else {
+		utf8_name = mono_unicode_to_external (directory_name);
+		if (utf8_name == NULL) {
+#ifdef DEBUG
+			g_message("%s: unicode conversion returned NULL", __func__);
+#endif
+
+			SetLastError (ERROR_INVALID_NAME);
+			return(FALSE);
+		}
+	}
+
+	do {
+		ret = statvfs (utf8_name, &fsstat);
+	} while(ret == -1 && errno == EINTR);
+
+	g_free(utf8_name);
+
+	if (ret == -1) {
+		_wapi_set_last_error_from_errno ();
+#ifdef DEBUG
+		g_message ("%s: statvfs failed: %s", __func__, strerror (errno));
+#endif
+		return(FALSE);
+	}
+
+	/* total number of free bytes for non-root */
+	if (free_bytes_avail != NULL) {
+		if ((fsstat.f_flag & ST_RDONLY) == ST_RDONLY) {
+			free_bytes_avail->QuadPart = 0;
+		}
+		else {
+			free_bytes_avail->QuadPart = fsstat.f_bsize * fsstat.f_bavail;
+		}
+	}
+
+	/* total number of bytes available for non-root */
+	if (total_number_of_bytes != NULL) {
+		total_number_of_bytes->QuadPart = fsstat.f_bsize * fsstat.f_blocks;
+	}
+
+	/* total number of bytes available for root */
+	if (total_number_of_free_bytes != NULL) {
+		if ((fsstat.f_flag & ST_RDONLY) == ST_RDONLY) {
+			total_number_of_free_bytes->QuadPart = 0;
+		}
+		else {
+			total_number_of_free_bytes->QuadPart = fsstat.f_bsize * fsstat.f_bfree;
+		}
+	}
+	
+	return(TRUE);
+}
+
 static gboolean _wapi_lock_file_region (int fd, off_t offset, off_t length)
 {
 	struct flock lock_data;
Index: mono/io-layer/types.h
===================================================================
--- mono/io-layer/types.h	(revision 122555)
+++ mono/io-layer/types.h	(working copy)
@@ -23,4 +23,15 @@
 	guint64 QuadPart;
 } WapiLargeInteger;
 
+typedef union
+{
+	struct
+	{
+		guint32 LowPart;
+		guint32 HighPart;
+	} u;
+
+	guint64 QuadPart;
+} WapiULargeInteger;
+
 #endif /* _WAPI_TYPES_H_ */
Index: mono/io-layer/io.h
===================================================================
--- mono/io-layer/io.h	(revision 122555)
+++ mono/io-layer/io.h	(working copy)
@@ -202,6 +202,9 @@
 			    WapiSecurityAttributes *security, guint32 size);
 extern guint32 GetTempPath (guint32 len, gunichar2 *buf);
 extern gint32 GetLogicalDriveStrings (guint32 len, gunichar2 *buf);
+extern gboolean GetDiskFreeSpaceEx(const gunichar2 *directory_name, WapiULargeInteger *free_bytes_avail,
+				   WapiULargeInteger *total_number_of_bytes,
+				   WapiULargeInteger *total_number_of_free_bytes);
 extern gboolean LockFile (gpointer handle, guint32 offset_low,
 			  guint32 offset_high, guint32 length_low,
 			  guint32 length_high);
Index: ChangeLog
===================================================================
--- ChangeLog	(revision 122555)
+++ ChangeLog	(working copy)
@@ -1,3 +1,16 @@
+2009-01-07  Christian Prochnow  <cproch@seculogix.de>
+	* mono/io-layer/types.h: added WapiULargeInteger.
+
+	* mono/io-layer/uglify.h: added ULARGE_INTEGER, PULARGE_INTEGER.
+
+	* mono/io-layer/io.h
+	* mono/io-layer/io.c: added GetDiskFreeSpaceEx() to query disk size
+	and free space via statvfs() POSIX call.
+
+	* mono/metadata/icall.c
+	* mono/metadata/icall-def.h: added internal call
+	ves_icall_System_IO_DriveInfo_GetDiskFreeSpace.
+
 2009-01-06  Jb Evain  <jbevain@novell.com>
 
 	* scripts/Makefile.am: don't generate a script for the now
