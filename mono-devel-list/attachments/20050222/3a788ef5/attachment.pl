Index: System.Threading/HostExecutionContextManager.cs
===================================================================
--- System.Threading/HostExecutionContextManager.cs	(revision 41077)
+++ System.Threading/HostExecutionContextManager.cs	(working copy)
@@ -47,7 +47,7 @@
 		}

 		[MonoTODO]
-		[ReliabilityContract (Consistency.WillNotCorruptState, CER.MayFail)]
+		[ReliabilityContract (Consistency.WillNotCorruptState, Cer.MayFail)]
 		public virtual void Revert (HostExecutionContextSwitcher hostContextSwitcher)
 		{
 			throw new NotImplementedException ();
Index: System.Threading/Thread.cs
===================================================================
--- System.Threading/Thread.cs	(revision 41077)
+++ System.Threading/Thread.cs	(working copy)
@@ -131,7 +131,7 @@

 		public static Thread CurrentThread {
 #if NET_2_0
-			[ReliabilityContract (Consistency.WillNotCorruptState, CER.MayFail)]
+			[ReliabilityContract (Consistency.WillNotCorruptState, Cer.MayFail)]
 #endif
 			get {
 				return(CurrentThread_internal());
@@ -853,7 +853,7 @@

 		[MonoTODO]
 		public ExecutionContext ExecutionContext {
-			[ReliabilityContract (Consistency.WillNotCorruptState, CER.MayFail)]
+			[ReliabilityContract (Consistency.WillNotCorruptState, Cer.MayFail)]
 			get { throw new NotImplementedException (); }
 		}

@@ -862,14 +862,14 @@
 		}

 		[MonoTODO]
-		[ReliabilityContract (Consistency.WillNotCorruptState, CER.MayFail)]
+		[ReliabilityContract (Consistency.WillNotCorruptState, Cer.MayFail)]
 		public static void BeginCriticalRegion ()
 		{
 			throw new NotImplementedException ();
 		}

 		[MonoTODO]
-		[ReliabilityContract (Consistency.WillNotCorruptState, CER.Success)]
+		[ReliabilityContract (Consistency.WillNotCorruptState, Cer.Success)]
 		public static void EndCriticalRegion ()
 		{
 			throw new NotImplementedException ();
Index: System.Threading/HostExecutionContextSwitcher.cs
===================================================================
--- System.Threading/HostExecutionContextSwitcher.cs	(revision 41077)
+++ System.Threading/HostExecutionContextSwitcher.cs	(working copy)
@@ -49,7 +49,7 @@
 		}

 		[MonoTODO]
-		[ReliabilityContract (Consistency.WillNotCorruptState, CER.MayFail)]
+		[ReliabilityContract (Consistency.WillNotCorruptState, Cer.MayFail)]
 		public void Undo ()
 		{
 		}
Index: System.Threading/SynchronizationContextSwitcher.cs
===================================================================
--- System.Threading/SynchronizationContextSwitcher.cs	(revision 41077)
+++ System.Threading/SynchronizationContextSwitcher.cs	(working copy)
@@ -63,7 +63,7 @@
 		}

 		[MonoTODO]
-		[ReliabilityContract (Consistency.WillNotCorruptState, CER.MayFail)]
+		[ReliabilityContract (Consistency.WillNotCorruptState, Cer.MayFail)]
 		public void Undo ()
 		{
 			throw new NotImplementedException ();
Index: System.Threading/ExecutionContextSwitcher.cs
===================================================================
--- System.Threading/ExecutionContextSwitcher.cs	(revision 41077)
+++ System.Threading/ExecutionContextSwitcher.cs	(working copy)
@@ -63,7 +63,7 @@
 		}

 		[MonoTODO]
-		[ReliabilityContract (Consistency.WillNotCorruptState, CER.MayFail)]
+		[ReliabilityContract (Consistency.WillNotCorruptState, Cer.MayFail)]
 		public void Undo ()
 		{
 			throw new NotImplementedException ();
Index: System.Threading/Monitor.cs
===================================================================
--- System.Threading/Monitor.cs	(revision 41077)
+++ System.Threading/Monitor.cs	(working copy)
@@ -50,7 +50,7 @@
 		private extern static bool Monitor_try_enter(object obj, int ms);

 #if NET_2_0
-		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, CER.MayFail)]
+		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, Cer.MayFail)]
 #endif
 		public static void Enter(object obj) {
 			if(obj==null) {
@@ -68,7 +68,7 @@
 		private extern static void Monitor_exit(object obj);

 #if NET_2_0
-		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, CER.MayFail)]
+		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, Cer.MayFail)]
 #endif
 		public static void Exit(object obj) {
 			if(obj==null) {
Index: System.Threading/CompressedStackSwitcher.cs
===================================================================
--- System.Threading/CompressedStackSwitcher.cs	(revision 41077)
+++ System.Threading/CompressedStackSwitcher.cs	(working copy)
@@ -65,7 +65,7 @@
 			// (even between executions).
 		}

-		[ReliabilityContract (Consistency.WillNotCorruptState, CER.MayFail)]
+		[ReliabilityContract (Consistency.WillNotCorruptState, Cer.MayFail)]
 		public void Undo ()
 		{
 			if ((_cs != null) && (_t != null)) {
Index: System.Threading/Interlocked.cs
===================================================================
--- System.Threading/Interlocked.cs	(revision 41077)
+++ System.Threading/Interlocked.cs	(working copy)
@@ -54,13 +54,13 @@
 #endif

 #if NET_2_0
-		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, CER.Success)]
+		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, Cer.Success)]
 #endif
 		[MethodImplAttribute(MethodImplOptions.InternalCall)]
 		public extern static int CompareExchange(ref int location1, int value, int comparand);

 #if NET_2_0
-		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, CER.Success)]
+		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, Cer.Success)]
 #endif
 		[MethodImplAttribute(MethodImplOptions.InternalCall)]
 		public extern static object CompareExchange(ref object location1, object value, object comparand);
@@ -69,7 +69,7 @@
 		public extern static float CompareExchange(ref float location1, float value, float comparand);

 #if NET_2_0
