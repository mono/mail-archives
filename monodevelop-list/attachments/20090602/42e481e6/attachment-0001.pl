Index: main/src/core/MonoDevelop.Ide/ChangeLog
===================================================================
--- main/src/core/MonoDevelop.Ide/ChangeLog	(revision 135058)
+++ main/src/core/MonoDevelop.Ide/ChangeLog	(working copy)
@@ -1,3 +1,12 @@
+2009-06-01  Carlo Kok  <ck@remobjects.com>
+
+	* MonoDevelop.Ide.Commands\HelpCommands.cs:
+	* MonoDevelop.Ide.Commands\ViewCommands.cs: rewritten from scratch to make it non-GPL.
+
+2009-05-29  Carlo Kok  <ck@remobjects.com>
+
+	* MonoDevelop.Ide.Commands\FileCommands.cs: Rewritten from scratch to make it non-GPL.
+
 2009-05-29  Lluis Sanchez Gual  <lluis@novell.com>
 
 	* MonoDevelop.Ide.Gui.Dialogs\FileSelectorDialog.cs: Fix glib
Index: main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.Commands/FileCommands.cs
===================================================================
--- main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.Commands/FileCommands.cs	(revision 135058)
+++ main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.Commands/FileCommands.cs	(working copy)
@@ -1,329 +1,327 @@
-//  FileCommands.cs
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
-using System.Collections;
-using System.Diagnostics;
-
-using Mono.Addins;
-using MonoDevelop.Core;
-using MonoDevelop.Projects;
-using MonoDevelop.Core.Gui;
-using MonoDevelop.Components;
-using MonoDevelop.Core.Gui.Dialogs;
-using MonoDevelop.Ide.Gui;
-using MonoDevelop.Ide.Gui.Content;
-using MonoDevelop.Ide.Gui.Dialogs;
-using MonoDevelop.Components.Commands;
-using MonoDevelop.Projects.Gui.Dialogs;
-
-namespace MonoDevelop.Ide.Commands
-{
-	public enum FileCommands
-	{
-		OpenFile,
-		NewFile,
-		NewProject,
-		CloseFile,
-		CloseAllFiles,
-		CloseWorkspace,
-		CloseWorkspaceItem,
-		ReloadFile,
-		Save,
-		SaveAll,
-		SaveAs,
-		RecentFileList,
-		ClearRecentFiles,
-		RecentProjectList,
-		ClearRecentProjects,
-		Exit,
-		ClearCombine,
-		OpenInTerminal,
-		OpenFolder,
-		OpenContainingFolder,
-		PrintDocument,
-		PrintPreviewDocument,
-		SetBuildAction,
-		ShowProperties,
-		CopyToOutputDirectory
-	}
-	
-	internal class NewProjectHandler : CommandHandler
-	{
-		protected override void Run ()
-		{
-			IdeApp.ProjectOperations.NewSolution ();
-		}
-	}
-	
-	internal class NewFileHandler : CommandHandler
-	{
-		protected override void Run ()
-		{
-			NewFileDialog fd = null;
-			try {
-				fd = new NewFileDialog (null, null);
-				fd.Run ();
-			} finally {
-				if (fd != null) fd.Destroy ();
-			}
-		}
-	}
-	
-	internal class CloseAllFilesHandler : CommandHandler
-	{
-		protected override void Run()
-		{
-			IdeApp.Workbench.CloseAllDocuments (false);
-		}
-	}
-	
-	internal class SaveAllHandler : CommandHandler
-	{
-		protected override void Run()
-		{
-			IdeApp.Workbench.SaveAll ();
-		}
-		
-		protected override void Update (CommandInfo info)
-		{
-			bool enabled = false;
-			foreach (Document doc in IdeApp.Workbench.Documents)
-			{
-				if (doc.IsDirty)
-				{
-					enabled = true;
-					break;
-				}
-			}
-			info.Enabled = enabled;
-		}
-	}	
-	
-
-	internal class OpenFileHandler : CommandHandler
-	{
-		protected override void Run()
-		{
-			FileSelectorDialog fs = new FileSelectorDialog (GettextCatalog.GetString ("File to Open"));
-			try {
-				
-				int response = fs.Run ();
-				string name = fs.Filename;
-				fs.Hide ();
-				if (response == (int)Gtk.ResponseType.Ok) {
-					if (name == null) {
-						if (fs.Uri != null)
-							MessageService.ShowError (GettextCatalog.GetString ("Only local files can be opened."));
-						else
-							MessageService.ShowError (GettextCatalog.GetString ("The provided file could not be loaded."));
-						return;
-					}
-					ProjectService ps = MonoDevelop.Projects.Services.ProjectService;
-					if ((ps.IsWorkspaceItemFile (name) || ps.IsSolutionItemFile (name)) && fs.SelectedViewer == null)
-						IdeApp.Workspace.OpenWorkspaceItem (name, fs.CloseCurrentWorkspace);
-					else if (fs.SelectedViewer != null)
-						fs.SelectedViewer.OpenFile (name, fs.Encoding);
-					else
-						IdeApp.Workbench.OpenDocument (name, fs.Encoding);
-				}	
-			}
-			finally {
-				fs.Destroy ();
-			}
-		}
-	}
-	
-	internal class CloseWorkspaceHandler : CommandHandler
-	{
-		protected override void Run()
-		{
-			IdeApp.Workspace.Close();
-		}
-		
-		protected override void Update (CommandInfo info)
-		{
-			if (IdeApp.Workspace.Items.Count == 0)
-				info.Enabled = false;
-			else if (IdeApp.Workspace.Items.Count == 1 && IdeApp.Workspace.Items [0] is Solution)
-				info.Text = GettextCatalog.GetString ("C_lose Solution");
-		}
-	}
-		
-	internal class ExitHandler : CommandHandler
-	{
-		protected override void Run()
-		{
-			IdeApp.Exit ();
-		}
-	}
-	
-	internal class PrintHandler : CommandHandler
-	{
-		protected override void Update (CommandInfo info)
-		{
-			if (IdeApp.Workbench.ActiveDocument == null) {
-				info.Enabled = false;
-				return;
-			}
-			IPrintable printable = IdeApp.Workbench.ActiveDocument.GetContent <IPrintable> ();
-			info.Enabled = printable != null;
-		}
-		protected override void Run (object doc)
-		{
-			IPrintable printable = IdeApp.Workbench.ActiveDocument.GetContent <IPrintable> ();
-			Debug.Assert (printable != null);
-			printable.PrintDocument ();
-		}
-	}
-	
-	internal class PrintPreviewHandler : CommandHandler
-	{
-		protected override void Update (CommandInfo info)
-		{
-			if (IdeApp.Workbench.ActiveDocument == null) {
-				info.Enabled = false;
-				return;
-			}
-			IPrintable printable = IdeApp.Workbench.ActiveDocument.GetContent <IPrintable> ();
-			info.Enabled = printable != null;
-		}
-		protected override void Run (object doc)
-		{
-			IPrintable printable = IdeApp.Workbench.ActiveDocument.GetContent <IPrintable> ();
-			Debug.Assert (printable != null);
-			printable.PrintPreviewDocument ();
-		}
-	}
-	
-	internal class ClearRecentFilesHandler : CommandHandler
-	{
-		protected override void Run()
-		{			
-			try {
-				if (IdeApp.Workbench.RecentOpen.RecentFilesCount > 0 && MessageService.Confirm (GettextCatalog.GetString ("Clear recent files"), GettextCatalog.GetString ("Are you sure you want to clear recent files list?"), AlertButton.Clear)) {
-					IdeApp.Workbench.RecentOpen.ClearRecentFiles();
-				}
-			} catch {}
-		}
-	
-		protected override void Update (CommandInfo info)
-		{
-			RecentOpen recentOpen = IdeApp.Workbench.RecentOpen;
-			info.Enabled = recentOpen.RecentFilesCount > 0;
-		}
-	}
-	
-	internal class ClearRecentProjectsHandler : CommandHandler
-	{
-		protected override void Run()
-		{			
-			try {
-				if (IdeApp.Workbench.RecentOpen.RecentProjectsCount > 0 && MessageService.Confirm (GettextCatalog.GetString ("Clear recent projects"), GettextCatalog.GetString ("Are you sure you want to clear recent projects list?"), AlertButton.Clear))
-				{
-					IdeApp.Workbench.RecentOpen.ClearRecentProjects();
-				}
-			} catch {}
-		}
-	
-		protected override void Update (CommandInfo info)
-		{
-			RecentOpen recentOpen = IdeApp.Workbench.RecentOpen;
-			info.Enabled = recentOpen.RecentProjectsCount > 0;
-		}
-	}
-
-	internal class RecentFileListHandler : CommandHandler
-	{
-		protected override void Update (CommandArrayInfo info)
-		{
-			RecentOpen recentOpen = IdeApp.Workbench.RecentOpen;
-			if (recentOpen.RecentFilesCount > 0) {
-				int i = 0;
-				foreach (RecentItem ri in recentOpen.RecentFiles) {
-					string accelaratorKeyPrefix = i < 10 ? "_" + ((i + 1) % 10).ToString() + " " : "";
-					string label = ((ri.Private == null || ri.Private.Length < 1) ? Path.GetFileName (ri.ToString ()) : ri.Private);
-					CommandInfo cmd = new CommandInfo (accelaratorKeyPrefix + label.Replace ("_", "__"));
-					cmd.Description = GettextCatalog.GetString ("Open {0}", ri.ToString ());
-					info.Add (cmd, ri);
-					i++;
-				}
-			}
-		}
-		
-		protected override void Run (object dataItem)
-		{
-			IdeApp.Workbench.OpenDocument (dataItem.ToString());
-		}
-	}
-
-	internal class RecentProjectListHandler : CommandHandler
-	{
-		protected override void Update (CommandArrayInfo info)
-		{
-			RecentOpen recentOpen = IdeApp.Workbench.RecentOpen;
-			
-			if (recentOpen.RecentProjectsCount <= 0)
-				return;
-				
-			int i = 0;
-			foreach (RecentItem ri in recentOpen.RecentProjects) {
-				//getting the icon requires probing the file, so handle IO errors
-				string icon;
-				try {
-					if (!File.Exists (ri.LocalPath))
-						continue;
-					
-					icon = IdeApp.Services.ProjectService.FileFormats.GetFileFormats
-						(ri.LocalPath, typeof(Solution)).Length > 0
-							? "md-solution"
-							: "md-workspace";
-				}
-				catch (IOException ex) {
-					LoggingService.LogWarning ("Error building recent solutions list", ex);
-					continue;
-				}
-				
-				string accelaratorKeyPrefix = i < 10 ? "_" + ((i + 1) % 10).ToString() + " " : "";
-				string label = ((ri.Private == null || ri.Private.Length < 1)
-				                ? Path.GetFileNameWithoutExtension (ri.ToString ())
-				                : ri.Private);
-				CommandInfo cmd = new CommandInfo (accelaratorKeyPrefix + label.Replace ("_", "__"));
-				cmd.Icon = icon;
-				
-				string str = GettextCatalog.GetString ("Load solution {0}", ri.ToString ());
-				if (IdeApp.Workspace.IsOpen)
-					str += " - " + GettextCatalog.GetString ("Hold Control to open in current workspace.");
-				cmd.Description = str;
-				info.Add (cmd, ri);
-				i++;
-			}
-		}
-		
-		protected override void Run (object dataItem)
-		{
-			string filename = dataItem.ToString();
-			Gdk.ModifierType mtype;
-			bool inWorkspace = Gtk.Global.GetCurrentEventState (out mtype) && (mtype & Gdk.ModifierType.ControlMask) != 0;
-			IdeApp.Workspace.OpenWorkspaceItem (filename, !inWorkspace);
-		}
-	}
-}
+﻿// FileCommands.cs
+//
+// Author:
+//   Carlo Kok (ck@remobjects.com)
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
+
+namespace MonoDevelop.Ide.Commands
+{
+	/// <summary>
+	/// Copied from MonoDevelop.Ide.addin.xml
+	/// </summary>
+	public enum FileCommands
+	{
+		OpenFile,
+		NewFile,
+		Save,
+		SaveAll,
+		NewProject,
+		CloseFile,
+		CloseAllFiles,
+		CloseWorkspace,
+		CloseWorkspaceItem,
+		ReloadFile,
+		SaveAs,
+		PrintDocument,
+		PrintPreviewDocument,
+		RecentFileList,
+		ClearRecentFiles,
+		RecentProjectList,
+		ClearRecentProjects,
+		Exit,
+		OpenInTerminal,
+		OpenFolder,
+		OpenContainingFolder,
+		SetBuildAction,
+		ShowProperties,
+		CopyToOutputDirectory
+	}
+
+	// MonoDevelop.Ide.Commands.FileCommands.OpenFile
+	public class OpenFileHandler : CommandHandler
+	{
+		protected override void Run ()
+		{
+			FileSelectorDialog dlg = new FileSelectorDialog (GettextCatalog.GetString ("File to Open"));
+			string filename;
+			FileViewer viewer;
+			try {
+				if(((ResponseType)dlg.Run ()) == ResponseType.Ok) {
+					filename = dlg.Filename;
+					viewer = dlg.SelectedViewer;
+					if(String.IsNullOrEmpty (filename)) {
+						if(dlg.Uri != null)
+							MessageService.ShowError (GettextCatalog.GetString ("Only local files can be opened."));
+						else
+							MessageService.ShowError (GettextCatalog.GetString ("The provided file could not be loaded."));
+						return;
+					}
+				}
+				else return;
+			}
+			finally {
+				dlg.Destroy (); // destroy, as dispose doesn't actually remove the window.
+			}
+			// Have to make sure that the FileSelectordialog is not a top level window, else it throws MissingMethodException errors deep in GTK.
+			if(viewer == null) { 
+				if(Services.ProjectService.IsWorkspaceItemFile (filename) || Services.ProjectService.IsSolutionItemFile (filename)) {
+					IdeApp.Workspace.OpenWorkspaceItem (filename);
+				}
+				else
+					IdeApp.Workbench.OpenDocument (filename);
+			}
+			else {
+				viewer.OpenFile (filename, dlg.Encoding);
+			}
+
+		}
+		
+	}
+	// MonoDevelop.Ide.Commands.FileCommands.NewFile
+	public class NewFileHandler : CommandHandler
+	{
+		protected override void Run ()
+		{
+			NewFileDialog dlg = new NewFileDialog (null, null); // new file seems to fail if I pass the project IdeApp.ProjectOperations.CurrentSelectedProject
+			try {
+				dlg.Run ();
+			}
+			finally {
+				dlg.Dispose ();
+			}
+		}
+	}
+
+	// MonoDevelop.Ide.Commands.FileCommands.SaveAll
+	public class SaveAllHandler : CommandHandler
+	{
+		protected override void Run ()
+		{
+			IdeApp.Workbench.SaveAll ();
+		}
+
+		protected override void Update (CommandInfo info)
+		{
+			bool hasdirty = false;
+			for(int i = 0; i < IdeApp.Workbench.Documents.Count; i++) {
+				hasdirty |= IdeApp.Workbench.Documents [i].IsDirty;
+			}
+			info.Enabled = hasdirty;
+		}
+	}
+	//MonoDevelop.Ide.Commands.FileCommands.NewProject
+	public class NewProjectHandler : CommandHandler
+	{
+		protected override void Run ()
+		{
+			IdeApp.ProjectOperations.NewSolution ();
+		}
+	}
+
+	// MonoDevelop.Ide.Commands.FileCommands.CloseAllFiles
+	public class CloseAllFilesHandler : CommandHandler
+	{
+		protected override void Run ()
+		{
+			IdeApp.Workbench.CloseAllDocuments (false);
+		}
+
+		protected override void Update (CommandInfo info)
+		{
+			// No point in closing all when there are no documents open
+			info.Enabled = IdeApp.Workbench.Documents.Count != 0;
+		}
+	}
+
+	// MonoDevelop.Ide.Commands.FileCommands.CloseWorkspace
+	// MonoDevelop.Ide.Commands.FileCommands.CloseWorkspaceItem
+	public class CloseWorkspaceHandler : CommandHandler
+	{
+		protected override void Run ()
+		{
+			IdeApp.Workspace.Close ();
+		}
+
+		protected override void Update (CommandInfo info)
+		{
+			info.Enabled = IdeApp.Workspace != null && IdeApp.Workspace.Items.Count > 0;
+
+			if(info.Enabled && IdeApp.Workspace.Items [0] is Solution) // a project is open, if not only a file is open.
+				info.Text = GettextCatalog.GetString ("C_lose Solution");
+			else
+				info.Text = GettextCatalog.GetString ("C_lose");
+
+		}
+	}
+	// MonoDevelop.Ide.Commands.FileCommands.PrintDocument
+	public class PrintHandler : CommandHandler
+	{
+		protected override void Run ()
+		{
+			IPrintable print = IdeApp.Workbench.ActiveDocument.GetContent<IPrintable> ();
+			print.PrintDocument ();
+		}
+
+		protected override void Update (CommandInfo info)
+		{
+			info.Enabled = IdeApp.Workbench.ActiveDocument != null &&
+			IdeApp.Workbench.ActiveDocument.GetContent<IPrintable> () != null;
+		}
+	}
+	// MonoDevelop.Ide.Commands.FileCommands.PrintPreviewDocument
+	public class PrintPreviewHandler : CommandHandler
+	{
+		protected override void Run ()
+		{
+			IPrintable print = IdeApp.Workbench.ActiveDocument.GetContent<IPrintable> ();
+			print.PrintPreviewDocument ();
+		}
+
+		protected override void Update (CommandInfo info)
+		{
+			info.Enabled = IdeApp.Workbench.ActiveDocument != null &&
+			IdeApp.Workbench.ActiveDocument.GetContent<IPrintable> () != null;
+		}
+	}
+	// MonoDevelop.Ide.Commands.FileCommands.RecentFileList
+	public class RecentFileListHandler : CommandHandler
+	{
+		protected override void Update (CommandArrayInfo info)
+		{
+			int i = 0;
+			foreach(RecentItem item in IdeApp.Workbench.RecentOpen.RecentFiles) {
+				i++;
+				CommandInfo ci = new CommandInfo ();
+				ci.Enabled = true;
+				string lFilename = item.ToString ();
+				string lCaption;
+				if(String.IsNullOrEmpty (item.Private)) // Private data will contain something like "filename [project]" if it's set
+					lCaption = Path.GetFileName (lFilename.ToString());
+				else
+					lCaption = item.Private;
+
+				lCaption = lCaption.Replace ("_", "__");
+				if(i < 10) {
+					lCaption = "_" + (i + 1) + " " + lCaption;
+				}
+				else if(i == 10) {
+					lCaption = "1_0 " + lCaption;
+				}
+				ci.Text = lCaption;
+				ci.Description = GettextCatalog.GetString ("Open {0}", lFilename);
+
+				info.Add (ci, lFilename);
+			}
+		}
+		protected override void Run (object dataItem)
+		{
+			IdeApp.Workbench.OpenDocument ((string)dataItem);
+		}
+	}
+	// MonoDevelop.Ide.Commands.FileCommands.ClearRecentFiles
+	public class ClearRecentFilesHandler : CommandHandler
+	{
+		protected override void Run ()
+		{
+			IdeApp.Workbench.RecentOpen.ClearRecentFiles ();
+		}
+		protected override void Update (CommandInfo info)
+		{
+			info.Enabled = IdeApp.Workbench.RecentOpen.RecentFilesCount > 0;
+		}
+	}
+	// MonoDevelop.Ide.Commands.FileCommands.RecentProjectList
+	public class RecentProjectListHandler : CommandHandler
+	{
+		protected override void Update (CommandArrayInfo info)
+		{
+			int i = 0;
+			foreach(RecentItem item in IdeApp.Workbench.RecentOpen.RecentProjects) {
+				i++;
+
+				CommandInfo ci = new CommandInfo ();
+				ci.Enabled = true;
+				string lFilename = item.ToString ();
+				string lCaption;
+				if(String.IsNullOrEmpty (item.Private)) // Private data will contain the project name, else extract from the filename
+					lCaption = Path.GetFileName (lFilename.ToString());
+				else
+					lCaption = item.Private;
+
+				lCaption = lCaption.Replace ("_", "__");
+				if(i < 10) {
+					lCaption = "_" + (i + 1) + " " + lCaption;
+				}
+				else if(i == 10) {
+					lCaption = "1_0 " + lCaption;
+				}
+				ci.Text = lCaption;
+				ci.Description = GettextCatalog.GetString ("Load solution {0}", lFilename);
+
+				info.Add (ci, lFilename);
+			}
+		}
+		protected override void Run (object dataItem)
+		{
+			IdeApp.Workspace.OpenWorkspaceItem ((string)dataItem);
+		}
+	}
+	// MonoDevelop.Ide.Commands.FileCommands.ClearRecentProjects
+	public class ClearRecentProjectsHandler : CommandHandler
+	{
+		protected override void Run ()
+		{
+			IdeApp.Workbench.RecentOpen.ClearRecentProjects ();
+		}
+		protected override void Update (CommandInfo info)
+		{
+			info.Enabled = IdeApp.Workbench.RecentOpen.RecentProjectsCount > 0;
+		}
+	}
+	// MonoDevelop.Ide.Commands.FileCommands.Exit
+	public class ExitHandler : CommandHandler
+	{
+		protected override void Run ()
+		{
+			IdeApp.Exit ();
+		}
+	}
+	// MonoDevelop.Ide.Commands.FileTabCommands.CloseAllButThis    Implemented in FileTabCommands.cs
+	// MonoDevelop.Ide.Commands.CopyPathNameHandler                Implemented in FileTabCommands.cs
+	// MonoDevelop.Ide.Commands.FileTabCommands.ToggleMaximize     Implemented in FileTabCommands.cs
+}
Index: main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.Commands/HelpCommands.cs
===================================================================
--- main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.Commands/HelpCommands.cs	(revision 135058)
+++ main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.Commands/HelpCommands.cs	(working copy)
@@ -1,72 +1,82 @@
-//  HelpCommands.cs
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
-using System.Diagnostics;
-using System.IO;
-using System.Collections;
-using Gtk;
-
-using MonoDevelop.Core;
-using MonoDevelop.Core.Gui;
-using MonoDevelop.Core.Gui.Dialogs;
-using MonoDevelop.Ide.Gui;
-using MonoDevelop.Ide.Gui.Dialogs;
-using MonoDevelop.Components.Commands;
-
-namespace MonoDevelop.Ide.Commands
-{
-	public enum HelpCommands
-	{
-		Help,
-		TipOfTheDay,
-		About
-	}
-	
-	internal class HelpHandler: CommandHandler
-	{
-		protected override void Run ()
-		{
-			IdeApp.HelpOperations.ShowHelp ("root:");
-		}
-	}
-	
-	internal class TipOfTheDayHandler: CommandHandler
-	{
-		protected override void Run ()
-		{
-			TipOfTheDayWindow totdw = new TipOfTheDayWindow ();
-			totdw.Show ();
-		}
-	}
-		
-	internal class AboutHandler: CommandHandler
-	{
-		protected override void Run ()
-		{
-			CommonAboutDialog ad = new CommonAboutDialog ();
-			try {
-				ad.Run ();
-			} finally {
-				ad.Destroy ();
-			}
-		}
-	}
-}
+// HelpCommands.cs
+//
+// Author:
+//   Carlo Kok (ck@remobjects.com)
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
+using MonoDevelop.Ide;
+using Mono.Addins;
+using MonoDevelop.Ide.Gui;
+using MonoDevelop.Components.Commands;
+using MonoDevelop.Ide.Gui.Dialogs;
+
+namespace MonoDevelop.Ide.Commands
+{
+	/// <summary>
+	/// Copied from MonoDevelop.Ide.addin.xml
+	/// </summary>
+	public enum HelpCommands {
+		Help,
+		TipOfTheDay,
+		About
+	}
+
+	// MonoDevelop.Ide.Commands.HelpCommands.Help
+	public class HelpHandler: CommandHandler 
+	{
+		protected override void Run ()
+		{
+			IdeApp.HelpOperations.ShowHelp ("root:");
+		}
+	}
+
+	// MonoDevelop.Ide.Commands.HelpCommands.TipOfTheDay
+	public class TipOfTheDayHandler : CommandHandler
+	{
+		protected override void Run ()
+		{
+			TipOfTheDayWindow dlg = new TipOfTheDayWindow ();
+			dlg.Show ();
+		}
+	}
+
+	// MonoDevelop.Ide.Commands.HelpCommands.About
+	public class AboutHandler : CommandHandler
+	{
+		protected override void Run ()
+		{
+			CommonAboutDialog dlg = new CommonAboutDialog ();
+			try {
+				dlg.Run ();
+			}
+			finally {
+				dlg.Destroy ();
+			}
+		}
+	}
+}
\ No newline at end of file
Index: main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.Commands/ViewCommands.cs
===================================================================
--- main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.Commands/ViewCommands.cs	(revision 135058)
+++ main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.Commands/ViewCommands.cs	(working copy)
@@ -1,266 +1,278 @@
-//  ViewCommands.cs
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
-using System.Collections;
-using System.Collections.Generic;
-using System.CodeDom.Compiler;
-using System.Diagnostics;
-
-using MonoDevelop.Core;
-using Mono.Addins;
-using MonoDevelop.Components.Commands;
-
-using MonoDevelop.Core.Gui;
-using MonoDevelop.Core.Gui.Dialogs;
-using MonoDevelop.Ide.Gui;
-using MonoDevelop.Ide.Gui.Dialogs;
-using MonoDevelop.Ide.Gui.Pads;
-using MonoDevelop.Ide.Gui.Content;
-
-namespace MonoDevelop.Ide.Commands
-{
-	public enum ViewCommands
-	{
-		ViewList,
-		LayoutList,
-		NewLayout,
-		DeleteCurrentLayout,
-		FullScreen,
-		Open,
-		OpenWithList,
-		TreeDisplayOptionList,
-		ResetTreeDisplayOptions,
-		RefreshTree,
-		CollapseAllTreeNodes,
-		LayoutSelector,
-		ShowNext,
-		ShowPrevious,
-		
-		ZoomIn,
-		ZoomOut,
-		ZoomReset
-	}
-	
-	internal class ZoomIn: CommandHandler
-	{
-		protected override void Update (CommandInfo info)
-		{
-			if (IdeApp.Workbench.ActiveDocument == null) {
-				info.Enabled = false;
-				return;
-			}
-			IZoomable zoom = IdeApp.Workbench.ActiveDocument.GetContent <IZoomable> ();
-			info.Enabled = zoom != null && zoom.EnableZoomIn;
+// ViewCommands.cs
+//
+// Author:
+//   Carlo Kok (ck@remobjects.com)
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
+using MonoDevelop.Ide;
+using Mono.Addins;
+using MonoDevelop.Ide.Gui;
+using MonoDevelop.Components.Commands;
+using MonoDevelop.Ide.Gui.Dialogs;
+using MonoDevelop.Ide.Gui.Content;
+
+namespace MonoDevelop.Ide.Commands
+{
+	public enum ViewCommands
+	{
+		ViewList,
+		LayoutList,
+		NewLayout,
+		DeleteCurrentLayout,
+		LayoutSelector,
+		FullScreen,
+		Open,
+		TreeDisplayOptionList,
+		ResetTreeDisplayOptions,
+		RefreshTree,
+		CollapseAllTreeNodes,
+		OpenWithList,
+		ShowNext,
+		ShowPrevious,
+		ZoomIn,
+		ZoomOut,
+		ZoomReset
+	}
+
+	// MonoDevelop.Ide.Commands.ViewCommands.ViewList
+	public class ViewListHandler: CommandHandler 
+	{
+		protected override void Update (CommandArrayInfo info)
+		{
+			for(int i = 0; i < IdeApp.Workbench.Pads.Count; i++) {
+				Pad pad = IdeApp.Workbench.Pads [i];
+
+				CommandInfo ci = new CommandInfo (pad.Title);
+				ci.Icon = pad.Icon;
+				ci.Description = GettextCatalog.GetString ("Show " + pad.Title);
+				ci.Checked = pad.Visible;
+
+				ActionCommand cmd = IdeApp.CommandService.GetActionCommand ("Pad|" + pad.Id);
+				if(cmd != null) ci.AccelKey = cmd.AccelKey;
+
+				CommandArrayInfo list = info;
+				if(pad.Categories != null) {
+					for(int j = 0; j < pad.Categories.Length; j++) {
+						bool found = false;
+						for(int k = list.Count - 1; k >= 0; k--) {
+							if(list [k].Text == pad.Categories [j] && list[k] is CommandInfoSet) {
+								list = ((CommandInfoSet)list [k]).CommandInfos;
+								found = true;
+								break;
+							}
+						}
+						if(!found) {
+							CommandInfoSet set = new CommandInfoSet ();
+							set.Text = pad.Categories [j];
+							set.Description = GettextCatalog.GetString ("Show " + set.Text);
+							list.Add (set);
+							list = set.CommandInfos;
+						}
+					}
+				}
+				for(int j = list.Count - 1; j >= 0; j--) {
+					if(!(list [j] is CommandInfoSet)) {
+						list.Insert (j + 1, ci, pad);
+						pad = null;
+						break;
+					}
+				}
+				if(pad != null)
+					list.Insert (0, ci, pad);
+			}
+		}
+
+		protected override void Run (object dataItem)
+		{
+			Pad pad = dataItem as Pad;
+			if (pad != null)
+				pad.Visible = !pad.Visible;	
 		}
-		protected override void Run (object doc)
-		{
-			IZoomable zoom = IdeApp.Workbench.ActiveDocument.GetContent <IZoomable> ();
-			Debug.Assert (zoom != null);
-			zoom.ZoomIn ();
-		}
 	}
-	
-	internal class ZoomOut: CommandHandler
-	{
-		protected override void Update (CommandInfo info)
-		{
-			if (IdeApp.Workbench.ActiveDocument == null) {
-				info.Enabled = false;
-				return;
-			}
-			IZoomable zoom = IdeApp.Workbench.ActiveDocument.GetContent <IZoomable> ();
-			info.Enabled = zoom != null && zoom.EnableZoomOut;
+
+	// MonoDevelop.Ide.Commands.ViewCommands.LayoutList
+	public class LayoutListHandler : CommandHandler
+	{
+		protected override void Update (CommandArrayInfo info)
+		{
+			string[] layouts = IdeApp.Workbench.Layouts;
+			Array.Sort<string> (layouts, StringComparer.CurrentCultureIgnoreCase);
+			for(int i = 0; i < layouts.Length; i++) {
+				string name = layouts [i];
+				CommandInfo item = new CommandInfo (GettextCatalog.GetString (name));
+				item.Checked = IdeApp.Workbench.CurrentLayout == name;
+				item.Description = GettextCatalog.GetString ("Switch to layout '" + name + "'");
+				info.Add (item, name);
+			}
+		}
+
+		protected override void Run (object dataItem)
+		{
+			if(dataItem is string)
+				IdeApp.Workbench.CurrentLayout = (string)dataItem;
 		}
-		protected override void Run (object doc)
-		{
-			IZoomable zoom = IdeApp.Workbench.ActiveDocument.GetContent <IZoomable> ();
-			Debug.Assert (zoom != null);
-			zoom.ZoomOut ();
-		}
-	}
-	
-	internal class ZoomReset: CommandHandler
-	{
-		protected override void Update (CommandInfo info)
-		{
-			if (IdeApp.Workbench.ActiveDocument == null) {
-				info.Enabled = false;
-				return;
-			}
-			IZoomable zoom = IdeApp.Workbench.ActiveDocument.GetContent <IZoomable> ();
-			info.Enabled = zoom != null && zoom.EnableZoomReset;
-		}
-		protected override void Run (object doc)
-		{
-			IZoomable zoom = IdeApp.Workbench.ActiveDocument.GetContent <IZoomable> ();
-			Debug.Assert (zoom != null);
-			zoom.ZoomReset ();
-		}
-	}
-	
-	internal class FullScreenHandler: CommandHandler
-	{
-		protected override void Run ()
-		{
-			IdeApp.Workbench.FullScreen = !IdeApp.Workbench.FullScreen;
-		}
-	}
-	
-	internal class NewLayoutHandler: CommandHandler
-	{
-		protected override void Run ()
-		{
-			NewLayoutDialog dlg = new NewLayoutDialog ();
-			try {
-				Gtk.ResponseType response = (Gtk.ResponseType) dlg.Run ();
-				if (response == Gtk.ResponseType.Ok)
-					IdeApp.Workbench.CurrentLayout = dlg.LayoutName;
-			} finally {
-				dlg.Destroy ();
-			}
-		}
-	}
-	
-	internal class DeleteCurrentLayoutHandler: CommandHandler
-	{
-		protected override void Run ()
-		{
-			if (MessageService.Confirm (GettextCatalog.GetString ("Are you sure you want to delete the active layout?"), AlertButton.Delete)) {
-				string clayout = IdeApp.Workbench.CurrentLayout;
-				IdeApp.Workbench.CurrentLayout = "Default";
-				IdeApp.Workbench.DeleteLayout (clayout);
-			}
-		}
-		
-		protected override void Update (CommandInfo info)
-		{
-			info.Enabled = IdeApp.Workbench.CurrentLayout != "Default";
-		}
-	}
-	
-	internal class ViewListHandler: CommandHandler
-	{
-		protected override void Update (CommandArrayInfo info)
-		{
-			foreach (Pad pad in IdeApp.Workbench.Pads) {
-				CommandArrayInfo ciset = FindArray (info, pad.Categories);
-				CommandInfo cmd = new CommandInfo (pad.Title);
-				cmd.Icon = pad.Icon;
-				cmd.UseMarkup = true;
-				cmd.Description = GettextCatalog.GetString ("Show {0}", pad.Title);
-				Command c = IdeApp.CommandService.GetActionCommand ("Pad|" + pad.InternalContent.PadId);
-				if (c != null)
-					cmd.AccelKey = c.AccelKey;
-				
-				// Insert before the submenus
-				int n = ciset.Count-1;
-				while (n >= 0 && ciset [n] is CommandInfoSet)
-					n--;
-				ciset.Insert (n+1, cmd, pad);
-			}
-		}
-		
-		public CommandArrayInfo FindArray (CommandArrayInfo iset, string[] categories)
-		{
-			for (int n=0; n<categories.Length; n++) {
-				CommandArrayInfo foundSet = null;
-				for (int i=0; i<iset.Count; i++) {
-					CommandInfoSet s = iset [i] as CommandInfoSet;
-					if (s != null && s.Text == categories [n]) {
-						foundSet = s.CommandInfos;
-						break;
-					}
-				}
-				if (foundSet == null) {
-					CommandInfoSet s = new CommandInfoSet ();
-					s.Text = s.Description = categories [n];
-					iset.Add (s);
-					foundSet = s.CommandInfos;
-				}
-				iset = foundSet;
-			}
-			return iset;
-		}
-		
-		protected override void Run (object ob)
-		{
-			if (ob == null)
-				return;
-			Pad pad = (Pad) ob;
-			pad.Visible = true;
-			pad.BringToFront ();
-		}
-	}
-	
-	internal class LayoutListHandler: CommandHandler
-	{
-		protected override void Update (CommandArrayInfo info)
-		{
-			string[] layouts = IdeApp.Workbench.Layouts;
-			Array.Sort (layouts);
-			foreach (string layout in layouts) {
-				CommandInfo cmd = new CommandInfo (GettextCatalog.GetString (layout));
-				cmd.Checked = (layout == IdeApp.Workbench.CurrentLayout);
-				cmd.Description = GettextCatalog.GetString ("Switch to layout '{0}'", cmd.Text);
-				info.Add (cmd, layout);
-			}
-		}
-		
-		protected override void Run (object layout)
-		{
-			IdeApp.Workbench.CurrentLayout = (string) layout;
-		}
-	}
-	
-	internal class ShowNextHandler: CommandHandler
-	{
-		protected override void Run ()
-		{
-			IdeApp.Workbench.ShowNext ();
-		}
-		
-		protected override void Update (CommandInfo info)
-		{
-			Pad pad = IdeApp.Workbench.GetLocationListPad ();
-			if (pad != null)
-				info.Text = GettextCatalog.GetString ("Show Next ({0})", pad.Title);
-			else
-				info.Enabled = false;
-		}
-	}
-	
-	internal class ShowPreviousHandler: CommandHandler
-	{
-		protected override void Run ()
-		{
-			IdeApp.Workbench.ShowPrevious ();
-		}
-		
-		protected override void Update (CommandInfo info)
-		{
-			Pad pad = IdeApp.Workbench.GetLocationListPad ();
-			if (pad != null)
-				info.Text = GettextCatalog.GetString ("Show Previous ({0})", pad.Title);
-			else
-				info.Enabled = false;
-		}
-	}
-}
+	}
+
+	// MonoDevelop.Ide.Commands.ViewCommands.NewLayout
+	public class NewLayoutHandler : CommandHandler
+	{
+		protected override void Run ()
+		{
+			string newLayoutName = null;
+			NewLayoutDialog dlg = new NewLayoutDialog ();
+			try {
+				if(((Gtk.ResponseType)dlg.Run ()) == Gtk.ResponseType.Ok)
+					newLayoutName = dlg.LayoutName;
+			}
+			finally {
+				dlg.Destroy ();
+			}
+			if(newLayoutName != null) {
+				IdeApp.Workbench.CurrentLayout = newLayoutName;
+			}
+		}
+	}
+	// MonoDevelop.Ide.Commands.ViewCommands.DeleteCurrentLayout
+	public class DeleteCurrentLayoutHandler : CommandHandler
+	{
+		protected override void Update (CommandInfo info)
+		{
+			info.Enabled = !String.Equals ("Default", IdeApp.Workbench.CurrentLayout, StringComparison.OrdinalIgnoreCase);
+		}
+		protected override void Run ()
+		{
+			IdeApp.Workbench.DeleteLayout (IdeApp.Workbench.CurrentLayout);
+		}
+	}
+	// MonoDevelop.Ide.Commands.ViewCommands.FullScreen
+	public class FullScreenHandler : CommandHandler
+	{
+		protected override void Run ()
+		{
+			IdeApp.Workbench.FullScreen = !IdeApp.Workbench.FullScreen;
+		}
+	}
+
+	// MonoDevelop.Ide.Commands.ViewCommands.ShowNext
+	public class ShowNextHandler : CommandHandler
+	{
+		protected override void Run ()
+		{
+			IdeApp.Workbench.ShowNext ();
+		}
+
+		protected override void Update (CommandInfo info)
+		{
+			Pad pad = IdeApp.Workbench.GetLocationListPad ();
+			if(pad == null)
+				info.Enabled = false;
+			else 
+				info.Text = GettextCatalog.GetString("Show Next ("+pad.Title+")");
+		}
+	}
+
+	// MonoDevelop.Ide.Commands.ViewCommands.ShowPrevious
+	public class ShowPreviousHandler : CommandHandler
+	{
+		protected override void Run ()
+		{
+			IdeApp.Workbench.ShowPrevious ();
+		}
+		
+		protected override void Update (CommandInfo info)
+		{
+
+			Pad pad = IdeApp.Workbench.GetLocationListPad ();
+			if(pad == null)
+				info.Enabled = false;
+			else
+				info.Text = GettextCatalog.GetString ("Show Previous (" + pad.Title + ")");
+		}
+	}
+
+	// MonoDevelop.Ide.Commands.ViewCommands.ZoomIn
+	public class ZoomIn : CommandHandler
+	{
+		protected override void Update (CommandInfo info)
+		{
+			if(IdeApp.Workbench.ActiveDocument == null)
+				info.Enabled = false;
+			else {
+				IZoomable zoom = IdeApp.Workbench.ActiveDocument.GetContent<IZoomable> ();
+
+				info.Enabled = zoom != null && zoom.EnableZoomIn;
+			}
+		}
+
+		protected override void Run ()
+		{
+			IZoomable zoom = IdeApp.Workbench.ActiveDocument.GetContent<IZoomable> ();
+			zoom.ZoomIn ();
+		}
+	}
+	// MonoDevelop.Ide.Commands.ViewCommands.ZoomOut
+	public class ZoomOut : CommandHandler
+	{
+		protected override void Update (CommandInfo info)
+		{
+			if(IdeApp.Workbench.ActiveDocument == null)
+				info.Enabled = false;
+			else {
+				IZoomable zoom = IdeApp.Workbench.ActiveDocument.GetContent<IZoomable> ();
+
+				info.Enabled = zoom != null && zoom.EnableZoomOut;
+			}
+		}
+
+		protected override void Run ()
+		{
+			IZoomable zoom = IdeApp.Workbench.ActiveDocument.GetContent<IZoomable> ();
+			zoom.ZoomOut ();
+		}
+	}
+	// MonoDevelop.Ide.Commands.ViewCommands.ZoomReset
+	public class ZoomReset : CommandHandler
+	{
+		protected override void Update (CommandInfo info)
+		{
+			if(IdeApp.Workbench.ActiveDocument == null)
+				info.Enabled = false;
+			else {
+				IZoomable zoom = IdeApp.Workbench.ActiveDocument.GetContent<IZoomable> ();
+
+				info.Enabled = zoom != null && zoom.EnableZoomReset;
+			}
+		}
+
+		protected override void Run ()
+		{
+			IZoomable zoom = IdeApp.Workbench.ActiveDocument.GetContent<IZoomable> ();
+			zoom.ZoomReset ();
+		}
+	}
+}
\ No newline at end of file