--- mcs/class/corlib/Test/System.Threading/InterlockedTest.cs.~0.0.~	2004-10-09 22:23:53.000000000 +0200
+++ mcs/class/corlib/Test/System.Threading/InterlockedTest.cs	2004-10-08 18:36:26.000000000 +0200
@@ -0,0 +1,253 @@
+//
+// InterlockedTest.cs - NUnit Test Cases for System.Threading.Interlocked
+//
+// Author:
+//   Luca Barbieri (luca.barbieri@gmail.com)
+//
+// (C) 2004 Luca Barbieri
+// 
+
+using NUnit.Framework;
+using System;
+using System.Threading;
+
+namespace MonoTests.System.Threading
+{
+	[TestFixture]
+	public class InterlockedTest
+	{
+		int int32;
+		long int64;
+		float flt;
+		double dbl;
+		object obj;
+		IntPtr iptr;
+
+		const int int32_1 = 0x12490082;
+		const int int32_2 = 0x24981071;
+		const int int32_3 = 0x36078912;
+		const long int64_1 = 0x1412803412472901L;
+		const long int64_2 = 0x2470232089701124L;
+		const long int64_3 = 0x3056432945919433L;
+		const float flt_1 = 141287.109874f;
+		const float flt_2 = 234108.324113f;
+		const float flt_3 = 342419.752395f;
+		const double dbl_1 = 141287.109874;
+		const double dbl_2 = 234108.324113;
+		const double dbl_3 = 342419.752395;
+		readonly object obj_1 = "obj_1";
+		readonly object obj_2 = "obj_2";
+		readonly object obj_3 = "obj_3";
+		readonly IntPtr iptr_1 = (IntPtr)int32_1;
+		readonly IntPtr iptr_2 = (IntPtr)int32_2;
+		readonly IntPtr iptr_3 = (IntPtr)int32_3;
+		
+		[Test]
+		public void TestExchange_Int32 ()
+		{
+			int32 = int32_1;
+			Assert.AreEqual(int32_1, Interlocked.Exchange(ref int32, int32_2));
+			Assert.AreEqual(int32_2, int32);
+		}
+
+		[Test]
+		public void TestExchange_Flt ()
+		{
+			flt = flt_1;
+			Assert.AreEqual(flt_1, Interlocked.Exchange(ref flt, flt_2));
+			Assert.AreEqual(flt_2, flt);
+		}
+
+		[Test]
+		public void TestExchange_Obj ()
+		{
+			obj = obj_1;
+			Assert.AreEqual(obj_1, Interlocked.Exchange(ref obj, obj_2));
+			Assert.AreEqual(obj_2, obj);
+		}
+
+#if NET_2_0
+		[Test]
+		public void TestExchange_Int64 ()
+		{
+			int64 = int64_1;
+			Assert.AreEqual(int64_1, Interlocked.Exchange(ref int64, int64_2));
+			Assert.AreEqual(int64_2, int64);
+		}
+
+		[Test]
+		public void TestExchange_Dbl ()
+		{
+			dbl = dbl_1;
+			Assert.AreEqual(dbl_1, Interlocked.Exchange(ref dbl, dbl_2));
+			Assert.AreEqual(dbl_2, dbl);
+		}
+
+		[Test]
+		public void TestExchange_Iptr ()
+		{
+			iptr = iptr_1;
+			Assert.AreEqual(iptr_1, Interlocked.Exchange(ref iptr, iptr_2));
+			Assert.AreEqual(iptr_2, iptr);
+		}
+#endif
+
+		[Test]
+		public void TestCompareExchange_Int32 ()
+		{
+			int32 = int32_1;
+			Assert.AreEqual(int32_1, Interlocked.CompareExchange(ref int32, int32_2, int32_1));
+			Assert.AreEqual(int32_2, int32);
+		}
+
+		[Test]
+		public void TestCompareExchange_Flt ()
+		{
+			flt = flt_1;
+			Assert.AreEqual(flt_1, Interlocked.CompareExchange(ref flt, flt_2, flt_1));
+			Assert.AreEqual(flt_2, flt);
+		}
+
+		[Test]
+		public void TestCompareExchange_Obj ()
+		{
+			obj = obj_1;
+			Assert.AreEqual(obj_1, Interlocked.CompareExchange(ref obj, obj_2, obj_1));
+			Assert.AreEqual(obj_2, obj);
+		}
+		
+#if NET_2_0
+		[Test]
+		public void TestCompareExchange_Int64 ()
+		{
+			int64 = int64_1;
+			Assert.AreEqual(int64_1, Interlocked.CompareExchange(ref int64, int64_2, int64_1));
+			Assert.AreEqual(int64_2, int64);
+		}
+
+		[Test]
+		public void TestCompareExchange_Dbl ()
+		{
+			dbl = dbl_1;
+			Assert.AreEqual(dbl_1, Interlocked.CompareExchange(ref dbl, dbl_2, dbl_1));
+			Assert.AreEqual(dbl_2, dbl);
+		}
+
+		[Test]
+		public void TestCompareExchange_Iptr ()
+		{
+			iptr = iptr_1;
+			Assert.AreEqual(iptr_1, Interlocked.CompareExchange(ref iptr, iptr_2, iptr_1));
+			Assert.AreEqual(iptr_2, iptr);
+		}
+#endif
+		
+		[Test]
+		public void TestCompareExchange_Failed_Int32 ()
+		{
+			int32 = int32_1;
+			Assert.AreEqual(int32_1, Interlocked.CompareExchange(ref int32, int32_2, int32_3));
+			Assert.AreEqual(int32_1, int32);
+		}
+
+		[Test]
+		public void TestCompareExchange_Failed_Flt ()
+		{
+			flt = flt_1;
+			Assert.AreEqual(flt_1, Interlocked.CompareExchange(ref flt, flt_2, flt_3));
+			Assert.AreEqual(flt_1, flt);
+		}
+
+		[Test]
+		public void TestCompareExchange_Failed_Obj ()
+		{
+			obj = obj_1;
+			Assert.AreEqual(obj_1, Interlocked.CompareExchange(ref obj, obj_2, obj_3));
+			Assert.AreEqual(obj_1, obj);
+		}
+
+#if NET_2_0
+		[Test]
+		public void TestCompareExchange_Failed_Int64 ()
+		{
+			int64 = int64_1;
+			Assert.AreEqual(int64_1, Interlocked.CompareExchange(ref int64, int64_2, int64_3));
+			Assert.AreEqual(int64_1, int64);
+		}
+
+		[Test]
+		public void TestCompareExchange_Failed_Dbl ()
+		{
+			dbl = dbl_1;
+			Assert.AreEqual(dbl_1, Interlocked.CompareExchange(ref dbl, dbl_2, dbl_3));
+			Assert.AreEqual(dbl_1, dbl);
+		}
+
+		[Test]
+		public void TestCompareExchange_Failed_Iptr ()
+		{
+			iptr = iptr_1;
+			Assert.AreEqual(iptr_1, Interlocked.CompareExchange(ref iptr, iptr_2, iptr_3));
+			Assert.AreEqual(iptr_1, iptr);
+		}
+#endif
+
+		[Test]
+		public void TestIncrement_Int32 ()
+		{
+			int32 = int32_1;
+			Assert.AreEqual(int32_1 + 1, Interlocked.Increment(ref int32));
+			Assert.AreEqual(int32_1 + 1, int32);
+		}
+
+		[Test]
+		public void TestIncrement_Int64 ()
+		{
+			int64 = int64_1;
+			Assert.AreEqual(int64_1 + 1, Interlocked.Increment(ref int64), "func");
+			Assert.AreEqual(int64_1 + 1, int64, "value");
+		}
+
+		[Test]
+		public void TestDecrement_Int32 ()
+		{
+			int32 = int32_1;
+			Assert.AreEqual(int32_1 - 1, Interlocked.Decrement(ref int32));
+			Assert.AreEqual(int32_1 - 1, int32);
+		}
+
+		[Test]
+		public void TestDecrement_Int64 ()
+		{
+			int64 = int64_1;
+			Assert.AreEqual(int64_1 - 1, Interlocked.Decrement(ref int64));
+			Assert.AreEqual(int64_1 - 1, int64);
+		}
+
+#if NET_2_0
+		[Test]
+		public void TestAdd_Int32 ()
+		{
+			int32 = int32_1;
+			Assert.AreEqual(int32_1, Interlocked.Add(ref int32, int32_2));
+			Assert.AreEqual(int32_1 + int32_2, int32);
+		}
+
+		[Test]
+		public void TestAdd_Int64 ()
+		{
+			int64 = int64_1;
+			Assert.AreEqual(int64_1, Interlocked.Add(ref int64, int64_2));
+			Assert.AreEqual(int64_1 + int64_2, int64);
+		}
+
+		[Test]
+		public void TestRead_Int64()
+		{
+			int64 = int64_1;
+			Assert.AreEqual(int64_1, Interlocked.Read(ref int64));
+			Assert.AreEqual(int64_1, int64);
+		}
+#endif
+	}
+}
--- mcs/class/corlib/System.Threading/Interlocked.cs.~1.5.~	2004-09-08 16:07:05.000000000 +0200
+++ mcs/class/corlib/System.Threading/Interlocked.cs	2004-10-08 01:03:11.000000000 +0200
@@ -78,6 +78,35 @@ namespace System.Threading
 
 		[MethodImplAttribute(MethodImplOptions.InternalCall)]
 		public extern static float Exchange(ref float location1, float value);
