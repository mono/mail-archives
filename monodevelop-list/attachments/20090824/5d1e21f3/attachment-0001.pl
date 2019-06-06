Index: PyBinding/PyBinding.csproj
===================================================================
--- PyBinding/PyBinding.csproj	(revision 140459)
+++ PyBinding/PyBinding.csproj	(working copy)
@@ -119,15 +119,14 @@
     <Reference Include="System.Core">
       <RequiredTargetFramework>3.5</RequiredTargetFramework>
     </Reference>
-    <Reference Include="MonoDevelop.SourceEditor2, Version=2.1.0.0, Culture=neutral">
-      <Package>monodevelop-core-addins</Package>
+    <Reference Include="Mono.TextTemplating, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null">
+      <SpecificVersion>False</SpecificVersion>
+      <HintPath>..\..\..\main\build\AddIns\MonoDevelop.TextTemplating\Mono.TextTemplating.dll</HintPath>
     </Reference>
-    <Reference Include="MonoDevelop.Debugger, Version=2.1.0.0, Culture=neutral">
-      <Package>monodevelop-core-addins</Package>
+    <Reference Include="MonoDevelop.TextTemplating, Version=2.1.0.0, Culture=neutral, PublicKeyToken=null">
+      <SpecificVersion>False</SpecificVersion>
+      <HintPath>..\..\..\main\build\AddIns\MonoDevelop.TextTemplating\MonoDevelop.TextTemplating.dll</HintPath>
     </Reference>
-    <Reference Include="MonoDevelop.Refactoring, Version=2.1.0.0, Culture=neutral">
-      <Package>monodevelop-core-addins</Package>
-    </Reference>
   </ItemGroup>
   <ItemGroup>
     <Compile Include="AssemblyInfo.cs" />
@@ -138,7 +137,6 @@
     <Compile Include="PyBinding\PythonConfiguration.cs" />
     <Compile Include="PyBinding.Runtime\IPythonRuntime.cs" />
     <Compile Include="PyBinding.Runtime\AbstractPythonRuntime.cs" />
-    <Compile Include="PyBinding.Runtime\Python26Runtime.cs" />
     <Compile Include="PyBinding.Compiler\IPythonCompiler.cs" />
     <Compile Include="PyBinding\PythonProjectBinding.cs" />
     <Compile Include="PyBinding.Gui\PythonOptionsWidget.cs" />
@@ -170,6 +168,17 @@
     <Compile Include="PyBinding.Gui\PythonOptionsPanel.cs" />
     <Compile Include="PyBinding\PythonExecutionCommand.cs" />
     <Compile Include="PyBinding\PythonExecutionHandler.cs" />
+    <Compile Include="PyBinding.Runtime\Python26Runtime.cs" />
+    <Compile Include="PyBinding.Django.Gui\DjangoCommands.cs" />
+    <Compile Include="PyBinding.Django.Gui\FolderNodeBuilderExtension.cs" />
+    <Compile Include="PyBinding.Django.Gui\AddAppDialog.cs" />
+    <Compile Include="gtk-gui\PyBinding.Django.Gui.AddAppDialog.cs" />
+    <Compile Include="PyBinding.Django\DjangoProject.cs" />
+    <Compile Include="PyBinding.Django.Gui\DjangoOptionsWidget.cs" />
+    <Compile Include="gtk-gui\PyBinding.Django.Gui.DjangoOptionsWidget.cs" />
+    <Compile Include="PyBinding.Django.Gui\DjangoOptionsPanel.cs" />
+    <Compile Include="PyBinding.Django\DjangoConfiguration.cs" />
+    <Compile Include="PyBinding.Django\DjangoProjectBinding.cs" />
   </ItemGroup>
   <ItemGroup>
     <EmbeddedResource Include="Resources\EmptyPyProject.xpt.xml">
@@ -197,12 +206,17 @@
     <EmbeddedResource Include="Resources\EmptyDjangoProject.xpt.xml">
       <LogicalName>EmptyDjangoProject.xpt.xml</LogicalName>
     </EmbeddedResource>
-    <EmbeddedResource Include="Resources\PyGtkProject.xpt.xml">
-      <LogicalName>PyGtkProject.xpt.xml</LogicalName>
+    <EmbeddedResource Include="Resources\PyClutterProject.xpt.xml" />
+    <EmbeddedResource Include="Resources\PyGtkProject.xpt.xml" />
+    <EmbeddedResource Include="CodeTemplates\Django\__init__.py">
+      <CopyToOutputDirectory>PreserveNewest</CopyToOutputDirectory>
     </EmbeddedResource>
-    <EmbeddedResource Include="Resources\PyClutterProject.xpt.xml">
-      <LogicalName>PyClutterProject.xpt.xml</LogicalName>
+    <EmbeddedResource Include="CodeTemplates\Django\models.py">
+      <CopyToOutputDirectory>PreserveNewest</CopyToOutputDirectory>
     </EmbeddedResource>
+    <EmbeddedResource Include="CodeTemplates\Django\views.py">
+      <CopyToOutputDirectory>PreserveNewest</CopyToOutputDirectory>
+    </EmbeddedResource>
   </ItemGroup>
   <Import Project="$(MSBuildBinPath)\Microsoft.CSharp.targets" />
   <ProjectExtensions>
@@ -220,4 +234,7 @@
       </Properties>
     </MonoDevelop>
   </ProjectExtensions>
+  <ItemGroup>
+    <Folder Include="PyBinding.Django\" />
+  </ItemGroup>
 </Project>
