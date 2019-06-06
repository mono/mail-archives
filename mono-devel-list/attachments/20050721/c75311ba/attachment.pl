Index: corlib.dll.sources
===================================================================
--- corlib.dll.sources	(revision 47350)
+++ corlib.dll.sources	(working copy)
@@ -8,6 +8,12 @@
 Microsoft.Win32/Win32RegistryApi.cs
 Microsoft.Win32/Win32ResultCode.cs
 Microsoft.Win32.SafeHandles/SafeFileHandle.cs
+Mono.Globalization.Unicode/CodePointIndexer.cs
+Mono.Globalization.Unicode/MSCompatUnicodeTable.cs
+Mono.Globalization.Unicode/MSCompatUnicodeTableUtil.cs
+Mono.Globalization.Unicode/SimpleCollator.cs
+Mono.Globalization.Unicode/SortKey.cs
+Mono.Globalization.Unicode/SortKeyBuffer.cs
 Mono/Runtime.cs
 Mono.Math/BigInteger.cs
 Mono.Math.Prime/ConfidenceFactor.cs
@@ -300,7 +306,6 @@
 System.Globalization/NumberFormatInfo.cs
 System.Globalization/NumberStyles.cs
 System.Globalization/RegionInfo.cs
-System.Globalization/SortKey.cs
 System.Globalization/StringInfo.cs
 System.Globalization/TaiwanCalendar.cs
 System.Globalization/TextElementEnumerator.cs
Index: Makefile
===================================================================
--- Makefile	(revision 47350)
+++ Makefile	(working copy)
@@ -3,13 +3,24 @@
 include ../../build/rules.make
 export __SECURITY_BOOTSTRAP_DB=$(topdir)/class/corlib
 
+
+RESOURCE_FILES = \
+	collation.core.bin \
+	collation.tailoring.bin \
+	collation.cjkCHS.bin \
+	collation.cjkCHT.bin \
+	collation.cjkJA.bin \
+	collation.cjkKO.bin \
+	collation.cjkKOlv2.bin
+
 # corlib is crazy to build so we skip build/library.make and do stuff
 # ourselves.
 #
 # Here, we define a bunch of variables.
 
 corlib_flags = /unsafe /nostdlib
-LOCAL_MCS_FLAGS = /nowarn:649 /nowarn:169 /nowarn:414 -nowarn:612 -nowarn:618 -d:INSIDE_CORLIB
+LOCAL_MCS_FLAGS = /nowarn:649 /nowarn:169 /nowarn:414 -nowarn:612 -nowarn:618 -d:INSIDE_CORLIB \
+	$(RESOURCE_FILES:%=/resource:%)
 
 LIBRARY = corlib.dll
 LIBRARY_NAME = mscorlib.dll
Index: System/String.cs
===================================================================
--- System/String.cs	(revision 47350)
+++ System/String.cs	(working copy)
@@ -746,7 +746,7 @@
 			if (this.length < value.length)
 				return false;
 
-			return (0 == Compare (this, 0, value, 0 , value.length));
+			return CultureInfo.CurrentCulture.CompareInfo.IsPrefix (this, value);
 		}
 
 		/* This method is culture insensitive */
Index: System.Globalization/CompareInfo.cs
===================================================================
--- System.Globalization/CompareInfo.cs	(revision 47350)
+++ System.Globalization/CompareInfo.cs	(working copy)
@@ -34,12 +34,25 @@
 using System.Reflection;
 using System.Runtime.Serialization;
 using System.Runtime.CompilerServices;
