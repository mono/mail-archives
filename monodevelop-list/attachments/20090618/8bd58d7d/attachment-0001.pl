Index: main/src/core/MonoDevelop.Ide/ChangeLog
===================================================================
--- main/src/core/MonoDevelop.Ide/ChangeLog	(revision 136205)
+++ main/src/core/MonoDevelop.Ide/ChangeLog	(working copy)
@@ -1,3 +1,7 @@
+2009-06-18  Viktoria Dudka  <viktoriad@remobjects.com>
+
+	* MonoDevelop.Ide.Gui/CustomStringTagParser.cs: Rewritten from scratch to make it non-GPL. 
+
 2009-06-16  Mike Krüger  <mkrueger@novell.com>
 
 	* MonoDevelop.Ide.Gui/ProjectOperations.cs: Fixed "Bug 513383
Index: main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.Commands/CustomStringTagProvider.cs
===================================================================
--- main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.Commands/CustomStringTagProvider.cs	(revision 136205)
+++ main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.Commands/CustomStringTagProvider.cs	(working copy)
@@ -1,161 +1,155 @@
-//  CustomStringTagProvider.cs
+// CustomStringTagProvider.cs
 //
-//  This file was derived from a file from #Develop. 
+// Author:
+//   Viktoria Dudka (viktoriad@remobjects.com)
 //
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
 using System;
+using MonoDevelop.Core.Gui.Dialogs;
+using MonoDevelop.Core;
+using Mono.Addins;
+using MonoDevelop.Components.Commands;
+using MonoDevelop.Ide.Gui;
+using MonoDevelop.Projects;
+using MonoDevelop.Ide.Gui.Dialogs;
+using MonoDevelop.Ide.Gui.Content;
+using MonoDevelop.Core.Gui;
 using System.IO;
-using System.Threading;
-using System.Drawing;
-using System.Drawing.Printing;
+using Gtk;
 using System.Collections.Generic;
-using System.ComponentModel;
-using System.Diagnostics;
 
