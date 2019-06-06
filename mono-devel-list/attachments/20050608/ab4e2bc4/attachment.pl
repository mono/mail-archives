Index: ChangeLog
===================================================================
--- ChangeLog	(revision 45568)
+++ ChangeLog	(working copy)
@@ -1,3 +1,9 @@
+2005-06-08 Ilya Kharmatsky <ilyak-at-mainsoft.com>
+
+    * HttpRuntimeConfig.cs: Added TARGET_JVM directive in "using clause"
+      in order to exclude in J2EE configuration usage of unsupported
+      CodeDome API.
+       
 2005-05-04 Gonzalo Paniagua Javier <gonzalo@ximian.com>
 
 	* CompilationConfiguration.cs: throw if we cannot load the type given
Index: HttpRuntimeConfig.cs
===================================================================
--- HttpRuntimeConfig.cs	(revision 45568)
+++ HttpRuntimeConfig.cs	(working copy)
@@ -29,7 +29,9 @@
 //
 
 using System;
+#if !TARGET_J2EE
 using System.CodeDom.Compiler;
+#endif
 using System.Collections;
 using System.Configuration;
 using System.IO;