+
+#if NET_2_0
+		[MethodImplAttribute(MethodImplOptions.InternalCall)]
+		public extern static long CompareExchange(ref long location1, long value, long comparand);
+
+		[MethodImplAttribute(MethodImplOptions.InternalCall)]
+		public extern static IntPtr CompareExchange(ref IntPtr location1, IntPtr value, IntPtr comparand);
+
+		[MethodImplAttribute(MethodImplOptions.InternalCall)]
+		public extern static double CompareExchange(ref double location1, double value, double comparand);
+
+		[MethodImplAttribute(MethodImplOptions.InternalCall)]
+		public extern static long Exchange(ref long location1, long value);
+
+		[MethodImplAttribute(MethodImplOptions.InternalCall)]
+		public extern static IntPtr Exchange(ref IntPtr location1, IntPtr value);
+
+		[MethodImplAttribute(MethodImplOptions.InternalCall)]
+		public extern static double Exchange(ref double location1, double value);
+
+		[MethodImplAttribute(MethodImplOptions.InternalCall)]
+		public extern static long Read(ref long location1);
+
+		[MethodImplAttribute(MethodImplOptions.InternalCall)]
+		public extern static int Add(ref int location1, int add);
+
+		[MethodImplAttribute(MethodImplOptions.InternalCall)]
+		public extern static long Add(ref long location1, long add);
+#endif
 	}
 }
 
--- mono/mono/io-layer/atomic-locked.h.~0.0.~	2004-10-09 22:26:43.000000000 +0200
+++ mono/mono/io-layer/atomic-locked.h	2004-10-09 13:01:29.000000000 +0200
@@ -0,0 +1,102 @@
+/* Convenience header. Do not include */
+
+FUNC(T, Read)(volatile T *val)
+{
+#ifdef A64
+	return ATOMIC_EXPR(*val);
+#else
+	return *val;
+#endif
+}
+
+FUNC(void, Write)(volatile T *dest, T exch)
+{
+	ATOMIC_DO(*dest = exch);
+}
+
+FUNC(T, CompareExchange)(volatile T *dest, T exch, T comp)
+{
+	T old;
+
+	ATOMIC_BEGIN {
+		old = *dest;
+
+		if(old == comp)
+			*dest = exch;
+	}
+	ATOMIC_END;
+	
+	return old;
+}
+
+FUNC(T, Exchange)(volatile T *dest, T exch)
+{
+	T old;
+
+	ATOMIC_BEGIN {
+		old = *dest;
+		*dest = exch;
+	}
+	ATOMIC_END;
+	
+	return old;
+}
+
+FUNC(T, ExchangeAdd)(volatile T *dest, T add)
+{
+	T old;
+
+	ATOMIC_BEGIN {
+		old = *dest;
+		*dest = old + add;
+	}
+	ATOMIC_END;
+	
+	return old;
+}
+
+FUNC(T, Increment)(volatile T *dest)
+{
+	T value;
+
+	ATOMIC_BEGIN {
+		value = *dest + 1;
+		*dest = value;
+	}
+	ATOMIC_END;
+	
+	return value;
+}
+
+FUNC(T, Decrement)(volatile T *dest)
+{
+	T value;
+
+	ATOMIC_BEGIN {
+		value = *dest - 1;
+		*dest = value;
+	}
+	ATOMIC_END;
+	
+	return value;
+}
+
+FUNC(void, Add)(volatile T *dest, T add)
+{
+	ATOMIC_DO(*dest += add);
+}
+
+FUNC(void, Sub)(volatile T *dest, T add)
+{
+	ATOMIC_DO(*dest -= add);
+}
+
+FUNC(void, IncrementBlind)(volatile T *dest)
+{
+	ATOMIC_DO(++*dest);
+}
+
+FUNC(void, DecrementBlind)(volatile T *dest)
+{
+	ATOMIC_DO(--*dest);
+}
--- mono/mono/io-layer/wapi.h.~1.12.~	2004-04-02 17:08:46.000000000 +0200
+++ mono/mono/io-layer/wapi.h	2004-10-08 14:52:52.000000000 +0200
@@ -12,6 +12,7 @@
 
 #include <mono/io-layer/types.h>
 #include <mono/io-layer/macros.h>
+#include <mono/io-layer/arch.h>
 #include <mono/io-layer/handles.h>
 #include <mono/io-layer/io.h>
 #include <mono/io-layer/access.h>
--- mono/mono/io-layer/atomic.c.~1.8.~	2004-04-28 23:54:04.000000000 +0200
+++ mono/mono/io-layer/atomic.c	2004-10-09 12:48:50.000000000 +0200
@@ -14,185 +14,56 @@
 
 #include "mono/io-layer/wapi.h"
 
-#ifdef WAPI_ATOMIC_ASM
-#if defined(sparc) || defined (__sparc__)
-volatile unsigned char _wapi_sparc_lock;
-#endif
-#else
-
 static pthread_mutex_t spin = PTHREAD_MUTEX_INITIALIZER;
-static mono_once_t spin_once=MONO_ONCE_INIT;
 
-static void spin_init(void)
-{
-	g_warning("Using non-atomic functions!");
-}
-
-gint32 InterlockedCompareExchange(volatile gint32 *dest, gint32 exch,
-				  gint32 comp)
-{
-	gint32 old;
-	int ret;
-	
-	mono_once(&spin_once, spin_init);
-	
-	pthread_cleanup_push ((void(*)(void *))pthread_mutex_unlock,
-			      (void *)&spin);
-	ret = pthread_mutex_lock(&spin);
-	g_assert (ret == 0);
-	
-	old= *dest;
-	if(old==comp) {
-		*dest=exch;
-	}
-	
-	ret = pthread_mutex_unlock(&spin);
-	g_assert (ret == 0);
-	
-	pthread_cleanup_pop (0);
-
-	return(old);
-}
+#define ATOMIC_BEGIN \
+	do { \
+	int thr_ret; \
+	pthread_cleanup_push ((void(*)(void *))pthread_mutex_unlock, \
+			      (void *)&spin); \
+	thr_ret = pthread_mutex_lock(&spin); \
+	g_assert (thr_ret == 0); \
+	do {
 
-gpointer InterlockedCompareExchangePointer(volatile gpointer *dest,
-					   gpointer exch, gpointer comp)
-{
-	gpointer old;
-	int ret;
-	
-	mono_once(&spin_once, spin_init);
-	
-	pthread_cleanup_push ((void(*)(void *))pthread_mutex_unlock,
-			      (void *)&spin);
-	ret = pthread_mutex_lock(&spin);
-	g_assert (ret == 0);
-	
-	old= *dest;
-	if(old==comp) {
-		*dest=exch;
-	}
-	
-	ret = pthread_mutex_unlock(&spin);
-	g_assert (ret == 0);
-	
-	pthread_cleanup_pop (0);
+#define ATOMIC_END \
+	; } while(0); \
+	thr_ret = pthread_mutex_unlock(&spin); \
+	g_assert (thr_ret == 0); \
+	pthread_cleanup_pop (0); \
+	} while(0)				 
 
-	return(old);
-}
+#define ATOMIC_DO(body) ATOMIC_BEGIN body ATOMIC_END
 
-gint32 InterlockedIncrement(volatile gint32 *dest)
-{
-	gint32 ret;
-	int thr_ret;
-	
-	mono_once(&spin_once, spin_init);
-	
-	pthread_cleanup_push ((void(*)(void *))pthread_mutex_unlock,
-			      (void *)&spin);
-	thr_ret = pthread_mutex_lock(&spin);
-	g_assert (thr_ret == 0);
-	
-	*dest++;
-	ret= *dest;
-	
-	thr_ret = pthread_mutex_unlock(&spin);
-	g_assert (thr_ret == 0);
-	
-	pthread_cleanup_pop (0);
-	
-	return(ret);
-}
+#define ATOMIC_EXPR(body) \
+	({ \
+	__typeof__(body) __ret; \
+	ATOMIC_DO(__ret = body); \
+	__ret; \
+	})
 
-gint32 InterlockedDecrement(volatile gint32 *dest)
-{
-	gint32 ret;
-	int thr_ret;
-	
-	mono_once(&spin_once, spin_init);
-	
-	pthread_cleanup_push ((void(*)(void *))pthread_mutex_unlock,
-			      (void *)&spin);
-	thr_ret = pthread_mutex_lock(&spin);
-	g_assert (thr_ret == 0);
-	
-	*dest--;
-	ret= *dest;
-	
-	thr_ret = pthread_mutex_unlock(&spin);
-	g_assert (thr_ret == 0);
-	
-	pthread_cleanup_pop (0);
-	
-	return(ret);
-}
+#define FUNC(r, n) r Interlocked##n##_Locked
+#define T gint32
+#include "atomic-locked.h"
+#undef FUNC
+#undef T
 
