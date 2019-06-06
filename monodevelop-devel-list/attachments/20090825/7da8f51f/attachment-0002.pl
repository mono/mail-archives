// VBBindingCompilerServices.cs
//
// Author:
//   Viktoria Dudka (viktoriad@remobjects.com)
//
// Copyright (c) 2009 RemObjects Software
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//
//
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using MonoDevelop.Projects;
using MonoDevelop.Core;
using System.IO;
using MonoDevelop.Core.Execution;
using System.CodeDom.Compiler;
using System.Text.RegularExpressions;

namespace MonoDevelop.VBNetBinding
{
	class VBBindingCompilerServices
	{
        public BuildResult Compile (ProjectItemCollection items, DotNetProjectConfiguration configuration, IProgressMonitor monitor)
        {
            VBCompilerParameters vbCompilerParameters;
            if (configuration.CompilationParameters is VBCompilerParameters)
                vbCompilerParameters = (VBCompilerParameters)configuration.CompilationParameters;
            else
                vbCompilerParameters = new VBCompilerParameters ();

            VBProjectParameters vbProjectParameters;
            if (configuration.ProjectParameters is VBProjectParameters)
                vbProjectParameters = (VBProjectParameters)configuration.ProjectParameters;
            else
                vbProjectParameters = new VBProjectParameters ();

            string tempFileName = Path.GetTempFileName ();
            StreamWriter streamWriter = new StreamWriter (tempFileName);
            streamWriter.WriteLine (GenerateOptions (configuration, vbCompilerParameters, vbProjectParameters, configuration.CompiledOutputName));


            foreach (ProjectReference projectReference in items.GetAll<ProjectReference> ()) {
                foreach ( string referencedFileName in projectReference.GetReferencedFileNames(configuration.Id)) {
                    streamWriter.WriteLine(String.Format("\"-r:{0}\"", referencedFileName));
                }
            }

            foreach (ProjectFile projectFile in items.GetAll<ProjectFile> ()) {
                if ((projectFile.Subtype != Subtype.Directory) && (projectFile.BuildAction == "Compile"))
                    streamWriter.WriteLine (String.Format ("\"{0}\"", projectFile.Name));

                if ((projectFile.Subtype != Subtype.Directory) && (projectFile.BuildAction == "EmbeddedResource")) {
                    string name = "";
                    if (String.Compare (Path.GetExtension (projectFile.Name), ".resx", StringComparison.InvariantCultureIgnoreCase) == 0)
                        name = Path.ChangeExtension (name, ".resources");
                    else
                        name = projectFile.Name;
                    streamWriter.WriteLine(String.Format("\"-resource:{0},{1}\"", name, projectFile.ResourceId));
                }
            }

            foreach (Import import in items.GetAll<Import> ()) {
                streamWriter.WriteLine (String.Format ("-imports:{0}", import.Include));
            }

            streamWriter.Close ();

            string CompilerName = "vbnc";
            monitor.Log.WriteLine (String.Format("{0} {1}", CompilerName, String.Join(" ", File.ReadAllLines(tempFileName))));

            StringWriter outWriter = new StringWriter ();
            int exitCode;
            string outputString = "";
            try {
                ProcessWrapper processWrapper = Runtime.ProcessService.StartProcess (CompilerName, "@" + tempFileName, configuration.ParentItem != null ? configuration.ParentItem.BaseDirectory.ToString () : ".", outWriter, outWriter, null);
                processWrapper.WaitForOutput ();
                monitor.Log.WriteLine (outWriter.ToString ());

                exitCode = processWrapper.ExitCode;
                outputString = outWriter.ToString ();
            }
            finally {
                outWriter.Dispose ();
            }

            TempFileCollection tempFileCollection = new TempFileCollection ();
            BuildResult buildResult = ParseOutput (tempFileCollection, outputString);
            if ((buildResult.Errors.Count == 0) && (exitCode != 0)) {
                buildResult.AddError (outputString);
            }

            FileService.DeleteFile (tempFileName);
            if (configuration.CompileTarget != CompileTarget.Library)
                WriteManifestFile (configuration.CompiledOutputName);

            return buildResult;
        }

        

