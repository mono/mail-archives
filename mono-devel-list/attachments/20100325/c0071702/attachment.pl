Index: test/1.1/webcontrols/dbpage1.aspx
===================================================================
--- test/1.1/webcontrols/dbpage1.aspx	(revision 154071)
+++ test/1.1/webcontrols/dbpage1.aspx	(working copy)
@@ -30,12 +30,12 @@
 	        Version ver = Environment.Version;
 		if (providerAssembly == null || providerAssembly == "")
 	                if (ver.Major == 1)
-			         providerAssembly = "Mono.Data.SqliteClient, Version=1.0.5000.0, Culture=neutral, PublicKeyToken=0738eb9f132ed756";
+			         providerAssembly = "Mono.Data.Sqlite, Version=1.0.5000.0, Culture=neutral, PublicKeyToken=0738eb9f132ed756";
 	                else if (ver.Major == 2)
-	                         providerAssembly = "Mono.Data.SqliteClient, Version=2.0.0.0, Culture=neutral, PublicKeyToken=0738eb9f132ed756";
+	                         providerAssembly = "Mono.Data.Sqlite, Version=2.0.0.0, Culture=neutral, PublicKeyToken=0738eb9f132ed756";
 
 		if (cncTypeName == null || cncTypeName == "")
-			cncTypeName = "Mono.Data.SqliteClient.SqliteConnection";
+			cncTypeName = "Mono.Data.Sqlite.SqliteConnection";
 		
 		if (cncString == null || cncString == "") {
 	                string dbPath = Path.Combine (Path.GetDirectoryName (Request.MapPath (Request.FilePath)), "dbpage1.sqlite");
Index: test/1.1/webcontrols/dbpage_test_setup.cs
===================================================================
--- test/1.1/webcontrols/dbpage_test_setup.cs	(revision 154071)
+++ test/1.1/webcontrols/dbpage_test_setup.cs	(working copy)
@@ -1,6 +1,6 @@
 using System;
 using System.IO;
-using Mono.Data.SqliteClient;
+using Mono.Data.Sqlite;
 
 class App
 {
Index: test/1.1/webcontrols/Makefile.am
===================================================================
--- test/1.1/webcontrols/Makefile.am	(revision 154079)
+++ test/1.1/webcontrols/Makefile.am	(working copy)
@@ -48,7 +48,7 @@
 EXTRA_DIST = $(sqlite_DATA) $(samples_DATA) $(dbpage_test_setup_build)
 
 dbpage_test_setup.exe: $(dbpage_test_setup_build)
-	$(GMCS) -debug:full -r:Mono.Data.SqliteClient.dll -out:$@ $^
+	$(GMCS) -debug:full -r:Mono.Data.Sqlite.dll -out:$@ $^
 
 dbpage1.sqlite: dbpage_test_setup.exe
 	$(RUNTIME) dbpage_test_setup.exe
Index: test/1.1/webcontrols/dbpage2.aspx
===================================================================
--- test/1.1/webcontrols/dbpage2.aspx	(revision 154071)
+++ test/1.1/webcontrols/dbpage2.aspx	(working copy)
@@ -36,12 +36,12 @@
 	        Version ver = Environment.Version;
 		if (providerAssembly == null || providerAssembly == "")
 	                if (ver.Major == 1)
-			         providerAssembly = "Mono.Data.SqliteClient, Version=1.0.5000.0, Culture=neutral, PublicKeyToken=0738eb9f132ed756";
+			         providerAssembly = "Mono.Data.Sqlite, Version=1.0.5000.0, Culture=neutral, PublicKeyToken=0738eb9f132ed756";
 	                else if (ver.Major == 2)
-	                         providerAssembly = "Mono.Data.SqliteClient, Version=2.0.0.0, Culture=neutral, PublicKeyToken=0738eb9f132ed756";
+	                         providerAssembly = "Mono.Data.Sqlite, Version=2.0.0.0, Culture=neutral, PublicKeyToken=0738eb9f132ed756";
 
 		if (cncTypeName == null || cncTypeName == "")
-			cncTypeName = "Mono.Data.SqliteClient.SqliteConnection";
+			cncTypeName = "Mono.Data.Sqlite.SqliteConnection";
 		
 		if (cncString == null || cncString == "") {
 	                string dbPath = Path.Combine (Path.GetDirectoryName (Request.MapPath (Request.FilePath)), "dbpage2.sqlite");