Index: PyBinding/PyBinding.Django/DjangoProjectBinding.cs
===================================================================
--- PyBinding/PyBinding.Django/DjangoProjectBinding.cs	(revision 0)
+++ PyBinding/PyBinding.Django/DjangoProjectBinding.cs	(revision 0)
@@ -0,0 +1,71 @@
+// 
+// DjangoProjectBindings.cs
+//  
+// Author:
+//       John Tindell <john@yeticode.co.uk>
+// 
+// Copyright (c) 2009 John Tindell
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
+
+using System;
+using System.IO;
+using System.Xml;
+
+using MonoDevelop.Projects;
+
+namespace PyBinding.Django
+{
+
+
+	public class DjangoProjectBinding : IProjectBinding
+	{
+		public string Name {
+			get {
+				return "Django";
+			}
+		}
+		
+		static readonly string m_Language = "Python";
+
+		
+		public Project CreateProject (ProjectCreateInformation info,
+		                              XmlElement projectOptions)
+		{
+			return new DjangoProject (m_Language, null, projectOptions);
+		}
+
+		public Project CreateSingleFileProject (string sourceFile)
+		{
+			ProjectCreateInformation info = new ProjectCreateInformation ();
+			info.ProjectName = Path.GetFileNameWithoutExtension (sourceFile);
+			info.SolutionPath = Path.GetDirectoryName (sourceFile);
+			info.ProjectBasePath = Path.GetDirectoryName (sourceFile);
+			
+			DjangoProject project = new DjangoProject (m_Language, info, null);
+			project.Files.Add (new ProjectFile (sourceFile));
+			return project;
+		}
+
+		public bool CanCreateSingleFileProject (string sourceFile)
+		{
+			return Path.GetExtension (sourceFile) == ".py";
+		}
+	}
+}
Index: PyBinding/PyBinding.Django/DjangoProject.cs
===================================================================
--- PyBinding/PyBinding.Django/DjangoProject.cs	(revision 0)
+++ PyBinding/PyBinding.Django/DjangoProject.cs	(revision 0)
@@ -0,0 +1,141 @@
+// DjangoProject.cs
+//  
+// Author:
+//       John Tindell <john@yeticode.co.uk>
+// 
+// Copyright (c) 2009 John Tindell
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
+
+using System;
+using MonoDevelop.Projects;
+using System.Xml;
+using System.IO;
+using MonoDevelop.Core;
+using MonoDevelop.Core.Execution;
+using MonoDevelop.Core.ProgressMonitoring;
+using MonoDevelop.Core.Gui;
+
+namespace PyBinding.Django
+{
+
+	public class DjangoProject : PythonProject
+	{
+		static readonly string s_Language = "Python";
+		public override string ProjectType {
+			get {
+				return "Django";
+			}
+		}
+		
+		public DjangoProject ()
+		{
+			
+		}
+		public DjangoProject (string languageName, 
+		                      ProjectCreateInformation info,
+		                      XmlElement projectOptions)
+			
+		{
+			DjangoConfiguration defaultConfig;
+			string binPath;
+			
+			if (!String.Equals (s_Language, languageName)) {
+				throw new ArgumentException (String.Format("Not Python Project: {0}, {1}",s_Language, languageName) );
+			}
+			
+			if (info != null) {
+				binPath = info.BinPath;
+				this.Name = info.ProjectName;
+			}
+			else {
+				binPath = ".";
+			}
+			
+			// Setup our Debug configuration
+			defaultConfig = CreateConfiguration ("Debug") as DjangoConfiguration;
+			this.Configurations.Add (defaultConfig);
+			
+			// Setup our Release configuration
+			defaultConfig = CreateConfiguration ("Release") as DjangoConfiguration;
+			defaultConfig.Optimize = true;
+			this.Configurations.Add (defaultConfig);
+			
+			// Setup proper paths for all configurations
+			foreach (DjangoConfiguration config in this.Configurations) {
+				config.OutputDirectory = Path.Combine (binPath, config.Name);
+			}
+		}
+		public override SolutionItemConfiguration CreateConfiguration (string configName)
+		{
+			DjangoConfiguration config = new DjangoConfiguration ();
+			config.Name = configName;
+			return config;
+		}
+		protected override void DoExecute (IProgressMonitor monitor,
+		                                   ExecutionContext context,
+		                                   string           configuration)
+		{
+			PythonConfiguration config;
+			IConsole console;
+			
+			config = (PythonConfiguration) GetConfiguration (configuration);
+			
+			// Make sure we have a module to execute
+			if (config.Runtime == null || String.IsNullOrEmpty (config.Module)) {
+				MessageService.ShowMessage ("No target module specified!");
+				return;
+			}
+			
+			monitor.Log.WriteLine ("Running project...");
+			
+			// Create a console, external if needed
+			if (config.ExternalConsole) {
+				console = context.ExternalConsoleFactory.CreateConsole (!config.PauseConsoleOutput);
+			}
+			else {
+				console = context.ConsoleFactory.CreateConsole (!config.PauseConsoleOutput);
+			}
+			
+			AggregatedOperationMonitor operationMonitor = new AggregatedOperationMonitor (monitor);
+			
+			try {
+				PythonExecutionCommand cmd = new PythonExecutionCommand (config);
+				Console.WriteLine(cmd.CommandString);
+				if (!context.ExecutionHandler.CanExecute (cmd)) {
+					monitor.ReportError ("The selected execution mode is not supported for Python projects.", null);
+					return;
+				}
+				
+				IProcessAsyncOperation op = context.ExecutionHandler.Execute (cmd, console);
+				operationMonitor.AddOperation (op);
+				op.WaitForCompleted ();
+				
+				monitor.Log.WriteLine ("The operation exited with code: {0}", op.ExitCode);
+			}
+			catch (Exception ex) {
+				monitor.ReportError ("Cannot execute \"" + config.Runtime.Path + "\"", ex);
+			}
+			finally {
+				operationMonitor.Dispose ();
+				console.Dispose ();
+			}
+		}
+	}
+}
Index: PyBinding/PyBinding.Django/DjangoConfiguration.cs
===================================================================
--- PyBinding/PyBinding.Django/DjangoConfiguration.cs	(revision 0)
+++ PyBinding/PyBinding.Django/DjangoConfiguration.cs	(revision 0)
@@ -0,0 +1,84 @@
+// 
+// DjangoConfiguration.cs
+//  
+// Author:
+//       John Tindell <john@yeticode.co.uk>
+// 
+// Copyright (c) 2009 John Tindell
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
+
+using System;
+
+using MonoDevelop.Core;
+using MonoDevelop.Projects;
+using MonoDevelop.Core.Serialization;
+
+namespace PyBinding.Django
+{
+
+
+	public class DjangoConfiguration : PythonConfiguration
+	{
+		[ItemProperty("Runtime/Port")]
+		string m_Port = String.Empty;
+		[ItemProperty("Runtime/Address")]		
+		string m_Address = String.Empty;
+		
+		public string Port {
+			get {
+				return this.m_Port;
+			}
+			set {
+				this.m_Port = value;
+			}
+		}
+
+		public string Address {
+			get {
+				return this.m_Address;
+			}
+			set {
+				this.m_Address = value;
+			}	
+		}
+		
+		public DjangoConfiguration ()
+		{
+			this.m_Port = "8080";
+			this.m_Address = "127.0.0.1";
+			this.Module  = "manage";
+		}
+		// this needs to be implemented otherwise the configuration won't save.
+		public override void CopyFrom (ItemConfiguration config)
+		{
+			DjangoConfiguration pyConfig = config as DjangoConfiguration;
+			
+			if (pyConfig == null)
+				throw new ArgumentException ("not a DjangoConfiguration");
+			
+			base.CopyFrom (config);
+			this.m_Address = pyConfig.Address;
+			this.m_Port = pyConfig.Port;
+			
+			// update the command line options of parent object here
+			this.CommandLineParameters = string.Format("runserver {0}:{1}",this.m_Address,this.m_Port);
+		}
+	}
+}
Index: PyBinding/CodeTemplates/Django/views.py
===================================================================
--- PyBinding/CodeTemplates/Django/views.py	(revision 0)
+++ PyBinding/CodeTemplates/Django/views.py	(revision 0)
@@ -0,0 +1 @@
+# Create your views here.
\ No newline at end of file
Index: PyBinding/CodeTemplates/Django/__init__.py
===================================================================
Index: PyBinding/CodeTemplates/Django/models.py
===================================================================
--- PyBinding/CodeTemplates/Django/models.py	(revision 0)
+++ PyBinding/CodeTemplates/Django/models.py	(revision 0)
@@ -0,0 +1,3 @@
+from django.db import models
+
+# Create your models here.
\ No newline at end of file
Index: PyBinding/PyBinding.addin.xml
===================================================================
--- PyBinding/PyBinding.addin.xml	(revision 140459)
+++ PyBinding/PyBinding.addin.xml	(working copy)
@@ -48,7 +48,7 @@
     		id = "EmptyPyProject"
     		resource = "EmptyPyProject.xpt.xml"/>
     	<ProjectTemplate
