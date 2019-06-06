Index: Microsoft.Build.Tasks.dll.sources
===================================================================
--- Microsoft.Build.Tasks.dll.sources	(wersja 66839)
+++ Microsoft.Build.Tasks.dll.sources	(kopia robocza)
@@ -88,6 +88,9 @@
 Microsoft.Build.Tasks/SignFile.cs
 Microsoft.Build.Tasks/TaskExtension.cs
 Microsoft.Build.Tasks/ToolTaskExtension.cs
+Microsoft.Build.Tasks/UpdateManifest.cs
+Microsoft.Build.Tasks/Vbc.cs
+Microsoft.Build.Tasks/VCBuild.cs
 Microsoft.Build.Tasks/Touch.cs
 Microsoft.Build.Tasks/UnregisterAssembly.cs
 Microsoft.Build.Tasks/Warning.cs
@@ -96,3 +99,5 @@
 Mono.XBuild.Tasks.GenerateResourceInternal/PoResourceWriter.cs
 Mono.XBuild.Tasks.GenerateResourceInternal/TxtResourceReader.cs
 Mono.XBuild.Tasks.GenerateResourceInternal/TxtResourceWriter.cs
+Microsoft.Build.Tasks/CreateTemporaryVCProject.cs
+Microsoft.Build.Tasks/GenerateDeploymentManifest.cs
Index: Microsoft.Build.Tasks/CreateTemporaryVCProject.cs
===================================================================
--- Microsoft.Build.Tasks/CreateTemporaryVCProject.cs	(wersja 0)
+++ Microsoft.Build.Tasks/CreateTemporaryVCProject.cs	(wersja 0)
@@ -0,0 +1,113 @@
+//
+//// CreateTemporaryVCProject.cs
+/////
+///// Author:
+/////      Leszek Ciesielski  <skolima@gmail.com>
+/////
+///// Copyright (C) 2006 Forcom (http://www.forcom.com.pl/)
+/////
+///// Permission is hereby granted, free of charge, to any person obtaining
+///// a copy of this software and associated documentation files (the
+///// "Software"), to deal in the Software without restriction, including
+///// without limitation the rights to use, copy, modify, merge, publish,
+///// distribute, sublicense, and/or sell copies of the Software, and to
+///// permit persons to whom the Software is furnished to do so, subject to
+///// the following conditions:
+///// 
+///// The above copyright notice and this permission notice shall be
+///// included in all copies or substantial portions of the Software.
+///// 
+///// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+///// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+///// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+///// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
+///// LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
+///// OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
+///// WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+/////
+
+using System;
+using Microsoft.Build.Framework;
+using Microsoft.Build.Utilities;
+
+namespace Microsoft.Build.Tasks
+{
+	public class CreateTemporaryVCProject : TaskExtension
+	{
+		[MonoTODO]
+		public CreateTemporaryVCProject ()
+		{
+			throw new NotImplementedException ();
+		}
+		
+		[MonoTODO]
+		[Required]
+		public string Configuration {
+			get {
+				throw new NotImplementedException ();
+			}
+			set {
+				throw new NotImplementedException ();
+			}
+		}
+		
+		[MonoTODO]
+		[Required]
+		public ITaskItem OutputProjectFile {
+			get {
+				throw new NotImplementedException ();
+			}
+			set {
+				throw new NotImplementedException ();
+			}
+		}
+		
+		[MonoTODO]
+		[Required]
+		public ITaskItem ProjectFile {
+			get {
+				throw new NotImplementedException ();
+			}
+			set {
+				throw new NotImplementedException ();
+			}
+		}
+		
+		[MonoTODO]
+		public ITaskItem[] ReferenceAssemblies {
+			get {
+				throw new NotImplementedException ();
+			}
+			set {
+				throw new NotImplementedException ();
+			}
+		}
+		
+		[MonoTODO]
+		[Required]
+		public ITaskItem[] ReferenceGuids {
+			get {
+				throw new NotImplementedException ();
+			}
+			set {
+				throw new NotImplementedException ();
+			}
+		}
+		
+		[MonoTODO]
+		public ITaskItem[] ReferenceImportLibraries {
+			get {
+				throw new NotImplementedException ();
+			}
+			set {
+				throw new NotImplementedException ();
+			}
+		}
+		
+		[MonoTODO]
+		public override bool Execute ()
+		{
+			throw new NotImplementedException ();
+		}
+	}
+}
Index: Microsoft.Build.Tasks/VCBuild.cs
===================================================================
--- Microsoft.Build.Tasks/VCBuild.cs	(wersja 0)
+++ Microsoft.Build.Tasks/VCBuild.cs	(wersja 0)
@@ -0,0 +1,183 @@
+//
+//// UpdateManifest.cs
+/////
+///// Author:
+/////      Leszek Ciesielski  <skolima@gmail.com>
+/////
+///// Copyright (C) 2006 Forcom (http://www.forcom.com.pl/)
+/////
+///// Permission is hereby granted, free of charge, to any person obtaining
+///// a copy of this software and associated documentation files (the
+///// "Software"), to deal in the Software without restriction, including
+///// without limitation the rights to use, copy, modify, merge, publish,
+///// distribute, sublicense, and/or sell copies of the Software, and to
+///// permit persons to whom the Software is furnished to do so, subject to
+///// the following conditions:
+///// 
+///// The above copyright notice and this permission notice shall be
+///// included in all copies or substantial portions of the Software.
+///// 
+///// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+///// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+///// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+///// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
+///// LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
+///// OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
+///// WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+/////
+
+using System;
+using System.Collections.Specialized;
+using Microsoft.Build.Framework;
+
+namespace Microsoft.Build.Tasks
+{
+	public class VCBuild : ToolTaskExtension
+	{
+		[MonoTODO]
+		public VCBuild ()
+		{
+			throw new NotImplementedException ();
+		}
+
+		[MonoTODO]
+		public ITaskItem[] AdditionalLibPaths {
+			get {
+				throw new NotImplementedException ();
+			}
+			set {
+				throw new NotImplementedException ();
+			}
+		}
+
+		[MonoTODO]
+		public string AdditionalOptions {
+			get {
+				throw new NotImplementedException ();
+			}
+			set {
+				throw new NotImplementedException ();
+			}
+		}
+
+		[MonoTODO]
+		public bool Clean {
+			get {
+				throw new NotImplementedException ();
+			}
+			set {
+				throw new NotImplementedException ();
+			}
+		}
+
+		[MonoTODO]
+		public string Configuration {
+			get {
+				throw new NotImplementedException ();
+			}
+			set {
+				throw new NotImplementedException ();
+			}
+		}
+
+		[MonoTODO]
+		public ITaskItem Override {
+			get {
+				throw new NotImplementedException ();
+			}
+			set {
+				throw new NotImplementedException ();
+			}
+		}
+
+		[MonoTODO]
+		public string Platform {
+			get {
+				throw new NotImplementedException ();
+			}
+			set {
+				throw new NotImplementedException ();
+			}
+		}
+
+		[MonoTODO]
+		[Required]
+		public ITaskItem[] Projects {
+			get {
+				throw new NotImplementedException ();
+			}
+			set {
+				throw new NotImplementedException ();
+			}
+		}
+
+		[MonoTODO]
+		public bool Rebuild {
+			get {
+				throw new NotImplementedException ();
+			}
+			set {
+				throw new NotImplementedException();
+			}
+		}
+
+		[MonoTODO]
+		public ITaskItem SolutionFile {
+			get {
+				throw new NotImplementedException ();
+			}
+			set {
+				throw new NotImplementedException ();
+			}
+		}
+
+		[MonoTODO]
+		public bool UserEnvironment {
+			get {
+				throw new NotImplementedException ();
+			}
+			set {
+				throw new NotImplementedException ();
+			}
+		}
+
+		[MonoTODO]
+		protected virtual StringDictionary EnvironmentOverride {
+			get {
+				throw new NotImplementedException ();
+			}
+		}
+
+		[MonoTODO]
+		protected override string ToolName {
+			get {
+				throw new NotImplementedException ();
+			}
+		}
+
+		[MonoTODO]
+		public override bool Execute ()
+		{
+			throw new NotImplementedException ();
+		}
+
+		[MonoTODO]
+		protected internal override void AddCommandLineCommands (
+				CommandLineBuilderExtension commandLine )
+		{
+			throw new NotImplementedException ();
+		}
+
+		[MonoTODO]
+		protected override string GenerateFullPathToTool ()
+		{
+			throw new NotImplementedException ();
+		}
+
+		[MonoTODO]
+		protected override bool ValidateParameters ()
+		{
+			throw new NotImplementedException ();
+		}
+	}
+}
Index: Microsoft.Build.Tasks/ToolTaskExtension.cs
===================================================================
--- Microsoft.Build.Tasks/ToolTaskExtension.cs	(wersja 66839)
+++ Microsoft.Build.Tasks/ToolTaskExtension.cs	(kopia robocza)
@@ -88,7 +88,9 @@
 		public new TaskLoggingHelper Log {
 			get { return base.Log; }
 		}
