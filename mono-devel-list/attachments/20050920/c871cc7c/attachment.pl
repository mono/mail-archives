Index: CompareInfo.cs
===================================================================
--- CompareInfo.cs	(revision 50272)
+++ CompareInfo.cs	(working copy)
@@ -42,8 +42,8 @@
 	public class CompareInfo : IDeserializationCallback
 	{
 		static readonly bool useManagedCollation =
-			Environment.internalGetEnvironmentVariable ("MONO_USE_MANAGED_COLLATION")
-			== "yes";
+			Environment.internalGetEnvironmentVariable ("MONO_DISABLE_MANAGED_COLLATION")
+			!= "yes";
 
 		internal static bool UseManagedCollation {
 			get { return useManagedCollation && MSCompatUnicodeTable.IsReady; }