-gint32 InterlockedExchange(volatile gint32 *dest, gint32 exch)
-{
-	gint32 ret;
-	int thr_ret;
-	
-	mono_once(&spin_once, spin_init);
-	
-	pthread_cleanup_push ((void(*)(void *))pthread_mutex_unlock,
-			      (void *)&spin);
-	thr_ret = pthread_mutex_lock(&spin);
-	g_assert (thr_ret == 0);
+#define FUNC(r, n) r Interlocked##n##64_Locked
+#define T gint64
+#define A64
+#include "atomic-locked.h"
+#undef A64
+#undef FUNC
+#undef T
 
-	ret=*dest;
-	*dest=exch;
-	
-	thr_ret = pthread_mutex_unlock(&spin);
-	g_assert (thr_ret == 0);
-	
-	pthread_cleanup_pop (0);
-	
-	return(ret);
-}
+#if defined(sparc) || defined (__sparc__)
+volatile unsigned char _wapi_sparc_lock;
+#endif
 
-gpointer InterlockedExchangePointer(volatile gpointer *dest, gpointer exch)
-{
-	gpointer ret;
-	int thr_ret;
-	
-	mono_once(&spin_once, spin_init);
-	
-	pthread_cleanup_push ((void(*)(void *))pthread_mutex_unlock,
-			      (void *)&spin);
-	thr_ret = pthread_mutex_lock(&spin);
-	g_assert (thr_ret == 0);
-	
-	ret=*dest;
-	*dest=exch;
-	
-	thr_ret = pthread_mutex_unlock(&spin);
-	g_assert (thr_ret == 0);
-	
-	pthread_cleanup_pop (0);
-	
-	return(ret);
-}
+#ifndef WAPI_ATOMIC_ASM
+static void spin_init(void) __attribute__((constructor));
 
-gint32 InterlockedExchangeAdd(volatile gint32 *dest, gint32 add)
+static void spin_init(void)
 {
-	gint32 ret;
-	int thr_ret;
-	
-	mono_once(&spin_once, spin_init);
-	
-	pthread_cleanup_push ((void(*)(void *))pthread_mutex_unlock,
-			      (void *)&spin);
-	thr_ret = pthread_mutex_lock(&spin);
-	g_assert (thr_ret == 0);
-
-	ret= *dest;
-	*dest+=add;
-	
-	thr_ret = pthread_mutex_unlock(&spin);
-	g_assert (thr_ret == 0);
-
-	pthread_cleanup_pop (0);
-
-	return(ret);
+	g_warning("Using non-atomic functions!");
 }
-
 #endif
--- mono/mono/io-layer/Makefile.am.~1.26.~	2004-04-02 17:08:46.000000000 +0200
+++ mono/mono/io-layer/Makefile.am	2004-10-08 17:18:28.000000000 +0200
@@ -11,6 +11,7 @@ libwapiincludedir = $(includedir)/mono/i
 
 OTHER_H = \
 	access.h	\
+	arch.h		\
 	atomic.h	\
 	context.h	\
 	critical-sections.h	\
@@ -38,6 +39,7 @@ OTHER_H = \
 
 OTHER_SRC = \
 	access.h		\
+	arch.c			\
 	atomic.c		\
 	atomic.h		\
 	context.c		\
--- mono/mono/io-layer/arch.c.~0.0.~	2004-10-09 21:50:29.000000000 +0200
+++ mono/mono/io-layer/arch.c	2004-10-09 23:30:20.823059414 +0200
@@ -0,0 +1,91 @@
+/*
+ * arch.c:  Architecture-specific code
+ *
+ * Author:
+ *	Luca Barbieri (luca.barbieri@gmail.com)
+ *
+ * (C) 2004 Luca Barbieri
+ */
+
+#include <config.h>
+#include <glib.h>
+#include <pthread.h>
+
+#include <mono/io-layer/wapi.h>
+
+#ifdef __i386__
+int mono_x86_cpuid_eax, mono_x86_cpuid_ebx, mono_x86_cpuid_ecx, mono_x86_cpuid_edx;
+int mono_x86_rw64_impl_var;
+
+static const guchar cpuid_impl [] = {
+	0x55,                   	/* push   %ebp */
+	0x89, 0xe5,                	/* mov    %esp,%ebp */
+	0x53,                   	/* push   %ebx */
+	0x8b, 0x45, 0x08,             	/* mov    0x8(%ebp),%eax */
+	0x0f, 0xa2,                	/* cpuid   */
+	0x50,                   	/* push   %eax */
+	0x8b, 0x45, 0x10,             	/* mov    0x10(%ebp),%eax */
+	0x89, 0x18,                	/* mov    %ebx,(%eax) */
+	0x8b, 0x45, 0x14,             	/* mov    0x14(%ebp),%eax */
+	0x89, 0x08,                	/* mov    %ecx,(%eax) */
+	0x8b, 0x45, 0x18,             	/* mov    0x18(%ebp),%eax */
+	0x89, 0x10,                	/* mov    %edx,(%eax) */
+	0x58,                   	/* pop    %eax */
+	0x8b, 0x55, 0x0c,             	/* mov    0xc(%ebp),%edx */
+	0x89, 0x02,                	/* mov    %eax,(%edx) */
+	0x5b,                   	/* pop    %ebx */
+	0xc9,                   	/* leave   */
+	0xc3,                   	/* ret     */
+};
+
+typedef void (*CpuidFunc) (int id, int* p_eax, int* p_ebx, int* p_ecx, int* p_edx);
+
+static int 
+cpuid (int id, int* p_eax, int* p_ebx, int* p_ecx, int* p_edx)
+{
+	int have_cpuid = 0;
+	__asm__  __volatile__ (
+		"pushfl\n"
+		"popl %%eax\n"
+		"movl %%eax, %%edx\n"
+		"xorl $0x200000, %%eax\n"
+		"pushl %%eax\n"
+		"popfl\n"
+		"pushfl\n"
+		"popl %%eax\n"
+		"xorl %%edx, %%eax\n"
+		"andl $0x200000, %%eax\n"
+		"movl %%eax, %0"
+		: "=r" (have_cpuid)
+		:
+		: "%eax", "%edx"
+	);
+
+	if (have_cpuid) {
+		CpuidFunc func = (CpuidFunc)cpuid_impl;
+		func (id, p_eax, p_ebx, p_ecx, p_edx);
+		/*
+		 * We use this approach because of issues with gcc and pic code, see:
+		 * http://gcc.gnu.org/cgi-bin/gnatsweb.pl?cmd=view%20audit-trail&database=gcc&pr=7329
+		__asm__ __volatile__ ("cpuid"
+			: "=a" (*p_eax), "=b" (*p_ebx), "=c" (*p_ecx), "=d" (*p_edx)
+			: "a" (id));
+		*/
+		return 1;
+	}
+	return 0;
+}
+
+static void arch_init(void) __attribute__((constructor));
+
+static void arch_init(void)
+{
+	cpuid(1, &mono_x86_cpuid_eax, &mono_x86_cpuid_ebx, &mono_x86_cpuid_ecx, &mono_x86_cpuid_edx);
+	
+	if(mono_x86_have_sse2)
+		mono_x86_rw64_impl_var = 2;
+	else if(mono_x86_have_cx8)
+		mono_x86_rw64_impl_var = 1;
+}
+
+#endif
--- mono/mono/io-layer/arch.h.~0.0.~	2004-10-09 22:23:09.000000000 +0200
+++ mono/mono/io-layer/arch.h	2004-10-09 23:32:53.870383898 +0200
@@ -0,0 +1,72 @@
+/*
+ * arch.h:  Architecture-specific code
+ *
+ * Author:
+ *	Luca Barbieri (luca.barbieri@gmail.com)
+ *
+ * (C) 2004 Luca Barbieri
+ */
+
+#ifndef _WAPI_ARCH_H_
+#define _WAPI_ARCH_H_
+
+#include <glib.h>
+
+#include "mono/io-layer/wapi.h"
+
+#ifdef __x86_64__
+
+#define mono_x86_have_cmov 1
+#define mono_x86_have_cx8 1
+#define mono_x86_have_mmx 1
+#define mono_x86_have_sse 1
+#define mono_x86_have_sse2 1
+
+#elif defined(__i386__)
+
+extern int mono_x86_cpuid_eax, mono_x86_cpuid_ebx, mono_x86_cpuid_ecx, mono_x86_cpuid_edx;
+
+#if defined(__i586__) || defined(__i686__) || defined(__pentium4__) || defined(__k6__) || defined(__athlon__) || defined(__k8__)
+#define mono_x86_have_fpu 1
+#else
+#define mono_x86_have_fpu (mono_x86_cpuid_edx & (1 << 0))
+#endif
+
+#if defined(__i586__) || defined(__i686__) || defined(__pentium4__) || defined(__athlon__) || defined(__k8__)
+#define mono_x86_have_cx8 1
+#else
+#define mono_x86_have_cx8 (mono_x86_cpuid_edx & (1 << 8))
+#endif
+
+#if defined(__i686__) || defined(__pentium4__) || defined(__athlon__) || defined(__k8__)
+#define mono_x86_have_cmov 1
+#else
+#define mono_x86_have_cmov (mono_x86_cpuid_edx & (1 << 15))
+#endif
+
+#ifdef __MMX__
+#define mono_x86_have_mmx 1
+#else
+#define mono_x86_have_mmx (mono_x86_cpuid_edx & (1 << 23))
+#endif
+
+#ifdef __SSE__
+#define mono_x86_have_sse 1
+#else
+#define mono_x86_have_sse (mono_x86_cpuid_edx & (1 << 25))
+#endif
+
+#ifdef __SSE2__
+#define mono_x86_rw64_impl 2
+#define mono_x86_have_sse2 1
+#else
+extern int mono_x86_rw64_impl_var;
+#define mono_x86_rw64_impl mono_x86_rw64_impl_var
+#define mono_x86_have_sse2 (mono_x86_cpuid_edx & (1 << 26))
+#endif
+#endif
+
+
+
+
+#endif
--- mono/mono/io-layer/atomic.h.~1.22.~	2004-08-04 22:43:11.000000000 +0200
+++ mono/mono/io-layer/atomic.h	2004-10-10 00:17:47.000000000 +0200
@@ -10,10 +10,37 @@
 #ifndef _WAPI_ATOMIC_H_
 #define _WAPI_ATOMIC_H_
 
