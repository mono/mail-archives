Index: main/src/core/MonoDevelop.Ide/ChangeLog
===================================================================
--- main/src/core/MonoDevelop.Ide/ChangeLog	(revision 139347)
+++ main/src/core/MonoDevelop.Ide/ChangeLog	(working copy)
@@ -1,3 +1,11 @@
+2009-08-04  Viktoria Dudka  <viktoriad@remobjects.com>
+
+	* MonoDevelop.Ide.Gui/WorkbenchContext.cs:
+	* MonoDevelop.Ide.Gui/IWorkbench.cs: Rewritten from scratch
+	  to make it non-GPL. 
+	* MonoDevelop.Ide.Gui/IWorkbenchLayout.cs: Rewritten from scratch
+	  to make it non-GPL.
+	  
 2009-08-04  Mike Krüger  <mkrueger@novell.com>
 
 	* MonoDevelop.Ide.Gui/RootWorkspace.cs:
Index: main/src/core/MonoDevelop.Ide/Makefile.am
===================================================================
--- main/src/core/MonoDevelop.Ide/Makefile.am	(revision 139347)
+++ main/src/core/MonoDevelop.Ide/Makefile.am	(working copy)
@@ -318,6 +318,7 @@
 	MonoDevelop.Ide.Gui/ToolbarComboBox.cs \
 	MonoDevelop.Ide.Gui/ViewCommandHandlers.cs \
 	MonoDevelop.Ide.Gui/Workbench.cs \
+	MonoDevelop.Ide.Gui/WorkbenchContext.cs \
 	MonoDevelop.Ide.Gui/WorkbenchMemento.cs \
 	MonoDevelop.Ide.StandardHeader/StandardHeaderPolicyPanel.cs \
 	MonoDevelop.Ide.StandardHeader/StandardHeaderService.cs \
Index: main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.csproj
===================================================================
--- main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.csproj	(revision 139347)
+++ main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.csproj	(working copy)
@@ -567,6 +567,7 @@
     <Compile Include="gtk-gui\MonoDevelop.Ide.Gui.Dialogs.ConfirmProjectDeleteDialog.cs" />
     <Compile Include="MonoDevelop.Ide.Gui.Dialogs\SelectFileFormatDialog.cs" />
     <Compile Include="gtk-gui\MonoDevelop.Ide.Gui.Dialogs.SelectFileFormatDialog.cs" />
+	<Compile Include="MonoDevelop.Ide.Gui\WorkbenchContext.cs" />
   </ItemGroup>
   <ItemGroup>
     <None Include="ChangeLog" />
Index: main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.Gui/IWorkbench.cs
===================================================================
--- main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.Gui/IWorkbench.cs	(revision 139347)
+++ main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.Gui/IWorkbench.cs	(working copy)
@@ -1,160 +1,48 @@
-//  IWorkbench.cs
+// IWorkbench.cs
 //
-//  This file was derived from a file from #Develop. 
+// Author:
+//   Viktoria Dudka (viktoriad@remobjects.com)
 //
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
 
 using System;
-using System.Collections;
-using System.Collections.ObjectModel;
 using System.Collections.Generic;
-using MonoDevelop.Core.Gui;
+using System.Linq;
+using System.Text;
 using MonoDevelop.Ide.Codons;