-		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, CER.Success)]
+		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, Cer.Success)]
 #endif
 		[MethodImplAttribute(MethodImplOptions.InternalCall)]
 		public extern static int Decrement(ref int location);
@@ -78,7 +78,7 @@
 		public extern static long Decrement(ref long location);

 #if NET_2_0
-		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, CER.Success)]
+		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, Cer.Success)]
 #endif
 		[MethodImplAttribute(MethodImplOptions.InternalCall)]
 		public extern static int Increment(ref int location);
@@ -87,13 +87,13 @@
 		public extern static long Increment(ref long location);

 #if NET_2_0
-		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, CER.Success)]
+		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, Cer.Success)]
 #endif
 		[MethodImplAttribute(MethodImplOptions.InternalCall)]
 		public extern static int Exchange(ref int location1, int value);

 #if NET_2_0
-		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, CER.Success)]
+		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, Cer.Success)]
 #endif
 		[MethodImplAttribute(MethodImplOptions.InternalCall)]
 		public extern static object Exchange(ref object location1, object value);
@@ -105,7 +105,7 @@
 		[MethodImplAttribute(MethodImplOptions.InternalCall)]
 		public extern static long CompareExchange(ref long location1, long value, long comparand);

-		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, CER.Success)]
+		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, Cer.Success)]
 		[MethodImplAttribute(MethodImplOptions.InternalCall)]
 		public extern static IntPtr CompareExchange(ref IntPtr location1, IntPtr value, IntPtr comparand);

@@ -115,7 +115,7 @@
 		[MethodImplAttribute(MethodImplOptions.InternalCall)]
 		public extern static long Exchange(ref long location1, long value);

-		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, CER.Success)]
+		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, Cer.Success)]
 		[MethodImplAttribute(MethodImplOptions.InternalCall)]
 		public extern static IntPtr Exchange(ref IntPtr location1, IntPtr value);

@@ -125,7 +125,7 @@
 		[MethodImplAttribute(MethodImplOptions.InternalCall)]
 		public extern static long Read(ref long location1);

-		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, CER.Success)]
+		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, Cer.Success)]
 		[MethodImplAttribute(MethodImplOptions.InternalCall)]
 		public extern static int Add(ref int location1, int add);

Index: System.Threading/SynchronizationContext.cs
===================================================================
--- System.Threading/SynchronizationContext.cs	(revision 41077)
+++ System.Threading/SynchronizationContext.cs	(working copy)
@@ -95,7 +95,7 @@

 		[MonoTODO]
 		[CLSCompliant (false)]
-		[ReliabilityContract (Consistency.WillNotCorruptState, CER.MayFail)]
+		[ReliabilityContract (Consistency.WillNotCorruptState, Cer.MayFail)]
 		protected static int WaitHelper (IntPtr[] waitHandles, bool waitAll, int millisecondsTimeout)
 		{
 			throw new NotImplementedException ();
Index: System.Security/SecurityContextSwitcher.cs
===================================================================
--- System.Security/SecurityContextSwitcher.cs	(revision 41077)
+++ System.Security/SecurityContextSwitcher.cs	(working copy)
@@ -50,7 +50,7 @@
 			return 0;
 		}

-		[ReliabilityContract (Consistency.WillNotCorruptState, CER.MayFail)]
+		[ReliabilityContract (Consistency.WillNotCorruptState, Cer.MayFail)]
 		public void Undo ()
 		{
 			_undo = true;
Index: System.Runtime.Reliability/ReliabilityContractAttribute.cs
===================================================================
--- System.Runtime.Reliability/ReliabilityContractAttribute.cs	(revision 41077)
+++ System.Runtime.Reliability/ReliabilityContractAttribute.cs	(working copy)
@@ -29,7 +29,8 @@
 #if NET_2_0
 namespace System.Runtime.Reliability
 {
-        public sealed class ReliabilityContractAttribute : Attribute
+	[Obsolete ("Use System.Runtime.ConstrainedExecution.ReliabilityContractAttribute")]
+	public sealed class ReliabilityContractAttribute : Attribute
         {
                 Consistency consistency;
                 CER cer;
Index: System.Runtime.Reliability/Consistency.cs
===================================================================
--- System.Runtime.Reliability/Consistency.cs	(revision 41077)
+++ System.Runtime.Reliability/Consistency.cs	(working copy)
@@ -29,7 +29,8 @@
 #if NET_2_0
 namespace System.Runtime.Reliability
 {
-        public enum Consistency
+	[Obsolete ("Use System.Runtime.ConstrainedExecution.Consistency")]
+	public enum Consistency
         {
                 MayCorruptAppDomain = 1,
                 MayCorruptInstance = 2,
@@ -37,4 +38,4 @@
                 WillNotCorruptState = 3
         }
 }
-#endif
+#endif
Index: System.Runtime.Reliability/CER.cs
===================================================================
--- System.Runtime.Reliability/CER.cs	(revision 41077)
+++ System.Runtime.Reliability/CER.cs	(working copy)
@@ -29,11 +29,12 @@
 #if NET_2_0
 namespace System.Runtime.Reliability
 {
-        public enum CER
+	[Obsolete ("Use System.Runtime.ConstrainedExecution.Cer")]
+	public enum CER
         {
                 MayFail = 1,
                 None = 0,
                 Success = 2
         }
 }
-#endif
+#endif
Index: System.Runtime.Reliability/PrePrepareMethodAttribute.cs
===================================================================
--- System.Runtime.Reliability/PrePrepareMethodAttribute.cs	(revision 41077)
+++ System.Runtime.Reliability/PrePrepareMethodAttribute.cs	(working copy)
@@ -29,11 +29,12 @@
 #if NET_2_0
 namespace System.Runtime.Reliability
 {
-        public sealed class PrePrepareMethodAttribute : Attribute
+	[Obsolete ("Use System.Runtime.ConstrainedExecution.PrePrepareMethodAttribute")]
+	public sealed class PrePrepareMethodAttribute : Attribute
         {
                 public PrePrepareMethodAttribute ()
                 {
                 }
         }
 }
-#endif
+#endif
Index: System/GC.cs
===================================================================
--- System/GC.cs	(revision 41077)
+++ System/GC.cs	(working copy)
@@ -95,7 +95,7 @@
 		public extern static void ReRegisterForFinalize (object obj);

 #if NET_2_0
-		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, CER.Success)]
+		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, Cer.Success)]
 #endif
 		[MethodImplAttribute (MethodImplOptions.InternalCall)]
 		public extern static void SuppressFinalize (object obj);
