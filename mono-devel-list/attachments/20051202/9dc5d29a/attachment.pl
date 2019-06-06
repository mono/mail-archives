Index: Makefile.in
===================================================================
--- Makefile.in	(revision 53812)
+++ Makefile.in	(working copy)
@@ -87,7 +87,7 @@
 	echo '[assembly: System.Reflection.AssemblyVersion("$(VERSION)")]' >$@
 
 Mono.Build.dll: Mono.Build.dll.sources $(shell cat Mono.Build.dll.sources)
-	$(MCS) /target:library /out:$@ /keyfile:mbuild.snk @$<
+	$(MCS) /target:library /out:$@ /keyfile:mbuild.snk /r:Mono.Posix.dll @$<
 	$(SN) -R $@ mbuild.snk
 
 MBuildDynamic.Core.dll: MBuildDynamic.Core.dll.sources $(shell cat MBuildDynamic.Core.dll.sources) Mono.Build.dll mb-bundlegen.exe
Index: Mono.Build/Mono.Build/MBFile.cs
===================================================================
--- Mono.Build/Mono.Build/MBFile.cs	(revision 53812)
+++ Mono.Build/Mono.Build/MBFile.cs	(working copy)
@@ -130,8 +130,8 @@
 			// try and abstract this operation.
 			string path = GetPath (ctxt);
 
-			if (Type.GetType ("System.MonoType") != null)
-				File.SetAttributes (path, (FileAttributes) 0x80000000);
+			if ((int) Environment.OSVersion.Platform == 4)
+				Mono.Unix.UnixFile.SetPermissions (path, Mono.Unix.Native.FilePermissions.S_IXUSR);
 
 			// no action needed on MS
 		}