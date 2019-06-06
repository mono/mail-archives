Index: timefuncs.c
===================================================================
--- timefuncs.c	(revision 41240)
+++ timefuncs.c	(working copy)
@@ -1,70 +1,326 @@
 /*
- * timefuncs.c:  performance timer and other time functions
+ * timefuncs.c:	 performance timer and other time functions
  *
  * Author:
  *	Dick Porter (dick@ximian.com)
+ *	Jesse Towner (townerj@gmail.com)
  *
  * (C) 2002 Ximian, Inc.
  */

 #include <config.h>
 #include <glib.h>
+#include <sys/types.h>
+#include <sys/param.h>
+#include <sys/utsname.h>
 #include <sys/time.h>
 #include <stdlib.h>
+#include <stdio.h>
+#include <unistd.h>
+#include <errno.h>

 #include <mono/io-layer/wapi.h>
 #include <mono/io-layer/timefuncs-private.h>

-#undef DEBUG
+/* Determine method to use to determine	boot time */
+#undef GET_BOOT_TIME_METHOD_FOUND

+/* Used	by most	Linux-based systems */
+#ifndef	GET_BOOT_TIME_METHOD_FOUND
+#	ifdef HAVE__PROC_UPTIME
+#		define GET_BOOT_TIME_PROCUPTIME
+#		define GET_BOOT_TIME_METHOD_FOUND
+#	endif
+#endif
+
+/* NetBSD, FreeBSD, OpenBSD and	MacOS X	*/
+#ifndef	GET_BOOT_TIME_METHOD_FOUND
+#	if defined(__NetBSD__) || defined(__FreeBSD__) || defined(__OpenBSD__) || \
+	   defined(__APPLE__) || defined(__DARWIN__)
+#		define GET_BOOT_TIME_SYSCTL
+#		define GET_BOOT_TIME_METHOD_FOUND
+#	endif
+#endif
+
+/* Look	for Irix */
+#if defined(irix) || defined(sgi) || defined(_sgi) || defined (__sgi)
+#	define IRIX
+#endif
+
+/* Ultrix & Irix*/
+#ifndef	GET_BOOT_TIME_METHOD_FOUND
+#	if defined(ultrix) || defined(IRIX)
+#		define GET_BOOT_TIME_KMEM
+#		define GET_BOOT_TIME_METHOD_FOUND
+#		if defined(HAVE__VMUNIX)
+#			define NLIST_KERNEL "/vmunix"
+#		endif
+#		if defined(HAVE__UNIX)
+#			define NLIST_KERNEL "/unix"
+#		endif
+#		ifndef NLIST_KERNEL
+#			error "Could not determine the kernel file to use with nlist!"
+#		endif
+#		if defined(IRIX) && defined(HAVE_NLIST64)
+#			define NLIST nlist64
+#		else
+#			define NLIST nlist
+#		endif
+#	endif
+#endif
+
+/* Solaris, Tru64 and HP/UX */
+#ifndef	GET_BOOT_TIME_METHOD_FOUND
+#	if defined(sun)	|| defined(__hpux) || defined(__hppa) || \
+	   defined(HPUX) || defined(hpux)
+#		define GET_BOOT_TIME_UTMPX
+#		define GET_BOOT_TIME_METHOD_FOUND
+#		ifndef HPUX
+#			define HPUX 1
+#		endif
+#	endif
+#endif
+
+/* Tru64 */
+#ifndef	GET_BOOT_TIME_METHOD_FOUND
+#	if defined(__osf__) || defined(__digital__)
+#		define GET_BOOT_TIME_TBLSYSINFO
+#		define GET_BOOT_TIME_METHOD_FOUND
+#	endif
+#endif
+
+/* Used	by some	of the BSD-like	systems	to extract boot	time */
+#ifdef GET_BOOT_TIME_SYSCTL
+#	include <sys/sysctl.h>
+#endif
+
+/* Needed to get boot time via kmem */
+#ifdef GET_BOOT_TIME_KMEM
+#	include <nlist.h>
+#	include <fcntl.h>
+#	include <time.h>
+#endif
+
+/* Get access to utmpx and time-functions */
+#ifdef GET_BOOT_TIME_UTMPX
+#	include <utmpx.h>
+#	include <time.h>
+#endif
+
+/* Needed on Tru64 */
+#ifdef GET_BOOT_TIME_TBLSYSINFO
+#	include <sys/table.h>
+#endif
+
+static mono_once_t get_boot_time_once=MONO_ONCE_INIT;
+static gboolean has_boot_time=FALSE;
+static struct timeval boot_time_cache;
+
+static void disable_boot_time (void)
+{
+	g_warning ("Could not retrieve boot-time! GetTickCount behaviour will be non-conforming!");
+	has_boot_time = FALSE;
+}
+
+static void get_boot_time_init (void)
+{
+#if defined(GET_BOOT_TIME_UTMPX)
+
+	/* Solaris and HP/UX */
+	struct utmpx id;
+	struct utmpx* u;
+
+	/* Rewind utmpx	entry pointer */
+	setutxent();
+
+	id.ut_type = BOOT_TIME;
+	u = getutxid (&id);
+
+	if (u == NULL) {
+		disable_boot_time ();
+		return;
+	}
+
+	boot_time_cache = u->ut_tv;
+
+#elif defined(GET_BOOT_TIME_KMEM)
+
+	/* Ultrix & Irix */
+	time_t boot_time_secs;
+	struct NLIST info[2];
+	int file;
+
+	/* Figure out where in kmem we can find	the boot time */
+	info[0].n_name = "boottime";
+	info[1].n_name = NULL;
+	if (NLIST (NLIST_KERNEL, info) != 0)
+		disable_boot_time ();
+		return;
+	}
+
+	/* Open /dev/kmem, read boot time, and close file */
+	if ((file = open ("/dev/kmem", O_RDONLY)) < 0)
+		disable_boot_time ();
+		return;
+	}
+
+	if (lseek (file, info[0].n_value,SEEK_SET) == -1) {
+		disable_boot_time ();
+		close (file);
+		return;
+	}
+
+	if (read (file, &boot_time_secs, sizeof (boot_time_sec)) == -1) {
+		disable_boot_time ();
+		close (file);
+		return;
+	}
+
+	close (file);
+
+	/* Store boot time */
+	boot_time_cache.tv_sec = boot_time_secs;
+	boot_time_cache.tv_usec = 0;
+
+#elif defined(GET_BOOT_TIME_TBLSYSINFO)
+
+	/* Tru64 */
+	struct tbl_sysinfo info;
+
+	/* Get boot time from system table */
+	if (table (TBL_SYSINFO, 0, &info, 1, sizeof (info)) == -1) {
+		disable_boot_time ();
+		return;
+	}
+
+	boot_time_cache.tv_sec = info.si_boottime;
+	boot_time_cache.tv_usec = 0;
+
+#elif defined(GET_BOOT_TIME_PROCUPTIME)
+
+	/* Most Linux-based Systems */
+	double uptime_secs = 0;
+	double uptime_usecs = 0;
+	struct timeval now;
+	FILE *file;
+
+	/* Try to get the uptime from /proc/uptime */
+	if ((file = fopen ("/proc/uptime", "r")) == NULL) {
+		disable_boot_time ();
+		return;
+	}
+
+	if (fscanf (file, "%lf %lf", &uptime_secs, &uptime_usecs) != 1)	{
+		disable_boot_time ();
+		fclose (file);
+		return;
+	}
+
+	fclose (file);
+
+	/* Translate uptime into boot time */
+	if (gettimeofday (&now, NULL) == -1) {
+		disable_boot_time ();
+		return;
+	}
+
+	boot_time_cache.tv_sec = now.tv_sev - (long)uptime_secs;
+	boot_time_cache.tv_usec = now.tv_usev - (long)uptime_usecs;
+
+#elif defined(GET_BOOT_TIME_SYSCTL)
+
+	/* FreeBSD, NetBSD, OpenBSD and MacOS X */
+	size_t size = sizeof (boot_time_cache);
+	int info[2];
+
+	/* Get boot time from sysctl interface */
+	info[0] = CTL_KERN;
+	info[1] = KERN_BOOTTIME;
+
+	if (sysctl (info, 2, &boot_time_cache, &size, NULL, 0) == -1) {
+		disable_boot_time ();
+		return;
+	}
+
+#else
+
+	has_boot_time = FALSE;
+	return;
+
+#endif
+
+	has_boot_time = TRUE;
+}
+
+gboolean _wapi_get_boottime (struct timeval *tv)
+{
+	if (tv == NULL)
+		return FALSE;
+
+	mono_once (&get_boot_time_once, get_boot_time_init);
+
+	if (has_boot_time == FALSE)
+		return FALSE;
+
+	tv->tv_sec = boot_time_cache.tv_sec;
+	tv->tv_usec = boot_time_cache.tv_usec;
+	return TRUE;
+}
+
+gboolean _wapi_get_uptime (struct timeval *tv)
+{
+	struct timeval bt;
+	struct timeval now;
+
+	if (tv == NULL)
+		return FALSE;
+
+	if (_wapi_get_boottime (&bt) == FALSE)
+		return FALSE;
+
+	if (gettimeofday (&now, NULL) == -1)
+		return FALSE;
+
+	tv->tv_sec = now.tv_sec - bt.tv_sec;
+	tv->tv_usec = now.tv_usec - bt.tv_usec;
+	return TRUE;
+}
+
 void _wapi_time_t_to_filetime (time_t timeval, WapiFileTime *filetime)
 {
-	guint64 ticks;
+	guint64	ticks;

-	ticks = ((guint64)timeval * 10000000) + 116444736000000000ULL;
-	filetime->dwLowDateTime = ticks & 0xFFFFFFFF;
+	ticks =	((guint64)timeval * 10000000) +	116444736000000000ULL;
+	filetime->dwLowDateTime	= ticks	& 0xFFFFFFFF;
 	filetime->dwHighDateTime = ticks >> 32;
 }

 void _wapi_timeval_to_filetime (struct timeval *tv, WapiFileTime *filetime)
 {
-	guint64 ticks;
+	guint64	ticks;

-	ticks = ((guint64)tv->tv_sec * 10000000) +
-		((guint64)tv->tv_usec * 10) + 116444736000000000ULL;
-	filetime->dwLowDateTime = ticks & 0xFFFFFFFF;
+	ticks =	((guint64)tv->tv_sec * 10000000) +
+		((guint64)tv->tv_usec *	10) + 116444736000000000ULL;
+	filetime->dwLowDateTime	= ticks	& 0xFFFFFFFF;
 	filetime->dwHighDateTime = ticks >> 32;
 }