+using Mono.Globalization.Unicode;
 
 namespace System.Globalization
 {
 	[Serializable]
 	public class CompareInfo : IDeserializationCallback
 	{
+		static readonly bool useManagedCollation =
+			Environment.GetEnvironmentVariable ("MONO_USE_MANAGED_COLLATION")
+			== "yes";
+
+		public static bool UseManagedCollation {
+			get {
+				if (!useManagedCollation)
+					return false;
+				return MSCompatUnicodeTable.IsReady;
+			}
+		}
+
 		// Keep in synch with MonoCompareInfo in the runtime. 
 		private int culture;
 		[NonSerialized]
@@ -47,6 +60,9 @@
 		[NonSerialized]
 		private IntPtr ICU_collator;
 		private int win32LCID;	// Unused, but MS.NET serializes this
+
+		[NonSerialized]
+		SimpleCollator collator;
 		
 		/* Hide the .ctor() */
 		CompareInfo() {}
@@ -57,39 +73,59 @@
 		internal CompareInfo (CultureInfo ci)
 		{
 			this.culture = ci.LCID;
-			this.icu_name = ci.IcuName;
-			this.construct_compareinfo (icu_name);
+			if (UseManagedCollation) 
+				collator = new SimpleCollator (ci);
+			else {
+				this.icu_name = ci.IcuName;
+				this.construct_compareinfo (icu_name);
+			}
 		}
 		
 		[MethodImplAttribute (MethodImplOptions.InternalCall)]
 		private extern void free_internal_collator ();
-		
+
 		~CompareInfo ()
 		{
-			free_internal_collator ();
+			if (UseManagedCollation)
+				collator = null;
+			else
+				free_internal_collator ();
 		}
-		
-		
+
 		[MethodImplAttribute (MethodImplOptions.InternalCall)]
 		private extern int internal_compare (string str1, int offset1,
 						     int length1, string str2,
 						     int offset2, int length2,
 						     CompareOptions options);
 
+		private int internal_compare_managed (string str1, int offset1,
+						int length1, string str2,
+						int offset2, int length2,
+						CompareOptions options)
+		{
+			return collator.Compare (str1, offset1, length1,
+				str2, offset2, length2, options);
+		}
+
+		private int internal_compare_switch (string str1, int offset1,
+						int length1, string str2,
+						int offset2, int length2,
+						CompareOptions options)
+		{
+			return UseManagedCollation ?
+				internal_compare_managed (str1, offset1, length1,
+				str2, offset2, length2, options) :
+				internal_compare (str1, offset1, length1,
+				str2, offset2, length2, options);
+		}
+
 		public virtual int Compare (string string1, string string2)
 		{
-			/* Short cuts... */
-			if(string1.Length == 0) {
-				if(string2.Length == 0) {
-					return(0);
-				} else {
-					return(-1);
-				}
-			} else if(string2.Length == 0) {
-				return(1);
-			}
+			/* Short cut... */
+			if(string1.Length == 0 && string2.Length == 0)
+				return(0);
 
-			return(internal_compare (string1, 0, string1.Length,
+			return(internal_compare_switch (string1, 0, string1.Length,
 						 string2, 0, string2.Length,
 						 CompareOptions.None));
 		}
@@ -97,18 +133,11 @@
 		public virtual int Compare (string string1, string string2,
 					    CompareOptions options)
 		{
-			/* Short cuts... */
-			if(string1.Length == 0) {
-				if(string2.Length == 0) {
-					return(0);
-				} else {
-					return(-1);
-				}
-			} else if(string2.Length == 0) {
-				return(1);
-			}
+			/* Short cut... */
+			if(string1.Length == 0 && string2.Length == 0)
+				return(0);
 
-			return(internal_compare (string1, 0, string1.Length,
+			return(internal_compare_switch (string1, 0, string1.Length,
 						 string2, 0, string2.Length,
 						 options));
 		}
@@ -121,18 +150,9 @@
 			 * the offset >= string length specified check
 			 * in the process...)
 			 */
-			if(string1.Length == 0 ||
-			   offset1 == string1.Length) {
-				if(string2.Length == 0 ||
-				   offset2 == string2.Length) {
-					return(0);
-				} else {
-					return(-1);
-				}
-			} else if(string2.Length == 0 ||
-				  offset2 == string2.Length) {
-				return(1);
-			}
+			if ((string1.Length == 0 || offset1 == string1.Length) &&
+				(string2.Length == 0 || offset2 == string2.Length))
+				return(0);
 
 			if(offset1 < 0 || offset2 < 0) {
 				throw new ArgumentOutOfRangeException ("Offsets must not be less than zero");
@@ -146,7 +166,7 @@
 				throw new ArgumentOutOfRangeException ("Offset2 is greater than or equal to the length of string2");
 			}
 			
-			return(internal_compare (string1, offset1,
+			return(internal_compare_switch (string1, offset1,
 						 string1.Length-offset1,
 						 string2, offset2,
 						 string2.Length-offset2,
@@ -162,18 +182,9 @@
 			 * the offset >= string length specified check
 			 * in the process...)
 			 */
-			if(string1.Length == 0 ||
-			   offset1 == string1.Length) {
-				if(string2.Length == 0 ||
-				   offset2 == string2.Length) {
-					return(0);
-				} else {
-					return(-1);
-				}
-			} else if(string2.Length == 0 ||
-				  offset2 == string2.Length) {
-				return(1);
-			}
+			if((string1.Length == 0 || offset1 == string1.Length) &&
+				(string2.Length == 0 || offset2 == string2.Length))
+				return(0);
 
 			if(offset1 < 0 || offset2 < 0) {
 				throw new ArgumentOutOfRangeException ("Offsets must not be less than zero");
@@ -187,7 +198,7 @@
 				throw new ArgumentOutOfRangeException ("Offset2 is greater than or equal to the length of string2");
 			}
 			
-			return(internal_compare (string1, offset1,
+			return(internal_compare_switch (string1, offset1,
 						 string1.Length-offset1,
 						 string2, offset2,
 						 string2.Length-offset1,
@@ -203,21 +214,13 @@
 			 * the offset >= string length specified check
 			 * in the process...)
 			 */
-			if(string1.Length == 0 ||
-			   offset1 == string1.Length ||
-			   length1 == 0) {
-				if(string2.Length == 0 ||
-				   offset2 == string2.Length ||
-				   length2 == 0) {
-					return(0);
-				} else {
-					return(-1);
-				}
-			} else if(string2.Length == 0 ||
-				  offset2 == string2.Length ||
-				  length2 == 0) {
-				return(1);
-			}
+			if((string1.Length == 0 ||
+				offset1 == string1.Length ||
+				length1 == 0) &&
+				(string2.Length == 0 ||
+				offset2 == string2.Length ||
+				length2 == 0))
+				return(0);
 
 			if(offset1 < 0 || length1 < 0 ||
 			   offset2 < 0 || length2 < 0) {
@@ -240,7 +243,7 @@
 				throw new ArgumentOutOfRangeException ("Length2 is greater than the number of characters from offset2 to the end of string2");
 			}
 			
-			return(internal_compare (string1, offset1, length1,
+			return(internal_compare_switch (string1, offset1, length1,
 						 string2, offset2, length2,
 						 CompareOptions.None));
 		}
@@ -255,21 +258,13 @@
 			 * the offset >= string length specified check
 			 * in the process...)
 			 */
-			if(string1.Length == 0 ||
-			   offset1 == string1.Length ||
-			   length1 == 0) {
-				if(string2.Length == 0 ||
-				   offset2 == string2.Length ||
-				   length2 == 0) {
+			if((string1.Length == 0 ||
+				offset1 == string1.Length ||
+				length1 == 0) &&
+				(string2.Length == 0 ||
+				offset2 == string2.Length ||
+				length2 == 0))
 					return(0);
-				} else {
-					return(-1);
-				}
-			} else if(string2.Length == 0 ||
-				  offset2 == string2.Length ||
-				  length2 == 0) {
-				return(1);
-			}
 
 			if(offset1 < 0 || length1 < 0 ||
 			   offset2 < 0 || length2 < 0) {
@@ -292,7 +287,7 @@
 				throw new ArgumentOutOfRangeException ("Length2 is greater than the number of characters from offset2 to the end of string2");
 			}
 			
-			return(internal_compare (string1, offset1, length1,
+			return(internal_compare_switch (string1, offset1, length1,
 						 string2, offset2, length2,
 						 options));
 		}
@@ -372,6 +367,8 @@
 		public virtual SortKey GetSortKey(string source,
 						  CompareOptions options)
 		{
+			if (UseManagedCollation)
+				return collator.GetSortKey (source, options);
 			SortKey key=new SortKey (culture, source, options);
 
 			/* Need to do the icall here instead of in the
@@ -460,7 +457,26 @@
 						   int count, char value,
 						   CompareOptions options,
 						   bool first);
-		
+
+		private int internal_index_managed (string s, int sindex,
+			int count, char c, CompareOptions opt,
+			bool first)
+		{
+			return first ?
+				collator.IndexOf (s, c, sindex, count, opt) :
+				collator.LastIndexOf (s, c, sindex, count, opt);
+		}
+
+		private int internal_index_switch (string s, int sindex,
+			int count, char c, CompareOptions opt,
+			bool first)
+		{
+			return UseManagedCollation &&
+				(CompareOptions.Ordinal & opt) == 0 ?
+				internal_index_managed (s, sindex, count, c, opt, first) :
+				internal_index (s, sindex, count, c, opt, first);
+		}
+
 		public virtual int IndexOf (string source, char value,
 					    int startIndex, int count,
 					    CompareOptions options)
@@ -492,7 +508,7 @@
 				}
 				return(-1);
 			} else {
-				return (internal_index (source, startIndex,
+				return (internal_index_switch (source, startIndex,
 							count, value, options,
 							true));
 			}
@@ -503,7 +519,26 @@
 						   int count, string value,
 						   CompareOptions options,
 						   bool first);
-		
+
+		private int internal_index_managed (string s1, int sindex,
+			int count, string s2, CompareOptions opt,
+			bool first)
+		{
+			return first ?
+				collator.IndexOf (s1, s2, sindex, count, opt) :
+				collator.LastIndexOf (s1, s2, sindex, count, opt);
+		}
+
+		private int internal_index_switch (string s1, int sindex,
+			int count, string s2, CompareOptions opt,
+			bool first)
+		{
+			return UseManagedCollation &&
+				(CompareOptions.Ordinal & opt) == 0 ?
+				internal_index_managed (s1, sindex, count, s2, opt, first) :
+				internal_index (s1, sindex, count, s2, opt, first);
+		}
+
 		public virtual int IndexOf (string source, string value,
 					    int startIndex, int count,
 					    CompareOptions options)
@@ -524,7 +559,7 @@
 				return(-1);
 			}
 
-			return (internal_index (source, startIndex, count,
+			return (internal_index_switch (source, startIndex, count,
 						value, options, true));
 		}
 
@@ -543,6 +578,9 @@
 				throw new ArgumentNullException("prefix");
 			}
 
+			if (UseManagedCollation)
+				return collator.IsPrefix (source, prefix, options);
+
 			if(source.Length < prefix.Length) {
 				return(false);
 			} else {
@@ -567,6 +605,9 @@
 				throw new ArgumentNullException("suffix");
 			}
 
+			if (UseManagedCollation)
+				return collator.IsSuffix (source, suffix, options);
+
 			if(source.Length < suffix.Length) {
 				return(false);
 			} else {
@@ -682,7 +723,7 @@
 				}
 				return(-1);
 			} else {
-				return (internal_index (source, startIndex,
+				return (internal_index_switch (source, startIndex,
 							count, value, options,
 							false));
 			}
@@ -713,7 +754,7 @@
 				return(0);
 			}
 
-			return(internal_index (source, startIndex, count,
+			return(internal_index_switch (source, startIndex, count,
 					       value, options, false));
 		}
 
@@ -724,13 +765,17 @@
 
 		void IDeserializationCallback.OnDeserialization(object sender)
 		{
-			/* This will build the ICU collator, and store
-			 * the pointer in ICU_collator
-			 */
-			try {
-				this.construct_compareinfo (icu_name);
-			} catch {
-				ICU_collator=IntPtr.Zero;
+			if (UseManagedCollation) {
+				collator = new SimpleCollator (new CultureInfo (culture));
+			} else {
+				/* This will build the ICU collator, and store
+				 * the pointer in ICU_collator
+				 */
+				try {
+					this.construct_compareinfo (icu_name);
+				} catch {
+					ICU_collator=IntPtr.Zero;
+				}
 			}
 		}
 