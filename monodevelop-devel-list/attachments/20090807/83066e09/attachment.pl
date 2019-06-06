Index: main/src/core/MonoDevelop.Projects/ChangeLog
===================================================================
--- main/src/core/MonoDevelop.Projects/ChangeLog	(revision 139552)
+++ main/src/core/MonoDevelop.Projects/ChangeLog	(working copy)
@@ -1,3 +1,8 @@
+2009-08-07  Viktoria Dudka  <viktoriad@remobjects.com>
+
+	* MonoDevelop.Projects/ProjectConfiguration.cs: Rewritten from scratch
+	  to make it NON-GPL.
+	  
 2009-08-06  Lluis Sanchez Gual  <lluis@novell.com>
 
 	* MonoDevelop.Projects/Solution.cs:
Index: main/src/core/MonoDevelop.Projects/MonoDevelop.Projects/AbstractProjectConfiguration.cs
===================================================================
--- main/src/core/MonoDevelop.Projects/MonoDevelop.Projects/AbstractProjectConfiguration.cs	(revision 139552)
+++ main/src/core/MonoDevelop.Projects/MonoDevelop.Projects/AbstractProjectConfiguration.cs	(working copy)
@@ -1,164 +1,147 @@
-//  ProjectConfiguration.cs
+﻿// ProjectConfiguration.cs
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
 