Index: System/Double.cs
===================================================================
--- System/Double.cs	(revision 41077)
+++ System/Double.cs	(working copy)
@@ -158,7 +158,7 @@
 		}

 #if NET_2_0
-		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, CER.Success)]
+		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, Cer.Success)]
 #endif
 		public static bool IsNaN (double d)
 		{
Index: System/IntPtr.cs
===================================================================
--- System/IntPtr.cs	(revision 41077)
+++ System/IntPtr.cs	(working copy)
@@ -113,7 +113,7 @@
 		}

 #if NET_2_0
-		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, CER.Success)]
+		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, Cer.Success)]
 #endif
 		public int ToInt32 ()
 		{
@@ -121,7 +121,7 @@
 		}

 #if NET_2_0
-		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, CER.Success)]
+		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, Cer.Success)]
 #endif
 		public long ToInt64 ()
 		{
@@ -143,7 +143,7 @@
 		}

 #if NET_2_0
-		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, CER.Success)]
+		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, Cer.Success)]
 #endif
 		public static bool operator == (IntPtr a, IntPtr b)
 		{
@@ -151,7 +151,7 @@
 		}

 #if NET_2_0
-		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, CER.Success)]
+		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, Cer.Success)]
 #endif
 		public static bool operator != (IntPtr a, IntPtr b)
 		{
@@ -159,7 +159,7 @@
 		}

 #if NET_2_0
-		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, CER.Success)]
+		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, Cer.Success)]
 #endif
 		public static explicit operator IntPtr (int value)
 		{
@@ -167,7 +167,7 @@
 		}

 #if NET_2_0
-		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, CER.Success)]
+		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, Cer.Success)]
 #endif
 		public static explicit operator IntPtr (long value)
 		{
@@ -175,7 +175,7 @@
 		}

 #if NET_2_0
-		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, CER.Success)]
+		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, Cer.Success)]
 #endif
 		[CLSCompliant (false)]
 		unsafe public static explicit operator IntPtr (void *value)
Index: System/Array.cs
===================================================================
--- System/Array.cs	(revision 41077)
+++ System/Array.cs	(working copy)
@@ -56,7 +56,7 @@
 		// Properties
 		public int Length {
 #if NET_2_0
-			[ReliabilityContractAttribute (Consistency.WillNotCorruptState, CER.Success)]
+			[ReliabilityContractAttribute (Consistency.WillNotCorruptState, Cer.Success)]
 #endif
 			get {
 				int length = this.GetLength (0);
@@ -72,7 +72,7 @@
 		[ComVisible (false)]
 		public long LongLength {
 #if NET_2_0
-			[ReliabilityContractAttribute (Consistency.WillNotCorruptState, CER.Success)]
+			[ReliabilityContractAttribute (Consistency.WillNotCorruptState, Cer.Success)]
 #endif
 			get { return Length; }
 		}
@@ -80,7 +80,7 @@

 		public int Rank {
 #if NET_2_0
-			[ReliabilityContractAttribute (Consistency.WillNotCorruptState, CER.Success)]
+			[ReliabilityContractAttribute (Consistency.WillNotCorruptState, Cer.Success)]
 #endif
 			get {
 				return this.GetRank ();
@@ -125,7 +125,7 @@
 		}

 #if NET_2_0
-		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, CER.MayFail)]
+		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, Cer.MayFail)]
 #endif
 		int IList.IndexOf (object value)
 		{
@@ -180,7 +180,7 @@
 #endif

 #if NET_2_0
-	[ReliabilityContractAttribute (Consistency.WillNotCorruptState, CER.Success)]
+		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, Cer.Success)]
 #endif
 		[MethodImplAttribute (MethodImplOptions.InternalCall)]
 		public extern int GetLowerBound (int dimension);
@@ -242,7 +242,7 @@
 		}

 #if NET_2_0
-		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, CER.Success)]
+		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, Cer.Success)]
 #endif
 		public int GetUpperBound (int dimension)
 		{
@@ -526,7 +526,7 @@
 #endif

 #if NET_2_0
-		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, CER.MayFail)]
+		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, Cer.MayFail)]
 #endif
 		public static int BinarySearch (Array array, object value)
 		{
@@ -546,7 +546,7 @@
 		}

 #if NET_2_0
-	[ReliabilityContractAttribute (Consistency.WillNotCorruptState, CER.MayFail)]
+	[ReliabilityContractAttribute (Consistency.WillNotCorruptState, Cer.MayFail)]
 #endif
 		public static int BinarySearch (Array array, object value, IComparer comparer)
 		{
@@ -564,7 +564,7 @@
 		}

 #if NET_2_0
-		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, CER.MayFail)]
+		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, Cer.MayFail)]
 #endif
 		public static int BinarySearch (Array array, int index, int length, object value)
 		{
@@ -592,7 +592,7 @@
 		}

 #if NET_2_0
-		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, CER.MayFail)]
+		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, Cer.MayFail)]
 #endif
 		public static int BinarySearch (Array array, int index, int length, object value, IComparer comparer)
 		{
@@ -654,7 +654,7 @@
 		}

 #if NET_2_0