+#ifndef SIZEOF_VOID_P
+#include <config.h>
+#endif
+
 #include <glib.h>
 
 #include "mono/io-layer/wapi.h"
 
+extern void InterlockedAdd_Locked(volatile gint32 *val, gint32 add);
+extern void InterlockedAdd64_Locked(volatile gint64 *val, gint64 add);
+extern gint32 InterlockedCompareExchange_Locked(volatile gint32 *val, gint32 exch, gint32 comp);
+extern gint64 InterlockedCompareExchange64_Locked(volatile gint64 *val, gint64 exch, gint64 comp);
+extern gint32 InterlockedDecrement_Locked(volatile gint32 *val);
+extern gint64 InterlockedDecrement64_Locked(volatile gint64 *val);
+extern void InterlockedDecrementBlind_Locked(volatile gint32 *val);
+extern void InterlockedDecrementBlind64_Locked(volatile gint64 *val);
+extern gint32 InterlockedExchange_Locked(volatile gint32 *val, gint32 new_val);
+extern gint64 InterlockedExchange64_Locked(volatile gint64 *val, gint64 new_val);
+extern gint32 InterlockedExchangeAdd_Locked(volatile gint32 *val, gint32 add);
+extern gint64 InterlockedExchangeAdd64_Locked(volatile gint64 *val, gint64 add);
+extern gint32 InterlockedIncrement_Locked(volatile gint32 *val);
+extern gint64 InterlockedIncrement64_Locked(volatile gint64 *val);
+extern void InterlockedIncrementBlind_Locked(volatile gint32 *val);
+extern void InterlockedIncrementBlind64_Locked(volatile gint64 *val);
+extern gint32 InterlockedRead_Locked(volatile gint32 *val);
+extern gint64 InterlockedRead64_Locked(volatile gint64 *val);
+extern void InterlockedSub_Locked(volatile gint32 *val, gint32 add);
+extern void InterlockedSub64_Locked(volatile gint64 *val, gint64 add);
+extern void InterlockedWrite_Locked(volatile gint32 *val, gint32 new_val);
+extern void InterlockedWrite64_Locked(volatile gint64 *val, gint64 new_val);
+
 #if defined(__i386__) || defined(__x86_64__)
 #define WAPI_ATOMIC_ASM
 
@@ -26,54 +53,30 @@
  * fall back to the non-atomic C versions of these calls.
  */
 
