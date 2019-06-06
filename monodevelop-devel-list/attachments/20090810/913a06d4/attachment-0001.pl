Index: main/src/core/MonoDevelop.Ide/ChangeLog
===================================================================
--- main/src/core/MonoDevelop.Ide/ChangeLog	(revision 139627)
+++ main/src/core/MonoDevelop.Ide/ChangeLog	(working copy)
@@ -1,3 +1,8 @@
+
+2009-08-10  Viktoria Dudka  <viktoriad@remobjects.com>
+
+	* MonoDevelop.Ide.Gui.Dialogs/NewFileDialog.cs: Rewritten the gpl parts.   
+	  
 2009-08-10  Lluis Sanchez Gual  <lluis@novell.com>
 
 	* MonoDevelop.Ide.Gui/SdiWorkspaceWindow.cs: Original #D code
Index: main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.Gui.Dialogs/NewFileDialog.cs
===================================================================
--- main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.Gui.Dialogs/NewFileDialog.cs	(revision 139628)
+++ main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.Gui.Dialogs/NewFileDialog.cs	(working copy)
@@ -1,22 +1,29 @@
-//  NewFileDialog.cs
+// NewFileDialog.cs
+//
+// Author:
+//   MonoDevelop Team
+//
+// Copyright (c) 2009 MonoDevelop
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
 using System.Collections;
@@ -35,7 +42,8 @@
 
 using Gtk;
 using MonoDevelop.Components;
-using IconView = MonoDevelop.Components.IconView;
+using IconView = MonoDevelop.Components.IconView;
+using Gdk;
 
 namespace MonoDevelop.Ide.Gui.Dialogs
 {
@@ -63,21 +71,77 @@
 		string userEditedEntryText = null;
 		string previousDefaultEntryText = null;
 		
-		public NewFileDialog (Project parentProject, string basePath) : base ()
-		{
-			Build ();
-			this.parentProject = parentProject;
-			this.basePath = basePath;
-			
-			this.TransientFor = IdeApp.Workbench.RootWindow;
-			this.BorderWidth = 6;
-			this.HasSeparator = false;
-			
-			InitializeComponents ();
-			
-			nameEntry.GrabFocus ();
-		}
+		public NewFileDialog (Project parentProject, string basePath) 
+		{
+            this.parentProject = parentProject;
+            this.basePath = basePath;
+
+            BorderWidth = 6;
+            TransientFor = IdeApp.Workbench.RootWindow;
+            HasSeparator = false;
+
+            Build ();
+            InitializeComponents ();
+
+            nameEntry.GrabFocus ();
+            
+		}
+
+
+        void InitializeView ()
+        {
+            InsertCategories (TreeIter.Zero, categories);
+
+            TreeIter treeIter;
+            if (!FindCatIter (PropertyService.Get (GetCategoryPropertyKey (parentProject), "General"), out treeIter)) {
+                if (!FindCatIter ("Misc", out treeIter))
+                    if (!catStore.GetIterFirst (out treeIter))
+                        return;
+            }
+            catView.Selection.SelectIter (treeIter);
+        }
+
+        void InsertCategories (TreeIter node, List<Category> catarray)
+        {
+            foreach (Category category in catarray) {
+                if (TreeIter.Zero.Equals (node))
+                    InsertCategories (catStore.AppendValues (category.Name, category.Categories, category.Templates, cat_imglist[1]), category.Categories);
+                else
+                    InsertCategories (catStore.AppendValues (node, category.Name, category.Categories, category.Templates, cat_imglist[1]), category.Categories);
+            }
+        }
+
+        Category GetCategory (string categoryname)
+        {
+            return GetCategory(categories, categoryname);
+        }
+
+        Category GetCategory (List<Category> catList, string categoryname)
+        {
+            foreach (Category category in catList) {
+                if (category.Name == categoryname)
+                    return category;
+            }
+
+            Category cat = new Category (categoryname);
+            catList.Add (cat);
+            return cat;
+
+        }
+
+        void CategoryChange (object sender, EventArgs e)
+        {
+            TreeModel treeModel;
+            TreeIter treeIter;
+
+            if (catView.Selection.GetSelected (out treeModel, out treeIter)) {
+                okButton.Sensitive = false;
+                FillCategoryTemplates (treeIter);
+            }
+        }
 		
+
+		
 		void InitializeDialog (bool update)
 		{
 			if (update) {
@@ -96,40 +160,6 @@
 			}
 		}
 		
-		void InitializeView()
-		{
-			PixbufList smalllist  = new PixbufList();
-			PixbufList imglist    = new PixbufList();
-			
-			smalllist.Add (ImageService.GetPixbuf ("md-empty-file-icon"));
-			imglist.Add (ImageService.GetPixbuf ("md-empty-file-icon"));
-			
-			int i = 0;
-			Hashtable tmp = new Hashtable(icons);
-			foreach (DictionaryEntry entry in icons) {
-				Gdk.Pixbuf bitmap = ImageService.GetPixbuf (entry.Key.ToString(), Gtk.IconSize.LargeToolbar);
-				if (bitmap != null) {
-					smalllist.Add(bitmap);
-					imglist.Add(bitmap);
-					tmp[entry.Key] = ++i;
-				} else {
-					LoggingService.LogError (GettextCatalog.GetString ("Can't load bitmap {0} using default", entry.Key.ToString ()));
-				}
-			}
-			
-			icons = tmp;
-			
-			InsertCategories(TreeIter.Zero, categories);
-			
-			//select the most recently selected category (with a few fallbacks)
-			string lastSelected = PropertyService.Get<string> (GetCategoryPropertyKey (parentProject), "General");
-			TreeIter iterToSelect;
-			if (FindCatIter (lastSelected, out iterToSelect)
-			    || FindCatIter ("Misc", out iterToSelect)
-			    || catStore.GetIterFirst (out iterToSelect)) {
-				catView.Selection.SelectIter (iterToSelect);
-			}
-		}
 		
 		protected override void OnDestroyed ()
 		{
@@ -197,19 +227,7 @@
 			return path;
 		}
 		
-		void InsertCategories(TreeIter node, List<Category> catarray)
-		{
-			foreach (Category cat in catarray) {
-				TreeIter cnode;
-				if (node.Equals(Gtk.TreeIter.Zero)) {
-					cnode = catStore.AppendValues (cat.Name, cat.Categories, cat.Templates, cat_imglist[1]);
-				} else {
-					cnode = catStore.AppendValues (node, cat.Name, cat.Categories, cat.Templates, cat_imglist[1]);
-				}
-				if (cat.Categories.Count > 0)
-					InsertCategories (cnode, cat.Categories);
-			}
-		}
+
 		
 		public void SelectTemplate (string id)
 		{
@@ -243,22 +261,7 @@
 			return false;
 		}
 		
-		Category GetCategory (string categoryname)
-		{
-			return GetCategory (categories, categoryname);
-		}
 		
-		Category GetCategory (List<Category> catList, string categoryname)
-		{
-			foreach (Category category in catList) {
-				if (category.Name == categoryname) {
-					return category;
-				}
-			}
-			Category newcategory = new Category(categoryname);
-			catList.Add(newcategory);
-			return newcategory;
-		}
 		
 		void InitializeTemplates()
 		{
@@ -338,17 +341,6 @@
 			}
 		}
 		