-		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, CER.Success)]
+		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, Cer.Success)]
 #endif
 		public static void Clear (Array array, int index, int length)
 		{
@@ -682,7 +682,7 @@
 		public virtual extern object Clone ();

 #if NET_2_0
-		[ReliabilityContractAttribute (Consistency.MayCorruptInstance, CER.MayFail)]
+		[ReliabilityContractAttribute (Consistency.MayCorruptInstance, Cer.MayFail)]
 #endif
 		public static void Copy (Array sourceArray, Array destinationArray, int length)
 		{
@@ -699,7 +699,7 @@
 		}

 #if NET_2_0
-		[ReliabilityContractAttribute (Consistency.MayCorruptInstance, CER.MayFail)]
+		[ReliabilityContractAttribute (Consistency.MayCorruptInstance, Cer.MayFail)]
 #endif
 		public static void Copy (Array sourceArray, int sourceIndex, Array destinationArray, int destinationIndex, int length)
 		{
@@ -773,7 +773,7 @@

 #if NET_1_1
 #if NET_2_0
-		[ReliabilityContractAttribute (Consistency.MayCorruptInstance, CER.MayFail)]
+		[ReliabilityContractAttribute (Consistency.MayCorruptInstance, Cer.MayFail)]
 #endif
 		public static void Copy (Array sourceArray, long sourceIndex, Array destinationArray,
 		                         long destinationIndex, long length)
@@ -800,7 +800,7 @@
 		}

 #if NET_2_0
-		[ReliabilityContractAttribute (Consistency.MayCorruptInstance, CER.MayFail)]
+		[ReliabilityContractAttribute (Consistency.MayCorruptInstance, Cer.MayFail)]
 #endif
 		public static void Copy (Array sourceArray, Array destinationArray, long length)
 		{
@@ -813,7 +813,7 @@
 #endif

 #if NET_2_0
-		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, CER.MayFail)]
+		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, Cer.MayFail)]
 #endif
 		public static int IndexOf (Array array, object value)
 		{
@@ -824,7 +824,7 @@
 		}

 #if NET_2_0
-		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, CER.MayFail)]
+		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, Cer.MayFail)]
 #endif
 		public static int IndexOf (Array array, object value, int startIndex)
 		{
@@ -835,7 +835,7 @@
 		}

 #if NET_2_0
-		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, CER.MayFail)]
+		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, Cer.MayFail)]
 #endif
 		public static int IndexOf (Array array, object value, int startIndex, int count)
 		{
@@ -867,7 +867,7 @@
 		}

 #if NET_2_0
-		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, CER.MayFail)]
+		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, Cer.MayFail)]
 #endif
 		public static int LastIndexOf (Array array, object value)
 		{
@@ -878,7 +878,7 @@
 		}

 #if NET_2_0
-		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, CER.MayFail)]
+		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, Cer.MayFail)]
 #endif
 		public static int LastIndexOf (Array array, object value, int startIndex)
 		{
@@ -889,7 +889,7 @@
 		}

 #if NET_2_0
-		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, CER.MayFail)]
+		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, Cer.MayFail)]
 #endif
 		public static int LastIndexOf (Array array, object value, int startIndex, int count)
 		{
@@ -929,7 +929,7 @@
 		}

 #if NET_2_0
-		[ReliabilityContractAttribute (Consistency.MayCorruptInstance, CER.MayFail)]
+		[ReliabilityContractAttribute (Consistency.MayCorruptInstance, Cer.MayFail)]
 #endif
 		public static void Reverse (Array array)
 		{
@@ -940,7 +940,7 @@
 		}

 #if NET_2_0
-		[ReliabilityContractAttribute (Consistency.MayCorruptInstance, CER.MayFail)]
+		[ReliabilityContractAttribute (Consistency.MayCorruptInstance, Cer.MayFail)]
 #endif
 		public static void Reverse (Array array, int index, int length)
 		{
@@ -1001,7 +1001,7 @@
 		}

 #if NET_2_0
-		[ReliabilityContractAttribute (Consistency.MayCorruptInstance, CER.MayFail)]
+		[ReliabilityContractAttribute (Consistency.MayCorruptInstance, Cer.MayFail)]
 #endif
 		public static void Sort (Array array)
 		{
@@ -1012,7 +1012,7 @@
 		}

 #if NET_2_0
-		[ReliabilityContractAttribute (Consistency.MayCorruptInstance, CER.MayFail)]
+		[ReliabilityContractAttribute (Consistency.MayCorruptInstance, Cer.MayFail)]
 #endif
 		public static void Sort (Array keys, Array items)
 		{
@@ -1023,7 +1023,7 @@
 		}

 #if NET_2_0
-		[ReliabilityContractAttribute (Consistency.MayCorruptInstance, CER.MayFail)]
+		[ReliabilityContractAttribute (Consistency.MayCorruptInstance, Cer.MayFail)]
 #endif
 		public static void Sort (Array array, IComparer comparer)
 		{
@@ -1034,7 +1034,7 @@
 		}

 #if NET_2_0
-		[ReliabilityContractAttribute (Consistency.MayCorruptInstance, CER.MayFail)]
+		[ReliabilityContractAttribute (Consistency.MayCorruptInstance, Cer.MayFail)]
 #endif
 		public static void Sort (Array array, int index, int length)
 		{
@@ -1042,7 +1042,7 @@
 		}

 #if NET_2_0
-		[ReliabilityContractAttribute (Consistency.MayCorruptInstance, CER.MayFail)]
+		[ReliabilityContractAttribute (Consistency.MayCorruptInstance, Cer.MayFail)]
 #endif
 		public static void Sort (Array keys, Array items, IComparer comparer)
 		{
@@ -1053,7 +1053,7 @@
 		}

 #if NET_2_0
-		[ReliabilityContractAttribute (Consistency.MayCorruptInstance, CER.MayFail)]
+		[ReliabilityContractAttribute (Consistency.MayCorruptInstance, Cer.MayFail)]
 #endif
 		public static void Sort (Array keys, Array items, int index, int length)
 		{
@@ -1061,7 +1061,7 @@
 		}

 #if NET_2_0
-		[ReliabilityContractAttribute (Consistency.MayCorruptInstance, CER.MayFail)]
+		[ReliabilityContractAttribute (Consistency.MayCorruptInstance, Cer.MayFail)]
 #endif
 		public static void Sort (Array array, int index, int length, IComparer comparer)
 		{
@@ -1069,7 +1069,7 @@
 		}

 #if NET_2_0