-    		id = "EmptyDjangoPyProject"
+    		id = "EmptyDjangoProject"
     		resource = "EmptyDjangoProject.xpt.xml"/>
         <ProjectTemplate
             id = "PyGtkProject"
@@ -68,6 +68,9 @@
         <ProjectBinding
         	id = "PyProject"
         	class = "PyBinding.PythonProjectBinding"/>
+       	<ProjectBinding
+        	id = "DjangoProject"
+        	class = "PyBinding.Django.DjangoProjectBinding"/>
     </Extension>
     
     <Extension path = "/MonoDevelop/ProjectModel/LanguageBindings">
@@ -85,6 +88,13 @@
 	            insertafter = "General"
 	            class       = "PyBinding.Gui.OutputOptionsPanel"/>
 		</Condition>
+		<Condition id="ItemType" value="PyBinding.Django.DjangoProject">
+	        <Section
+				id          = "DjangoOptionsPanel"
+	            _label      = "Django"
+	            insertafter = "Python"
+	            class       = "PyBinding.Django.Gui.DjangoOptionsPanel"/>
+		</Condition>
 	</Extension>
 
 	<Extension path = "/MonoDevelop/Ide/TextEditorExtensions">
@@ -99,6 +109,8 @@
 
   	<Extension path = "/MonoDevelop/ProjectModel/SerializableClasses">
         <DataType class = "PyBinding.PythonProject"/>
+        <DataType class = "PyBinding.Django.DjangoProject"/>
+        <DataType class = "PyBinding.Django.DjangoConfiguration"/>
         <DataType class = "PyBinding.PythonConfiguration"/>
         <DataType class = "PyBinding.Runtime.Python25Runtime"/>
         <DataType class = "PyBinding.Runtime.Python26Runtime"/>
