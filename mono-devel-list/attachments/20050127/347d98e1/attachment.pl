Index: Npgsql.dll.sources
===================================================================
--- Npgsql.dll.sources	(revision 39639)
+++ Npgsql.dll.sources	(working copy)
@@ -1,4 +1,9 @@
 Npgsql/AssemblyInfo.cs
+Npgsql/Design/ConnectionStringEditor.cs
+Npgsql/Design/ConnectionStringEditorForm.cs
+Npgsql/Design/NpgsqlParameterConverter.cs
+Npgsql/Design/NpgsqlParametersEditor.cs
+Npgsql/Design/NpgsqlSysDescriptionAttribute.cs
 Npgsql/HashAlgorithm.cs
 Npgsql/MD5.cs
 Npgsql/MD5CryptoServiceProvider.cs
@@ -49,8 +54,3 @@
 NpgsqlTypes/NpgsqlTypeConverters.cs
 NpgsqlTypes/NpgsqlTypes.cs
 NpgsqlTypes/NpgsqlTypesHelper.cs
-
-
-
-
-
Index: Makefile
===================================================================
--- Makefile	(revision 39639)
+++ Makefile	(working copy)
@@ -8,7 +8,11 @@
 
 LIB_MCS_FLAGS = /r:$(corlib) /r:System.dll /r:System.Xml.dll \
 		/r:System.Data.dll  \
+		/r:System.Design.dll  \
+		/r:System.Drawing.dll  \
+		/r:System.Windows.Forms.dll \
 		/r:Mono.Security.dll \
+		/d:WITHDESIGN \
 		@Npgsql.dll.resources
 
 TEST_MCS_FLAGS = /r:$(corlib) /r:System.dll /r:System.Xml.dll \
