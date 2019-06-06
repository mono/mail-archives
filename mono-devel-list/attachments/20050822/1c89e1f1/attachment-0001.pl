Index: System.Globalization/RegionInfo.cs
===================================================================
--- System.Globalization/RegionInfo.cs	(revision 48630)
+++ System.Globalization/RegionInfo.cs	(working copy)
@@ -29,28 +29,17 @@
 //
 using System.Globalization;
 using System.Runtime.CompilerServices;
+using System.Threading;
 
 namespace System.Globalization
 {
 	[Serializable]
 	public class RegionInfo
 	{
-		static RegionInfo currentRegion;
-
 		// This property is not synchronized with CurrentCulture, so
 		// we need to use bootstrap CurrentCulture LCID.
 		public static RegionInfo CurrentRegion {
-			get {
-				if (currentRegion == null) {
-					// make sure to fill BootstrapCultureID.
-					CultureInfo ci = CultureInfo.CurrentCulture;
-					// If current culture is invariant then region is not available.
-					if (ci == null || CultureInfo.BootstrapCultureID == 0x7F)
-						return null;
-					currentRegion = new RegionInfo (CultureInfo.BootstrapCultureID);
-				}
-				return currentRegion;
-			}
+			get { return Thread.CurrentRegion; }
 		}
 
 		int regionId;
Index: System.Threading/Thread.cs
===================================================================
--- System.Threading/Thread.cs	(revision 48630)
+++ System.Threading/Thread.cs	(working copy)
@@ -59,6 +59,7 @@
 		
 		private IntPtr culture_info;
 		private IntPtr ui_culture_info;
+		private IntPtr region_info;
 		private bool threadpool_thread;
 		/* accessed only from unmanaged code */
 		private IntPtr name;
@@ -317,6 +318,9 @@
 		private extern CultureInfo GetCachedCurrentUICulture ();
 
 		[MethodImplAttribute (MethodImplOptions.InternalCall)]
+		private static extern RegionInfo GetCachedCurrentRegion ();
+
+		[MethodImplAttribute (MethodImplOptions.InternalCall)]
 		private extern byte[] GetSerializedCurrentUICulture ();
 
 		[MethodImplAttribute (MethodImplOptions.InternalCall)]
@@ -325,6 +329,9 @@
 		[MethodImplAttribute (MethodImplOptions.InternalCall)]
 		private extern void SetSerializedCurrentUICulture (byte[] culture);
 
+		[MethodImplAttribute (MethodImplOptions.InternalCall)]
+		private static extern void SetCachedCurrentRegion (RegionInfo region);
+
 		/* If the current_lcid() isn't known by CultureInfo,
 		 * it will throw an exception which may cause
 		 * String.Concat to try and recursively look up the
@@ -476,6 +483,23 @@
 			}
 		}
 
+		internal static RegionInfo CurrentRegion {
+			get {
+				RegionInfo region = GetCachedCurrentRegion ();
+				// unlike CurrentCulture, creating different
+				// instance between AppDomain should be OK.
+				if (region != null)
+					return region;
+
+				// make sure that CurrentCulture exists.
+				CultureInfo current = CurrentThread.CurrentCulture;
+				region = new RegionInfo (
+					CultureInfo.BootstrapCultureID);
+				SetCachedCurrentRegion (region);
+				return region;
+			}
+		}
+
 		public bool IsThreadPoolThread {
 			get {
 				return IsThreadPoolThreadInternal;