        static Regex regexError = new Regex (@"^\s*((?<file>.*) \((?<line>\d*),(?<column>\d*)\) : )?(?<level>\w+) :? ?(?<number>[^:]*): (?<message>.*)$", RegexOptions.ExplicitCapture);

        private static CompilerError CreateErrorFromString (string error_string)
        {
            Match match;
            int i;

            match = regexError.Match (error_string);

            if (match.Success) {
                CompilerError error = new CompilerError ();

                error.IsWarning = match.Result ("${level}").ToLowerInvariant () == "warning";
                error.ErrorNumber = match.Result ("${number}");
                error.ErrorText = match.Result ("${message}");
                error.FileName = match.Result ("${file}");
                if (int.TryParse (match.Result ("${line}"), out i))
                    error.Line = i;
                if (int.TryParse (match.Result ("${column}"), out i))
                    error.Column = i;

                // Workaround for bug #484351. Vbnc incorrectly emits this warning.
                if (error.ErrorNumber == "VBNC2009" && error.ErrorText != null && error.ErrorText.IndexOf ("optioninfer") != -1)
                    return null;

                return error;
            }

            return null;
        }


        private string GenerateOptions (DotNetProjectConfiguration configuration, VBCompilerParameters vbCompilerParameters, VBProjectParameters vbProjectParameters, string outputFileName)
        {
            StringBuilder stringBuilder = new StringBuilder ();

            DotNetProject dotNetProject = (DotNetProject)configuration.ParentItem;

            if (!String.IsNullOrEmpty (dotNetProject.DefaultNamespace)) {
                stringBuilder.AppendLine (String.Format ("-rootnamespace:{0}", dotNetProject.DefaultNamespace));
            }


            stringBuilder.AppendLine (String.Format ("\"-out:{0}\"", outputFileName));
            stringBuilder.AppendLine ("-nologo");
            stringBuilder.AppendLine ("-utf8output");
            stringBuilder.AppendLine (String.Format ("-debug:{0}", vbCompilerParameters.DebugType));


            if (vbCompilerParameters.Optimize)
                stringBuilder.AppendLine ("-optimize+");
            else
                stringBuilder.AppendLine ("-optimize-");

            if ( vbProjectParameters.OptionStrict )
                stringBuilder.AppendLine ("-optionstrict+");
            else
                stringBuilder.AppendLine ("-optionstrict-");

            if (vbProjectParameters.OptionExplicit)
                stringBuilder.AppendLine ("-optionexplicit+");
            else
                stringBuilder.AppendLine ("-optionexplicit-");

            if (vbProjectParameters.OptionInfer)
                stringBuilder.AppendLine ("-optioninfer+");
            else
                stringBuilder.AppendLine ("-optioninfer-");

            if (vbCompilerParameters.RemoveIntegerChecks)
                stringBuilder.AppendLine ("-remoteintchecks+");
            else
                stringBuilder.AppendLine ("-remoteintchecks-");

            if (vbProjectParameters.BinaryOptionCompare)
                stringBuilder.AppendLine ("-optioncompare:binary");
            else
                stringBuilder.AppendLine ("-optioncompare:text");



            if ( !String.IsNullOrEmpty (vbProjectParameters.MyType))
                stringBuilder.AppendLine(String.Format("-define:_MYTYPE=\\\"{0}\\\"", vbProjectParameters.MyType));

            if (!String.IsNullOrEmpty (vbProjectParameters.ApplicationIcon) && File.Exists (vbProjectParameters.ApplicationIcon))
                stringBuilder.AppendLine (String.Format ("\"-win32icon:{0}\"", vbProjectParameters.ApplicationIcon));

            if (!String.IsNullOrEmpty (vbProjectParameters.CodePage))
                stringBuilder.AppendLine (String.Format ("-codepage:{0}", vbProjectParameters.CodePage));

            if (!String.IsNullOrEmpty (vbCompilerParameters.DefineConstants))
                stringBuilder.AppendLine (String.Format ("\"-define:{0}\"", vbCompilerParameters.DefineConstants));

            if (!String.IsNullOrEmpty (vbCompilerParameters.DocumentationFile))
                stringBuilder.AppendLine (String.Format ("-doc:{0}", vbCompilerParameters.DocumentationFile));

            if (!String.IsNullOrEmpty (vbProjectParameters.StartupObject))
                stringBuilder.AppendLine (String.Format ("-main:{0}", vbProjectParameters.StartupObject));



            if (vbCompilerParameters.DefineDebug) 
                stringBuilder.AppendLine("-define:DEBUG=-1");

            if (vbCompilerParameters.DefineTrace)
                stringBuilder.AppendLine ("-define:TRACE=-1");

            if (vbCompilerParameters.WarningsDisabled)
                stringBuilder.AppendLine ("nowarn");
            else if (!String.IsNullOrEmpty(vbCompilerParameters.NoWarn))
                stringBuilder.AppendLine (String.Format ("\"-nowarn:{0}\"", vbCompilerParameters.NoWarn));

            if ( !String.IsNullOrEmpty(vbCompilerParameters.WarningsAsErrors))
                stringBuilder.AppendLine (String.Format("-warnaserror+:{0}", vbCompilerParameters.WarningsAsErrors));

            if (!String.IsNullOrEmpty (vbCompilerParameters.AdditionalParameters))
                stringBuilder.AppendLine (vbCompilerParameters.AdditionalParameters);



            if (configuration.SignAssembly && File.Exists (configuration.AssemblyKeyFile))
                stringBuilder.AppendLine (String.Format ("\"-keyfile:{0}\"", configuration.AssemblyKeyFile));

            if (configuration.CompileTarget == CompileTarget.Exe)
                stringBuilder.AppendLine ("-target:exe");
            else if (configuration.CompileTarget == CompileTarget.WinExe)
                stringBuilder.AppendLine ("-target:winexe");
            else if (configuration.CompileTarget == CompileTarget.Library)
                stringBuilder.AppendLine ("-target:library");
            else if (configuration.CompileTarget == CompileTarget.Module)
                stringBuilder.AppendLine ("-target:module");
            else throw new NotSupportedException ("CompileTarget " + configuration.CompileTarget.ToString() + "not supported");

            

            return stringBuilder.ToString();
        }