-using Mono.Addins;
-using MonoDevelop.Core;
-using MonoDevelop.Core.Gui;
-using MonoDevelop.Core.Gui.Dialogs;
-using MonoDevelop.Projects;
-using MonoDevelop.Ide.Gui;
-
 namespace MonoDevelop.Ide.Commands
 {
-	internal class SharpDevelopStringTagProvider :  StringParserService.IStringTagProvider 
+    class DefaultStringTagProvider : StringParserService.IStringTagProvider
 	{
-		public IEnumerable<string> Tags {
-			get {
-				return new string[] { "ITEMPATH", "ITEMDIR", "ITEMFILENAME", "ITEMEXT",
-				                      "CURLINE", "CURCOL", "CURTEXT",
-				                      "TARGETPATH", "TARGETDIR", "TARGETNAME", "TARGETEXT",
-				                      "PROJECTDIR", "PROJECTFILENAME",
-				                      "COMBINEDIR", "COMBINEFILENAME",
-				                      "SOLUTIONDIR", "SOLUTIONFILE",
-				                      "STARTUPPATH"};
-			}
-		}
-		
-		string GetCurrentItemPath()
-		{
-			if (IdeApp.Workbench.ActiveDocument != null && !IdeApp.Workbench.ActiveDocument.IsViewOnly) {
-				return IdeApp.Workbench.ActiveDocument.Name;
-			}
-			return String.Empty;
-		}
-		
-		string GetCurrentTargetPath()
-		{
-			if (IdeApp.ProjectOperations.CurrentSelectedProject != null) {
-				return IdeApp.ProjectOperations.CurrentSelectedProject.GetOutputFileName (IdeApp.Workspace.ActiveConfiguration);
-			}
-			if (IdeApp.Workbench.ActiveDocument != null) {
-				Project project = IdeApp.Workbench.ActiveDocument.Project;
-				if (project != null)
-					return project.GetOutputFileName (IdeApp.Workspace.ActiveConfiguration);
-			}
-			return String.Empty;
-		}
-		
-		public string Convert(string tag, string format)
-		{
-			switch (tag.ToUpper ()) {
-				case "ITEMPATH":
-					try {
-						return GetCurrentItemPath();
-					} catch (Exception) {}
-					break;
-				case "ITEMDIR":
-					try {
-						return Path.GetDirectoryName(GetCurrentItemPath());
-					} catch (Exception) {}
-					break;
-				case "ITEMFILENAME":
-					try {
-						return Path.GetFileName(GetCurrentItemPath());
-					} catch (Exception) {}
-					break;
-				case "ITEMEXT":
-					try {
-						return Path.GetExtension(GetCurrentItemPath());
-					} catch (Exception) {}
-					break;
-				
-				// TODO:
-				case "CURLINE":
-					return String.Empty;
-				case "CURCOL":
-					return String.Empty;
-				case "CURTEXT":
-					return String.Empty;
-				
-				case "TARGETPATH":
-					try {
-						return GetCurrentTargetPath();
-					} catch (Exception) {}
-					break;
-				case "TARGETDIR":
-					try {
-						return Path.GetDirectoryName(GetCurrentTargetPath());
-					} catch (Exception) {}
-					break;
-				case "TARGETNAME":
-					try {
-						return Path.GetFileName(GetCurrentTargetPath());
-					} catch (Exception) {}
-					break;
-				case "TARGETEXT":
-					try {
-						return Path.GetExtension(GetCurrentTargetPath());
-					} catch (Exception) {}
-					break;
-				
-				case "PROJECTDIR":
-					if (IdeApp.ProjectOperations.CurrentSelectedProject != null) {
-						return IdeApp.ProjectOperations.CurrentSelectedProject.BaseDirectory;
-					}
-					break;
-				case "PROJECTFILENAME":
-					if (IdeApp.ProjectOperations.CurrentSelectedProject != null) {
-						try {
-							return Path.GetFileName(IdeApp.ProjectOperations.CurrentSelectedProject.FileName);
-						} catch (Exception) {}
-					}
-					break;
-				
-				case "SOLUTIONDIR":
-				case "COMBINEDIR":
-					if (IdeApp.ProjectOperations.CurrentSelectedSolutionItem != null)
-						return Path.GetDirectoryName (IdeApp.ProjectOperations.CurrentSelectedSolutionItem.ParentSolution.FileName);
-					break;
+        public IEnumerable<string> Tags { 
+            get {
+                return new String[] {
+                                "ITEMPATH", 
+                                "ITEMDIR", 
+                                "ITEMFILENAME", 
+                                "ITEMEXT", 
+                                "TARGETPATH", 
+                                "TARGETDIR", 
+                                "TARGETNAME", 
+                                "TARGETEXT", 
+                                "PROJECTDIR", 
+                                "PROJECTFILENAME",
+                                "SOLUTIONDIR", 
+                                "SOLUTIONFILE",
+                                "COMBINEDIR", 
+                                "COMBINEFILENAME"
+                };
+            }
+        }
 
-				case "SOLUTIONFILE":
-				case "COMBINEFILENAME":
-					try {
-					if (IdeApp.ProjectOperations.CurrentSelectedSolutionItem != null)
-						return Path.GetFileName (IdeApp.ProjectOperations.CurrentSelectedSolutionItem.ParentSolution.FileName);
-					} catch (Exception) {}
-					break;
-				case "STARTUPPATH":
-					//return Application.StartupPath;
-					return "";
+        public string Convert(string tag, string format)
+        {
+			try {
+				switch(tag.ToUpperInvariant ()) {
+					case "ITEMPATH":
+						if(IdeApp.Workbench.ActiveDocument != null)
+							return (IdeApp.Workbench.ActiveDocument.IsViewOnly) ? String.Empty : IdeApp.Workbench.ActiveDocument.Name;
+						return String.Empty;
+
+					case "ITEMDIR":
+						if(IdeApp.Workbench.ActiveDocument != null)
+							return (IdeApp.Workbench.ActiveDocument.IsViewOnly) ? String.Empty : (string)IdeApp.Workbench.ActiveDocument.FileName.ParentDirectory;
+						return String.Empty;
+
+					case "ITEMFILENAME":
+						if(IdeApp.Workbench.ActiveDocument != null)
+							return (IdeApp.Workbench.ActiveDocument.IsViewOnly) ? String.Empty : IdeApp.Workbench.ActiveDocument.FileName.FileName;
+						return String.Empty;
+
+					case "ITEMEXT":
+						if(IdeApp.Workbench.ActiveDocument != null)
+							return (IdeApp.Workbench.ActiveDocument.IsViewOnly) ? String.Empty : IdeApp.Workbench.ActiveDocument.FileName.Extension;
+						return String.Empty;
+
+					case "TARGETPATH":
+						if(IdeApp.ProjectOperations.CurrentSelectedProject != null)
+							return IdeApp.ProjectOperations.CurrentSelectedProject.GetOutputFileName (IdeApp.Workspace.ActiveConfiguration);
+						else
+							if((IdeApp.Workbench.ActiveDocument != null) && (IdeApp.Workbench.ActiveDocument.Project != null))
+								return IdeApp.Workbench.ActiveDocument.Project.GetOutputFileName (IdeApp.Workspace.ActiveConfiguration);
+						return String.Empty;
+
+					case "TARGETDIR":
+						if(IdeApp.ProjectOperations.CurrentSelectedProject != null)
+							return Path.GetDirectoryName (IdeApp.ProjectOperations.CurrentSelectedProject.GetOutputFileName (IdeApp.Workspace.ActiveConfiguration));
+						else
+							if((IdeApp.Workbench.ActiveDocument != null) && (IdeApp.Workbench.ActiveDocument.Project != null))
+								return Path.GetDirectoryName (IdeApp.Workbench.ActiveDocument.Project.GetOutputFileName (IdeApp.Workspace.ActiveConfiguration));
+						return String.Empty;
+
+					case "TARGETNAME":
+						if(IdeApp.ProjectOperations.CurrentSelectedProject != null)
+							return Path.GetFileName (IdeApp.ProjectOperations.CurrentSelectedProject.GetOutputFileName (IdeApp.Workspace.ActiveConfiguration));
+						else
+							if((IdeApp.Workbench.ActiveDocument != null) && (IdeApp.Workbench.ActiveDocument.Project != null))
+								return Path.GetFileName (IdeApp.Workbench.ActiveDocument.Project.GetOutputFileName (IdeApp.Workspace.ActiveConfiguration));
+						return String.Empty;
+
+					case "TARGETEXT":
+						if(IdeApp.ProjectOperations.CurrentSelectedProject != null)
+							return Path.GetExtension (IdeApp.ProjectOperations.CurrentSelectedProject.GetOutputFileName (IdeApp.Workspace.ActiveConfiguration));
+						else
+							if((IdeApp.Workbench.ActiveDocument != null) && (IdeApp.Workbench.ActiveDocument.Project != null))
+								return Path.GetExtension (IdeApp.Workbench.ActiveDocument.Project.GetOutputFileName (IdeApp.Workspace.ActiveConfiguration));
+						return String.Empty;
+
+					case "PROJECTDIR":
+						if((IdeApp.Workbench.ActiveDocument != null) && (IdeApp.Workbench.ActiveDocument.Project != null))
+							return IdeApp.Workbench.ActiveDocument.Project.FileName.ParentDirectory.FileName;
+						return String.Empty;
+
+					case "PROJECTFILENAME":
+						if((IdeApp.Workbench.ActiveDocument != null) && (IdeApp.Workbench.ActiveDocument.Project != null))
+							return IdeApp.Workbench.ActiveDocument.Project.FileName.FileName;
+						return String.Empty;
+
+					case "SOLUTIONDIR":
+					case "COMBINEDIR":
+						if(IdeApp.ProjectOperations.CurrentSelectedSolutionItem != null)
+							return IdeApp.ProjectOperations.CurrentSelectedSolutionItem.ParentSolution.FileName.ParentDirectory.FileName;
+						return String.Empty;
+
+					case "SOLUTIONFILE":
+					case "COMBINEFILENAME":
+						if(IdeApp.ProjectOperations.CurrentSelectedSolutionItem != null)
+							return IdeApp.ProjectOperations.CurrentSelectedSolutionItem.ParentSolution.FileName.FileName;
+						return String.Empty;
+
+					default:
+						return String.Empty;
+				}
+			}
+			catch {
+				return String.Empty;
 			}
-			return String.Empty;
-		}
+        }
 	}
-
 }
Index: main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.Gui/Ide.cs
===================================================================
--- main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.Gui/Ide.cs	(revision 136205)
+++ main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.Gui/Ide.cs	(working copy)
@@ -159,7 +159,7 @@
 			monitor.Step (1);
 			
 			// register string tag provider (TODO: move to add-in tree :)
-			StringParserService.RegisterStringTagProvider(new MonoDevelop.Ide.Commands.SharpDevelopStringTagProvider());
+            StringParserService.RegisterStringTagProvider (new MonoDevelop.Ide.Commands.DefaultStringTagProvider ());
 			
 			InternalLog.EnableErrorNotification ();
 			