-static inline gint32 InterlockedCompareExchange(volatile gint32 *dest,
-						gint32 exch, gint32 comp)
-{
-	gint32 old;
-
-	__asm__ __volatile__ ("lock; cmpxchgl %2, %0"
-			      : "=m" (*dest), "=a" (old)
-			      : "r" (exch), "m" (*dest), "a" (comp));	
-	return(old);
-}
-
-static inline gpointer InterlockedCompareExchangePointer(volatile gpointer *dest, gpointer exch, gpointer comp)
-{
-	gpointer old;
-
-	__asm__ __volatile__ ("lock; "
-#ifdef __x86_64__
-			      "cmpxchgq"
+#ifdef __PIC__
+#define PIC_EBX gint32 dummy_ebx
 #else
-			      "cmpxchgl"
+#define PIC_EBX
 #endif
-			      " %2, %0"
-			      : "=m" (*dest), "=a" (old)
-			      : "r" (exch), "m" (*dest), "a" (comp));	
 
-	return(old);
+static inline gint32 InterlockedRead(volatile gint32 *val)
+{
+	return *val;
 }
 
-static inline gint32 InterlockedIncrement(volatile gint32 *val)
+static inline void InterlockedWrite(volatile gint32 *val, gint32 new_val)
 {
-	gint32 tmp;
-	
-	__asm__ __volatile__ ("lock; xaddl %0, %1"
-			      : "=r" (tmp), "=m" (*val)
-			      : "0" (1), "m" (*val));
-
-	return(tmp+1);
+	*val = new_val;
 }
 
-static inline gint32 InterlockedDecrement(volatile gint32 *val)
+static inline gint32 InterlockedCompareExchange(volatile gint32 *val,
+						gint32 exch, gint32 comp)
 {
-	gint32 tmp;
-	
-	__asm__ __volatile__ ("lock; xaddl %0, %1"
-			      : "=r" (tmp), "=m" (*val)
-			      : "0" (-1), "m" (*val));
+	__asm__ __volatile__ ("lock; cmpxchgl %2, %0"
+			      : "+m" (*val), "+a" (comp)
+			      : "r" (exch));
 
-	return(tmp-1);
+	return comp;
 }
 
 /*
@@ -86,48 +89,285 @@ static inline gint32 InterlockedDecremen
  *
  * For the time being, http://msdn.microsoft.com/msdnmag/issues/0700/Win32/
  * might work.  Bet it will change soon enough though.
+ *
+ *
+ * The argument seems to be that since Microsoft used a cmpxchg, it must be right.
+ * However, a xchgl does the same faster.
  */
 static inline gint32 InterlockedExchange(volatile gint32 *val, gint32 new_val)
 {
-	gint32 ret;
-	
-	__asm__ __volatile__ ("1:; lock; cmpxchgl %2, %0; jne 1b"
-			      : "=m" (*val), "=a" (ret)
-			      : "r" (new_val), "m" (*val), "a" (*val));
+	__asm__ __volatile__ ("xchgl %1, %0"
+			      : "+m" (*val), "+r" (new_val));
 
-	return(ret);
+	return new_val;
 }
 
-static inline gpointer InterlockedExchangePointer(volatile gpointer *val,
-						  gpointer new_val)
+static inline gint32 InterlockedExchangeAdd(volatile gint32 *val, gint32 add)
 {
-	gpointer ret;
+	__asm__ __volatile__ ("lock; xaddl %1, %0"
+			      : "+m" (*val), "+r" (add));
 	
-	__asm__ __volatile__ ("1:; lock; "
+	return add;
+}
+
+static inline gint32 InterlockedIncrement(volatile gint32 *val)
+{
+	return InterlockedExchangeAdd(val, 1) + 1;
+}
+
+static inline gint32 InterlockedDecrement(volatile gint32 *val)
+{
+	return InterlockedExchangeAdd(val, -1) - 1;
+}
+
+static inline void InterlockedAdd(volatile gint32 *val, gint32 add)
+{
+	__asm__ __volatile__ ("lock; addl %1, %0"
+			      : "+m" (*val)
+			      : "r" (add));
+}
+
+static inline void InterlockedSub(volatile gint32 *val, gint32 add)
+{
+	__asm__ __volatile__ ("lock; subl %1, %0"
+			      : "+m" (*val)
+			      : "r" (add));
+}
+
+static inline void InterlockedIncrementBlind(volatile gint32 *val)
+{
+	__asm__ __volatile__ ("lock; incl %0"
+			      : "+m" (*val));
+}
+
+static inline void InterlockedDecrementBlind(volatile gint32 *val)
+{
+	__asm__ __volatile__ ("lock; decl %0"
+			      : "+m" (*val));
+}
+
+
+/* start of 64-bit operations */
+
 #ifdef __x86_64__
-			      "cmpxchgq"
+
+static inline gint64 InterlockedRead64(volatile gint64 *val)
+{
+	return *val;
+}
+
+static inline void InterlockedWrite64(volatile gint64 *val, gint64 new_val)
+{
+	*val = new_val;
+}
+
+static inline gint64 InterlockedCompareExchange64(volatile gint64 *val,
+						gint64 exch, gint64 comp)
+{
+	__asm__ __volatile__ ("lock; cmpxchgq %2, %0"
+			      : "+m" (*val), "+a" (comp)
+			      : "r" (exch));
+
+	return comp;
+}
+
+static inline gint64 InterlockedExchange64(volatile gint64 *val, gint64 new_val)
+{
+	__asm__ __volatile__ ("xchgq %1, %0"
+			      : "+m" (*val), "+r" (new_val));
+
+	return new_val;
+}
+
+static inline gint64 InterlockedExchangeAdd64(volatile gint64 *val, gint64 add)
+{
+	__asm__ __volatile__ ("lock; xaddq %1, %0"
+			      : "+m" (*val), "+r" (add));
+	
+	return add;
+}
+
+static inline void InterlockedAdd64(volatile gint64 *val, gint64 add)
+{
+	__asm__ __volatile__ ("lock; addq %1, %0"
+			      : "+m" (*val)
+			      : "r" (add));
+}
+
+static inline void InterlockedSub64(volatile gint64 *val, gint64 add)
+{
+	__asm__ __volatile__ ("lock; subq %1, %0"
+			      : "+m" (*val)
+			      : "r" (add));
+}
+
+static inline void InterlockedIncrementBlind64(volatile gint64 *val)
+{
+	__asm__ __volatile__ ("lock; incq %0"
+			      : "+m" (*val));
+}
+
+static inline void InterlockedDecrementBlind64(volatile gint64 *val)
+{
+	__asm__ __volatile__ ("lock; decq %0"
+			      : "+m" (*val));
+}
+
+#else /* not __x86_64__ */
+
+static inline gint64 InterlockedRead64(volatile gint64 *val)
+{
+	gint64 ret;
+
+	if(__builtin_expect(mono_x86_rw64_impl == 2, 1))
+	{
+		__asm__ __volatile__ ("movq %1, %%xmm0; movd %%xmm0, %%eax; psrlq $32, %%xmm0; movd %%xmm0, %%edx" : "=A" (ret) : "m" (*val) : "xmm0");
+	}
+	else if(__builtin_expect(mono_x86_rw64_impl == 1, 1))
+	{
+		/* We call cmpxchg8b with comparand == new_value, where comparand is whatever happens to lie in %ecx:%ebx.
+		   If it matches, we rewrite the old value and have the correct return value in %edx:%eax.
+		   If it doesn't match, cmpxchg8b will put the old value in %edx:%eax for us.
+		   Note that the lock prefix is necessary.
+		*/ 
+		   
+		__asm__ __volatile__ ("movl %%ebx, %%eax; movl %%ecx, %%edx; lock; cmpxchg8b %1"
+				      : "=&A" (ret) : "m" (*val));
+	}
+	else
+	{
+		ret = InterlockedRead64_Locked(val);
+	}
+	return ret;
+}
+
+static inline gint64 InterlockedCompareExchange64(volatile gint64 *val,
+						gint64 exch, gint64 comp)
+{
+	if(__builtin_expect(mono_x86_have_cx8, 1))
+	{
+		PIC_EBX;
+		WapiLargeInteger exch_u;
+		exch_u.QuadPart = exch;
+
+#ifdef __PIC__
+		__asm__ __volatile__ ("movl %%ebx, %2; movl %3, %%ebx; lock; cmpxchg8b %0; movl %2, %%ebx"
+				      : "+m" (*val), "+A" (comp), "=m" (dummy_ebx)
+				      : "g" (exch_u.u.LowPart), "c" (exch_u.u.HighPart));
 #else
-			      "cmpxchgl"
+		__asm__ __volatile__ ("lock; cmpxchg8b %0"
+				      : "+m" (*val), "+A" (comp)
+				      : "b" (exch_u.u.LowPart), "c" (exch_u.u.HighPart));
 #endif
-			      " %2, %0; jne 1b"
-			      : "=m" (*val), "=a" (ret)
-			      : "r" (new_val), "m" (*val), "a" (*val));
+		return comp;
+	}
+	else
+		return InterlockedCompareExchange64_Locked(val, exch, comp);
+}
 
-	return(ret);
+static inline gint64 InterlockedExchange64(volatile gint64 *val, gint64 new_val)
+{
+	if(__builtin_expect(mono_x86_have_cx8, 1))
+	{
+		/* there is no xchg8b but there is a cmpxchg8b */
+
+		PIC_EBX;
+		gint64 ret = *val;
+		WapiLargeInteger exch_u;
+		exch_u.QuadPart = new_val;
+
+#ifdef __PIC__
+		__asm__ __volatile__ ("movl %%ebx, %2; movl %3, %%ebx; 1:; lock; cmpxchg8b %0; jne 1b; movl %2, %%ebx"
+				      : "+m" (*val), "+A" (ret), "=m" (dummy_ebx)
+				      : "g" (exch_u.u.LowPart), "c" (exch_u.u.HighPart));
+#else
+		__asm__ __volatile__ ("1:; lock; cmpxchg8b %0; jne 1b"
+				      : "+m" (*val), "+A" (ret)
+				      : "b" (exch_u.u.LowPart), "c" (exch_u.u.HighPart));
+#endif
+		return ret;
+	}
+	else
+		return InterlockedExchange64_Locked(val, new_val);
 }
 
-static inline gint32 InterlockedExchangeAdd(volatile gint32 *val, gint32 add)
+static inline void InterlockedWrite64(volatile gint64 *val, gint64 new_val)
 {
-	gint32 ret;
-	
-	__asm__ __volatile__ ("lock; xaddl %0, %1"
-			      : "=r" (ret), "=m" (*val)
-			      : "0" (add), "m" (*val));
-	
-	return(ret);
+	if(__builtin_expect(mono_x86_rw64_impl == 2, 1))
+	{
+		__asm__ __volatile__ ("movq %1, %%xmm0; movq %%xmm0, %0" : "=m" (*val) : "m" (new_val) : "xmm0");
+	}
+	else if(__builtin_expect(mono_x86_rw64_impl == 1, 1))
+	{
+		InterlockedExchange64(val, new_val);
+	}
+	else
+	{
+		InterlockedWrite64_Locked(val, new_val);
+	}
 }
 
-#elif defined(sparc) || defined (__sparc__)
+static inline gint64 InterlockedExchangeAdd64(volatile gint64 *val, gint64 add)
+{
+	if(__builtin_expect(mono_x86_have_cx8, 1))
+	{
+		PIC_EBX;
+		WapiLargeInteger add_u;
+		add_u.QuadPart = add;
+		gint64 ret = *val;
+
+#ifdef __PIC__
+		__asm__ __volatile__ ("movl %%ebx, %2; 1:; movl %%eax, %%ebx; movl %%edx, %%ecx; addl %3, %%ebx; adcl %4, %%ecx; lock; cmpxchg8b %0; jne 1b; movl %2, %%ebx"
+				      : "+m" (*val), "+A" (ret), "+m" (dummy_ebx)
+				      : "g" (add_u.u.LowPart), "g" (add_u.u.HighPart) : "ecx");
+#else
+		__asm__ __volatile__ ("1:; movl %%eax, %%ebx; movl %%edx, %%ecx; addl %2, %%ebx; adcl %3, %%ecx; lock; cmpxchg8b %0; jne 1b"
+				      : "+m" (*val), "+A" (ret)
+				      : "g" (add_u.u.LowPart), "g" (add_u.u.HighPart)
+				      : "ecx", "ebx");
+#endif
+		return ret;
+	}
+	else
+		return InterlockedExchangeAdd64_Locked(val, add);
+}
+
+static inline void InterlockedAdd64(volatile gint64 *val, gint64 add)
+{
+	InterlockedExchangeAdd64(val, add);
+}
+
+static inline void InterlockedSub64(volatile gint64 *val, gint64 add)
+{
+	InterlockedExchangeAdd64(val, -add);
+}
+
+static inline void InterlockedIncrementBlind64(volatile gint64 *val)
+{
+	InterlockedExchangeAdd64(val, 1);
+}
+
+static inline void InterlockedDecrementBlind64(volatile gint64 *val)
+{
+	InterlockedExchangeAdd64(val, -1);
+}
+#endif /* __x86_64__ */
+
+
+static inline gint64 InterlockedIncrement64(volatile gint64 *val)
+{
+	return InterlockedExchangeAdd64(val, 1) + 1;
+}
+
+static inline gint64 InterlockedDecrement64(volatile gint64 *val)
+{
+	return InterlockedExchangeAdd64(val, -1) - 1;
+}
+
+#undef PIC_EBX
+
+#elif (defined(sparc) || defined (__sparc__)) && defined(REMOVE_THIS_WHEN_THE_NEW_ATOMIC_OPERATIONS_HAVE_BEEN_IMPLEMENTED_NATIVELY_FOR_THIS_ARCH)
+
 #define WAPI_ATOMIC_ASM
 
 #ifdef __GNUC__
@@ -275,7 +515,7 @@ static inline gint32 InterlockedExchange
         return(ret);
 }
 