@@ -117,5 +129,22 @@
 	<Extension path = "/MonoDevelop/Core/ExecutionHandlers">
 		<ExecutionHandler id="Python" class = "PyBinding.PythonExecutionHandler"/>
 	</Extension>
-	
+	<Extension path = "/MonoDevelop/Ide/Commands">
+		<Category _name = "Python" id = "Python">
+		<Command id = "PyBinding.Django.Gui.DjangoCommands.AddApplication"
+		         _label = "Add New Django Application"
+		         _description = "Add an New Django Application" />
+		</Category>
+	</Extension>
+
+	<Extension path = "/MonoDevelop/Ide/ContextMenu/ProjectPad/Add">
+<!--		<Condition id="activeproject" value="DjangoProject">-->
+			<CommandItem id = "PyBinding.Django.Gui.DjangoCommands.AddApplication" insertbefore="MonoDevelop.Ide.Commands.ProjectCommands.AddNewFiles"  disabledVisible="false"/>
+			<SeparatorItem id = "DjangoAddSeparator" />
+		<!--</Condition>-->
+	</Extension>
+		
+	<Extension path = "/MonoDevelop/Ide/Pads/ProjectPad">
+		<NodeBuilder id="DjangoFolderNodeBuilderExtension" class = "PyBinding.Django.Gui.FolderNodeBuilderExtension"/>
+	</Extension>	
 </Addin>