-		[ReliabilityContractAttribute (Consistency.MayCorruptInstance, CER.MayFail)]
+		[ReliabilityContractAttribute (Consistency.MayCorruptInstance, Cer.MayFail)]
 #endif
 		public static void Sort (Array keys, Array items, int index, int length, IComparer comparer)
 		{
@@ -1697,7 +1697,7 @@
 #endif

 #if NET_2_0
-		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, CER.Success)]
+		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, Cer.Success)]
 #endif
 		// Fixme: wtf is constrained about this
 		public static void ConstrainedCopy (Array s, int s_i, Array d, int d_i, int c)
Index: System/Decimal.cs
===================================================================
--- System/Decimal.cs	(revision 41077)
+++ System/Decimal.cs	(working copy)
@@ -185,10 +185,10 @@

         public Decimal (float val)
         {
-		if (val > (float)Decimal.MaxValue || val < (float)Decimal.MinValue) {
-			throw new OverflowException (Locale.GetText (
+		if (val > (float)Decimal.MaxValue || val < (float)Decimal.MinValue) {
+			throw new OverflowException (Locale.GetText (
 				"Value is greater than Decimal.MaxValue or less than Decimal.MinValue"));
-		}
+		}
 		// we must respect the precision (double2decimal doesn't)
 		Decimal d = Decimal.Parse (val.ToString (CultureInfo.InvariantCulture),
 				NumberStyles.Float, CultureInfo.InvariantCulture);
@@ -200,8 +200,8 @@

 	public Decimal (double val)
 	{
-		if (val > (double)Decimal.MaxValue || val < (double)Decimal.MinValue) {
-			throw new OverflowException (Locale.GetText (
+		if (val > (double)Decimal.MaxValue || val < (double)Decimal.MinValue) {
+			throw new OverflowException (Locale.GetText (
 				"Value is greater than Decimal.MaxValue or less than Decimal.MinValue"));
 		}
 		// we must respect the precision (double2decimal doesn't)
@@ -655,7 +655,7 @@
         }

 #if NET_2_0
-		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, CER.Success)]
+		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, Cer.Success)]
 #endif
         public static int Compare(Decimal d1, Decimal d2)
         {
@@ -1018,12 +1018,12 @@

 	public static byte ToByte (decimal value)
 	{
-		if (value > Byte.MaxValue || value < Byte.MinValue)
-			throw new OverflowException (Locale.GetText (
-				"Value is greater than Byte.MaxValue or less than Byte.MinValue"));
-
-		// return truncated value
-		return (byte)(Decimal.Truncate (value));
+		if (value > Byte.MaxValue || value < Byte.MinValue)
+			throw new OverflowException (Locale.GetText (
+				"Value is greater than Byte.MaxValue or less than Byte.MinValue"));
+
+		// return truncated value
+		return (byte)(Decimal.Truncate (value));
 	}

 	public static double ToDouble (decimal value)
@@ -1033,32 +1033,32 @@

 	public static short ToInt16 (decimal value)
 	{
-		if (value > Int16.MaxValue || value < Int16.MinValue)
-			throw new OverflowException (Locale.GetText (
-				"Value is greater than Int16.MaxValue or less than Int16.MinValue"));
-
-		// return truncated value
-		return (Int16)(Decimal.Truncate (value));
+		if (value > Int16.MaxValue || value < Int16.MinValue)
+			throw new OverflowException (Locale.GetText (
+				"Value is greater than Int16.MaxValue or less than Int16.MinValue"));
+
+		// return truncated value
+		return (Int16)(Decimal.Truncate (value));
 	}

 	public static int ToInt32 (decimal value)
 	{
-		if (value > Int32.MaxValue || value < Int32.MinValue)
-			throw new OverflowException (Locale.GetText (
-				"Value is greater than Int32.MaxValue or less than Int32.MinValue"));
-
-		// return truncated value
-		return (Int32)(Decimal.Truncate (value));
+		if (value > Int32.MaxValue || value < Int32.MinValue)
+			throw new OverflowException (Locale.GetText (
+				"Value is greater than Int32.MaxValue or less than Int32.MinValue"));
+
+		// return truncated value
+		return (Int32)(Decimal.Truncate (value));
 	}

 	public static long ToInt64 (decimal value)
 	{
-		if (value > Int64.MaxValue || value < Int64.MinValue)
-			throw new OverflowException (Locale.GetText (
-				"Value is greater than Int64.MaxValue or less than Int64.MinValue"));
-
-		// return truncated value
-		return (Int64)(Decimal.Truncate (value));
+		if (value > Int64.MaxValue || value < Int64.MinValue)
+			throw new OverflowException (Locale.GetText (
+				"Value is greater than Int64.MaxValue or less than Int64.MinValue"));
+
+		// return truncated value
+		return (Int64)(Decimal.Truncate (value));
 	}

 	public static long ToOACurrency (decimal value)
@@ -1069,12 +1069,12 @@
 	[CLSCompliant(false)]
 	public static sbyte ToSByte (decimal value)
 	{
-		if (value > SByte.MaxValue || value < SByte.MinValue)
-			throw new OverflowException (Locale.GetText (
-				"Value is greater than SByte.MaxValue or less than SByte.MinValue"));
-
-		// return truncated value
-		return (SByte)(Decimal.Truncate (value));
+		if (value > SByte.MaxValue || value < SByte.MinValue)
+			throw new OverflowException (Locale.GetText (
+				"Value is greater than SByte.MaxValue or less than SByte.MinValue"));
+
+		// return truncated value
+		return (SByte)(Decimal.Truncate (value));
 	}

 	public static float ToSingle (decimal value)
@@ -1085,34 +1085,34 @@
 	[CLSCompliant(false)]
 	public static ushort ToUInt16 (decimal value)
 	{
-		if (value > UInt16.MaxValue || value < UInt16.MinValue)
-			throw new OverflowException (Locale.GetText (
-				"Value is greater than UInt16.MaxValue or less than UInt16.MinValue"));
-
-		// return truncated value
-		return (UInt16)(Decimal.Truncate (value));
+		if (value > UInt16.MaxValue || value < UInt16.MinValue)
+			throw new OverflowException (Locale.GetText (
+				"Value is greater than UInt16.MaxValue or less than UInt16.MinValue"));
+
+		// return truncated value
+		return (UInt16)(Decimal.Truncate (value));
 	}

 	[CLSCompliant(false)]
 	public static uint ToUInt32 (decimal value)
 	{
-		if (value > UInt32.MaxValue || value < UInt32.MinValue)
-			throw new OverflowException (Locale.GetText (
-				"Value is greater than UInt32.MaxValue or less than UInt32.MinValue"));
-
-		// return truncated value
-		return (UInt32)(Decimal.Truncate (value));
+		if (value > UInt32.MaxValue || value < UInt32.MinValue)
+			throw new OverflowException (Locale.GetText (
+				"Value is greater than UInt32.MaxValue or less than UInt32.MinValue"));
+
+		// return truncated value
+		return (UInt32)(Decimal.Truncate (value));
 	}

 	[CLSCompliant(false)]
 	public static ulong ToUInt64 (decimal value)
 	{
-		if (value > UInt64.MaxValue || value < UInt64.MinValue)
-			throw new OverflowException (Locale.GetText (
-				"Value is greater than UInt64.MaxValue or less than UInt64.MinValue"));
-
-		// return truncated value
-		return (UInt64)(Decimal.Truncate (value));
+		if (value > UInt64.MaxValue || value < UInt64.MinValue)
+			throw new OverflowException (Locale.GetText (
+				"Value is greater than UInt64.MaxValue or less than UInt64.MinValue"));
+
+		// return truncated value
+		return (UInt64)(Decimal.Truncate (value));
 	}

 	object IConvertible.ToType (Type conversionType, IFormatProvider provider)
Index: System/Math.cs
===================================================================
--- System/Math.cs	(revision 41077)
+++ System/Math.cs	(working copy)
@@ -144,7 +144,7 @@
 		}

 #if NET_2_0
-		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, CER.Success)]
+		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, Cer.Success)]
 #endif
 		public static byte Max (byte val1, byte val2)
 		{
@@ -152,7 +152,7 @@
 		}

 #if NET_2_0
