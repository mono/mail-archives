Index: main/src/core/MonoDevelop.Ide/ChangeLog
===================================================================
--- main/src/core/MonoDevelop.Ide/ChangeLog	(revision 135981)
+++ main/src/core/MonoDevelop.Ide/ChangeLog	(working copy)
@@ -1,3 +1,8 @@
+2009-06-01  Carlo Kok  <ck@remobjects.com>
+
+	* MonoDevelop.Ide.Commands\HelpCommands.cs:
+	* MonoDevelop.Ide.Commands\ViewCommands.cs: rewritten from scratch to make it non-GPL.
+	
 2009-06-10  Lluis Sanchez Gual  <lluis@novell.com>
 
 	* MonoDevelop.Ide.Gui.Dialogs\FileSelectorDialog.cs: Fix gtk
Index: main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.Commands/HelpCommands.cs
===================================================================
--- main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.Commands/HelpCommands.cs	(revision 135981)
+++ main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.Commands/HelpCommands.cs	(working copy)
@@ -1,72 +1,82 @@
-//  HelpCommands.cs
+// HelpCommands.cs
 //
-//  This file was derived from a file from #Develop. 
+// Author:
+//   Carlo Kok (ck@remobjects.com)
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
 
+
 using System;
-using System.Diagnostics;
-using System.IO;
-using System.Collections;
-using Gtk;
-
+using MonoDevelop.Core.Gui.Dialogs;
 using MonoDevelop.Core;
-using MonoDevelop.Core.Gui;
-using MonoDevelop.Core.Gui.Dialogs;
+using MonoDevelop.Ide;
+using Mono.Addins;
 using MonoDevelop.Ide.Gui;
+using MonoDevelop.Components.Commands;
 using MonoDevelop.Ide.Gui.Dialogs;
-using MonoDevelop.Components.Commands;
 
 namespace MonoDevelop.Ide.Commands
 {
-	public enum HelpCommands
-	{
+	/// <summary>
+	/// Copied from MonoDevelop.Ide.addin.xml
+	/// </summary>
+	public enum HelpCommands {
 		Help,
 		TipOfTheDay,
 		About
 	}
-	
-	internal class HelpHandler: CommandHandler
+
+	// MonoDevelop.Ide.Commands.HelpCommands.Help
+	public class HelpHandler: CommandHandler 
 	{
 		protected override void Run ()
 		{
 			IdeApp.HelpOperations.ShowHelp ("root:");
 		}
 	}
-	
-	internal class TipOfTheDayHandler: CommandHandler
+
+	// MonoDevelop.Ide.Commands.HelpCommands.TipOfTheDay
+	public class TipOfTheDayHandler : CommandHandler
 	{
 		protected override void Run ()
 		{
-			TipOfTheDayWindow totdw = new TipOfTheDayWindow ();
-			totdw.Show ();
+			TipOfTheDayWindow dlg = new TipOfTheDayWindow ();
+			dlg.Show ();
 		}
 	}
-		
-	internal class AboutHandler: CommandHandler
+
+	// MonoDevelop.Ide.Commands.HelpCommands.About
+	public class AboutHandler : CommandHandler
 	{
 		protected override void Run ()
 		{
-			CommonAboutDialog ad = new CommonAboutDialog ();
+			CommonAboutDialog dlg = new CommonAboutDialog ();
 			try {
-				ad.Run ();
-			} finally {
-				ad.Destroy ();
+				dlg.Run ();
 			}
+			finally {
+				dlg.Destroy ();
+			}
 		}
 	}
 }
Index: main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.Commands/ViewCommands.cs
===================================================================
--- main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.Commands/ViewCommands.cs	(revision 135981)
+++ main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.Commands/ViewCommands.cs	(working copy)
@@ -1,38 +1,39 @@
-//  ViewCommands.cs
+// ViewCommands.cs
 //
-//  This file was derived from a file from #Develop. 
+// Author:
+//   Carlo Kok (ck@remobjects.com)
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
 
+
 using System;
-using System.Collections;
-using System.Collections.Generic;
-using System.CodeDom.Compiler;
-using System.Diagnostics;
-
+using MonoDevelop.Core.Gui.Dialogs;
 using MonoDevelop.Core;
+using MonoDevelop.Ide;
 using Mono.Addins;
+using MonoDevelop.Ide.Gui;
 using MonoDevelop.Components.Commands;
-
-using MonoDevelop.Core.Gui;
-using MonoDevelop.Core.Gui.Dialogs;
-using MonoDevelop.Ide.Gui;
 using MonoDevelop.Ide.Gui.Dialogs;
-using MonoDevelop.Ide.Gui.Pads;
 using MonoDevelop.Ide.Gui.Content;
 
 namespace MonoDevelop.Ide.Commands
@@ -43,224 +44,235 @@
 		LayoutList,
 		NewLayout,
 		DeleteCurrentLayout,
+		LayoutSelector,
 		FullScreen,
 		Open,
-		OpenWithList,
 		TreeDisplayOptionList,
 		ResetTreeDisplayOptions,
 		RefreshTree,
 		CollapseAllTreeNodes,
-		LayoutSelector,
+		OpenWithList,
 		ShowNext,
 		ShowPrevious,
-		
 		ZoomIn,
 		ZoomOut,
 		ZoomReset
 	}
