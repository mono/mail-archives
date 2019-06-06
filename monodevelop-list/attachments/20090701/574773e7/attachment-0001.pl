Index: main/src/addins/AspNetAddIn/ChangeLog
===================================================================
--- main/src/addins/AspNetAddIn/ChangeLog	(revision 137158)
+++ main/src/addins/AspNetAddIn/ChangeLog	(working copy)
@@ -1,3 +1,7 @@
+2009-06-30  Viktoria Dudka  <viktoriad@remobjects.com>
+	* MonoDevelop.AspNet\AspNetAppProjectBinding.cs
+	  Rewritten from scratch to make it non-GPL.
+
 2009-06-23  Lluis Sanchez Gual  <lluis@novell.com>
 
 	* MonoDevelop.AspNet/AspNetToolboxNode.cs:
Index: main/src/addins/AspNetAddIn/MonoDevelop.AspNet/AspNetAppProjectBinding.cs
===================================================================
--- main/src/addins/AspNetAddIn/MonoDevelop.AspNet/AspNetAppProjectBinding.cs	(revision 137158)
+++ main/src/addins/AspNetAddIn/MonoDevelop.AspNet/AspNetAppProjectBinding.cs	(working copy)
@@ -67,7 +67,7 @@
 					
 			ProjectCreateInformation info = new ProjectCreateInformation ();
 			info.ProjectName = Path.GetFileNameWithoutExtension (file);
-			info.CombinePath = Path.GetDirectoryName (file);
+			info.SolutionPath = Path.GetDirectoryName (file);
 			Project project = CreateProject (language, info, null);
 			project.Files.Add (new ProjectFile (file));
 			return project;
Index: main/src/addins/CBinding/ChangeLog
===================================================================
--- main/src/addins/CBinding/ChangeLog	(revision 137158)
+++ main/src/addins/CBinding/ChangeLog	(working copy)
@@ -1,3 +1,7 @@
+2009-06-30  Viktoria Dudka  <viktoriad@remobjects.com>
+	* Project/CProjectBinding.cs:
+	  Rewritten from scratch to make it non-GPL.
+	
 2009-06-29  Levi Bard <taktaktaktaktaktaktaktaktaktak@gmail.com> 
 
 	* Compiler/GNUCompiler.cs: Localize output parser.