-#elif __s390__
+#elif __s390__ && defined(REMOVE_THIS_WHEN_THE_NEW_ATOMIC_OPERATIONS_HAVE_BEEN_IMPLEMENTED_NATIVELY_FOR_THIS_ARCH)
 
 #define WAPI_ATOMIC_ASM
 
@@ -403,7 +643,7 @@ InterlockedExchangeAdd(volatile gint32 *
 	return(ret);
 }
 
-#elif defined(__ppc__) || defined (__powerpc__)
+#elif (defined(__ppc__) || defined (__powerpc__)) && defined(REMOVE_THIS_WHEN_THE_NEW_ATOMIC_OPERATIONS_HAVE_BEEN_IMPLEMENTED_NATIVELY_FOR_THIS_ARCH)
 #define WAPI_ATOMIC_ASM
 
 static inline gint32 InterlockedIncrement(volatile gint32 *val)
@@ -477,7 +717,7 @@ static inline gint32 InterlockedExchange
 	return(tmp);
 }
 
-#elif defined(__arm__)
+#elif defined(__arm__) && defined(REMOVE_THIS_WHEN_THE_NEW_ATOMIC_OPERATIONS_HAVE_BEEN_IMPLEMENTED_NATIVELY_FOR_THIS_ARCH)
 #define WAPI_ATOMIC_ASM
 
 static inline gint32 InterlockedCompareExchange(volatile gint32 *dest, gint32 exch, gint32 comp)
@@ -596,20 +836,77 @@ static inline gint32 InterlockedExchange
 	return a;
 }
 
-#else
+#elif (defined(__hpux) && !defined(__GNUC__)) && defined(REMOVE_THIS_WHEN_THE_NEW_ATOMIC_OPERATIONS_HAVE_BEEN_IMPLEMENTED_NATIVELY_FOR_THIS_ARCH)
+#define WAPI_ATOMIC_ASM
 
-extern gint32 InterlockedCompareExchange(volatile gint32 *dest, gint32 exch, gint32 comp);
-extern gpointer InterlockedCompareExchangePointer(volatile gpointer *dest, gpointer exch, gpointer comp);
-extern gint32 InterlockedIncrement(volatile gint32 *dest);
-extern gint32 InterlockedDecrement(volatile gint32 *dest);
-extern gint32 InterlockedExchange(volatile gint32 *dest, gint32 exch);
-extern gpointer InterlockedExchangePointer(volatile gpointer *dest, gpointer exch);
-extern gint32 InterlockedExchangeAdd(volatile gint32 *dest, gint32 add);
+extern void InterlockedAdd(volatile gint32 *val, gint32 add);
+extern void InterlockedAdd64(volatile gint64 *val, gint64 add);
+extern gint32 InterlockedCompareExchange(volatile gint32 *val, gint32 exch, gint32 comp);
+extern gint64 InterlockedCompareExchange64(volatile gint64 *val, gint64 exch, gint64 comp);
+extern gint32 InterlockedDecrement(volatile gint32 *val);
+extern gint64 InterlockedDecrement64(volatile gint64 *val);
+extern void InterlockedDecrementBlind(volatile gint32 *val);
+extern void InterlockedDecrementBlind64(volatile gint64 *val);
+extern gint32 InterlockedExchange(volatile gint32 *val, gint32 new_val);
+extern gint64 InterlockedExchange64(volatile gint64 *val, gint64 new_val);
+extern gint32 InterlockedExchangeAdd(volatile gint32 *val, gint32 add);
+extern gint64 InterlockedExchangeAdd64(volatile gint64 *val, gint64 add);
+extern gint32 InterlockedIncrement(volatile gint32 *val);
+extern gint64 InterlockedIncrement64(volatile gint64 *val);
+extern void InterlockedIncrementBlind(volatile gint32 *val);
+extern void InterlockedIncrementBlind64(volatile gint64 *val);
+extern gint32 InterlockedRead(volatile gint32 *val);
+extern gint64 InterlockedRead64(volatile gint64 *val);
+extern void InterlockedSub(volatile gint32 *val, gint32 add);
+extern void InterlockedSub64(volatile gint64 *val, gint64 add);
+extern void InterlockedWrite(volatile gint32 *val, gint32 new_val);
+extern void InterlockedWrite64(volatile gint64 *val, gint64 new_val);
+#endif
 
-#if defined(__hpux) && !defined(__GNUC__)
-#define WAPI_ATOMIC_ASM
+#ifndef WAPI_ATOMIC_ASM
+#define InterlockedAdd InterlockedAdd_Locked
+#define InterlockedAdd64 InterlockedAdd64_Locked
+#define InterlockedCompareExchange InterlockedCompareExchange_Locked
+#define InterlockedCompareExchange64 InterlockedCompareExchange64_Locked
+#define InterlockedCompareExchangePointer InterlockedCompareExchangePointer_Locked
+#define InterlockedDecrement InterlockedDecrement_Locked
+#define InterlockedDecrement64 InterlockedDecrement64_Locked
+#define InterlockedDecrementBlind InterlockedDecrementBlind_Locked
+#define InterlockedDecrementBlind64 InterlockedDecrementBlind64_Locked
+#define InterlockedExchange InterlockedExchange_Locked
+#define InterlockedExchange64 InterlockedExchange64_Locked
+#define InterlockedExchangeAdd InterlockedExchangeAdd_Locked
+#define InterlockedExchangeAdd64 InterlockedExchangeAdd64_Locked
+#define InterlockedExchangePointer InterlockedExchangePointer_Locked
+#define InterlockedIncrement InterlockedIncrement_Locked
+#define InterlockedIncrement64 InterlockedIncrement64_Locked
+#define InterlockedIncrementBlind InterlockedIncrementBlind_Locked
+#define InterlockedIncrementBlind64 InterlockedIncrementBlind64_Locked
+#define InterlockedRead InterlockedRead_Locked
+#define InterlockedRead64 InterlockedRead64_Locked
+#define InterlockedSub InterlockedSub_Locked
+#define InterlockedSub64 InterlockedSub64_Locked
+#define InterlockedWrite InterlockedWrite_Locked
+#define InterlockedWrite64 InterlockedWrite64_Locked
+#endif
+	
+static inline gpointer InterlockedCompareExchangePointer(volatile gpointer *val, gpointer exch, gpointer comp)
+{
+#if SIZEOF_VOID_P == 8
+	return (gpointer)InterlockedCompareExchange64((volatile gint64*)val, (gint64)exch, (gint64)comp);
+#else
+	return (gpointer)InterlockedCompareExchange((volatile gint32*)val, (gint32)exch, (gint32)comp);
 #endif
+}
 
+static inline gpointer InterlockedExchangePointer(volatile gpointer *val,
+						  gpointer new_val)
+{
+#if SIZEOF_VOID_P == 8
+	return (gpointer)InterlockedExchange64((volatile gint64*)val, (gint64)new_val);
+#else
+	return (gpointer)InterlockedExchange((volatile gint32*)val, (gint32)new_val);
 #endif
+}
 
 #endif /* _WAPI_ATOMIC_H_ */
--- mono/mono/mini/mini-amd64.c.~1.49.~	2004-09-25 16:24:01.000000000 +0200
+++ mono/mono/mini/mini-amd64.c	2004-10-08 23:34:53.000000000 +0200
@@ -629,12 +629,6 @@ mono_arch_get_argument_info (MonoMethodS
 	return args_size;
 }
 
-static int 
-cpuid (int id, int* p_eax, int* p_ebx, int* p_ecx, int* p_edx)
-{
-	return 0;
-}
-
 /*
  * Initialize the cpu to execute managed code.
  */
@@ -660,24 +654,9 @@ mono_arch_cpu_init (void)
 guint32
 mono_arch_cpu_optimizazions (guint32 *exclude_mask)
 {
-	int eax, ebx, ecx, edx;
-	guint32 opts = 0;
-
-	/* FIXME: AMD64 */
-
 	*exclude_mask = 0;
-	/* Feature Flags function, flags returned in EDX. */
-	if (cpuid (1, &eax, &ebx, &ecx, &edx)) {
-		if (edx & (1 << 15)) {
-			opts |= MONO_OPT_CMOV;
-			if (edx & 1)
-				opts |= MONO_OPT_FCMOV;
-			else
-				*exclude_mask |= MONO_OPT_FCMOV;
-		} else
-			*exclude_mask |= MONO_OPT_CMOV;
-	}
-	return opts;
+	
+	return MONO_OPT_CMOV | MONO_OPT_FCMOV;
 }
 
 static gboolean
