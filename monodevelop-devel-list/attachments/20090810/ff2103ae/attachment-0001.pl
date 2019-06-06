Index: main/src/core/MonoDevelop.Ide/ChangeLog
===================================================================
--- main/src/core/MonoDevelop.Ide/ChangeLog	(revision 139624)
+++ main/src/core/MonoDevelop.Ide/ChangeLog	(working copy)
@@ -1,3 +1,7 @@
+2009-08-07  Viktoria Dudka  <viktoriad@remobjects.com>
+
+	* MonoDevelop.Ide.Gui.Pads/FileList.cs: Rewritten the GPL parts.
+	  
 2009-08-07  Lluis Sanchez Gual  <lluis@novell.com>
 
 	* MonoDevelop.Ide.Gui.Pads.ProjectPad/ProjectFileNodeBuilder.cs:
Index: main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.Gui.Pads/FileList.cs
===================================================================
--- main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.Gui.Pads/FileList.cs	(revision 139624)
+++ main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.Gui.Pads/FileList.cs	(working copy)
@@ -1,22 +1,29 @@
-//  FileList.cs
+//  FileList.cs
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
 using System.IO;
@@ -35,61 +42,92 @@
 		private Gtk.ListStore store;
 		FileListItem selectedItem = null;
 		Gtk.TreeIter selectedIter;
-		Gtk.CellRendererText textRender = new Gtk.CellRendererText ();
+		Gtk.CellRendererText textRender = new Gtk.CellRendererText ();
+
+        public FileList ()
+        {
+            Items = new ArrayList ();
+            store = new Gtk.ListStore (typeof (string), typeof (string), typeof (string), typeof (FileListItem), typeof (Gdk.Pixbuf));
+            Model = store;
+
+            HeadersVisible = true;
+            HeadersClickable = true;
+            RulesHint = true;
+
+            Gtk.TreeViewColumn name_column = new Gtk.TreeViewColumn ();
+            name_column.Title = GettextCatalog.GetString ("Files");
+
+            Gtk.TreeViewColumn size_column = new Gtk.TreeViewColumn ();
+            size_column.Title = GettextCatalog.GetString ("Size");
+
+            Gtk.TreeViewColumn modi_column = new Gtk.TreeViewColumn ();
+            modi_column.Title = GettextCatalog.GetString ("Last modified");
+
+            Gtk.CellRendererPixbuf pix_render = new Gtk.CellRendererPixbuf ();
+            name_column.PackStart (pix_render, false);
+            name_column.AddAttribute (pix_render, "pixbuf", 4);
+
+            name_column.PackStart (textRender, false);
+            name_column.AddAttribute (textRender, "text", 0);
+
+            size_column.PackStart (textRender, false);
+            size_column.AddAttribute (textRender, "text", 1);
+
+            modi_column.PackStart (textRender, false);
+            modi_column.AddAttribute (textRender, "text", 2);
+
+            AppendColumn (name_column);
+            AppendColumn (size_column);
+            AppendColumn (modi_column);
+
+            this.PopupMenu += new Gtk.PopupMenuHandler (OnPopupMenu);
+            this.ButtonReleaseEvent += new Gtk.ButtonReleaseEventHandler (OnButtonReleased);
+            this.Selection.Changed += new EventHandler (OnSelectionChanged);
+
+            watcher = new FileSystemWatcher ();
+            watcher.EnableRaisingEvents = false;
+            watcher.NotifyFilter = NotifyFilters.FileName;
+
+            watcher.Created += DispatchService.GuiDispatch (new FileSystemEventHandler (fileCreated));
+            watcher.Deleted += DispatchService.GuiDispatch (new FileSystemEventHandler (fileDeleted));
+            watcher.Changed += DispatchService.GuiDispatch (new FileSystemEventHandler (fileChanged));
+            watcher.Renamed += DispatchService.GuiDispatch (new RenamedEventHandler (fileRenamed));
+        }
+
+        private void fileCreated (Object o, FileSystemEventArgs e)
+        {
+            FileInfo fileInfo = new FileInfo (e.FullPath);
+            Items.Add(new FileListItem(e.FullPath, String.Format("{0} KB", fileInfo.Length / 512 * 2), fileInfo.LastWriteTime.ToString()));
+        }
+
+        private void fileDeleted (Object o, FileSystemEventArgs e)
+        {
+            foreach (FileListItem fileListItem in Items) {
+                if (String.Compare (fileListItem.FullName, e.FullPath, StringComparison.InvariantCultureIgnoreCase) == 0)
+                    Items.Remove (fileListItem);
+            }
+        }
+
+        private void fileChanged (Object o, FileSystemEventArgs e)
+        {
+            foreach (FileListItem fileListItem in Items) {
+                if (String.Compare (fileListItem.FullName, e.FullPath, StringComparison.InvariantCultureIgnoreCase) == 0) {
+                    FileInfo info = new FileInfo(e.FullPath);
+                    fileListItem.Size = String.Format("{0} KB", info.Length / 512 * 2);
+                    fileListItem.LastModified = info.LastWriteTime.ToString ();
+                }
+            }
+        }
+
+        private void fileRenamed (Object o, RenamedEventArgs e)
+        {
+            foreach (FileListItem fileListItem in Items) {
+                if (String.Compare (fileListItem.FullName, e.OldFullPath, StringComparison.InvariantCultureIgnoreCase) == 0) {
+                    fileListItem.FullName = e.FullPath;
+                }
+            }
+        }
 		
