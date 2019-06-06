Index: main/src/core/MonoDevelop.Projects/ChangeLog
===================================================================
--- main/src/core/MonoDevelop.Projects/ChangeLog	(revision 136699)
+++ main/src/core/MonoDevelop.Projects/ChangeLog	(working copy)
@@ -1,3 +1,9 @@
+2009-07-23  Carlo Kok  <ck@remobjects.com>
+	* MonoDevelop.Projects/UnknownProjectVersionException.cs: Deleted
+	* MonoDevelop.Projects.Formats.MD1/CmbxFileFormat.cs:
+	* MonoDevelop.Projects.Formats.MD1/MD1FileFormat.cs: New 
+	  exception & removed references to the old one.
+
 2009-06-23  Lluis Sanchez Gual  <lluis@novell.com>
 
 	* MonoDevelop.Projects/Project.cs:
Index: main/src/core/MonoDevelop.Projects/Makefile.am
===================================================================
--- main/src/core/MonoDevelop.Projects/Makefile.am	(revision 136699)
+++ main/src/core/MonoDevelop.Projects/Makefile.am	(working copy)
@@ -266,7 +266,6 @@
 	MonoDevelop.Projects/SolutionItemEventArgs.cs \
 	MonoDevelop.Projects/SolutionItemReference.cs \
 	MonoDevelop.Projects/UnknownConfiguration.cs \
-	MonoDevelop.Projects/UnknownProjectVersionException.cs \
 	MonoDevelop.Projects/UnknownSolutionItem.cs \
 	MonoDevelop.Projects/UnknownWorkspaceItem.cs \
 	MonoDevelop.Projects/Workspace.cs \
Index: main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.csproj
===================================================================
--- main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.csproj	(revision 136699)
+++ main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.csproj	(working copy)
@@ -119,7 +119,6 @@
     <Compile Include="MonoDevelop.Projects\ProjectConvertTool.cs" />
     <Compile Include="MonoDevelop.Projects\ProjectsServices.cs" />
     <Compile Include="MonoDevelop.Projects\UnknownSolutionItem.cs" />
-    <Compile Include="MonoDevelop.Projects\UnknownProjectVersionException.cs" />
     <Compile Include="MonoDevelop.Projects.Text\TextFileService.cs" />
     <Compile Include="MonoDevelop.Projects\Workspace.cs" />
     <Compile Include="MonoDevelop.Projects\UnknownConfiguration.cs" />
Index: main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Formats.MD1/CmbxFileFormat.cs
===================================================================
--- main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Formats.MD1/CmbxFileFormat.cs	(revision 136699)
+++ main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Formats.MD1/CmbxFileFormat.cs	(working copy)
@@ -259,8 +259,8 @@
 			DataSerializer serializer = new DataSerializer (MD1ProjectService.DataContext, file);
 			
 			try {
-				if (version != "2.0")
-					throw new UnknownProjectVersionException (file, version);
+				if (version != "2.0")
+					throw new MD1UnknownProjectVersion (file, version);
 				ICombineReader combineReader = new CombineReaderV2 (serializer, monitor, typeof(SolutionFolder));
 				return combineReader.ReadCombine (reader);
 			} catch (Exception ex) {
Index: main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Formats.MD1/MD1FileFormat.cs
===================================================================
--- main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Formats.MD1/MD1FileFormat.cs	(revision 136699)
+++ main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Formats.MD1/MD1FileFormat.cs	(working copy)
@@ -35,7 +35,15 @@
 using MonoDevelop.Core;
 
 namespace MonoDevelop.Projects.Formats.MD1
-{
+{
+	class MD1UnknownProjectVersion : Exception
+	{
+		public MD1UnknownProjectVersion (string filename, string unsupportedVersion)
+			: base (GettextCatalog.GetString ("The file '{0}' has an unknown format version (version '{1}')'.", filename, unsupportedVersion))
+		{
+		}
+	}
+
 	internal class MD1FileFormat: IFileFormat
 	{
 		public string Name {
@@ -287,8 +295,8 @@
 			try {
 				if (combineReader != null)
 					return combineReader.ReadCombine (reader);
-				else
-					throw new UnknownProjectVersionException (file, version);
+				else
+					throw new MD1UnknownProjectVersion (file, version);
 			} catch (Exception ex) {
 				monitor.ReportError (GettextCatalog.GetString ("Could not load solution: {0}", file), ex);
 				throw;
@@ -316,8 +324,8 @@
 					projectReader = new ProjectReaderV2 (serializer);
 					return projectReader.ReadProject (reader);
 				}
-				else
-					throw new UnknownProjectVersionException (fileName, version);
+				else
+					throw new MD1UnknownProjectVersion (fileName, version);
 			} catch (Exception ex) {
 				monitor.ReportError (GettextCatalog.GetString ("Could not load project: {0}", fileName), ex);
 				throw;
Index: main/src/core/MonoDevelop.Projects/MonoDevelop.Projects/UnknownProjectVersionException.cs
===================================================================
--- main/src/core/MonoDevelop.Projects/MonoDevelop.Projects/UnknownProjectVersionException.cs	(revision 136699)
+++ main/src/core/MonoDevelop.Projects/MonoDevelop.Projects/UnknownProjectVersionException.cs	(working copy)
@@ -1,34 +0,0 @@
-//  UnknownProjectVersionException.cs
-//
-//  This file was derived from a file from #Develop. 
-//
-//  Copyright (C) 2001-2007 Mike Krüger <mkrueger@novell.com>
-// 
-//  This program is free software; you can redistribute it and/or modify
-//  it under the terms of the GNU General Public License as published by
-//  the Free Software Foundation; either version 2 of the License, or
-//  (at your option) any later version.
-// 
-//  This program is distributed in the hope that it will be useful,
-//  but WITHOUT ANY WARRANTY; without even the implied warranty of
-//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
-//  GNU General Public License for more details.
-//  
-//  You should have received a copy of the GNU General Public License
-//  along with this program; if not, write to the Free Software
-//  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
-
-using System;
-using MonoDevelop.Core;
-
-namespace MonoDevelop.Projects
-{
-	public class UnknownProjectVersionException : Exception
-	{
-		public UnknownProjectVersionException (string file, string version)
-		: base (GettextCatalog.GetString ("The file '{0}' has an unknown format version (version '{1}')'.", file, version))
-		{
-		}
-	}
-	
-}