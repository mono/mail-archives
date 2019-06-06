Index: class/System.Transactions/Assembly/AssemblyInfo.cs
===================================================================
--- class/System.Transactions/Assembly/AssemblyInfo.cs	(revision 66235)
+++ class/System.Transactions/Assembly/AssemblyInfo.cs	(working copy)
@@ -45,7 +45,9 @@
 [assembly: NeutralResourcesLanguage ("en-US")]
 
 [assembly: AssemblyDelaySign (true)]
-[assembly: AssemblyKeyFile ("../msfinal.pub")]
+#if !TARGET_JVM
+[assembly: AssemblyKeyFile ("../ecma.pub")]
+#endif
 
 #if NET_2_0
 [assembly: AssemblyCompany ("MONO development team")]