-	
-	internal class ZoomIn: CommandHandler
+
+	// MonoDevelop.Ide.Commands.ViewCommands.ViewList
+	public class ViewListHandler: CommandHandler 
 	{
-		protected override void Update (CommandInfo info)
+		protected override void Update (CommandArrayInfo info)
 		{
-			if (IdeApp.Workbench.ActiveDocument == null) {
-				info.Enabled = false;
-				return;
+			for(int i = 0; i < IdeApp.Workbench.Pads.Count; i++) {
+				Pad pad = IdeApp.Workbench.Pads [i];
+
+				CommandInfo ci = new CommandInfo (pad.Title);
+				ci.Icon = pad.Icon;
+				ci.Description = GettextCatalog.GetString ("Show " + pad.Title);
+				ci.Checked = pad.Visible;
+
+				ActionCommand cmd = IdeApp.CommandService.GetActionCommand ("Pad|" + pad.Id);
+				if(cmd != null) ci.AccelKey = cmd.AccelKey;
+
+				CommandArrayInfo list = info;
+				if(pad.Categories != null) {
+					for(int j = 0; j < pad.Categories.Length; j++) {
+						bool found = false;
+						for(int k = list.Count - 1; k >= 0; k--) {
+							if(list [k].Text == pad.Categories [j] && list[k] is CommandInfoSet) {
+								list = ((CommandInfoSet)list [k]).CommandInfos;
+								found = true;
+								break;
+							}
+						}
+						if(!found) {
+							CommandInfoSet set = new CommandInfoSet ();
+							set.Text = pad.Categories [j];
+							set.Description = GettextCatalog.GetString ("Show " + set.Text);
+							list.Add (set);
+							list = set.CommandInfos;
+						}
+					}
+				}
+				for(int j = list.Count - 1; j >= 0; j--) {
+					if(!(list [j] is CommandInfoSet)) {
+						list.Insert (j + 1, ci, pad);
+						pad = null;
+						break;
+					}
+				}
+				if(pad != null)
+					list.Insert (0, ci, pad);
 			}
-			IZoomable zoom = IdeApp.Workbench.ActiveDocument.GetContent <IZoomable> ();
-			info.Enabled = zoom != null && zoom.EnableZoomIn;
 		}
-		protected override void Run (object doc)
+
+		protected override void Run (object dataItem)
 		{
-			IZoomable zoom = IdeApp.Workbench.ActiveDocument.GetContent <IZoomable> ();
-			Debug.Assert (zoom != null);
-			zoom.ZoomIn ();
+			Pad pad = dataItem as Pad;
+			if (pad != null)
+				pad.Visible = !pad.Visible;	
 		}
 	}
-	
-	internal class ZoomOut: CommandHandler
+
+	// MonoDevelop.Ide.Commands.ViewCommands.LayoutList
+	public class LayoutListHandler : CommandHandler
 	{
-		protected override void Update (CommandInfo info)
+		protected override void Update (CommandArrayInfo info)
 		{
-			if (IdeApp.Workbench.ActiveDocument == null) {
-				info.Enabled = false;
-				return;
+			string[] layouts = IdeApp.Workbench.Layouts;
+			Array.Sort<string> (layouts, StringComparer.CurrentCultureIgnoreCase);
+			for(int i = 0; i < layouts.Length; i++) {
+				string name = layouts [i];
+				CommandInfo item = new CommandInfo (GettextCatalog.GetString (name));
+				item.Checked = IdeApp.Workbench.CurrentLayout == name;
+				item.Description = GettextCatalog.GetString ("Switch to layout '" + name + "'");
+				info.Add (item, name);
 			}
-			IZoomable zoom = IdeApp.Workbench.ActiveDocument.GetContent <IZoomable> ();
-			info.Enabled = zoom != null && zoom.EnableZoomOut;
 		}
-		protected override void Run (object doc)
+
+		protected override void Run (object dataItem)
 		{
-			IZoomable zoom = IdeApp.Workbench.ActiveDocument.GetContent <IZoomable> ();
-			Debug.Assert (zoom != null);
-			zoom.ZoomOut ();
+			if(dataItem is string)
+				IdeApp.Workbench.CurrentLayout = (string)dataItem;
 		}
 	}
-	
-	internal class ZoomReset: CommandHandler
+
+	// MonoDevelop.Ide.Commands.ViewCommands.NewLayout
+	public class NewLayoutHandler : CommandHandler
 	{
-		protected override void Update (CommandInfo info)
+		protected override void Run ()
 		{
-			if (IdeApp.Workbench.ActiveDocument == null) {
-				info.Enabled = false;
-				return;
+			string newLayoutName = null;
+			NewLayoutDialog dlg = new NewLayoutDialog ();
+			try {
+				if(((Gtk.ResponseType)dlg.Run ()) == Gtk.ResponseType.Ok)
+					newLayoutName = dlg.LayoutName;
 			}
-			IZoomable zoom = IdeApp.Workbench.ActiveDocument.GetContent <IZoomable> ();
-			info.Enabled = zoom != null && zoom.EnableZoomReset;
+			finally {
+				dlg.Destroy ();
+			}
+			if(newLayoutName != null) {
+				IdeApp.Workbench.CurrentLayout = newLayoutName;
+			}
 		}
-		protected override void Run (object doc)
+	}
+	// MonoDevelop.Ide.Commands.ViewCommands.DeleteCurrentLayout
+	public class DeleteCurrentLayoutHandler : CommandHandler
+	{
+		protected override void Update (CommandInfo info)
 		{
-			IZoomable zoom = IdeApp.Workbench.ActiveDocument.GetContent <IZoomable> ();
-			Debug.Assert (zoom != null);
-			zoom.ZoomReset ();
+			info.Enabled = !String.Equals ("Default", IdeApp.Workbench.CurrentLayout, StringComparison.OrdinalIgnoreCase);
 		}
+		protected override void Run ()
+		{
+			IdeApp.Workbench.DeleteLayout (IdeApp.Workbench.CurrentLayout);
+		}
 	}
-	
-	internal class FullScreenHandler: CommandHandler
+	// MonoDevelop.Ide.Commands.ViewCommands.FullScreen
+	public class FullScreenHandler : CommandHandler
 	{
 		protected override void Run ()
 		{
 			IdeApp.Workbench.FullScreen = !IdeApp.Workbench.FullScreen;
 		}
 	}
-	
-	internal class NewLayoutHandler: CommandHandler
+
+	// MonoDevelop.Ide.Commands.ViewCommands.ShowNext
+	public class ShowNextHandler : CommandHandler
 	{
 		protected override void Run ()
 		{
-			NewLayoutDialog dlg = new NewLayoutDialog ();
-			try {
-				Gtk.ResponseType response = (Gtk.ResponseType) dlg.Run ();
-				if (response == Gtk.ResponseType.Ok)
-					IdeApp.Workbench.CurrentLayout = dlg.LayoutName;
-			} finally {
-				dlg.Destroy ();
-			}
+			IdeApp.Workbench.ShowNext ();
 		}
+
+		protected override void Update (CommandInfo info)
+		{
+			Pad pad = IdeApp.Workbench.GetLocationListPad ();
+			if(pad == null)
+				info.Enabled = false;
+			else 
+				info.Text = GettextCatalog.GetString("Show Next ("+pad.Title+")");
+		}
 	}
-	
-	internal class DeleteCurrentLayoutHandler: CommandHandler
+
+	// MonoDevelop.Ide.Commands.ViewCommands.ShowPrevious
+	public class ShowPreviousHandler : CommandHandler
 	{
 		protected override void Run ()
 		{
-			if (MessageService.Confirm (GettextCatalog.GetString ("Are you sure you want to delete the active layout?"), AlertButton.Delete)) {
-				string clayout = IdeApp.Workbench.CurrentLayout;
-				IdeApp.Workbench.CurrentLayout = "Default";
-				IdeApp.Workbench.DeleteLayout (clayout);
-			}
+			IdeApp.Workbench.ShowPrevious ();
 		}
 		
 		protected override void Update (CommandInfo info)
 		{
-			info.Enabled = IdeApp.Workbench.CurrentLayout != "Default";
+
+			Pad pad = IdeApp.Workbench.GetLocationListPad ();
+			if(pad == null)
+				info.Enabled = false;
+			else
+				info.Text = GettextCatalog.GetString ("Show Previous (" + pad.Title + ")");
 		}
 	}
-	
-	internal class ViewListHandler: CommandHandler
+
+	// MonoDevelop.Ide.Commands.ViewCommands.ZoomIn
+	public class ZoomIn : CommandHandler
 	{
-		protected override void Update (CommandArrayInfo info)
+		protected override void Update (CommandInfo info)
 		{
-			foreach (Pad pad in IdeApp.Workbench.Pads) {
-				CommandArrayInfo ciset = FindArray (info, pad.Categories);
-				CommandInfo cmd = new CommandInfo (pad.Title);
-				cmd.Icon = pad.Icon;
-				cmd.UseMarkup = true;
-				cmd.Description = GettextCatalog.GetString ("Show {0}", pad.Title);
-				Command c = IdeApp.CommandService.GetActionCommand ("Pad|" + pad.InternalContent.PadId);
-				if (c != null)
-					cmd.AccelKey = c.AccelKey;
-				
-				// Insert before the submenus
-				int n = ciset.Count-1;
-				while (n >= 0 && ciset [n] is CommandInfoSet)
-					n--;
-				ciset.Insert (n+1, cmd, pad);
+			if(IdeApp.Workbench.ActiveDocument == null)
+				info.Enabled = false;
+			else {
+				IZoomable zoom = IdeApp.Workbench.ActiveDocument.GetContent<IZoomable> ();
+
+				info.Enabled = zoom != null && zoom.EnableZoomIn;
 			}
 		}
-		
-		public CommandArrayInfo FindArray (CommandArrayInfo iset, string[] categories)
+
+		protected override void Run ()
 		{
-			for (int n=0; n<categories.Length; n++) {
-				CommandArrayInfo foundSet = null;
-				for (int i=0; i<iset.Count; i++) {
-					CommandInfoSet s = iset [i] as CommandInfoSet;
-					if (s != null && s.Text == categories [n]) {
-						foundSet = s.CommandInfos;
-						break;
-					}
-				}
-				if (foundSet == null) {
-					CommandInfoSet s = new CommandInfoSet ();
-					s.Text = s.Description = categories [n];
-					iset.Add (s);
-					foundSet = s.CommandInfos;
-				}
-				iset = foundSet;
-			}
-			return iset;
+			IZoomable zoom = IdeApp.Workbench.ActiveDocument.GetContent<IZoomable> ();
+			zoom.ZoomIn ();
 		}
-		
-		protected override void Run (object ob)
-		{
-			if (ob == null)
-				return;
-			Pad pad = (Pad) ob;
-			pad.Visible = true;
-			pad.BringToFront ();
-		}
 	}
-	
-	internal class LayoutListHandler: CommandHandler
+	// MonoDevelop.Ide.Commands.ViewCommands.ZoomOut
+	public class ZoomOut : CommandHandler
 	{
-		protected override void Update (CommandArrayInfo info)
+		protected override void Update (CommandInfo info)
 		{
-			string[] layouts = IdeApp.Workbench.Layouts;
-			Array.Sort (layouts);
-			foreach (string layout in layouts) {
-				CommandInfo cmd = new CommandInfo (GettextCatalog.GetString (layout));
-				cmd.Checked = (layout == IdeApp.Workbench.CurrentLayout);
-				cmd.Description = GettextCatalog.GetString ("Switch to layout '{0}'", cmd.Text);
-				info.Add (cmd, layout);
+			if(IdeApp.Workbench.ActiveDocument == null)
+				info.Enabled = false;
+			else {
+				IZoomable zoom = IdeApp.Workbench.ActiveDocument.GetContent<IZoomable> ();
+
+				info.Enabled = zoom != null && zoom.EnableZoomOut;
 			}
 		}
-		
-		protected override void Run (object layout)
+
+		protected override void Run ()
 		{
-			IdeApp.Workbench.CurrentLayout = (string) layout;
+			IZoomable zoom = IdeApp.Workbench.ActiveDocument.GetContent<IZoomable> ();
+			zoom.ZoomOut ();
 		}
 	}
-	
-	internal class ShowNextHandler: CommandHandler
+	// MonoDevelop.Ide.Commands.ViewCommands.ZoomReset
+	public class ZoomReset : CommandHandler
 	{
-		protected override void Run ()
-		{
-			IdeApp.Workbench.ShowNext ();
-		}
-		
 		protected override void Update (CommandInfo info)
 		{
-			Pad pad = IdeApp.Workbench.GetLocationListPad ();
-			if (pad != null)
-				info.Text = GettextCatalog.GetString ("Show Next ({0})", pad.Title);
-			else
+			if(IdeApp.Workbench.ActiveDocument == null)
 				info.Enabled = false;
+			else {
+				IZoomable zoom = IdeApp.Workbench.ActiveDocument.GetContent<IZoomable> ();
+
+				info.Enabled = zoom != null && zoom.EnableZoomReset;
+			}
 		}
-	}
-	
-	internal class ShowPreviousHandler: CommandHandler
-	{
+
 		protected override void Run ()
 		{
-			IdeApp.Workbench.ShowPrevious ();
+			IZoomable zoom = IdeApp.Workbench.ActiveDocument.GetContent<IZoomable> ();
+			zoom.ZoomReset ();
 		}
-		
-		protected override void Update (CommandInfo info)
-		{
-			Pad pad = IdeApp.Workbench.GetLocationListPad ();
-			if (pad != null)
-				info.Text = GettextCatalog.GetString ("Show Previous ({0})", pad.Title);
-			else
-				info.Enabled = false;
-		}
 	}
 }