-		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, CER.Success)]
+		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, Cer.Success)]
 #endif
 		public static decimal Max (decimal val1, decimal val2)
 		{
@@ -160,7 +160,7 @@
 		}

 #if NET_2_0
-		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, CER.Success)]
+		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, Cer.Success)]
 #endif
 		public static double Max (double val1, double val2)
 		{
@@ -171,7 +171,7 @@
 		}

 #if NET_2_0
-		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, CER.Success)]
+		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, Cer.Success)]
 #endif
 		public static float Max (float val1, float val2)
 		{
@@ -182,7 +182,7 @@
 		}

 #if NET_2_0
-		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, CER.Success)]
+		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, Cer.Success)]
 #endif
 		public static int Max (int val1, int val2)
 		{
@@ -190,7 +190,7 @@
 		}

 #if NET_2_0
-		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, CER.Success)]
+		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, Cer.Success)]
 #endif
 		public static long Max (long val1, long val2)
 		{
@@ -198,7 +198,7 @@
 		}

 #if NET_2_0
-		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, CER.Success)]
+		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, Cer.Success)]
 #endif
 		[CLSCompliant (false)]
 		public static sbyte Max (sbyte val1, sbyte val2)
@@ -207,7 +207,7 @@
 		}

 #if NET_2_0
-		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, CER.Success)]
+		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, Cer.Success)]
 #endif
 		public static short Max (short val1, short val2)
 		{
@@ -215,7 +215,7 @@
 		}

 #if NET_2_0
-		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, CER.Success)]
+		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, Cer.Success)]
 #endif
 		[CLSCompliant (false)]
 		public static uint Max (uint val1, uint val2)
@@ -224,7 +224,7 @@
 		}

 #if NET_2_0
-		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, CER.Success)]
+		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, Cer.Success)]
 #endif
 		[CLSCompliant (false)]
 		public static ulong Max (ulong val1, ulong val2)
@@ -233,7 +233,7 @@
 		}

 #if NET_2_0
-		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, CER.Success)]
+		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, Cer.Success)]
 #endif
 		[CLSCompliant (false)]
 		public static ushort Max (ushort val1, ushort val2)
@@ -242,7 +242,7 @@
 		}

 #if NET_2_0
-		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, CER.Success)]
+		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, Cer.Success)]
 #endif
 		public static byte Min (byte val1, byte val2)
 		{
@@ -250,7 +250,7 @@
 		}

 #if NET_2_0
-		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, CER.Success)]
+		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, Cer.Success)]
 #endif
 		public static decimal Min (decimal val1, decimal val2)
 		{
@@ -258,7 +258,7 @@
  		}

 #if NET_2_0
-		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, CER.Success)]
+		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, Cer.Success)]
 #endif
 		public static double Min (double val1, double val2)
 		{
@@ -269,7 +269,7 @@
 		}

 #if NET_2_0
-		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, CER.Success)]
+		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, Cer.Success)]
 #endif
 		public static float Min (float val1, float val2)
 		{
@@ -280,7 +280,7 @@
 		}

 #if NET_2_0
-		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, CER.Success)]
+		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, Cer.Success)]
 #endif
 		public static int Min (int val1, int val2)
 		{
@@ -288,7 +288,7 @@
 		}

 #if NET_2_0
-		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, CER.Success)]
+		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, Cer.Success)]
 #endif
 		public static long Min (long val1, long val2)
 		{
@@ -296,7 +296,7 @@
 		}

 #if NET_2_0
-		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, CER.Success)]
+		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, Cer.Success)]
 #endif
 		[CLSCompliant (false)]
 		public static sbyte Min (sbyte val1, sbyte val2)
@@ -305,7 +305,7 @@
 		}

 #if NET_2_0
-		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, CER.Success)]
+		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, Cer.Success)]
 #endif
 		public static short Min (short val1, short val2)
 		{
@@ -313,7 +313,7 @@
 		}

 #if NET_2_0
