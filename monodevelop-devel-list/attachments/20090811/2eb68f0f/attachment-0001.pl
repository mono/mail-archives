Index: main/src/core/MonoDevelop.Projects/ChangeLog
===================================================================
--- main/src/core/MonoDevelop.Projects/ChangeLog	(revision 139704)
+++ main/src/core/MonoDevelop.Projects/ChangeLog	(working copy)
@@ -1,3 +1,7 @@
+2009-08-11  Viktoria Dudka  <viktoriad@remobjects.com>
+
+	* MonoDevelop.Projects/DotNetProject.cs: Rewritten GPL parts.
+
 2009-08-11  Lluis Sanchez Gual  <lluis@novell.com>
 
 	* MonoDevelop.Projects/ProjectConvertTool.cs: Allow converting
Index: main/src/core/MonoDevelop.Projects/MonoDevelop.Projects/DotNetProject.cs
===================================================================
--- main/src/core/MonoDevelop.Projects/MonoDevelop.Projects/DotNetProject.cs	(revision 139714)
+++ main/src/core/MonoDevelop.Projects/MonoDevelop.Projects/DotNetProject.cs	(working copy)
@@ -1,22 +1,29 @@
-//  DotNetProject.cs
+//  DotNetProject.cs
+//
+// Author:
+//   MonoDevelop Team
+//
+// Copyright (c) 2009 MonoDevelop Team
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
 //
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
 
 using System;
 using System.CodeDom.Compiler;
