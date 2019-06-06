Index: extras/MonoDevelop.AddinAuthoring/MonoDevelop.AddinAuthoring/AddinDescriptionView.cs
===================================================================
--- extras/MonoDevelop.AddinAuthoring/MonoDevelop.AddinAuthoring/AddinDescriptionView.cs	(revision 154234)
+++ extras/MonoDevelop.AddinAuthoring/MonoDevelop.AddinAuthoring/AddinDescriptionView.cs	(working copy)
@@ -2,9 +2,9 @@
 using System;
 using System.IO;
 using MonoDevelop.Core;
-using MonoDevelop.Core.Gui;
 using MonoDevelop.Ide.Gui.Content;
 using MonoDevelop.Ide.Gui;
+using MonoDevelop.Ide;
 using Mono.Addins;
 using Mono.Addins.Description;
 
Index: extras/MonoDevelop.AddinAuthoring/MonoDevelop.AddinAuthoring/AddinAuthoringService.cs
===================================================================
--- extras/MonoDevelop.AddinAuthoring/MonoDevelop.AddinAuthoring/AddinAuthoringService.cs	(revision 154234)
+++ extras/MonoDevelop.AddinAuthoring/MonoDevelop.AddinAuthoring/AddinAuthoringService.cs	(working copy)
@@ -34,6 +34,7 @@
 using Mono.Addins.Setup;
 using MonoDevelop.Core;
 using MonoDevelop.Core.ProgressMonitoring;
+using MonoDevelop.Ide;
 using MonoDevelop.Ide.Gui;
 using MonoDevelop.Ide.Gui.Content;
 using MonoDevelop.Projects;
Index: extras/MonoDevelop.AddinAuthoring/MonoDevelop.AddinAuthoring/ExtensionEditorWidget.cs
===================================================================
--- extras/MonoDevelop.AddinAuthoring/MonoDevelop.AddinAuthoring/ExtensionEditorWidget.cs	(revision 154234)
+++ extras/MonoDevelop.AddinAuthoring/MonoDevelop.AddinAuthoring/ExtensionEditorWidget.cs	(working copy)
@@ -6,8 +6,7 @@
 using Mono.Addins.Description;
 using Gtk;
 using MonoDevelop.Core;
-using MonoDevelop.Core.Gui;
-using MonoDevelop.Ide.Gui;
+using MonoDevelop.Ide;
 using MonoDevelop.Components;
 using MonoDevelop.Projects;
 