-		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, CER.Success)]
+		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, Cer.Success)]
 #endif
 		[CLSCompliant (false)]
 		public static uint Min (uint val1, uint val2)
@@ -322,7 +322,7 @@
 		}

 #if NET_2_0
-		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, CER.Success)]
+		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, Cer.Success)]
 #endif
 		[CLSCompliant (false)]
 		public static ulong Min (ulong val1, ulong val2)
@@ -331,7 +331,7 @@
 		}

 #if NET_2_0
-		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, CER.Success)]
+		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, Cer.Success)]
 #endif
 		[CLSCompliant (false)]
 		public static ushort Min (ushort val1, ushort val2)
Index: System/Single.cs
===================================================================
--- System/Single.cs	(revision 41077)
+++ System/Single.cs	(working copy)
@@ -151,7 +151,7 @@
 		}

 #if NET_2_0
-		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, CER.Success)]
+		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, Cer.Success)]
 #endif
 		public static bool IsNaN (float f)
 		{
Index: System.Runtime.InteropServices/Marshal.cs
===================================================================
--- System.Runtime.InteropServices/Marshal.cs	(revision 41077)
+++ System.Runtime.InteropServices/Marshal.cs	(working copy)
@@ -472,20 +472,20 @@
 		}

 #if NET_2_0
-		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, CER.Success)]
+		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, Cer.Success)]
 #endif
 		public static int ReadInt32 (IntPtr ptr) {
 			return ReadInt32 (ptr, 0);
 		}

 #if NET_2_0
-		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, CER.Success)]
+		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, Cer.Success)]
 #endif
 		[MethodImplAttribute(MethodImplOptions.InternalCall)]
 		public extern static int ReadInt32 (IntPtr ptr, int ofs);

 #if NET_2_0
-		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, CER.Success)]
+		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, Cer.Success)]
 #endif
 		[MonoTODO]
 		public static int ReadInt32 ([In, MarshalAs(UnmanagedType.AsAny)] object ptr, int ofs) {
@@ -493,20 +493,20 @@
 		}

 #if NET_2_0
-		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, CER.Success)]
+		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, Cer.Success)]
 #endif
 		public static long ReadInt64 (IntPtr ptr) {
 			return ReadInt64 (ptr, 0);
 		}

 #if NET_2_0
-		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, CER.Success)]
+		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, Cer.Success)]
 #endif
 		[MethodImplAttribute(MethodImplOptions.InternalCall)]
 		public extern static long ReadInt64 (IntPtr ptr, int ofs);

 #if NET_2_0
-		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, CER.Success)]
+		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, Cer.Success)]
 #endif
 		[MonoTODO]
 		public static long ReadInt64 ([In, MarshalAs (UnmanagedType.AsAny)] object ptr, int ofs) {
@@ -514,20 +514,20 @@
 		}

 #if NET_2_0
-		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, CER.Success)]
+		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, Cer.Success)]
 #endif
 		public static IntPtr ReadIntPtr (IntPtr ptr) {
 			return ReadIntPtr (ptr, 0);
 		}

 #if NET_2_0
-		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, CER.Success)]
+		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, Cer.Success)]
 #endif
 		[MethodImplAttribute(MethodImplOptions.InternalCall)]
 		public extern static IntPtr ReadIntPtr (IntPtr ptr, int ofs);

 #if NET_2_0
-		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, CER.Success)]
+		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, Cer.Success)]
 #endif
 		[MonoTODO]
 		public static IntPtr ReadIntPtr ([In, MarshalAs (UnmanagedType.AsAny)] object ptr, int ofs) {
@@ -543,7 +543,7 @@
 		public extern static IntPtr ReAllocHGlobal (IntPtr pv, IntPtr cb);

 #if NET_2_0
-		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, CER.Success)]
+		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, Cer.Success)]
 #endif
 		[MonoTODO]
 		public static int Release (IntPtr pUnk) {
@@ -647,7 +647,7 @@
 #endif

 #if NET_2_0
-		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, CER.MayFail)]
+		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, Cer.MayFail)]
 #endif
 		[MethodImplAttribute(MethodImplOptions.InternalCall)]
 		public extern static void StructureToPtr (object structure, IntPtr ptr, bool fDeleteOld);
Index: System.Collections/Hashtable.cs
===================================================================
--- System.Collections/Hashtable.cs	(revision 41077)
+++ System.Collections/Hashtable.cs	(working copy)
@@ -375,7 +375,7 @@
 		}

 #if NET_2_0
-		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, CER.Success)]
+		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, Cer.Success)]
 #endif
 		public virtual void Clear ()
 		{
@@ -400,7 +400,7 @@
 		}

 #if NET_2_0
