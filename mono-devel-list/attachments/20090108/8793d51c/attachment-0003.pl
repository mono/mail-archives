Index: mono/metadata/ChangeLog
===================================================================
--- mono/metadata/ChangeLog	(revision 122751)
+++ mono/metadata/ChangeLog	(working copy)
@@ -1,3 +1,9 @@
+2009-01-08  Christian Prochnow  <cproch@seculogix.de>
+
+	* icall.c
+	* icall-def.h: added internal calls ves_icall_System_IO_DriveInfo_GetDiskFreeSpace,
+	ves_icall_System_IO_DriveInfo_GetDriveType.
+
 2009-01-07  Miguel de Icaza  <miguel@novell.com>
 
 	* icall.c: Wrap calls to mono_strtod in CriticalSection
Index: mono/metadata/icall-def.h
===================================================================
--- mono/metadata/icall-def.h	(revision 122751)
+++ mono/metadata/icall-def.h	(working copy)
@@ -283,6 +283,10 @@
 ICALL(REGINF_1, "construct_internal_region_from_lcid", ves_icall_System_Globalization_RegionInfo_construct_internal_region_from_lcid)
 ICALL(REGINF_2, "construct_internal_region_from_name", ves_icall_System_Globalization_RegionInfo_construct_internal_region_from_name)
 
+ICALL_TYPE(IODRIVEINFO, "System.IO.DriveInfo", IODRIVEINFO_1)
+ICALL(IODRIVEINFO_1, "GetDiskFreeSpaceInternal", ves_icall_System_IO_DriveInfo_GetDiskFreeSpace)
+ICALL(IODRIVEINFO_2, "GetDriveTypeInternal", ves_icall_System_IO_DriveInfo_GetDriveType)
+
 ICALL_TYPE(FAMW, "System.IO.FAMWatcher", FAMW_1)
 ICALL(FAMW_1, "InternalFAMNextEvent", ves_icall_System_IO_FAMW_InternalFAMNextEvent)
 
Index: mono/metadata/icall.c
===================================================================
--- mono/metadata/icall.c	(revision 122751)
+++ mono/metadata/icall.c	(working copy)
@@ -6868,6 +6868,45 @@
 	return mono_string_new (mono_domain_get (), g_get_tmp_dir ());
 }
 