+
+		internal ToolTaskExtension () {}
 	}
 }
 
-#endif
\ brakuje znaku końca linii na końcu pliku 
+#endif
Index: Microsoft.Build.Tasks/TaskExtension.cs
===================================================================
--- Microsoft.Build.Tasks/TaskExtension.cs	(wersja 66839)
+++ Microsoft.Build.Tasks/TaskExtension.cs	(kopia robocza)
@@ -35,7 +35,8 @@
 		public new TaskLoggingHelper Log {
 			get { return base.Log; }
 		}
+		internal TaskExtension () {}
 	}
 }
 
-#endif
\ brakuje znaku końca linii na końcu pliku 
+#endif
Index: Microsoft.Build.Tasks/UpdateManifest.cs
===================================================================
--- Microsoft.Build.Tasks/UpdateManifest.cs	(wersja 0)
+++ Microsoft.Build.Tasks/UpdateManifest.cs	(wersja 0)
@@ -0,0 +1,94 @@
+//
+//// UpdateManifest.cs
+/////
+///// Author:
+/////      Leszek Ciesielski  <skolima@gmail.com>
+/////
+///// Copyright (C) 2006 Forcom (http://www.forcom.com.pl/)
+/////
+///// Permission is hereby granted, free of charge, to any person obtaining
+///// a copy of this software and associated documentation files (the
+///// "Software"), to deal in the Software without restriction, including
+///// without limitation the rights to use, copy, modify, merge, publish,
+///// distribute, sublicense, and/or sell copies of the Software, and to
+///// permit persons to whom the Software is furnished to do so, subject to
+///// the following conditions:
+///// 
+///// The above copyright notice and this permission notice shall be
+///// included in all copies or substantial portions of the Software.
+///// 
+///// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+///// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+///// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+///// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
+///// LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
+///// OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
+///// WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+/////
+///
+
+using System;
+using Microsoft.Build.Utilities;
+using Microsoft.Build.Framework;
+
+namespace Microsoft.Build.Tasks
+{
+	public class UpdateManifest : Task
+	{
+		[MonoTODO]
+		public UpdateManifest ()
+		{
+			throw new NotImplementedException ();
+		}
+
+		[MonoTODO]
+		[Required]
+		public ITaskItem ApplicationManifest {
+			get {
+				throw new NotImplementedException ();
+			}
+			set {
+				throw new NotImplementedException ();
+			}
+		}
+
+		[MonoTODO]
+		[Required]
+		public string ApplicationPath {
+			get {
+				throw new NotImplementedException ();
+			}
+			set {
+				throw new NotImplementedException ();
+			}
+		}
+
+		[MonoTODO]
+		[Required]
+		public ITaskItem InputManifest {
+			get {
+				throw new NotImplementedException ();
+			}
+			set {
+				throw new NotImplementedException ();
+			}
+		}
+
+		[MonoTODO]
+		[Output]
+		public ITaskItem OutputManifest {
+                        get {
+				throw new NotImplementedException ();
+			}
+                        set {
+                                throw new NotImplementedException ();
+                        }
+                }
+
+		[MonoTODO]
+		public override bool Execute ()
+		{
+			throw new NotImplementedException ();
+		}
+	}
+}
Index: Microsoft.Build.Tasks/Vbc.cs
===================================================================
--- Microsoft.Build.Tasks/Vbc.cs	(wersja 0)
+++ Microsoft.Build.Tasks/Vbc.cs	(wersja 0)
@@ -0,0 +1,291 @@
+//
+//// UpdateManifest.cs
+/////
+///// Author:
+/////      Leszek Ciesielski  <skolima@gmail.com>
+/////
+///// Copyright (C) 2006 Forcom (http://www.forcom.com.pl/)
+/////
+///// Permission is hereby granted, free of charge, to any person obtaining
+///// a copy of this software and associated documentation files (the
+///// "Software"), to deal in the Software without restriction, including
+///// without limitation the rights to use, copy, modify, merge, publish,
+///// distribute, sublicense, and/or sell copies of the Software, and to
+///// permit persons to whom the Software is furnished to do so, subject to
+///// the following conditions:
+///// 
+///// The above copyright notice and this permission notice shall be
+///// included in all copies or substantial portions of the Software.
+///// 
+///// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+///// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+///// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+///// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
+///// LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
+///// OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
+///// WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+/////
+
+using System;
+using Microsoft.Build.Framework;
+using Microsoft.Build.Utilities;
+
+namespace Microsoft.Build.Tasks
+{
+	public class Vbc : ManagedCompiler
+	{
+		[MonoTODO]
+		protected override bool ValidateParameters ()
+		{
+			throw new NotImplementedException ();
+		}
+		
+		[MonoTODO]
+		public string RootNamespace {
+			get {
+				throw new NotImplementedException ();
+			}
+			set {
+				throw new NotImplementedException ();
+			}
+		}
+		
+		[MonoTODO]
+		public string SdkPath {
+			get {
+				throw new NotImplementedException ();
+			}
+			set {
+				throw new NotImplementedException ();
+			}
+		}
+		
+		[MonoTODO]
+		public bool TargetCompactFramework {
+			get {
+				throw new NotImplementedException ();
+			}
+			set {
+				throw new NotImplementedException ();
+			}
+		}
+		
+		[MonoTODO]
+		public bool UseHostCompilerIfAvailable {
+			get {
+				throw new NotImplementedException ();
+			}
+			set {
+				throw new NotImplementedException ();
+			}
+		}
+		
+		[MonoTODO]
+		public string Verbosity {
+			get {
+				throw new NotImplementedException ();
+			}
+			set {
+				throw new NotImplementedException ();
+			}
+		}
+		
+		[MonoTODO]
+		public string WarningsAsErrors {
+			get {
+				throw new NotImplementedException ();
+			}
+			set {
+				throw new NotImplementedException ();
+			}
+		}
+		
+		[MonoTODO]
+		public string WarningsNotAsErrors {
+			get {
+				throw new NotImplementedException ();
+			}
+			set {
+				throw new NotImplementedException ();
+			}
+		}
+		
+		[MonoTODO]
+		protected override string ToolName {
+			get {
+				throw new NotImplementedException ();
+			}
+		}
+		
+		[MonoTODO]
+		protected internal override void AddResponseFileCommands (
+				CommandLineBuilderExtension commandLine )
+		{
+			throw new NotImplementedException ();
+		}
+		
+		[MonoTODO]
+		protected override bool CallHostObjectToExecute ()
+		{
+			throw new NotImplementedException ();
+		}
+		
+		[MonoTODO]
+		protected override string GenerateFullPathToTool ()
+		{
+			throw new NotImplementedException ();
+		}
+		
+		[MonoTODO]
+		protected override HostObjectInitializationStatus InitializeHostObject ()
+		{
+			throw new NotImplementedException ();
+		}
+		
+		[MonoTODO]
+		public Vbc ()
+		{
+			throw new NotImplementedException ();
+		}
+		
+		[MonoTODO]
+		public string BaseAddress {
+			get {
+				throw new NotImplementedException ();
+			}
+			set {
+				throw new NotImplementedException ();
+			}
+		}
+		
+		[MonoTODO]
+		public string DisabledWarnings  {
+			get {
+				throw new NotImplementedException ();
+			}
+			set {
+				throw new NotImplementedException ();
+			}
+		}
+		
+		[MonoTODO]
+		public string DocumentationFile {
+			get {
+				throw new NotImplementedException ();
+			}
+			set {
+				throw new NotImplementedException ();
+			}
+		}
+		
+		[MonoTODO]
+		public string ErrorReport {
+			get {
+				throw new NotImplementedException ();
+			}
+			set {
+				throw new NotImplementedException ();
+			}
+		}
+		
+		[MonoTODO]
+		public bool GenerateDocumentation {
+			get {
+				throw new NotImplementedException ();
+			}
+			set {
+				throw new NotImplementedException ();
+			}
+		}
+		
+		[MonoTODO]
+		public ITaskItem[] Imports {
+			get {
+				throw new NotImplementedException ();
+			}
+			set {
+				throw new NotImplementedException ();
+			}
+		}
+		
+		[MonoTODO]
+		public bool NoStandardLib {
+			get {
+				throw new NotImplementedException ();
+			}
+			set {
+				throw new NotImplementedException ();
+			}
+		}
+		
+		[MonoTODO]
+		public bool NoWarnings {
+			get {
+				throw new NotImplementedException ();
+			}
+			set {
+				throw new NotImplementedException ();
+			}
+		}
+		
+		[MonoTODO]
+		public string OptionCompare {
+			get {
+				throw new NotImplementedException ();
+			}
+			set {
+				throw new NotImplementedException ();
+			}
+		}
+		
+		[MonoTODO]
+		public bool OptionExplicit {
+			get {
+				throw new NotImplementedException ();
+			}
+			set {
+				throw new NotImplementedException ();
+			}
+		}
+		
+		[MonoTODO]
+		public bool OptionStrict {
+			get {
+				throw new NotImplementedException ();
+			}
+			set {
+				throw new NotImplementedException ();
+			}
+		}
+		
+		[MonoTODO]
+		public string OptionStrictType {
+			get {
+				throw new NotImplementedException ();
+			}
+			set {
+				throw new NotImplementedException ();
+			}
+		}
+		
+		[MonoTODO]
+		public string Platform {
+			get {
+				throw new NotImplementedException ();
+			}
+			set {
+				throw new NotImplementedException ();
+			}
+		}
+		
+		[MonoTODO]
+		public bool RemoveIntegerChecks {
+			get {
+				throw new NotImplementedException ();
+			}
+			set {
+				throw new NotImplementedException ();
+			}
+		}
+	}
+}
Index: Microsoft.Build.Tasks/GenerateDeploymentManifest.cs
===================================================================
--- Microsoft.Build.Tasks/GenerateDeploymentManifest.cs	(wersja 0)
+++ Microsoft.Build.Tasks/GenerateDeploymentManifest.cs	(wersja 0)
@@ -0,0 +1,193 @@
+//
+//// GenerateDeploymentManifest.cs
+/////
+///// Author:
+/////      Leszek Ciesielski  <skolima@gmail.com>
+/////
+///// Copyright (C) 2006 Forcom (http://www.forcom.com.pl/)
+/////
+///// Permission is hereby granted, free of charge, to any person obtaining
+///// a copy of this software and associated documentation files (the
+///// "Software"), to deal in the Software without restriction, including
+///// without limitation the rights to use, copy, modify, merge, publish,
+///// distribute, sublicense, and/or sell copies of the Software, and to
+///// permit persons to whom the Software is furnished to do so, subject to
+///// the following conditions:
+///// 
+///// The above copyright notice and this permission notice shall be
+///// included in all copies or substantial portions of the Software.
+///// 
+///// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+///// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+///// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+///// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
+///// LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
+///// OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
+///// WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+/////
+
+using System;
+using Microsoft.Build.Framework;
+using Microsoft.Build.Utilities;
+
+namespace Microsoft.Build.Tasks
+{
+	public sealed class GenerateDeploymentManifest : GenerateManifestBase
+	{
+		[MonoTODO]
+		public GenerateDeploymentManifest ()
+		{
+			throw new NotImplementedException ();
+		}
+		
+		[MonoTODO]
+		public string DeploymentUrl {
+			get {
+				throw new NotImplementedException ();
+			}
+			set {
+				throw new NotImplementedException ();
+			}
+		}
+		
+		[MonoTODO]
+		public bool DisallowUrlActivation {
+			get {
+				throw new NotImplementedException ();
+			}
+			set {
+				throw new NotImplementedException ();
+			}
+		}
+		
+		[MonoTODO]
+		public bool Install {
+			get {
+				throw new NotImplementedException ();
+			}
+			set {
+				throw new NotImplementedException ();
+			}
+		}
+		
+		[MonoTODO]
+		public bool MapFileExtensions {
+			get {
+				throw new NotImplementedException ();
+			}
+			set {
+				throw new NotImplementedException ();
+			}
+		}
+		
+		[MonoTODO]
+		public string MinimumRequiredVersion {
+			get {
+				throw new NotImplementedException ();
+			}
+			set {
+				throw new NotImplementedException ();
+			}
+		}
+		
+		[MonoTODO]
+		public string Product {
+			get {
+				throw new NotImplementedException ();
+			}
+			set {
+				throw new NotImplementedException ();
+			}
+		}
+		
+		[MonoTODO]
+		public string Publisher {
+			get {
+				throw new NotImplementedException ();
+			}
+			set {
+				throw new NotImplementedException ();
+			}
+		}
+		
+		[MonoTODO]
+		public string SupportUrl {
+			get {
+				throw new NotImplementedException ();
+			}
+			set {
+				throw new NotImplementedException ();
+			}
+		}
+		
+		[MonoTODO]
+		public bool TrustUrlParameters {
+			get {
+				throw new NotImplementedException ();
+			}
+			set {
+				throw new NotImplementedException ();
+			}
+		}
+		
+		[MonoTODO]
+		public bool UpdateEnabled {
+			get {
+				throw new NotImplementedException ();
+			}
+			set {
+				throw new NotImplementedException ();
+			}
+		}
+		
+		[MonoTODO]
+		public int UpdateInterval {
+			get {
+				throw new NotImplementedException ();
+			}
+			set {
+				throw new NotImplementedException ();
+			}
+		}
+		
+		[MonoTODO]
+		public string UpdateMode {
+			get {
+				throw new NotImplementedException ();
+			}
+			set {
+				throw new NotImplementedException ();
+			}
+		}
+		
+		[MonoTODO]
+		public string UpdateUnit {
+			get {
+				throw new NotImplementedException ();
+			}
+			set {
+				throw new NotImplementedException ();
+			}
+		}
+		
+		protected internal override bool ValidateInputs ()
+		{
+			throw new NotImplementedException ();
+		}
+		
+		protected override Type GetObjectType ()
+		{
+			throw new NotImplementedException ();
+		}
+		
+		protected override bool OnManifestLoaded(Microsoft.Build.Tasks.Deployment.ManifestUtilities.Manifest manifest)
+		{
+			throw new NotImplementedException ();
+		}
+		
+		protected override bool OnManifestResolved(Microsoft.Build.Tasks.Deployment.ManifestUtilities.Manifest manifest)
+		{
+			throw new NotImplementedException ();
+		}
+	}
+}