-		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, CER.Success)]
+		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, Cer.Success)]
 #endif
 		public virtual void Remove (Object key)
 		{
Index: System.Runtime.ConstrainedExecution/ReliabilityContractAttribute.cs
===================================================================
--- System.Runtime.ConstrainedExecution/ReliabilityContractAttribute.cs	(revision 41077)
+++ System.Runtime.ConstrainedExecution/ReliabilityContractAttribute.cs	(working copy)
@@ -4,9 +4,9 @@
 // Author:
 //    Duncan Mak (duncan@ximian.com)
 //
-// Permission is hereby granted, free of charge, to any person obtaining
-// a copy of this software and associated documentation files (the
-// "Software"), to deal in the Software without restriction, including
+// Permission is hereby	granted, free of charge, to any	person obtaining
+// a copy of this software and associated documentation	files (the
+// "Software"),	to deal	in the Software	without	restriction, including
 // without limitation the rights to use, copy, modify, merge, publish,
 // distribute, sublicense, and/or sell copies of the Software, and to
 // permit persons to whom the Software is furnished to do so, subject to
@@ -15,13 +15,13 @@
 // The above copyright notice and this permission notice shall be
 // included in all copies or substantial portions of the Software.
 //
-// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
-// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
-// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
-// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
-// LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
-// OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
-// WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+// THE SOFTWARE	IS PROVIDED "AS	IS", WITHOUT WARRANTY OF ANY KIND,
+// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE	WARRANTIES OF
+// MERCHANTABILITY, FITNESS FOR	A PARTICULAR PURPOSE AND
+// NONINFRINGEMENT. IN NO EVENT	SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
+// LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN	AN ACTION
+// OF CONTRACT,	TORT OR	OTHERWISE, ARISING FROM, OUT OF	OR IN CONNECTION
+// WITH	THE SOFTWARE OR	THE USE	OR OTHER DEALINGS IN THE SOFTWARE.
 //
 // Copyright (C) 2004 Novell, Inc (http://www.novell.com)
 //
@@ -32,35 +32,52 @@

 namespace System.Runtime.ConstrainedExecution
 {
-	[AttributeUsage ((AttributeTargets.Assembly | AttributeTargets.Class | AttributeTargets.Struct |
+	[AttributeUsage	((AttributeTargets.Assembly | AttributeTargets.Class | AttributeTargets.Struct |
 		AttributeTargets.Constructor | AttributeTargets.Method), Inherited=false)]
 	[ComVisible (false)]
-        public sealed class ReliabilityContractAttribute : Attribute
-        {
-                Consistency consistency;
-                CER cer;
-
-                public ReliabilityContractAttribute ()
-                {
-                }
+	public sealed class ReliabilityContractAttribute : Attribute
+	{
+		private	Consistency consistency;
+		private	Cer cer;
+
+		public ReliabilityContractAttribute ()
+		{
+		}

-                public ReliabilityContractAttribute (Consistency consistency, CER cer)
-                {
-                        this.consistency = consistency;
-                        this.cer = cer;
-                }
+		[CLSCompliant (false)]
+		public ReliabilityContractAttribute (Consistency consistency, Cer cer)
+		{
+			this.consistency = consistency;
+			this.cer = cer;
+		}

-                public CER CER {
-                        get { return cer; }
-			set { cer = value; }
-                }
+		[MonoTODO ("Remove this	method once dependencies on CER	are removed")]
+		[Obsolete ("CER	has been replaced with Cer")]
+		[CLSCompliant (false)]
+		public ReliabilityContractAttribute (Consistency consistency, CER cer)
+		{
+			this.consistency = consistency;
+			this.cer = (Cer)(Int32)cer;
+		}

-                public Consistency ConsistencyGuarantee {
+		[MonoTODO ("Remove this	method once dependencies on CER	are removed")]
+		[Obsolete ("CER	has been replaced with Cer")]
+		[CLSCompliant (false)]
+		public CER CER {
+			get { return (CER)(Int32)cer; }
+			set { cer = (Cer)(Int32)value; }
+		}

-                        get { return consistency; }
-
-                        set { consistency = value; }
-                }
-        }
+		[CLSCompliant (false)]
+		public Cer Cer {
+			get { return cer; }
+			set { cer = value; }
+		}
+
+		public Consistency ConsistencyGuarantee	{
+			get { return consistency; }
+			set { consistency = value; }
+		}
+	}
 }
 #endif
Index: System.Runtime.ConstrainedExecution/CriticialFinalizerObject.cs
===================================================================
--- System.Runtime.ConstrainedExecution/CriticialFinalizerObject.cs	(revision 41077)
+++ System.Runtime.ConstrainedExecution/CriticialFinalizerObject.cs	(working copy)
@@ -29,16 +29,16 @@
 #if NET_2_0
 namespace System.Runtime.ConstrainedExecution
 {
-        public abstract class CriticalFinalizerObject
-        {
-                protected CriticalFinalizerObject ()
-                {
-                }
+	public abstract class CriticalFinalizerObject
+	{
+		protected CriticalFinalizerObject ()
+		{
+		}

-		[ReliabilityContract (Consistency.WillNotCorruptState, CER.Success)]
+		[ReliabilityContract (Consistency.WillNotCorruptState, Cer.Success)]
 		~CriticalFinalizerObject ()
 		{
 		}
-        }
+	}
 }
 #endif
Index: System.Runtime.ConstrainedExecution/CER.cs
===================================================================
--- System.Runtime.ConstrainedExecution/CER.cs	(revision 41077)
+++ System.Runtime.ConstrainedExecution/CER.cs	(working copy)
@@ -3,7 +3,12 @@
 //
 // Author:
 //    Duncan Mak (duncan@ximian.com)
+//    Jesse Towner (townerj@gmail.com)
 //
+// Notice:
+//    This enumeration only exists for backwards compatability, and
+//    can be removed when all dependencies have been removed.
+//
 // Permission is hereby granted, free of charge, to any person obtaining
 // a copy of this software and associated documentation files (the
 // "Software"), to deal in the Software without restriction, including
@@ -27,18 +32,30 @@
 //

 #if NET_2_0
-
 using System.Runtime.InteropServices;

 namespace System.Runtime.ConstrainedExecution
 {
+	[CLSCompliant (false)]
 	[Serializable]
 	[ComVisible (false)]
-        public enum CER
-        {
-                MayFail = 1,
-                None = 0,
-                Success = 2
-        }
+	public enum Cer
+	{
+		MayFail = 1,
+		None = 0,
+		Success = 2
+	}
+
+	[CLSCompliant (false)]
+	[MonoTODO ("Replace dependencies on this enum with Cer")]
+	[Obsolete ("Has been replaced by System.Runtime.ConstrainedExecution.Cer")]
+	[Serializable]
+	[ComVisible (false)]
+	public enum CER
+	{
+		MayFail = 1,
+		None = 0,
+		Success = 2
+	}
 }
 #endif
Index: System.Runtime.CompilerServices/RuntimeHelpers.cs
===================================================================
--- System.Runtime.CompilerServices/RuntimeHelpers.cs(revision 41077)
+++ System.Runtime.CompilerServices/RuntimeHelpers.cs	(working copy)
@@ -86,7 +86,7 @@

 #if NET_2_0
 		[MonoTODO]
-		[ReliabilityContract (Consistency.WillNotCorruptState, CER.MayFail)]
+		[ReliabilityContract (Consistency.WillNotCorruptState, Cer.MayFail)]
 		public static void PrepareConstrainedRegions () {
 			throw new NotImplementedException ();
 		}