+static MonoBoolean
+ves_icall_System_IO_DriveInfo_GetDiskFreeSpace (MonoString *path_name, guint64 *free_bytes_avail,
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
+	result = GetDiskFreeSpaceEx (mono_string_chars (path_name), &wapi_free_bytes_avail, &wapi_total_number_of_bytes,
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
+static guint32
+ves_icall_System_IO_DriveInfo_GetDriveType (MonoString *root_path_name)
+{
+	MONO_ARCH_SAVE_REGS;
+
+	return GetDriveType (mono_string_chars (root_path_name));
+}
+
 static gpointer
 ves_icall_RuntimeMethod_GetFunctionPointer (MonoMethod *method)
 {
Index: mono/io-layer/uglify.h
===================================================================
--- mono/io-layer/uglify.h	(revision 122751)
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
Index: mono/io-layer/ChangeLog
===================================================================
--- mono/io-layer/ChangeLog	(revision 122751)
+++ mono/io-layer/ChangeLog	(working copy)
@@ -1,3 +1,16 @@
+2009-01-08  Christian Prochnow  <cproch@seculogix.de>
+
+	* types.h: added WapiULargeInteger.
+
+	* uglify.h: added ULARGE_INTEGER, PULARGE_INTEGER.
+
+	* io.h: added WapiDriveType, added method declarations
+	for GetDiskFreeSpaceEx and GetDriveType
+
+	* io.c: added GetDiskFreeSpaceEx() to query disk size
+	and free space via statvfs or statfs system call.
+	added GetDriveType to query drive type via /etc/mtab or /etc/mnttab.
+
 2009-01-07  Geoff Norton  <gnorton@novell.com>
 
 	* processes.c: Properly implement support for Process.Modules on OSX.
Index: mono/io-layer/io.c
===================================================================
--- mono/io-layer/io.c	(revision 122751)
+++ mono/io-layer/io.c	(working copy)
@@ -15,6 +15,14 @@
 #include <errno.h>
 #include <string.h>
 #include <sys/stat.h>
+#ifdef HAVE_SYS_STATVFS_H
+#include <sys/statvfs.h>
+#elif defined(HAVE_SYS_STATFS_H)
+#include <sys/statfs.h>
+#elif defined(HAVE_SYS_PARAM_H) && defined(HAVE_SYS_MOUNT_H)
+#include <sys/param.h>
+#include <sys/mount.h>
+#endif
 #include <sys/types.h>
 #include <dirent.h>
 #include <fnmatch.h>
@@ -3698,6 +3706,225 @@
 #endif
 }
 
+#if defined(HAVE_STATVFS) || defined(HAVE_STATFS)
+gboolean GetDiskFreeSpaceEx(const gunichar2 *path_name, WapiULargeInteger *free_bytes_avail,
+			    WapiULargeInteger *total_number_of_bytes,
+			    WapiULargeInteger *total_number_of_free_bytes)
+{
+#ifdef HAVE_STATVFS
+	struct statvfs fsstat;
+#elif defined(HAVE_STATFS)
+	struct statfs fsstat;
+#endif
+	gboolean isreadonly;
+	gchar *utf8_path_name;
+	int ret;
+
+	if (path_name == NULL) {
+		utf8_path_name = g_strdup (g_get_current_dir());
+		if (utf8_path_name == NULL) {
+			SetLastError (ERROR_DIRECTORY);
+			return(FALSE);
+		}
+	}
+	else {
+		utf8_path_name = mono_unicode_to_external (path_name);
+		if (utf8_path_name == NULL) {
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
+#ifdef HAVE_STATVFS
+		ret = statvfs (utf8_path_name, &fsstat);
+		isreadonly = ((fsstat.f_flag & ST_RDONLY) == ST_RDONLY);
+#elif defined(HAVE_STATFS)
+		ret = statfs (utf8_path_name, &fsstat);
+		isreadonly = ((fsstat.f_flags & MNT_RDONLY) == MNT_RDONLY);
+#endif
+	} while(ret == -1 && errno == EINTR);
+
+	g_free(utf8_path_name);
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
+		if (isreadonly) {
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
+		if (isreadonly) {
+			total_number_of_free_bytes->QuadPart = 0;
+		}
+		else {
+			total_number_of_free_bytes->QuadPart = fsstat.f_bsize * fsstat.f_bfree;
+		}
+	}
+	
+	return(TRUE);
+}
+#else
+gboolean GetDiskFreeSpaceEx(const gunichar2 *path_name, WapiULargeInteger *free_bytes_avail,
+			    WapiULargeInteger *total_number_of_bytes,
+			    WapiULargeInteger *total_number_of_free_bytes)
+{
+	if (free_bytes_avail != NULL) {
+		free_bytes_avail->QuadPart = (guint64) -1;
+	}
+
+	if (total_number_of_bytes != NULL) {
+		total_number_of_bytes->QuadPart = (guint64) -1;
+	}
+
+	if (total_number_of_free_bytes != NULL) {
+		total_number_of_free_bytes->QuadPart = (guint64) -1;
+	}
+
+	return(TRUE);
+}
+#endif
+
+typedef struct {
+	guint32 drive_type;
+	const gchar* fstype;
+} _wapi_drive_type;
+
+static _wapi_drive_type _wapi_drive_types[] = {
+	{ DRIVE_RAMDISK, "ramfs"      },
+	{ DRIVE_RAMDISK, "tmpfs"      },
+	{ DRIVE_RAMDISK, "proc"       },
+	{ DRIVE_RAMDISK, "sysfs"      },
+	{ DRIVE_RAMDISK, "debugfs"    },
+	{ DRIVE_RAMDISK, "devpts"     },
+	{ DRIVE_RAMDISK, "securityfs" },
+	{ DRIVE_CDROM,   "iso9660"    },
+	{ DRIVE_FIXED,   "ext2"       },
+	{ DRIVE_FIXED,   "ext3"       },
+	{ DRIVE_FIXED,   "ext4"       },
+	{ DRIVE_FIXED,   "sysv"       },
+	{ DRIVE_FIXED,   "reiserfs"   },
+	{ DRIVE_FIXED,   "ufs"        },
+	{ DRIVE_FIXED,   "vfat"       },
+	{ DRIVE_FIXED,   "msdos"      },
+	{ DRIVE_FIXED,   "udf"        },
+	{ DRIVE_FIXED,   "hfs"        },
+	{ DRIVE_FIXED,   "hpfs"       },
+	{ DRIVE_FIXED,   "qnx4"       },
+	{ DRIVE_FIXED,   "ntfs"       },
+	{ DRIVE_FIXED,   "ntfs-3g"    },
+	{ DRIVE_REMOTE,  "smbfs"      },
+	{ DRIVE_REMOTE,  "fuse"       },
+	{ DRIVE_REMOTE,  "nfs"        },
+	{ DRIVE_REMOTE,  "nfs4"       },
+	{ DRIVE_REMOTE,  "cifs"       },
+	{ DRIVE_REMOTE,  "ncpfs"      },
+	{ DRIVE_REMOTE,  "coda"       },
+	{ DRIVE_REMOTE,  "afs"        },
+	{ DRIVE_UNKNOWN, NULL         }
+};
+
+static guint32 _wapi_get_drive_type(const gchar* fstype)
+{
+	_wapi_drive_type *current;
+
+	current = &_wapi_drive_types[0];
+	while (current->drive_type != DRIVE_UNKNOWN) {
+		if (strcmp (current->fstype, fstype) == 0)
+			break;
+
+		current++;
+	}
+	
+	return current->drive_type;
+}
+
+guint32 GetDriveType(const gunichar2 *root_path_name)
+{
+	FILE *fp;
+	gchar buffer [512];
+	gchar **splitted;
+	gchar *utf8_root_path_name;
+	guint32 drive_type;
+
+	if (root_path_name == NULL) {
+		utf8_root_path_name = g_strdup (g_get_current_dir());
+		if (utf8_root_path_name == NULL) {
+			return(DRIVE_NO_ROOT_DIR);
+		}
+	}
+	else {
+		utf8_root_path_name = mono_unicode_to_external (root_path_name);
+		if (utf8_root_path_name == NULL) {
+#ifdef DEBUG
+			g_message("%s: unicode conversion returned NULL", __func__);
+#endif
+			return(DRIVE_NO_ROOT_DIR);
+		}
+		
+		/* strip trailing slash for compare below */
+		if (g_str_has_suffix(utf8_root_path_name, "/")) {
+			utf8_root_path_name[strlen(utf8_root_path_name) - 1] = 0;
+		}
+	}
+
+	fp = fopen ("/etc/mtab", "rt");
+	if (fp == NULL) {
+		fp = fopen ("/etc/mnttab", "rt");
+		if (fp == NULL) {
+			g_free (utf8_root_path_name);
+			return(DRIVE_UNKNOWN);
+		}
+	}
+
+	drive_type = DRIVE_NO_ROOT_DIR;
+	while (fgets (buffer, 512, fp) != NULL) {
+		splitted = g_strsplit (buffer, " ", 0);
+		if (!*splitted || !*(splitted + 1) || !*(splitted + 2)) {
+			g_strfreev (splitted);
+			continue;
+		}
+
+		/* compare given root_path_name with the one from mtab, 
+		  if length of utf8_root_path_name is zero it must be the root dir */
+		if (strcmp (*(splitted + 1), utf8_root_path_name) == 0 ||
+		    (strcmp (*(splitted + 1), "/") == 0 && strlen (utf8_root_path_name) == 0)) {
+			drive_type = _wapi_get_drive_type (*(splitted + 2));
+			g_strfreev (splitted);
+			break;
+		}
+
+		g_strfreev (splitted);
+	}
+
+	fclose (fp);
+	g_free (utf8_root_path_name);
+
+	return (drive_type);
+}
+
 static gboolean _wapi_lock_file_region (int fd, off_t offset, off_t length)
 {
 	struct flock lock_data;
Index: mono/io-layer/types.h
===================================================================
--- mono/io-layer/types.h	(revision 122751)
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
--- mono/io-layer/io.h	(revision 122751)
+++ mono/io-layer/io.h	(working copy)
@@ -108,6 +108,16 @@
 } WapiFileType;
 
 typedef enum {
+	DRIVE_UNKNOWN=0,
+	DRIVE_NO_ROOT_DIR=1,
+	DRIVE_REMOVABLE=2,
+	DRIVE_FIXED=3,
+	DRIVE_REMOTE=4,
+	DRIVE_CDROM=5,
+	DRIVE_RAMDISK=6
+} WapiDriveType;
+
+typedef enum {
 	GetFileExInfoStandard=0x0000,
 	GetFileExMaxInfoLevel=0x0001
 } WapiGetFileExInfoLevels;
@@ -202,6 +212,10 @@
 			    WapiSecurityAttributes *security, guint32 size);
 extern guint32 GetTempPath (guint32 len, gunichar2 *buf);
 extern gint32 GetLogicalDriveStrings (guint32 len, gunichar2 *buf);
+extern gboolean GetDiskFreeSpaceEx(const gunichar2 *path_name, WapiULargeInteger *free_bytes_avail,
+				   WapiULargeInteger *total_number_of_bytes,
+				   WapiULargeInteger *total_number_of_free_bytes);
+extern guint32 GetDriveType(const gunichar2 *root_path_name);
 extern gboolean LockFile (gpointer handle, guint32 offset_low,
 			  guint32 offset_high, guint32 length_low,
 			  guint32 length_high);
Index: configure.in
===================================================================
--- configure.in	(revision 122751)
+++ configure.in	(working copy)
@@ -1407,9 +1407,12 @@
 	AC_CHECK_HEADERS(sys/extattr.h)
 	AC_CHECK_HEADERS(sys/sendfile.h)
 	AC_CHECK_HEADERS(sys/statvfs.h)
+	AC_CHECK_HEADERS(sys/statfs.h)
 	AC_CHECK_HEADERS(sys/vfstab.h)
 	AC_CHECK_HEADERS(sys/xattr.h)
 	AC_CHECK_HEADERS(sys/mman.h)
+	AC_CHECK_HEADERS(sys/param.h)
+	AC_CHECK_HEADERS(sys/mount.h)
 	AC_CHECK_FUNCS(getdomainname)
 	AC_CHECK_FUNCS(setdomainname)
 	AC_CHECK_FUNCS(fgetgrent)
Index: ChangeLog
===================================================================
--- ChangeLog	(revision 122751)
+++ ChangeLog	(working copy)
@@ -1,3 +1,7 @@
+2008-01-08  Christian Prochnow  <cproch@seculogix.de>
+
+	* configure.in: Check for sys/statfs.h and sys/mount.h
+
 2009-01-07  Geoff Norton  <gnorton@novell.com>
 
 	* configure.in: Provide platform information to the mcs build tree