-		// tree view event handlers
-		void CategoryChange(object sender, EventArgs e)
-		{
-			TreeModel mdl;
-			TreeIter iter;
-			if (catView.Selection.GetSelected (out mdl, out iter)) {
-				FillCategoryTemplates (iter);
-				okButton.Sensitive = false;
-			}
-		}
-		
 		void FillCategoryTemplates (TreeIter iter)
 		{
 			iconView.Clear ();
@@ -463,74 +455,35 @@
 			}
 		}
 		
-		/// <summary>
-		///  Represents a category
-		/// </summary>
-		class Category
-		{
-			List<Category> categories = new List<Category>();
-			List<TemplateItem> templates  = new List<TemplateItem>();
-			string name;
-			
-			public bool Selected = false;
-			public bool HasSelectedTemplate = false;
-			
-			public Category(string name)
-			{
-				this.name = name;
-				//ImageIndex = 1;
-			}
-			
-			public string Name {
-				get {
-					return name;
-				}
-			}
-			
-			public List<Category> Categories {
-				get {
-					return categories;
-				}
-			}
-			
-			public List<TemplateItem> Templates {
-				get {
-					return templates;
-				}
-			}
-		}
 		
 		/// <summary>
 		///  Represents a new file template
 		/// </summary>
-		class TemplateItem
-		{
-			FileTemplate template;
-			string name;
-			string language;
-			
-			public TemplateItem (FileTemplate template, string language)
-			{
-				this.template = template;
-				this.language =  language;
-				this.name = template.Name;
-			}
+		private class TemplateItem
+		{
+            public TemplateItem (FileTemplate template, string language)
+            {
+                this.template = template;
+                this.language = language;
+            }
+
+            private string language;
+            public string Language
+            {
+                get { return language; }
+            }
+
+            public string Name
+            {
+                get { return template.Name; }
+            }
+
+            private FileTemplate template = null;
+            public FileTemplate Template
+            {
+                get { return template; }
+            }
 
-			public string Name {
-				get {
-					return name;
-				}
-			}
-			
-			public FileTemplate Template {
-				get {
-					return template;
-				}
-			}
-			
-			public string Language {
-				get { return language; }
-			}
 		}
 
 		void cancelClicked (object o, EventArgs e) {
@@ -575,87 +528,134 @@
 		}
 		
 		void InitializeComponents()
-		{
-			catStore = new Gtk.TreeStore (typeof(string), typeof(List<Category>), typeof(List<TemplateItem>), typeof(Gdk.Pixbuf));
-			catStore.SetSortColumnId (0, SortType.Ascending);
-			
-			catView.Model = catStore;
+		{
+            catStore = new TreeStore (typeof (string), typeof (List<Category>), typeof (List<TemplateItem>), typeof (Pixbuf));
+
+            TreeViewColumn treeViewColumn = new TreeViewColumn ();
+            treeViewColumn.Title = "categories";
+            CellRenderer cellRenderer = new CellRendererText ();
+            treeViewColumn.PackStart (cellRenderer, true);
+            treeViewColumn.AddAttribute (cellRenderer, "text", 0);
+            catView.AppendColumn (treeViewColumn);
+
+            catStore.SetSortColumnId (0, SortType.Ascending);
+            catView.Model = catStore;
+
+            okButton.Clicked += new EventHandler (OpenEvent);
+            cancelButton.Clicked += new EventHandler (cancelClicked);
+
+            nameEntry.Changed += new EventHandler (NameChanged);
+            nameEntry.Activated += new EventHandler (OpenEvent);
+
+            ReadOnlyCollection<Project> projects = null;
+            if (parentProject == null)
+                projects = IdeApp.Workspace.GetAllProjects ();
+
+            if (projects != null) {
+                Project curProject = IdeApp.ProjectOperations.CurrentSelectedProject;
+
+                boxProject.Visible = true;
+                projectAddCheckbox.Active = curProject != null;
+                projectAddCheckbox.Toggled += new EventHandler (AddToProjectToggled);
+
+                projectNames = new string[projects.Count];
+                projectRefs = new Project[projects.Count];
+                int i = 0;
+
+                bool singleSolution = IdeApp.Workspace.Items.Count == 1 && IdeApp.Workspace.Items[0] is Solution;
+
+                foreach (Project project in projects) {
+                    projectRefs[i] = project;
+                    if (singleSolution)
+                        projectNames[i++] = project.Name;
+                    else
+                        projectNames[i++] = project.ParentSolution.Name + "/" + project.Name;
+                }
+
+                Array.Sort (projectNames, projectRefs);
+                i = Array.IndexOf (projectRefs, curProject);
+
+                foreach (string pn in projectNames)
+                    projectAddCombo.AppendText (pn);
+
+                projectAddCombo.Active = i != -1 ? i : 0;
+                projectAddCombo.Sensitive = projectAddCheckbox.Active;
+                projectAddCombo.Changed += new EventHandler (AddToProjectComboChanged);
+
+                projectPathLabel.Sensitive = projectAddCheckbox.Active;
+                projectFolderEntry.Sensitive = projectAddCheckbox.Active;
+                if (curProject != null)
+                    projectFolderEntry.Path = curProject.BaseDirectory;
+                projectFolderEntry.PathChanged += new EventHandler (AddToProjectPathChanged);
+
+                if (curProject != null) {
+                    basePath = curProject.BaseDirectory;
+                    parentProject = curProject;
+                }
+            }
+            else {
+                boxProject.Visible = false;
+            }
+
+            cat_imglist = new PixbufList ();
+            cat_imglist.Add (ImageService.GetPixbuf ("md-open-folder"));
+            cat_imglist.Add (ImageService.GetPixbuf ("md-closed-folder"));
+            catView.Selection.Changed += new EventHandler (CategoryChange);
+            catView.RowActivated += new RowActivatedHandler (CategoryActivated);
+            iconView.IconSelected += new EventHandler (SelectedIndexChange);
+            iconView.IconDoubleClicked += new EventHandler (OpenEvent);
+            InitializeDialog (false);
+            InitializeView ();
+            UpdateOkStatus ();
+		}
+
+        class Category {
+            List<Category> categories = new List<Category> ();
+            List<TemplateItem> templates = new List<TemplateItem> ();
+            string name;
+
+            public Category (string name)
+            {
+                this.name = name;
+            }
+
+            public string Name
+            {
+                get
+                {
+                    return name;
+                }
+            }
+            public List<Category> Categories
+            {
+                get
+                {
+                    return categories;
+                }
+            }
+            public List<TemplateItem> Templates
+            {
+                get
+                {
+                    return templates;
+                }
+            }
+
+            private bool selected;
+            public bool Selected
+            {
+                get { return selected; }
+                set { selected = value; }
+            }
+
+            private bool hasSelectedTemplate;
+            public bool HasSelectedTemplate
+            {
+                get { return hasSelectedTemplate; }
+                set { hasSelectedTemplate = value; }
+            }
+        }
+	}
 
-			TreeViewColumn catColumn = new TreeViewColumn ();
-			catColumn.Title = "categories";
-			
-			CellRendererText cat_text_render = new CellRendererText ();
-			catColumn.PackStart (cat_text_render, true);
-			catColumn.AddAttribute (cat_text_render, "text", 0);
-
-			catView.AppendColumn (catColumn);
-
-			okButton.Clicked += new EventHandler (OpenEvent);
-			cancelButton.Clicked += new EventHandler (cancelClicked);
-
-			nameEntry.Changed += new EventHandler (NameChanged);
-			nameEntry.Activated += new EventHandler (OpenEvent);
-			
-			ReadOnlyCollection<Project> projects = null;
-			if (parentProject == null)
-				projects = IdeApp.Workspace.GetAllProjects ();
-			
-			if (projects != null) {
-				Project curProject = IdeApp.ProjectOperations.CurrentSelectedProject;
-				
-				boxProject.Visible = true;
-				projectAddCheckbox.Active = curProject != null;
-				projectAddCheckbox.Toggled += new EventHandler (AddToProjectToggled);
-				
-				projectNames = new string [projects.Count];
-				projectRefs = new Project [projects.Count];
-				int i = 0;
-				
-				bool singleSolution = IdeApp.Workspace.Items.Count == 1 && IdeApp.Workspace.Items [0] is Solution;
-				
-				foreach (Project project in projects) {
-					projectRefs[i] = project;
-					if (singleSolution)
-						projectNames[i++] = project.Name;
-					else
-						projectNames[i++] = project.ParentSolution.Name + "/" + project.Name;
-				}
-				
-				Array.Sort (projectNames, projectRefs);
-				i = Array.IndexOf (projectRefs, curProject);
-				
-				foreach (string pn in projectNames)
-					projectAddCombo.AppendText (pn);
-				
-				projectAddCombo.Active = i != -1 ? i : 0;
-				projectAddCombo.Sensitive = projectAddCheckbox.Active;
-				projectAddCombo.Changed += new EventHandler (AddToProjectComboChanged);
-				
-				projectPathLabel.Sensitive = projectAddCheckbox.Active;
-				projectFolderEntry.Sensitive = projectAddCheckbox.Active;
-				if (curProject != null)
-					projectFolderEntry.Path = curProject.BaseDirectory;
-				projectFolderEntry.PathChanged += new EventHandler (AddToProjectPathChanged);
-				
-				if (curProject != null) {
-					basePath = curProject.BaseDirectory;
-					parentProject = curProject;
-				}
-			}
-			else {
-				boxProject.Visible = false;
-			}
-			
-			cat_imglist = new PixbufList ();
-			cat_imglist.Add (ImageService.GetPixbuf ("md-open-folder"));
-			cat_imglist.Add (ImageService.GetPixbuf ("md-closed-folder"));
-			catView.Selection.Changed += new EventHandler (CategoryChange);
-			catView.RowActivated += new RowActivatedHandler (CategoryActivated);
-			iconView.IconSelected += new EventHandler(SelectedIndexChange);
-			iconView.IconDoubleClicked += new EventHandler(OpenEvent);
-			InitializeDialog (false);
-			InitializeView ();
-			UpdateOkStatus ();
-		}
-	}
+    
 }