+using System.Collections.ObjectModel;
 
 namespace MonoDevelop.Ide.Gui
 {
-	public class WorkbenchContext
+	public interface IWorkbench
 	{
-		string id;
-		static Hashtable contexts = new Hashtable ();
-		
-		WorkbenchContext (string id)
-		{
-			this.id = id;
-		}
-		
-		public static WorkbenchContext GetContext (string id)
-		{
-			WorkbenchContext ctx = (WorkbenchContext) contexts [id];
-			if (ctx == null) {
-				ctx = new WorkbenchContext (id);
-				contexts [id] = ctx;
-			}
-			return ctx;
-		}
-		
-		public static WorkbenchContext Edit {
-			get { return GetContext ("Edit"); }
-		}
-		
-		public static WorkbenchContext Debug {
-			get { return GetContext ("Debug"); }
-		}
-		
-		public string Id {
-			get { return id; }
-		}
-	}
-	
-	/// <summary>
-	/// This is the basic interface to the workspace.
-	/// </summary>
-	internal interface IWorkbench : IMementoCapable
-	{
-		/// <summary>
-		/// The title shown in the title bar.
-		/// </summary>
-		string Title {
-			get;
-			set;
-		}
-		
-		/// <summary>
-		/// A collection in which all active workspace windows are saved.
-		/// </summary>
-		ReadOnlyCollection<IViewContent> ViewContentCollection {
-			get;
-		}
-		
-		/// <summary>
-		/// A collection in which all active workspace windows are saved.
-		/// </summary>
-		ReadOnlyCollection<PadCodon> PadContentCollection {
-			get;
-		}
-		
-		/// <summary>
-		/// The active workbench window.
-		/// </summary>
-		IWorkbenchWindow ActiveWorkbenchWindow {
-			get;
-		}
-		
-		IWorkbenchLayout WorkbenchLayout {
-			get;
-		}
-		
-		/// <summary>
-		/// Inserts a new <see cref="IViewContent"/> object in the workspace.
-		/// </summary>
-		void ShowView (IViewContent content, bool bringToFront);
-		
-		/// <summary>
-		/// Inserts a new <see cref="IPadContent"/> object in the workspace.
-		/// </summary>
-		void ShowPad(PadCodon content);
-		void AddPad(PadCodon content);
-		
-		void CloseContent(IViewContent content);
-		
-		/// <summary>
-		/// Returns a pad from a specific type.
-		/// </summary>
-		PadCodon GetPad(Type type);
-		
-		/// <summary>
-		/// Returns a pad from an id.
-		/// </summary>
-		PadCodon GetPad(string id);
-		
-		/// <summary>
-		/// Tries to make the pad visible to the user.
-		/// </summary>
-		void BringToFront (PadCodon content);
-		
-		/// <summary>
-		/// Closes all views inside the workbench.
-		/// </summary>
-		void CloseAllViews();
-		
-		/// <summary>
-		/// Re-initializes all components of the workbench, should be called
-		/// when a special property is changed that affects layout st	uff.
-		/// (like language change) 
-		/// </summary>
-		void RedrawAllComponents();
+        IWorkbenchLayout WorkbenchLayout { get; }
+        ReadOnlyCollection<IViewContent> ViewContentCollection { get; }
 
-		/// <summary>
-		/// Is called, when the workbench window which the user has into
-		/// the foreground (e.g. editable) changed to a new one.
-		/// </summary>
-		event EventHandler ActiveWorkbenchWindowChanged;
+        void BringToFront( PadCodon pad);
 
-		/// <summary>
-		/// The context the workbench is currently in
-		/// </summary>
-		WorkbenchContext Context {
-			get;
-			set;
-		}
-		
-		/// <summary>
-		/// Called when the Context property changes
-		/// </summary>
-		event EventHandler ContextChanged;
+        void CloseContent(IViewContent viewContent);
+
+        void ShowView(IViewContent viewContent, bool bringToFront);
 	}
 }
Index: main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.Gui/IWorkbenchLayout.cs
===================================================================
--- main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.Gui/IWorkbenchLayout.cs	(revision 139347)
+++ main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.Gui/IWorkbenchLayout.cs	(working copy)
@@ -1,145 +1,72 @@
-//  IWorkbenchLayout.cs
+// IWorkbenchLayout.cs
 //
-//  This file was derived from a file from #Develop. 
+// Author:
+//   Viktoria Dudka (viktoriad@remobjects.com)
 //
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
 
 using System;
 using System.Collections.Generic;
-using MonoDevelop.Core.Gui;
+using System.Linq;
+using System.Text;
 using MonoDevelop.Ide.Codons;
