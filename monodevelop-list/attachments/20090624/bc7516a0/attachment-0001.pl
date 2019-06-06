Index: main/src/core/MonoDevelop.Ide/ChangeLog
===================================================================
--- main/src/core/MonoDevelop.Ide/ChangeLog	(revision 136782)
+++ main/src/core/MonoDevelop.Ide/ChangeLog	(working copy)
@@ -1,3 +1,7 @@
+2009-06-24  Viktoria Dudka  <viktoriad@remobjects.com>
+	* MonoDevelop.Ide.Templates/FileTemplate.cs: rewritten GPL parts
+	  rest based on monodevelop-only changes.
+
 2009-06-23  Lluis Sanchez Gual  <lluis@novell.com>
 
 	* MonoDevelop.Ide.Gui/Ide.cs:
Index: main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.Templates/FileTemplate.cs
===================================================================
--- main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.Templates/FileTemplate.cs	(revision 136782)
+++ main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.Templates/FileTemplate.cs	(working copy)
@@ -1,473 +1,466 @@
-//  FileTemplate.cs
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
-using System.CodeDom;
-using System.CodeDom.Compiler;
-
-using MonoDevelop.Core;
-using Mono.Addins;
-using MonoDevelop.Core.Gui;
-using MonoDevelop.Ide.Codons;
-using MonoDevelop.Projects;
-using MonoDevelop.Ide.Gui;
-using MonoDevelop.Projects.CodeGeneration;
-
-namespace MonoDevelop.Ide.Templates
-{
-	/// <summary>
-	/// This class defines and holds the new file templates.
-	/// </summary>
-	public class FileTemplate
-	{
-		public static List<FileTemplate> fileTemplates = new List<FileTemplate> ();
-		
-		string    id;
-		string    originator   = null;
-		string    created      = null;
-		string    lastmodified = null;
-		string    name         = null;
-		string    category     = null;
-		string    languagename = "";
-		string    projecttype  = "";
-		string    description  = null;
-		string    icon         = null;
-		
-		string    defaultFilename = null;
-		bool      isFixedFilename = false;
-		
-		string    wizardpath   = null;
-		
-		List<FileDescriptionTemplate> files = new List<FileDescriptionTemplate> ();
-		List<FileTemplateCondition> conditions = new List<FileTemplateCondition> ();
-		
-		public string Id {
-			get {
-				return id;
-			}
-		}
-		
-		public string WizardPath {
-			get {
-				return wizardpath;
-			}
-		}
-		
-		public string Originator {
-			get {
-				return originator;
-			}
-		}
-		
-		public string Created {
-			get {
-				return created;
-			}
-		}
-		
-		public string LastModified {
-			get {
-				return lastmodified;
-			}
-		}
-		
-		public string Name {
-			get {
-				return name;
-			}
-		}
-		
-		public string Category {
-			get {
-				return category;
-			}
-		}
-		
-		public string LanguageName {
-			get {
-				return languagename;
-			}
-		}
-		
-		public string ProjectType {
-			get {
-				return projecttype;
-			}
-		}
-		
-		public string Description {
-			get {
-				return description;
-			}
-		}
-		
-		public string Icon {
-			get {
-				return icon;
-			}
-		}
-		
-		public string DefaultFilename {
-			get {
-				return defaultFilename;
-			}
-		}
-		
-		public bool IsFixedFilename {
-			get {
-				return isFixedFilename;
-			}
-		}
-		
-		public List<FileDescriptionTemplate> Files {
-			get {
-				return files;
-			}
-		}
-		
-		public List<FileTemplateCondition> Conditions {
-			get {
-				return conditions;
-			}
-		}
-		
-		static FileTemplate LoadFileTemplate (RuntimeAddin addin, ProjectTemplateCodon codon)
-		{
-			XmlDocument doc = codon.GetTemplate ();
-			
-			XmlElement config = doc.DocumentElement["TemplateConfiguration"];
-			
-			FileTemplate fileTemplate;
-			
-			if (config["Type"] != null) {
-				string hn = config["Type"].InnerText;
-				Type type = addin.GetType (hn);
-				if (!(typeof(FileTemplate).IsAssignableFrom (type)))
-					throw new InvalidOperationException ("The file template class '" + hn + "' must be a subclass of MonoDevelop.Ide.Templates.FileTemplate.");
-				fileTemplate = (FileTemplate) Activator.CreateInstance (type);
-			} else {
-				fileTemplate = new FileTemplate ();
-			}
-			
-			fileTemplate.originator   = doc.DocumentElement.GetAttribute ("Originator");
-			fileTemplate.created      = doc.DocumentElement.GetAttribute ("Created");
-			fileTemplate.lastmodified = doc.DocumentElement.GetAttribute ("LastModified");
-			
-			if (config["_Name"] != null)
-				fileTemplate.name = addin.Localizer.GetString (config["_Name"].InnerText);
-			else
-				throw new InvalidOperationException ("Missing element '_Name' in file template: " + codon.Id);
-			
-			if (config["_Category"] != null)
-				fileTemplate.category = addin.Localizer.GetString (config["_Category"].InnerText);
-			else
-				throw new InvalidOperationException ("Missing element '_Category' in file template: " + codon.Id);
-			
-			if (config["LanguageName"] != null)
-				fileTemplate.languagename = config["LanguageName"].InnerText;
-			
-			if (config["ProjectType"] != null)
-				fileTemplate.projecttype  = config["ProjectType"].InnerText;
-			
-			if (config["_Description"] != null) {
-				fileTemplate.description  = addin.Localizer.GetString (config["_Description"].InnerText);
-			}
-			
-			if (config["Icon"] != null) {
-				fileTemplate.icon = ImageService.GetStockId (addin, config["Icon"].InnerText);
-			}
-			
-			if (config["Wizard"] != null) {
-				fileTemplate.wizardpath = config["Wizard"].Attributes["path"].InnerText;
-			}
-			
-			if (config["DefaultFilename"] != null) {
-				fileTemplate.defaultFilename = config["DefaultFilename"].InnerText;
-				if (config["DefaultFilename"].Attributes["IsFixed"] != null) {
-					string isFixedStr = config["DefaultFilename"].Attributes["IsFixed"].InnerText;
-					try {
-						fileTemplate.isFixedFilename = bool.Parse (isFixedStr);
-					} catch (FormatException) {
-						throw new InvalidOperationException ("Invalid value for IsFixed in template.");
-					}
-				}
-			}
-			
-			// load the files
-			XmlElement files  = doc.DocumentElement["TemplateFiles"];
-			XmlNodeList nodes = files.ChildNodes;
-			foreach (XmlNode filenode in nodes) {
-				XmlElement fileelem = filenode as XmlElement;
-				if (fileelem == null)
-					continue;
-				FileDescriptionTemplate template = FileDescriptionTemplate.CreateTemplate (fileelem);
-				fileTemplate.files.Add(template);
-			}
-			
-			//load the conditions
-			XmlElement conditions  = doc.DocumentElement["Conditions"];
-			if (conditions != null) {
-				XmlNodeList conditionNodes = conditions.ChildNodes;
-				foreach (XmlNode node in conditionNodes) {
-					XmlElement elem = node as XmlElement;
-					if (elem == null)
-						continue;
-					FileTemplateCondition condition = FileTemplateCondition.CreateCondition (elem);
-					fileTemplate.conditions.Add (condition);
-				}
-			}
-			
-			return fileTemplate;
-		}
-		
-		static FileTemplate()
-		{
-			AddinManager.AddExtensionNodeHandler ("/MonoDevelop/Ide/FileTemplates", OnExtensionChanged);
-		}
-
-		static void OnExtensionChanged (object s, ExtensionNodeEventArgs args)
-		{
-			if (args.Change == ExtensionChange.Add) {
-				ProjectTemplateCodon codon = (ProjectTemplateCodon) args.ExtensionNode;
-				try {
-					FileTemplate t = LoadFileTemplate (codon.Addin, codon);
-					t.id = codon.Id;
-					fileTemplates.Add (t);
-				} catch (Exception e) {
-					LoggingService.LogFatalError (GettextCatalog.GetString ("Error loading template: {0}", codon.Id), e);
-				}
-			}
-			else {
-				ProjectTemplateCodon codon = (ProjectTemplateCodon) args.ExtensionNode;
-				foreach (FileTemplate t in fileTemplates) {
-					if (t.Id == codon.Id) {
-						fileTemplates.Remove (t);
-						break;
-					}
-				}
-			}
-		}
-		
-		internal static ArrayList GetFileTemplates (Project project, string projectPath)
-		{
-			ArrayList list = new ArrayList ();
-			foreach (FileTemplate t in fileTemplates) {
-				if (t.IsValidForProject (project, projectPath))
-					list.Add (t);
-			}
-			return list;
-		}
-		
-		internal static FileTemplate GetFileTemplateByID (string templateID)
-		{
-			foreach (FileTemplate t in fileTemplates)
-				if (t.Id == templateID)
-					return t;
-			
-			return null;
-		}
-		
-		public virtual bool Create (SolutionItem policyParent, Project project, string directory, string language, string name)
-		{
-			if (WizardPath != null) {
-				//Properties customizer = new Properties();
-				//customizer.Set("Template", item);
-				//customizer.Set("Creator",  this);
-				//WizardDialog wizard = new WizardDialog("File Wizard", customizer, item.WizardPath);
-				//if (wizard.ShowDialog() == DialogResult.OK) {
-					//DialogResult = DialogResult.OK;
-				//}
-				return false;
-			} else {
-				foreach (FileDescriptionTemplate newfile in Files)
-					if (!CreateFile (newfile, policyParent, project, directory, language, name))
-						return false;
-				return true;
-			}
-		}
-		
-		public virtual bool IsValidName (string name, string language)
-		{
-			if (isFixedFilename)
-				return (name == defaultFilename);
-			
-			bool valid = true;
-			foreach (FileDescriptionTemplate templ in Files)
-				if (!templ.IsValidName (name, language))
-					valid = false;
-			
-			return valid;
-		}
-		
-		protected virtual bool CreateFile (FileDescriptionTemplate newfile, SolutionItem policyParent, Project project, string directory, string language, string name)
-		{
-			if (project != null) {
-				if (newfile.AddToProject (policyParent, project, language, directory, name)) {
-					newfile.Show ();
-					return true;
-				}
-			} else {
-				SingleFileDescriptionTemplate singleFile = newfile as SingleFileDescriptionTemplate;
-				if (singleFile == null)
-					throw new InvalidOperationException ("Single file template expected");
-				
-				if (directory != null) {
-					string fileName = singleFile.SaveFile (policyParent, project, language, directory, name);
-					if (fileName != null) {
-						IdeApp.Workbench.OpenDocument (fileName);
-						return true;
-					}
-				} else {
-					string fileName = singleFile.GetFileName (policyParent, project, language, directory, name);
-					Stream stream = singleFile.CreateFileContent (policyParent, project, language, fileName);
-				
-					// Guess the mime type of the new file
-					string fn = Path.GetTempFileName ();
-					string ext = Path.GetExtension (fileName);
-					int n=0;
-					while (File.Exists (fn + n + ext))
-						n++;
-					FileService.MoveFile (fn, fn + n + ext);
-					string mimeType = DesktopService.GetMimeTypeForUri (fn + n + ext);
-					FileService.DeleteFile (fn + n + ext);
-					if (mimeType == null || mimeType == "")
-						mimeType = "text";
-					
-					IdeApp.Workbench.NewDocument (fileName, mimeType, stream);
-					return true;
-				}
-			}
-			return false;
-		}
-		
-		protected virtual bool IsValidForProject (Project project, string projectPath)
-		{
-			// When there is no project, only single template files can be created.
-			if (project == null) {
-				foreach (FileDescriptionTemplate f in files)
-					if (!(f is SingleFileDescriptionTemplate))
-						return false;
-			}
-			
-			// Filter on templates
-			foreach (FileDescriptionTemplate f in files)
-				if (!f.SupportsProject (project, projectPath))
-					return false;
-		
-			//filter on conditions
-			if (project != null) {
-				if (!string.IsNullOrEmpty(projecttype) && (projecttype != project.ProjectType))
-					return false;
-				
-				foreach (FileTemplateCondition condition in conditions)
-					if (!condition.ShouldEnableFor (project, projectPath))
-						return false;
-			}
-			
-			return true;
-		}
-		
-		public virtual List<string> GetCompatibleLanguages (Project project, string projectPath)
-		{
-			if (project == null)
-				return SupportedLanguages;
-			
-			//find the languages that both the template and the project support
-			List<string> langMatches = MatchLanguagesWithProject (project);
-			
-			//filter on conditions
-			List<string> filtered = new List<string> ();
-			foreach (string lang in langMatches) {
-				bool shouldEnable = true;
-				foreach (FileTemplateCondition condition in conditions) {
-					if (!condition.ShouldEnableFor (project, projectPath, lang)) {
-						shouldEnable = false;
-						break;
-					}
-				}
-				if (shouldEnable)
-					filtered.Add (lang);
-			}
-			
-			return filtered;
-		}
-		
-		//The languages that the template supports
-		//FIXME: would it be memory-effective to cache this?
-		List<string> SupportedLanguages {
-			get {
-				List<string> templateLangs = new List<string> ();
-				foreach (string s in this.LanguageName.Split (','))
-					templateLangs.Add (s.Trim ());
-				ExpandLanguageWildcards (templateLangs);
-				return templateLangs;
-			}
-		}
-		
-		List<string> MatchLanguagesWithProject (Project project)
-		{
-			//The languages that the project supports
-			List<string> projectLangs = new List<string> (project.SupportedLanguages);
-			ExpandLanguageWildcards (projectLangs);
-			
-			List<string> templateLangs = SupportedLanguages;
-			
-			//Find all matches between the language strings of project and template
-			List<string> langMatches = new List<string> ();
-				
-			foreach (string templLang in templateLangs)
-				foreach (string projLang in projectLangs)
-					if (templLang == projLang)
-						langMatches.Add (projLang);
-				
-			//Eliminate duplicates
-			int pos = 0;
-			while (pos < langMatches.Count) {
-				int next = langMatches.IndexOf (langMatches [pos], pos +1);
-				if (next != -1)
-					langMatches.RemoveAt (next);
-				else
-					pos++;
-			}
-			
-			return langMatches;
-		}
-		
-		void ExpandLanguageWildcards (List<string> list)
-		{
-			//Template can match all CodeDom .NET languages with a "*"
-			if (list.Contains ("*")) {
-				foreach (ILanguageBinding lb in LanguageBindingService.LanguageBindings) {
-					IDotNetLanguageBinding dnlang = lb as IDotNetLanguageBinding;
-					if (dnlang != null && dnlang.GetCodeDomProvider () != null)
-						list.Add (dnlang.Language);
-					list.Remove ("*");
-				}
-			}
-		}
-	}
-}
+﻿// FileTemplate.cs
+//
+// Author:
+//   Mike Krüger (mkrueger@novell.com)
+//   Lluis Sanchez Gual (lluis@novell.com)
+//   Michael Hutchinson (mhutchinson@novell.com)
+//   Marek Sieradzki (marek.sieradzki@gmail.com)
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
+using System.Collections;
+using MonoDevelop.Ide.Codons;
+using System.Xml;
+
+namespace MonoDevelop.Ide.Templates
+{
+    class FileTemplate
+    {
+        
+
+        public static List<FileTemplate> fileTemplates = new List<FileTemplate> ();
+
+
+        private List<FileDescriptionTemplate> files = new List<FileDescriptionTemplate> ();
+        public List<FileDescriptionTemplate> Files
+        {
+            get { return files; }
+        }
+
+        private List<FileTemplateCondition> conditions = new List<FileTemplateCondition> ();
+        public List<FileTemplateCondition> Сonditions
+        {
+            get { return conditions; }
+        }
+
+        private string id = String.Empty;
+        public string Id
+        {
+            get { return id; }
+        }
+
+        private string icon = String.Empty;
+        public string Icon
+        {
+            get { return icon; }
+        }
+
+        private string category = String.Empty;
+        public string Category
+        {
+            get { return category; }
+        }
+
+        private string wizardPath = String.Empty;
+        public string WizardPath
+        {
+            get { return wizardPath; }
+        }
+
+        private string description = String.Empty;
+        public string Description
+        {
+            get { return description; }
+        }
+
+        private bool isFixedFilename = false;
+        public bool IsFixedFilename
+        {
+            get { return isFixedFilename; }
+        }
+
+        private string defaultFilename = String.Empty;
+        public string DefaultFilename
+        {
+            get { return defaultFilename; }
+        }
+
+        public string name = String.Empty;
+        public string Name
+        {
+            get { return name; }
+        }
+
+        private string languageName = String.Empty;
+        public string LanguageName
+        {
+            get { return languageName; }
+        }
+
+        private string originator = String.Empty;
+        public string Originator
+        {
+            get { return originator; }
+        }
+
+        private string created = String.Empty;
+        public  string Created
+        {
+            get { return created; }
+        }
+
+        private string lastModified = String.Empty;
+        public  string LastModified
+        {
+            get { return lastModified; }
+        }
+
+        private string projecttype = String.Empty;
+        public  string ProjectType
+        {
+            get { return projecttype; }
+        }
+
+
+        private static FileTemplate LoadFileTemplate(RuntimeAddin addin, ProjectTemplateCodon codon)
+        {
+            XmlDocument xmlDocument = codon.GetTemplate ();
+
+            //Configuration
+            //XmlNode xmlNodeConfig = xmlDocument.DocumentElement["TemplateConfiguration"];
+            XmlElement xmlNodeConfig = xmlDocument.DocumentElement["TemplateConfiguration"];
+
+            FileTemplate fileTemplate = null;
+            if (xmlNodeConfig["Type"] != null) {
+                Type configType = addin.GetType (xmlNodeConfig["Type"].InnerText);
+
+                if (typeof (FileTemplate).IsAssignableFrom (configType)) {
+                    fileTemplate = (FileTemplate)Activator.CreateInstance (configType);
+                }
+                else
+                    throw new InvalidOperationException (string.Format ("The file template class '{0}' must be a subclass of MonoDevelop.Ide.Templates.FileTemplate", xmlNodeConfig["Type"].InnerText));
+            }
+            else
+                fileTemplate = new FileTemplate ();
+
+            fileTemplate.originator = xmlDocument.DocumentElement.GetAttribute ("Originator");
+            fileTemplate.created = xmlDocument.DocumentElement.GetAttribute ("Created");
+            fileTemplate.lastModified = xmlDocument.DocumentElement.GetAttribute ("LastModified");
+
+            if (xmlNodeConfig["_Name"] != null) {
+                fileTemplate.name = xmlNodeConfig["_Name"].InnerText;
+            }
+            else {
+                throw new InvalidOperationException (string.Format ("Missing element '_Name' in file template: {0}", codon.Id));
+            }
+
+            if (xmlNodeConfig["_Category"] != null) {
+                fileTemplate.category = xmlNodeConfig["_Category"].InnerText;
+            }
+            else {
+                throw new InvalidOperationException (string.Format ("Missing element '_Category' in file template: {0}", codon.Id));
+            }
+
+            if (xmlNodeConfig["LanguageName"] != null) {
+                fileTemplate.languageName = xmlNodeConfig["LanguageName"].InnerText;
+            }
+
+            if (xmlNodeConfig["ProjectType"] != null) {
+                fileTemplate.projecttype = xmlNodeConfig["ProjectType"].InnerText;
+            }
+
+            if (xmlNodeConfig["_Description"] != null) {
+                fileTemplate.description = xmlNodeConfig["_Description"].InnerText;
+            }
+
+            if (xmlNodeConfig["Icon"] != null) {
+                fileTemplate.icon = ImageService.GetStockId (addin, xmlNodeConfig["Icon"].InnerText); //xmlNodeConfig["_Description"].InnerText;
+            }
+
+            if (xmlNodeConfig["Wizard"] != null) {
+                fileTemplate.icon = xmlNodeConfig["Wizard"].Attributes["path"].InnerText;
+            }
+
+            if (xmlNodeConfig["DefaultFilename"] != null) {
+                fileTemplate.defaultFilename = xmlNodeConfig["DefaultFilename"].InnerText;
+                if (xmlNodeConfig["DefaultFilename"].Attributes["IsFixed"] != null && (bool.Parse (xmlNodeConfig["DefaultFilename"].Attributes["IsFixed"].InnerText)))
+                    fileTemplate.isFixedFilename = true;
+            }
+
+
+            //Template files
+            XmlNode xmlNodeTemplates = xmlDocument.DocumentElement["TemplateFiles"];
+
+			if(xmlNodeTemplates != null) {
+				foreach(XmlNode xmlNode in xmlNodeTemplates.ChildNodes) {
+					if(xmlNode is XmlElement) {
+						fileTemplate.files.Add (FileDescriptionTemplate.CreateTemplate ((XmlElement)xmlNode));
+					}
+				}
+			}
+
+            //Conditions
+            XmlNode xmlNodeConditions = xmlDocument.DocumentElement["Conditions"];
+			if(xmlNodeConditions != null) {
+				foreach(XmlNode xmlNode in xmlNodeConditions.ChildNodes) {
+					if(xmlNode is XmlElement) {
+						fileTemplate.conditions.Add (FileTemplateCondition.CreateCondition ((XmlElement)xmlNode));
+					}
+				}
+			}
+
+            return fileTemplate;
+        }
+
+		static FileTemplate()
+        {
+            AddinManager.AddExtensionNodeHandler ("/MonoDevelop/Ide/FileTemplates", OnExtensionChanged);
+        }
+
+		static void OnExtensionChanged (object s, ExtensionNodeEventArgs args)
+        {
+            if (args.Change == ExtensionChange.Add) {
+				ProjectTemplateCodon codon = (ProjectTemplateCodon) args.ExtensionNode;
+                try {
+                    FileTemplate t = LoadFileTemplate (codon.Addin, codon);
+                    t.id = codon.Id;
+                    fileTemplates.Add (t);
+				} catch (Exception e) {
+                    LoggingService.LogFatalError (GettextCatalog.GetString ("Error loading template: {0}", codon.Id), e);
+                }
+            }
+            else {
+				ProjectTemplateCodon codon = (ProjectTemplateCodon) args.ExtensionNode;
+                foreach (FileTemplate t in fileTemplates) {
+                    if (t.Id == codon.Id) {
+                        fileTemplates.Remove (t);
+                        break;
+                    }
+                }
+            }
+        }
+
+		internal static ArrayList GetFileTemplates (Project project, string projectPath)
+        {
+            ArrayList list = new ArrayList ();
+            foreach (FileTemplate t in fileTemplates) {
+                if (t.IsValidForProject (project, projectPath))
+                    list.Add (t);
+            }
+            return list;
+        }
+
+		internal static FileTemplate GetFileTemplateByID (string templateID)
+        {
+            foreach (FileTemplate t in fileTemplates)
+                if (t.Id == templateID)
+                    return t;
+
+            return null;
+        }
+
+		public virtual bool Create (SolutionItem policyParent, Project project, string directory, string language, string name)
+        {
+            if (!String.IsNullOrEmpty(WizardPath)) {
+                //Properties customizer = new Properties();
+                //customizer.Set("Template", item);
+                //customizer.Set("Creator",  this);
+                //WizardDialog wizard = new WizardDialog("File Wizard", customizer, item.WizardPath);
+                //if (wizard.ShowDialog() == DialogResult.OK) {
+                //DialogResult = DialogResult.OK;
+                //}
+                return false;
+			} else {
+                foreach (FileDescriptionTemplate newfile in Files)
+                    if (!CreateFile (newfile, policyParent, project, directory, language, name))
+                        return false;
+                return true;
+            }
+        }
+
+		public virtual bool IsValidName (string name, string language)
+        {
+            if (isFixedFilename)
+                return (name == defaultFilename);
+
+            bool valid = true;
+            foreach (FileDescriptionTemplate templ in Files)
+                if (!templ.IsValidName (name, language))
+                    valid = false;
+
+            return valid;
+        }
+
+		protected virtual bool CreateFile (FileDescriptionTemplate newfile, SolutionItem policyParent, Project project, string directory, string language, string name)
+        {
+            if (project != null) {
+                if (newfile.AddToProject (policyParent, project, language, directory, name)) {
+                    newfile.Show ();
+                    return true;
+                }
+			} else {
+                SingleFileDescriptionTemplate singleFile = newfile as SingleFileDescriptionTemplate;
+                if (singleFile == null)
+                    throw new InvalidOperationException ("Single file template expected");
+
+                if (directory != null) {
+                    string fileName = singleFile.SaveFile (policyParent, project, language, directory, name);
+                    if (fileName != null) {
+                        IdeApp.Workbench.OpenDocument (fileName);
+                        return true;
+                    }
+				} else {
+                    string fileName = singleFile.GetFileName (policyParent, project, language, directory, name);
+                    Stream stream = singleFile.CreateFileContent (policyParent, project, language, fileName);
+
+                    // Guess the mime type of the new file
+                    string fn = Path.GetTempFileName ();
+                    string ext = Path.GetExtension (fileName);
+					int n=0;
+                    while (File.Exists (fn + n + ext))
+                        n++;
+                    FileService.MoveFile (fn, fn + n + ext);
+					string mimeType = DesktopService.GetMimeTypeForUri (fn + n + ext);
+                    FileService.DeleteFile (fn + n + ext);
+                    if (mimeType == null || mimeType == "")
+                        mimeType = "text";
+
+                    IdeApp.Workbench.NewDocument (fileName, mimeType, stream);
+                    return true;
+                }
+            }
+            return false;
+        }
+
+		protected virtual bool IsValidForProject (Project project, string projectPath)
+        {
+            // When there is no project, only single template files can be created.
+            if (project == null) {
+                foreach (FileDescriptionTemplate f in files)
+                    if (!(f is SingleFileDescriptionTemplate))
+                        return false;
+            }
+
+            // Filter on templates
+            foreach (FileDescriptionTemplate f in files)
+                if (!f.SupportsProject (project, projectPath))
+                    return false;
+
+            //filter on conditions
+            if (project != null) {
+				if (!string.IsNullOrEmpty(projecttype) && (projecttype != project.ProjectType))
+                    return false;
+
+                foreach (FileTemplateCondition condition in conditions)
+                    if (!condition.ShouldEnableFor (project, projectPath))
+                        return false;
+            }
+
+            return true;
+        }
+
+		public virtual List<string> GetCompatibleLanguages (Project project, string projectPath)
+        {
+            if (project == null)
+                return SupportedLanguages;
+
+            //find the languages that both the template and the project support
+            List<string> langMatches = MatchLanguagesWithProject (project);
+
+            //filter on conditions
+            List<string> filtered = new List<string> ();
+            foreach (string lang in langMatches) {
+                bool shouldEnable = true;
+                foreach (FileTemplateCondition condition in conditions) {
+                    if (!condition.ShouldEnableFor (project, projectPath, lang)) {
+                        shouldEnable = false;
+                        break;
+                    }
+                }
+                if (shouldEnable)
+                    filtered.Add (lang);
+            }
+
+            return filtered;
+        }
+
+        //The languages that the template supports
+        //FIXME: would it be memory-effective to cache this?
+		List<string> SupportedLanguages {
+			get {
+                List<string> templateLangs = new List<string> ();
+                foreach (string s in this.LanguageName.Split (','))
+                    templateLangs.Add (s.Trim ());
+                ExpandLanguageWildcards (templateLangs);
+                return templateLangs;
+            }
+        }
+
+		List<string> MatchLanguagesWithProject (Project project)
+        {
+            //The languages that the project supports
+            List<string> projectLangs = new List<string> (project.SupportedLanguages);
+            ExpandLanguageWildcards (projectLangs);
+
+            List<string> templateLangs = SupportedLanguages;
+
+            //Find all matches between the language strings of project and template
+            List<string> langMatches = new List<string> ();
+
+            foreach (string templLang in templateLangs)
+                foreach (string projLang in projectLangs)
+                    if (templLang == projLang)
+                        langMatches.Add (projLang);
+
+            //Eliminate duplicates
+            int pos = 0;
+            while (pos < langMatches.Count) {
+				int next = langMatches.IndexOf (langMatches [pos], pos +1);
+                if (next != -1)
+                    langMatches.RemoveAt (next);
+                else
+                    pos++;
+            }
+
+            return langMatches;
+        }
+
+		void ExpandLanguageWildcards (List<string> list)
+        {
+            //Template can match all CodeDom .NET languages with a "*"
+            if (list.Contains ("*")) {
+                foreach (ILanguageBinding lb in LanguageBindingService.LanguageBindings) {
+                    IDotNetLanguageBinding dnlang = lb as IDotNetLanguageBinding;
+                    if (dnlang != null && dnlang.GetCodeDomProvider () != null)
+                        list.Add (dnlang.Language);
+                    list.Remove ("*");
+                }
+            }
+        }
+    }
+}