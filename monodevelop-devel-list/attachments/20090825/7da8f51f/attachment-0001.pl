Index: main/src/addins/VBNetBinding/ChangeLog
===================================================================
--- main/src/addins/VBNetBinding/ChangeLog	(revision 140585)
+++ main/src/addins/VBNetBinding/ChangeLog	(working copy)
@@ -1,3 +1,8 @@
+2009-08-25  Vikoria Dudka  <viktoriad@remobjects.com>
+
+	* VBBindingCompilerServices: Rewritten to make it NON GPL.
+	* VBLanguageBinding: Rewritten GPL parts.
+	
 2009-07-31  Lluis Sanchez Gual  <lluis@novell.com>
 
 	* gtk-gui/gui.stetic:
Index: main/src/addins/VBNetBinding/VBBindingCompilerServices.cs
===================================================================
--- main/src/addins/VBNetBinding/VBBindingCompilerServices.cs	(revision 140590)
+++ main/src/addins/VBNetBinding/VBBindingCompilerServices.cs	(working copy)
@@ -1,369 +1,302 @@
-//  VBBindingCompilerServices.cs
+// VBBindingCompilerServices.cs
 //
-//  This file was derived from a file from #Develop.
+// Author:
+//   Viktoria Dudka (viktoriad@remobjects.com)
 //
-//  Authors:
-//    Markus Palme <MarkusPalme@gmx.de>
-//    Rolf Bjarne Kvinge <RKvinge@novell.com>
+// Copyright (c) 2009 RemObjects Software
 //
-//  Copyright (C) 2001-2007 Markus Palme <MarkusPalme@gmx.de>
-//  Copyright (C) 2008 Novell, Inc (http://www.novell.com)
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
 using System;
+using System.Collections.Generic;
+using System.Linq;
 using System.Text;
-using System.Text.RegularExpressions;
-using System.Collections;
+using MonoDevelop.Projects;
+using MonoDevelop.Core;
 using System.IO;
-using System.Diagnostics;
+using MonoDevelop.Core.Execution;
 using System.CodeDom.Compiler;
-using System.Threading;
+using System.Text.RegularExpressions;
 
