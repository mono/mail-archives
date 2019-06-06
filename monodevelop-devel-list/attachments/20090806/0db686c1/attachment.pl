Index: main/src/core/MonoDevelop.Ide/ChangeLog
===================================================================
--- main/src/core/MonoDevelop.Ide/ChangeLog	(revision 139392)
+++ main/src/core/MonoDevelop.Ide/ChangeLog	(working copy)
@@ -1,3 +1,15 @@
+2009-07-02  Viktoria Dudka  <viktoriad@remobjects.com>
+
+	* MonoDevelop.Ide.Gui/IWorkbenchWindow.cs: Rewritten from scratch
+	  to make it non-GPL. 
+	* MonoDevelop.Ide.Gui/IPadContent.cs: Rewritten from scratch
+	  to make it non-GPL. 
+	* MonoDevelop.Ide.Gui/IBaseViewContent.cs: Rewritten from scratch
+	  to make it non-GPL. 
+	* MonoDevelop.Ide.Gui/IViewContent.cs: Rewritten from scratch
+	  to make it non-GPL. 
+
+	  
 2009-08-04  Mike Krüger  <mkrueger@novell.com>
 
 	* MonoDevelop.Ide.Gui/RootWorkspace.cs:
Index: main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.Gui/IBaseViewContent.cs
===================================================================
--- main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.Gui/IBaseViewContent.cs	(revision 139392)
+++ main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.Gui/IBaseViewContent.cs	(working copy)
@@ -1,65 +1,43 @@
-//  IBaseViewContent.cs
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
-//using System.Windows.Forms;
-
-namespace MonoDevelop.Ide.Gui
-{
-	/// <summary>
-	/// The base functionalty all view contents must provide
-	/// </summary>
-	public interface IBaseViewContent : IDisposable
-	{
-		/// <summary>
-		/// This is the Windows.Forms control for the view.
-		/// </summary>
-		Gtk.Widget Control {
-			get;
-		}
-		
-		/// <summary>
-		/// The workbench window in which this view is displayed.
-		/// </summary>
-		IWorkbenchWindow  WorkbenchWindow {
-			get;
-			set;
-		}
-		
-		/// <summary>
-		/// The text on the tab page when more than one view content
-		/// is attached to a single window.
-		/// </summary>
-		string TabPageLabel {
-			get;
-		}
-		
-		/// <summary>
-		/// Reinitializes the content. (Re-initializes all add-in tree stuff)
-		/// and redraws the content. Call this not directly unless you know
-		/// what you do.
-		/// </summary>
-		void RedrawContent();
-		
-		bool CanReuseView (string fileName);
-		
-		object GetContent (Type contentType);
-	}
-}
+﻿// IBaseViewContent.cs
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
+
+namespace MonoDevelop.Ide.Gui
+{
+    public interface IBaseViewContent : IDisposable
+	{
+        IWorkbenchWindow WorkbenchWindow { get; set; }
+        Widget Control { get; }
+        string TabPageLabel { get; }
+
+        object GetContent (Type type);
+        bool CanReuseView (string fileName);
+        void RedrawContent ();
+	}
+}
Index: main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.Gui/IPadContent.cs
===================================================================
--- main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.Gui/IPadContent.cs	(revision 139392)
+++ main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.Gui/IPadContent.cs	(working copy)
@@ -1,48 +1,40 @@
-//  IPadContent.cs
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
-using System.Drawing;
-
-namespace MonoDevelop.Ide.Gui 
-{
-	/// <summary>
-	/// The IPadContent interface is the basic interface to all "tool" windows
-	/// in SharpDevelop.
-	/// </summary>
-	public interface IPadContent : IDisposable
-	{
-		void Initialize (IPadWindow container);
-
-		/// <summary>
-		/// Returns the Gtk Widget for this pad.
-		/// </summary>
-		Gtk.Widget Control {
-			get;
-		}
-
-		
-		/// <summary>
-		/// Re-initializes all components of the pad. Don't call unless
-		/// you know what you do.
-		/// </summary>
-		void RedrawContent();
-	}
-}
+﻿// IPadContent.cs
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
+
+namespace MonoDevelop.Ide.Gui
+{
+    public interface IPadContent : IDisposable
+	{
+        Widget Control { get; }
+
+        void Initialize (IPadWindow window);
+        void RedrawContent ();
+	}
+}
Index: main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.Gui/IViewContent.cs
===================================================================
--- main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.Gui/IViewContent.cs	(revision 139392)
+++ main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.Gui/IViewContent.cs	(working copy)
@@ -1,135 +1,57 @@
-//  IViewContent.cs
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
-
-using MonoDevelop.Projects;
-
-namespace MonoDevelop.Ide.Gui
-{
-	/// <summary>
-	/// IViewContent is the base interface for all editable data
-	/// inside SharpDevelop.
-	/// </summary>
-	public interface IViewContent : IBaseViewContent
-	{
-		
-		/// <summary>
-		/// A generic name for the file, when it does have no file name
-		/// (e.g. newly created files)
-		/// </summary>
-		string UntitledName {
-			get;
-			set;
-		}
-		
-		/// <summary>
-		/// This is the whole name of the content, e.g. the file name or
-		/// the url depending on the type of the content.
-		/// </summary>
-		string ContentName {
-			get;
-			set;
-		}
-		
-		/// <summary>
-		/// If this property returns true the view is untitled.
-		/// </summary>
-		bool IsUntitled {
-			get;
-		}
-		
-		/// <summary>
-		/// If this property returns true the content has changed since
-		/// the last load/save operation.
-		/// </summary>
-		bool IsDirty {
-			get;
-			set;
-		}
-		
-		/// <summary>
-		/// If this property returns true the content could not be altered.
-		/// </summary>
-		bool IsReadOnly {
-			get;
-		}
-		
-		/// <summary>
-		/// If this property returns true the content can't be written.
-		/// </summary>
-		bool IsViewOnly {
-			get;
-		}
-		
-		bool IsFile {
-			get;
-		}
-
-		string StockIconId {
-			get;
-		}
-		
-		/// <summary>
-		/// Saves this content to the last load/save location.
-		/// </summary>
-		void Save();
-		
-		/// <summary>
-		/// Saves the content to the location <code>fileName</code>
-		/// </summary>
-		void Save(string fileName);
-		
-		/// <summary>
-		/// Loads the content from the location <code>fileName</code>
-		/// </summary>
-		void Load(string fileName);
-		
-		/// <summary>
-		/// The name of the project the content is attached to
-		/// </summary>
-		Project Project {
-			get;
-			set;
-		}
-	
-		/// <summary>
-		/// The path relative to the project
-		/// </summary>
-		string PathRelativeToProject {
-			get;
-		}
-		
-		/// <summary>
-		/// Is called each time the name for the content has changed.
-		/// </summary>
-		event EventHandler ContentNameChanged;
-		
-		/// <summary>
-		/// Is called when the content is changed after a save/load operation
-		/// and this signals that changes could be saved.
-		/// </summary>
-		event EventHandler DirtyChanged;
-		
-		event EventHandler BeforeSave;
-
-		event EventHandler ContentChanged;
-	}
-}
+﻿// IViewContent.cs
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
+using MonoDevelop.Projects;
+
+namespace MonoDevelop.Ide.Gui
+{
+    public interface IViewContent : IBaseViewContent
+	{
+        Project Project { get; set; }
+
+        string PathRelativeToProject { get; }
+        string ContentName { get; set; }
+        string UntitledName { get; set; }
+        string StockIconId { get; }
+
+        bool IsUntitled { get; }
+        bool IsViewOnly { get;  }
+        bool IsFile { get; }
+        bool IsDirty { get; set; }
+        bool IsReadOnly { get; }
+
+        void Load (string fileName);
+        void Save (string fileName);
+        void Save ();
+
+        event EventHandler ContentNameChanged;
+        event EventHandler ContentChanged;
+        event EventHandler DirtyChanged;
+        event EventHandler BeforeSave;
+	}
+}
Index: main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.Gui/IWorkbenchWindow.cs
===================================================================
--- main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.Gui/IWorkbenchWindow.cs	(revision 139392)
+++ main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.Gui/IWorkbenchWindow.cs	(working copy)
@@ -1,145 +1,90 @@
-//  IWorkbenchWindow.cs
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
-using System.Collections;
-
-namespace MonoDevelop.Ide.Gui
-{
-	/// <summary>
-	/// The IWorkbenchWindow is the basic interface to a window which
-	/// shows a view (represented by the IViewContent object).
-	/// </summary>
-	public interface IWorkbenchWindow
-	{
-		/// <summary>
-		/// The window title.
-		/// </summary>
-		string Title {
-			get;
-			set;
-		}
-		
-		string DocumentType {
-			get;
-			set;
-		}
-
-		bool ShowNotification {
-			get;
-			set;
-		}
-		
-		/// <summary>
-		/// The current view content which is shown inside this window.
-		/// </summary>
-		IViewContent ViewContent {
-			get;
-		}
-		
-		/// <summary>
-		/// returns null if no sub view contents are attached.
-		/// </summary>
-		ArrayList SubViewContents {
-			get;
-		}
-		
-		IBaseViewContent ActiveViewContent {
-			get;
-			set;
-		}
-		
-		Document Document {
-			get;
-			set;
-		}
-		
-		/// <summary>
-		/// Closes the window, if force == true it closes the window
-		/// without ask, even the content is dirty.
-		/// </summary>
-		bool CloseWindow(bool force, bool fromMenu, int pageNum);
-		
-		/// <summary>
-		/// Brings this window to front and sets the user focus to this
-		/// window.
-		/// </summary>
-		void SelectWindow();
-		
-		void SwitchView(int viewNumber);
-		void AttachViewContent (IAttachableViewContent subViewContent);
-		
-		/// <summary>
-		/// Is called when the title of this window has changed.
-		/// </summary>
-		event EventHandler TitleChanged;
-		
-		/// <summary>
-		/// Is called after the window closes.
-		/// </summary>
-		event WorkbenchWindowEventHandler Closing;
-		
-		/// <summary>
-		/// Is called after the window closes.
-		/// </summary>
-		event WorkbenchWindowEventHandler Closed;
-		
-		event ActiveViewContentEventHandler ActiveViewContentChanged;
-	}
-	
-	public delegate void WorkbenchWindowEventHandler (object sender, WorkbenchWindowEventArgs args);
-	
-	public class WorkbenchWindowEventArgs: System.ComponentModel.CancelEventArgs
-	{
-		bool forced;
-		bool wasActive;
-		
-		public WorkbenchWindowEventArgs (bool forced, bool wasActive)
-		{
-			this.forced = forced;
-			this.wasActive = wasActive;
-		}
-		
-		public bool Forced {
-			get { return forced; }
-		}
-		
-		public bool WasActive {
-			get { return wasActive; }
-		}
-	}
-	
-		
-	public delegate void ActiveViewContentEventHandler (object sender, ActiveViewContentEventArgs args);
-	
-	public class ActiveViewContentEventArgs: System.EventArgs
-	{
-		IBaseViewContent content;
-		
-		public ActiveViewContentEventArgs (IBaseViewContent content)
-		{
-			this.content = content;
-		}
-		
-		public IBaseViewContent Content {
-			get { return content; }
-		}
-	}
-}
+﻿// IWorkbenchWindow.cs
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
+using System.ComponentModel;
+
+namespace MonoDevelop.Ide.Gui
+{
+	public interface IWorkbenchWindow
+	{
+        IViewContent ViewContent { get; }
+        IBaseViewContent ActiveViewContent { get; set; }
+        Document Document { get; set; }
+        string DocumentType { get; set; }
+        string Title { get; set; }
+        bool ShowNotification { get; set; }
+
+        void AttachViewContent (IAttachableViewContent subViewContent);
+        void SwitchView (int index);
+
+        bool CloseWindow (bool force, bool fromMenu, int pageNum);
+        void SelectWindow ();
+
+        event WorkbenchWindowEventHandler Closed;
+        event WorkbenchWindowEventHandler Closing;
+        event ActiveViewContentEventHandler ActiveViewContentChanged;
+
+	}
+
+    public delegate void WorkbenchWindowEventHandler (object o, WorkbenchWindowEventArgs e);
+    public class WorkbenchWindowEventArgs : CancelEventArgs
+    {
+        private bool forced;
+        public bool Forced
+        {
+            get { return forced; }
+        }
+
+        private bool wasActive;
+        public bool WasActive
+        {
+            get { return wasActive; }
+        }
+
+        public WorkbenchWindowEventArgs (bool forced, bool wasActive)
+        {
+            this.forced = forced;
+            this.wasActive = wasActive;
+        }
+    }
+
+    public delegate void ActiveViewContentEventHandler (object o, ActiveViewContentEventArgs e);
+    public class ActiveViewContentEventArgs: EventArgs
+    {
+        private IBaseViewContent content = null;
+        public IBaseViewContent Content
+        {
+            get { return content; }
+        }
+
+        public ActiveViewContentEventArgs (IBaseViewContent content)
+        {
+            this.content = content;
+        }
+    }
+}