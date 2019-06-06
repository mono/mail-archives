Index: main/src/core/MonoDevelop.Ide/ChangeLog
===================================================================
--- main/src/core/MonoDevelop.Ide/ChangeLog	(revision 136205)
+++ main/src/core/MonoDevelop.Ide/ChangeLog	(working copy)
@@ -1,3 +1,6 @@
+2009-06-17  Viktoria Dudka  <viktoriad@remobjects.com>
+	* MonoDevelop.Ide.Commands\ProjectCommands.cs: Rewritten from scratch to make it non-GPL.
+
 2009-06-16  Mike Krüger  <mkrueger@novell.com>
 
 	* MonoDevelop.Ide.Gui/ProjectOperations.cs: Fixed "Bug 513383
Index: main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.Commands/ProjectCommands.cs
===================================================================
--- main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.Commands/ProjectCommands.cs	(revision 136205)
+++ main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.Commands/ProjectCommands.cs	(working copy)
@@ -1,431 +1,455 @@
-//  ProjectCommands.cs
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
-using System.Threading;
-using System.Diagnostics;
-using MonoDevelop.Core;
-using MonoDevelop.Core.Execution;
-using MonoDevelop.Core.Gui;
-using MonoDevelop.Core.Gui.ProgressMonitoring;
-using MonoDevelop.Projects;
-using MonoDevelop.Components;
-using MonoDevelop.Ide.Gui;
-using MonoDevelop.Components.Commands;
-using CustomCommand = MonoDevelop.Projects.CustomCommand;
-
-namespace MonoDevelop.Ide.Commands
-{
-	public enum ProjectCommands
-	{
-		AddNewProject,
-		AddNewSolution,
-		AddNewWorkspace,
-		AddSolutionFolder,
-		AddProject,
-		AddItem,
-		RemoveFromProject,
-		Options,
-		AddReference,
-		AddNewFiles,
-		AddFiles,
-		NewFolder,
-		IncludeToProject,
-		Build,
-		BuildSolution,
-		Rebuild,
-		RebuildSolution,
-		SetAsStartupProject,
-		GenerateMakefiles,
-		RunEntry,
-		Run,
-		RunWithList,
-		IncludeInBuild,
-		IncludeInDeploy,
-		Deploy,
-		ConfigurationSelector,
-		Stop,
-		Clean,
-		CleanSolution,
-		LocalCopyReference,
-		DeployTargetList,
-		ConfigureDeployTargets,
-		CustomCommandList,
-		Reload,
-		ExportProject
-	}
-	
-	internal class RunHandler: CommandHandler
-	{
-		Document doc;
-		
-		protected override void Run ()
-		{
-			Run (new DefaultExecutionHandlerFactory ());
-		}
-		
-		protected override void Update (CommandInfo info)
-		{
-			info.Text = GettextCatalog.GetString ("_Run");
-			if (IdeApp.Workspace.IsOpen) {
-				if (!IdeApp.ProjectOperations.CurrentRunOperation.IsCompleted)
-					info.Text = GettextCatalog.GetString ("_Run again");
-			}
-			info.Enabled = CanRun (new DefaultExecutionHandlerFactory ());
-		}
-		
-		protected void Run (IExecutionHandler handler)
-		{
-			if (!IdeApp.ProjectOperations.CurrentRunOperation.IsCompleted) {
-				StopHandler.StopBuildOperations ();
-				IdeApp.ProjectOperations.CurrentRunOperation.WaitForCompleted ();
-			} 
-			if (IdeApp.Workspace.IsOpen) {
-				if (IdeApp.Preferences.BuildBeforeExecuting) {
-					IAsyncOperation op = IdeApp.ProjectOperations.Build (IdeApp.Workspace);
-					op.Completed += delegate { ExecuteCombine (op, handler); };
-				} else
-					IdeApp.ProjectOperations.Execute (IdeApp.Workspace, handler);
-			} else {
-				doc = IdeApp.Workbench.ActiveDocument;
-				if (doc != null) {
-					if (IdeApp.Preferences.BuildBeforeExecuting) {
-						IAsyncOperation op = doc.Build ();
-						op.Completed += delegate { ExecuteFile (op, doc, handler); };
-					} else {
-						doc.Run (handler);
-					}
-				}
-			}
-		}
-		
-		protected bool CanRun (IExecutionHandler handler)
-		{
-			if (IdeApp.Workspace.IsOpen)
-				return !(IdeApp.ProjectOperations.CurrentSelectedItem is Workspace) && IdeApp.ProjectOperations.CanExecute (IdeApp.Workspace, handler);
-			else
-				return IdeApp.Workbench.ActiveDocument != null && IdeApp.Workbench.ActiveDocument.CanRun (handler);
-		}
-		
-		void ExecuteCombine (IAsyncOperation op, IExecutionHandler handler)
-		{
-			if (op.SuccessWithWarnings && !IdeApp.Preferences.RunWithWarnings)
-				return;
-			if (op.Success)
-				IdeApp.ProjectOperations.Execute (IdeApp.Workspace, handler);
-		}
-		
-		void ExecuteFile (IAsyncOperation op, Document doc, IExecutionHandler handler)
-		{
-			if (op.SuccessWithWarnings && !IdeApp.Preferences.RunWithWarnings)
-				return;
-			if (op.Success)
-				doc.Run (handler);
-		}
-	}
-	
-	internal class RunWithHandler: RunHandler
-	{
-		protected override void Run (object dataItem)
-		{
-			Run ((IExecutionHandler) dataItem);
-		}
-
-		protected override void Update (CommandArrayInfo info)
-		{
-			foreach (IExecutionModeSet mset in Runtime.ProcessService.GetExecutionModes ()) {
-				foreach (IExecutionMode mode in mset.ExecutionModes) {
-					if (CanRun (mode.ExecutionHandler))
-						info.Add (mode.Name, mode.ExecutionHandler);
-				}
-				info.AddSeparator ();
-			}
-		}
-
-	}
-	
-	internal class RunEntryHandler: CommandHandler
-	{
-		protected override void Run ()
-		{
-			IBuildTarget entry = IdeApp.ProjectOperations.CurrentSelectedBuildTarget;
-			if (IdeApp.Preferences.BuildBeforeExecuting) {
-				IAsyncOperation op = IdeApp.ProjectOperations.Build (entry);
-				op.Completed += delegate {
-					if (op.SuccessWithWarnings && !IdeApp.Preferences.RunWithWarnings)
-						return;
-					if (op.Success)
-						IdeApp.ProjectOperations.Execute (entry);
-				};
-			} else
-				IdeApp.ProjectOperations.Execute (entry);
-		}
-		
-		protected override void Update (CommandInfo info)
-		{
-			IBuildTarget target = IdeApp.ProjectOperations.CurrentSelectedBuildTarget;
-			info.Enabled = target != null &&
-					!(target is Workspace) && IdeApp.ProjectOperations.CanExecute (target) &&
-					IdeApp.ProjectOperations.CurrentRunOperation.IsCompleted;
-		}
-	}
-	
-	internal class BuildHandler: CommandHandler
-	{
-		protected override void Run ()
-		{
-			if (IdeApp.Workspace.IsOpen) {
-				if (IdeApp.ProjectOperations.CurrentSelectedBuildTarget != null)
-					IdeApp.ProjectOperations.Build (IdeApp.ProjectOperations.CurrentSelectedBuildTarget);
-			}
-			else if (IdeApp.Workbench.ActiveDocument != null) {
-				IdeApp.Workbench.ActiveDocument.Save ();
-				IdeApp.Workbench.ActiveDocument.Build ();
-			}
-		}
-		
-		protected override void Update (CommandInfo info)
-		{
-			if (IdeApp.Workspace.IsOpen) {
-				IBuildTarget entry = IdeApp.ProjectOperations.CurrentSelectedBuildTarget;
-				if (entry != null) {
-					info.Enabled = IdeApp.ProjectOperations.CurrentBuildOperation.IsCompleted;
-					info.Text = GettextCatalog.GetString ("B_uild {0}", entry.Name);
-					if (entry is SolutionFolder)
-						info.Description = GettextCatalog.GetString ("Build solution {0}", entry.Name);
-					else if (entry is Project)
-						info.Description = GettextCatalog.GetString ("Build project {0}", entry.Name);
-					else
-						info.Description = GettextCatalog.GetString ("Build {0}", entry.Name);;
-				} else {
-					info.Enabled = false;
-				}
-			} else {
-				if (IdeApp.Workbench.ActiveDocument != null && IdeApp.Workbench.ActiveDocument.IsBuildTarget) {
-					info.Enabled = IdeApp.ProjectOperations.CurrentBuildOperation.IsCompleted;
-					string file = Path.GetFileName (IdeApp.Workbench.ActiveDocument.Name);
-					info.Text = GettextCatalog.GetString ("B_uild {0}", file);
-					info.Description = GettextCatalog.GetString ("Build {0}", file);
-				} else {
-					info.Enabled = false;
-				}
-			}
-		}
-	}
-	
-	
-	internal class RebuildHandler: CommandHandler
-	{
-		protected override void Run ()
-		{
-			if (IdeApp.Workspace.IsOpen) {
-				if (IdeApp.ProjectOperations.CurrentSelectedBuildTarget != null)
-					IdeApp.ProjectOperations.Rebuild (IdeApp.ProjectOperations.CurrentSelectedBuildTarget);
-			}
-			else if (IdeApp.Workbench.ActiveDocument != null) {
-				IdeApp.Workbench.ActiveDocument.Save ();
-				IdeApp.Workbench.ActiveDocument.Build ();
-			}
-		}
-		
-		protected override void Update (CommandInfo info)
-		{
-			if (IdeApp.Workspace.IsOpen) {
-				IBuildTarget entry = IdeApp.ProjectOperations.CurrentSelectedBuildTarget;
-				if (entry != null) {
-					info.Enabled = IdeApp.ProjectOperations.CurrentBuildOperation.IsCompleted;
-					info.Text = GettextCatalog.GetString ("R_ebuild {0}", entry.Name);
-					info.Description = GettextCatalog.GetString ("Rebuild {0}", entry.Name);
-				} else {
-					info.Enabled = false;
-				}
-			} else {
-				if (IdeApp.Workbench.ActiveDocument != null && IdeApp.Workbench.ActiveDocument.IsBuildTarget) {
-					info.Enabled = IdeApp.ProjectOperations.CurrentBuildOperation.IsCompleted;
-					string file = Path.GetFileName (IdeApp.Workbench.ActiveDocument.Name);
-					info.Text = GettextCatalog.GetString ("R_ebuild {0}", file);
-					info.Description = GettextCatalog.GetString ("Rebuild {0}", file);
-				} else {
-					info.Enabled = false;
-				}
-			}
-		}
-	}
-	
-	internal class BuildSolutionHandler: CommandHandler
-	{
-		protected override void Run ()
-		{
-			IdeApp.ProjectOperations.Build (IdeApp.Workspace);
-		}
-		
-		protected override void Update (CommandInfo info)
-		{
-			info.Enabled = IdeApp.ProjectOperations.CurrentBuildOperation.IsCompleted &&
-							(IdeApp.Workspace.IsOpen);
-		}
-	}
-	
-	internal class RebuildSolutionHandler: CommandHandler
-	{
-		protected override void Run ()
-		{
-			IdeApp.ProjectOperations.Rebuild (IdeApp.Workspace);
-		}
-		
-		protected override void Update (CommandInfo info)
-		{
-			info.Enabled = IdeApp.ProjectOperations.CurrentBuildOperation.IsCompleted &&
-							(IdeApp.Workspace.IsOpen);
-		}
-	}
-	
-	internal class CleanSolutionHandler: CommandHandler
-	{
-		protected override void Run ()
-		{
-			IdeApp.ProjectOperations.Clean (IdeApp.Workspace);
-		}
-		
-		protected override void Update (CommandInfo info)
-		{
-			info.Enabled = IdeApp.Workspace.IsOpen;
-		}
-	}
-	
-	internal class CleanHandler: CommandHandler
-	{
-		protected override void Run ()
-		{
-			IdeApp.ProjectOperations.Clean (IdeApp.ProjectOperations.CurrentSelectedBuildTarget);
-		}
-		
-		protected override void Update (CommandInfo info)
-		{
-			if (IdeApp.ProjectOperations.CurrentSelectedBuildTarget != null) {
-				info.Text = GettextCatalog.GetString ("C_lean {0}", IdeApp.ProjectOperations.CurrentSelectedBuildTarget.Name);
-				info.Description = GettextCatalog.GetString ("Clean {0}", IdeApp.ProjectOperations.CurrentSelectedBuildTarget.Name);
-			} else {
-				info.Enabled = false;
-			}
-		}
-	}
-	
-	public class StopHandler: CommandHandler
-	{
-		public static void StopBuildOperations ()
-		{
-			if (!IdeApp.ProjectOperations.CurrentBuildOperation.IsCompleted)
-				IdeApp.ProjectOperations.CurrentBuildOperation.Cancel ();
-			if (!IdeApp.ProjectOperations.CurrentRunOperation.IsCompleted)
-				IdeApp.ProjectOperations.CurrentRunOperation.Cancel ();
-		}
-		
-		protected override void Run ()
-		{
-			StopBuildOperations ();
-		}
-		
-		protected override void Update (CommandInfo info)
-		{
-			info.Enabled = !IdeApp.ProjectOperations.CurrentBuildOperation.IsCompleted ||
-							!IdeApp.ProjectOperations.CurrentRunOperation.IsCompleted;
-		}
-	}
-	
-	internal class SolutionItemOptionsHandler: CommandHandler
-	{
-		protected override void Run ()
-		{
-			IBuildTarget ce = IdeApp.ProjectOperations.CurrentSelectedBuildTarget;
-			if (ce != null)
-				IdeApp.ProjectOperations.ShowOptions (ce);
-		}
-		
-		protected override void Update (CommandInfo info)
-		{
-			info.Enabled = IdeApp.ProjectOperations.CurrentSelectedBuildTarget != null;
-		}
-	}
-	
-	internal class CustomCommandListHandler: CommandHandler
-	{
-		protected override void Run (object c)
-		{
-			IWorkspaceObject ce = IdeApp.ProjectOperations.CurrentSelectedBuildTarget;
-			CustomCommand cmd = (CustomCommand) c;
-			IProgressMonitor monitor = IdeApp.Workbench.ProgressMonitors.GetRunProgressMonitor ();
-			
-			Thread t = new Thread (
-				delegate () {
-					using (monitor) {
-						cmd.Execute (monitor, ce, IdeApp.Workspace.ActiveConfiguration);
-					}
-				}
-			);
-			t.IsBackground = true;
-			t.Start ();
-		}
-		
-		protected override void Update (CommandArrayInfo info)
-		{
-			IConfigurationTarget ce = IdeApp.ProjectOperations.CurrentSelectedBuildTarget as IConfigurationTarget;
-			if (ce != null) {
-				ItemConfiguration conf = ce.DefaultConfiguration;
-				if (conf != null) {
-					foreach (CustomCommand cmd in conf.CustomCommands)
-						if (cmd.Type == CustomCommandType.Custom)
-							info.Add (cmd.Name, cmd);
-				}
-			}
-		}
-	}
-	
-	internal class ExportProjectHandler: CommandHandler
-	{
-		protected override void Run ()
-		{
-			IWorkspaceObject ce = IdeApp.ProjectOperations.CurrentSelectedItem as IWorkspaceObject;
-			IdeApp.ProjectOperations.Export (ce, null);
-		}
-		
-		protected override void Update (CommandInfo info)
-		{
-			info.Enabled = IdeApp.ProjectOperations.CurrentSelectedItem is WorkspaceItem || IdeApp.ProjectOperations.CurrentSelectedItem is SolutionEntityItem;
-		}
-
-	}
-	
-	internal class EditReferencesHandler: CommandHandler
-	{
-		protected override void Run ()
-		{
-			DotNetProject p = IdeApp.ProjectOperations.CurrentSelectedProject as DotNetProject;
-			if (p != null && IdeApp.ProjectOperations.AddReferenceToProject (p))
-				IdeApp.ProjectOperations.Save (p);
-		}
-		
-		protected override void Update (CommandInfo info)
-		{
-			info.Bypass = !(info.Enabled = IdeApp.ProjectOperations.CurrentSelectedProject is DotNetProject);
-		}
-	}
-}
+// ProjectCommands.cs
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
+using MonoDevelop.Core.Execution;
+
+namespace MonoDevelop.Ide.Commands
+{
+	public enum ProjectCommands
+	{
+		AddNewProject,
+		AddNewWorkspace,
+		AddNewSolution,
+		AddSolutionFolder,
+		AddProject,
+		AddItem,
+		RemoveFromProject,
+		Options,
+		AddReference,
+		AddNewFiles,
+		AddFiles,
+		NewFolder,
+		IncludeToProject,
+		BuildSolution,
+		Build,
+		RebuildSolution,
+		Rebuild,
+		SetAsStartupProject,
+		Run,
+		RunWithList,
+		RunEntry,
+		Clean,
+		CleanSolution,
+		LocalCopyReference,
+		Stop,
+		ConfigurationSelector,
+		CustomCommandList,
+		Reload,
+		ExportProject
+	}
+
+	internal class SolutionItemOptionsHandler : CommandHandler
+	{
+		protected override void Update (CommandInfo info)
+		{
+			if(IdeApp.ProjectOperations.CurrentSelectedBuildTarget == null)
+				info.Enabled = false;
+		}
+
+		protected override void Run ()
+		{
+			IdeApp.ProjectOperations.ShowOptions (IdeApp.ProjectOperations.CurrentSelectedBuildTarget);
+		}
+	}
+
+	internal class EditReferencesHandler : CommandHandler
+	{
+		protected override void Update (CommandInfo info)
+		{
+			if(!(IdeApp.ProjectOperations.CurrentSelectedProject is DotNetProject)) {
+				info.Enabled = false;
+				info.Bypass = true;
+			}
+			else
+				info.Bypass = false;
+		}
+
+		protected override void Run ()
+		{
+			//Edit references
+			IdeApp.ProjectOperations.AddReferenceToProject (IdeApp.ProjectOperations.CurrentSelectedProject as DotNetProject);
+			IdeApp.ProjectOperations.Save (IdeApp.ProjectOperations.CurrentSelectedProject);
+
+		}
+	}
+
+	internal class BuildSolutionHandler : CommandHandler
+	{
+		protected override void Update (CommandInfo info)
+		{
+			info.Enabled = ((IdeApp.Workspace.IsOpen) && (IdeApp.ProjectOperations.CurrentBuildOperation.IsCompleted));
+		}
+
+		protected override void Run ()
+		{
+			//Build solution
+			IdeApp.ProjectOperations.Build (IdeApp.Workspace);
+		}
+	}
+
+	internal class BuildHandler : CommandHandler
+	{
+		protected override void Update (CommandInfo info)
+		{
+			if(IdeApp.Workspace.IsOpen) {
+				IBuildTarget buildTarget = IdeApp.ProjectOperations.CurrentSelectedBuildTarget;
+				info.Enabled = ((buildTarget != null) && (IdeApp.ProjectOperations.CurrentBuildOperation.IsCompleted));
+				if(info.Enabled) {
+					info.Text = GettextCatalog.GetString ("B_uild {0}", IdeApp.ProjectOperations.CurrentSelectedBuildTarget.Name);
+					info.Description = GettextCatalog.GetString ("Build {0}", IdeApp.ProjectOperations.CurrentSelectedBuildTarget.Name);
+				}
+			}
+			else {
+				info.Enabled = ((IdeApp.Workbench.ActiveDocument != null) && (IdeApp.Workbench.ActiveDocument.IsBuildTarget) && (IdeApp.ProjectOperations.CurrentBuildOperation.IsCompleted));
+				if(info.Enabled) {
+					info.Text = GettextCatalog.GetString ("B_uild {0}", IdeApp.Workbench.ActiveDocument.FileName);
+					info.Description = GettextCatalog.GetString ("Build {0}", IdeApp.Workbench.ActiveDocument.FileName);
+				}
+			}
+		}
+
+		protected override void Run ()
+		{
+			if(IdeApp.Workspace.IsOpen) {
+				IdeApp.ProjectOperations.Build (IdeApp.ProjectOperations.CurrentSelectedBuildTarget);
+			}
+			else {
+				IdeApp.Workbench.ActiveDocument.Save ();
+				IdeApp.Workbench.ActiveDocument.Build ();
+			}
+		}
+	}
+
+	internal class RebuildSolutionHandler : CommandHandler
+	{
+		protected override void Update (CommandInfo info)
+		{
+			info.Enabled = ((IdeApp.Workspace.IsOpen) && (IdeApp.ProjectOperations.CurrentBuildOperation.IsCompleted));
+		}
+
+		protected override void Run ()
+		{
+			//Build solution
+			IdeApp.ProjectOperations.Rebuild (IdeApp.Workspace);
+		}
+	}
+
+	internal class RebuildHandler : CommandHandler
+	{
+		protected override void Update (CommandInfo info)
+		{
+			if(IdeApp.Workspace.IsOpen) {
+				IBuildTarget buildTarget = IdeApp.ProjectOperations.CurrentSelectedBuildTarget;
+				info.Enabled = ((buildTarget != null) && (IdeApp.ProjectOperations.CurrentBuildOperation.IsCompleted));
+				if(info.Enabled) {
+					info.Text = GettextCatalog.GetString ("R_ebuild {0}", IdeApp.ProjectOperations.CurrentSelectedBuildTarget.Name);
+					info.Description = GettextCatalog.GetString ("Rebuild {0}", IdeApp.ProjectOperations.CurrentSelectedBuildTarget.Name);
+				}
+			}
+			else {
+				info.Enabled = ((IdeApp.Workbench.ActiveDocument != null) && (IdeApp.Workbench.ActiveDocument.IsBuildTarget) && (IdeApp.ProjectOperations.CurrentBuildOperation.IsCompleted));
+				if(info.Enabled) {
+					info.Text = GettextCatalog.GetString ("R_ebuild {0}", IdeApp.Workbench.ActiveDocument.FileName);
+					info.Description = GettextCatalog.GetString ("Rebuild {0}", IdeApp.Workbench.ActiveDocument.FileName);
+				}
+			}
+		}
+
+		protected override void Run ()
+		{
+			if(IdeApp.Workspace.IsOpen) {
+				IdeApp.ProjectOperations.Rebuild (IdeApp.ProjectOperations.CurrentSelectedBuildTarget);
+			}
+			else {
+				IdeApp.Workbench.ActiveDocument.Save ();
+				IdeApp.Workbench.ActiveDocument.Rebuild ();
+			}
+		}
+	}
+
+	internal class RunHandler : CommandHandler
+	{
+		internal static readonly DefaultExecutionHandlerFactory handlerFactory = new DefaultExecutionHandlerFactory ();
+		protected override void Update (CommandInfo info)
+		{
+			if((IdeApp.Workspace.IsOpen) && (IdeApp.ProjectOperations.CurrentRunOperation.IsCompleted))
+				info.Text = GettextCatalog.GetString ("_Run again");
+			else
+				info.Text = GettextCatalog.GetString ("_Run");
+
+			if((IdeApp.ProjectOperations.CanExecute (IdeApp.Workspace, handlerFactory)) && (!(IdeApp.ProjectOperations.CurrentSelectedItem is Workspace)))
+				info.Enabled = true;
+			else
+				info.Enabled = ((IdeApp.Workbench.ActiveDocument != null) && (IdeApp.Workbench.ActiveDocument.CanRun (handlerFactory)));
+
+		}
+
+		protected override void Run ()
+		{
+			if(!IdeApp.ProjectOperations.CurrentRunOperation.IsCompleted) {
+				StopHandler.StopBuildOperations ();
+				IdeApp.ProjectOperations.CurrentRunOperation.WaitForCompleted ();
+			}
+
+			if(!IdeApp.Workspace.IsOpen) {
+				if(!IdeApp.Preferences.BuildBeforeExecuting)
+					IdeApp.Workbench.ActiveDocument.Run (handlerFactory);
+				else {
+					IAsyncOperation asyncOperation = IdeApp.Workbench.ActiveDocument.Build ();
+					asyncOperation.Completed += delegate
+					{
+						if((asyncOperation.Success) || (IdeApp.Preferences.RunWithWarnings && asyncOperation.SuccessWithWarnings))
+							IdeApp.Workbench.ActiveDocument.Run (handlerFactory);
+					};
+				}
+			}
+			else {
+				if(!IdeApp.Preferences.BuildBeforeExecuting)
+					IdeApp.ProjectOperations.Execute (IdeApp.Workspace, handlerFactory);
+				else {
+					IAsyncOperation asyncOperation = IdeApp.ProjectOperations.Build (IdeApp.ProjectOperations.CurrentSelectedBuildTarget);
+					asyncOperation.Completed += delegate
+					{
+						if((asyncOperation.Success) || (IdeApp.Preferences.RunWithWarnings && asyncOperation.SuccessWithWarnings))
+							IdeApp.ProjectOperations.Execute (IdeApp.Workspace, handlerFactory);
+					};
+				}
+
+			}
+		}
+
+	}
+
+	internal class RunWithHandler : CommandHandler
+	{
+		protected override void Update (CommandArrayInfo info)
+		{
+			foreach(IExecutionModeSet modeSet in Runtime.ProcessService.GetExecutionModes ()) {
+
+				int i = 0;
+
+				foreach(IExecutionMode mode in modeSet.ExecutionModes) {
+					CommandInfo commandInfo = new CommandInfo ();
+					commandInfo.Text = mode.Name;
+
+					if((IdeApp.ProjectOperations.CanExecute (IdeApp.Workspace, mode.ExecutionHandler)) && (!(IdeApp.ProjectOperations.CurrentSelectedItem is Workspace)))
+						info.Add (commandInfo, mode.ExecutionHandler);
+					else
+						if((IdeApp.Workbench.ActiveDocument != null) && (IdeApp.Workbench.ActiveDocument.CanRun (mode.ExecutionHandler)))
+							info.Add (commandInfo, mode.ExecutionHandler);
+
+					i++;
+				}
+
+				if(i > 0)
+					info.AddSeparator ();
+			}
+
+			if(info.Count == 0)
+				info.DefaultCommandInfo.Enabled = false;
+
+		}
+
+		protected override void Run (object dataItem)
+		{
+			IExecutionHandler executionHandler = (IExecutionHandler)dataItem;
+
+			if(!IdeApp.ProjectOperations.CurrentRunOperation.IsCompleted) {
+				StopHandler.StopBuildOperations ();
+				IdeApp.ProjectOperations.CurrentRunOperation.WaitForCompleted ();
+			}
+
+			if(!IdeApp.Workspace.IsOpen) {
+				if(!IdeApp.Preferences.BuildBeforeExecuting)
+					IdeApp.Workbench.ActiveDocument.Run (executionHandler);
+				else {
+					IAsyncOperation asyncOperation = IdeApp.Workbench.ActiveDocument.Build ();
+					asyncOperation.Completed += delegate {
+						if((asyncOperation.Success) || (IdeApp.Preferences.RunWithWarnings && asyncOperation.SuccessWithWarnings))
+							IdeApp.Workbench.ActiveDocument.Run (executionHandler);
+					};
+
+				}
+			}
+			else {
+				if(!IdeApp.Preferences.BuildBeforeExecuting)
+					IdeApp.ProjectOperations.Execute (IdeApp.Workspace, executionHandler);
+				else {
+					IAsyncOperation asyncOperation = IdeApp.ProjectOperations.Build (IdeApp.ProjectOperations.CurrentSelectedBuildTarget);
+					asyncOperation.Completed += delegate
+					{
+						if((asyncOperation.Success) || (IdeApp.Preferences.RunWithWarnings && asyncOperation.SuccessWithWarnings))
+							IdeApp.ProjectOperations.Execute (IdeApp.Workspace, executionHandler);
+					};
+				}
+
+			}
+		}
+	}
+
+	internal class RunEntryHandler : CommandHandler
+	{
+		protected override void Update (CommandInfo info)
+		{
+			IBuildTarget buildTarget = IdeApp.ProjectOperations.CurrentSelectedBuildTarget;
+			info.Enabled = ((buildTarget != null) && (!(buildTarget is Workspace)) && IdeApp.ProjectOperations.CanExecute (buildTarget) && IdeApp.ProjectOperations.CurrentRunOperation.IsCompleted);
+		}
+
+		protected override void Run ()
+		{
+			if(!IdeApp.Preferences.BuildBeforeExecuting)
+				IdeApp.ProjectOperations.Execute (IdeApp.Workspace, RunHandler.handlerFactory);
+			else {
+				IAsyncOperation asyncOperation = IdeApp.ProjectOperations.Build (IdeApp.ProjectOperations.CurrentSelectedBuildTarget);
+				asyncOperation.Completed += new OperationHandler (IsRunCompletedMethoWorkspaced);
+			}
+		}
+
+		void IsRunCompletedMethoWorkspaced (IAsyncOperation asyncOperation)
+		{
+			if((asyncOperation.Success) || (IdeApp.Preferences.RunWithWarnings && asyncOperation.SuccessWithWarnings))
+				IdeApp.ProjectOperations.Execute (IdeApp.Workspace, RunHandler.handlerFactory);
+		}
+	}
+
+	internal class CleanHandler : CommandHandler
+	{
+		protected override void Update (CommandInfo info)
+		{
+			if(IdeApp.ProjectOperations.CurrentSelectedBuildTarget == null)
+				info.Enabled = false;
+			else {
+				info.Text = GettextCatalog.GetString ("C_lean {0}", IdeApp.ProjectOperations.CurrentSelectedBuildTarget.Name);
+				info.Description = GettextCatalog.GetString ("Clean {0}", IdeApp.ProjectOperations.CurrentSelectedBuildTarget.Name);
+			}
+		}
+
+		protected override void Run ()
+		{
+			IdeApp.ProjectOperations.Clean (IdeApp.ProjectOperations.CurrentSelectedBuildTarget);
+		}
+	}
+
+	internal class CleanSolutionHandler : CommandHandler
+	{
+		protected override void Update (CommandInfo info)
+		{
+			if(!IdeApp.Workspace.IsOpen)
+				info.Enabled = false;
+		}
+
+		protected override void Run ()
+		{
+			IdeApp.ProjectOperations.Clean (IdeApp.Workspace);
+		}
+	}
+
+	public class StopHandler : CommandHandler
+	{
+		protected override void Update (CommandInfo info)
+		{
+			if((IdeApp.ProjectOperations.CurrentBuildOperation.IsCompleted) && (IdeApp.ProjectOperations.CurrentRunOperation.IsCompleted))
+				info.Enabled = false;
+		}
+
+		protected override void Run ()
+		{
+			if(!IdeApp.ProjectOperations.CurrentBuildOperation.IsCompleted)
+				IdeApp.ProjectOperations.CurrentBuildOperation.Cancel ();
+			if(!IdeApp.ProjectOperations.CurrentRunOperation.IsCompleted)
+				IdeApp.ProjectOperations.CurrentRunOperation.Cancel ();
+		}
+		public static void StopBuildOperations ()
+		{
+			if(!IdeApp.ProjectOperations.CurrentBuildOperation.IsCompleted)
+				IdeApp.ProjectOperations.CurrentBuildOperation.Cancel ();
+			if(!IdeApp.ProjectOperations.CurrentRunOperation.IsCompleted)
+				IdeApp.ProjectOperations.CurrentRunOperation.Cancel ();
+		}
+	}
+
+	internal class CustomCommandListHandler : CommandHandler
+	{
+		protected override void Update (CommandArrayInfo info)
+		{
+			IBuildTarget buildTarget = IdeApp.ProjectOperations.CurrentSelectedBuildTarget;
+
+			if((buildTarget is IConfigurationTarget) && (((IConfigurationTarget)buildTarget).DefaultConfiguration != null)) {
+				foreach(Projects.CustomCommand customCommand in ((IConfigurationTarget)buildTarget).DefaultConfiguration.CustomCommands) {
+					if(customCommand.Type == CustomCommandType.Custom) {
+						CommandInfo commandInfo = new CommandInfo ();
+						commandInfo.Text = customCommand.Name;
+						//commandInfo.Description = customCommand.Name;
+
+						info.Add (commandInfo, customCommand);
+					}
+				}
+			}
+		}
+
+		protected override void Run (object dataItem)
+		{
+			IProgressMonitor progressMonitor = IdeApp.Workbench.ProgressMonitors.GetRunProgressMonitor ();
+			IBuildTarget buildTarget = IdeApp.ProjectOperations.CurrentSelectedBuildTarget;
+
+			Projects.CustomCommand customCommand = (Projects.CustomCommand)dataItem;
+			System.Threading.ThreadPool.QueueUserWorkItem (delegate
+			{
+				using (progressMonitor)
+					customCommand.Execute (progressMonitor, null, null);
+			});
+
+		}
+	}
+
+	internal class ExportProjectHandler : CommandHandler
+	{
+		protected override void Update (CommandInfo info)
+		{
+			if(!(IdeApp.ProjectOperations.CurrentSelectedItem is WorkspaceItem) && !(IdeApp.ProjectOperations.CurrentSelectedItem is SolutionEntityItem))
+				info.Enabled = false;
+		}
+
+		protected override void Run ()
+		{
+			IdeApp.ProjectOperations.Export (((IWorkspaceObject)IdeApp.ProjectOperations.CurrentSelectedItem), null);
+		}
+	}
+}