//  VBLanguageBinding.cs
//
// Author:
//   MonoDevelop Team
//
// Copyright (c) 2009 MonoDevelop Team
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
using System.IO;
using System.Collections;
using System.Diagnostics;
using System.Xml;
using Microsoft.VisualBasic;
using System.CodeDom.Compiler;

using MonoDevelop.Projects;
using MonoDevelop.Core;
using MonoDevelop.Projects.Dom;
using MonoDevelop.Projects.Dom.Parser;
using MonoDevelop.Projects.CodeGeneration;

namespace MonoDevelop.VBNetBinding
{
	public class VBLanguageBinding : IDotNetLanguageBinding
	{
        public VBLanguageBinding ()
        {
            compilerServices = new VBBindingCompilerServices ();
        }

        public string Language
        {
            get { return "VBNet"; }
        }

        public string ProjectStockIcon
        {
            get
            {
                return "md-project";
            }
        }

        public bool IsSourceCodeFile (string fileName)
        {
            return Path.GetExtension (fileName) == ".vb";
        }

        private VBBindingCompilerServices compilerServices;
        public BuildResult Compile (ProjectItemCollection items, DotNetProjectConfiguration configuration, IProgressMonitor monitor)
        {
            return compilerServices.Compile (items, configuration, monitor);
        }

        public ConfigurationParameters CreateCompilationParameters (XmlElement projectOptions)
        {
            return new VBCompilerParameters ();
        }

        public string SingleLineCommentTag { get { return "'"; } }
        public string BlockCommentStartTag { get { return null; } }
        public string BlockCommentEndTag { get { return null; } }

        private ImprovedCodeDomProvider provider;
        public CodeDomProvider GetCodeDomProvider ()
        {
            if (provider == null)
                provider = new ImprovedCodeDomProvider ();
            return provider;
        }

        public string GetFileName (string baseName)
        {
			return baseName + ".vb";
		}
		
		public IParser Parser {
			get { return null; }
		}
		
		public IRefactorer Refactorer {
			get { return null; }
		}
		
		public ClrVersion[] GetSupportedClrVersions ()
		{
			return new ClrVersion[] { ClrVersion.Net_2_0 };
		}
	
		public ProjectParameters CreateProjectParameters (XmlElement projectOptions)
		{
			return new VBProjectParameters ();
		}
	
		class ImprovedCodeDomProvider : Microsoft.VisualBasic.VBCodeProvider
		{
			[Obsolete ("Use CodeDomProvider class")]
			public override ICodeGenerator CreateGenerator ()
			{
				return new VBCodeGenerator ();
			}
		}
	}
}