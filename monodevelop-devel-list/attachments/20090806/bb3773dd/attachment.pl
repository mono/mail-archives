Index: main/src/core/MonoDevelop.Projects/ChangeLog
===================================================================
--- main/src/core/MonoDevelop.Projects/ChangeLog	(revision 139472)
+++ main/src/core/MonoDevelop.Projects/ChangeLog	(working copy)
@@ -1,3 +1,9 @@
+2009-08-06  Viktoria Dudka  <viktoriad@remobjects.com>
+
+	* MonoDevelop.Projects/IDotNetLanguageBinding.cs: Rewrittent from
+	  scratch to make it NON-GPL.
+
+
 2009-08-06  Lluis Sanchez Gual  <lluis@novell.com>
 
 	* MonoDevelop.Projects/Solution.cs:
Index: main/src/core/MonoDevelop.Projects/MonoDevelop.Projects/IDotNetLanguageBinding.cs
===================================================================
--- main/src/core/MonoDevelop.Projects/MonoDevelop.Projects/IDotNetLanguageBinding.cs	(revision 139472)
+++ main/src/core/MonoDevelop.Projects/MonoDevelop.Projects/IDotNetLanguageBinding.cs	(working copy)
@@ -1,53 +1,49 @@
-//  IDotNetLanguageBinding.cs
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
-using System.CodeDom.Compiler;
-using System.Collections;
-using System.Xml;
-
-using MonoDevelop.Projects;
-using MonoDevelop.Core;
-using MonoDevelop.Projects.CodeGeneration;
-
-namespace MonoDevelop.Projects
-{
-	/// <summary>
-	/// The <code>IDotNetLanguageBinding</code> interface is the base interface
-	/// of all language bindings avaiable.
-	/// </summary>
-	public interface IDotNetLanguageBinding: ILanguageBinding
-	{
-		string ProjectStockIcon {
-			get;
-		}
-		
-		BuildResult Compile (ProjectItemCollection items, DotNetProjectConfiguration configuration, IProgressMonitor monitor);
-
-		ProjectParameters CreateProjectParameters (XmlElement projectOptions);
-		ConfigurationParameters CreateCompilationParameters (XmlElement projectOptions);
-
-		// Optional. Return null if not supported.
-		CodeDomProvider GetCodeDomProvider ();
-		
-		ClrVersion[] GetSupportedClrVersions ();
-	}
-	
-}
+﻿// IDotNetLanguageBinding.cs
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
+using System;
+using System.Xml;
+using MonoDevelop.Core;
+using System.CodeDom.Compiler;
+
+namespace MonoDevelop.Projects
+{
+    public interface IDotNetLanguageBinding : ILanguageBinding
+	{
+        string ProjectStockIcon { get; }
+
+        ConfigurationParameters CreateCompilationParameters (XmlElement projectOptions);
+        ProjectParameters CreateProjectParameters (XmlElement projectOptions);
+
+
+        BuildResult Compile (ProjectItemCollection items, DotNetProjectConfiguration configuration, IProgressMonitor monitor);
+
+        ClrVersion[] GetSupportedClrVersions ();
+
+        CodeDomProvider GetCodeDomProvider ();
+	}
+}