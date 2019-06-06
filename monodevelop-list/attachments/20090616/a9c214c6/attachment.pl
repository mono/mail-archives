Index: main/src/core/MonoDevelop.Ide/ChangeLog
===================================================================
--- main/src/core/MonoDevelop.Ide/ChangeLog	(revision 136205)
+++ main/src/core/MonoDevelop.Ide/ChangeLog	(working copy)
@@ -1,3 +1,6 @@
+2009-06-16  Viktoria Dudka  <viktoriad@remobjects.com>
+	* MonoDevelop.Ide.Commands\ToolsCommands.cs: Rewritten from scratch to make it non-GPL.
+
 2009-06-16  Mike Krüger  <mkrueger@novell.com>
 
 	* MonoDevelop.Ide.Gui/ProjectOperations.cs: Fixed "Bug 513383
Index: main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.Commands/ToolsCommands.cs
===================================================================
--- main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.Commands/ToolsCommands.cs	(revision 136205)
+++ main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.Commands/ToolsCommands.cs	(working copy)
@@ -1,119 +1,148 @@
-//  ToolsCommands.cs
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
-using System.CodeDom.Compiler;
-
-using MonoDevelop.Core;
-using MonoDevelop.Core.Execution;
-using Mono.Addins;
-using MonoDevelop.Components.Commands;
-
-using MonoDevelop.Core.Gui;
-using MonoDevelop.Ide.ExternalTools;
-using MonoDevelop.Ide.Gui;
-using MonoDevelop.Core.ProgressMonitoring;
-using MonoDevelop.Core.Gui.ProgressMonitoring;
-
-namespace MonoDevelop.Ide.Commands
-{
-	public enum ToolCommands
-	{
-		AddinManager,
-		ToolList
-	}
-	
-	internal class AddinManagerHandler: CommandHandler
-	{
-		protected override void Run ()
-		{
-			AddinUpdateHandler.ShowManager ();
-		}
-	}
-	
-	internal class ToolListHandler: CommandHandler
-	{
-		protected override void Update (CommandArrayInfo info)
-		{
-			for (int i = 0; i < ExternalToolService.Tools.Count; ++i) {
-				CommandInfo cmd = new CommandInfo (ExternalToolService.Tools[i].MenuCommand);
-				cmd.Description = GettextCatalog.GetString ("Start tool") + " " + String.Join(String.Empty, ExternalToolService.Tools[i].MenuCommand.Split('&'));
-				info.Add (cmd, ExternalToolService.Tools[i]);
-			}
-		}
-		
-		protected override void Run (object tool)
-		{
-			DispatchService.BackgroundDispatch (new StatefulMessageHandler (RunTool), tool);
-		}
-
-		private void RunTool (object ob)
-		{
-			ExternalTool tool = (ExternalTool) ob;
-			
-			// set the command
-			string command = tool.Command;
-			// set the args
-			string args = StringParserService.Parse(tool.Arguments);
-			// prompt for args if needed
-			if (tool.PromptForArguments) {
-				args = MessageService.GetTextResponse (
-					GettextCatalog.GetString ("Enter any arguments you want to use while launching tool, {0}:", tool.MenuCommand),
-					GettextCatalog.GetString ("Command Arguments for {0}", tool.MenuCommand), args);
-					
-				// if user selected cancel string will be null
-				if (args == null) {
-					args = StringParserService.Parse(tool.Arguments);
-				}
-			}
-			if (tool.SaveCurrentFile && MonoDevelop.Ide.Gui.IdeApp.Workbench.ActiveDocument != null)
-				MonoDevelop.Ide.Gui.IdeApp.Workbench.ActiveDocument.Save ();
-			
-			// create the process
-			IProgressMonitor monitor = IdeApp.Workbench.ProgressMonitors.GetRunProgressMonitor ();
-			monitor.Log.WriteLine ("Running: {0} {1} ...", command, args);
-			monitor.Log.WriteLine ();
-			
-			try {
-				ProcessWrapper p;
-				string workingDirectory = StringParserService.Parse(tool.InitialDirectory);
-				if (tool.UseOutputPad)
-					p = Runtime.ProcessService.StartProcess (command, args, workingDirectory, monitor.Log, monitor.Log, null);
-				else
-					p = Runtime.ProcessService.StartProcess (command, args, workingDirectory, null);
-
-				p.WaitForOutput ();
-				
-				monitor.Log.WriteLine ();
-				if (p.ExitCode == 0) {
-					monitor.Log.WriteLine ("Process '{0}' has completed succesfully.", p.ProcessName); 
-				} else {
-					monitor.Log.WriteLine ("Process '{0}' has exited with errorcode {1}.", p.ProcessName, p.ExitCode);
-				}
-				
-			} catch (Exception ex) {
-				monitor.ReportError (GettextCatalog.GetString ("External program execution failed.\nError while starting:\n '{0} {1}'", command, args), ex);
-			} finally {
-				monitor.Dispose ();
-			}
-		}
-	}
-}
+﻿// ToolsCommands.cs
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
+	public enum ToolCommands
+	{
+		AddinManager,
+		ToolList
+	}
+
+	internal class AddinManagerHandler : CommandHandler
+	{
+		protected override void Run ()
+		{
+			AddinUpdateHandler.ShowManager ();
+		}
+	}
+
+	internal class ToolListHandler : CommandHandler
+	{
+		protected override void Update (CommandArrayInfo info)
+		{
+			foreach(ExternalTools.ExternalTool externalTool in ExternalTools.ExternalToolService.Tools) {
+				//Create CommandInfo object
+				CommandInfo commandInfo = new CommandInfo ();
+				commandInfo.Text = externalTool.MenuCommand;
+				commandInfo.Description = GettextCatalog.GetString ("Start tool") + " " + externalTool.MenuCommand;
+
+				//Add menu item
+				info.Add (commandInfo, externalTool);
+
+			}
+		}
+
+		protected override void Run (object dataItem)
+		{
+			ExternalTools.ExternalTool externalTool = (ExternalTools.ExternalTool)dataItem;
+
+			DispatchService.BackgroundDispatch (new StatefulMessageHandler (RunExternalTool), (object)externalTool);
+		}
+
+		void RunExternalTool (object externalTool)
+		{
+			ExternalTools.ExternalTool tool = (ExternalTools.ExternalTool)externalTool;
+
+			String commandTool = StringParserService.Parse (tool.Command);
+			String argumentsTool = StringParserService.Parse (tool.Arguments);
+			String initialDirectoryTool = StringParserService.Parse (tool.InitialDirectory);
+
+			//Save current file checkbox
+			if(tool.SaveCurrentFile) {
+				if(IdeApp.Workbench.ActiveDocument != null) {
+					IdeApp.Workbench.ActiveDocument.Save ();
+				}
+			}
+
+			if(tool.PromptForArguments) {
+				String customerArguments = MessageService.GetTextResponse (GettextCatalog.GetString ("Enter any arguments you want to use while launching tool, {0}:", tool.MenuCommand),
+												GettextCatalog.GetString ("Command Arguments for {0}", tool.MenuCommand),
+												"");
+				if(customerArguments != String.Empty) {
+					argumentsTool = StringParserService.Parse (customerArguments);
+				}
+			}
+
+
+
+
+			//Execute tool
+			IProgressMonitor progressMonitor = IdeApp.Workbench.ProgressMonitors.GetRunProgressMonitor ();
+			try {
+				progressMonitor.Log.WriteLine (GettextCatalog.GetString ("Running: {0} {1}", (commandTool), (argumentsTool)));
+				progressMonitor.Log.WriteLine ();
+
+				ProcessWrapper processWrapper;
+				if(tool.UseOutputPad) {
+					processWrapper = Runtime.ProcessService.StartProcess (commandTool, argumentsTool, initialDirectoryTool, progressMonitor.Log, progressMonitor.Log, null);
+				}
+				else {
+					processWrapper = Runtime.ProcessService.StartProcess (commandTool, argumentsTool, initialDirectoryTool, null);
+				}
+
+				string processName = System.IO.Path.GetFileName (commandTool);
+				try {
+					processName = processWrapper.ProcessName;
+				}
+				catch(SystemException) {
+				}
+
+				processWrapper.WaitForOutput ();
+
+				if(processWrapper.ExitCode == 0) {
+					progressMonitor.Log.WriteLine (GettextCatalog.GetString ("Process '{0}' has completed succesfully", processName));
+				}
+				else {
+					progressMonitor.Log.WriteLine (GettextCatalog.GetString ("Process '{0}' has exited with error code {1}", processName, processWrapper.ExitCode));
+				}
+			}
+			catch(Exception ex) {
+				progressMonitor.ReportError (GettextCatalog.GetString ("External program execution failed.\nError while starting:\n '{0} {1}'", commandTool, argumentsTool), ex);
+			}
+			finally {
+				progressMonitor.Dispose ();
+			}
+
+		}
+	}
+}