--- mono/mono/mini/mini-x86.c.~1.123.~	2004-09-10 20:52:36.000000000 +0200
+++ mono/mono/mini/mini-x86.c	2004-10-08 18:35:03.000000000 +0200
@@ -109,65 +109,6 @@ mono_arch_get_argument_info (MonoMethodS
 	return frame_size;
 }
 
-static const guchar cpuid_impl [] = {
-	0x55,                   	/* push   %ebp */
-	0x89, 0xe5,                	/* mov    %esp,%ebp */
-	0x53,                   	/* push   %ebx */
-	0x8b, 0x45, 0x08,             	/* mov    0x8(%ebp),%eax */
-	0x0f, 0xa2,                	/* cpuid   */
-	0x50,                   	/* push   %eax */
-	0x8b, 0x45, 0x10,             	/* mov    0x10(%ebp),%eax */
-	0x89, 0x18,                	/* mov    %ebx,(%eax) */
-	0x8b, 0x45, 0x14,             	/* mov    0x14(%ebp),%eax */
-	0x89, 0x08,                	/* mov    %ecx,(%eax) */
-	0x8b, 0x45, 0x18,             	/* mov    0x18(%ebp),%eax */
-	0x89, 0x10,                	/* mov    %edx,(%eax) */
-	0x58,                   	/* pop    %eax */
-	0x8b, 0x55, 0x0c,             	/* mov    0xc(%ebp),%edx */
-	0x89, 0x02,                	/* mov    %eax,(%edx) */
-	0x5b,                   	/* pop    %ebx */
-	0xc9,                   	/* leave   */
-	0xc3,                   	/* ret     */
-};
-
-typedef void (*CpuidFunc) (int id, int* p_eax, int* p_ebx, int* p_ecx, int* p_edx);
-
-static int 
-cpuid (int id, int* p_eax, int* p_ebx, int* p_ecx, int* p_edx)
-{
-	int have_cpuid = 0;
-	__asm__  __volatile__ (
-		"pushfl\n"
-		"popl %%eax\n"
-		"movl %%eax, %%edx\n"
-		"xorl $0x200000, %%eax\n"
-		"pushl %%eax\n"
-		"popfl\n"
-		"pushfl\n"
-		"popl %%eax\n"
-		"xorl %%edx, %%eax\n"
-		"andl $0x200000, %%eax\n"
-		"movl %%eax, %0"
-		: "=r" (have_cpuid)
-		:
-		: "%eax", "%edx"
-	);
-
-	if (have_cpuid) {
-		CpuidFunc func = (CpuidFunc)cpuid_impl;
-		func (id, p_eax, p_ebx, p_ecx, p_edx);
-		/*
-		 * We use this approach because of issues with gcc and pic code, see:
-		 * http://gcc.gnu.org/cgi-bin/gnatsweb.pl?cmd=view%20audit-trail&database=gcc&pr=7329
-		__asm__ __volatile__ ("cpuid"
-			: "=a" (*p_eax), "=b" (*p_ebx), "=c" (*p_ecx), "=d" (*p_edx)
-			: "a" (id));
-		*/
-		return 1;
-	}
-	return 0;
-}
-
 /*
  * Initialize the cpu to execute managed code.
  */
@@ -191,21 +132,18 @@ mono_arch_cpu_init (void)
 guint32
 mono_arch_cpu_optimizazions (guint32 *exclude_mask)
 {
-	int eax, ebx, ecx, edx;
 	guint32 opts = 0;
 	
 	*exclude_mask = 0;
 	/* Feature Flags function, flags returned in EDX. */
-	if (cpuid (1, &eax, &ebx, &ecx, &edx)) {
-		if (edx & (1 << 15)) {
-			opts |= MONO_OPT_CMOV;
-			if (edx & 1)
-				opts |= MONO_OPT_FCMOV;
-			else
-				*exclude_mask |= MONO_OPT_FCMOV;
-		} else
-			*exclude_mask |= MONO_OPT_CMOV;
-	}
+	if (mono_x86_have_cmov) {
+		opts |= MONO_OPT_CMOV;
+		if (mono_x86_have_fpu)
+			opts |= MONO_OPT_FCMOV;
+		else
+			*exclude_mask |= MONO_OPT_FCMOV;
+	} else
+		*exclude_mask |= MONO_OPT_CMOV;
 	return opts;
 }
 
--- mono/mono/jit/emit-x86.c.~1.121.~	2003-04-23 17:27:08.000000000 +0200
+++ mono/mono/jit/emit-x86.c	2004-10-08 17:39:57.000000000 +0200
@@ -55,59 +55,6 @@ arch_get_reg_name (int regnum)
 	return NULL;
 }
 
