/*
 * intps.h: INTeger Platform Size types
 *
 * Author:
 *	Willibald Krenn
 *
 * put into public domain 
 */
#ifndef _INTPS_H
#define _INTPS_H	1

#include <glib.h>

#ifndef _STDINT_H
	/*
	  The types below are normally defined in stdint.h.
	  Unfortunately it's not clear if this header file is available
	  on the target system, so we redefine them here.
	  Note:
	  We could add a check for stdint.h in configure.in, but that
	  would make this header file dependant on config.h, which would
	  mean it could not be included in the set of header files that
	  are part of the public mono-'interface'.
	  So instead we rely on glib and it's types/macros.
	*/
	#if GLIB_SIZEOF_VOID_P == 8
		typedef guint64 uintptr_t;
		#ifndef __intptr_t_defined /*unistd.h*/
		typedef gint64 intptr_t;
		#endif
	#else
		typedef guint32 uintptr_t;
		#ifndef __intptr_t_defined /*unistd.h*/
		typedef gint32 intptr_t;
		#endif
	#endif  /*sizeof void*/
#endif /*_STDINT_H*/


/*
   Define some constants to ease printf handling.

   You may use the constants below whenever you have to printf some
   variable that changes size over different CPU-architectures.
   (e.g. all vars with g[s]size as type!)

   Note that glib also provides some definitions that help dealing
   with printf issues while using fixed size glib types:
	G_GINT64_FORMAT
	G_GUINT64_FORMAT
	G_GINT32_FORMAT
	G_GUINT32_FORMAT
	G_GINT16_FORMAT
	G_GUINT16_FORMAT
   One drawback: Glib's constants don't allow for hexadecimal output.
*/
#if GLIB_SIZEOF_VOID_P == 8
	#define MONO_FMT_PTR "l"
	#define MONO_FMT_64  "l"
#else
	/*default for 32bit machines*/
	#define MONO_FMT_PTR ""
	#define MONO_FMT_64  "ll"
#endif

/*some macros for casting pointer to int64 and vice-versa*/
#define MPOINTER_TO_GINT64(x) ((gint64) (intptr_t) (x))
#define MPOINTER_TO_GUINT64(x) ((guint64) (uintptr_t) (x))
#define MINT64_TO_GPOINTER(x) ((gpointer) (intptr_t) (x))
#define MUINT64_TO_GPOINTER(x) ((gpointer) (uintptr_t) (x))

#endif /*_INTPS_H*/
