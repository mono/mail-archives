Index: extras/MonoDevelop.Database/MonoDevelop.Database.Sql.Sqlite/MonoDevelop.Database.Sql.Sqlite.csproj
===================================================================
--- extras/MonoDevelop.Database/MonoDevelop.Database.Sql.Sqlite/MonoDevelop.Database.Sql.Sqlite.csproj	(revision 154234)
+++ extras/MonoDevelop.Database/MonoDevelop.Database.Sql.Sqlite/MonoDevelop.Database.Sql.Sqlite.csproj	(working copy)
@@ -69,9 +69,6 @@
     <Reference Include="Mono.TextEditor, Version=1.0.0.0, Culture=neutral">
       <Package>monodevelop</Package>
     </Reference>
-    <Reference Include="Mono.Data">
-      <SpecificVersion>False</SpecificVersion>
-    </Reference>
     <Reference Include="Mono.Data.Sqlite">
       <SpecificVersion>False</SpecificVersion>
     </Reference>
Index: extras/MonoDevelop.Database/MonoDevelop.Database.Sql.Sqlite/Makefile.am
===================================================================
--- extras/MonoDevelop.Database/MonoDevelop.Database.Sql.Sqlite/Makefile.am	(revision 154234)
+++ extras/MonoDevelop.Database/MonoDevelop.Database.Sql.Sqlite/Makefile.am	(working copy)
@@ -7,7 +7,6 @@
 	-r:$(top_builddir)/build/MonoDevelop.Database.Components.dll \
 	-r:$(top_builddir)/build/MonoDevelop.Database.Designer.dll \
 	-r:$(top_builddir)/build/MonoDevelop.Database.Sql.dll \
-	-r:Mono.Data \
 	-r:Mono.Data.Sqlite \
 	-r:System \
 	-r:System.Data


