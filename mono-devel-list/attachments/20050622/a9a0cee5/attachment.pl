Index: corlib.dll.sources
===================================================================
--- corlib.dll.sources	(revision 46284)
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
Index: System.Globalization/CompareInfo.cs
===================================================================
--- System.Globalization/CompareInfo.cs	(revision 46284)
+++ System.Globalization/CompareInfo.cs	(working copy)
@@ -34,12 +34,17 @@
 using System.Reflection;
 using System.Runtime.Serialization;
 using System.Runtime.CompilerServices;
+using Mono.Globalization.Unicode;
 
 namespace System.Globalization
 {
 	[Serializable]
 	public class CompareInfo : IDeserializationCallback
 	{
+		public static readonly bool UseManagedCollation =
+			Environment.GetEnvironmentVariable ("MONO_USE_MANAGED_COLLATION")
+			== "yes";
+
 		// Keep in synch with MonoCompareInfo in the runtime. 
 		private int culture;
 		[NonSerialized]
@@ -47,6 +52,8 @@
 		[NonSerialized]
 		private IntPtr ICU_collator;
 		private int win32LCID;	// Unused, but MS.NET serializes this
+
+		SimpleCollator collator;
 		
 		/* Hide the .ctor() */
 		CompareInfo() {}
@@ -57,25 +64,50 @@
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
+			if (!UseManagedCollation)
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
 			/* Short cuts... */
@@ -89,7 +121,7 @@
 				return(1);
 			}
 
-			return(internal_compare (string1, 0, string1.Length,
+			return(internal_compare_switch (string1, 0, string1.Length,
 						 string2, 0, string2.Length,
 						 CompareOptions.None));
 		}
@@ -108,7 +140,7 @@
 				return(1);
 			}
 
-			return(internal_compare (string1, 0, string1.Length,
+			return(internal_compare_switch (string1, 0, string1.Length,
 						 string2, 0, string2.Length,
 						 options));
 		}
@@ -146,7 +178,7 @@
 				throw new ArgumentOutOfRangeException ("Offset2 is greater than or equal to the length of string2");
 			}
 			
-			return(internal_compare (string1, offset1,
+			return(internal_compare_switch (string1, offset1,
 						 string1.Length-offset1,
 						 string2, offset2,
 						 string2.Length-offset2,
@@ -187,7 +219,7 @@
 				throw new ArgumentOutOfRangeException ("Offset2 is greater than or equal to the length of string2");
 			}
 			
-			return(internal_compare (string1, offset1,
+			return(internal_compare_switch (string1, offset1,
 						 string1.Length-offset1,
 						 string2, offset2,
 						 string2.Length-offset1,
@@ -240,7 +272,7 @@
 				throw new ArgumentOutOfRangeException ("Length2 is greater than the number of characters from offset2 to the end of string2");
 			}
 			
-			return(internal_compare (string1, offset1, length1,
+			return(internal_compare_switch (string1, offset1, length1,
 						 string2, offset2, length2,
 						 CompareOptions.None));
 		}
@@ -292,7 +324,7 @@
 				throw new ArgumentOutOfRangeException ("Length2 is greater than the number of characters from offset2 to the end of string2");
 			}
 			
-			return(internal_compare (string1, offset1, length1,
+			return(internal_compare_switch (string1, offset1, length1,
 						 string2, offset2, length2,
 						 options));
 		}
@@ -372,6 +404,8 @@
 		public virtual SortKey GetSortKey(string source,
 						  CompareOptions options)
 		{
+			if (UseManagedCollation)
+				return collator.GetSortKey (source, options);
 			SortKey key=new SortKey (culture, source, options);
 
 			/* Need to do the icall here instead of in the
@@ -460,7 +494,25 @@
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
+			return UseManagedCollation ?
+				internal_index_managed (s, sindex, count, c, opt, first) :
+				internal_index (s, sindex, count, c, opt, first);
+		}
+
 		public virtual int IndexOf (string source, char value,
 					    int startIndex, int count,
 					    CompareOptions options)
@@ -492,7 +544,7 @@
 				}
 				return(-1);
 			} else {
-				return (internal_index (source, startIndex,
+				return (internal_index_switch (source, startIndex,
 							count, value, options,
 							true));
 			}
@@ -503,7 +555,25 @@
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
+			return UseManagedCollation ?
+				internal_index_managed (s1, sindex, count, s2, opt, first) :
+				internal_index (s1, sindex, count, s2, opt, first);
+		}
+
 		public virtual int IndexOf (string source, string value,
 					    int startIndex, int count,
 					    CompareOptions options)
@@ -524,7 +594,7 @@
 				return(-1);
 			}
 
-			return (internal_index (source, startIndex, count,
+			return (internal_index_switch (source, startIndex, count,
 						value, options, true));
 		}
 
@@ -682,7 +752,7 @@
 				}
 				return(-1);
 			} else {
-				return (internal_index (source, startIndex,
+				return (internal_index_switch (source, startIndex,
 							count, value, options,
 							false));
 			}
@@ -713,7 +783,7 @@
 				return(0);
 			}
 
-			return(internal_index (source, startIndex, count,
+			return(internal_index_switch (source, startIndex, count,
 					       value, options, false));
 		}
 
@@ -724,6 +794,9 @@
 
 		void IDeserializationCallback.OnDeserialization(object sender)
 		{
+			if (UseManagedCollation)
+				return; // maybe nothing to do.
+
 			/* This will build the ICU collator, and store
 			 * the pointer in ICU_collator
 			 */