-		public FileList ()
-		{
-			Items = new ArrayList ();
-			store = new Gtk.ListStore (typeof (string), typeof (string), typeof(string), typeof(FileListItem), typeof (Gdk.Pixbuf));
-			Model = store;
-
-			HeadersVisible = true;
-			HeadersClickable = true;
-			RulesHint = true;
-
-			Gtk.TreeViewColumn name_column = new Gtk.TreeViewColumn ();
-			name_column.Title = GettextCatalog.GetString ("Files");
-			
-			Gtk.TreeViewColumn size_column = new Gtk.TreeViewColumn ();
-			size_column.Title = GettextCatalog.GetString ("Size");
-
-			Gtk.TreeViewColumn modi_column = new Gtk.TreeViewColumn ();
-			modi_column.Title = GettextCatalog.GetString ("Last modified");
-
-			Gtk.CellRendererPixbuf pix_render = new Gtk.CellRendererPixbuf ();
-			name_column.PackStart (pix_render, false);
-			name_column.AddAttribute (pix_render, "pixbuf", 4);
-			
-			name_column.PackStart (textRender, false);
-			name_column.AddAttribute (textRender, "text", 0);
-			
-			size_column.PackStart (textRender, false);
-			size_column.AddAttribute (textRender, "text", 1);
-			
-			modi_column.PackStart (textRender, false);
-			modi_column.AddAttribute (textRender, "text", 2);
-				
-			AppendColumn(name_column);
-			AppendColumn(size_column);
-			AppendColumn(modi_column);
-
-			this.PopupMenu += new Gtk.PopupMenuHandler (OnPopupMenu);
-			this.ButtonReleaseEvent += new Gtk.ButtonReleaseEventHandler (OnButtonReleased);
-			this.Selection.Changed += new EventHandler (OnSelectionChanged);
-			
-			watcher = new FileSystemWatcher ();
-			
-			if(watcher != null) {
-				watcher.NotifyFilter = NotifyFilters.FileName;
-				watcher.EnableRaisingEvents = false;
-				
-				watcher.Renamed += (RenamedEventHandler) DispatchService.GuiDispatch (new RenamedEventHandler(fileRenamed));
-				watcher.Deleted += (FileSystemEventHandler) DispatchService.GuiDispatch (new FileSystemEventHandler(fileDeleted));
-				watcher.Created += (FileSystemEventHandler) DispatchService.GuiDispatch (new FileSystemEventHandler(fileCreated));
-				watcher.Changed += (FileSystemEventHandler) DispatchService.GuiDispatch (new FileSystemEventHandler(fileChanged));
-			}
-		}
-		
 		internal void ItemAdded(FileListItem item) {
 			store.AppendValues(item.Text, item.Size, item.LastModified, item, item.Icon);
 		}
@@ -102,51 +140,9 @@
 			store.Clear();
 		}
 		
-		void fileDeleted(object sender, FileSystemEventArgs e)
-		{
-			foreach(FileListItem fileItem in Items)
-			{
-				if(fileItem.FullName.ToLower() == e.FullPath.ToLower()) {
-					Items.Remove(fileItem);
-					break;
-				}
-			}
-		}
 		
-		void fileChanged(object sender, FileSystemEventArgs e)
-		{
-			foreach(FileListItem fileItem in Items)
-			{
-				if(fileItem.FullName.ToLower() == e.FullPath.ToLower()) {
-					
-					FileInfo info = new FileInfo(e.FullPath);
-					fileItem.Size = Math.Round((double)info.Length / 1024).ToString() + " KB";
-					fileItem.LastModified = info.LastWriteTime.ToString();
-					break;
-				}
-			}
-		}
 		
-		void fileCreated(object sender, FileSystemEventArgs e)
-		{
-			FileInfo info = new FileInfo (e.FullPath);
-			
-			FileListItem fileItem = new FileListItem (e.FullPath, Math.Round ((double) info.Length / 1024).ToString () + " KB", info.LastWriteTime.ToString ());
-			
-			Items.Add (fileItem);
-		}
 		
-		void fileRenamed(object sender, RenamedEventArgs e)
-		{
-			foreach(FileListItem fileItem in Items)
-			{
-				if(fileItem.FullName.ToLower() == e.OldFullPath.ToLower()) {
-					fileItem.FullName = e.FullPath;
-					//fileItem.Text = e.Name;
-					break;
-				}
-			}
-		}
 		
 		private void OnRenameFile (object sender, EventArgs e)
 		{