Index: PyBinding/PyBinding.Django.Gui/DjangoOptionsPanel.cs
===================================================================
--- PyBinding/PyBinding.Django.Gui/DjangoOptionsPanel.cs	(revision 0)
+++ PyBinding/PyBinding.Django.Gui/DjangoOptionsPanel.cs	(revision 0)
@@ -0,0 +1,70 @@
+// 
+// DjangoOptionsPanel.cs
+//  
+// Author:
+//       John Tindell <john@yeticode.co.uk>
+// 
+// Copyright (c) 2009 John Tindell
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
+
+using System;
+
+using Gtk;
+
+using MonoDevelop.Ide.Gui;
+using MonoDevelop.Core;
+using MonoDevelop.Core.Gui;
+using MonoDevelop.Projects;
+using MonoDevelop.Projects.Gui.Dialogs;
+using MonoDevelop.Projects.Text;
+using MonoDevelop.Core.Gui.Dialogs;
+
+namespace PyBinding.Django.Gui
+{
+
+
+	public class DjangoOptionsPanel: MultiConfigItemOptionsPanel
+	{
+		DjangoOptionsWidget widget;
+		
+		public override Gtk.Widget CreatePanelWidget ()
+		{
+			widget = new DjangoOptionsWidget ();
+			widget.Show ();
+			return widget;
+		}
+
+		public override void LoadConfigData ()
+		{
+			DjangoConfiguration config = CurrentConfiguration as DjangoConfiguration;
+			
+			widget.Port = config.Port;
+			widget.Address = config.Address;
+		}
+
+		public override void ApplyChanges ()
+		{
+			DjangoConfiguration config = CurrentConfiguration as DjangoConfiguration;
+			
+			config.Port = widget.Port;
+			config.Address = widget.Address;			
+		}
+	}
+}
Index: PyBinding/PyBinding.Django.Gui/DjangoOptionsWidget.cs
===================================================================
--- PyBinding/PyBinding.Django.Gui/DjangoOptionsWidget.cs	(revision 0)
+++ PyBinding/PyBinding.Django.Gui/DjangoOptionsWidget.cs	(revision 0)
@@ -0,0 +1,47 @@
+// DjangoOptionsWidget.cs
+//  
+// Author:
+//       John Tindell <john@yeticode.co.uk>
+// 
+// Copyright (c) 2009 John Tindell
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
+
+using System;
+
+namespace PyBinding.Django.Gui
+{
+	public partial class DjangoOptionsWidget : Gtk.Bin
+	{
+		public string Port
+		{
+			get { return txtPort.Text; }
+			set { txtPort.Text = value; }
+		}
+		public string Address
+		{
+			get { return txtAddress.Text; }
+			set { txtAddress.Text = value; }
+		}
+		public DjangoOptionsWidget ()
+		{
+			this.Build ();
+		}
+	}
+}
Index: PyBinding/PyBinding.Django.Gui/DjangoCommands.cs
===================================================================
--- PyBinding/PyBinding.Django.Gui/DjangoCommands.cs	(revision 0)
+++ PyBinding/PyBinding.Django.Gui/DjangoCommands.cs	(revision 0)
@@ -0,0 +1,35 @@
+// DjangoCommands.cs
+//  
+// Author:
+//       John Tindell <john@yeticode.co.uk>
+// 
+// Copyright (c) 2009 john@yeticode.co.uk
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
+using System;
+
+namespace PyBinding.Django.Gui
+{
+
+
+	public enum DjangoCommands
+	{
+		AddApplication
+	}
+}
Index: PyBinding/PyBinding.Django.Gui/FolderNodeBuilderExtension.cs
===================================================================
--- PyBinding/PyBinding.Django.Gui/FolderNodeBuilderExtension.cs	(revision 0)
+++ PyBinding/PyBinding.Django.Gui/FolderNodeBuilderExtension.cs	(revision 0)
@@ -0,0 +1,134 @@
+// FolderNodeBuilderExtension.cs
+//  
+// Author:
+//       John Tindell <john@yeticode.co.uk>
+// 
+// Copyright (c) 2009 john@yeticode.co.uk
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
+
+using System;
+using System.IO;
+using System.Collections.Generic;
+using MonoDevelop.Components.Commands;
+using MonoDevelop.Core;
+using MonoDevelop.Core.Gui;
+using MonoDevelop.Projects;
+using MonoDevelop.Ide.Gui.Components;
+using MonoDevelop.Ide.Gui.Pads.ProjectPad;
+using System.Reflection;
+
+namespace PyBinding.Django.Gui
+{
+	class FolderNodeBuilderExtension : NodeBuilderExtension
+	{
+		public override bool CanBuildNode (Type dataType)
+		{
+			return typeof (ProjectFolder).IsAssignableFrom (dataType);
+		}
+		
+		public override Type CommandHandlerType {
+			get { return typeof (FolderCommandHandler); }
+		}
+	}
+
+	class FolderCommandHandler : NodeCommandHandler
+	{
+		[CommandUpdateHandler (DjangoCommands.AddApplication)]
+		public void AddControllerUpdate (CommandInfo info)
+		{
+			ProjectFolder pf = (ProjectFolder)CurrentNode.DataItem;
+			FilePath rootName = pf.Project.BaseDirectory.Combine ("apps");
+			info.Enabled = info.Visible = (pf.Path == rootName || pf.Path.IsChildPathOf (rootName));
+		}
+		[CommandHandler (DjangoCommands.AddApplication)]
+		public void AddApplication()
+		{
+			AddAppDialog dialog = null;
+			
+			DjangoProject project = CurrentNode.GetParentDataItem (typeof(DjangoProject), true) as DjangoProject;
+			if (project == null)
+				return;
+			
+			try
+			{
+				
+				dialog = new AddAppDialog(project);
+				dialog.ShowNow();
+				Gtk.ResponseType resp = (Gtk.ResponseType) MessageService.ShowCustomDialog(dialog);
+				dialog.Hide ();
+				string appName = dialog.ApplicationName.Replace(" ","");
+
+				if (resp != Gtk.ResponseType.Ok )
+					return;
+				if(appName.Equals(String.Empty) || appName.ToLower().Equals("test"))
+					return;
+				
+				ProjectFolder folder = CurrentNode.GetParentDataItem (typeof(ProjectFolder), true) as ProjectFolder;
+				string path = folder != null? folder.Path : project.BaseDirectory;
+				AddApplication(project,path,appName);
+				
+			}
+			catch(Exception ex)
+			{
+				Console.WriteLine(ex.Message);
+			}
+			finally
+			{
+				if(dialog != null)
+					dialog.Destroy();
+			}
+		}
+		
+		private static void AddApplication(DjangoProject project, string path, string name)
+		{
+			// create the folder
+			string appPath = System.IO.Path.Combine(path,name);
+			Directory.CreateDirectory(appPath);
+			project.AddDirectory(appPath);			
+			
+			Dictionary<string,string> resIds = new Dictionary<string, string>();
+			resIds.Add("__init__.py","CodeTemplates.Django.__init__.py");
+           	resIds.Add("models.py","CodeTemplates.Django.models.py");
+            resIds.Add("views.py","CodeTemplates.Django.views.py");
+			
+			Assembly asm = Assembly.GetExecutingAssembly ();
+			foreach(String key in resIds.Keys)
+			{
+				Stream   src = asm.GetManifestResourceStream (resIds[key]);
+				using (TextReader reader = new StreamReader (src))
+				{
+					string dest = Path.Combine( appPath, key );
+					using(TextWriter writer = new StreamWriter(dest))
+					{
+						string line = String.Empty;
+						while (null != (line = reader.ReadLine ()))
+						{
+							writer.WriteLine (line);
+						}
+						
+					}
+					project.AddFile(dest);
+				}
+			}
+			// force a save?
+			project.Save(null);
+		}
+	}
+}
\ No newline at end of file
Index: PyBinding/PyBinding.Django.Gui/AddAppDialog.cs
===================================================================
--- PyBinding/PyBinding.Django.Gui/AddAppDialog.cs	(revision 0)
+++ PyBinding/PyBinding.Django.Gui/AddAppDialog.cs	(revision 0)
@@ -0,0 +1,46 @@
+// AddAppDialog.cs
+//  
+// Author:
+//       John Tindell <john@yeticode.co.uk>
+// 
+// Copyright (c) 2009 john@yeticode.co.uk
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
+
+using System;
+
+namespace PyBinding.Django.Gui
+{
+
+
+	public partial class AddAppDialog : Gtk.Dialog
+	{
+		public string ApplicationName
+		{
+			get
+			{
+				return txtAppName.Text;
+			}
+		}
+		public AddAppDialog (DjangoProject project)
+		{
+			this.Build ();
+		}
+	}
+}
Index: PyBinding/gtk-gui/gui.stetic
===================================================================
--- PyBinding/gtk-gui/gui.stetic	(revision 140459)
+++ PyBinding/gtk-gui/gui.stetic	(working copy)
@@ -6,26 +6,23 @@
   </configuration>
   <import>
     <widget-library name="Mono.TextEditor, Version=1.0.0.0, Culture=neutral" />
