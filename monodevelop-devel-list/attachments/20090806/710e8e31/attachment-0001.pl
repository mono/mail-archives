Index: main/src/core/MonoDevelop.Ide/ChangeLog
===================================================================
--- main/src/core/MonoDevelop.Ide/ChangeLog	(revision 139482)
+++ main/src/core/MonoDevelop.Ide/ChangeLog	(working copy)
@@ -1,3 +1,10 @@
+2009-08-06  Viktoria Dudka  <viktoriad@remobjects.com>
+
+	* MonoDevelop.Ide.Gui.Dialogs/AbstractPadContent.cs:
+    * MonoDevelop.Ide.Gui.Dialogs/AbstractViewContent.cs:
+	* MonoDevelop.Ide.Gui.Dialogs/AbstractBaseViewContent.cs: Rewritten from scratch
+	  to make it non-GPL. 
+	  
 2009-08-06  Lluis Sanchez Gual  <lluis@novell.com>
 
 	* Makefile.am:
Index: main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.Gui/AbstractBaseViewContent.cs
===================================================================
--- main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.Gui/AbstractBaseViewContent.cs	(revision 139482)
+++ main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.Gui/AbstractBaseViewContent.cs	(working copy)
@@ -1,84 +1,97 @@
-//  AbstractBaseViewContent.cs
+﻿// AbstractBaseViewContent.cs
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
-
-using System;
-//using System.Windows.Forms;
-
-using MonoDevelop.Core;
-
-namespace MonoDevelop.Ide.Gui
-{
-	public abstract class AbstractBaseViewContent : IBaseViewContent
-	{
-		IWorkbenchWindow workbenchWindow = null;
-		
-		public abstract Gtk.Widget Control {
-			get;
-		}
-		
-		public virtual IWorkbenchWindow WorkbenchWindow {
-			get {
-				return workbenchWindow;
-			}
-			set {
-				workbenchWindow = value;
-				OnWorkbenchWindowChanged(EventArgs.Empty);
-			}
-		}
-		
-		public virtual string TabPageLabel {
-			get {
-				return GettextCatalog.GetString ("Abstract Content");
-			}
-		}
-		
-		public virtual void RedrawContent()
-		{
-		}
-		
-		public virtual void Dispose()
-		{
-			if (Control != null)
-				Control.Dispose ();				
-		}
-		
-		public virtual bool CanReuseView (string fileName)
-		{
-			return false;
-		}
-		
-		protected virtual void OnWorkbenchWindowChanged(EventArgs e)
-		{
-			if (WorkbenchWindowChanged != null) {
-				WorkbenchWindowChanged(this, e);
-			}
-		}
-		
-		public virtual object GetContent (Type type)
-		{
-			if (type.IsInstanceOfType (this))
-				return this;
-			else
-				return null;
-		}
-		
-		public event EventHandler WorkbenchWindowChanged;
-	}
-}
+
+using System;
+using System.Collections.Generic;
+using System.Text;
+using MonoDevelop.Core;
+
+namespace MonoDevelop.Ide.Gui
+{
+    public abstract class AbstractBaseViewContent : IBaseViewContent
+	{
+        #region IBaseViewContent Members
+
+        public abstract Gtk.Widget Control { get; }
+
+        private IWorkbenchWindow workbenchWindow = null;
+        public virtual IWorkbenchWindow WorkbenchWindow
+        {
+            get
+            {
+                return workbenchWindow;
+            }
+            set
+            {
+                if (workbenchWindow != value) {
+                    workbenchWindow = value;
+                    OnWorkbenchWindowChanged (EventArgs.Empty);
+                }
+            }
+        }
+
+        public virtual string TabPageLabel
+        {
+            get { return GettextCatalog.GetString ("Abstract Content"); }
+        }
+
+        public virtual void RedrawContent ()
+        {
+        }
+
+        public virtual bool CanReuseView (string fileName)
+        {
+            return false;
+        }
+
+        public virtual object GetContent (Type contentType)
+        {
+            return contentType.IsInstanceOfType (this) ? this : null;
+        }
+
+        #endregion
+
+        #region IDisposable Members
+
+        public virtual void Dispose ()
+        {
+            if (Control != null) {
+                Control.Dispose ();
+            }
+        }
+
+        #endregion
+
+        public event EventHandler WorkbenchWindowChanged;
+        protected virtual void OnWorkbenchWindowChanged(EventArgs e)
+        {
+            if (WorkbenchWindowChanged != null) {
+                WorkbenchWindowChanged (this, e);
+            }
+        }
+    }
+}
Index: main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.Gui/AbstractPadContent.cs
===================================================================
--- main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.Gui/AbstractPadContent.cs	(revision 139482)
+++ main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.Gui/AbstractPadContent.cs	(working copy)
@@ -1,79 +1,100 @@
-//  AbstractPadContent.cs
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
-using MonoDevelop.Core;
-
-namespace MonoDevelop.Ide.Gui
-{
-	public abstract class AbstractPadContent : IPadContent
-	{
-		string id;
-		IPadWindow window;
-		string title;
-		string icon;
-		
-		protected AbstractPadContent () : this (null)
-		{
-		}
-		
-		public AbstractPadContent (string title) : this(title, null)
-		{
-			id = GetType ().FullName;
-		}
-		
-		public AbstractPadContent (string title, string iconResoureName)
-		{
-			this.title = title;
-			this.icon  = iconResoureName;
-			id = GetType ().FullName;
-		}
-		
-		public virtual void Initialize (IPadWindow window)
-		{
-			this.window = window;
-			if (title != null) window.Title = title;
-			if (icon != null) window.Icon  = icon;
-		}
-		
-		public IPadWindow Window {
-			get { return window; }
-		}
-		
-		public abstract Gtk.Widget Control {
-			get;
-		}
-		
-		public string Id {
-			get { return id; }
-			set { id = value; }
-		}
-		
-		public virtual void RedrawContent()
-		{
-		}
-		
-		public virtual void Dispose()
-		{
-		}
-	}
-}
+﻿// AbstractPadContent.cs
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
+using System.Collections.Generic;
+using System.Text;
+
+namespace MonoDevelop.Ide.Gui
+{
+	public abstract class AbstractPadContent: IPadContent
+	{
+        protected AbstractPadContent ()
+            : this (null, null)
+        {
+        }
+
+        public AbstractPadContent (string title)
+            : this (title, null)
+        {
+        }
+
+        private string icon;
+        private string title;
+        public AbstractPadContent (string title, string icon)
+        {
+            this.id = GetType ().FullName;
+            this.icon = icon;
+            this.title = title;
+        }
+
+        private string id;
+        public string Id
+        {
+            get { return id; }
+            set { id = value; }
+        }
+
+        private IPadWindow window = null;
+        public IPadWindow Window
+        {
+            get { return window; }
+        }
+
+        #region IPadContent Members
+
+        public virtual void Initialize (IPadWindow container)
+        {
+            if (title != null)
+                container.Title = title;
+
+            if (icon != null)
+                container.Icon = icon;
+
+            window = container;
+        }
+
+        public abstract Gtk.Widget Control
+        {
+            get;
+        }
+
+        public virtual void RedrawContent ()
+        {
+        }
+
+        #endregion
+
+        #region IDisposable Members
+
+        public virtual void Dispose ()
+        {
+        }
+
+        #endregion
+    }
+}
Index: main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.Gui/AbstractViewContent.cs
===================================================================
--- main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.Gui/AbstractViewContent.cs	(revision 139482)
+++ main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.Gui/AbstractViewContent.cs	(working copy)
@@ -1,177 +1,166 @@
-//  AbstractViewContent.cs
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
-using MonoDevelop.Core;
-using MonoDevelop.Projects;
-
-namespace MonoDevelop.Ide.Gui
-{
-	public abstract class AbstractViewContent : AbstractBaseViewContent, IViewContent
-	{
-		string untitledName = "";
-		string contentName  = null;
-		Project project = null;
-		
-		bool   isDirty  = false;
-		bool   isViewOnly = false;
-
-		public override string TabPageLabel {
-			get { return GettextCatalog.GetString ("Change me"); }
-		}
-		
-		public virtual string UntitledName {
-			get {
-				return untitledName;
-			}
-			set {
-				untitledName = value;
-			}
-		}
-		
-		public virtual string ContentName {
-			get {
-				return contentName;
-			}
-			set {
-				if (contentName != value) {
-					contentName = value;
-					OnContentNameChanged(EventArgs.Empty);
-				}
-			}
-		}
-		
-		public bool IsUntitled {
-			get {
-				return contentName == null;
-			}
-		}
-		
-		public virtual bool IsDirty {
-			get {
-				return isDirty;
-			}
-			set {
-				isDirty = value;
-				OnDirtyChanged(EventArgs.Empty);
-			}
-		}
-		
-		public virtual bool IsReadOnly {
-			get {
-				return false;
-			}
-		}		
-		
-		public virtual bool IsViewOnly {
-			get {
-				return isViewOnly;
-			}
-			set {
-				isViewOnly = value;
-			}
-		}
-		
-		public virtual bool IsFile {
-			get { return true; }
-		}
-
-		public virtual string StockIconId {
-			get {
-				return null;
-			}
-		}
-		
-		public virtual void Save()
-		{
-			OnBeforeSave(EventArgs.Empty);
-			Save(contentName);
-		}
-		
-		public virtual void Save(string fileName)
-		{
-			throw new System.NotImplementedException();
-		}
-		
-		public abstract void Load(string fileName);
-		
-		public virtual Project Project
-		{
-			get
-			{
-				return project;
-			}
-			set
-			{
-				project = value;
-			}
-		}
-		
-		public override bool CanReuseView (string fileName)
-		{
-			return (ContentName == fileName);
-		}
-		
-		public string PathRelativeToProject
-		{
-			get
-			{
-				if (project != null) {
-					return FileService.AbsoluteToRelativePath (project.BaseDirectory, ContentName);
-				}
-				return null;
-			}
-		}
-
-		protected virtual void OnDirtyChanged(EventArgs e)
-		{
-			if (DirtyChanged != null) {
-				DirtyChanged(this, e);
-			}
-		}
-		
-		protected virtual void OnContentNameChanged(EventArgs e)
-		{
-			if (ContentNameChanged != null) {
-				ContentNameChanged(this, e);
-			}
-		}
-		
-		protected virtual void OnBeforeSave(EventArgs e)
-		{
-			if (BeforeSave != null) {
-				BeforeSave(this, e);
-			}
-		}
-
-		protected virtual void OnContentChanged (EventArgs e)
-		{
-			if (ContentChanged != null) {
-				ContentChanged (this, e);
-			}
-		}
-		
-		public event EventHandler ContentNameChanged;
-		public event EventHandler DirtyChanged;
-		public event EventHandler BeforeSave;
-		public event EventHandler ContentChanged;
-	}
-}
+﻿// AbstractViewContent.cs
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
+using System.Collections.Generic;
+using System.Text;
+using MonoDevelop.Core;
+
+namespace MonoDevelop.Ide.Gui
+{
+    public abstract class AbstractViewContent : AbstractBaseViewContent, IViewContent
+	{
+        #region IViewContent Members
+
+        private string untitledName = "";
+        public virtual string UntitledName
+        {
+            get { return untitledName; }
+            set { untitledName = value; }
+        }
+
+        private string contentName;
+        public virtual string ContentName
+        {
+            get
+            {
+                return contentName;
+            }
+            set
+            {
+                if (value != contentName) {
+                    contentName = value;
+                    OnContentNameChanged (EventArgs.Empty);
+                }
+            }
+        }
+
+        public bool IsUntitled
+        {
+            get { return (contentName == null); }
+        }
+
+        private bool isDirty;
+        public virtual bool IsDirty
+        {
+            get
+            {
+                return isDirty;
+            }
+            set
+            {
+                if (value != isDirty) {
+                    isDirty = value;
+                    OnDirtyChanged (EventArgs.Empty);
+                }
+            }
+        }
+
+        public virtual bool IsReadOnly
+        {
+            get { return false; }
+        }
+
+        private bool isViewOnly;
+        public bool IsViewOnly
+        {
+            get { return isViewOnly; }
+            set { isViewOnly = value; }
+        }
+
+        public virtual bool IsFile
+        {
+            get { return true; }
+        }
+
+        public virtual string StockIconId
+        {
+            get { return null; }
+        }
+
+        private MonoDevelop.Projects.Project project = null;
+        public virtual MonoDevelop.Projects.Project Project
+        {
+            get { return project; }
+            set { project = value; }
+        }
+
+        public string PathRelativeToProject
+        {
+            get { return project == null ? null : FileService.AbsoluteToRelativePath(project.BaseDirectory, ContentName); }
+        }
+
+        public virtual void Save ()
+        {
+            OnBeforeSave (EventArgs.Empty);
+            this.Save (contentName);
+        }
+
+        public virtual void Save (string fileName)
+        {
+            throw new NotImplementedException ();
+        }
+
+        public abstract void Load (string fileName);
+
+        
+        public event EventHandler ContentNameChanged;
+
+        public event EventHandler DirtyChanged;
+
+        public event EventHandler BeforeSave;
+
+        public event EventHandler ContentChanged;
+
+        #endregion
+
+
+        public virtual void OnContentChanged (EventArgs e)
+        {
+            if (ContentChanged != null)
+                ContentChanged (this, e);
+        }
+
+        public virtual void OnDirtyChanged (EventArgs e)
+        {
+            if (DirtyChanged != null)
+                DirtyChanged (this, e);
+        }
+
+        public virtual void OnBeforeSave (EventArgs e)
+        {
+            if (BeforeSave != null)
+                BeforeSave (this, e);
+        }
+
+        public virtual void OnContentNameChanged (EventArgs e)
+        {
+            if (ContentNameChanged != null)
+                ContentNameChanged (this, e);
+        }
+    }
+}