@@ -45,10 +52,101 @@
 {
 	[DataInclude (typeof(DotNetProjectConfiguration))]
 	public class DotNetProject : Project
-	{
-		string language;
+	{
+        public DotNetProject ()
+        {
+            Runtime.SystemAssemblyService.DefaultRuntimeChanged += RuntimeSystemAssemblyServiceDefaultRuntimeChanged;
+            projectReferences = new ProjectReferenceCollection ();
+            Items.Bind (projectReferences);
+            if (IsLibraryBasedProjectType)
+                CompileTarget = CompileTarget.Library;
+            FileService.FileRemoved += OnFileRemoved;
+        }
+
+        public DotNetProject (string languageName)
+            : this ()
+        {
+            this.languageName = languageName;
+            this.languageBinding = FindLanguage (languageName);
+
+            if (this.languageBinding != null)
+                this.StockIcon = this.languageBinding.ProjectStockIcon;
+
+            this.usePartialTypes = SupportsPartialTypes;
+        }
+
+        public DotNetProject (string languageName, ProjectCreateInformation projectCreateInfo, XmlElement projectOptions)
+            : this (languageName)
+        {
+            if (this.LanguageBinding != null) {
+                LanguageParameters = languageBinding.CreateProjectParameters (projectOptions);
+
+                if (projectOptions != null)
+                    projectOptions.SetAttribute ("DefineDebug", "True");
+                DotNetProjectConfiguration configDebug = CreateConfiguration ("Debug") as DotNetProjectConfiguration;
+                configDebug.CompilationParameters = languageBinding.CreateCompilationParameters (projectOptions);
+                configDebug.DebugMode = true;
+                Configurations.Add (configDebug);
+
+                DotNetProjectConfiguration configRelease = CreateConfiguration ("Release") as DotNetProjectConfiguration;
+                if (projectOptions != null)
+                    projectOptions.SetAttribute ("DefineDebug", "False");
+                configRelease.CompilationParameters = languageBinding.CreateCompilationParameters (projectOptions);
+                configRelease.DebugMode = false;
+                Configurations.Add (configRelease);
+            }
+
+            if ((projectOptions != null) && (projectOptions.Attributes["Target"] != null))
+                CompileTarget = (CompileTarget)Enum.Parse (typeof (CompileTarget), projectOptions.Attributes["Target"].Value);
+            else if (IsLibraryBasedProjectType)
+                CompileTarget = CompileTarget.Library;
+
+            if ((projectOptions != null) && (projectOptions.Attributes["TargetFrameworkVersion"] != null))
+                targetFrameworkVersion = projectOptions.Attributes["TargetFrameworkVersion"].Value;
+
+            string binPath;
+            if (projectCreateInfo != null) {
+                Name = projectCreateInfo.ProjectName;
+                binPath = projectCreateInfo.BinPath;
+            }
+            else
+                binPath = ".";
+
+            foreach (DotNetProjectConfiguration dotNetProjectConfig in Configurations) {
+                dotNetProjectConfig.OutputDirectory = Path.Combine (binPath, dotNetProjectConfig.Id);
+
+                if ((projectOptions != null) && (projectOptions.Attributes["PauseConsoleOutput"] != null))
+                    dotNetProjectConfig.PauseConsoleOutput = Boolean.Parse (projectOptions.Attributes["PauseConsoleOutput"].Value);
+
+                if (projectCreateInfo != null)
+                    dotNetProjectConfig.OutputAssembly = projectCreateInfo.ProjectName;
+            }
+        }
+
+        public override string ProjectType
+        {
+            get { return "DotNet"; }
+        }
+
+        private Ambience ambience;
+        public override Ambience Ambience
+        {
+            get
+            {
+                if (ambience == null)
+                    ambience = AmbienceService.GetAmbienceForLanguage (LanguageName);
+                return ambience;
+            }
+        }
+
+        private string languageName;
+        public string LanguageName
+        {
+            get { return languageName; }
+        }
+
+
 		bool usePartialTypes = true;
-		Ambience ambience;
 		ProjectParameters languageParameters;
 		
 		[ItemProperty ("OutputType")]
@@ -59,27 +157,12 @@
 		protected ProjectReferenceCollection projectReferences;
 
 		[ItemProperty ("RootNamespace", DefaultValue="")]
-		protected string defaultNamespace = String.Empty;
-		
-		public override string ProjectType {
-			get { return "DotNet"; }
-		}
-		
-		public override Ambience Ambience {
-			get {
-				if (ambience == null)
-					ambience = AmbienceService.GetAmbienceForLanguage (LanguageName);
-				return ambience;
-			}
-		}
-		
-		public string LanguageName {
-			get { return language; }
-		}
-		
+		protected string defaultNamespace = String.Empty;
+
+        
 		public override string [] SupportedLanguages {
-			get {
-				return new string [] { "", language };
+			get {
+                return new string[] { "", languageName };
 			}
 		}
 		
@@ -95,8 +178,8 @@
 		
 		public IDotNetLanguageBinding LanguageBinding {
 			get {
-				if (languageBinding == null) {
-					languageBinding = FindLanguage (language);
+				if (languageBinding == null) {
+                    languageBinding = FindLanguage (languageName);
 					
 					//older projects may not have this property but may not support partial types
 					//so need to verify that the default attribute is OK
@@ -248,82 +331,8 @@
 			set { usePartialTypes = value; }
 		}
 		
-		public DotNetProject ()
-		{
-			Runtime.SystemAssemblyService.DefaultRuntimeChanged += RuntimeSystemAssemblyServiceDefaultRuntimeChanged;
-			projectReferences = new ProjectReferenceCollection ();
-			Items.Bind (projectReferences);
-			if (IsLibraryBasedProjectType)
-				CompileTarget = CompileTarget.Library;
-			FileService.FileRemoved += OnFileRemoved;
-		}
 		
-		public DotNetProject (string languageName): this ()
-		{
-			language = languageName;
-			languageBinding = FindLanguage (language);
-			if (languageBinding != null)
-				this.StockIcon = languageBinding.ProjectStockIcon;
-			this.usePartialTypes = SupportsPartialTypes;
-		}
 		
-		public DotNetProject (string languageName, ProjectCreateInformation info, XmlElement projectOptions): this ()
-		{
-			// Language name must be set before the item handler is assigned
-			language = languageName;
-			languageBinding = FindLanguage (language);
-			
-			string binPath;
-			if (info != null) {
-				Name = info.ProjectName;
-				binPath = info.BinPath;
-			} else {
-				binPath = ".";
-			}
-			
-			if (languageBinding != null) {
-				this.StockIcon = languageBinding.ProjectStockIcon;
-				LanguageParameters = languageBinding.CreateProjectParameters (projectOptions);
-				if (projectOptions != null)
-					projectOptions.SetAttribute ("DefineDebug", "True");
-				DotNetProjectConfiguration configuration = (DotNetProjectConfiguration) CreateConfiguration ("Debug");
-				configuration.CompilationParameters = languageBinding.CreateCompilationParameters (projectOptions);
-				configuration.DebugMode = true;
-				Configurations.Add (configuration);
-				
-				configuration = (DotNetProjectConfiguration) CreateConfiguration ("Release");
-				configuration.DebugMode = false;
-				if (projectOptions != null)
-					projectOptions.SetAttribute ("DefineDebug", "False");
-				configuration.CompilationParameters = languageBinding.CreateCompilationParameters (projectOptions);
-				Configurations.Add (configuration);
-			}
-			
-			if (projectOptions != null && projectOptions.Attributes["Target"] != null) {
-				compileTarget = (CompileTarget) Enum.Parse(typeof(CompileTarget), projectOptions.Attributes["Target"].InnerText);
-			} else if (IsLibraryBasedProjectType) {
-				CompileTarget = CompileTarget.Library;
-			}
-			
-			if (projectOptions != null && projectOptions.Attributes["TargetFrameworkVersion"] != null) {
-				targetFrameworkVersion = projectOptions.Attributes["TargetFrameworkVersion"].InnerText;
-			}
-			
-			foreach (DotNetProjectConfiguration parameter in Configurations) {
-				parameter.OutputDirectory = Path.Combine (binPath, parameter.Id);
-				if (info != null)
-					parameter.OutputAssembly  = info.ProjectName;
-				
-				if (projectOptions != null) {
-					if (projectOptions.Attributes["PauseConsoleOutput"] != null) {
-						parameter.PauseConsoleOutput = Boolean.Parse(projectOptions.Attributes["PauseConsoleOutput"].InnerText);
-					}
-				}
-			}
-			
-			this.usePartialTypes = SupportsPartialTypes;
-		}
-		
 		public override void Dispose ()
 		{
 			base.Dispose ();
@@ -358,11 +367,6 @@
 			}
 		}
 		
-		void OnFileRemoved (object o, FileEventArgs args)
-		{
-			CheckReferenceChange (args.FileName);
-		}
-		
 		internal override void OnFileChanged (object source, MonoDevelop.Core.FileEventArgs e)
 		{
 			base.OnFileChanged (source, e);
@@ -510,8 +514,8 @@
 		}
 
 		IDotNetLanguageBinding FindLanguage (string name)
-		{
-			IDotNetLanguageBinding binding = LanguageBindingService.GetBindingPerLanguageName (language) as IDotNetLanguageBinding;
+		{
+            IDotNetLanguageBinding binding = LanguageBindingService.GetBindingPerLanguageName (languageName) as IDotNetLanguageBinding;
 			return binding;
 		}
 		
@@ -557,40 +561,8 @@
 			return false;
 		}
 
-		protected override void DoExecute (IProgressMonitor monitor, ExecutionContext context, string config)
-		{
-			DotNetProjectConfiguration configuration = (DotNetProjectConfiguration) GetConfiguration (config);
-			monitor.Log.WriteLine ("Running " + configuration.CompiledOutputName + " ...");
-			
-			IConsole console;
-			if (configuration.ExternalConsole)
-				console = context.ExternalConsoleFactory.CreateConsole (!configuration.PauseConsoleOutput);
-			else
-				console = context.ConsoleFactory.CreateConsole (!configuration.PauseConsoleOutput);
-			
-			AggregatedOperationMonitor operationMonitor = new AggregatedOperationMonitor (monitor);
-			
-			try {
-				ExecutionCommand cmd = CreateExecutionCommand (configuration);
-				
-				if (!context.ExecutionHandler.CanExecute (cmd)) {
-					monitor.ReportError ("Can not execute \"" + configuration.CompiledOutputName + "\". The selected execution mode is not supported for .NET projects.", null);
-					return;
-				}
-			
-				IProcessAsyncOperation op = context.ExecutionHandler.Execute (cmd, console);
-				
-				operationMonitor.AddOperation (op);
-				op.WaitForCompleted ();
-				monitor.Log.WriteLine ("The application exited with code: {0}", op.ExitCode);
-			} catch (Exception ex) {
-				monitor.ReportError ("Can not execute " + "\"" + configuration.CompiledOutputName + "\"", ex);
-			} finally {
-				operationMonitor.Dispose ();
-				console.Dispose ();
-			}
-		}
 		
+		
 		protected virtual ExecutionCommand CreateExecutionCommand (DotNetProjectConfiguration configuration)
 		{
 			DotNetExecutionCommand cmd = new DotNetExecutionCommand (configuration.CompiledOutputName);
@@ -864,6 +836,45 @@
 		}
 		
 		public event ProjectReferenceEventHandler ReferenceRemovedFromProject;
-		public event ProjectReferenceEventHandler ReferenceAddedToProject;
+		public event ProjectReferenceEventHandler ReferenceAddedToProject;
+
+
+        private void OnFileRemoved (Object o, FileEventArgs e)
+        {
+            CheckReferenceChange (e.FileName);
+        }
+
+        protected override void DoExecute (IProgressMonitor monitor, ExecutionContext context, string itemConfiguration)
+        {
+            DotNetProjectConfiguration dotNetProjectConfig = GetConfiguration (itemConfiguration) as DotNetProjectConfiguration;
+            monitor.Log.WriteLine (String.Format (GettextCatalog.GetString ("Running {0} ...", dotNetProjectConfig.CompiledOutputName)));
+
+            IConsole console = dotNetProjectConfig.ExternalConsole ? context.ExternalConsoleFactory.CreateConsole (!dotNetProjectConfig.PauseConsoleOutput) : context.ConsoleFactory.CreateConsole (!dotNetProjectConfig.PauseConsoleOutput);
+            AggregatedOperationMonitor aggregatedOperationMonitor = new AggregatedOperationMonitor (monitor);
+
+            try {
+                try {
+                    ExecutionCommand executionCommand = CreateExecutionCommand (dotNetProjectConfig);
+
+                    if (!context.ExecutionHandler.CanExecute (executionCommand)) {
+                        monitor.ReportError (GettextCatalog.GetString ("Can not execute \"{0}\". The selected execution mode is not supported for .NET projects.", dotNetProjectConfig.CompiledOutputName), null);
+                        return;
+                    }
+
+                    IProcessAsyncOperation asyncOp = context.ExecutionHandler.Execute (executionCommand, console);
+                    aggregatedOperationMonitor.AddOperation (asyncOp);
+                    asyncOp.WaitForCompleted ();
+
+                    monitor.Log.WriteLine (GettextCatalog.GetString ("The application exited with code: {0}", asyncOp.ExitCode));
+                }
+                finally {
+                    console.Dispose ();
+                    aggregatedOperationMonitor.Dispose ();
+                }
+            }
+            catch (Exception ex) {
+                monitor.ReportError (GettextCatalog.GetString ("Cannot execute \"{0}\", myconfiguration.CompiledOutputname"), ex);
+            }
+        }
 	}
 }