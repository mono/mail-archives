#ifndef _INTPS_H
#define _INTPS_H	1

#include "config.h"

#if HAVE_STDINT_H == 1
	/*include stdint.h for types*/
	#include <stdint.h>
#else
	/*just in case..*/
	#ifndef _STDINT_H
		#include <glib.h>

		#if SIZEOF_VOID_P == 8
			typedef guint64 uintptr_t;
			typedef gint64 intptr_t;
		#else
			typedef guint32 uintptr_t;
			typedef gint32 intptr_t;
		#endif  /*sizeof void*/
	#endif /*_STDINT_H*/
#endif /*HAVE_STDINT_H*/

/*define some macros to ease printf handling..*/

	#if SIZEOF_VOID_P == 8
		/*only applies if sizeof(void*)==8*/
		#define d_INT_PTR_T "ld"
		#define d_INT_64    "ld"
		#define u_INT_PTR_T "lu"
		#define u_INT_64    "lu"
		#define x_INT_PTR_T "lx"
		#define x_INT_64    "lx"
	#else
		/*else switch back to normal*/
		#define d_INT_PTR_T "d"
		#define d_INT_64    "lld"
		#define u_INT_PTR_T "u"
		#define u_INT_64    "llu"
		#define x_INT_PTR_T "x"
		#define x_INT_64    "llx"
	#endif

#endif