-gboolean QueryPerformanceCounter(WapiLargeInteger *count G_GNUC_UNUSED)
+gboolean QueryPerformanceCounter (WapiLargeInteger *count G_GNUC_UNUSED)
 {
-	return(FALSE);
+	return FALSE;
 }

-gboolean QueryPerformanceFrequency(WapiLargeInteger *freq G_GNUC_UNUSED)
+gboolean QueryPerformanceFrequency (WapiLargeInteger *freq G_GNUC_UNUSED)
 {
-	return(FALSE);
+	return FALSE;
 }

 guint32 GetTickCount (void)
 {
 	struct timeval tv;
-	guint32 ret;
+
+	if (_wapi_get_uptime (&tv) == FALSE)
+		return 0;

-	ret=gettimeofday (&tv, NULL);
-	if(ret==-1) {
-		return(0);
-	}
-
-	/* This is supposed to return milliseconds since reboot but I
-	 * really can't be bothered to work out the uptime, especially
-	 * as the 32bit value wraps around every 47 days
-	 */
-	ret=(guint32)((tv.tv_sec * 1000) + (tv.tv_usec / 1000));
-
-#ifdef DEBUG
-	g_message (G_GNUC_PRETTY_FUNCTION ": returning %d", ret);
-#endif
-
-	return(ret);
+	return (guint32)((tv.tv_sec * 1000) + (tv.tv_usec / 1000));
 }
Index: timefuncs-private.h
===================================================================
--- timefuncs-private.h	(revision 41240)
+++ timefuncs-private.h	(working copy)
@@ -3,6 +3,7 @@
  *
  * Author:
  *	Dick Porter (dick@ximian.com)
+ *	Jesse Towner (townerj@gmail.com)
  *
  * (C) 2002 Ximian, Inc.
  */
@@ -14,6 +15,9 @@
 #include <glib.h>
 #include <sys/time.h>

+extern gboolean _wapi_get_boottime (struct timeval *tv);
+extern gboolean _wapi_get_uptime (struct timeval *tv);
+
 extern void _wapi_time_t_to_filetime (time_t timeval, WapiFileTime *filetime);
 extern void _wapi_timeval_to_filetime (struct timeval *tv,
 				       WapiFileTime *filetime);
