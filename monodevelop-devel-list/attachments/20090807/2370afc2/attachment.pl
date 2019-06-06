Index: main/src/core/MonoDevelop.Ide/ChangeLog
===================================================================
--- main/src/core/MonoDevelop.Ide/ChangeLog	(revision 139554)
+++ main/src/core/MonoDevelop.Ide/ChangeLog	(working copy)
@@ -1,3 +1,10 @@
+2009-08-07  Viktoria Dudka  <viktoriad@remobjects.com>
+
+	* MonoDevelop.Ide.Gui.Dialogs/SharpDevelopAboutPanels.cs: removed
+	* MonoDevelop.Ide.Gui.Dialogs/AboutMonoDevelopTabPage.cs:
+	* MonoDevelop.Ide.Templates/VersionInformationTabPage.cs: Rewritten from scratch
+	  to make it non-GPL.
+	  
 2009-08-06  Lluis Sanchez Gual  <lluis@novell.com>
 
 	* Makefile.am:
Index: main/src/core/MonoDevelop.Ide/Makefile.am
===================================================================
--- main/src/core/MonoDevelop.Ide/Makefile.am	(revision 139554)
+++ main/src/core/MonoDevelop.Ide/Makefile.am	(working copy)
@@ -210,7 +210,8 @@
 	MonoDevelop.Ide.Gui.Dialogs/SelectEncodingsDialog.cs \
 	MonoDevelop.Ide.Gui.Dialogs/SelectFileFormatDialog.cs \
 	MonoDevelop.Ide.Gui.Dialogs/SelectReferenceDialog.cs \
-	MonoDevelop.Ide.Gui.Dialogs/SharpDevelopAboutPanels.cs \
+	MonoDevelop.Ide.Gui.Dialogs/VersionInformationTabPage.cs \
+	MonoDevelop.Ide.Gui.Dialogs/AboutMonoDevelopTabPage.cs \
 	MonoDevelop.Ide.Gui.Dialogs/SplashScreen.cs \
 	MonoDevelop.Ide.Gui.Dialogs/TipOfTheDay.cs \
 	MonoDevelop.Ide.Gui.OptionPanels/AddInsOptionsPanel.cs \
Index: main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.csproj
===================================================================
--- main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.csproj	(revision 139565)
+++ main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.csproj	(working copy)
@@ -304,7 +304,8 @@
     <Compile Include="MonoDevelop.Ide.Gui.Dialogs\NewFileDialog.cs" />
     <Compile Include="MonoDevelop.Ide.Gui.Dialogs\NewLayoutDialog.cs" />
     <Compile Include="MonoDevelop.Ide.Gui.Dialogs\NewProjectDialog.cs" />
-    <Compile Include="MonoDevelop.Ide.Gui.Dialogs\SharpDevelopAboutPanels.cs" />
+    <Compile Include="MonoDevelop.Ide.Gui.Dialogs\AboutMonoDevelopTabPage.cs" />
+    <Compile Include="MonoDevelop.Ide.Gui.Dialogs\VersionInformationTabPage.cs" />
     <Compile Include="MonoDevelop.Ide.Gui.Dialogs\SplashScreen.cs" />
     <Compile Include="MonoDevelop.Ide.Gui.Dialogs\TipOfTheDay.cs" />
     <Compile Include="MonoDevelop.Ide.Gui.Dialogs\AddinLoadErrorDialog.cs" />