-using System;
-using System.IO;
-using System.Collections;
-using System.Collections.Generic;
-using System.Diagnostics;
-using System.ComponentModel;
-using System.Xml;
-
-using MonoDevelop.Core;
-using MonoDevelop.Projects;
-using MonoDevelop.Core.Serialization;
-
-namespace MonoDevelop.Projects
-{
-	/// <summary>
-	/// External language bindings may choose to extend this class.
-	/// It makes things a bit easier.
-	/// </summary>
-	public abstract class ProjectConfiguration : SolutionItemConfiguration
-	{
-		[ProjectPathItemProperty ("OutputPath")]
-		string directory = "." + Path.DirectorySeparatorChar.ToString();
-		
-		[ProjectPathItemProperty ("ExecuteBeforeBuild", DefaultValue = "")]
-		string executeBeforeBuild = String.Empty;
-		
-		[ProjectPathItemProperty ("ExecuteAfterBuild", DefaultValue = "")]
-		string executeAfterBuild = String.Empty;
-		
-		[ItemProperty ("DebugSymbols", DefaultValue=false)]
-		bool debugmode;
-		
-		[ItemProperty ("SignAssembly", DefaultValue = false)]
-		bool signAssembly = false;
-		
-		[ProjectPathItemProperty ("AssemblyKeyFile")]
-		string assemblyKeyFile = String.Empty;
-		
-		[ProjectPathItemProperty ("ExecuteScript", DefaultValue = "")]
-		string executeScript = String.Empty;
-		
-		[ItemProperty ("RunWithWarnings", DefaultValue=true)]
-		bool runWithWarnings = true;
-		
-		[ItemProperty ("Commandlineparameters", DefaultValue = "")]
-		string commandLineParameters = String.Empty;
-		
-		[ItemProperty ("Externalconsole", DefaultValue=false)]
-		bool externalConsole = false;
-
-		[ItemProperty ("ConsolePause", DefaultValue=true)]
-		bool pauseconsoleoutput = true;
-
-		[ItemProperty ("EnvironmentVariables", SkipEmpty=true)]
-		[ItemProperty ("Variable", Scope="item")]
-		[ItemProperty ("name", Scope="key")]
-		[ItemProperty ("value", Scope="value")]
-		Dictionary<string,string> envVars;
-
-		public ProjectConfiguration ()
-		{
-		}
-		
-		public ProjectConfiguration (string name): base (name)
-		{
-		}
-		
-		public virtual FilePath OutputDirectory {
-			get { return directory; }
-			set { directory = value; }
-		}
-		
-		public virtual string ExecuteScript {
-			get { return executeScript; }
-			set { executeScript = value; }
-		}
-		
-		public virtual bool RunWithWarnings {
-			get { return runWithWarnings; }
-			set { runWithWarnings = value; }
-		}
-		
-		public bool DebugMode {
-			get { return debugmode; }
-			set { debugmode = value; }
-		}
-		
-		public string CommandLineParameters {
-			get { return commandLineParameters; }
-			set { commandLineParameters = value; }
-		}
-		
-		public bool ExternalConsole {
-			get { return externalConsole; }
-			set { externalConsole = value; }
-		}
-		
-		public bool PauseConsoleOutput {
-			get { return pauseconsoleoutput; }
-			set { pauseconsoleoutput = value; }
-		}
-		
-		public bool SignAssembly {
-			get { return signAssembly; }
-			set { signAssembly = value; }
-		}
-		
-		public string AssemblyKeyFile {
-			get { return assemblyKeyFile; }
-			set { assemblyKeyFile = value; }
-		}
-		
-		public Dictionary<string,string> EnvironmentVariables {
-			get {
-				if (envVars == null)
-					envVars = new Dictionary<string,string> ();
-				return envVars; 
-			}
-		}
-		
-		
-		public override void CopyFrom (ItemConfiguration configuration)
-		{
-			base.CopyFrom (configuration);
-			ProjectConfiguration conf = (ProjectConfiguration) configuration;
-			
-			directory = conf.directory;
-			executeScript = conf.executeScript;
-			executeBeforeBuild = conf.executeBeforeBuild;
-			executeAfterBuild = conf.executeAfterBuild;
-			runWithWarnings = conf.runWithWarnings;
-			debugmode = conf.debugmode;
-			commandLineParameters = conf.commandLineParameters;
-			externalConsole = conf.externalConsole;
-			pauseconsoleoutput = conf.pauseconsoleoutput;
-			signAssembly = conf.signAssembly;
-			assemblyKeyFile = conf.assemblyKeyFile;
-			if (conf.envVars != null)
-				envVars = new Dictionary<string,string> (conf.envVars);
-			else
-				envVars = null;
-		}
-	}
-}
+
+using System;
+using MonoDevelop.Core;
+using System.IO;
+using MonoDevelop.Core.Serialization;
+using System.Collections.Generic;
+
+namespace MonoDevelop.Projects
+{
+    public abstract class ProjectConfiguration : SolutionItemConfiguration 
+    {
+
+        public ProjectConfiguration ()
+        {
+        }
+
+        public ProjectConfiguration (string name): base(name)
+        {
+        }
+
+        [ProjectPathItemProperty ("OutputPath")]
+        private FilePath outputDirectory = "." + Path.DirectorySeparatorChar;
+        public virtual FilePath OutputDirectory
+        {
+            get { return outputDirectory; }
+            set { outputDirectory = value; }
+        }
+
+        [ItemProperty ("DebugSymbols", DefaultValue = false)]
+        private bool debugMode = false;
+        public bool DebugMode
+        {
+            get { return debugMode; }
+            set { debugMode = value; }
+        }
+
+        [ItemProperty ("ConsolePause", DefaultValue = true)]
+        private bool pauseConsoleOutput = true;
+        public bool PauseConsoleOutput
+        {
+            get { return pauseConsoleOutput; }
+            set { pauseConsoleOutput = value; }
+        }
+
+        [ItemProperty ("Externalconsole", DefaultValue = false)]
+        private bool externalConsole = false;
+        public bool ExternalConsole
+        {
+            get { return externalConsole; }
+            set { externalConsole = value; }
+        }
+
+        [ItemProperty ("Commandlineparameters", DefaultValue = "")]
+        private string commandLineParameters = "";
+        public string CommandLineParameters
+        {
+            get { return commandLineParameters; }
+            set { commandLineParameters = value; }
+        }
+
+        [ItemProperty ("EnvironmentVariable", SkipEmpty = true)]
+        [ItemProperty ("Variable", Scope = "item")]
+        [ItemProperty ("name", Scope = "key")]
+        [ItemProperty ("value", Scope = "value")]
+        private Dictionary<string, string> environmentVariables = new Dictionary<string, string> ();
+        public Dictionary<string, string> EnvironmentVariables
+        {
+            get { return environmentVariables; }
+        }
+
+        [ItemProperty ("SignAssembly", DefaultValue = false)]
+        private bool signAssembly = false;
+        public bool SignAssembly
+        {
+            get { return signAssembly; }
+            set { signAssembly = value; }
+        }
+
+        [ItemProperty ("RunWithWarnings", DefaultValue = true)]
+        private bool runWithWarnings = true;
+        public virtual bool RunWithWarnings
+        {
+            get { return runWithWarnings; }
+            set { runWithWarnings = value; }
+        }
+
+        [ItemProperty ("AssemblyKeyFile", DefaultValue = "")]
+        private string assemblyKeyFile = "";
+        public string AssemblyKeyFile
+        {
+            get { return assemblyKeyFile; }
+            set { assemblyKeyFile = value; }
+        }
+
+        public override void CopyFrom (ItemConfiguration conf)
+        {
+            base.CopyFrom (conf);
+
+            ProjectConfiguration projectConf = conf as ProjectConfiguration;
+
+            outputDirectory = projectConf.outputDirectory;
+            debugMode = projectConf.debugMode;
+            pauseConsoleOutput = projectConf.pauseConsoleOutput;
+            externalConsole = projectConf.externalConsole;
+            commandLineParameters = projectConf.commandLineParameters;
+
+            environmentVariables.Clear ();
+            foreach (KeyValuePair<string, string> el in projectConf.environmentVariables) {
+                environmentVariables.Add (el.Key, el.Value);
+            }
+
+            signAssembly = projectConf.signAssembly;
+            runWithWarnings = projectConf.runWithWarnings;
+            assemblyKeyFile = projectConf.assemblyKeyFile;
+
+        }
+
+    }
+
+}