-
-/* 
- * we may want a x86-specific header or we 
- * can just declare it extern in x86.brg.
- */
-int mono_x86_have_cmov = 0;
-
-static int 
-cpuid (int id, int* p_eax, int* p_ebx, int* p_ecx, int* p_edx)
-{
-#ifdef PIC
-	return 0;
-#else
-	int have_cpuid = 0;
-	__asm__  __volatile__ (
-		"pushfl\n"
-		"popl %%eax\n"
-		"movl %%eax, %%edx\n"
-		"xorl $0x200000, %%eax\n"
-		"pushl %%eax\n"
-		"popfl\n"
-		"pushfl\n"
-		"popl %%eax\n"
-		"xorl %%edx, %%eax\n"
-		"andl $0x200000, %%eax\n"
-		"movl %%eax, %0"
-		: "=r" (have_cpuid)
-		:
-		: "%eax", "%edx"
-	);
-
-	if (have_cpuid) {
-		__asm__ __volatile__ ("cpuid"
-			: "=a" (*p_eax), "=b" (*p_ebx), "=c" (*p_ecx), "=d" (*p_edx)
-			: "a" (id));
-		return 1;
-	}
-	return 0;
-#endif
-}
-
-void
-mono_cpu_detect (void) {
-	int eax, ebx, ecx, edx;
-
-	/* Feature Flags function, flags returned in EDX. */
-	if (cpuid(1, &eax, &ebx, &ecx, &edx)) {
-		if (edx & (1U << 15)) {
-			mono_x86_have_cmov = 1;
-		}
-	}
-}
-
 /*
  * arch_get_argument_info:
  * @csig:  a method signature
--- mono/mono/metadata/threads.c.~1.118.~	2004-09-28 17:16:05.000000000 +0200
+++ mono/mono/metadata/threads.c	2004-10-09 22:36:53.000000000 +0200
@@ -49,7 +49,12 @@ typedef union {
 	gint32 ival;
 	gfloat fval;
 } IntFloatUnion;
- 
+
+typedef union {
+	gint64 ival;
+	gdouble fval;
+} IntDoubleUnion;
+
 typedef struct {
 	int idx;
 	int offset;
@@ -910,22 +915,9 @@ gint32 ves_icall_System_Threading_Interl
 
 gint64 ves_icall_System_Threading_Interlocked_Increment_Long (gint64 *location)
 {
-	gint32 lowret;
-	gint32 highret;
-
 	MONO_ARCH_SAVE_REGS;
 
-	EnterCriticalSection(&interlocked_mutex);
-
-	lowret = InterlockedIncrement((gint32 *) location);
-	if (0 == lowret)
-		highret = InterlockedIncrement((gint32 *) location + 1);
-	else
-		highret = *((gint32 *) location + 1);
-
-	LeaveCriticalSection(&interlocked_mutex);
-
-	return (gint64) highret << 32 | (gint64) lowret;
+	return InterlockedIncrement64(location);
 }
 
 gint32 ves_icall_System_Threading_Interlocked_Decrement_Int (gint32 *location)
@@ -937,22 +929,9 @@ gint32 ves_icall_System_Threading_Interl
 
 gint64 ves_icall_System_Threading_Interlocked_Decrement_Long (gint64 * location)
 {
-	gint32 lowret;
-	gint32 highret;
-
 	MONO_ARCH_SAVE_REGS;
 
-	EnterCriticalSection(&interlocked_mutex);
-
-	lowret = InterlockedDecrement((gint32 *) location);
-	if (-1 == lowret)
-		highret = InterlockedDecrement((gint32 *) location + 1);
-	else
-		highret = *((gint32 *) location + 1);
-
-	LeaveCriticalSection(&interlocked_mutex);
-
-	return (gint64) highret << 32 | (gint64) lowret;
+	return InterlockedDecrement64(location);
 }
 
 gint32 ves_icall_System_Threading_Interlocked_Exchange_Int (gint32 *location1, gint32 value)
@@ -962,11 +941,18 @@ gint32 ves_icall_System_Threading_Interl
 	return InterlockedExchange(location1, value);
 }
 
-MonoObject * ves_icall_System_Threading_Interlocked_Exchange_Object (MonoObject **location1, MonoObject *value)
+gint64 ves_icall_System_Threading_Interlocked_Exchange_Long (gint64 *location1, gint64 value)
 {
 	MONO_ARCH_SAVE_REGS;
 
-	return (MonoObject *) InterlockedExchangePointer((gpointer *) location1, value);
+	return InterlockedExchange64(location1, value);
+}
+
+void * ves_icall_System_Threading_Interlocked_Exchange_Object (void **location1, void *value)
+{
+	MONO_ARCH_SAVE_REGS;
+
+	return InterlockedExchangePointer(location1, value);
 }
 
 gfloat ves_icall_System_Threading_Interlocked_Exchange_Single (gfloat *location1, gfloat value)
@@ -981,6 +967,18 @@ gfloat ves_icall_System_Threading_Interl
 	return ret.fval;
 }
 
+gdouble ves_icall_System_Threading_Interlocked_Exchange_Double (gdouble *location1, gdouble value)
+{
+	IntDoubleUnion val, ret;
+
+	MONO_ARCH_SAVE_REGS;
+
+	val.fval = value;
+	ret.ival = InterlockedExchange64((gint64 *) location1, val.ival);
+
+	return ret.fval;
+}
+
 gint32 ves_icall_System_Threading_Interlocked_CompareExchange_Int(gint32 *location1, gint32 value, gint32 comparand)
 {
 	MONO_ARCH_SAVE_REGS;
@@ -988,11 +986,18 @@ gint32 ves_icall_System_Threading_Interl
 	return InterlockedCompareExchange(location1, value, comparand);
 }
 
-MonoObject * ves_icall_System_Threading_Interlocked_CompareExchange_Object (MonoObject **location1, MonoObject *value, MonoObject *comparand)
+gint64 ves_icall_System_Threading_Interlocked_CompareExchange_Long(gint64 *location1, gint64 value, gint64 comparand)
 {
 	MONO_ARCH_SAVE_REGS;
 
-	return (MonoObject *) InterlockedCompareExchangePointer((gpointer *) location1, value, comparand);
+	return InterlockedCompareExchange64(location1, value, comparand);
+}
+
+void * ves_icall_System_Threading_Interlocked_CompareExchange_Object (void **location1, void *value, void *comparand)
+{
+	MONO_ARCH_SAVE_REGS;
+
+	return InterlockedCompareExchangePointer((gpointer *) location1, value, comparand);
 }
 
 gfloat ves_icall_System_Threading_Interlocked_CompareExchange_Single (gfloat *location1, gfloat value, gfloat comparand)
@@ -1008,6 +1013,40 @@ gfloat ves_icall_System_Threading_Interl
 	return ret.fval;
 }
 
+gdouble ves_icall_System_Threading_Interlocked_CompareExchange_Double (gdouble *location1, gdouble value, gdouble comparand)
+{
+	IntDoubleUnion val, ret, cmp;
+
+	MONO_ARCH_SAVE_REGS;
+
+	val.fval = value;
+	cmp.fval = comparand;
+	ret.ival = InterlockedCompareExchange64((gint64 *) location1, val.ival, cmp.ival);
+
+	return ret.fval;
+}
+
+gint32 ves_icall_System_Threading_Interlocked_Add_Int (gint32 *location1, gint32 value)
+{
+	MONO_ARCH_SAVE_REGS;
+
+	return InterlockedExchangeAdd(location1, value);
+}
+
+gint64 ves_icall_System_Threading_Interlocked_Add_Long (gint64 *location1, gint64 value)
+{
+	MONO_ARCH_SAVE_REGS;
+
+	return InterlockedExchangeAdd64(location1, value);
+}
+
+gint64 ves_icall_System_Threading_Interlocked_Read_Long (gint64 *location1)
+{
+	MONO_ARCH_SAVE_REGS;
+
+	return InterlockedRead64(location1);
+}
+
 int  
 mono_thread_get_abort_signal (void)
 {
--- mono/mono/metadata/threads-types.h.~1.7.~	2004-06-24 16:22:00.000000000 +0200
+++ mono/mono/metadata/threads-types.h	2004-10-09 22:32:32.000000000 +0200
@@ -65,16 +65,27 @@ extern gboolean ves_icall_System_Threadi
 
 extern gint32 ves_icall_System_Threading_Interlocked_Increment_Int(gint32 *location);
 extern gint64 ves_icall_System_Threading_Interlocked_Increment_Long(gint64 *location);
+
 extern gint32 ves_icall_System_Threading_Interlocked_Decrement_Int(gint32 *location);
 extern gint64 ves_icall_System_Threading_Interlocked_Decrement_Long(gint64 * location);
 
 extern gint32 ves_icall_System_Threading_Interlocked_Exchange_Int(gint32 *location1, gint32 value);
-extern MonoObject *ves_icall_System_Threading_Interlocked_Exchange_Object(MonoObject **location1, MonoObject *value);
+extern gint64 ves_icall_System_Threading_Interlocked_Exchange_Long(gint64 *location1, gint64 value);
+extern void * ves_icall_System_Threading_Interlocked_Exchange_Object(void **location1, void *value);
 extern gfloat ves_icall_System_Threading_Interlocked_Exchange_Single(gfloat *location1, gfloat value);
+extern gdouble ves_icall_System_Threading_Interlocked_Exchange_Double(gdouble *location1, gdouble value);
 
 extern gint32 ves_icall_System_Threading_Interlocked_CompareExchange_Int(gint32 *location1, gint32 value, gint32 comparand);
-extern MonoObject *ves_icall_System_Threading_Interlocked_CompareExchange_Object(MonoObject **location1, MonoObject *value, MonoObject *comparand);
+extern gint64 ves_icall_System_Threading_Interlocked_CompareExchange_Long(gint64 *location1, gint64 value, gint64 comparand);
+extern void * ves_icall_System_Threading_Interlocked_CompareExchange_Object(void **location1, void *value, void *comparand);
 extern gfloat ves_icall_System_Threading_Interlocked_CompareExchange_Single(gfloat *location1, gfloat value, gfloat comparand);
+extern gdouble ves_icall_System_Threading_Interlocked_CompareExchange_Double(gdouble *location1, gdouble value, gdouble comparand);
+
+extern gint32 ves_icall_System_Threading_Interlocked_Add_Int(gint32 *location1, gint32 value);
+extern gint64 ves_icall_System_Threading_Interlocked_Add_Long(gint64 *location1, gint64 value);
+
+extern gint64 ves_icall_System_Threading_Interlocked_Read_Long(gint64 *location1);
+
 extern void ves_icall_System_Threading_Thread_Abort (MonoThread *thread, MonoObject *state);
 extern void ves_icall_System_Threading_Thread_ResetAbort (void);
 extern void ves_icall_System_Threading_Thread_Suspend (MonoThread *thread);
--- mono/mono/metadata/icall.c.~1.559.~	2004-10-07 15:25:42.000000000 +0200
+++ mono/mono/metadata/icall.c	2004-10-08 23:36:38.000000000 +0200
@@ -6250,16 +6250,25 @@ static const IcallEntry monitor_icalls [
 };
 
 static const IcallEntry interlocked_icalls [] = {
+	{"Add(int&,int)", ves_icall_System_Threading_Interlocked_Add_Int},
+	{"Add(long&,long)", ves_icall_System_Threading_Interlocked_Add_Long},
+	{"CompareExchange(double&,double,double)", ves_icall_System_Threading_Interlocked_CompareExchange_Double},
 	{"CompareExchange(int&,int,int)", ves_icall_System_Threading_Interlocked_CompareExchange_Int},
+	{"CompareExchange(intptr&,intptr,intptr)", ves_icall_System_Threading_Interlocked_CompareExchange_Object},
+	{"CompareExchange(long&,long,long)", ves_icall_System_Threading_Interlocked_CompareExchange_Long},
 	{"CompareExchange(object&,object,object)", ves_icall_System_Threading_Interlocked_CompareExchange_Object},
 	{"CompareExchange(single&,single,single)", ves_icall_System_Threading_Interlocked_CompareExchange_Single},
 	{"Decrement(int&)", ves_icall_System_Threading_Interlocked_Decrement_Int},
 	{"Decrement(long&)", ves_icall_System_Threading_Interlocked_Decrement_Long},
+	{"Exchange(double&,double)", ves_icall_System_Threading_Interlocked_Exchange_Double},
 	{"Exchange(int&,int)", ves_icall_System_Threading_Interlocked_Exchange_Int},
+	{"Exchange(intptr&,intptr)", ves_icall_System_Threading_Interlocked_Exchange_Object},
+	{"Exchange(long&,long)", ves_icall_System_Threading_Interlocked_Exchange_Long},
 	{"Exchange(object&,object)", ves_icall_System_Threading_Interlocked_Exchange_Object},
 	{"Exchange(single&,single)", ves_icall_System_Threading_Interlocked_Exchange_Single},
 	{"Increment(int&)", ves_icall_System_Threading_Interlocked_Increment_Int},
-	{"Increment(long&)", ves_icall_System_Threading_Interlocked_Increment_Long}
+	{"Increment(long&)", ves_icall_System_Threading_Interlocked_Increment_Long},
+	{"Read(long&)", ves_icall_System_Threading_Interlocked_Read_Long}
 };
 
 static const IcallEntry mutex_icalls [] = {