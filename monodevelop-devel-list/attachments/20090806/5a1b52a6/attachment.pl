Index: main/src/core/MonoDevelop.Ide/ChangeLog
===================================================================
--- main/src/core/MonoDevelop.Ide/ChangeLog	(revision 139397)
+++ main/src/core/MonoDevelop.Ide/ChangeLog	(working copy)
@@ -1,3 +1,8 @@
+2009-07-02  Viktoria Dudka  <viktoriad@remobjects.com>
+
+	* MonoDevelop.Ide.Gui/SdiWorkspaceWindow.cs: Rewritten from scratch
+	  to make it non-GPL. 
+
 2009-08-05  Lluis Sanchez Gual  <lluis@novell.com>
 
 	* MonoDevelop.Ide.FindInFiles/SearchResultWidget.cs: Don't
Index: main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.Gui/SdiWorkspaceWindow.cs
===================================================================
--- main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.Gui/SdiWorkspaceWindow.cs	(revision 139397)
+++ main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.Gui/SdiWorkspaceWindow.cs	(working copy)
@@ -1,634 +1,637 @@
-//  SdiWorkspaceWindow.cs
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
-using System.IO;
-using Gtk;
-
-using MonoDevelop.Core;
-using MonoDevelop.Core.Gui;
-using MonoDevelop.Components;
-using MonoDevelop.Ide.Commands;
-using MonoDevelop.Components.Commands;
-
-namespace MonoDevelop.Ide.Gui
-{
-	internal class SdiWorkspaceWindow : Frame, IWorkbenchWindow, ICommandDelegatorRouter
-	{
-		IWorkbench workbench;
-		IViewContent content;
-		
-		ArrayList subViewContents = null;
-		Notebook subViewNotebook = null;
-		Toolbar subViewToolbar = null;
-		HBox pathBox = null;
-		HBox toolbarBox = null;
-		
-		VBox box;
-		TabLabel tabLabel;
-		Widget    tabPage;
-		Notebook  tabControl;
-		SeparatorToolItem separatorItem;
-		
-		string myUntitledTitle     = null;
-		string _titleHolder = "";
-		
-		string documentType;
-		MonoDevelop.Ide.Gui.Content.IPathedDocument pathDoc;
-		
-		bool show_notification = false;
-		
-		ViewCommandHandlers commandHandler;
-		
-		public SdiWorkspaceWindow (IWorkbench workbench, IViewContent content, Notebook tabControl, TabLabel tabLabel) : base ()
-		{
-			this.workbench = workbench;
-			this.tabControl = tabControl;
-			this.content = content;
-			this.tabLabel = tabLabel;
-			this.tabPage = content.Control;
-			
-			content.WorkbenchWindow = this;
-			
-			content.ContentNameChanged += new EventHandler(SetTitleEvent);
-			content.DirtyChanged       += new EventHandler(SetTitleEvent);
-			content.BeforeSave         += new EventHandler(BeforeSave);
-			content.ContentChanged     += new EventHandler (OnContentChanged);
-			
-			ShadowType = ShadowType.None;
-			box = new VBox ();
-			box.Add (content.Control);
-			Add (box);
-			
-			Show ();
-			box.Show ();
-			content.Control.Show ();
-			SetTitleEvent(null, null);
-			
-			commandHandler = new ViewCommandHandlers (this);
-		}
-		
-		protected SdiWorkspaceWindow (IntPtr p): base (p)
-		{
-		}
-		
-		public Widget TabPage {
-			get {
-				return tabPage;
-			}
-			set {
-				tabPage = value;
-			}
-		}
-		
-		internal TabLabel TabLabel {
-			get { return tabLabel; }
-		}
-
-		public Document Document {
-			get;
-			set;
-		}
-		
-		public bool ShowNotification {
-			get {
-				return show_notification;
-			}
-			set {
-				if (show_notification != value) {
-					show_notification = value;
-					OnTitleChanged (null);
-				}
-			}
-		}
-		
-		public string Title {
-			get {
-				//FIXME: This breaks, Why? --Todd
-				//_titleHolder = tabControl.GetTabLabelText (tabPage);
-				return _titleHolder;
-			}
-			set {
-				_titleHolder = value;
-				string fileName = content.ContentName;
-				if (fileName == null) {
-					fileName = content.UntitledName;
-				}
-				
-				OnTitleChanged(null);
-			}
-		}
-		
-		public ArrayList SubViewContents {
-			get {
-				return subViewContents;
-			}
-		}
-		
-		// caution use activeView with care !!
-		IBaseViewContent activeView = null;
-		public IBaseViewContent ActiveViewContent {
-			get {
-				if (activeView != null)
-					return activeView;
-				if (subViewNotebook != null && subViewNotebook.CurrentPage > 0) {
-					return (IBaseViewContent)subViewContents[subViewNotebook.CurrentPage - 1];
-				}
-				return content;
-			}
-			set {
-				this.activeView = value;
-				this.OnActiveViewContentChanged (new ActiveViewContentEventArgs (value));
-			}
-		}
-		
-		public void SwitchView (int viewNumber)
-		{
-			if (subViewNotebook != null)
-				ShowPage (viewNumber);
-		}
-		
-		public void SelectWindow()	
-		{
-			if (this.Parent == null)
-				return;
-			int toSelect = tabControl.PageNum (this);
-			tabControl.CurrentPage = toSelect;
-		}
-		
-
-		void BeforeSave(object sender, EventArgs e)
-		{
-			IAttachableViewContent secondaryViewContent = ActiveViewContent as IAttachableViewContent;
-			if (secondaryViewContent != null) {
-				secondaryViewContent.BeforeSave ();
-			}
-		}
-		
-		public IViewContent ViewContent {
-			get {
-				return content;
-			}
-			set {
-				content = value;
-			}
-		}
-
-		public MonoDevelop.Ide.Gui.ViewCommandHandlers CommandHandler {
-			get {
-				return commandHandler;
-			}
-		}
-
-		public string DocumentType {
-			get {
-				return documentType;
-			}
-			set {
-				documentType = value;
-			}
-		}
-		
-		public void SetTitleEvent(object sender, EventArgs e)
-		{
-			if (content == null) {
-				return;
-			}
-		
-			string newTitle = "";
-			if (content.ContentName == null) {
-				if (myUntitledTitle == null) {
-					string baseName  = System.IO.Path.GetFileNameWithoutExtension(content.UntitledName);
-					int number = 1;
-					bool found = true;
-					myUntitledTitle = baseName + System.IO.Path.GetExtension (content.UntitledName);
-					while (found) {
-						found = false;
-						foreach (IViewContent windowContent in workbench.ViewContentCollection) {
-							string title = windowContent.WorkbenchWindow.Title;
-							if (title.EndsWith("*") || title.EndsWith("+")) {
-								title = title.Substring(0, title.Length - 1);
-							}
-							if (title == myUntitledTitle) {
-								myUntitledTitle = baseName + number + System.IO.Path.GetExtension (content.UntitledName);
-								found = true;
-								++number;
-								break;
-							}
-						}
-					}
-				}
-				newTitle = myUntitledTitle;
-			} else {
-				newTitle = System.IO.Path.GetFileName(content.ContentName);
-			}
-			
-			if (content.IsDirty) {
-				newTitle += "*";
-				IdeApp.ProjectOperations.MarkFileDirty (content.ContentName);
-			} else if (content.IsReadOnly) {
-				newTitle += "+";
-			}
-			
-			if (newTitle != Title) {
-				Title = newTitle;
-			}
-		}
-		
-		public void OnContentChanged (object o, EventArgs e)
-		{
-			if (subViewContents != null) {
-				foreach (IAttachableViewContent subContent in subViewContents)
-				{
-					subContent.BaseContentChanged ();
-				}
-			}
-		}
-		
-		public bool CloseWindow (bool force, bool fromMenu, int pageNum)
-		{
-			bool wasActive = workbench.WorkbenchLayout.ActiveWorkbenchwindow == this;
-			WorkbenchWindowEventArgs args = new WorkbenchWindowEventArgs (force, wasActive);
-			args.Cancel = false;
-			OnClosing (args);
-			if (args.Cancel)
-				return false;
-			if (fromMenu == true) {
-				workbench.WorkbenchLayout.RemoveTab (tabControl.PageNum(this));
-			} else {
-				workbench.WorkbenchLayout.RemoveTab (pageNum);
-			}
-			
-			content.ContentNameChanged -= new EventHandler(SetTitleEvent);
-			content.DirtyChanged       -= new EventHandler(SetTitleEvent);
-			content.BeforeSave         -= new EventHandler(BeforeSave);
-			content.ContentChanged     -= new EventHandler (OnContentChanged);
-			content.WorkbenchWindow = null;
-			
-			if (subViewContents != null) {
-				foreach (IAttachableViewContent sv in subViewContents) {
-					subViewNotebook.Remove (sv.Control);
-					sv.Dispose ();
-				}
-				this.subViewContents = null;
-				subViewNotebook.Remove (content.Control);
-			} else {
-				box.Remove (content.Control);
-			}
-			content.Dispose ();
-			tabLabel.Dispose ();
-			
-			this.subViewToolbar = null;
-			this.separatorItem = null;
-			DetachFromPathedDocument ();
-
-			OnClosed (args);
-			
-			this.content = null;
-			this.subViewNotebook = null;
-			this.tabControl = null;
-			this.tabLabel = null;
-			this.tabPage = null;
-			Destroy ();
-			return true;
-		}
-		
-		#region lazy UI element creation
-		
-		void CheckCreateSubViewToolbar ()
-		{
-			if (subViewToolbar != null)
-				return;
-			
-			subViewToolbar = new Toolbar ();
-			subViewToolbar.IconSize = IconSize.SmallToolbar;
-			subViewToolbar.ToolbarStyle = ToolbarStyle.BothHoriz;
-			subViewToolbar.ShowArrow = false;
-			subViewToolbar.Show ();
-			
-			CheckCreateToolbarBox ();
-			toolbarBox.PackStart (subViewToolbar, false, false, 0);
-		}
-		
-		void EnsureToolbarBoxSeparator ()
-		{
-			if (toolbarBox == null || subViewToolbar == null)
-				return;
-
-			if (separatorItem != null && pathBox == null) {
-				subViewToolbar.Remove (separatorItem);
-				separatorItem = null;
-			} else if (separatorItem == null && pathBox != null) {
-				separatorItem = new SeparatorToolItem ();
-				subViewToolbar.Insert (separatorItem, -1);
-			} else if (separatorItem != null && pathBox != null) {
-				if (subViewToolbar.GetItemIndex(separatorItem) != subViewToolbar.NumChildren - 1) {
-					subViewToolbar.Remove (separatorItem);
-					subViewToolbar.Insert (separatorItem, -1);
-				}
-			}
-		}
-		
-		void CheckCreateToolbarBox ()
-		{
-			if (toolbarBox != null)
-				return;
-			toolbarBox = new HBox (false, 6);
-			toolbarBox.Show ();
-			box.PackEnd (toolbarBox, false, false, 3);
-		}
-		
-		void CheckCreateSubViewContents ()
-		{
-			if (subViewContents != null)
-				return;
-			
-			subViewContents = new ArrayList ();
-			
-			box.Remove (this.ViewContent.Control);
-			
-			subViewNotebook = new Notebook ();
-			subViewNotebook.TabPos = PositionType.Bottom;
-			subViewNotebook.ShowTabs = false;
-			subViewNotebook.ShowBorder = false;
-			subViewNotebook.Show ();
-			subViewNotebook.SwitchPage += subViewNotebookIndexChanged;
-			
-			//add existing ViewContent
-			AddButton (this.ViewContent.TabPageLabel, this.ViewContent.Control).Active = true;
-			
-			//pack them in a box
-			box.PackStart (subViewNotebook, true, true, 0);
-			box.ShowAll ();
-		}
-		
-		#endregion
-		
-			
-		public void AttachViewContent (IAttachableViewContent subViewContent)
-		{
-			// need to create child Notebook when first IAttachableViewContent is added
-			CheckCreateSubViewContents ();
-			
-			subViewContents.Add (subViewContent);
-			subViewContent.WorkbenchWindow = this;
-			AddButton (subViewContent.TabPageLabel, subViewContent.Control);
-			
-			OnContentChanged (null, null);
-		}
-		
-		bool updating = false;
-		protected ToggleToolButton AddButton (string label, Gtk.Widget page)
-		{
-			CheckCreateSubViewToolbar ();
-			updating = true;
-			ToggleToolButton button = new ToggleToolButton ();
-			button.Label = label;
-			button.IsImportant = true;
-			button.Clicked += new EventHandler (OnButtonToggled);
-			button.ShowAll ();
-			subViewToolbar.Insert (button, -1);
-			subViewNotebook.AppendPage (page, new Gtk.Label ());
-			page.ShowAll ();
-			EnsureToolbarBoxSeparator ();
-			updating = false;
-			return button;
-		}
-		
-		#region Track and display document's "path"
-		
-		internal void AttachToPathedDocument (MonoDevelop.Ide.Gui.Content.IPathedDocument pathDoc)
-		{
-			if (this.pathDoc != pathDoc)
-				DetachFromPathedDocument ();
-			if (pathDoc == null)
-				return;
-			PathWidgetEnabled = true;
-			pathDoc.PathChanged += HandlePathChange;
-			this.pathDoc = pathDoc;
-		}
-		
-		internal void DetachFromPathedDocument ()
-		{
-			if (pathDoc == null)
-				return;
-			PathWidgetEnabled = false;
-			pathDoc.PathChanged -= HandlePathChange;
-			pathDoc = null;
-		}
-		
-		void HandlePathChange (object sender, MonoDevelop.Ide.Gui.Content.DocumentPathChangedEventArgs args)
-		{
-			MonoDevelop.Ide.Gui.Content.IPathedDocument pathDoc = (MonoDevelop.Ide.Gui.Content.IPathedDocument) sender;
-			
-			while (pathBox.Children.Length > 0)
-				pathBox.Remove (pathBox.Children[0]);
-			
-			if (pathDoc.CurrentPath == null || pathDoc.CurrentPath.Length == 0)
-				return;
-			
-			for (int i = 0; i < pathDoc.CurrentPath.Length; i++) {
-				PathMenuButton button = new PathMenuButton (pathDoc, i);
-				button.ArrowType = (i + 1 < pathDoc.CurrentPath.Length)? ArrowType.Right : (ArrowType?) null;
-				
-				if (i == pathDoc.SelectedIndex) {
-					string escaped = GLib.Markup.EscapeText (pathDoc.CurrentPath[i]);
-					button.Markup = string.Concat ("<b>", escaped ,"</b>");
-				} else {
-					button.Label = pathDoc.CurrentPath[i];
-				}
-				pathBox.PackStart (button, false, false, 0);
-			}
-			pathBox.PackEnd (new Label (string.Empty), true, true, 0);
-			pathBox.ShowAll ();
-		}
-		
-		bool PathWidgetEnabled {
-			get { return (pathBox != null); }
-			set {
-				if (PathWidgetEnabled == value)
-					return;
-				if (value) {
-					CheckCreateToolbarBox ();
-					
-					pathBox = new HBox ();
-					pathBox.Spacing = 0;
-					
-					toolbarBox.PackEnd (pathBox, true, true, 0);
-					toolbarBox.ShowAll ();
-				} else {
-					toolbarBox.Remove (pathBox);
-					toolbarBox.Destroy ();
-				}
-				EnsureToolbarBoxSeparator ();
-			}
-		}
-		
-		private class PathMenuButton : MenuButton
-		{
-			MonoDevelop.Ide.Gui.Content.IPathedDocument pathDoc;
-			int index;
-			
-			public PathMenuButton (MonoDevelop.Ide.Gui.Content.IPathedDocument pathDoc, int index)
-			{
-				this.pathDoc = pathDoc;
-				this.index = index;
-				this.MenuCreator = PathMenuCreator;
-				this.Relief = Gtk.ReliefStyle.None;
-			}
-			
-			Menu PathMenuCreator (MenuButton button)	
-			{
-				Menu menu = new Menu ();
-				MenuItem mi = new MenuItem (GettextCatalog.GetString ("Select"));
-				mi.Activated += delegate {
-					pathDoc.SelectPath (index);
-				};
-				menu.Add (mi);
-				mi = new MenuItem (GettextCatalog.GetString ("Select contents"));
-				mi.Activated += delegate {
-					pathDoc.SelectPathContents (index);
-				};
-				menu.Add (mi);
-				menu.ShowAll ();
-				return menu;
-			}
-		}
-		
-		#endregion
-		
-		protected void ShowPage (int npage)
-		{
-			if (updating) return;
-			updating = true;
-			
-			subViewNotebook.CurrentPage = npage;
-			Gtk.Widget[] buttons = subViewToolbar.Children;
-			for (int n=0; n<buttons.Length; n++) {
-				if (buttons [n] is ToggleToolButton) {
-					ToggleToolButton b = (ToggleToolButton) buttons [n];
-					b.Active = (n == npage);
-				}
-			}
-
-			updating = false;
-		}
-		
-		void OnButtonToggled (object s, EventArgs args)
-		{
-			int i = Array.IndexOf (subViewToolbar.Children, s);
-			if (i != -1)
-				ShowPage (i);
-		}
-		
-		int oldIndex = -1;
-		protected void subViewNotebookIndexChanged(object sender, SwitchPageArgs e)
-		{
-			if (oldIndex > 0) {
-				IAttachableViewContent secondaryViewContent = subViewContents[oldIndex - 1] as IAttachableViewContent;
-				if (secondaryViewContent != null) {
-					secondaryViewContent.Deselected();
-				}
-			}
-			
-			if (subViewNotebook.CurrentPage > 0) {
-				IAttachableViewContent secondaryViewContent = subViewContents[subViewNotebook.CurrentPage - 1] as IAttachableViewContent;
-				if (secondaryViewContent != null) {
-					secondaryViewContent.Selected();
-				}
-			}
-			oldIndex = subViewNotebook.CurrentPage;
-			
-			OnActiveViewContentChanged (new ActiveViewContentEventArgs (this.ActiveViewContent));
-		}
-
-		object ICommandDelegatorRouter.GetNextCommandTarget ()
-		{
-			return Parent;
-		}
-		
-		object ICommandDelegatorRouter.GetDelegatedCommandTarget ()
-		{
-			Gtk.Widget w = content as Gtk.Widget;
-			if (w != this.tabPage) {
-				// Route commands to the view
-				return content;
-			} else
-				return null;
-		}
-		
-		protected virtual void OnTitleChanged(EventArgs e)
-		{
-			if (show_notification) {
-				tabLabel.Label.Markup = "<span foreground=\"blue\">" + Title + "</span>";
-				tabLabel.Label.UseMarkup = true;
-			} else {
-				tabLabel.Label.Text = Title;
-				tabLabel.Label.UseMarkup = false;
-			}
-			
-			if (content.ContentName != null && content.ContentName != "") {
-				tabLabel.SetTooltip (content.ContentName, content.ContentName);
-			}
-
-			try {
-				if (content.StockIconId != null ) {
-					tabLabel.Icon = new Gtk.Image ( content.StockIconId, IconSize.Menu );
-				}
-				else if (content.ContentName != null && content.ContentName.IndexOfAny (new char[] { '*', '+'}) == -1) {
-					tabLabel.Icon.Pixbuf = DesktopService.GetPixbufForFile (content.ContentName, Gtk.IconSize.Menu);
-				}
-			} catch (Exception ex) {
-				LoggingService.LogError (ex.ToString ());
-				tabLabel.Icon.Pixbuf = DesktopService.GetPixbufForType ("gnome-fs-regular", Gtk.IconSize.Menu);
-			}
-
-			if (TitleChanged != null) {
-				TitleChanged(this, e);
-			}
-		}
-
-		protected virtual void OnClosing (WorkbenchWindowEventArgs e)
-		{
-			if (Closing != null) {
-				Closing (this, e);
-			}
-		}
-
-		protected virtual void OnClosed (WorkbenchWindowEventArgs e)
-		{
-			if (Closed != null) {
-				Closed (this, e);
-			}
-		}
-		
-		protected virtual void OnActiveViewContentChanged (ActiveViewContentEventArgs e)
-		{
-			if (ActiveViewContentChanged != null)
-				ActiveViewContentChanged (this, e);
-		}
-
-		public event EventHandler TitleChanged;
-		public event WorkbenchWindowEventHandler Closed;
-		public event WorkbenchWindowEventHandler Closing;
-		public event ActiveViewContentEventHandler ActiveViewContentChanged;
-	}
-}
+﻿// SdiWorkspaceWindow.cs
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
+using System.Linq;
+using System.Text;
+using Gtk;
+using MonoDevelop.Components.Commands;
+using MonoDevelop.Components;
+using System.Collections;
+using MonoDevelop.Core.Gui;
+using MonoDevelop.Core;
+using MonoDevelop.Ide.Gui.Content;
+
+namespace MonoDevelop.Ide.Gui
+{
+    class SdiWorkspaceWindow : Frame, IWorkbenchWindow, ICommandDelegatorRouter
+	{
+        private VBox vBox = null;
+        private IWorkbench workbench = null;
+        private IViewContent content = null;
+        private Notebook tabControl = null;
+
+        private ViewCommandHandlers viewCommandHandlers = null;
+
+        private Notebook subViewNotebook = null;
+
+        private bool updating = false;
+
+        private Toolbar subViewToolbar = null;
+
+        private TabLabel tabLabel = null;
+        public TabLabel TabLabel
+        {
+            get { return tabLabel; }
+        }
+
+        private ViewCommandHandlers commandHandler = null;
+        public ViewCommandHandlers CommandHandler
+        {
+            get { return commandHandler; }
+        }
+
+
+        public SdiWorkspaceWindow (IWorkbench workbench, IViewContent content, Notebook tabControl, TabLabel tabLabel): base()
+        {
+            vBox = new VBox();
+            vBox.Add (content.Control);
+            this.Add (vBox);
+            Show ();
+            vBox.Show ();
+            content.Control.Show ();
+
+            this.workbench = workbench;
+            this.content = content;
+            this.tabControl = tabControl;
+            this.tabLabel = tabLabel;
+            
+
+            SetTitleEvent (null, null);
+
+            content.WorkbenchWindow = this;
+
+            content.ContentChanged += new EventHandler (OnContentChanged);
+            content.BeforeSave += new EventHandler (OnBeforeSave);
+            content.ContentNameChanged += new EventHandler (SetTitleEvent);
+            content.DirtyChanged += new EventHandler (SetTitleEvent);
+
+            viewCommandHandlers = new ViewCommandHandlers (this);
+        }
+
+        protected SdiWorkspaceWindow (IntPtr intPtr): base (intPtr)
+        {
+        }
+
+        #region ICommandDelegatorRouter Members
+
+        public object GetNextCommandTarget ()
+        {
+            return Parent;
+        }
+
+        public object GetDelegatedCommandTarget ()
+        {
+            return content != content.Control ? content : null;
+        }
+
+        #endregion
+
+
+        #region IWorkbenchWindow Members
+
+        private string title = "";
+        public string Title
+        {
+            get
+            {
+                return title;
+            }
+            set
+            {
+                title = value;
+                OnTitleChanged (EventArgs.Empty);
+            }
+        }
+
+        private string documentType = null;
+        public string DocumentType
+        {
+            get
+            {
+                return documentType;
+            }
+            set
+            {
+                documentType = value;
+            }
+        }
+
+        private bool showNotification = false;
+        public bool ShowNotification
+        {
+            get
+            {
+                return showNotification;
+            }
+            set
+            {
+                if (showNotification != value) {
+                    showNotification = value;
+                }
+
+                OnTitleChanged (EventArgs.Empty);
+            }
+        }
+
+        public IViewContent ViewContent
+        {
+            get { return content; } //maybe we need setter
+            set { content = value; }
+        }
+
+        private ArrayList subViewContents = null;
+        public ArrayList SubViewContents
+        {
+            get { return subViewContents; }
+        }
+
+        private IBaseViewContent activeViewContent = null;
+        public IBaseViewContent ActiveViewContent
+        {
+            get
+            {
+                if (activeViewContent != null)
+                    return activeViewContent;
+
+                if ((subViewNotebook != null) && (subViewNotebook.CurrentPage > 0))
+                    return (IBaseViewContent)subViewContents[subViewNotebook.CurrentPage - 1];
+                else
+                    return content;
+                
+            }
+            set
+            {
+                activeViewContent = value;
+                OnActiveViewContentChanged(new ActiveViewContentEventArgs(value));
+            }
+        }
+
+        private Document document = null;
+        public Document Document
+        {
+            get
+            {
+                return document;
+            }
+            set
+            {
+                document = value;
+            }
+        }
+
+        public bool CloseWindow (bool force, bool fromMenu, int pageNum)
+        {
+            WorkbenchWindowEventArgs workbenchWindowEventArgs = new WorkbenchWindowEventArgs (force, (workbench.WorkbenchLayout.ActiveWorkbenchwindow == this));
+            OnClosing (workbenchWindowEventArgs);
+            if (workbenchWindowEventArgs.Cancel)
+                return false;
+
+            content.ContentChanged -= new EventHandler (OnContentChanged);
+            content.BeforeSave -= new EventHandler (OnBeforeSave);
+            content.ContentNameChanged -= new EventHandler (SetTitleEvent);
+            content.DirtyChanged -= new EventHandler (SetTitleEvent);
+
+            content.WorkbenchWindow = null;
+
+            if (subViewContents != null) {
+                subViewNotebook.Remove (content.Control);
+                foreach (IAttachableViewContent subViewContent in subViewContents)
+                {
+                    subViewContent.Dispose ();
+                    subViewNotebook.Remove (subViewContent.Control);
+                }
+            }
+            else {
+                vBox.Remove (content.Control);
+            }
+
+            content.Dispose ();
+            tabLabel.Dispose ();
+
+            DetachFromPathedDocument ();
+            OnClosed (workbenchWindowEventArgs);
+            Destroy ();
+
+            content = null;
+
+            return true;
+        }
+
+        public void SelectWindow ()
+        {
+            if (this.Parent == null)
+                return;
+            tabControl.CurrentPage = tabControl.PageNum (this);
+        }
+
+        public void SwitchView (int viewNumber)
+        {
+            if (subViewNotebook == null)
+                return;
+
+            if (updating)
+                return;
+
+            updating = true;
+            subViewNotebook.CurrentPage = viewNumber;
+
+            int i = 0;
+            foreach (Widget widget in subViewToolbar.Children) {
+                ToggleToolButton btn = widget as ToggleToolButton;
+                if (btn != null) {
+                    btn.Active = (i == viewNumber);
+                }
+                i++;
+            }
+
+            updating = false;
+        }
+
+        public void AttachViewContent (IAttachableViewContent subViewContent)
+        {
+            if (subViewContents == null) {
+                subViewContents = new ArrayList ();
+                vBox.Remove (ViewContent.Control);
+
+                subViewNotebook = new Notebook ();
+                subViewNotebook.ShowBorder = false;
+                subViewNotebook.ShowTabs = false;
+                subViewNotebook.TabPos = PositionType.Bottom;
+                subViewNotebook.SwitchPage += subViewNotebookIndexChanged;
+                subViewNotebook.Show ();
+
+                ToggleToolButton toggleToolButton = AddButton (ViewContent.TabPageLabel, ViewContent.Control);
+                toggleToolButton.Active = true;
+
+                vBox.PackStart (subViewNotebook, true, true, 0);
+                vBox.ShowAll ();
+            }
+
+            subViewContent.WorkbenchWindow = this;
+            subViewContents.Add (subViewContent);
+
+            AddButton (subViewContent.TabPageLabel, subViewContent.Control);
+
+            OnContentChanged (null, null);
+        }
+
+        public event EventHandler TitleChanged;
+
+        public event WorkbenchWindowEventHandler Closing;
+
+        public event WorkbenchWindowEventHandler Closed;
+
+        public event ActiveViewContentEventHandler ActiveViewContentChanged;
+
+        #endregion
+
+        private void OnTitleChanged (EventArgs e)
+        {
+            tabLabel.Label.UseMarkup = showNotification;
+            if (showNotification)
+                tabLabel.Label.Markup = String.Format ("<span foreground=\"blue\">{0}</span>", Title);
+            else
+                tabLabel.Label.Text = Title;
+
+            if (!String.IsNullOrEmpty (content.ContentName))
+                tabLabel.SetTooltip (content.ContentName, content.ContentName);
+
+            try {
+                if (!String.IsNullOrEmpty (content.StockIconId)) {
+                    tabLabel.Icon = new Gtk.Image (content.StockIconId, IconSize.Menu);
+                }
+                else if (!String.IsNullOrEmpty (content.ContentName) && !(content.ContentName.Contains ("+") && content.ContentName.Contains ("*"))) {
+                    tabLabel.Icon.Pixbuf = DesktopService.GetPixbufForFile (content.ContentName, IconSize.Menu);
+                }
+            }
+            catch (Exception ex) {
+                LoggingService.LogError (ex.ToString ());
+                tabLabel.Icon.Pixbuf = DesktopService.GetPixbufForType ("gnome-fs-regular", IconSize.Menu);
+            }
+
+            if (TitleChanged != null) 
+                TitleChanged(this, e);
+        }
+
+        protected virtual void OnActiveViewContentChanged (ActiveViewContentEventArgs e)
+        {
+            if (ActiveViewContentChanged != null)
+                ActiveViewContentChanged (this, e);
+        }
+
+        protected virtual void OnClosing (WorkbenchWindowEventArgs e)
+        {
+            if (Closing != null)
+                Closing (this, e);
+        }
+
+        protected virtual void OnClosed (WorkbenchWindowEventArgs e)
+        {
+            if (Closed != null)
+                Closed (this, e);
+        }
+        
+        public void OnContentChanged (System.Object o, EventArgs e)
+        {
+            if (subViewContents != null) {
+                foreach (IAttachableViewContent subViewContent in subViewContents)
+                    subViewContent.BaseContentChanged ();
+
+            }
+        }
+
+        private void OnBeforeSave (System.Object o, EventArgs e)
+        {
+            if (ActiveViewContent is IAttachableViewContent)
+                ((IAttachableViewContent)ActiveViewContent).BeforeSave ();
+
+        }
+
+        private string untitledName;
+        public void SetTitleEvent (System.Object o, EventArgs e)
+        {
+            if (content == null)
+                return;
+
+            string title = "";
+            if (!String.IsNullOrEmpty (content.ContentName)) {
+                title = System.IO.Path.GetFileName (content.ContentName);
+                untitledName = null;
+            }
+            else {
+                string baseName = System.IO.Path.GetFileNameWithoutExtension (content.UntitledName);
+                untitledName = baseName + System.IO.Path.GetExtension (content.UntitledName);
+
+                if (!TitleExists (untitledName)) {
+                    int i = 1;
+                    while (true) {
+                        untitledName = baseName + i + System.IO.Path.GetExtension (content.UntitledName);
+                        if ( TitleExists(untitledName)) break;
+                        i++;
+                    }
+                }
+                else
+                    title = untitledName;
+            }
+
+            if (content.IsDirty) {
+                title = title + "*";
+                IdeApp.ProjectOperations.MarkFileDirty (content.ContentName);
+            }
+            else if (content.IsReadOnly) {
+                title = title + "*";
+            }
+
+            Title = title;
+        }
+
+        private bool TitleExists (string titleFound)
+        {
+            foreach (IViewContent viewContent in workbench.ViewContentCollection) {
+                string name = viewContent.WorkbenchWindow.Title;
+                if (name.EndsWith ("*") || name.EndsWith ("+"))
+                    name.Remove (name.Length, 1);
+
+                if (name == titleFound)
+                    return true;
+            }
+
+            return false;
+
+        }
+
+        private int prevIndex = -1;
+        protected void subViewNotebookIndexChanged (System.Object o, SwitchPageArgs e)
+        {
+            if (prevIndex != -1) {
+                if (subViewContents[prevIndex - 1] is IAttachableViewContent) {
+                    ((IAttachableViewContent)subViewContents[prevIndex - 1]).Deselected ();
+                }
+            }
+
+            prevIndex = subViewNotebook.CurrentPage;
+
+            if (prevIndex > 0) {
+                if (subViewContents[prevIndex - 1] is IAttachableViewContent) {
+                    ((IAttachableViewContent)subViewContents[prevIndex - 1]).Selected ();
+                }
+            }
+
+            OnActiveViewContentChanged (new ActiveViewContentEventArgs (ActiveViewContent));
+        }
+
+        private HBox toolbarBox = null;
+        protected ToggleToolButton AddButton (String label,  Widget page)
+        {
+            if (subViewToolbar == null) {
+                subViewToolbar = new Toolbar ();
+                subViewToolbar.ShowArrow = false;
+                subViewToolbar.ToolbarStyle = ToolbarStyle.BothHoriz;
+                subViewToolbar.IconSize = IconSize.SmallToolbar;
+
+                subViewToolbar.Show ();
+                CheckCreateToolbarBox ();
+                toolbarBox.PackStart (subViewToolbar, false, false, 0);
+            }
+
+            this.updating = true;
+
+            ToggleToolButton buttonResult = new ToggleToolButton ();
+            buttonResult.Label = label;
+            buttonResult.IsImportant = true;
+            buttonResult.Clicked += new EventHandler (OnButtonToggled);
+            buttonResult.ShowAll ();
+
+            subViewToolbar.Insert (buttonResult, -1);
+            subViewNotebook.AppendPage (page, new Gtk.Label ());
+            page.ShowAll ();
+            EnsureToolbarBoxSeparator ();
+
+            this.updating = false;
+
+            return buttonResult;
+        }
+
+        private void OnButtonToggled (System.Object o, EventArgs e)
+        {
+            int index = 0;
+            foreach (Widget w in subViewToolbar.Children) {
+                if (w == (Widget)o) {
+                    SwitchView (index);
+                    return;
+                }
+                index++;
+            }
+        }
+
+        private void CheckCreateToolbarBox ()
+        {
+            if (toolbarBox == null ) {
+                toolbarBox = new HBox(false, 6);
+                toolbarBox.Show ();
+                vBox.PackEnd (toolbarBox, false, false, 3);
+
+            }
+        }
+
+        private HBox pathBox = null;
+        private SeparatorToolItem separatorItem = null;
+        private void EnsureToolbarBoxSeparator() {
+            if ( (subViewToolbar != null) && (toolbarBox != null)) {
+
+                if (pathBox == null && separatorItem != null) {
+                    subViewToolbar.Remove (separatorItem);
+                    separatorItem = null;
+                }
+
+                if ( (separatorItem != null) && (pathBox != null) && (subViewToolbar.GetItemIndex (separatorItem) != subViewToolbar.NumChildren - 1)) {
+                    subViewToolbar.Remove (separatorItem);
+                    subViewToolbar.Insert (separatorItem, -1);
+                }
+                else if ( (pathBox != null) && (separatorItem == null)) {
+                    separatorItem = new SeparatorToolItem();
+                    subViewToolbar.Insert (separatorItem, -1);
+                }
+            }
+        }
+
+        public bool PathWidgetEnabled
+        {
+            get
+            {
+                return (pathBox != null);
+            }
+
+            set
+            {
+                if ((pathBox != null) == value)
+                    return;
+
+                if (value) {
+                    CheckCreateToolbarBox ();
+
+                    pathBox = new HBox ();
+                    pathBox.Spacing = 0;
+
+                    toolbarBox.PackEnd (pathBox, true, true, 0);
+                    toolbarBox.ShowAll ();
+                }
+                else {
+                    toolbarBox.Remove (pathBox);
+                    toolbarBox.Destroy ();
+                }
+
+                EnsureToolbarBoxSeparator ();
+            }
+        }
+
+        void HandlePathChange (System.Object o, EventArgs e)
+        {
+            for (int i = pathBox.Children.Length - 1; i >= 0; i--) {
+                pathBox.Remove (pathBox.Children[i]);
+            }
+
+            IPathedDocument pathedDocument = o as IPathedDocument;
+            for (int i = 0; i < pathedDocument.CurrentPath.Length; i++) {
+                PathMenuButton menuButton = new PathMenuButton (pathedDocument, i);
+
+                if (i == pathedDocument.CurrentPath.Length - 1)
+                    menuButton.ArrowType = ArrowType.Right;
+                else
+                    menuButton.ArrowType = null;
+
+                if (pathDoc.SelectedIndex == i)
+                    menuButton.Markup = String.Format ("<b>{0}</b>", GLib.Markup.EscapeText (pathedDocument.CurrentPath[i]));
+                else
+                    menuButton.Label = pathDoc.CurrentPath[i];
+
+                pathBox.PackStart (menuButton, false, false, 0);
+
+            }
+
+            pathBox.PackEnd (new Label (string.Empty), true, true, 0);
+            pathBox.ShowAll ();
+        }
+
+        private IPathedDocument pathDoc = null;
+        public void AttachToPathedDocument (IPathedDocument pathedDocument)
+        {
+            if (this.pathDoc != pathedDocument) {
+                DetachFromPathedDocument ();
+            }
+
+            if (pathedDocument != null) {
+                PathWidgetEnabled = true;
+                pathedDocument.PathChanged += HandlePathChange;
+                this.pathDoc = pathedDocument;
+            }
+        }
+
+        public void DetachFromPathedDocument ()
+        {
+            if (pathDoc != null) {
+                PathWidgetEnabled = false;
+                pathDoc.PathChanged -= HandlePathChange;
+                this.pathDoc = null;
+            }
+        }
+
+        internal class PathMenuButton : MenuButton {
+            private IPathedDocument pathedDocument = null;
+            private int index;
+
+            public PathMenuButton (IPathedDocument pathedDocument, int index)
+        {
+            this.Relief = ReliefStyle.None;
+
+            this.pathedDocument = pathedDocument;
+            this.index = index;
+
+            this.MenuCreator = (delegate (MenuButton menuButton) 
+                {
+                    Menu menu = new Menu();
+                    MenuItem menuItem = new MenuItem(GettextCatalog.GetString("Select"));
+                    menuItem.Activated += delegate { pathedDocument.SelectPath (index); };
+                    menu.Add (menuItem);
+
+                    MenuItem menuItemContent = new MenuItem (GettextCatalog.GetString ("Select contents"));
+                    menuItemContent.Activated += delegate { pathedDocument.SelectPathContents (index); };
+                    menu.Add (menuItemContent);
+
+                    menu.ShowAll ();
+                    
+                    return menu;
+            });
+        }
+        }
+       
+    }
+
+    
+}