-    <widget-library name="MonoDevelop.Gettext, Version=2.1.0.0, Culture=neutral" />
-    <widget-library name="MonoDevelop.Ide, Version=2.1.0.0, Culture=neutral" />
-    <widget-library name="MonoDevelop.Projects.Gui, Version=2.1.0.0, Culture=neutral" />
-    <widget-library name="MonoDevelop.Components, Version=2.1.0.0, Culture=neutral" />
-    <widget-library name="MonoDevelop.GtkCore, Version=2.1.0.0, Culture=neutral" />
-    <widget-library name="MonoDevelop.DesignerSupport, Version=2.1.0.0, Culture=neutral" />
-    <widget-library name="MonoDevelop.Core.Gui, Version=2.1.0.0, Culture=neutral" />
-    <widget-library name="MonoDevelop.VersionControl, Version=2.1.0.0, Culture=neutral" />
-    <widget-library name="MonoDevelop.NUnit, Version=2.1.0.0, Culture=neutral" />
-    <widget-library name="MonoDevelop.XmlEditor, Version=2.1.0.0, Culture=neutral" />
-    <widget-library name="MonoDevelop.AspNet, Version=2.1.0.0, Culture=neutral" />
-    <widget-library name="MonoDevelop.Deployment, Version=2.1.0.0, Culture=neutral" />
-    <widget-library name="MonoDevelop.Deployment.Linux, Version=2.1.0.0, Culture=neutral" />
-    <widget-library name="MonoDevelop.VBNetBinding, Version=2.1.0.0, Culture=neutral" />
-    <widget-library name="MonoDevelop.CBinding, Version=2.1.0.0, Culture=neutral" />
-    <widget-library name="MonoDevelop.CSharpBinding, Version=2.1.0.0, Culture=neutral" />
-    <widget-library name="MonoDevelop.Autotools, Version=2.1.0.0, Culture=neutral" />
-    <widget-library name="MonoDevelop.SourceEditor2, Version=2.1.0.0, Culture=neutral" />
-    <widget-library name="MonoDevelop.Debugger, Version=2.1.0.0, Culture=neutral" />
-    <widget-library name="MonoDevelop.Refactoring, Version=2.1.0.0, Culture=neutral" />
+    <widget-library name="MonoDevelop.Gettext, Version=2.0.0.0, Culture=neutral" />
+    <widget-library name="MonoDevelop.Ide, Version=2.0.0.0, Culture=neutral" />
+    <widget-library name="MonoDevelop.Projects.Gui, Version=2.0.0.0, Culture=neutral" />
+    <widget-library name="MonoDevelop.Components, Version=2.0.0.0, Culture=neutral" />
+    <widget-library name="MonoDevelop.GtkCore, Version=2.0.0.0, Culture=neutral" />
+    <widget-library name="MonoDevelop.DesignerSupport, Version=2.0.0.0, Culture=neutral" />
+    <widget-library name="MonoDevelop.Core.Gui, Version=2.0.0.0, Culture=neutral" />
+    <widget-library name="MonoDevelop.VersionControl, Version=2.0.0.0, Culture=neutral" />
+    <widget-library name="MonoDevelop.NUnit, Version=2.0.0.0, Culture=neutral" />
+    <widget-library name="MonoDevelop.XmlEditor, Version=2.0.0.0, Culture=neutral" />
+    <widget-library name="MonoDevelop.AspNet, Version=2.0.0.0, Culture=neutral" />
+    <widget-library name="MonoDevelop.Deployment, Version=2.0.0.0, Culture=neutral" />
+    <widget-library name="MonoDevelop.Deployment.Linux, Version=2.0.0.0, Culture=neutral" />
+    <widget-library name="MonoDevelop.VBNetBinding, Version=2.0.0.0, Culture=neutral" />
+    <widget-library name="MonoDevelop.CBinding, Version=2.0.0.0, Culture=neutral" />
+    <widget-library name="MonoDevelop.CSharpBinding, Version=2.0.0.0, Culture=neutral" />
+    <widget-library name="MonoDevelop.Autotools, Version=2.0.0.0, Culture=neutral" />
     <widget-library name="../../build/PyBinding.dll" internal="true" />
   </import>
   <widget class="Gtk.Bin" id="PyBinding.Gui.PythonOptionsWidget" design-size="491 382">
@@ -308,4 +305,247 @@
       </widget>
     </child>
   </widget>