Index: main/src/addins/CBinding/Project/CProjectBinding.cs
===================================================================
--- main/src/addins/CBinding/Project/CProjectBinding.cs	(revision 137158)
+++ main/src/addins/CBinding/Project/CProjectBinding.cs	(working copy)
@@ -55,7 +55,7 @@
 		{
 			ProjectCreateInformation info = new ProjectCreateInformation ();
 			info.ProjectName = Path.GetFileNameWithoutExtension (sourceFile);
-			info.CombinePath = Path.GetDirectoryName (sourceFile);
+			info.SolutionPath = Path.GetDirectoryName (sourceFile);
 			info.ProjectBasePath = Path.GetDirectoryName (sourceFile);
 			
 			string language = string.Empty;
Index: main/src/core/MonoDevelop.Ide/ChangeLog
===================================================================
--- main/src/core/MonoDevelop.Ide/ChangeLog	(revision 137158)
+++ main/src/core/MonoDevelop.Ide/ChangeLog	(working copy)
@@ -1,3 +1,12 @@
+2009-06-30  Viktoria Dudka  <viktoriad@remobjects.com>
+	* Makefile.am: 
+	* MonoDevelop.Ide.csproj: 
+	* MonoDevelop.Ide.Gui.Dialogs\NewProjectDialog.cs: 
+	* MonoDevelop.Ide.Templates\CombineDescriptor.cs: 
+	* MonoDevelop.Ide.Templates\ProjectTemplate.cs: 
+	* MonoDevelop.Ide.Templates\SolutionDescriptor.cs: 
+	  Rewritten from scratch to make it non-GPL.
+	
 2009-06-29  Lluis Sanchez Gual  <lluis@novell.com>
 
 	* MonoDevelop.Ide.Gui.Pads.ProjectPad/FolderNodeBuilder.cs:
Index: main/src/core/MonoDevelop.Ide/Makefile.am
===================================================================
--- main/src/core/MonoDevelop.Ide/Makefile.am	(revision 137158)
+++ main/src/core/MonoDevelop.Ide/Makefile.am	(working copy)
@@ -313,7 +313,7 @@
 	MonoDevelop.Ide.Templates/ClrVersionFileTemplateCondition.cs \
 	MonoDevelop.Ide.Templates/CodeDomFileDescriptionTemplate.cs \
 	MonoDevelop.Ide.Templates/CodeTranslationFileDescriptionTemplate.cs \
-	MonoDevelop.Ide.Templates/CombineDescriptor.cs \
+	MonoDevelop.Ide.Templates/SolutionDescriptor.cs \
 	MonoDevelop.Ide.Templates/DirectoryTemplate.cs \
 	MonoDevelop.Ide.Templates/FileDescriptionTemplate.cs \
 	MonoDevelop.Ide.Templates/FileTemplate.cs \
Index: main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.csproj
===================================================================
--- main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.csproj	(revision 137158)
+++ main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.csproj	(working copy)
@@ -279,12 +279,12 @@
     <Compile Include="MonoDevelop.Ide.Templates\FileDescriptionTemplate.cs" />
     <Compile Include="MonoDevelop.Ide.Templates\FileTemplate.cs" />
     <Compile Include="MonoDevelop.Ide.Templates\INewFileCreator.cs" />
-    <Compile Include="MonoDevelop.Ide.Templates\CombineDescriptor.cs" />
     <Compile Include="MonoDevelop.Ide.Templates\ProjectDescriptor.cs" />
     <Compile Include="MonoDevelop.Ide.Templates\ProjectTemplate.cs" />
     <Compile Include="MonoDevelop.Ide.Templates\TextFileDescriptionTemplate.cs" />
     <Compile Include="MonoDevelop.Ide.Templates\CodeDomFileDescriptionTemplate.cs" />
     <Compile Include="MonoDevelop.Ide.Templates\SingleFileDescriptionTemplate.cs" />
+    <Compile Include="MonoDevelop.Ide.Templates\SolutionDescriptor.cs" />
     <Compile Include="MonoDevelop.Ide.Templates\ResourceFileDescriptionTemplate.cs" />
     <Compile Include="MonoDevelop.Ide.Gui\AbstractBaseViewContent.cs" />
     <Compile Include="MonoDevelop.Ide.Gui\AbstractPadContent.cs" />
Index: main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.Gui.Dialogs/NewProjectDialog.cs
===================================================================
--- main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.Gui.Dialogs/NewProjectDialog.cs	(revision 137158)
+++ main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.Gui.Dialogs/NewProjectDialog.cs	(working copy)
@@ -450,10 +450,10 @@
 		ProjectCreateInformation CreateProjectCreateInformation ()
 		{
 			ProjectCreateInformation cinfo = new ProjectCreateInformation ();
-			cinfo.CombinePath     = SolutionLocation;
+			cinfo.SolutionPath     = SolutionLocation;
 			cinfo.ProjectBasePath = ProjectLocation;
 			cinfo.ProjectName     = txt_name.Text;
-			cinfo.CombineName     = CreateSolutionDirectory ? txt_subdirectory.Text : txt_name.Text;
+			cinfo.SolutionName     = CreateSolutionDirectory ? txt_subdirectory.Text : txt_name.Text;
 			return cinfo;
 		}
 
Index: main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.Templates/CombineDescriptor.cs
===================================================================
--- main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.Templates/CombineDescriptor.cs	(revision 137158)
+++ main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.Templates/CombineDescriptor.cs	(working copy)
@@ -1,156 +0,0 @@
-//  CombineDescriptor.cs
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
-using System.IO;
-using System.Xml;
-using System.Collections;
-using System.Collections.Generic;
-using System.Collections.Specialized;
-using System.Diagnostics;
-using System.Reflection;
-
-using MonoDevelop.Core;
-using MonoDevelop.Projects;
-using MonoDevelop.Core.Gui;
-using MonoDevelop.Core.ProgressMonitoring;
-
-namespace MonoDevelop.Ide.Templates
-{
-	internal class CombineDescriptor
-	{
-		ArrayList entryDescriptors = new ArrayList();
-		
-		string name;
-		string startupProject    = null;
-		string relativeDirectory = null;
-		string typeName;
-	
-		public string StartupProject {
-			get {
-				return startupProject;
-			}
-		}
-
-		protected CombineDescriptor (string name, string type)
-		{
-			this.name = name;
-			this.typeName = type;
-		}
-		
-		public ISolutionItemDescriptor[] EntryDescriptors {
-			get { return (ISolutionItemDescriptor[]) entryDescriptors.ToArray (typeof(ISolutionItemDescriptor)); }
-		}
-		
-		public WorkspaceItem CreateEntry (ProjectCreateInformation projectCreateInformation, string defaultLanguage)
-		{
-			WorkspaceItem item;
-
-			if (typeName != null && typeName.Length > 0) {
-				Type type = Type.GetType (typeName);
-				if (type == null || !typeof(WorkspaceItem).IsAssignableFrom (type)) {
-					MessageService.ShowError (GettextCatalog.GetString ("Can't create solution with type: {0}", typeName));
-					return null;
-				}
-				item = (WorkspaceItem) Activator.CreateInstance (type);
-			} else
-				item = new Solution ();
-			
-			string  newCombineName = StringParserService.Parse(name, new string[,] { 
-				{"ProjectName", projectCreateInformation.CombineName}
-			});
-			
-			item.Name = newCombineName;
-			
-			string oldCombinePath = projectCreateInformation.CombinePath;
-			string oldProjectPath = projectCreateInformation.ProjectBasePath;
-			if (relativeDirectory != null && relativeDirectory.Length > 0 && relativeDirectory != ".") {
-				projectCreateInformation.CombinePath     = projectCreateInformation.CombinePath + Path.DirectorySeparatorChar + relativeDirectory;
-				projectCreateInformation.ProjectBasePath = projectCreateInformation.CombinePath + Path.DirectorySeparatorChar + relativeDirectory;
-				if (!Directory.Exists(projectCreateInformation.CombinePath)) {
-					Directory.CreateDirectory(projectCreateInformation.CombinePath);
-				}
-				if (!Directory.Exists(projectCreateInformation.ProjectBasePath)) {
-					Directory.CreateDirectory(projectCreateInformation.ProjectBasePath);
-				}
-			}
-
-			Solution sol = item as Solution;
-			if (sol != null) {
-				List<string> configs = new List<string> ();
-				
-				// Create sub projects
-				foreach (ISolutionItemDescriptor entryDescriptor in entryDescriptors) {
-					SolutionEntityItem sit = entryDescriptor.CreateItem (projectCreateInformation, defaultLanguage);
-					entryDescriptor.InitializeItem (sol.RootFolder, projectCreateInformation, defaultLanguage, sit);
-					sol.RootFolder.Items.Add (sit);
-					if (sit is IConfigurationTarget) {
-						foreach (ItemConfiguration c in ((IConfigurationTarget)sit).Configurations) {
-							if (!configs.Contains (c.Id))
-								configs.Add (c.Id);
-						}
-					}
-				}
-				
-				// Create configurations
-				foreach (string conf in configs)
-					sol.AddConfiguration (conf, true);
-			}
-			
-			projectCreateInformation.CombinePath = oldCombinePath;
-			projectCreateInformation.ProjectBasePath = oldProjectPath;
-			item.SetLocation (projectCreateInformation.CombinePath, newCombineName);
-			
-			return item;
-		}
-		
-		public static CombineDescriptor CreateCombineDescriptor(XmlElement element)
-		{
-			CombineDescriptor combineDescriptor = new CombineDescriptor(element.GetAttribute ("name"), element.GetAttribute ("type"));
-			
-			if (element.Attributes["directory"] != null) {
-				combineDescriptor.relativeDirectory = element.Attributes["directory"].InnerText;
-			}
-			
-			if (element["Options"] != null && element["Options"]["StartupProject"] != null) {
-				combineDescriptor.startupProject = element["Options"]["StartupProject"].InnerText;
-			}
-			
-			foreach (XmlNode node in element.ChildNodes) {
-				if (node != null) {
-					switch (node.Name) {
-						case "Project":
-							combineDescriptor.entryDescriptors.Add (ProjectDescriptor.CreateProjectDescriptor((XmlElement)node));
-							break;
-						case "Solution":
-						case "Combine":
-							combineDescriptor.entryDescriptors.Add (CreateCombineDescriptor((XmlElement)node));
-							break;
-						case "CombineEntry":
-						case "SolutionItem":
-							combineDescriptor.entryDescriptors.Add (SolutionItemDescriptor.CreateDescriptor((XmlElement)node));
-							break;
-					}
-				}
-			}
-			return combineDescriptor;
-		}
-	}
-}
Index: main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.Templates/ProjectTemplate.cs
===================================================================
--- main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.Templates/ProjectTemplate.cs	(revision 137158)
+++ main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.Templates/ProjectTemplate.cs	(working copy)
@@ -73,7 +73,8 @@
 		ArrayList actions      = new ArrayList();
 
 		
-		CombineDescriptor combineDescriptor = null;
+		//CombineDescriptor combineDescriptor = null;
+        SolutionDescriptor combineDescriptor = null;
 		
 #region Template Properties
 		public string WizardPath {
@@ -135,7 +136,7 @@
 		}
 
 		[Browsable(false)]
-		public CombineDescriptor CombineDescriptor
+		public SolutionDescriptor CombineDescriptor
 		{
 			get 
 			{
@@ -223,7 +224,7 @@
 			}
 			
 			if (doc.DocumentElement["Combine"] != null) {
-				combineDescriptor = CombineDescriptor.CreateCombineDescriptor(doc.DocumentElement["Combine"]);
+                combineDescriptor = SolutionDescriptor.CreateSolutionDescriptor (doc.DocumentElement["Combine"]);
 			} else {
 				throw new InvalidOperationException ("Combine element not found");
 			}
Index: main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.Templates/SolutionDescriptor.cs
===================================================================
--- main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.Templates/SolutionDescriptor.cs	(revision 0)
+++ main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.Templates/SolutionDescriptor.cs	(revision 0)
@@ -0,0 +1,158 @@
+//  SolutionDescriptor.cs
+//
+//  This file was derived from a file from #Develop. 
+//
+//  Copyright (C) 2001-2007 Mike Kr�ger <mkrueger@novell.com>
+// 
+//  This program is free software; you can redistribute it and/or modify
+//  it under the terms of the GNU General Public License as published by
+//  the Free Software Foundation; either version 2 of the License, or
+//  (at your option) any later version.
+// 
+//  This program is distributed in the hope that it will be useful,
+//  but WITHOUT ANY WARRANTY; without even the implied warranty of
+//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+//  GNU General Public License for more details.
+//  
+//  You should have received a copy of the GNU General Public License
+//  along with this program; if not, write to the Free Software
+//  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+
+using System;
+using System.IO;
+using System.Threading;
+using System.Diagnostics;
+using MonoDevelop.Core;
+using MonoDevelop.Core.Execution;
+using MonoDevelop.Core.Gui;
+using MonoDevelop.Core.Gui.ProgressMonitoring;
+using MonoDevelop.Projects;
+using MonoDevelop.Components;
+using MonoDevelop.Ide.Gui;
+using MonoDevelop.Components.Commands;
+using System.Collections.Generic;
+using System.Xml;
+
+namespace MonoDevelop.Ide.Templates
+{
+    internal class SolutionDescriptor 
+	{
+        string startupProject;
+        string directory;
+        string name;
+        string type;
+
+        private List<ISolutionItemDescriptor> entryDescriptors = new List<ISolutionItemDescriptor> ();
+        public ISolutionItemDescriptor[] EntryDescriptors
+        {
+            get { return entryDescriptors.ToArray(); }
+        }
+
+        public static SolutionDescriptor CreateSolutionDescriptor (XmlElement xmlElement)
+        {
+            SolutionDescriptor solutionDescriptor = new SolutionDescriptor ();
+
+            if (xmlElement.Attributes["name"] != null)
+                solutionDescriptor.name = xmlElement.Attributes["name"].Value;
+            else
+                throw new InvalidOperationException ("Attribute 'name' not found");
+
+            if (xmlElement.Attributes["type"] != null)
+                solutionDescriptor.type = xmlElement.Attributes["type"].Value;
+
+            if (xmlElement.Attributes["directory"] != null)
+                solutionDescriptor.directory = xmlElement.Attributes["directory"].Value;
+
+            if (xmlElement["Options"] != null && xmlElement["Options"]["StartupProject"] != null)
+                solutionDescriptor.startupProject = xmlElement["Options"]["StartupProject"].InnerText;
+
+
+            foreach (XmlNode xmlNode in xmlElement.ChildNodes) {
+                if (xmlNode is XmlElement) {
+                    XmlElement xmlNodeElement = (XmlElement)xmlNode;
+                    switch (xmlNodeElement.Name) {
+                        case "Project":
+                            solutionDescriptor.entryDescriptors.Add (ProjectDescriptor.CreateProjectDescriptor (xmlNodeElement));
+                            break;
+                        case "CombineEntry":
+                        case "SolutionItem":
+                            solutionDescriptor.entryDescriptors.Add (SolutionItemDescriptor.CreateDescriptor (xmlNodeElement));
+                            break;
+
+                    }
+                }
+            }
+
+            return solutionDescriptor;
+        }
+
+        public WorkspaceItem CreateEntry(ProjectCreateInformation projectCreateInformation, string defaultLanguage)
+        {
+            WorkspaceItem workspaceItem;
+
+            if (String.IsNullOrEmpty (type))
+                workspaceItem = new Solution ();
+            else {
+                Type workspaceItemType = Type.GetType (type);
+                if (workspaceItemType == null) {
+                    workspaceItem = null;
+                }
+                else
+                    workspaceItem = Activator.CreateInstance (workspaceItemType) as WorkspaceItem;
+
+                if (workspaceItemType == null || workspaceItem == null)
+                    MessageService.ShowError (GettextCatalog.GetString ("Can't create solution with type: {0}", type));
+
+            }
+
+            workspaceItem.Name = StringParserService.Parse (name, new string[,] { {"ProjectName", projectCreateInformation.SolutionName} });
+
+            workspaceItem.SetLocation (projectCreateInformation.SolutionPath, workspaceItem.Name);
+
+            ProjectCreateInformation localProjectCI;
+            if (!String.IsNullOrEmpty (directory) && directory != ".") {
+                localProjectCI = new ProjectCreateInformation (projectCreateInformation);
+
+                localProjectCI.SolutionPath = Path.Combine (localProjectCI.SolutionPath, directory);
+                localProjectCI.ProjectBasePath = Path.Combine (localProjectCI.ProjectBasePath, directory);
+
+                if (!Directory.Exists (localProjectCI.SolutionPath))
+                    Directory.CreateDirectory (localProjectCI.SolutionPath);
+
+                if (!Directory.Exists (localProjectCI.ProjectBasePath))
+                    Directory.CreateDirectory (localProjectCI.ProjectBasePath);
+            }
+            else
+                localProjectCI = projectCreateInformation;
+
+            Solution solution = workspaceItem as Solution;
+            if ( solution != null ) {
+                for ( int i = 0; i < entryDescriptors.Count; i++ )
+                {
+                    ISolutionItemDescriptor solutionItem = entryDescriptors[i];
+
+                    SolutionEntityItem info = solutionItem.CreateItem (localProjectCI, defaultLanguage);
+                    entryDescriptors[i].InitializeItem (solution.RootFolder, localProjectCI, defaultLanguage, info);
+
+                    IConfigurationTarget configurationTarget = info as IConfigurationTarget;
+                    if (configurationTarget != null) {
+                        foreach (ItemConfiguration configuration in configurationTarget.Configurations) {
+                            bool flag = false;
+                            foreach (SolutionConfiguration solutionCollection in solution.Configurations) {
+                                if (solutionCollection.Id == configuration.Id)
+                                    flag = true;
+                            }
+                            if (!flag)
+                                solution.AddConfiguration (configuration.Id, true);
+                        }
+                    }
+
+                    solution.RootFolder.Items.Add (info);
+                }
+            }
+
+            return workspaceItem;
+        }
+
+	}
+}
Index: main/src/core/MonoDevelop.Projects/ChangeLog
===================================================================
--- main/src/core/MonoDevelop.Projects/ChangeLog	(revision 137158)
+++ main/src/core/MonoDevelop.Projects/ChangeLog	(working copy)
@@ -1,3 +1,8 @@
+2009-06-30  Viktoria Dudka  <viktoriad@remobjects.com> 
+	* MonoDevelop.Projects/DotNetProjectBinding.cs:
+	* MonoDevelop.Projects/ProjectCreateInformation.cs: 
+	  Rewritten from scratch to make it non-GPL.
+	
 2009-06-26  Mike Krüger  <mkrueger@novell.com>
 
 	* MonoDevelop.Projects.addin.xml:
Index: main/src/core/MonoDevelop.Projects/MonoDevelop.Projects/DotNetProjectBinding.cs
===================================================================
--- main/src/core/MonoDevelop.Projects/MonoDevelop.Projects/DotNetProjectBinding.cs	(revision 137158)
+++ main/src/core/MonoDevelop.Projects/MonoDevelop.Projects/DotNetProjectBinding.cs	(working copy)
@@ -57,7 +57,7 @@
 			if (binding != null) {
 				ProjectCreateInformation info = new ProjectCreateInformation ();
 				info.ProjectName = Path.GetFileNameWithoutExtension (file);
-				info.CombinePath = Path.GetDirectoryName (file);
+				info.SolutionPath = Path.GetDirectoryName (file);
 				info.ProjectBasePath = Path.GetDirectoryName (file);
 				Project project = CreateProject (binding.Language, info, null);
 				project.Files.Add (new ProjectFile (file));
Index: main/src/core/MonoDevelop.Projects/MonoDevelop.Projects/ProjectCreateInformation.cs
===================================================================
--- main/src/core/MonoDevelop.Projects/MonoDevelop.Projects/ProjectCreateInformation.cs	(revision 137158)
+++ main/src/core/MonoDevelop.Projects/MonoDevelop.Projects/ProjectCreateInformation.cs	(working copy)
@@ -32,8 +32,8 @@
 	public class ProjectCreateInformation
 	{
 		string projectName;
-		string combineName;
-		string combinePath;
+		string solutionName;
+        string solutionPath;
 		string projectBasePath;
 		
 		public string ProjectName {
@@ -45,12 +45,12 @@
 			}
 		}
 		
-		public string CombineName {
+		public string SolutionName {
 			get {
-				return combineName;
+                return solutionName;
 			}
 			set {
-				combineName = value;
+                solutionName = value;
 			}
 		}
 		
@@ -60,12 +60,12 @@
 			}
 		}
 		
-		public string CombinePath {
+		public string SolutionPath {
 			get {
-				return combinePath;
+				return solutionPath;
 			}
 			set {
-				combinePath = value;
+                solutionPath = value;
 			}
 		}
 		
@@ -77,5 +77,16 @@
 				projectBasePath = value;
 			}
 		}
+
+        public ProjectCreateInformation() { }
+
+        public ProjectCreateInformation(ProjectCreateInformation projectCreateInformation)
+        {
+            projectName = projectCreateInformation.ProjectName;
+            solutionName = projectCreateInformation.SolutionName;
+            solutionPath = projectCreateInformation.SolutionPath;
+            projectBasePath = projectCreateInformation.ProjectBasePath;
+        }
+
 	}
 }