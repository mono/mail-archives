Index: main/src/core/MonoDevelop.Ide/ChangeLog
===================================================================
--- main/src/core/MonoDevelop.Ide/ChangeLog	(revision 137229)
+++ main/src/core/MonoDevelop.Ide/ChangeLog	(working copy)
@@ -1,3 +1,7 @@
+2009-07-02  Viktoria Dudka  <viktoriad@remobjects.com>
+
+	* MonoDevelop.Ide.Templates\ProjectDescriptor.cs: Rewritten from scratch to make it non-GPL.
+
 2009-07-01  Mike Krüger  <mkrueger@novell.com>
 
 	* Makefile.am:
Index: main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.Templates/ProjectDescriptor.cs
===================================================================
--- main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.Templates/ProjectDescriptor.cs	(revision 137229)
+++ main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.Templates/ProjectDescriptor.cs	(working copy)
@@ -1,202 +1,167 @@
-//  ProjectDescriptor.cs
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
-using System.Collections.Specialized;
-using System.Diagnostics;
-using System.Reflection;
-using MonoDevelop.Projects;
-using MonoDevelop.Core;
-using MonoDevelop.Core.Gui;
-using MonoDevelop.Core.ProgressMonitoring;
-
-using Project_ = MonoDevelop.Projects.Project;
-
-namespace MonoDevelop.Ide.Templates
-{
-	/// <summary>
-	/// This class is used inside the combine templates for projects.
-	/// </summary>
-	internal class ProjectDescriptor: ISolutionItemDescriptor
-	{
-		string name;
-		string projectType;
-		
-		ArrayList files      = new ArrayList(); // contains FileTemplate classes
-		ArrayList references = new ArrayList(); 
-		ArrayList resources = new ArrayList ();
-		
-		XmlElement projectOptions = null;
-		
-		#region public properties
-		public ArrayList Files {
-			get {
-				return files;
-			}
-		}
-
-		public ArrayList References {
-			get {
-				return references;
-			}
-		}
-
-		public ArrayList Resources {
-			get {
-				return resources;
-			}
-		}
-
-		public XmlElement ProjectOptions {
-			get {
-				return projectOptions;
-			}
-		}
-		#endregion
-
-		protected ProjectDescriptor(string name, string relativePath)
-		{
-			this.name = name;
-		}
-		
-		public SolutionEntityItem CreateItem (ProjectCreateInformation projectCreateInformation, string defaultLanguage)
-		{
-			if (projectOptions.GetAttribute ("language") == "") {
-/*				if (defaultLanguage == null || defaultLanguage == "")
-					throw new InvalidOperationException ("Language not specified in template");
-*/				projectOptions.SetAttribute ("language", defaultLanguage);
-			}
-			return Services.ProjectService.CreateProject (projectType, projectCreateInformation, projectOptions);
-		}
-
-		public void InitializeItem (SolutionItem policyParent, ProjectCreateInformation projectCreateInformation, string defaultLanguage, SolutionEntityItem item)
-		{
-			Project_ project = item as Project_;
-			
-			if (project == null) {
-				MessageService.ShowError (GettextCatalog.GetString ("Can't create project with type : {0}", projectType));
-				return;
-			}
-			
-			string newProjectName = StringParserService.Parse(name, new string[,] { 
-				{"ProjectName", projectCreateInformation.ProjectName}
-			});
-			
-			project.FileName = Path.Combine (projectCreateInformation.ProjectBasePath, newProjectName);
-			project.Name = newProjectName;
-			
-			DotNetProject netProject = project as DotNetProject;
-			if (netProject != null) {
-				// Add References
-				foreach (ProjectReference projectReference in references) {
-					netProject.References.Add (projectReference);
-				}
-			}
-
-			foreach (FileDescriptionTemplate file in resources) {
-				SingleFileDescriptionTemplate singleFile = file as SingleFileDescriptionTemplate;
-				if (singleFile == null)
-					throw new InvalidOperationException ("Only single-file templates can be used to generate resource files");
-
-				try {
-					string fileName = singleFile.SaveFile (policyParent, project, defaultLanguage, project.BaseDirectory, null);
-
-					ProjectFile resource = new ProjectFile (fileName);
-					resource.BuildAction = BuildAction.EmbeddedResource;
-					project.Files.Add(resource);
-				} catch (Exception ex) {
-					string err = GettextCatalog.GetString ("File {0} could not be written.", file.Name);
-					LoggingService.LogError (err, ex);	
-					MessageService.ShowException (ex, err);
-				}
-			}
-	
-			// Add Files
-			foreach (FileDescriptionTemplate file in files) {
-				try {
-					file.AddToProject (policyParent, project, defaultLanguage, project.BaseDirectory, null);
-				} catch (Exception ex) {
-					string err = GettextCatalog.GetString ("File {0} could not be written.", file.Name);
-					LoggingService.LogError (err, ex);
-					MessageService.ShowException (ex, err);
-				}
-			}
-			
-			// Save project
-/*			
-			using (IProgressMonitor monitor = new NullProgressMonitor ()) {
-				if (File.Exists (project.FileName)) {
-					if (MessageService.Confirm (GettextCatalog.GetString ("File already exists"),
-					                                GettextCatalog.GetString ("Project file {0} already exists. Do you want to overwrite\nthe existing file?", project.FileName),
-					                                AlertButton.OverwriteFile)) {
-						project.Save (project.FileName, monitor);
-					}
-				} else {
-					project.Save (monitor);
-				}
-			}
-*/			
-		}
-		
-		public static ProjectDescriptor CreateProjectDescriptor(XmlElement element)
-		{
-			ProjectDescriptor projectDescriptor = new ProjectDescriptor(element.Attributes["name"].InnerText, element.Attributes["directory"].InnerText);
-			
-			projectDescriptor.projectType = element.GetAttribute ("type");
-			if (projectDescriptor.projectType == "") projectDescriptor.projectType = "DotNet";
-			
-			projectDescriptor.projectOptions = element["Options"];
-			if (projectDescriptor.projectOptions == null)
-				projectDescriptor.projectOptions = element.OwnerDocument.CreateElement ("Options");
-			
-			if (element["Files"] != null) {
-				foreach (XmlNode node in element["Files"].ChildNodes) {
-					XmlElement elem = node as XmlElement;
-					if (elem != null)
-						projectDescriptor.files.Add (FileDescriptionTemplate.CreateTemplate (elem));
-				}
-			}
-			if (element["Resources"] != null) {
-				foreach (XmlNode node in element["Resources"].ChildNodes) {
-					XmlElement elem = node as XmlElement;
-					if (elem != null)
-						projectDescriptor.resources.Add (FileDescriptionTemplate.CreateTemplate (elem));
-				}
-			}
-			if (element["References"] != null) {
-				foreach (XmlNode node in element["References"].ChildNodes) {
-					if (node != null && node.Name == "Reference") {
-					
-						ReferenceType referenceType = (ReferenceType)Enum.Parse(typeof(ReferenceType), node.Attributes["type"].InnerXml);
-						ProjectReference projectReference = new ProjectReference (referenceType, node.Attributes["refto"].InnerXml);
-						XmlNode specVerNode = node.Attributes["SpecificVersion"];
-						if (specVerNode != null && !String.IsNullOrEmpty (specVerNode.Value))
-							projectReference.SpecificVersion = bool.Parse (specVerNode.Value);
-						projectDescriptor.references.Add(projectReference);
-					}
-				}
-			}
-			return projectDescriptor;
-		}
-	}
-}
+﻿// ProjectDescriptor.cs
+//
+// Author:
+//   Viktoria Dudka (viktoriad@remobjects.com)
+//
+// Copyright (c) 2009 RemObjects Software
+//
+// Permission is hereby granted, free of charge, to any person obtaining a copy
+// of this software and associated documentation files (the "Software"), to deal
+// in the Software without restriction, including without limitation the rights
+// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+// copies of the Software, and to permit persons to whom the Software is
+// furnished to do so, subject to the following conditions:
+//
+// The above copyright notice and this permission notice shall be included in
+// all copies or substantial portions of the Software.
+//
+// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
+// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+// THE SOFTWARE.
+//
+//
+
+
+using System;
+using MonoDevelop.Core.Gui.Dialogs;
+using MonoDevelop.Core;
+using Mono.Addins;
+using MonoDevelop.Components.Commands;
+using MonoDevelop.Ide.Gui;
+using MonoDevelop.Projects;
+using MonoDevelop.Ide.Gui.Dialogs;
+using MonoDevelop.Ide.Gui.Content;
+using MonoDevelop.Core.Gui;
+using System.IO;
+using Gtk;
+using System.Collections.Generic;
+using System.Xml;
+
+
+namespace MonoDevelop.Ide.Templates
+{
+	internal class ProjectDescriptor: ISolutionItemDescriptor
+	{
+        private string name;
+        private string type;
+
+        private List<FileDescriptionTemplate> files = new List<FileDescriptionTemplate> ();
+        private List<SingleFileDescriptionTemplate> resources = new List<SingleFileDescriptionTemplate> ();
+        private List<ProjectReference> references = new List<ProjectReference> ();
+
+        private XmlElement projectOptions = null;
+
+
+        protected ProjectDescriptor()
+        {
+        }
+
+        public static ProjectDescriptor CreateProjectDescriptor(XmlElement xmlElement)
+        {
+            ProjectDescriptor projectDescriptor = new ProjectDescriptor ();
+
+            projectDescriptor.name = xmlElement.GetAttribute ("name");
+
+            projectDescriptor.type = xmlElement.GetAttribute ("type");
+            if ( String.IsNullOrEmpty(projectDescriptor.type))
+                projectDescriptor.type = "DotNet";
+
+            if (xmlElement["Files"] != null) {
+                foreach (XmlNode xmlNode in xmlElement["Files"].ChildNodes) {
+                    if (xmlNode is XmlElement)
+                        projectDescriptor.files.Add (FileDescriptionTemplate.CreateTemplate ((XmlElement)xmlNode));
+
+                }
+            }
+
+            if (xmlElement["Resources"] != null) {
+                foreach (XmlNode xmlNode in xmlElement["Resources"].ChildNodes) {
+                    if (xmlNode is XmlElement) {
+                        FileDescriptionTemplate fileTemplate = FileDescriptionTemplate.CreateTemplate ((XmlElement)xmlNode);
+                        if ( fileTemplate is SingleFileDescriptionTemplate )
+                            projectDescriptor.resources.Add ((SingleFileDescriptionTemplate)fileTemplate);
+                        else
+                            MessageService.ShowError (GettextCatalog.GetString ("Only single-file templates allowed to generate resource files"));
+                    }
+
+                }
+            }
+
+            if (xmlElement["References"] != null) {
+                foreach (XmlNode xmlNode in xmlElement["References"].ChildNodes) {
+                    XmlElement elem = (XmlElement)xmlNode;
+                    ProjectReference projectReference = new ProjectReference ((ReferenceType)Enum.Parse (typeof (ReferenceType), elem.GetAttribute ("type")), elem.GetAttribute ("refto"));
+
+                    if (elem.Attributes["SpecificVersion"] != null && (String.Compare(elem.Attributes["SpecificVersion"].Value, "true", StringComparison.InvariantCultureIgnoreCase) == 0))
+                        projectReference.SpecificVersion = true;
+
+                    projectDescriptor.references.Add (projectReference);
+                }
+            }
+
+
+            projectDescriptor.projectOptions = xmlElement ["Options"];
+            if ( projectDescriptor.projectOptions == null )
+                projectDescriptor.projectOptions = xmlElement.OwnerDocument.CreateElement("Options");
+
+            return projectDescriptor;
+        }
+
+        public SolutionEntityItem CreateItem (ProjectCreateInformation projectCreateInformation, string defaultLanguage)
+        {
+            if ((projectOptions.Attributes["language"] == null) || String.IsNullOrEmpty (projectOptions.Attributes["language"].Value))
+                projectOptions.SetAttribute ("language", defaultLanguage);
+            
+
+            Project project = Services.ProjectService.CreateProject (type, projectCreateInformation, projectOptions);
+            return project;
+
+        }
+
+        public void InitializeItem(SolutionItem policyParent, ProjectCreateInformation projectCreateInformation, string defaultLanguage, SolutionEntityItem item)
+        {
+            MonoDevelop.Projects.Project project = item as MonoDevelop.Projects.Project;
+
+            if (project == null) {
+                MessageService.ShowError (GettextCatalog.GetString ("Can't create project with type: {0}", type));
+                return;
+            }
+
+            project.Name = StringParserService.Parse (name, new string[,] { { "ProjectName", projectCreateInformation.ProjectName } });
+            project.FileName = Path.Combine (projectCreateInformation.ProjectBasePath, project.Name);
+
+            if (project is DotNetProject) {
+                foreach (ProjectReference projectReference in references)
+                    ((DotNetProject)project).References.Add (projectReference);
+            }
+
+            foreach (SingleFileDescriptionTemplate resourceTemplate in resources) {
+                try {
+                    ProjectFile projectFile = new ProjectFile (resourceTemplate.SaveFile (policyParent, project, defaultLanguage, project.BaseDirectory, null));
+                    projectFile.BuildAction = BuildAction.EmbeddedResource;
+
+                    project.Files.Add (projectFile);
+                }
+                catch (Exception ex) {
+                    MessageService.ShowException (ex, GettextCatalog.GetString ("File {0} could not be written.", resourceTemplate.Name));
+                    LoggingService.LogError (GettextCatalog.GetString ("File {0} could not be written.", resourceTemplate.Name), ex);
+                }
+            }
+
+
+            foreach (FileDescriptionTemplate fileTemplate in files) {
+                try {
+                    fileTemplate.AddToProject (policyParent, project, defaultLanguage, project.BaseDirectory, null);
+                }
+                catch (Exception ex) {
+                    MessageService.ShowException (ex, GettextCatalog.GetString ("File {0} could not be written.", fileTemplate.Name));
+                    LoggingService.LogError (GettextCatalog.GetString ("File {0} could not be written.", fileTemplate.Name), ex);
+                }
+            }
+        }
+	}
+}