+  <widget class="Gtk.Dialog" id="PyBinding.Django.Gui.AddAppDialog" design-size="400 99">
+    <property name="MemberName" />
+    <property name="WindowPosition">CenterOnParent</property>
+    <property name="Buttons">2</property>
+    <property name="HelpButton">False</property>
+    <child internal-child="VBox">
+      <widget class="Gtk.VBox" id="dialog1_VBox">
+        <property name="MemberName" />
+        <property name="BorderWidth">2</property>
+        <child>
+          <widget class="Gtk.VBox" id="vbox2">
+            <property name="MemberName" />
+            <property name="Spacing">6</property>
+            <child>
+              <widget class="Gtk.Label" id="label1">
+                <property name="MemberName" />
+                <property name="LabelProp" translatable="yes">Enter the name of the Django Application To Create</property>
+              </widget>
+              <packing>
+                <property name="Position">0</property>
+                <property name="AutoSize">True</property>
+                <property name="Expand">False</property>
+                <property name="Fill">False</property>
+              </packing>
+            </child>
+            <child>
+              <widget class="Gtk.HBox" id="hbox1">
+                <property name="MemberName" />
+                <property name="Spacing">6</property>
+                <child>
+                  <widget class="Gtk.Label" id="label2">
+                    <property name="MemberName" />
+                    <property name="LabelProp" translatable="yes">Name</property>
+                  </widget>
+                  <packing>
+                    <property name="Position">0</property>
+                    <property name="AutoSize">True</property>
+                    <property name="Expand">False</property>
+                    <property name="Fill">False</property>
+                  </packing>
+                </child>
+                <child>
+                  <widget class="Gtk.Entry" id="txtAppName">
+                    <property name="MemberName" />
+                    <property name="CanFocus">True</property>
+                    <property name="IsEditable">True</property>
+                    <property name="InvisibleChar">●</property>
+                  </widget>
+                  <packing>
+                    <property name="Position">1</property>
+                    <property name="AutoSize">True</property>
+                  </packing>
+                </child>
+              </widget>
+              <packing>
+                <property name="Position">1</property>
+                <property name="AutoSize">True</property>
+                <property name="Expand">False</property>
+                <property name="Fill">False</property>
+              </packing>
+            </child>
+          </widget>
+          <packing>
+            <property name="Position">0</property>
+            <property name="AutoSize">True</property>
+            <property name="Expand">False</property>
+            <property name="Fill">False</property>
+          </packing>
+        </child>
+      </widget>
+    </child>
+    <child internal-child="ActionArea">
+      <widget class="Gtk.HButtonBox" id="dialog1_ActionArea">
+        <property name="MemberName" />
+        <property name="Spacing">10</property>
+        <property name="BorderWidth">5</property>
+        <property name="Size">2</property>
+        <property name="LayoutStyle">End</property>
+        <child>
+          <widget class="Gtk.Button" id="buttonCancel">
+            <property name="MemberName" />
+            <property name="CanDefault">True</property>
+            <property name="CanFocus">True</property>
+            <property name="UseStock">True</property>
+            <property name="Type">StockItem</property>
+            <property name="StockId">gtk-cancel</property>
+            <property name="ResponseId">-6</property>
+            <property name="label">gtk-cancel</property>
+          </widget>
+          <packing>
+            <property name="Expand">False</property>
+            <property name="Fill">False</property>
+          </packing>
+        </child>
+        <child>
+          <widget class="Gtk.Button" id="buttonOk">
+            <property name="MemberName" />
+            <property name="CanDefault">True</property>
+            <property name="CanFocus">True</property>
+            <property name="UseStock">True</property>
+            <property name="Type">StockItem</property>
+            <property name="StockId">gtk-ok</property>
+            <property name="ResponseId">-5</property>
+            <property name="label">gtk-ok</property>
+          </widget>
+          <packing>
+            <property name="Position">1</property>
+            <property name="Expand">False</property>
+            <property name="Fill">False</property>
+          </packing>
+        </child>
+      </widget>
+    </child>
+  </widget>
+  <widget class="Gtk.Bin" id="PyBinding.Django.Gui.DjangoOptionsWidget" design-size="309 300">
+    <property name="MemberName" />
+    <property name="Visible">False</property>
+    <child>
+      <widget class="Gtk.VBox" id="vbox2">
+        <property name="MemberName" />
+        <property name="Spacing">6</property>
+        <child>
+          <widget class="Gtk.Label" id="label1">
+            <property name="MemberName" />
+            <property name="LabelProp" translatable="yes">&lt;span weight="bold"&gt;Django Options&lt;/span&gt;</property>
+            <property name="UseMarkup">True</property>
+          </widget>
+          <packing>
+            <property name="Position">0</property>
+            <property name="AutoSize">True</property>
+            <property name="Expand">False</property>
+            <property name="Fill">False</property>
+          </packing>
+        </child>
+        <child>
+          <widget class="Gtk.Table" id="table1">
+            <property name="MemberName" />
+            <property name="NRows">3</property>
+            <property name="NColumns">3</property>
+            <property name="RowSpacing">6</property>
+            <property name="ColumnSpacing">6</property>
+            <child>
+              <placeholder />
+            </child>
+            <child>
+              <placeholder />
+            </child>
+            <child>
+              <placeholder />
+            </child>
+            <child>
+              <placeholder />
+            </child>
+            <child>
+              <placeholder />
+            </child>
+            <child>
+              <widget class="Gtk.Label" id="label2">
+                <property name="MemberName" />
+                <property name="LabelProp" translatable="yes">Address</property>
+              </widget>
+              <packing>
+                <property name="TopAttach">1</property>
+                <property name="BottomAttach">2</property>
+                <property name="AutoSize">True</property>
+                <property name="XOptions">Fill</property>
+                <property name="YOptions">Fill</property>
+                <property name="XExpand">False</property>
+                <property name="XFill">True</property>
+                <property name="XShrink">False</property>
+                <property name="YExpand">False</property>
+                <property name="YFill">True</property>
+                <property name="YShrink">False</property>
+              </packing>
+            </child>
+            <child>
+              <widget class="Gtk.Label" id="label3">
+                <property name="MemberName" />
+                <property name="LabelProp" translatable="yes">Port</property>
+              </widget>
+              <packing>
+                <property name="AutoSize">True</property>
+                <property name="XOptions">Fill</property>
+                <property name="YOptions">Fill</property>
+                <property name="XExpand">False</property>
+                <property name="XFill">True</property>
+                <property name="XShrink">False</property>
+                <property name="YExpand">False</property>
+                <property name="YFill">True</property>
+                <property name="YShrink">False</property>
+              </packing>
+            </child>
+            <child>
+              <widget class="Gtk.Entry" id="txtAddress">
+                <property name="MemberName" />
+                <property name="CanFocus">True</property>
+                <property name="IsEditable">True</property>
+                <property name="InvisibleChar">●</property>
+              </widget>
+              <packing>
+                <property name="TopAttach">1</property>
+                <property name="BottomAttach">2</property>
+                <property name="LeftAttach">1</property>
+                <property name="RightAttach">2</property>
+                <property name="AutoSize">True</property>
+                <property name="YOptions">Fill</property>
+                <property name="XExpand">True</property>
+                <property name="XFill">True</property>
+                <property name="XShrink">False</property>
+                <property name="YExpand">False</property>
+                <property name="YFill">True</property>
+                <property name="YShrink">False</property>
+              </packing>
+            </child>
+            <child>
+              <widget class="Gtk.Entry" id="txtPort">
+                <property name="MemberName" />
+                <property name="CanFocus">True</property>
+                <property name="IsEditable">True</property>
+                <property name="InvisibleChar">●</property>
+              </widget>
+              <packing>
+                <property name="LeftAttach">1</property>
+                <property name="RightAttach">2</property>
+                <property name="AutoSize">True</property>
+                <property name="YOptions">Fill</property>
+                <property name="XExpand">True</property>
+                <property name="XFill">True</property>
+                <property name="XShrink">False</property>
+                <property name="YExpand">False</property>
+                <property name="YFill">True</property>
+                <property name="YShrink">False</property>
+              </packing>
+            </child>
+          </widget>
+          <packing>
+            <property name="Position">1</property>
+            <property name="AutoSize">True</property>
+          </packing>
+        </child>
+      </widget>
+    </child>
+  </widget>
 </stetic-interface>