@@ -43,7 +42,7 @@
 		{
 			this.Build();
 			
-			pixAddin = ImageService.GetPixbuf (MonoDevelop.Core.Gui.Stock.Addin, IconSize.Menu);
+			pixAddin = ImageService.GetPixbuf (MonoDevelop.Ide.Gui.Stock.Addin, IconSize.Menu);
 			pixLocalAddin = ImageService.GetPixbuf ("md-addinauthoring-current-addin", IconSize.Menu);
 			pixExtensionPoint = ImageService.GetPixbuf ("md-extension-point", IconSize.Menu);
 			pixExtensionNode = ImageService.GetPixbuf ("md-extension-node", IconSize.Menu);
Index: extras/MonoDevelop.AddinAuthoring/MonoDevelop.AddinAuthoring/TypeCellEditor.cs
===================================================================
--- extras/MonoDevelop.AddinAuthoring/MonoDevelop.AddinAuthoring/TypeCellEditor.cs	(revision 154234)
+++ extras/MonoDevelop.AddinAuthoring/MonoDevelop.AddinAuthoring/TypeCellEditor.cs	(working copy)
@@ -31,7 +31,6 @@
 using Gdk;
 using System.Text;
 using System.ComponentModel;
-using MonoDevelop.Core.Gui;
 using MonoDevelop.Components.PropertyGrid;
 
 namespace MonoDevelop.AddinAuthoring
Index: extras/MonoDevelop.AddinAuthoring/MonoDevelop.AddinAuthoring/AddinOptionPanelWidget.cs
===================================================================
--- extras/MonoDevelop.AddinAuthoring/MonoDevelop.AddinAuthoring/AddinOptionPanelWidget.cs	(revision 154234)
+++ extras/MonoDevelop.AddinAuthoring/MonoDevelop.AddinAuthoring/AddinOptionPanelWidget.cs	(working copy)
@@ -2,9 +2,9 @@
 using System;
 using MonoDevelop.Core;
 using MonoDevelop.Projects;
-using MonoDevelop.Core.Gui;
-using MonoDevelop.Projects.Gui.Dialogs;
+using MonoDevelop.Ide;
 using MonoDevelop.Ide.Gui;
+using MonoDevelop.Ide.Gui.Dialogs;
 
 namespace MonoDevelop.AddinAuthoring
 {
Index: extras/MonoDevelop.AddinAuthoring/MonoDevelop.AddinAuthoring/ExtensionSelectorDialog.cs
===================================================================
--- extras/MonoDevelop.AddinAuthoring/MonoDevelop.AddinAuthoring/ExtensionSelectorDialog.cs	(revision 154234)
+++ extras/MonoDevelop.AddinAuthoring/MonoDevelop.AddinAuthoring/ExtensionSelectorDialog.cs	(working copy)
@@ -5,7 +5,7 @@
 using Mono.Addins;
 using Mono.Addins.Description;
 using MonoDevelop.Core;
-using MonoDevelop.Core.Gui;
+using MonoDevelop.Ide;
 using MonoDevelop.Ide.Gui;
 
 namespace MonoDevelop.AddinAuthoring
@@ -48,9 +48,9 @@
 			this.adesc = adesc;
 			this.isRoot = isRoot;
 			
-			pixCategory = ImageService.GetPixbuf (MonoDevelop.Core.Gui.Stock.ClosedFolder, IconSize.Menu);
-			pixNamespace = ImageService.GetPixbuf (MonoDevelop.Core.Gui.Stock.NameSpace, IconSize.Menu);
-			pixAddin = ImageService.GetPixbuf (MonoDevelop.Core.Gui.Stock.Addin, IconSize.Menu);
+			pixCategory = ImageService.GetPixbuf (MonoDevelop.Ide.Gui.Stock.ClosedFolder, IconSize.Menu);
+			pixNamespace = ImageService.GetPixbuf (MonoDevelop.Ide.Gui.Stock.NameSpace, IconSize.Menu);
+			pixAddin = ImageService.GetPixbuf (MonoDevelop.Ide.Gui.Stock.Addin, IconSize.Menu);
 			pixLocalAddin = ImageService.GetPixbuf ("md-addinauthoring-current-addin", IconSize.Menu);
 			
 			store = new TreeStore (typeof(string), typeof(object), typeof(ExtensionPoint), typeof(bool), typeof(bool), typeof(Gdk.Pixbuf), typeof(bool), typeof(bool));
Index: extras/MonoDevelop.AddinAuthoring/MonoDevelop.AddinAuthoring/SelectRepositoryDialog.cs
===================================================================
--- extras/MonoDevelop.AddinAuthoring/MonoDevelop.AddinAuthoring/SelectRepositoryDialog.cs	(revision 154234)
+++ extras/MonoDevelop.AddinAuthoring/MonoDevelop.AddinAuthoring/SelectRepositoryDialog.cs	(working copy)
@@ -3,8 +3,6 @@
 using Gtk;
 using Mono.Addins;
 using MonoDevelop.Components;
-using MonoDevelop.Core.Gui;
-using MonoDevelop.Ide.Gui;
 
 namespace MonoDevelop.AddinAuthoring
 {
Index: extras/MonoDevelop.AddinAuthoring/MonoDevelop.AddinAuthoring/AddinDescriptionDisplayBinding.cs
===================================================================
--- extras/MonoDevelop.AddinAuthoring/MonoDevelop.AddinAuthoring/AddinDescriptionDisplayBinding.cs	(revision 154234)
+++ extras/MonoDevelop.AddinAuthoring/MonoDevelop.AddinAuthoring/AddinDescriptionDisplayBinding.cs	(working copy)
@@ -26,6 +26,7 @@
 //
 
 using System;
+using MonoDevelop.Ide;
 using MonoDevelop.Ide.Gui;
 using MonoDevelop.Ide.Codons;
 using MonoDevelop.Projects;
Index: extras/MonoDevelop.AddinAuthoring/MonoDevelop.AddinAuthoring/SolutionAddinData.cs
===================================================================
--- extras/MonoDevelop.AddinAuthoring/MonoDevelop.AddinAuthoring/SolutionAddinData.cs	(revision 154234)
+++ extras/MonoDevelop.AddinAuthoring/MonoDevelop.AddinAuthoring/SolutionAddinData.cs	(working copy)
@@ -31,6 +31,7 @@
 using MonoDevelop.Projects;
 using Mono.Addins;
 using Mono.Addins.Setup;
+using MonoDevelop.Ide;
 using MonoDevelop.Ide.Gui;
 
 namespace MonoDevelop.AddinAuthoring
Index: extras/MonoDevelop.AddinAuthoring/MonoDevelop.AddinAuthoring.CodeCompletion/CodeCompletionExtension.cs
===================================================================
--- extras/MonoDevelop.AddinAuthoring/MonoDevelop.AddinAuthoring.CodeCompletion/CodeCompletionExtension.cs	(revision 154234)
+++ extras/MonoDevelop.AddinAuthoring/MonoDevelop.AddinAuthoring.CodeCompletion/CodeCompletionExtension.cs	(working copy)
@@ -34,9 +34,9 @@
 using MonoDevelop.Core;
 using MonoDevelop.Core.Collections;
 using MonoDevelop.Projects;
-using MonoDevelop.Projects.Gui.Completion;
 using MonoDevelop.Ide.Gui.Content;
 using MonoDevelop.Ide.Gui;
+using MonoDevelop.Ide.CodeCompletion;
 using MonoDevelop.XmlEditor;
 using MonoDevelop.Xml.StateEngine;
 using MonoDevelop.XmlEditor.Gui;
Index: extras/MonoDevelop.AddinAuthoring/MonoDevelop.AddinAuthoring.NodeBuilders/AddinReferenceNodeBuilder.cs
===================================================================
--- extras/MonoDevelop.AddinAuthoring/MonoDevelop.AddinAuthoring.NodeBuilders/AddinReferenceNodeBuilder.cs	(revision 154234)
+++ extras/MonoDevelop.AddinAuthoring/MonoDevelop.AddinAuthoring.NodeBuilders/AddinReferenceNodeBuilder.cs	(working copy)
@@ -28,7 +28,7 @@
 using System;
 using MonoDevelop.Projects;
 using MonoDevelop.Core;
-using MonoDevelop.Core.Gui;
+using MonoDevelop.Ide;
 using MonoDevelop.Ide.Gui;
 using MonoDevelop.Ide.Gui.Pads;
 using MonoDevelop.Ide.Gui.Pads.ProjectPad;
Index: extras/MonoDevelop.AddinAuthoring/MonoDevelop.AddinAuthoring.NodeBuilders/ExtensionsNodeBuilder.cs
===================================================================
--- extras/MonoDevelop.AddinAuthoring/MonoDevelop.AddinAuthoring.NodeBuilders/ExtensionsNodeBuilder.cs	(revision 154234)
+++ extras/MonoDevelop.AddinAuthoring/MonoDevelop.AddinAuthoring.NodeBuilders/ExtensionsNodeBuilder.cs	(working copy)
@@ -28,6 +28,7 @@
 using System;
 using MonoDevelop.Projects;
 using MonoDevelop.Core;
+using MonoDevelop.Ide;
 using MonoDevelop.Ide.Gui;
 using MonoDevelop.Ide.Gui.Pads;
 using MonoDevelop.Ide.Gui.Pads.ProjectPad;
Index: extras/MonoDevelop.AddinAuthoring/MonoDevelop.AddinAuthoring.NodeBuilders/ProjectFolderNodeBuilderExtension.cs
===================================================================
--- extras/MonoDevelop.AddinAuthoring/MonoDevelop.AddinAuthoring.NodeBuilders/ProjectFolderNodeBuilderExtension.cs	(revision 154234)
+++ extras/MonoDevelop.AddinAuthoring/MonoDevelop.AddinAuthoring.NodeBuilders/ProjectFolderNodeBuilderExtension.cs	(working copy)
@@ -30,6 +30,7 @@
 using System;
 using MonoDevelop.Projects;
 using MonoDevelop.Core;
+using MonoDevelop.Ide;
 using MonoDevelop.Ide.Gui;
 using MonoDevelop.Ide.Gui.Pads;
 using MonoDevelop.Ide.Gui.Pads.ProjectPad;
Index: extras/MonoDevelop.AddinAuthoring/MonoDevelop.AddinAuthoring.NodeBuilders/ExtensionPointsNodeBuilder.cs
===================================================================
--- extras/MonoDevelop.AddinAuthoring/MonoDevelop.AddinAuthoring.NodeBuilders/ExtensionPointsNodeBuilder.cs	(revision 154234)
+++ extras/MonoDevelop.AddinAuthoring/MonoDevelop.AddinAuthoring.NodeBuilders/ExtensionPointsNodeBuilder.cs	(working copy)
@@ -28,6 +28,7 @@
 using System;
 using MonoDevelop.Projects;
 using MonoDevelop.Core;
+using MonoDevelop.Ide;
 using MonoDevelop.Ide.Gui;
 using MonoDevelop.Ide.Gui.Pads;
 using MonoDevelop.Ide.Gui.Pads.ProjectPad;
Index: extras/MonoDevelop.AddinAuthoring/MonoDevelop.AddinAuthoring.NodeBuilders/AddinFolderNodeBuilder.cs
===================================================================
--- extras/MonoDevelop.AddinAuthoring/MonoDevelop.AddinAuthoring.NodeBuilders/AddinFolderNodeBuilder.cs	(revision 154234)
+++ extras/MonoDevelop.AddinAuthoring/MonoDevelop.AddinAuthoring.NodeBuilders/AddinFolderNodeBuilder.cs	(working copy)
@@ -33,10 +33,10 @@
 using MonoDevelop.Core;
 using MonoDevelop.Ide.Gui.Pads;
 using MonoDevelop.Components.Commands;
+using MonoDevelop.Ide;
 using MonoDevelop.Ide.Gui;
 using MonoDevelop.Ide.Commands;
 using MonoDevelop.Ide.Gui.Pads.ProjectPad;
-using MonoDevelop.Core.Gui;
 using Mono.Addins;
 using MonoDevelop.Ide.Gui.Components;
 
Index: extras/MonoDevelop.Database/MonoDevelop.Database.Sql.Sqlite/MonoDevelop.Database.Sql.Sqlite.csproj
===================================================================
--- extras/MonoDevelop.Database/MonoDevelop.Database.Sql.Sqlite/MonoDevelop.Database.Sql.Sqlite.csproj	(revision 154234)
+++ extras/MonoDevelop.Database/MonoDevelop.Database.Sql.Sqlite/MonoDevelop.Database.Sql.Sqlite.csproj	(working copy)
@@ -69,9 +69,6 @@
     <Reference Include="Mono.TextEditor, Version=1.0.0.0, Culture=neutral">
       <Package>monodevelop</Package>
     </Reference>
-    <Reference Include="Mono.Data">
-      <SpecificVersion>False</SpecificVersion>
-    </Reference>
     <Reference Include="Mono.Data.Sqlite">
       <SpecificVersion>False</SpecificVersion>
     </Reference>
Index: extras/MonoDevelop.Database/MonoDevelop.Database.Sql.Sqlite/Makefile.am
===================================================================
--- extras/MonoDevelop.Database/MonoDevelop.Database.Sql.Sqlite/Makefile.am	(revision 154234)
+++ extras/MonoDevelop.Database/MonoDevelop.Database.Sql.Sqlite/Makefile.am	(working copy)
@@ -7,7 +7,6 @@
 	-r:$(top_builddir)/build/MonoDevelop.Database.Components.dll \
 	-r:$(top_builddir)/build/MonoDevelop.Database.Designer.dll \
 	-r:$(top_builddir)/build/MonoDevelop.Database.Sql.dll \
-	-r:Mono.Data \
 	-r:Mono.Data.Sqlite \
 	-r:System \
 	-r:System.Data