Index: main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.Gui.Dialogs/AboutMonoDevelopTabPage.cs
===================================================================
--- main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.Gui.Dialogs/AboutMonoDevelopTabPage.cs	(revision 0)
+++ main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.Gui.Dialogs/AboutMonoDevelopTabPage.cs	(revision 0)
@@ -0,0 +1,66 @@
+﻿// AboutMonoDevelopTabPage.cs
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
+using Gtk;
+using MonoDevelop.Core;
+
+namespace MonoDevelop.Ide.Gui.Dialogs
+{
+	internal class AboutMonoDevelopTabPage: VBox
+	{
+        public AboutMonoDevelopTabPage ()
+        {
+            Label label = new Label();
+            label.Markup = String.Format (
+                "<b>{0}</b>\n    {1}", 
+                GettextCatalog.GetString ("Version"), 
+                BuildVariables.PackageVersion == BuildVariables.PackageVersionLabel ? BuildVariables.PackageVersionLabel : String.Format ("{0} ({1})", 
+                BuildVariables.PackageVersionLabel, 
+                BuildVariables.PackageVersion));
+            HBox hBoxVersion = new HBox ();
+            hBoxVersion.PackStart (label, false, false, 5);
+            this.PackStart (hBoxVersion, false, true, 0);
+
+            label = null;
+            label = new Label ();
+            label.Markup = GettextCatalog.GetString ("<b>License</b>\n    {0}", GettextCatalog.GetString ("Released under the GNU General Public license."));
+            HBox hBoxLicense = new HBox ();
+            hBoxLicense.PackStart (label, false, false, 5);
+            this.PackStart (hBoxLicense, false, true, 5);
+
+            label = null;
+            label = new Label ();
+            label.Markup = GettextCatalog.GetString ("<b>Copyright</b>\n    (c) 2000-2003 by icsharpcode.net\n    (c) 2004-{0} by MonoDevelop contributors", 2009);
+            HBox hBoxCopyright = new HBox ();
+            hBoxCopyright.PackStart (label, false, false, 5);
+            this.PackStart (hBoxCopyright, false, true, 5);
+
+            this.ShowAll ();
+        }
+	}
+}
Index: main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.Gui.Dialogs/VersionInformationTabPage.cs
===================================================================
--- main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.Gui.Dialogs/VersionInformationTabPage.cs	(revision 0)
+++ main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.Gui.Dialogs/VersionInformationTabPage.cs	(revision 0)
@@ -0,0 +1,95 @@
+﻿// VersionInformationTabPage.cs
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
+using Gtk;
+using MonoDevelop.Core;
+using System.Reflection;
+
+namespace MonoDevelop.Ide.Gui.Dialogs
+{
+	internal class VersionInformationTabPage: VBox
+	{
+        private ListStore data = null;
+        private CellRenderer cellRenderer = new CellRendererText ();
+
+        public VersionInformationTabPage ()
+        {
+            TreeView treeView = new TreeView ();
+
+            TreeViewColumn treeViewColumnTitle = new TreeViewColumn (GettextCatalog.GetString ("Title"), cellRenderer, "text", 0);
+            treeViewColumnTitle.FixedWidth = 200;
+            treeViewColumnTitle.Sizing = TreeViewColumnSizing.Fixed;
+            treeViewColumnTitle.Resizable = true;
+            treeView.AppendColumn (treeViewColumnTitle);
+
+            TreeViewColumn treeViewColumnVersion = new TreeViewColumn (GettextCatalog.GetString ("Version"), cellRenderer, "text", 1);
+            treeView.AppendColumn (treeViewColumnVersion);
+
+            TreeViewColumn treeViewColumnPath = new TreeViewColumn (GettextCatalog.GetString ("Path"), cellRenderer, "text", 2);
+            treeView.AppendColumn (treeViewColumnPath);
+
+            treeView.RulesHint = true;
+
+            data = new ListStore (typeof (string), typeof (string), typeof (string));
+            treeView.Model = data;
+
+            ScrolledWindow scrolledWindow = new ScrolledWindow ();
+            scrolledWindow.Add (treeView);
+            scrolledWindow.ShadowType = ShadowType.In;
+
+            BorderWidth = 6;
+
+            PackStart (scrolledWindow, true, true, 0);
+
+            foreach (Assembly assembly in AppDomain.CurrentDomain.GetAssemblies ()) {
+                try {
+                    AssemblyName assemblyName = assembly.GetName ();
+                    data.AppendValues (assemblyName.Name, assemblyName.Version.ToString (), System.IO.Path.GetFullPath (assembly.Location));
+                }
+                catch { }
+            }
+
+            data.SetSortColumnId (0, SortType.Ascending);
+        }
+
+        protected override void OnDestroyed ()
+        {
+            if (cellRenderer != null) {
+                cellRenderer.Destroy ();
+                cellRenderer = null;
+            }
+
+            if (data != null) {
+                data.Dispose ();
+                data = null;
+            }
+
+            base.OnDestroyed ();
+        }
+	}
+}