\ No newline at end of file
Index: PyBinding/Resources/EmptyDjangoProject.xpt.xml
===================================================================
--- PyBinding/Resources/EmptyDjangoProject.xpt.xml	(revision 140459)
+++ PyBinding/Resources/EmptyDjangoProject.xpt.xml	(working copy)
@@ -15,8 +15,11 @@
 
     <!-- Template Content -->
     <Combine name = "${ProjectName}" directory = ".">
-        <Project name = "${ProjectName}" directory = "." type = "Python">
+        <Project name = "${ProjectName}" directory = "." type = "Django">
         	<Files>
+        		<Directory name="apps">
+        			<File name="__init__.py" AddStandardHeader="False"></File>
+        		</Directory>
         		<File name="__init__.py" AddStandardHeader="False"></File>
         		<File name="manage.py" AddStandardHeader="True">
         			<![CDATA[
Index: PyBinding/Makefile
===================================================================
--- PyBinding/Makefile	(revision 140459)
+++ PyBinding/Makefile	(working copy)
@@ -54,9 +54,19 @@
 FILES =  \
 	AssemblyInfo.cs \
 	gtk-gui/generated.cs \
+	gtk-gui/PyBinding.Django.Gui.AddAppDialog.cs \
+	gtk-gui/PyBinding.Django.Gui.DjangoOptionsWidget.cs \
 	gtk-gui/PyBinding.Gui.PythonOptionsWidget.cs \
 	PyBinding.Compiler/IPythonCompiler.cs \
 	PyBinding.Compiler/Python25Compiler.cs \
+	PyBinding.Django.Gui/AddAppDialog.cs \
+	PyBinding.Django.Gui/DjangoCommands.cs \
+	PyBinding.Django.Gui/DjangoOptionsPanel.cs \
+	PyBinding.Django.Gui/DjangoOptionsWidget.cs \
+	PyBinding.Django.Gui/FolderNodeBuilderExtension.cs \
+	PyBinding.Django/DjangoConfiguration.cs \
+	PyBinding.Django/DjangoProject.cs \
+	PyBinding.Django/DjangoProjectBinding.cs \
 	PyBinding.Gui.Navigation/AttributeNodeBuilder.cs \
 	PyBinding.Gui.Navigation/ClassNodeBuilder.cs \
 	PyBinding.Gui.Navigation/FunctionNodeBuilder.cs \
@@ -96,6 +106,9 @@
 DATA_FILES = 
 
 RESOURCES =  \
+	CodeTemplates/Django/__init__.py,CodeTemplates.Django.__init__.py \
+	CodeTemplates/Django/models.py,CodeTemplates.Django.models.py \
+	CodeTemplates/Django/views.py,CodeTemplates.Django.views.py \
 	gtk-gui/gui.stetic \
 	PyBinding.addin.xml \
 	Resources/BasicScriptPySourceFile.xft.xml \
@@ -103,8 +116,8 @@
 	Resources/EmptyDjangoProject.xpt.xml \
 	Resources/EmptyPyProject.xpt.xml \
 	Resources/EmptyPySourceFile.xft.xml \
-	Resources/PyClutterProject.xpt.xml \
-	Resources/PyGtkProject.xpt.xml \
+	Resources/PyClutterProject.xpt.xml,Resources.PyClutterProject.xpt.xml \
+	Resources/PyGtkProject.xpt.xml,Resources.PyGtkProject.xpt.xml \
 	Resources/py-icon-32.png \
 	Resources/text-x-pysrc.16x16.png 
 
@@ -112,6 +125,8 @@
 	monodevelop-pybinding.pc.in 
 
 REFERENCES =  \
+	../../../main/build/AddIns/MonoDevelop.TextTemplating/Mono.TextTemplating.dll \
+	../../../main/build/AddIns/MonoDevelop.TextTemplating/MonoDevelop.TextTemplating.dll \
 	Mono.Posix \
 	-pkg:gtk-sharp-2.0 \
 	-pkg:mono-addins \
