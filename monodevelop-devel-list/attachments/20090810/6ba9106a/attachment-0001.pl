Index: main/src/core/MonoDevelop.Ide/ChangeLog
===================================================================
--- main/src/core/MonoDevelop.Ide/ChangeLog	(revision 139622)
+++ main/src/core/MonoDevelop.Ide/ChangeLog	(working copy)
@@ -1,3 +1,8 @@
+2009-08-10  Viktoria Dudka  <viktoriad@remobjects.com>
+
+	* MonoDevelop.Ide.Gui.Dialogs/NewProjectDialog.cs: Rewritten the
+	  GPL parts. 
+
 2009-08-07  Lluis Sanchez Gual  <lluis@novell.com>
 
 	* MonoDevelop.Ide.Gui.Pads.ProjectPad/ProjectFileNodeBuilder.cs:
Index: main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.Gui.Dialogs/NewProjectDialog.cs
===================================================================
--- main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.Gui.Dialogs/NewProjectDialog.cs	(revision 139622)
+++ main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.Gui.Dialogs/NewProjectDialog.cs	(working copy)
@@ -1,22 +1,29 @@
-//  NewProjectDialog.cs
+//  NewProjectDialog.cs
+//
+// Author:
+//   MonoDevelop Team
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
@@ -33,7 +40,8 @@
 
 using MonoDevelop.Components;
 using IconView = MonoDevelop.Components.IconView;
-using Gtk;
+using Gtk;
+using System.Collections.Generic;
 
 namespace MonoDevelop.Ide.Gui.Dialogs {
 	/// <summary>
@@ -43,7 +51,7 @@
 	public partial class NewProjectDialog: Gtk.Dialog
 	{
 		ArrayList alltemplates = new ArrayList();
-		ArrayList categories   = new ArrayList();
+        List<Category> categories = new List<Category> ();
 		
 		IconView TemplateView;
 		TreeStore catStore;
@@ -178,25 +186,14 @@
 			base.OnDestroyed ();
 		}
 		
-		void InsertCategories (TreeIter node, ArrayList catarray)
-		{
-			foreach (Category cat in catarray) {
-				TreeIter i;
-				if (node.Equals (TreeIter.Zero)) {
-					i = catStore.AppendValues (cat.Name, cat);
-				} else {
-					i = catStore.AppendValues (node, cat.Name, cat);
-				}
-				InsertCategories(i, cat.Categories);
-			}
-		}
 		
+		
 		Category GetCategory (string categoryname)
 		{
 			return GetCategory (categories, categoryname);
 		}
 		
-		Category GetCategory (ArrayList catList, string categoryname)
+		Category GetCategory (List<Category> catList, string categoryname)
 		{
 			int i = categoryname.IndexOf ('/');
 			if (i != -1) {
@@ -214,39 +211,10 @@
 			return newcategory;
 		}
 		
-		void InitializeTemplates()
-		{
-			foreach (ProjectTemplate template in ProjectTemplate.ProjectTemplates) {
-				// When creating a project (not a solution) hide solutions that don't have at least one project
-				if (!newSolution && template.SolutionDescriptor.EntryDescriptors.Length == 0)
-					continue;
-				TemplateItem titem = new TemplateItem(template);
-				Category cat = GetCategory(titem.Template.Category);
-				cat.Templates.Add(titem);
-				//if (cat.Templates.Count == 1)
-				//	titem.Selected = true;
-				alltemplates.Add(titem);
-			}
-			InitializeComponents ();
-		}
 		
-		void CategoryChange(object sender, EventArgs e)
-		{
-			TreeModel mdl;
-			TreeIter  iter;
-			if (lst_template_types.Selection.GetSelected (out mdl, out iter)) {
-				TemplateView.Clear ();
-				foreach (TemplateItem item in ((Category)catStore.GetValue (iter, 1)).Templates) {
-					string icon = item.Template.Icon;
-					if (icon == null) icon = "md-project";
-					icon = ImageService.GetStockId (icon);
-					TemplateView.AddIcon (icon, Gtk.IconSize.Dnd, item.Name, item.Template);
-				}
-				
-				btn_new.Sensitive = false;
-			}
-		}
 		
+		
+		
 		string GetValidDir (string name)
 		{
 			name = name.Trim ();
@@ -537,36 +505,6 @@
 			InitializeView ();
 		}
 
-		/// <summary>
-		///  Represents a category
-		/// </summary>
-		internal class Category
-		{
-			ArrayList categories = new ArrayList();
-			ArrayList templates  = new ArrayList();
-			string name;
-			
-			public Category(string name)
-			{
-				this.name = name;
-			}
-			
-			public string Name {
-				get {
-					return name;
-				}
-			}
-			public ArrayList Categories {
-				get {
-					return categories;
-				}
-			}
-			public ArrayList Templates {
-				get {
-					return templates;
-				}
-			}
-		}
 		
 		/// <summary>
 		/// Holds a new file template
@@ -591,6 +529,78 @@
 					return template;
 				}
 			}
-		}
+		}
+
+        private void InitializeTemplates ()
+        {
+            foreach (ProjectTemplate projectTemplate in ProjectTemplate.ProjectTemplates) {
+                if (newSolution && (projectTemplate.SolutionDescriptor.EntryDescriptors != null) && (projectTemplate.SolutionDescriptor.EntryDescriptors.Length == 0))
+                    continue;
+                else {
+                    TemplateItem templateItem = new TemplateItem (projectTemplate);
+
+                    Category category = GetCategory(templateItem.Template.Category);
+                    if (category != null )
+                        category.Templates.Add(templateItem);
+
+                    alltemplates.Add(templateItem);
+                }
+            }
+
+            InitializeComponents ();
+        }
+
+        private void InsertCategories (TreeIter node, List<Category> listCategories)
+        {
+            foreach (Category category in listCategories) {
+                if (TreeIter.Zero.Equals (node))
+                    InsertCategories (catStore.AppendValues (category.Name, category), category.Categories);
+                else
+                    InsertCategories (catStore.AppendValues (node, category.Name, category), category.Categories);
+            }
+        }
+
+        private void CategoryChange (System.Object o, EventArgs e)
+        {
+            TreeModel treeModel;
+            TreeIter treeIter;
+
+            if (lst_template_types.Selection.GetSelected(out treeModel, out treeIter)) {
+                TemplateView.Clear();
+
+                foreach ( TemplateItem templateItem in  (catStore.GetValue(treeIter, 1) as Category).Templates) {
+                    TemplateView.AddIcon(ImageService.GetStockId(templateItem.Template.Icon ?? "md-project"), IconSize.Dnd, templateItem.Name, templateItem.Template);
+                }
+
+                btn_new.Sensitive = false;
+            }
+
+        }
+
+        internal class Category 
+        {
+            private string name;
+            public string Name
+            {
+                get { return name; }
+            }
+
+            public Category (string name)
+            {
+                this.name = name;
+            }        
+
+            private List<TemplateItem> templates = new List<TemplateItem>();
+            public List<TemplateItem> Templates
+            {
+                get { return templates; }
+            }
+
+            private List<Category> categories = new List<Category>();
+            public List<Category> Categories
+            {
+                get { return categories; }
+            }
+        }
 	}
 }