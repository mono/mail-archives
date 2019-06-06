Index: main/src/core/MonoDevelop.Ide/ChangeLog
===================================================================
--- main/src/core/MonoDevelop.Ide/ChangeLog	(revision 139347)
+++ main/src/core/MonoDevelop.Ide/ChangeLog	(working copy)
@@ -1,3 +1,9 @@
+2009-08-04  Viktoria Dudka  <viktoriad@remobjects.com>
+
+	* MonoDevelop.Ide.Gui.Dialogs/TipOfTheDay.cs: Rewritten from scratch
+	* MonoDevelop.Ide.Gui/TipOfTheDayStartupHandler.cs: Deleted
+	* MonoDevelop.Ide.addin.xml: moved auto-start to a different location
+	  
 2009-08-04  Mike Krüger  <mkrueger@novell.com>
 
 	* MonoDevelop.Ide.Gui/RootWorkspace.cs:
Index: main/src/core/MonoDevelop.Ide/Makefile.am
===================================================================
--- main/src/core/MonoDevelop.Ide/Makefile.am	(revision 139347)
+++ main/src/core/MonoDevelop.Ide/Makefile.am	(working copy)
@@ -314,7 +314,6 @@
 	MonoDevelop.Ide.Gui/StatusProgressMonitor.cs \
 	MonoDevelop.Ide.Gui/TextEditor.cs \
 	MonoDevelop.Ide.Gui/TextFileNavigationPoint.cs \
-	MonoDevelop.Ide.Gui/TipOfTheDayStartupHandler.cs \
 	MonoDevelop.Ide.Gui/ToolbarComboBox.cs \
 	MonoDevelop.Ide.Gui/ViewCommandHandlers.cs \
 	MonoDevelop.Ide.Gui/Workbench.cs \
Index: main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.addin.xml
===================================================================
--- main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.addin.xml	(revision 139347)
+++ main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.addin.xml	(working copy)
@@ -209,7 +209,7 @@
 
 	<Extension path = "/MonoDevelop/Ide/StartupHandlers">
 		<Class class = "MonoDevelop.Ide.Gui.AddinUpdateHandler"/>
-		<Class class = "MonoDevelop.Ide.Gui.TipOfTheDayStartupHandler"/>
+		<Class class = "MonoDevelop.Ide.Gui.Dialogs.TipOfTheDayStartup"/>
 	</Extension>
 	
 	<Extension path = "/MonoDevelop/Ide/Commands">
Index: main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.csproj
===================================================================
--- main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.csproj	(revision 139347)
+++ main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.csproj	(working copy)
@@ -358,7 +358,6 @@
     <Compile Include="MonoDevelop.Ide.Gui\ProgressMonitors.cs" />
     <Compile Include="MonoDevelop.Ide.Gui\IdeStartup.cs" />
     <Compile Include="MonoDevelop.Ide.Gui\AddinUpdateHandler.cs" />
-    <Compile Include="MonoDevelop.Ide.Gui\TipOfTheDayStartupHandler.cs" />
     <Compile Include="MonoDevelop.Ide\Services.cs" />
     <Compile Include="MonoDevelop.Ide.Gui.OptionPanels\TasksOptionsPanel.cs" />
     <Compile Include="MonoDevelop.Ide.Gui\FileViewer.cs" />
Index: main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.Gui.Dialogs/TipOfTheDay.cs
===================================================================
--- main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.Gui.Dialogs/TipOfTheDay.cs	(revision 139347)
+++ main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.Gui.Dialogs/TipOfTheDay.cs	(working copy)
@@ -1,95 +1,88 @@
-//  TipOfTheDay.cs
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
 using System;
-using System.IO;
-using System.Xml;
-
+using Mono.GetOptions;
 using Gtk;
-using MonoDevelop.Core.Gui;
+using System.Reflection;
+using System.Xml;
 using MonoDevelop.Core;