        private BuildResult ParseOutput (TempFileCollection tempFileCollection, string output)
        {
            CompilerResults compilerResults = new CompilerResults (tempFileCollection);

            StringReader stringReader = new StringReader (output);
            string line = stringReader.ReadLine();
            
            while (line != null) {
                line = line.Trim ();
                if (!String.IsNullOrEmpty (line)) {
                    CompilerError error = CreateErrorFromString (line);
                    if (error != null)
                        compilerResults.Errors.Add (error);
                }
                line = stringReader.ReadLine ();
            }

            return new BuildResult (compilerResults, output);
        }

        private void WriteManifestFile (string fileName)
        {
            string fullFileName = fileName + ".manifest";

            if (!File.Exists (fullFileName)) {
                File.WriteAllText ( fullFileName, 
                                    "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?>" + 
                                    "<assembly xmlns=\"urn:schemas-microsoft-com:asm.v1\" manifestVersion=\"1.0\">" +
                                    "<dependency>" +
                                    "<dependentAssembly>" +
                                    "<assemblyIdentity" +
                                    "type=\"win32\"" +
                                    "name=\"Microsoft.Windows.Common-Controls\"" +
                                    "version=\"6.0.0.0\"" +
                                    "processorArchitecture=\"X86\"" +
                                    "publicKeyToken=\"6595b64144ccf1df\"" +
                                    "language=\"*\"" +
                                    "/>" +
                                    "</dependentAssembly>" +
                                    "</dependency>" +
                                    "</assembly>");
            }
        }
	}
}