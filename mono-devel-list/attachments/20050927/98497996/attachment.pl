Index: CsprojInfo.cs
===================================================================
--- CsprojInfo.cs	(revision 50720)
+++ CsprojInfo.cs	(working copy)
@@ -35,6 +35,7 @@
 		public string makename_ext;
 		public string assembly_name;
 		public string res;
+		public string resgen;
 		public string src;
 		private bool m_bAllowUnsafeCode;
 		private Mfconsulting.General.Prj2Make.Schema.Csproj.VisualStudioProject m_projObject;
@@ -171,6 +172,7 @@
 			}
     		
 			res = "";
+			resgen = "";
 			string rootNS = m_projObject.CSHARP.Build.Settings.RootNamespace;
 			string relPath;
 			foreach (Mfconsulting.General.Prj2Make.Schema.Csproj.File fl in m_projObject.CSHARP.Files.Include)
@@ -183,6 +185,15 @@
     			
 					relPath = fl.RelPath.Replace("\\", "/");
 					s = System.IO.Path.Combine(basePath, relPath);
+					if (Path.GetExtension (s) == ".resx") {
+						string path = s;
+						path = path.Replace (@"\", "/");
+						if (SlnMaker.slash != "/")
+							path = path.Replace("/", SlnMaker.slash);
+						resgen += String.Format ("{0} ", path);
+						s = Path.ChangeExtension (s, ".resources");
+						relPath = Path.ChangeExtension (relPath, ".resources");
+					}
 					s = String.Format("-resource:{0},{1}", s, rootNS + "." + relPath.Replace("/", "."));
 					s = s.Replace("\\", "/");
 					if (SlnMaker.slash != "/")
Index: ChangeLog
===================================================================
--- ChangeLog	(revision 50720)
+++ ChangeLog	(working copy)
@@ -1,3 +1,10 @@
+2005-09-27  Sureshkumar T  <tsureshkumar@novell.com>
+
+	* MsPrjHelper.cs (MsSlnHelper): add resgen.
+
+	* CsprojInfo.cs (CsprojInfo): If resource file ends with .resx
+	convert them into .resources.
+
 2005-02-19  Miguel de Icaza  <miguel@novell.com>
 
 	* MsPrjHelper.cs, MdPrjHelper.cs: Escape path names, as they might
Index: MsPrjHelper.cs
===================================================================
--- MsPrjHelper.cs	(revision 50720)
+++ MsPrjHelper.cs	(working copy)
@@ -231,6 +231,7 @@
 						if (this.m_bIsMcs == false)
 						{
 							MakefileBuilder.Append("MCS=csc\n");
+							MakefileBuilder.Append("RESGEN=resgen\n");
 							MakefileBuilder.Append("MCSFLAGS=-nologo\n\n");
 							MakefileBuilder.Append("ifdef (RELEASE)\n");
 							MakefileBuilder.Append("\tMCSFLAGS=$(MCSFLAGS) -optimize+ -d:TRACE\n");
@@ -241,6 +242,7 @@
 						else
 						{
 							MakefileBuilder.Append("MCS=mcs\n");
+							MakefileBuilder.Append("RESGEN=resgen\n");
 							MakefileBuilder.Append("ifndef (RELEASE)\n");
 							MakefileBuilder.Append("\tMCSFLAGS=-debug \n");
 							MakefileBuilder.Append("endif\n");
@@ -273,6 +275,7 @@
 						if (m_bIsMcs == false)
 						{
 							MakefileBuilder.Append("MCS=csc\n");
+							MakefileBuilder.Append("RESGEN=resgen\n");
 							MakefileBuilder.Append("MCSFLAGS=-nologo\n\n");
 							MakefileBuilder.Append("!if !defined(RELEASE)\n");
 							MakefileBuilder.Append("MCSFLAGS=$(MCSFLAGS) -optimize+ -d:TRACE\n");
@@ -283,6 +286,7 @@
 						else
 						{
 							MakefileBuilder.Append("MCS=mcs\n");
+							MakefileBuilder.Append("RESGEN=resgen\n");
 							MakefileBuilder.Append("!if !defined(RELEASE)\n");
 							MakefileBuilder.Append("MCSFLAGS=-debug \n");
 							MakefileBuilder.Append("!endif\n");
@@ -303,6 +307,7 @@
 					MakefileBuilder.AppendFormat("{0}=$(TARGET){1}{2}\n", pi.makename_ext, slash, pi.assembly_name);
 					MakefileBuilder.AppendFormat("{0}_PDB=$(TARGET){1}{2}\n", pi.makename, slash, pi.assembly_name.Replace(".dll",".pdb"));
 					MakefileBuilder.AppendFormat("{0}_SRC={1}\n", pi.makename, pi.src);
+					MakefileBuilder.AppendFormat("{0}_RESX={1}\n", pi.makename, pi.resgen);
 					MakefileBuilder.AppendFormat("{0}_RES={1}\n\n", pi.makename, pi.res);
 				}
 				
@@ -406,6 +411,9 @@
 						MakefileBuilder.Append("\t-md $(TARGET)\n");
 					}
 
+					if (pi.resgen != null && pi.resgen != String.Empty)
+						MakefileBuilder.AppendFormat ("\t$(RESGEN) /compile {0}\n", pi.resgen);
+
 					MakefileBuilder.Append("\t$(MCS) $(MCSFLAGS)");
 
 					foreach (string libdir in libdirs.Keys)