+using MonoDevelop.Core.Gui;
 
 namespace MonoDevelop.Ide.Gui
 {
-	/// <summary>
-	/// The IWorkbenchLayout object is responsible for the layout of 
-	/// the workspace, it shows the contents, chooses the IWorkbenchWindow
-	/// implementation etc. it could be attached/detached at the runtime
-	/// to a workbench.
-	/// </summary>
-	internal interface IWorkbenchLayout: IMementoCapable
+    public interface IWorkbenchLayout : IMementoCapable
 	{
-		/// <summary>
-		/// The active workbench window.
-		/// </summary>
+        List<PadCodon> PadContentCollection { get; }
+        IWorkbenchWindow ActiveWorkbenchwindow { get; }
+        string CurrentLayout { get; set; }
+        string[] Layouts { get; }
 
-		Gtk.Widget LayoutWidget {
-			get;
-		}
-		
-		IWorkbenchWindow ActiveWorkbenchwindow {
-			get;
-		}
+        void Attach(IWorkbench workbench);
+        void Detach();
 
-		/// <summary>
-		/// The name of the active layout.
-		/// </summary>
-		string CurrentLayout {
-			get;
-			set;
-		}
+        bool IsVisible(PadCodon padContent);
+        bool IsContentVisible(PadCodon padContent);
+        bool IsSticky(PadCodon padContent);
 
-		/// <summary>
-		/// A list of the currently available layouts for the current workbench context.
-		/// </summary>
-		string[] Layouts {
-			get;
-		}
-		
-		void DeleteLayout (string name);
+        void AddPad(PadCodon padContent);
+        void RemovePad(PadCodon padContent);
+        void ShowPad(PadCodon padContent);
+        void HidePad(PadCodon padContent);
+        void ActivatePad(PadCodon padContent);
+        IPadWindow GetPadWindow(PadCodon padContent);
 
-		/// <summary>
-		/// Attaches this layout manager to a workbench object.
-		/// </summary>
-		void Attach(IWorkbench workbench);
-		
-		/// <summary>
-		/// Detaches this layout manager from the current workspace.
-		/// </summary>
-		void Detach();
-		
-		/// <summary>
-		/// Shows a new <see cref="IPadContent"/>.
-		/// </summary>
-		void ShowPad (PadCodon content);
-		void AddPad (PadCodon content);
-		
-		IPadWindow GetPadWindow (PadCodon content);
-		
-		/// <summary>
-		/// Activates a pad (Show only makes it visible but Activate does
-		/// bring it to foreground)
-		/// </summary>
-		void ActivatePad(PadCodon content);
-		
-		/// <summary>
-		/// Hides a new <see cref="IPadContent"/>.
-		/// </summary>
-		void HidePad(PadCodon content);
-		
-		void RemovePad (PadCodon content);
-		
-		/// <summary>
-		/// returns true, if padContent is visible;
-		/// </summary>
-		bool IsVisible(PadCodon padContent);
-		bool IsContentVisible(PadCodon padContent);
-		
-		bool IsSticky (PadCodon padContent);
+        IWorkbenchWindow ShowView(IViewContent content);
 
-		void SetSticky (PadCodon padContent, bool sticky);
-		
-		/// <summary>
-		/// Re-initializes all components of the layout manager.
-		/// </summary>
-		void RedrawAllComponents();
-		
-		/// <summary>
-		/// Shows a new <see cref="IViewContent"/>.
-		/// </summary>
-		IWorkbenchWindow ShowView(IViewContent content);
+        void RemoveTab(int pageNum);
 
-		void RemoveTab (int pageNum);	
+        void RedrawAllComponents();
 
-		/// <summary>
-		/// Moves to the next tab.
-		/// </summary>          
-		void NextTab();
-		
-		/// <summary>
-		/// Moves to the previous tab.
-		/// </summary>          
-		void PreviousTab();
-		
-		/// <summary>
-		/// Is called, when the workbench window which the user has into
-		/// the foreground (e.g. editable) changed to a new one.
-		/// </summary>
-		event EventHandler ActiveWorkbenchWindowChanged;
+        void SetSticky(PadCodon padContent, bool value);
 
-		/// <summary>
-		/// A collection of all valid pads in the layout for the workbench context.
-		/// </summary>
-		List<PadCodon> PadContentCollection {
-			get;
-		}
-		
-		void ActiveMdiChanged(object sender, Gtk.SwitchPageArgs e);
-		
-		void ResetToolbars ();
+        void DeleteLayout(string name);
+
+        void ResetToolbars();
+
+        event EventHandler ActiveWorkbenchWindowChanged;
 	}
 }
Index: main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.Gui/WorkbenchContext.cs
===================================================================
--- main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.Gui/WorkbenchContext.cs	(revision 0)
+++ main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.Gui/WorkbenchContext.cs	(revision 0)
@@ -0,0 +1,64 @@
+// WorkbenchContext.cs
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
+
+namespace MonoDevelop.Ide.Gui
+{
+	public class WorkbenchContext
+	{
+        private string id;
+        public string Id
+        {
+            get
+            {
+                return id;
+            }
+        }
+
+        static Dictionary<string, WorkbenchContext> contexts = new Dictionary<string, WorkbenchContext>();
+
+        private WorkbenchContext(string pId)
+        {
+            this.id = pId;
+        }
+
+        public static WorkbenchContext GetContext(string pId)
+        {
+            WorkbenchContext workbenchContext;
+            if (!contexts.TryGetValue (pId, out workbenchContext)) {
+                workbenchContext = new WorkbenchContext (pId);
+                contexts.Add (pId, workbenchContext);
+            }
+
+            return workbenchContext;
+        }
+	}
+}