-using MonoDevelop.Core;
-using MonoDevelop.Core.Execution;
-using MonoDevelop.Core.Gui;
-using MonoDevelop.Core.Gui.Components;
-using MonoDevelop.Core.Serialization;
-using MonoDevelop.Projects;
-using MonoDevelop.Projects.Text;
-
-namespace MonoDevelop.VBNetBinding {
-	
-	/// <summary>
-	/// This class controls the compilation of VB.net files and VB.net projects
-	/// </summary>
-	public class VBBindingCompilerServices
+namespace MonoDevelop.VBNetBinding
+{
+	class VBBindingCompilerServices
 	{
-		//matches "/home/path/Default.aspx.vb (40,31) : Error VBNC30205: Expected end of statement."
-		//and "Error : VBNC99999: vbnc crashed nearby this location in the source code."
-		//and "Error : VBNC99999: Unexpected error: Object reference not set to an instance of an object" 
-		static Regex regexError = new Regex (@"^\s*((?<file>.*) \((?<line>\d*),(?<column>\d*)\) : )?(?<level>\w+) :? ?(?<number>[^:]*): (?<message>.*)$",
-		                                     RegexOptions.Compiled | RegexOptions.ExplicitCapture);
-		
-		string GenerateOptions (DotNetProjectConfiguration configuration, VBCompilerParameters compilerparameters, VBProjectParameters projectparameters, string outputFileName)
-		{
-			DotNetProject project = (DotNetProject) configuration.ParentItem;
-			StringBuilder sb = new StringBuilder ();
-			
-			sb.AppendFormat ("\"-out:{0}\"", outputFileName);
-			sb.AppendLine ();
-			
-			sb.AppendLine ("-nologo");
-			sb.AppendLine ("-utf8output");
+        public BuildResult Compile (ProjectItemCollection items, DotNetProjectConfiguration configuration, IProgressMonitor monitor)
+        {
+            VBCompilerParameters vbCompilerParameters;
+            if (configuration.CompilationParameters is VBCompilerParameters)
+                vbCompilerParameters = (VBCompilerParameters)configuration.CompilationParameters;
+            else
+                vbCompilerParameters = new VBCompilerParameters ();
 
-			sb.AppendFormat ("-debug:{0}", compilerparameters.DebugType);
-			sb.AppendLine ();
+            VBProjectParameters vbProjectParameters;
+            if (configuration.ProjectParameters is VBProjectParameters)
+                vbProjectParameters = (VBProjectParameters)configuration.ProjectParameters;
+            else
+                vbProjectParameters = new VBProjectParameters ();
 
-			if (compilerparameters.Optimize)
-				sb.AppendLine ("-optimize+");
+            string tempFileName = Path.GetTempFileName ();
+            StreamWriter streamWriter = new StreamWriter (tempFileName);
+            streamWriter.WriteLine (GenerateOptions (configuration, vbCompilerParameters, vbProjectParameters, configuration.CompiledOutputName));
 
-			
-			if (projectparameters.OptionStrict)
-				sb.AppendLine ("-optionstrict+");
-			else
-				sb.AppendLine ("-optionstrict-");
-			
-			if (projectparameters.OptionExplicit)
-				sb.AppendLine ("-optionexplicit+");
-			else
-				sb.AppendLine ("-optionexplicit-");
 
-			if (projectparameters.BinaryOptionCompare)
-				sb.AppendLine ("-optioncompare:binary");
-			else
-				sb.AppendLine ("-optioncompare:text");
+            foreach (ProjectReference projectReference in items.GetAll<ProjectReference> ()) {
+                foreach ( string referencedFileName in projectReference.GetReferencedFileNames(configuration.Id)) {
+                    streamWriter.WriteLine(String.Format("\"-r:{0}\"", referencedFileName));
+                }
+            }
 
-			if (projectparameters.OptionInfer)
-				sb.AppendLine ("-optioninfer+");
-			else
-				sb.AppendLine ("-optioninfer-");
+            foreach (ProjectFile projectFile in items.GetAll<ProjectFile> ()) {
+                if ((projectFile.Subtype != Subtype.Directory) && (projectFile.BuildAction == "Compile"))
+                    streamWriter.WriteLine (String.Format ("\"{0}\"", projectFile.Name));
 
-			string mytype = projectparameters.MyType;
-			if (!string.IsNullOrEmpty (mytype)) {
-				sb.AppendFormat ("-define:_MYTYPE=\\\"{0}\\\"", mytype);
-				sb.AppendLine ();
-			}
-			
-			string win32IconPath = projectparameters.ApplicationIcon;
-			if (!string.IsNullOrEmpty (win32IconPath) && File.Exists (win32IconPath)) {
-				sb.AppendFormat ("\"-win32icon:{0}\"", win32IconPath);
-				sb.AppendLine ();
-			}
+                if ((projectFile.Subtype != Subtype.Directory) && (projectFile.BuildAction == "EmbeddedResource")) {
+                    string name = "";
+                    if (String.Compare (Path.GetExtension (projectFile.Name), ".resx", StringComparison.InvariantCultureIgnoreCase) == 0)
+                        name = Path.ChangeExtension (name, ".resources");
+                    else
+                        name = projectFile.Name;
+                    streamWriter.WriteLine(String.Format("\"-resource:{0},{1}\"", name, projectFile.ResourceId));
+                }
+            }
 
-			if (!string.IsNullOrEmpty (projectparameters.CodePage)) {
-				TextEncoding enc = TextEncoding.GetEncoding (projectparameters.CodePage);
-				sb.AppendFormat ("-codepage:{0}", enc.CodePage);
-				sb.AppendLine ();
-			}
-			
-			if (!string.IsNullOrEmpty (project.DefaultNamespace)) {
-				sb.AppendFormat ("-rootnamespace:{0}", project.DefaultNamespace);
-				sb.AppendLine ();
-			}
-			
-			if (!string.IsNullOrEmpty (compilerparameters.DefineConstants)) {
-				sb.AppendFormat ("\"-define:{0}\"", compilerparameters.DefineConstants);
-				sb.AppendLine ();
-			}
+            foreach (Import import in items.GetAll<Import> ()) {
+                streamWriter.WriteLine (String.Format ("-imports:{0}", import.Include));
+            }
 
-			if (compilerparameters.DefineDebug)
-				sb.AppendLine ("-define:DEBUG=-1");
+            streamWriter.Close ();
 
-			if (compilerparameters.DefineTrace)
-				sb.AppendLine ("-define:TRACE=-1");
+            string CompilerName = "vbnc";
+            monitor.Log.WriteLine (String.Format("{0} {1}", CompilerName, String.Join(" ", File.ReadAllLines(tempFileName))));
 
-			if (compilerparameters.WarningsDisabled) {
-				sb.AppendLine ("-nowarn");
-			} else if (!string.IsNullOrEmpty (compilerparameters.NoWarn)) {
-				sb.AppendFormat ("-nowarn:{0}", compilerparameters.NoWarn);
-				sb.AppendLine ();
-			}
+            StringWriter outWriter = new StringWriter ();
+            int exitCode;
+            string outputString = "";
+            try {
+                ProcessWrapper processWrapper = Runtime.ProcessService.StartProcess (CompilerName, "@" + tempFileName, configuration.ParentItem != null ? configuration.ParentItem.BaseDirectory.ToString () : ".", outWriter, outWriter, null);
+                processWrapper.WaitForOutput ();
+                monitor.Log.WriteLine (outWriter.ToString ());
 
-			if (!string.IsNullOrEmpty (compilerparameters.WarningsAsErrors)) {
-				sb.AppendFormat ("-warnaserror+:{0}", compilerparameters.WarningsAsErrors);
-				sb.AppendLine ();
-			}
-			
-			if (configuration.SignAssembly) {
-				if (File.Exists (configuration.AssemblyKeyFile)) {
-					sb.AppendFormat ("\"-keyfile:{0}\"", configuration.AssemblyKeyFile);
-					sb.AppendLine ();
-				}
-			}
+                exitCode = processWrapper.ExitCode;
+                outputString = outWriter.ToString ();
+            }
+            finally {
+                outWriter.Dispose ();
+            }
 
-			if (!string.IsNullOrEmpty (compilerparameters.DocumentationFile)) {
-				sb.AppendFormat ("-doc:{0}", compilerparameters.DocumentationFile);
-				sb.AppendLine ();
-			}
+            TempFileCollection tempFileCollection = new TempFileCollection ();
+            BuildResult buildResult = ParseOutput (tempFileCollection, outputString);
+            if ((buildResult.Errors.Count == 0) && (exitCode != 0)) {
+                buildResult.AddError (outputString);
+            }
 
-			if (!string.IsNullOrEmpty (projectparameters.StartupObject) && projectparameters.StartupObject != "Sub Main") {
-				sb.Append ("-main:");
-				sb.Append (projectparameters.StartupObject);
-				sb.AppendLine ();
-			}
+            FileService.DeleteFile (tempFileName);
+            if (configuration.CompileTarget != CompileTarget.Library)
+                WriteManifestFile (configuration.CompiledOutputName);
 
-			if (compilerparameters.RemoveIntegerChecks)
-				sb.AppendLine ("-removeintchecks+");
-			
-			if (!string.IsNullOrEmpty (compilerparameters.AdditionalParameters)) {
-				sb.Append (compilerparameters.AdditionalParameters);
-				sb.AppendLine ();
-			}
-						
-			switch (configuration.CompileTarget) {
-				case CompileTarget.Exe:
-					sb.AppendLine ("-target:exe");
-					break;
-				case CompileTarget.WinExe:
-					sb.AppendLine ("-target:winexe");
-					break;
-				case CompileTarget.Library:
-					sb.AppendLine ("-target:library");
-					break;
-				case CompileTarget.Module:
-					sb.AppendLine ("-target:module");
-					break;
-				default:
-					throw new NotSupportedException("unknown compile target:" + configuration.CompileTarget);
-			}
-			
-			return sb.ToString();
-		}
-		
-		public BuildResult Compile (ProjectItemCollection items, DotNetProjectConfiguration configuration, IProgressMonitor monitor)
-		{
-			VBCompilerParameters compilerparameters = (VBCompilerParameters) configuration.CompilationParameters;
-			if (compilerparameters == null)
-				compilerparameters = new VBCompilerParameters ();
-			
-			VBProjectParameters projectparameters = (VBProjectParameters) configuration.ProjectParameters;
-			if (projectparameters == null)
-				projectparameters = new VBProjectParameters ();
-			
-			string exe = configuration.CompiledOutputName;
-			string responseFileName = Path.GetTempFileName();
-			StreamWriter writer = new StreamWriter (responseFileName);
-			
-			writer.WriteLine (GenerateOptions (configuration, compilerparameters, projectparameters, exe));
+            return buildResult;
+        }
 
-			// Write references
-			foreach (ProjectReference lib in items.GetAll<ProjectReference> ()) {
-				foreach (string fileName in lib.GetReferencedFileNames(configuration.Id)) {
-					writer.Write ("\"-r:");
-					writer.Write (fileName);
-					writer.WriteLine ("\"");
-				}
-			}
-			
-			// Write source files and embedded resources
-			foreach (ProjectFile finfo in items.GetAll<ProjectFile> ()) {
-				if (finfo.Subtype != Subtype.Directory) {
-					switch (finfo.BuildAction) {
-						case "Compile":
-							writer.WriteLine("\"" + finfo.Name + "\"");
-						break;
-						
-						case "EmbeddedResource":
-							string fname = finfo.Name;
-							if (String.Compare (Path.GetExtension (fname), ".resx", true) == 0)
-								fname = Path.ChangeExtension (fname, ".resources");
+        
 
-							writer.WriteLine("\"-resource:{0},{1}\"", fname, finfo.ResourceId);
-							break;
-						
-						default:
-							continue;
-					}
-				}
-			}
-			
-			// Write source files and embedded resources
-			foreach (Import import in items.GetAll<Import> ()) {
-				writer.WriteLine ("-imports:{0}", import.Include);
-			}
-			
-			TempFileCollection tf = new TempFileCollection ();
-			writer.Close();
-			
-			string output = "";
-			string compilerName = "vbnc";
-			string outstr = String.Concat (compilerName, " @", responseFileName);
-			
-			
-			string workingDir = ".";
-			if (configuration.ParentItem != null)
-				workingDir = configuration.ParentItem.BaseDirectory;
-			int exitCode;
-			
-			monitor.Log.WriteLine (compilerName + " " + string.Join (" ", File.ReadAllLines (responseFileName)));
-			exitCode = DoCompilation (outstr, tf, workingDir, ref output);
-			
-			monitor.Log.WriteLine (output);			                                                          
-			BuildResult result = ParseOutput (tf, output);
-			if (result.Errors.Count == 0 && exitCode != 0) {
-				// Compilation failed, but no errors?
-				// Show everything the compiler said.
-				result.AddError (output);
-			}
-			
-			FileService.DeleteFile (responseFileName);
-			if (configuration.CompileTarget != CompileTarget.Library) {
-				WriteManifestFile (exe);
-			}
-			return result;
-		}
-		
-		// code duplication: see C# backend : CSharpBindingCompilerManager
-		void WriteManifestFile(string fileName)
-		{
-			string manifestFile = String.Concat(fileName, ".manifest");
-			if (File.Exists(manifestFile)) {
-				return;
-			}
-			StreamWriter sw = new StreamWriter(manifestFile);
-			sw.WriteLine("<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?>");
-			sw.WriteLine("");
-			sw.WriteLine("<assembly xmlns=\"urn:schemas-microsoft-com:asm.v1\" manifestVersion=\"1.0\">");
-			sw.WriteLine("	<dependency>");
-			sw.WriteLine("		<dependentAssembly>");
-			sw.WriteLine("			<assemblyIdentity");
-			sw.WriteLine("				type=\"win32\"");
-			sw.WriteLine("				name=\"Microsoft.Windows.Common-Controls\"");
-			sw.WriteLine("				version=\"6.0.0.0\"");
-			sw.WriteLine("				processorArchitecture=\"X86\"");
-			sw.WriteLine("				publicKeyToken=\"6595b64144ccf1df\"");
-			sw.WriteLine("				language=\"*\"");
-			sw.WriteLine("			/>");
-			sw.WriteLine("		</dependentAssembly>");
-			sw.WriteLine("	</dependency>");
-			sw.WriteLine("</assembly>");
-			sw.Close();
-		}
-		
-		BuildResult ParseOutput(TempFileCollection tf, string output)
-		{
-			CompilerResults results = new CompilerResults (tf);
+        static Regex regexError = new Regex (@"^\s*((?<file>.*) \((?<line>\d*),(?<column>\d*)\) : )?(?<level>\w+) :? ?(?<number>[^:]*): (?<message>.*)$", RegexOptions.ExplicitCapture);
 
-			using (StringReader sr = new StringReader (output)) {			
-				while (true) {
-					string curLine = sr.ReadLine();
+        private static CompilerError CreateErrorFromString (string error_string)
+        {
+            Match match;
+            int i;
 
-					if (curLine == null) {
-						break;
-					}
-					
-					curLine = curLine.Trim();
-					if (curLine.Length == 0) {
-						continue;
-					}
-					
-					CompilerError error = CreateErrorFromString (curLine);
-					
-					if (error != null)
-						results.Errors.Add (error);
-				}
-			}
-			return new BuildResult (results, output);
-		}
-		
-		
-		private static CompilerError CreateErrorFromString (string error_string)
-		{
-			Match match;
-			int i;
-			
-			match = regexError.Match (error_string);
-			    
-			if (match.Success) {
-				CompilerError error = new CompilerError ();
+            match = regexError.Match (error_string);
 
-				error.IsWarning = match.Result ("${level}").ToLowerInvariant () == "warning";
-				error.ErrorNumber = match.Result("${number}");
-				error.ErrorText = match.Result("${message}");
-				error.FileName = match.Result ("${file}");
-				if (int.TryParse (match.Result ("${line}"), out i))
-					error.Line = i;
-				if (int.TryParse (match.Result ("${column}"), out i))
-					error.Column = i;
-				
-				// Workaround for bug #484351. Vbnc incorrectly emits this warning.
-				if (error.ErrorNumber == "VBNC2009" && error.ErrorText != null && error.ErrorText.IndexOf ("optioninfer") != -1)
-					return null;
-				
-				return error;
-			}
+            if (match.Success) {
+                CompilerError error = new CompilerError ();
 
-			return null;
-		}
-		
-		private int DoCompilation (string outstr, TempFileCollection tf, string working_dir, ref string output)
-		{
-			StringWriter outwr = new StringWriter ();
-			string[] tokens = outstr.Split (' ');			
-			try {
-				outstr = outstr.Substring (tokens[0].Length+1);
-				ProcessWrapper pw = Runtime.ProcessService.StartProcess (tokens[0], "\"" + outstr + "\"", working_dir, outwr, outwr, null);
-				pw.WaitForOutput ();
-				output = outwr.ToString ();
-				
-				return pw.ExitCode;
-			} finally {
-				if (outwr != null)
-					outwr.Dispose ();
-			}
-		}
+                error.IsWarning = match.Result ("${level}").ToLowerInvariant () == "warning";
+                error.ErrorNumber = match.Result ("${number}");
+                error.ErrorText = match.Result ("${message}");
+                error.FileName = match.Result ("${file}");
+                if (int.TryParse (match.Result ("${line}"), out i))
+                    error.Line = i;
+                if (int.TryParse (match.Result ("${column}"), out i))
+                    error.Column = i;
+
+                // Workaround for bug #484351. Vbnc incorrectly emits this warning.
+                if (error.ErrorNumber == "VBNC2009" && error.ErrorText != null && error.ErrorText.IndexOf ("optioninfer") != -1)
+                    return null;
+
+                return error;
+            }
+
+            return null;
+        }
+
+
+        private string GenerateOptions (DotNetProjectConfiguration configuration, VBCompilerParameters vbCompilerParameters, VBProjectParameters vbProjectParameters, string outputFileName)
+        {
+            StringBuilder stringBuilder = new StringBuilder ();
+
+            DotNetProject dotNetProject = (DotNetProject)configuration.ParentItem;
+
+            if (!String.IsNullOrEmpty (dotNetProject.DefaultNamespace)) {
+                stringBuilder.AppendLine (String.Format ("-rootnamespace:{0}", dotNetProject.DefaultNamespace));
+            }
+
+
+            stringBuilder.AppendLine (String.Format ("\"-out:{0}\"", outputFileName));
+            stringBuilder.AppendLine ("-nologo");
+            stringBuilder.AppendLine ("-utf8output");
+            stringBuilder.AppendLine (String.Format ("-debug:{0}", vbCompilerParameters.DebugType));
+
+
+            if (vbCompilerParameters.Optimize)
+                stringBuilder.AppendLine ("-optimize+");
+            else
+                stringBuilder.AppendLine ("-optimize-");
+
+            if ( vbProjectParameters.OptionStrict )
+                stringBuilder.AppendLine ("-optionstrict+");
+            else
+                stringBuilder.AppendLine ("-optionstrict-");
+
+            if (vbProjectParameters.OptionExplicit)
+                stringBuilder.AppendLine ("-optionexplicit+");
+            else
+                stringBuilder.AppendLine ("-optionexplicit-");
+
+            if (vbProjectParameters.OptionInfer)
+                stringBuilder.AppendLine ("-optioninfer+");
+            else
+                stringBuilder.AppendLine ("-optioninfer-");
+
+            if (vbCompilerParameters.RemoveIntegerChecks)
+                stringBuilder.AppendLine ("-remoteintchecks+");
+            else
+                stringBuilder.AppendLine ("-remoteintchecks-");
+
+            if (vbProjectParameters.BinaryOptionCompare)
+                stringBuilder.AppendLine ("-optioncompare:binary");
+            else
+                stringBuilder.AppendLine ("-optioncompare:text");
+
+
+
+            if ( !String.IsNullOrEmpty (vbProjectParameters.MyType))
+                stringBuilder.AppendLine(String.Format("-define:_MYTYPE=\\\"{0}\\\"", vbProjectParameters.MyType));
+
+            if (!String.IsNullOrEmpty (vbProjectParameters.ApplicationIcon) && File.Exists (vbProjectParameters.ApplicationIcon))
+                stringBuilder.AppendLine (String.Format ("\"-win32icon:{0}\"", vbProjectParameters.ApplicationIcon));
+
+            if (!String.IsNullOrEmpty (vbProjectParameters.CodePage))
+                stringBuilder.AppendLine (String.Format ("-codepage:{0}", vbProjectParameters.CodePage));
+
+            if (!String.IsNullOrEmpty (vbCompilerParameters.DefineConstants))
+                stringBuilder.AppendLine (String.Format ("\"-define:{0}\"", vbCompilerParameters.DefineConstants));
+
+            if (!String.IsNullOrEmpty (vbCompilerParameters.DocumentationFile))
+                stringBuilder.AppendLine (String.Format ("-doc:{0}", vbCompilerParameters.DocumentationFile));
+
+            if (!String.IsNullOrEmpty (vbProjectParameters.StartupObject))
+                stringBuilder.AppendLine (String.Format ("-main:{0}", vbProjectParameters.StartupObject));
+
+
+
+            if (vbCompilerParameters.DefineDebug) 
+                stringBuilder.AppendLine("-define:DEBUG=-1");
+
+            if (vbCompilerParameters.DefineTrace)
+                stringBuilder.AppendLine ("-define:TRACE=-1");
+
+            if (vbCompilerParameters.WarningsDisabled)
+                stringBuilder.AppendLine ("nowarn");
+            else if (!String.IsNullOrEmpty(vbCompilerParameters.NoWarn))
+                stringBuilder.AppendLine (String.Format ("\"-nowarn:{0}\"", vbCompilerParameters.NoWarn));
+
+            if ( !String.IsNullOrEmpty(vbCompilerParameters.WarningsAsErrors))
+                stringBuilder.AppendLine (String.Format("-warnaserror+:{0}", vbCompilerParameters.WarningsAsErrors));
+
+            if (!String.IsNullOrEmpty (vbCompilerParameters.AdditionalParameters))
+                stringBuilder.AppendLine (vbCompilerParameters.AdditionalParameters);
+
+
+
+            if (configuration.SignAssembly && File.Exists (configuration.AssemblyKeyFile))
+                stringBuilder.AppendLine (String.Format ("\"-keyfile:{0}\"", configuration.AssemblyKeyFile));
+
+            if (configuration.CompileTarget == CompileTarget.Exe)
+                stringBuilder.AppendLine ("-target:exe");
+            else if (configuration.CompileTarget == CompileTarget.WinExe)
+                stringBuilder.AppendLine ("-target:winexe");
+            else if (configuration.CompileTarget == CompileTarget.Library)
+                stringBuilder.AppendLine ("-target:library");
+            else if (configuration.CompileTarget == CompileTarget.Module)
+                stringBuilder.AppendLine ("-target:module");
+            else throw new NotSupportedException ("CompileTarget " + configuration.CompileTarget.ToString() + "not supported");
+
+            
+
+            return stringBuilder.ToString();
+        }
+
+        private BuildResult ParseOutput (TempFileCollection tempFileCollection, string output)
+        {
+            CompilerResults compilerResults = new CompilerResults (tempFileCollection);
+
+            StringReader stringReader = new StringReader (output);
+            string line = stringReader.ReadLine();
+            
+            while (line != null) {
+                line = line.Trim ();
+                if (!String.IsNullOrEmpty (line)) {
+                    CompilerError error = CreateErrorFromString (line);
+                    if (error != null)
+                        compilerResults.Errors.Add (error);
+                }
+                line = stringReader.ReadLine ();
+            }
+
+            return new BuildResult (compilerResults, output);
+        }
+
+        private void WriteManifestFile (string fileName)
+        {
+            string fullFileName = fileName + ".manifest";
+
+            if (!File.Exists (fullFileName)) {
+                File.WriteAllText ( fullFileName, 
+                                    "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?>" + 
+                                    "<assembly xmlns=\"urn:schemas-microsoft-com:asm.v1\" manifestVersion=\"1.0\">" +
+                                    "<dependency>" +
+                                    "<dependentAssembly>" +
+                                    "<assemblyIdentity" +
+                                    "type=\"win32\"" +
+                                    "name=\"Microsoft.Windows.Common-Controls\"" +
+                                    "version=\"6.0.0.0\"" +
+                                    "processorArchitecture=\"X86\"" +
+                                    "publicKeyToken=\"6595b64144ccf1df\"" +
+                                    "language=\"*\"" +
+                                    "/>" +
+                                    "</dependentAssembly>" +
+                                    "</dependency>" +
+                                    "</assembly>");
+            }
+        }
 	}
 }
Index: main/src/addins/VBNetBinding/VBLanguageBinding.cs
===================================================================
--- main/src/addins/VBNetBinding/VBLanguageBinding.cs	(revision 140590)
+++ main/src/addins/VBNetBinding/VBLanguageBinding.cs	(working copy)
@@ -1,22 +1,29 @@
 //  VBLanguageBinding.cs
 //
-//  This file was derived from a file from #Develop. 
+// Author:
+//   MonoDevelop Team
 //
-//  Copyright (C) 2001-2007 Markus Palme <MarkusPalme@gmx.de>
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
+//
 
 using System;
 using System.IO;
@@ -36,53 +43,54 @@
 {
 	public class VBLanguageBinding : IDotNetLanguageBinding
 	{
-		public const string LanguageName = "VBNet";
-		
-		VBBindingCompilerServices   compilerServices  = new VBBindingCompilerServices();
-		VBCodeProvider provider;
-		//TParser parser = new TParser ();
-		
-		public string Language {
-			get {
-				return LanguageName;
-			}
-		}
-		
-		public string ProjectStockIcon {
-			get { 
-				return "md-project";
-			}
-		}
-		
-		public bool IsSourceCodeFile (string fileName)
-		{
-			return Path.GetExtension(fileName) == ".vb";
-		}
-		
-		public BuildResult Compile (ProjectItemCollection items, DotNetProjectConfiguration configuration, IProgressMonitor monitor)
-		{
-			Debug.Assert(compilerServices != null);
-			return compilerServices.Compile (items, configuration, monitor);
-		}
-		
-		public ConfigurationParameters CreateCompilationParameters (XmlElement projectOptions)
-		{
-			return new VBCompilerParameters ();
-		}
-		
-		public string SingleLineCommentTag { get { return "'"; } }
-		public string BlockCommentStartTag { get { return null; } }
-		public string BlockCommentEndTag { get { return null; } }
-		
-		public CodeDomProvider GetCodeDomProvider ()
-		{
-			if (provider == null)
-				provider = new ImprovedCodeDomProvider ();
-			return provider;
-		}
-		
-		public string GetFileName (string baseName)
-		{
+        public VBLanguageBinding ()
+        {
+            compilerServices = new VBBindingCompilerServices ();
+        }
+
+        public string Language
+        {
+            get { return "VBNet"; }
+        }
+
+        public string ProjectStockIcon
+        {
+            get
+            {
+                return "md-project";
+            }
+        }
+
+        public bool IsSourceCodeFile (string fileName)
+        {
+            return Path.GetExtension (fileName) == ".vb";
+        }
+
+        private VBBindingCompilerServices compilerServices;
+        public BuildResult Compile (ProjectItemCollection items, DotNetProjectConfiguration configuration, IProgressMonitor monitor)
+        {
+            return compilerServices.Compile (items, configuration, monitor);
+        }
+
+        public ConfigurationParameters CreateCompilationParameters (XmlElement projectOptions)
+        {
+            return new VBCompilerParameters ();
+        }
+
+        public string SingleLineCommentTag { get { return "'"; } }
+        public string BlockCommentStartTag { get { return null; } }
+        public string BlockCommentEndTag { get { return null; } }
+
+        private ImprovedCodeDomProvider provider;
+        public CodeDomProvider GetCodeDomProvider ()
+        {
+            if (provider == null)
+                provider = new ImprovedCodeDomProvider ();
+            return provider;
+        }
+
+        public string GetFileName (string baseName)
+        {
 			return baseName + ".vb";
 		}
 		