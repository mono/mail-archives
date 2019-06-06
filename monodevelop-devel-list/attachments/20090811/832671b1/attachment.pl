Index: main/src/core/MonoDevelop.Ide/ChangeLog
===================================================================
--- main/src/core/MonoDevelop.Ide/ChangeLog	(revision 139696)
+++ main/src/core/MonoDevelop.Ide/ChangeLog	(working copy)
@@ -1,3 +1,8 @@
+
+2009-08-11  Viktoria Dudka  <viktoriad@remobjects.com>
+
+	* MonoDevelop.Ide.Gui.Dialogs/CommonAboutDialog.cs: Rewritten GPL parts. 
+	  
 2009-08-10  Lluis Sanchez Gual  <lluis@novell.com>
 
 	* MonoDevelop.Ide.Gui/AbstractPadContent.cs:
Index: main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.Gui.Dialogs/CommonAboutDialog.cs
===================================================================
--- main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.Gui.Dialogs/CommonAboutDialog.cs	(revision 139696)
+++ main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.Gui.Dialogs/CommonAboutDialog.cs	(working copy)
@@ -1,22 +1,29 @@
-//  CommonAboutDialog.cs
+//  CommonAboutDialog.cs
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
 using System.Text;
@@ -184,20 +191,22 @@
 //		}
 		
 		private void DrawText ()
-		{
-			int w, h;
-			this.GdkWindow.GetSize (out w, out h);
-			int tw, maxHeight;
-			layout.GetPixelSize (out tw, out maxHeight);
-			
-			this.GdkWindow.DrawLayout (this.Style.WhiteGC, 0, textTop - scroll, layout);
-			this.GdkWindow.DrawPixbuf (backGc, monoPowered, 0, 0, (w/2) - (monoPowered.Width/2), textTop - scroll + maxHeight + monoLogoSpacing, -1, -1, RgbDither.Normal,  0,  0);
-
-			maxHeight += image.Height - 80;
-			if (scroll == maxHeight && scrollPause == 0)
-				scrollPause = 60;
-			if (scroll > maxHeight + monoLogoSpacing + monoPowered.Height)
-				scroll = scrollStart;
+		{
+            int width, height;
+            GdkWindow.GetSize (out width, out height);
+
+            int widthPixel, heightPixel;
+            layout.GetPixelSize (out widthPixel, out heightPixel);
+
+            GdkWindow.DrawLayout (Style.WhiteGC, 0, textTop - scroll, layout);
+            GdkWindow.DrawPixbuf (backGc, monoPowered, 0, 0, (width / 2) - (monoPowered.Width / 2), textTop - scroll + heightPixel + monoLogoSpacing, -1, -1, RgbDither.Normal, 0, 0);
+
+            heightPixel = heightPixel - 80 + image.Height;
+
+            if ((scroll == heightPixel) && (scrollPause == 0))
+                scrollPause = 60;
+            if (scroll > heightPixel + monoLogoSpacing + monoPowered.Height)
+                scroll = scrollStart;
 		}
 		
 		protected override bool OnExposeEvent (Gdk.EventExpose evnt)
@@ -249,38 +258,29 @@
 		Pixbuf imageSep;
 		
 		public CommonAboutDialog ()
-		{
-			HasSeparator = false;
-			this.VBox.BorderWidth = 0;
-			
-			AllowGrow = false;
-			this.Title = GettextCatalog.GetString ("About MonoDevelop");
-			this.TransientFor = IdeApp.Workbench.RootWindow;
-			aboutPictureScrollBox = new ScrollBox ();
-		
-			this.VBox.PackStart (aboutPictureScrollBox, false, false, 0);
-			
-			imageSep = new Gdk.Pixbuf (GetType().Assembly, "AboutImageSep.png");
-			Gtk.Image img = new Gtk.Image (imageSep);
-			this.VBox.PackStart (img, false, false, 0);
-		
-			Notebook nb = new Notebook ();
-			nb.BorderWidth = 6;
-//			nb.SetSizeRequest (440, 240);
-//			nb.ModifyBg (Gtk.StateType.Normal, new Gdk.Color (255, 255, 255));
-			VersionInformationTabPage vinfo = new VersionInformationTabPage ();
-			
-			nb.AppendPage (new AboutMonoDevelopTabPage (), new Label (GettextCatalog.GetString ("About MonoDevelop")));
-
-			nb.AppendPage (vinfo, new Label (GettextCatalog.GetString ("Version Info")));
-			this.VBox.PackStart (nb, true, true, 4);
-			this.AddButton (Gtk.Stock.Close, (int) ResponseType.Close);
-			
-//			ChangeColor (this);
-//			this.ModifyBg (Gtk.StateType.Normal, new Gdk.Color (49, 49, 74));
-//			aboutPictureScrollBox.ModifyBg (Gtk.StateType.Normal, new Gdk.Color (49, 49, 74));
-			
-			this.ShowAll ();
+		{
+            Title = GettextCatalog.GetString ("About MonoDevelop");
+            TransientFor = IdeApp.Workbench.RootWindow;
+            AllowGrow = false;
+            HasSeparator = false;
+
+            VBox.BorderWidth = 0;
+
+            aboutPictureScrollBox = new ScrollBox ();
+
+            VBox.PackStart (aboutPictureScrollBox, false, false, 0);
+            imageSep = new Pixbuf (typeof (CommonAboutDialog).Assembly, "AboutImageSep.png");
+            VBox.PackStart (new Gtk.Image (imageSep), false, false, 0);
+
+            Notebook notebook = new Notebook ();
+            notebook.BorderWidth = 6;
+            notebook.AppendPage (new AboutMonoDevelopTabPage (), new Label (Title));
+            notebook.AppendPage (new VersionInformationTabPage (), new Label (GettextCatalog.GetString ("VersionInfo")));
+            VBox.PackStart (notebook, true, true, 4);
+
+            AddButton (Gtk.Stock.Close, (int)ResponseType.Close);
+
+            ShowAll ();
 		}
 		
 		void ChangeColor (Gtk.Widget w)