-using MonoDevelop.Ide.Gui;
+using System.Collections.Generic;
+using MonoDevelop.Components.Commands;
+using MonoDevelop.Core.Gui;
 
 namespace MonoDevelop.Ide.Gui.Dialogs
 {
-	internal partial class TipOfTheDayWindow: Gtk.Window
+    internal partial class TipOfTheDayWindow : Gtk.Window
 	{
-		string[] tips;
-		int currentTip = 0;
+        private List<string> tips = new List<string> ();
+        private int currentTip;
 
-		public TipOfTheDayWindow (): base (WindowType.Toplevel)
-		{
-			Build ();
-			TransientFor = IdeApp.Workbench.RootWindow;
+        private string property = "MonoDevelop.Core.Gui.Dialog.TipOfTheDayView.ShowTipsAtStartup";
 
-			noshowCheckbutton.Active = PropertyService.Get ("MonoDevelop.Core.Gui.Dialog.TipOfTheDayView.ShowTipsAtStartup", false);
-			noshowCheckbutton.Toggled += new EventHandler (OnNoshow);
-			nextButton.Clicked += new EventHandler (OnNext);
-			closeButton.Clicked += new EventHandler (OnClose);
-			DeleteEvent += new DeleteEventHandler (OnDelete);
+        public TipOfTheDayWindow()
+            : base (WindowType.Toplevel)
+        {
+            Build ();
+            TransientFor = IdeApp.Workbench.RootWindow;
 
- 			XmlDocument doc = new XmlDocument();
- 			doc.Load (PropertyService.DataPath +
-				  System.IO.Path.DirectorySeparatorChar + "options" +
-				  System.IO.Path.DirectorySeparatorChar + "TipsOfTheDay.xml");
-			ParseTips (doc.DocumentElement);
-			
-			tipTextview.Buffer.Clear ();
-			tipTextview.Buffer.InsertAtCursor (tips[currentTip]);
-		}
+            if (PropertyService.Get (property, false)) {
+                noshowCheckbutton.Active = true;
+            }
+            try {
+            XmlDocument xmlDocument = new XmlDocument ();
+            xmlDocument.Load (System.IO.Path.Combine (System.IO.Path.Combine (PropertyService.DataPath, "options"), "TipsOfTheDay.xml"));
 
-		private void ParseTips (XmlElement el)
-		{
- 			XmlNodeList nodes = el.ChildNodes;
- 			tips = new string[nodes.Count];
-			
- 			for (int i = 0; i < nodes.Count; i++) {
- 				tips[i] = StringParserService.Parse (nodes[i].InnerText);
- 			}
-			
- 			currentTip = (new Random ().Next ()) % nodes.Count;
-		}
+            foreach (XmlNode xmlNode in xmlDocument.DocumentElement.ChildNodes) {
+                tips.Add (StringParserService.Parse (xmlNode.InnerText));
+            }
+           
+            if (tips.Count != 0) 
+                currentTip = new Random ().Next () % tips.Count;
+            else
+                currentTip = -1;
 
-		void OnNoshow (object obj, EventArgs args)
-		{
-			PropertyService.Set ("MonoDevelop.Core.Gui.Dialog.TipOfTheDayView.ShowTipsAtStartup",
-						    noshowCheckbutton.Active);
-		}
+            tipTextview.Buffer.Clear ();
+            if (currentTip != -1) 
+                tipTextview.Buffer.InsertAtCursor (tips[currentTip]);
 
-		void OnNext (object obj, EventArgs args)
-		{
-			tipTextview.Buffer.Clear ();
-			currentTip = ++currentTip % tips.Length;
-			tipTextview.Buffer.InsertAtCursor (tips[currentTip]);
-		}
+            noshowCheckbutton.Toggled += new EventHandler (OnNoShow);
+            nextButton.Clicked += new EventHandler (OnNextClicked);
+            closeButton.Clicked += new EventHandler (OnCloseClicked);
+            DeleteEvent += new DeleteEventHandler (OnCloseClicked);
+            
+        }
 
-		void OnClose (object obj, EventArgs args)
-		{
-			Hide ();
-			Destroy ();
-		}
+        void OnNoShow (object o, EventArgs e)
+        {
+            PropertyService.Set (property, noshowCheckbutton.Active);
+        }
 
-		void OnDelete (object obj, DeleteEventArgs args)
-		{
-			Hide ();
-			Destroy ();
-		}
+        void OnNextClicked (object o, EventArgs e)
+        {
+            if (tips.Count == 0)
+                return;
+
+            currentTip = currentTip + 1;
+            if (currentTip >= tips.Count)
+                currentTip = 0;
+
+            tipTextview.Buffer.Clear ();
+            tipTextview.Buffer.InsertAtCursor (tips[currentTip]);
+
+
+        }
+
+        void OnCloseClicked (object o, EventArgs e)
+        {
+            Hide ();
+            Destroy ();
+        }
 	}
+
+    class TipOfTheDayStartup : CommandHandler {
+        protected override void Run ()
+        {
+            if (PropertyService.Get ("MonoDevelop.Core.Gui.Dialog.TipOfTheDayView.ShowTipsAtStartup", false)) {
+                new TipOfTheDayWindow ().Show ();
+            }
+        }
+    }
 }
Index: main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.Gui/TipOfTheDayStartupHandler.cs
===================================================================
--- main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.Gui/TipOfTheDayStartupHandler.cs	(revision 139347)
+++ main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.Gui/TipOfTheDayStartupHandler.cs	(working copy)
@@ -1,39 +0,0 @@
-/*
-Copyright (C) 2006  Jacob Ilsø Christensen
-
-This program is free software; you can redistribute it and/or
-modify it under the terms of the GNU General Public License
-as published by the Free Software Foundation; either version 2
-of the License, or (at your option) any later version.
-
-This program is distributed in the hope that it will be useful,
-but WITHOUT ANY WARRANTY; without even the implied warranty of
-MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-GNU General Public License for more details.
-
-You should have received a copy of the GNU General Public License
-along with this program; if not, write to the Free Software
-Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
-*/
-
-using MonoDevelop.Core;
-using MonoDevelop.Ide.Gui.Dialogs;
-using MonoDevelop.Components.Commands;
-
-namespace MonoDevelop.Ide.Gui
-{
-	/// <summary>
-	/// The responsibility of this CommandHandler is
-	/// to show the Tip of the Day window at startup
-	/// </summary>
-	class TipOfTheDayStartupHandler: CommandHandler
-	{
-		protected override void Run ()
-		{
-			if (PropertyService.Get("MonoDevelop.Core.Gui.Dialog.TipOfTheDayView.ShowTipsAtStartup", false))
-			{
-				new TipOfTheDayWindow().Show();
-			}
-		}		
-	}
-}