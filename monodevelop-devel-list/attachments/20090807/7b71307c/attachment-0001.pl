Index: main/src/core/MonoDevelop.Ide/ChangeLog
===================================================================
--- main/src/core/MonoDevelop.Ide/ChangeLog	(revision 139577)
+++ main/src/core/MonoDevelop.Ide/ChangeLog	(working copy)
@@ -1,3 +1,7 @@
+2009-08-07  Viktoria Dudka  <viktoriad@remobjects.com>
+
+	* MonoDevelop.Ide.Gui.Dialogs/GacReferencePanel.cs: Rewritten the gpl parts.
+
 2009-08-07  Lluis Sanchez Gual  <lluis@novell.com>
 
 	* MonoDevelop.Ide.Gui.Pads.ProjectPad/ProjectFileNodeBuilder.cs:
Index: main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.Gui.Dialogs/GacReferencePanel.cs
===================================================================
--- main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.Gui.Dialogs/GacReferencePanel.cs	(revision 139577)
+++ main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.Gui.Dialogs/GacReferencePanel.cs	(working copy)
@@ -1,157 +1,162 @@
-//  GacReferencePanel.cs
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
-using System.IO;
-
-using MonoDevelop.Projects;
-using MonoDevelop.Core;
-using MonoDevelop.Core.Assemblies;
-
-using Gtk;
-
-namespace MonoDevelop.Ide.Gui.Dialogs
-{
-	internal class GacReferencePanel : VBox, IReferencePanel
-	{
-		SelectReferenceDialog selectDialog;
-		TargetFramework version;
-		TargetRuntime runtime;
-
-		ListStore store;
-		TreeView treeView;
-		
-		public GacReferencePanel(SelectReferenceDialog selectDialog)
-		{
-			this.selectDialog = selectDialog;
-			
-			store = new ListStore (typeof (string), typeof (string), typeof(SystemAssembly), typeof(bool), typeof(string), typeof(string));
-			treeView = new TreeView (store);
-
-			TreeViewColumn firstColumn = new TreeViewColumn ();
-			CellRendererToggle tog_render = new CellRendererToggle ();
-			tog_render.Toggled += new Gtk.ToggledHandler (AddReference);
-			firstColumn.PackStart (tog_render, false);
-			firstColumn.AddAttribute (tog_render, "active", 3);
-
-			treeView.AppendColumn (firstColumn);
-			
-			TreeViewColumn secondColumn = new TreeViewColumn ();
-			secondColumn.Title = GettextCatalog.GetString ("Assembly");
-			CellRendererPixbuf crp = new CellRendererPixbuf ();
-			secondColumn.PackStart (crp, false);
-			crp.StockId = "md-package";
-
-			CellRendererText text_render = new CellRendererText ();
-			secondColumn.PackStart (text_render, true);
-			secondColumn.AddAttribute (text_render, "text", 0);
-			
-			treeView.AppendColumn (secondColumn);
-
-			treeView.AppendColumn (GettextCatalog.GetString ("Version"), new CellRendererText (), "text", 1);
-			treeView.AppendColumn (GettextCatalog.GetString ("Package"), new CellRendererText (), "text", 5);
-			
-			treeView.Columns[1].Resizable = true;
-
-			store.SetSortColumnId (0, SortType.Ascending);
-			store.SetSortFunc (0, new TreeIterCompareFunc (SortTree));
-			
-			ScrolledWindow sc = new ScrolledWindow ();
-			sc.ShadowType = Gtk.ShadowType.In;
-			sc.Add (treeView);
-			this.PackStart (sc, true, true, 0);
-			ShowAll ();
-			BorderWidth = 6;
-		}
-		
-		public void SetTargetFramework (TargetRuntime runtime, TargetFramework version)
-		{
-			this.version = version;
-			this.runtime = runtime;
-		}
-		
-		int SortTree (TreeModel model, TreeIter first, TreeIter second)
-		{
-			// first compare by name
-			string fname = (string) model.GetValue (first, 0);
-			string sname = (string) model.GetValue (second, 0);
-			int compare = String.Compare (fname, sname, true);
-
-			// they had the same name, so compare the version
-			if (compare == 0) {
-				string fversion = (string) model.GetValue (first, 1);
-				string sversion = (string) model.GetValue (second, 1);
-				compare = String.Compare (fversion, sversion, true);
-			}
-
-			return compare;
-		}
-
-		public void Reset ()
-		{
-			store.Clear ();
-			PrintCache ();
-		}
-		
-		public void AddReference(object sender, Gtk.ToggledArgs e)
-		{
-			Gtk.TreeIter iter;
-			store.GetIterFromString (out iter, e.Path);
-			if ((bool)store.GetValue (iter, 3) == false) {
-				store.SetValue (iter, 3, true);
-				ProjectReference pr = new ProjectReference ((SystemAssembly)store.GetValue (iter, 2));
-				selectDialog.AddReference (pr);
-			} else {
-				store.SetValue (iter, 3, false);
-				selectDialog.RemoveReference (ReferenceType.Gac, (string)store.GetValue (iter, 4));
-			}
-		}
-
-		public void SignalRefChange (ProjectReference pref, bool newstate)
-		{
-			Gtk.TreeIter looping_iter;
-			
-			if (!store.GetIterFirst (out looping_iter)) {
-				return;
-			}
-
-			do {
-				SystemAssembly asm = (SystemAssembly) store.GetValue (looping_iter, 2);
-				if (pref.Reference == asm.FullName && pref.Package == asm.Package) {
-					store.SetValue (looping_iter, 3, newstate);
-					return;
-				}
-			} while (store.IterNext (ref looping_iter));
-		}
-		
-		void PrintCache()
-		{
-			foreach (SystemAssembly asm in runtime.GetAssemblies (version)) {
-				if (asm.Package.IsFrameworkPackage && asm.Name == "mscorlib")
-					continue;
-				string pn = asm.Package.Name;
-				if (asm.Package.IsInternalPackage)
-					pn += " " + GettextCatalog.GetString ("(Provided by MonoDevelop)");
-				store.AppendValues (asm.Name, asm.Version, asm, false, asm.FullName, pn);
-			}
-		}
-	}
-}
-
+﻿// GacReferencePanel.cs
+//
+// Author:
+//     MonoDevelop Team
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
+//
+
+using System;
+using System.Collections.Generic;
+using System.Linq;
+using System.Text;
+using Gtk;
+using MonoDevelop.Core.Assemblies;
+using MonoDevelop.Projects;
+using MonoDevelop.Core;
+using System.Globalization;
+
+namespace MonoDevelop.Ide.Gui.Dialogs
+{
+    internal class GacReferencePanel : VBox, IReferencePanel 
+    {
+        ListStore store = null;
+        private TreeView treeView = null;
+
+        private SelectReferenceDialog selectDialog = null;
+        
+        public GacReferencePanel (SelectReferenceDialog selectDialog)
+        {
+            this.selectDialog = selectDialog;
+
+            store = new ListStore (typeof (string), typeof (string), typeof (SystemAssembly), typeof (bool), typeof (string), typeof (string));
+            treeView = new TreeView (store);
+
+            TreeViewColumn firstColumn = new TreeViewColumn ();
+            CellRendererToggle tog_render = new CellRendererToggle ();
+            tog_render.Toggled += new Gtk.ToggledHandler (AddReference);
+            firstColumn.PackStart (tog_render, false);
+            firstColumn.AddAttribute (tog_render, "active", 3);
+
+            treeView.AppendColumn (firstColumn);
+
+            TreeViewColumn secondColumn = new TreeViewColumn ();
+            secondColumn.Title = GettextCatalog.GetString ("Assembly");
+            CellRendererPixbuf crp = new CellRendererPixbuf ();
+            secondColumn.PackStart (crp, false);
+            crp.StockId = "md-package";
+
+            CellRendererText text_render = new CellRendererText ();
+            secondColumn.PackStart (text_render, true);
+            secondColumn.AddAttribute (text_render, "text", 0);
+
+            treeView.AppendColumn (secondColumn);
+
+            treeView.AppendColumn (GettextCatalog.GetString ("Version"), new CellRendererText (), "text", 1);
+            treeView.AppendColumn (GettextCatalog.GetString ("Package"), new CellRendererText (), "text", 5);
+
+            treeView.Columns[1].Resizable = true;
+
+            store.SetSortColumnId (0, SortType.Ascending);
+            store.SetSortFunc (0, new TreeIterCompareFunc (Sort));
+
+            ScrolledWindow sc = new ScrolledWindow ();
+            sc.ShadowType = Gtk.ShadowType.In;
+            sc.Add (treeView);
+            this.PackStart (sc, true, true, 0);
+            ShowAll ();
+            BorderWidth = 6;
+        }
+
+        private TargetRuntime targetRuntime;
+        private TargetFramework targetVersion;
+        public void SetTargetFramework (TargetRuntime targetRuntime, TargetFramework targetVersion)
+        {
+            this.targetRuntime = targetRuntime;
+            this.targetVersion = targetVersion;
+        }
+
+        public void Reset ()
+        {
+            store.Clear ();
+
+            foreach (SystemAssembly systemAssembly in targetRuntime.GetAssemblies (targetVersion)) {
+                if (systemAssembly.Package.IsFrameworkPackage && systemAssembly.Name == "mscorlib")
+                    continue;
+
+                if (systemAssembly.Package.IsInternalPackage) {
+                    store.AppendValues (systemAssembly.Name, 
+                                        systemAssembly.Version, 
+                                        systemAssembly, 
+                                        false, 
+                                        systemAssembly.FullName, 
+                                        systemAssembly.Package.Name + " " + GettextCatalog.GetString ("(Provided by MonoDevelop)"));
+                }
+                else {
+                    store.AppendValues (systemAssembly.Name, systemAssembly.Version, systemAssembly, false, systemAssembly.FullName, systemAssembly.Package.Name);
+                }
+            }
+        }
+
+        public void SignalRefChange (ProjectReference refInfo, bool newState)
+        {
+            TreeIter iter = new TreeIter ();
+
+            if (store.GetIterFirst (out iter)) {
+                do {
+                    SystemAssembly systemAssembly = store.GetValue(iter, 2) as SystemAssembly;
+                    
+                    if ( (refInfo.Reference == systemAssembly.FullName) && (refInfo.Package == systemAssembly.Package) ) {
+                        store.SetValue(iter, 3, newState);
+                        return;
+                    }
+                } while (store.IterNext (ref iter));
+            }
+
+        }
+
+        private int Sort (TreeModel model, TreeIter left, TreeIter right)
+        {
+            int result = String.Compare ((string)model.GetValue (left, 0), (string)model.GetValue (right, 0), StringComparison.InvariantCultureIgnoreCase);
+
+            if (result != 0)
+                return result;
+
+            return String.Compare ((string)model.GetValue (left, 1), (string)model.GetValue (right, 1), StringComparison.InvariantCultureIgnoreCase);
+        }
+
+        public void AddReference (object sender, Gtk.ToggledArgs e)
+        {
+            Gtk.TreeIter iter;
+            store.GetIterFromString (out iter, e.Path);
+            if ((bool)store.GetValue (iter, 3) == false) {
+                store.SetValue (iter, 3, true);
+                ProjectReference pr = new ProjectReference ((SystemAssembly)store.GetValue (iter, 2));
+                selectDialog.AddReference (pr);
+            }
+            else {
+                store.SetValue (iter, 3, false);
+                selectDialog.RemoveReference (ReferenceType.Gac, (string)store.GetValue (iter, 4));
+            }
+        }
+    }
+}