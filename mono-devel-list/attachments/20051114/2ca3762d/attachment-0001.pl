Index: typemanager.cs
===================================================================
--- typemanager.cs	(revision 52958)
+++ typemanager.cs	(working copy)
@@ -587,6 +587,14 @@
 	/// </summary>
 	static public string GetFullNameSignature (MemberInfo mi)
 	{
+		PropertyInfo pi = mi as PropertyInfo;
+		if (pi != null) {
+			MethodBase pmi = pi.GetGetMethod ();
+			if (pmi == null)
+				pmi = pi.GetSetMethod ();
+			if (GetParameterData (pmi).Count > 0)
+				mi = pmi;
+		}
 		return (mi is MethodBase)
 			? CSharpSignature (mi as MethodBase) 
 			: CSharpName (mi.DeclaringType) + '.' + mi.Name;
@@ -629,14 +637,17 @@
 
 		// Is indexer
 		if (mb.IsSpecialName && !mb.IsConstructor) {
-			if (iparams.Count > 1) {
+			if (iparams.Count > (mb.Name.StartsWith ("get_") ? 0 : 1)) {
 				sig.Append ("this[");
 				if (show_accessor) {
 					sig.Append (parameters.Substring (1, parameters.Length - 2));
 				}
 				else {
 					int before_ret_val = parameters.LastIndexOf (',');
-					sig.Append (parameters.Substring (1, before_ret_val - 1));
+					if (before_ret_val < 0)
+						sig.Append (parameters.Substring (1, parameters.Length - 2));
+					else
+						sig.Append (parameters.Substring (1, before_ret_val - 1));
 				}
 				sig.Append (']');
 			} else {