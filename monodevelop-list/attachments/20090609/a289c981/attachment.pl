Index: main/src/core/MonoDevelop.Core/ChangeLog
===================================================================
--- main/src/core/MonoDevelop.Core/ChangeLog	(revision 135730)
+++ main/src/core/MonoDevelop.Core/ChangeLog	(working copy)
@@ -1,3 +1,9 @@
+2009-06-08  Carlo Kok  <ck@remobjects.com>
+	* MonoDevelop.Core.Properties/IXmlConvertable.cs:
+	* MonoDevelop.Core.Properties/PropertyFileLoadException.cs:
+	* MonoDevelop.Core.Properties/UnknownPropertyNodeException.cs:
+	  removed unused files.
+
 2009-05-29  Lluis Sanchez Gual  <lluis@novell.com>
 
 	* MonoDevelop.Core.Execution\ProcessService.cs: Fix crash on
Index: main/src/core/MonoDevelop.Core/MonoDevelop.Core.Properties/IXmlConvertable.cs
===================================================================
--- main/src/core/MonoDevelop.Core/MonoDevelop.Core.Properties/IXmlConvertable.cs	(revision 135730)
+++ main/src/core/MonoDevelop.Core/MonoDevelop.Core.Properties/IXmlConvertable.cs	(working copy)
@@ -1,51 +0,0 @@
-//  IXmlConvertable.cs
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
-using System.Xml;
-
-namespace MonoDevelop.Core.Properties
-{
-	/*
-	/// <summary>
-	/// If you want define own, complex options you can implement this interface
-	/// and save it in the main Option class, your class will be saved as xml in
-	/// the global properties.
-	/// Use your class like any other property. (the conversion will be transparent)
-	/// </summary>
-	public interface IProperties
-	{
-		/// <summary>
-		/// Converts a <code>XmlElement</code> to an <code>IProperties</code>
-		/// </summary>
-		/// <returns>
-		/// A new <code>IProperties</code> object 
-		/// </returns>
-		object FromXmlElement(XmlElement element);
-		
-		/// <summary>
-		/// Converts the <code>IProperties</code> object to a <code>XmlElement</code>
-		/// </summary>
-		/// <returns>
-		/// A new <code>XmlElement</code> object which represents the state
-		/// of the <code>IProperties</code> object.
-		/// </returns>
-		XmlElement ToXmlElement(XmlDocument doc);
-	}*/
-}
Index: main/src/core/MonoDevelop.Core/MonoDevelop.Core.Properties/PropertyFileLoadException.cs
===================================================================
--- main/src/core/MonoDevelop.Core/MonoDevelop.Core.Properties/PropertyFileLoadException.cs	(revision 135730)
+++ main/src/core/MonoDevelop.Core/MonoDevelop.Core.Properties/PropertyFileLoadException.cs	(working copy)
@@ -1,34 +0,0 @@
-//  PropertyFileLoadException.cs
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
-namespace MonoDevelop.Core.Properties
-{
-	/// <summary>
-	/// Is thrown when no property file could be loaded.
-	/// </summary>
-	public class PropertyFileLoadException : Exception
-	{
-		public PropertyFileLoadException() : base("couldn't load global property file")
-		{
-		}
-	}
-}
Index: main/src/core/MonoDevelop.Core/MonoDevelop.Core.Properties/UnknownPropertyNodeException.cs
===================================================================
--- main/src/core/MonoDevelop.Core/MonoDevelop.Core.Properties/UnknownPropertyNodeException.cs	(revision 135730)
+++ main/src/core/MonoDevelop.Core/MonoDevelop.Core.Properties/UnknownPropertyNodeException.cs	(working copy)
@@ -1,34 +0,0 @@
-//  UnknownPropertyNodeException.cs
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
-namespace MonoDevelop.Core.Properties
-{
-	/// <summary>
-	/// Is thrown when an unknown XmlNode in a property file is encountered.
-	/// </summary>
-	public class UnknownPropertyNodeException : Exception
-	{
-		public UnknownPropertyNodeException(string nodeName) : base("unknown XmlNode : " + nodeName)
-		{
-		}
-	}
-}
Index: main/src/core/MonoDevelop.Ide/ChangeLog
===================================================================
--- main/src/core/MonoDevelop.Ide/ChangeLog	(revision 135730)
+++ main/src/core/MonoDevelop.Ide/ChangeLog	(working copy)
@@ -1,3 +1,9 @@
+2009-06-09  Carlo Kok  <ck@remobjects.com>
+
+	* MonoDevelop.Ide.Gui/ViewContentEventHandler.cs: 
+	  Deleted, not used anymore.
+	* MonoDevelop.Ide.csproj: Removed unused file from project
+
 2009-06-08  Mike Krüger  <mkrueger@novell.com>
 
 	* MonoDevelop.Ide.Commands/RefactoryCommands.cs: Fixed "Bug
Index: main/src/core/MonoDevelop.Ide/Makefile.am
===================================================================
--- main/src/core/MonoDevelop.Ide/Makefile.am	(revision 135730)
+++ main/src/core/MonoDevelop.Ide/Makefile.am	(working copy)
@@ -296,7 +296,6 @@
 	MonoDevelop.Ide.Gui/TipOfTheDayStartupHandler.cs \
 	MonoDevelop.Ide.Gui/ToolbarComboBox.cs \
 	MonoDevelop.Ide.Gui/ViewCommandHandlers.cs \
-	MonoDevelop.Ide.Gui/ViewContentEventHandler.cs \
 	MonoDevelop.Ide.Gui/Workbench.cs \
 	MonoDevelop.Ide.Gui/WorkbenchMemento.cs \
 	MonoDevelop.Ide.StandardHeader/StandardHeaderPolicyPanel.cs \
Index: main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.csproj
===================================================================
--- main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.csproj	(revision 135730)
+++ main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.csproj	(working copy)
@@ -379,7 +379,6 @@
     <Compile Include="MonoDevelop.Ide.Gui.Dialogs\GoToDialog.cs" />
     <Compile Include="MonoDevelop.Ide.Gui.Content\TextEditorExtension.cs" />
     <Compile Include="MonoDevelop.Ide.Gui\TextEditor.cs" />
-    <Compile Include="MonoDevelop.Ide.Gui\ViewContentEventHandler.cs" />
     <Compile Include="MonoDevelop.Ide.Commands\NavigationCommands.cs" />
     <Compile Include="MonoDevelop.Ide.Gui.Dialogs\ExportProjectDialog.cs" />
     <Compile Include="MonoDevelop.Ide.Templates\ISolutionItemFeature.cs" />
Index: main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.Gui/ViewContentEventHandler.cs
===================================================================
--- main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.Gui/ViewContentEventHandler.cs	(revision 135730)
+++ main/src/core/MonoDevelop.Ide/MonoDevelop.Ide.Gui/ViewContentEventHandler.cs	(working copy)
@@ -1,27 +0,0 @@
-// <file>
-//     <copyright see="prj:///doc/copyright.txt"/>
-//     <license see="prj:///doc/license.txt"/>
-//     <owner name="Mike Krüger" email="mike@icsharpcode.net"/>
-//     <version>$Revision: 1965 $</version>
-// </file>
-
-using System;
-
-namespace MonoDevelop.Ide.Gui
-{
-	public delegate void ViewContentEventHandler (object sender, ViewContentEventArgs e);
-	
-	public class ViewContentEventArgs : System.EventArgs {
-		IViewContent content;
-		
-		public IViewContent Content {
-			get { return content; }
-			set { content = value; }
-		}
-		
-		public ViewContentEventArgs (IViewContent content)
-		{
-			this.content = content;
-		}
-	}
-}
Index: main/src/core/MonoDevelop.Projects/ChangeLog
===================================================================
--- main/src/core/MonoDevelop.Projects/ChangeLog	(revision 135730)
+++ main/src/core/MonoDevelop.Projects/ChangeLog	(working copy)
@@ -1,3 +1,20 @@
+2009-06-08  Carlo Kok  <ck@remobjects.com>
+
+	* MonoDevelop.Projects.Ambience:
+	* MonoDevelop.Projects.Ambience/Ambience.cs:
+	* MonoDevelop.Projects.Ambience/AmbienceService.cs:
+	* MonoDevelop.Projects.Ambience/ConversionFlags.cs:
+	* MonoDevelop.Projects.Ambience/NetAmbience.cs:
+	* MonoDevelop.Projects/ProjectRenameEventArgs.cs:
+	* MonoDevelop.Projects/CyclicBuildOrderException.cs:
+	* MonoDevelop.Projects/ConvertXml.cs:
+	* MonoDevelop.Projects/CombineEventArgs.cs: 
+	* MonoDevelop.Projects/IProjectService.cs:
+	* MonoDevelop.Projects/ProjectRenameEventArgs.cs: 
+	  Removed unused files
+	* MonoDevelop.Projects.csproj: Updated to remove unused files.
+
+
 2009-06-05  Mike Krüger  <mkrueger@novell.com>
 
 	* MonoDevelop.Projects.addin.xml:
Index: main/src/core/MonoDevelop.Projects/Makefile.am
===================================================================
--- main/src/core/MonoDevelop.Projects/Makefile.am	(revision 135730)
+++ main/src/core/MonoDevelop.Projects/Makefile.am	(working copy)
@@ -204,15 +204,12 @@
 	MonoDevelop.Projects/BuildResult.cs \
 	MonoDevelop.Projects/BuildTool.cs \
 	MonoDevelop.Projects/CombineEntryRenamedEventArgs.cs \
-	MonoDevelop.Projects/CombineEventArgs.cs \
 	MonoDevelop.Projects/ConfigurationEventHandler.cs \
 	MonoDevelop.Projects/ConfigurationParameters.cs \
-	MonoDevelop.Projects/ConvertXml.cs \
 	MonoDevelop.Projects/CustomCommand.cs \
 	MonoDevelop.Projects/CustomCommandCollection.cs \
 	MonoDevelop.Projects/CustomCommandExtension.cs \
 	MonoDevelop.Projects/CustomCommandType.cs \
-	MonoDevelop.Projects/CyclicBuildOrderException.cs \
 	MonoDevelop.Projects/DotNetProject.cs \
 	MonoDevelop.Projects/DotNetProjectBinding.cs \
 	MonoDevelop.Projects/DotNetProjectConfiguration.cs \
@@ -249,7 +246,6 @@
 	MonoDevelop.Projects/ProjectReference.cs \
 	MonoDevelop.Projects/ProjectReferenceCollection.cs \
 	MonoDevelop.Projects/ProjectReferenceEventArgs.cs \
-	MonoDevelop.Projects/ProjectRenameEventArgs.cs \
 	MonoDevelop.Projects/ProjectService.cs \
 	MonoDevelop.Projects/ProjectServiceExtension.cs \
 	MonoDevelop.Projects/ProjectsServices.cs \
Index: main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Ambience/Ambience.cs
===================================================================
--- main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Ambience/Ambience.cs	(revision 135730)
+++ main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Ambience/Ambience.cs	(working copy)
@@ -1,275 +0,0 @@
-// Ambience.cs
-//
-// Author:
-//   Lluis Sanchez Gual <lluis@novell.com>
-//
-// Copyright (c) 2006 Novell, Inc (http://www.novell.com)
-//
-// Permission is hereby granted, free of charge, to any person obtaining a copy
-// of this software and associated documentation files (the "Software"), to deal
-// in the Software without restriction, including without limitation the rights
-// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-// copies of the Software, and to permit persons to whom the Software is
-// furnished to do so, subject to the following conditions:
-//
-// The above copyright notice and this permission notice shall be included in
-// all copies or substantial portions of the Software.
-//
-// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
-// THE SOFTWARE.
-//
-//
-
-using System;
-using System.Collections;
-using MonoDevelop.Core;
-using MonoDevelop.Projects.Parser;
-
-namespace MonoDevelop.Projects.Ambience
-{
-	public abstract class Ambience
-	{		
-		public static bool ShowAccessibility(ConversionFlags conversionFlags)
-		{
-			return (conversionFlags & ConversionFlags.ShowAccessibility) == ConversionFlags.ShowAccessibility;
-		}
-		
-		public static bool ShowReturnType (ConversionFlags conversionFlags)
-		{
-			return (conversionFlags & ConversionFlags.ShowReturnType) == ConversionFlags.ShowReturnType;
-		}
-		public static bool ShowParameters (ConversionFlags conversionFlags)
-		{
-			return (conversionFlags & ConversionFlags.ShowParameters) == ConversionFlags.ShowParameters;
-		}
-		
-
-		public static bool ShowParameterNames(ConversionFlags conversionFlags)
-		{
-			return (conversionFlags & ConversionFlags.ShowParameterNames) == ConversionFlags.ShowParameterNames;
-		}
-		
-		public static bool UseFullyQualifiedNames(ConversionFlags conversionFlags)
-		{
-			return (conversionFlags & ConversionFlags.UseFullyQualifiedNames) == ConversionFlags.UseFullyQualifiedNames;
-		}
-		
-		public static bool UseIntrinsicTypeNames(ConversionFlags conversionFlags)
-		{
-			return (conversionFlags & ConversionFlags.UseIntrinsicTypeNames) == ConversionFlags.UseIntrinsicTypeNames;
-		}
-		
-		public static bool ShowMemberModifiers(ConversionFlags conversionFlags)
-		{
-			return (conversionFlags & ConversionFlags.ShowMemberModifiers) == ConversionFlags.ShowMemberModifiers;
-		}
-		
-		public static bool ShowInheritanceList(ConversionFlags conversionFlags)
-		{
-			return (conversionFlags & ConversionFlags.ShowInheritanceList) == ConversionFlags.ShowInheritanceList;
-		}
-		
-		public static bool IncludeHTMLMarkup(ConversionFlags conversionFlags)
-		{
-			return (conversionFlags & ConversionFlags.IncludeHTMLMarkup) == ConversionFlags.IncludeHTMLMarkup;
-		}
-		
-		public static bool IncludePangoMarkup(ConversionFlags conversionFlags)
-		{
-			return (conversionFlags & ConversionFlags.IncludePangoMarkup) == ConversionFlags.IncludePangoMarkup;
-		}
-		
-//		public static bool UseLinkArrayList(ConversionFlags conversionFlags)
-//		{
-//			return (conversionFlags & ConversionFlags.UseLinkArrayList) == ConversionFlags.UseLinkArrayList;
-//		}
-		
-		public static bool UseFullyQualifiedMemberNames(ConversionFlags conversionFlags)
-		{
-			return UseFullyQualifiedNames(conversionFlags) && !((conversionFlags & ConversionFlags.QualifiedNamesOnlyForReturnTypes) == ConversionFlags.QualifiedNamesOnlyForReturnTypes);
-		}
-		
-		public static bool IncludeBodies(ConversionFlags conversionFlags)
-		{
-			return (conversionFlags & ConversionFlags.IncludeBodies) == ConversionFlags.IncludeBodies;
-		}
-		
-		public static bool ShowClassModifiers(ConversionFlags conversionFlags)
-		{
-			return (conversionFlags & ConversionFlags.ShowClassModifiers) == ConversionFlags.ShowClassModifiers;
-		}
-		
-		public static bool ShowGenericParameters(ConversionFlags conversionFlags)
-		{
-			return (conversionFlags & ConversionFlags.ShowGenericParameters) == ConversionFlags.ShowGenericParameters;
-		}
-		
-		public string Convert(ILanguageItem item)
-		{
-			return Convert (item, ConversionFlags.StandardConversionFlags);
-		}
-		
-		public string Convert(ILanguageItem item, ConversionFlags conversionFlags)
-		{
-			if (item is IClass)
-				return Convert (item as IClass, conversionFlags);
-			else if (item is IEvent)
-				return Convert (item as IEvent, conversionFlags);
-			else if (item is IField)
-				return Convert (item as IField, conversionFlags);
-			else if (item is IIndexer)
-				return Convert (item as IIndexer, conversionFlags);
-			else if (item is IMethod)
-				return Convert (item as IMethod, conversionFlags);
-			else if (item is IProperty)
-				return Convert (item as IProperty, conversionFlags);
-			else if (item is LocalVariable)
-				return Convert (item as LocalVariable, conversionFlags);
-			else
-				return item.Name;
-		}
-		
-		public string Convert (IClass c)
-		{
-			return Convert(c, ConversionFlags.StandardConversionFlags, null);
-		}
-		
-		public string Convert (IClass c, ConversionFlags flags)
-		{
-			return Convert(c, flags, null);
-		}
-		
-		public string ConvertEnd (IClass c)
-		{
-			return ConvertEnd (c, ConversionFlags.StandardConversionFlags);
-		}
-
-		public string Convert (IEvent e)
-		{
-			return Convert(e, ConversionFlags.StandardConversionFlags, null);
-		}
-		
-		public string Convert (IEvent e, ConversionFlags flags)
-		{
-			return Convert(e, flags, null);
-		}
-		
-		public string Convert (IField c)
-		{
-			return Convert(c, ConversionFlags.StandardConversionFlags, null);
-		}
-		
-		public string Convert (IField c, ConversionFlags flags)
-		{
-			return Convert(c, flags, null);
-		}
-		
-		public string Convert (IIndexer indexer)
-		{
-			return Convert(indexer, ConversionFlags.StandardConversionFlags, null);
-		}
-		
-		public string Convert (IIndexer indexer, ConversionFlags flags)
-		{
-			return Convert(indexer, flags, null);
-		}
-		
-		public string Convert (IMethod m)
-		{
-			return Convert (m, ConversionFlags.StandardConversionFlags, null);
-		}
-		
-		public string Convert (IMethod m, ConversionFlags flags)
-		{
-			return Convert (m, flags, null);
-		}
-		
-		public string ConvertEnd (IMethod m)
-		{
-			return ConvertEnd(m, ConversionFlags.StandardConversionFlags);
-		}
-		
-		public string Convert (IProperty property)
-		{
-			return Convert (property, ConversionFlags.StandardConversionFlags, null);
-		}
-		
-		public string Convert (IProperty property, ConversionFlags flags)
-		{
-			return Convert (property, flags, null);
-		}
-		
-		public string Convert (IParameter param)
-		{
-			return Convert (param, ConversionFlags.StandardConversionFlags, null);
-		}
-		
-		public string Convert (IParameter param, ConversionFlags flags)
-		{
-			return Convert (param, flags, null);
-		}
-		
-		public string Convert (IReturnType returnType)
-		{
-			return Convert (returnType, ConversionFlags.StandardConversionFlags, null);
-		}
-		
-		public string Convert (IReturnType returnType, ConversionFlags flags)
-		{
-			return Convert (returnType, flags, null);
-		}
-		
-		public string Convert (ModifierEnum modifier)
-		{
-			return Convert(modifier, ConversionFlags.StandardConversionFlags);
-		}
-
-		public string Convert(LocalVariable localVariable)
-		{
-			return Convert (localVariable, ConversionFlags.StandardConversionFlags, null);
-		}
-
-		public string Convert(LocalVariable localVariable, ConversionFlags flags)
-		{
-			return Convert (localVariable, flags, null);
-		}
-
-		protected string GetResolvedTypeName (string dotNetTypeName, ConversionFlags flags, ITypeNameResolver resolver)
-		{
-			if (UseIntrinsicTypeNames (flags)) {
-				string tn = GetIntrinsicTypeName (dotNetTypeName);
-				if (tn != null && tn != dotNetTypeName)
-					return tn;
-			}
-			if (resolver != null) {
-				string tn = resolver.ResolveName (dotNetTypeName);
-				if (tn != null)
-					return tn;
-			}
-			return dotNetTypeName;
-		}
-		
-		public abstract string Convert (IClass c, ConversionFlags flags, ITypeNameResolver resolver);
-		public abstract string ConvertEnd (IClass c, ConversionFlags flags);
-		public abstract string Convert (IEvent e, ConversionFlags flags, ITypeNameResolver resolver);
-		public abstract string Convert (IField c, ConversionFlags flags, ITypeNameResolver resolver);
-		public abstract string Convert (IIndexer indexer, ConversionFlags flags, ITypeNameResolver resolver);
-		public abstract string Convert (IMethod m, ConversionFlags flags, ITypeNameResolver resolver);
-		public abstract string Convert (IProperty property, ConversionFlags flags, ITypeNameResolver resolver);
-		public abstract string ConvertEnd (IMethod m, ConversionFlags flags);
-		public abstract string Convert (IParameter param, ConversionFlags flags, ITypeNameResolver resolver);
-		public abstract string Convert (IReturnType returnType, ConversionFlags flags, ITypeNameResolver resolver);
-		public abstract string Convert (ModifierEnum modifier, ConversionFlags flags);
-		public abstract string Convert (LocalVariable localVariable, ConversionFlags flags, ITypeNameResolver resolver);
-		
-		public abstract string WrapAttribute (string attribute);
-		public abstract string WrapComment (string comment);
-		public abstract string GetIntrinsicTypeName (string dotNetTypeName);
-		
-	}
-}
Index: main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Ambience/AmbienceService.cs
===================================================================
--- main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Ambience/AmbienceService.cs	(revision 135730)
+++ main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Ambience/AmbienceService.cs	(working copy)
@@ -1,138 +0,0 @@
-//  AmbienceService.cs
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
-using Mono.Addins;
-using MonoDevelop.Core;
-
-namespace MonoDevelop.Projects.Ambience
-{
-	public class AmbienceService : AbstractService
-	{
-		static readonly string ambienceProperty       = "SharpDevelop.UI.CurrentAmbience";
-		static readonly string codeGenerationProperty = "SharpDevelop.UI.CodeGenerationOptions";
-		
-		Hashtable ambiences = new Hashtable ();
-
-		public Properties CodeGenerationProperties {
-			get {
-				return PropertyService.Get (codeGenerationProperty, new Properties());
-			}
-		}
-		
-		public bool GenerateDocumentComments {
-			get {
-				return CodeGenerationProperties.Get("GenerateDocumentComments", true);
-			}
-		}
-		
-		public bool GenerateAdditionalComments {
-			get {
-				return CodeGenerationProperties.Get("GenerateAdditionalComments", true);
-			}
-		}
-		
-		public bool UseFullyQualifiedNames {
-			get {
-				return CodeGenerationProperties.Get("UseFullyQualifiedNames", true);
-			}
-		}
-		
-		public Ambience GenericAmbience {
-			get {
-				return AmbienceFromName(".NET");
-			}
-		}
-		
-		public string[] AvailableAmbiences {
-			get {
-				ExtensionNodeList ambiencesNodes = AddinManager.GetExtensionNodes ("/MonoDevelop/ProjectModel/Ambiences");
-				string[] availableAmbiences = new string [ambiencesNodes.Count];
-				int index = 0;
-				foreach (ExtensionNode node in ambiencesNodes)
-					availableAmbiences [index++] = node.Id;
-				
-				return availableAmbiences;
-			}
-		}
-		
-		public Ambience AmbienceFromName (string name)
-		{
-			Ambience amb = (Ambience) ambiences [name];
-			
-			if (amb == null) {
-				TypeExtensionNode node = (TypeExtensionNode) AddinManager.GetExtensionNode ("/MonoDevelop/ProjectModel/Ambiences/" + name);
-				if (node != null) {
-					amb = (Ambience) node.CreateInstance ();
-				} else {
-					amb = GenericAmbience;
-				}
-				ambiences [name] = amb;
-			}
-			return amb;
-		}
-		
-		public Ambience GetAmbienceForFile (string fileName)
-		{
-			ILanguageBinding lang = Services.Languages.GetBindingPerFileName (fileName);
-			if (lang != null) {
-				Ambience a = AmbienceFromName (lang.Language);
-				if (a != null)
-					return a;
-			}
-			return GenericAmbience;
-		}
-		
-		public Ambience CurrentAmbience {
-			get {
-				string language = PropertyService.Get (ambienceProperty, ".NET");
-				return AmbienceFromName(language);
-			}
-		}
-		
-		/*void PropertyChanged(object sender, PropertyChangedEventArgs e)
-		{
-			if (e.Key == ambienceProperty) {
-				OnAmbienceChanged(EventArgs.Empty);
-			}
-		}
-		
-		public override void InitializeService()
-		{
-			PropertyService.PropertyChanged += new PropertyEventHandler(PropertyChanged);
-		}
-		
-		public override void UnloadService()
-		{
-			PropertyService.PropertyChanged -= new PropertyEventHandler(PropertyChanged);
-		}
-		
-		protected virtual void OnAmbienceChanged(EventArgs e)
-		{
-			if (AmbienceChanged != null) {
-				AmbienceChanged(this, e);
-			}
-		}
-		
-		public event EventHandler AmbienceChanged;*/
-	}
-}
Index: main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Ambience/ConversionFlags.cs
===================================================================
--- main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Ambience/ConversionFlags.cs	(revision 135730)
+++ main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Ambience/ConversionFlags.cs	(working copy)
@@ -1,78 +0,0 @@
-//  ConversionFlags.cs
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
-using MonoDevelop.Projects.Parser;
-using MonoDevelop.Core;
-
-namespace MonoDevelop.Projects.Ambience
-{
-	[Flags]
-	public enum ConversionFlags {
-		None                   = 0,
-		ShowParameterNames     = 1,
-		UseFullyQualifiedNames = 1<<1,
-		ShowMemberModifiers    = 1<<2,
-		ShowInheritanceList    = 1<<3,
-		ShowAccessibility      = 1<<4,
-		IncludeHTMLMarkup      = 1<<5,
-		UseLinkArrayList       = 1<<6,
-		QualifiedNamesOnlyForReturnTypes = 1<<7,
-		IncludeBodies          = 1<<8,
-		IncludePangoMarkup     = 1<<9,
-		ShowClassModifiers     = 1<<10,
-		ShowGenericParameters  = 1<<11,
-		UseIntrinsicTypeNames  = 1<<12,
-		ShowReturnType         = 1<<13,
-		ShowParameters         = 1<<14,
-		
-		StandardConversionFlags = ShowParameterNames | 
-		                          UseFullyQualifiedNames | 
-		                          ShowMemberModifiers |
-		                          ShowClassModifiers |
-		                          ShowGenericParameters |
-		                          ShowReturnType |
-		                          ShowParameters |
-		                          UseIntrinsicTypeNames,
-		                          
-		All = ShowParameterNames | 
-		      ShowAccessibility | 
-		      UseFullyQualifiedNames |
-		      ShowMemberModifiers |
-		      ShowClassModifiers |
-		      ShowInheritanceList |
-              ShowGenericParameters |
-              ShowReturnType |
-              ShowParameters |
-              UseIntrinsicTypeNames,
-
-		      
-		AssemblyScoutDefaults = StandardConversionFlags |
-		                        ShowAccessibility |	
-		                        QualifiedNamesOnlyForReturnTypes |
-		                        IncludeHTMLMarkup |
-		                        UseLinkArrayList |
-		                        ShowReturnType |
-  	                            ShowParameters |
-		                        ShowGenericParameters,
-	}
-}
Index: main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Ambience/NetAmbience.cs
===================================================================
--- main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Ambience/NetAmbience.cs	(revision 135730)
+++ main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.Ambience/NetAmbience.cs	(working copy)
@@ -1,351 +0,0 @@
-//  NetAmbience.cs
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
-using System.Text;
-
-using MonoDevelop.Projects.Parser;
-using MonoDevelop.Core;
-
-namespace MonoDevelop.Projects.Ambience
-{
-	public class NetAmbience : Ambience
-	{		
-		public override string Convert(ModifierEnum modifier, ConversionFlags conversionFlags)
-		{
-			return "";
-		}
-		
-		public override string Convert (IClass c, ConversionFlags conversionFlags, ITypeNameResolver resolver)
-		{
-			StringBuilder builder = new StringBuilder();
-			
-			if (ShowClassModifiers(conversionFlags)) {
-				switch (c.ClassType) {
-					case ClassType.Delegate:
-						builder.Append("Delegate");
-						break;
-					case ClassType.Class:
-						builder.Append("Class");
-						break;
-					case ClassType.Struct:
-						builder.Append("Structure");
-						break;
-					case ClassType.Interface:
-						builder.Append("Interface");
-						break;
-					case ClassType.Enum:
-						builder.Append("Enumeration");
-						break;
-				}
-				builder.Append(' ');
-			}
-			
-			if (UseFullyQualifiedNames(conversionFlags))
-				builder.Append (c.FullyQualifiedName);
-			else
-				builder.Append (c.Name);
-			
-			if (c.GenericParameters != null && c.GenericParameters.Count > 0)
- 			{
- 				builder.Append("&lt;");
- 				for (int i = 0; i < c.GenericParameters.Count; i++)
- 				{
- 					builder.Append(c.GenericParameters[i].Name);
- 					if (i + 1 < c.GenericParameters.Count) builder.Append(", ");
- 				}
- 				builder.Append("&gt;");
- 			}
-				
-			if (c.ClassType == ClassType.Delegate) {
-				builder.Append('(');
-				
-				foreach (IMethod m in c.Methods) {
-					if (m.Name != "Invoke") continue;
-					
-					for (int i = 0; i < m.Parameters.Count; ++i) {
-						builder.Append(Convert(m.Parameters[i]));
-						if (i + 1 < m.Parameters.Count) {
-							builder.Append(", ");
-						}
-					}					
-				}
-				
-				builder.Append(')');
-				if (c.Methods.Count > 0) {
-					builder.Append(" : ");
-					builder.Append(Convert(c.Methods[0].ReturnType));
-				}
-			} else if (ShowInheritanceList(conversionFlags)) {
-				if (c.BaseTypes.Count > 0) {
-					builder.Append(" : ");
-					for (int i = 0; i < c.BaseTypes.Count; ++i) {
-						builder.Append(c.BaseTypes[i]);
-						if (i + 1 < c.BaseTypes.Count) {
-							builder.Append(", ");
-						}
-					}
-				}
-			}
-			
-			if (IncludeBodies(conversionFlags)) {
-				builder.Append("\n{");
-			}
-			
-			return builder.ToString();		
-		}
-		
-		public override string ConvertEnd(IClass c, ConversionFlags conversionFlags)
-		{
-			return "}";
-		}
-		
-		public override string Convert(IField field, ConversionFlags conversionFlags, ITypeNameResolver resolver)
-		{
-			StringBuilder builder = new StringBuilder();
-			if (ShowMemberModifiers(conversionFlags)) {
-				builder.Append("Field");
-				builder.Append(' ');
-			}
-			
-			if (UseFullyQualifiedNames(conversionFlags)) {
-				builder.Append(field.FullyQualifiedName);
-			} else {
-				builder.Append(field.Name);
-			}
-			
-			if (field.ReturnType != null && ShowReturnType (conversionFlags)) {
-				builder.Append(" : ");
-				builder.Append(Convert(field.ReturnType));
-			}
-			
-			return builder.ToString();			
-		}
-		
-		public override string Convert(IProperty property, ConversionFlags conversionFlags, ITypeNameResolver resolver)
-		{
-			StringBuilder builder = new StringBuilder();
-			if (ShowMemberModifiers(conversionFlags)) {
-				builder.Append("Property");
-				builder.Append(' ');
-			}
-			
-			if (UseFullyQualifiedNames(conversionFlags)) {
-				builder.Append(property.FullyQualifiedName);
-			} else {
-				builder.Append(property.Name);
-			}
-			if (ShowParameters (conversionFlags)) {
-				if (property.Parameters.Count > 0) builder.Append('(');
-			
-				for (int i = 0; i < property.Parameters.Count; ++i) {
-					builder.Append(Convert(property.Parameters[i]));
-					if (i + 1 < property.Parameters.Count) {
-						builder.Append(", ");
-					}
-				}
-				
-				if (property.Parameters.Count > 0) builder.Append(')');
-			}
-			
-			
-			if (property.ReturnType != null && ShowReturnType (conversionFlags)) {
-				builder.Append(" : ");
-				builder.Append(Convert(property.ReturnType));
-			}
-			return builder.ToString();
-		}
-		
-		public override string Convert(IEvent e, ConversionFlags conversionFlags, ITypeNameResolver resolver)
-		{
-			StringBuilder builder = new StringBuilder();
-			if (ShowMemberModifiers(conversionFlags)) {
-				builder.Append("Event ");
-			}
-			
-			if (UseFullyQualifiedNames(conversionFlags)) {
-				builder.Append(e.FullyQualifiedName);
-			} else {
-				builder.Append(e.Name);
-			}
-			if (e.ReturnType != null && ShowReturnType (conversionFlags)) {
-				builder.Append(" : ");
-				builder.Append(Convert(e.ReturnType));
-			}
-			return builder.ToString();
-		}
-		
-		public override string Convert(IIndexer m, ConversionFlags conversionFlags, ITypeNameResolver resolver)
-		{
-			StringBuilder builder = new StringBuilder();
-			if (ShowMemberModifiers(conversionFlags)) {
-				builder.Append("Indexer ");
-			}
-			
-			if (UseFullyQualifiedNames(conversionFlags)) {
-				builder.Append(m.FullyQualifiedName);
-			} else {
-				builder.Append(m.Name);
-			}
-			builder.Append('[');
-			for (int i = 0; i < m.Parameters.Count; ++i) {
-				builder.Append(Convert(m.Parameters[i]));
-				if (i + 1 < m.Parameters.Count) {
-					builder.Append(", ");
-				}
-			}
-			
-			builder.Append("]");
-			if (m.ReturnType != null && ShowReturnType (conversionFlags)) {
-				builder.Append(" : ");
-				builder.Append(Convert(m.ReturnType));
-			}
-			return builder.ToString();
-		}
-		
-		public override string Convert(IMethod m, ConversionFlags conversionFlags, ITypeNameResolver resolver)
-		{
-			StringBuilder builder = new StringBuilder();
-			if (ShowMemberModifiers(conversionFlags)) {
-				builder.Append("Method ");
-			}
-			
-			if (UseFullyQualifiedNames(conversionFlags)) {
-				builder.Append(m.FullyQualifiedName);
-			} else {
-				builder.Append(m.Name);
-			}
-			if (ShowParameters (conversionFlags)) {			
-				builder.Append('(');
-				for (int i = 0; i < m.Parameters.Count; ++i) {
-					builder.Append(Convert(m.Parameters[i]));
-					if (i + 1 < m.Parameters.Count) {
-						builder.Append(", ");
-					}
-				}
-				
-				builder.Append(")");
-			}
-			if (m.ReturnType != null && ShowReturnType (conversionFlags)) {
-				builder.Append(" : ");
-				builder.Append(Convert(m.ReturnType));
-			}
-			
-			if (IncludeBodies(conversionFlags)) {
-				builder.Append(" {");
-			}
-			
-			return builder.ToString();
-		}
-		
-		public override string ConvertEnd(IMethod m, ConversionFlags conversionFlags)
-		{
-			return "}";
-		}	
-		
-		public override string Convert(IReturnType returnType, ConversionFlags conversionFlags, ITypeNameResolver resolver)
-		{
-			if (returnType == null) {
-				return String.Empty;
-			}
-			StringBuilder builder = new StringBuilder();
-			
-			bool linkSet = false;
-			
-			//if (UseLinkArrayList(conversionFlags)) {
-				//SharpAssemblyReturnType ret = returnType as SharpAssemblyReturnType;
-				//if (ret != null) {
-				//	if (ret.UnderlyingClass != null) {
-				//		builder.Append("<a href='as://" + linkArrayList.Add(ret.UnderlyingClass) + "'>");
-				//		linkSet = true;
-				//	}
-				//}
-			//}
-			
-			if (UseFullyQualifiedNames(conversionFlags)) {
-				builder.Append(returnType.FullyQualifiedName);
-			} else {
-				builder.Append(returnType.Name);
-			}
-			
-			if (linkSet) {
-				builder.Append("</a>");
-			}
-			
-			for (int i = 0; i < returnType.PointerNestingLevel; ++i) {
-				builder.Append('*');
-			}
-			
-			for (int i = 0; i < returnType.ArrayCount; ++i) {
-				builder.Append('[');
-				for (int j = 1; j < returnType.ArrayDimensions[i]; ++j) {
-					builder.Append(',');
-				}
-				builder.Append(']');
-			}
-			
-			return builder.ToString();
-		}
-		
-		public override string Convert(IParameter param, ConversionFlags conversionFlags, ITypeNameResolver resolver)
-		{
-			StringBuilder builder = new StringBuilder();
-			if (ShowParameterNames(conversionFlags)) {
-				builder.Append(param.Name);
-			}
-			if (ShowReturnType (conversionFlags)) {
-				builder.Append(" : ");
-				builder.Append(Convert(param.ReturnType));
-			}
-			if (param.IsRef) {
-				builder.Append("&amp;");
-			}
-			return builder.ToString();
-		}
-
-		public override string Convert(LocalVariable localVariable, ConversionFlags conversionFlags, ITypeNameResolver resolver)
-		{
-			StringBuilder builder = new StringBuilder();
-
-			builder.Append(localVariable.Name);
-			if (ShowReturnType (conversionFlags)) {
-				builder.Append(" : ");
-				builder.Append(Convert(localVariable.ReturnType));
-			}
-
-			return builder.ToString();
-		}
-
-		public override string WrapAttribute(string attribute)
-		{
-			return "[" + attribute + "]";
-		}
-		
-		public override string WrapComment(string comment)
-		{
-			return "// " + comment;
-		}
-		
-		public override string GetIntrinsicTypeName(string dotNetTypeName)
-		{
-			return dotNetTypeName;
-		}
-	}
-}
Index: main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.csproj
===================================================================
--- main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.csproj	(revision 135730)
+++ main/src/core/MonoDevelop.Projects/MonoDevelop.Projects.csproj	(working copy)
@@ -65,10 +65,8 @@
     </ProjectReference>
   </ItemGroup>
   <ItemGroup>
-    <Compile Include="MonoDevelop.Projects\CombineEventArgs.cs" />
     <Compile Include="MonoDevelop.Projects\FileFormatManager.cs" />
     <Compile Include="MonoDevelop.Projects\ProjectEventArgs.cs" />
-    <Compile Include="MonoDevelop.Projects\ProjectRenameEventArgs.cs" />
     <Compile Include="MonoDevelop.Projects\ProjectService.cs" />
     <Compile Include="MonoDevelop.Projects.Extensions\ItemPropertyCodon.cs" />
     <Compile Include="MonoDevelop.Projects.Utility\DiffUtility.cs" />
@@ -77,10 +75,8 @@
     <Compile Include="MonoDevelop.Projects\SolutionEntityItem.cs" />
     <Compile Include="MonoDevelop.Projects\SolutionItemEventArgs.cs" />
     <Compile Include="MonoDevelop.Projects\CombineEntryRenamedEventArgs.cs" />
-    <Compile Include="MonoDevelop.Projects\CyclicBuildOrderException.cs" />
     <Compile Include="MonoDevelop.Projects\SolutionItemConfiguration.cs" />
     <Compile Include="MonoDevelop.Projects\AbstractProjectConfiguration.cs" />
-    <Compile Include="MonoDevelop.Projects\ConvertXml.cs" />
     <Compile Include="MonoDevelop.Projects\DotNetProjectBinding.cs" />
     <Compile Include="MonoDevelop.Projects\DotNetProjectConfiguration.cs" />
     <Compile Include="MonoDevelop.Projects\Project.cs" />
Index: main/src/core/MonoDevelop.Projects/MonoDevelop.Projects/CombineEventArgs.cs
===================================================================
--- main/src/core/MonoDevelop.Projects/MonoDevelop.Projects/CombineEventArgs.cs	(revision 135730)
+++ main/src/core/MonoDevelop.Projects/MonoDevelop.Projects/CombineEventArgs.cs	(working copy)
@@ -1,43 +0,0 @@
-//  CombineEventArgs.cs
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
-using MonoDevelop.Projects;
-
-namespace MonoDevelop.Projects
-{
-	public delegate void CombineEventHandler(object sender, CombineEventArgs e);
-	
-	public class CombineEventArgs : EventArgs
-	{
-		SolutionFolder folder;
-		
-		public SolutionFolder Combine {
-			get {
-				return folder;
-			}
-		}
-		
-		public CombineEventArgs(SolutionFolder folder)
-		{
-			this.folder = folder;
-		}
-	}
-}
Index: main/src/core/MonoDevelop.Projects/MonoDevelop.Projects/ConvertXml.cs
===================================================================
--- main/src/core/MonoDevelop.Projects/MonoDevelop.Projects/ConvertXml.cs	(revision 135730)
+++ main/src/core/MonoDevelop.Projects/MonoDevelop.Projects/ConvertXml.cs	(working copy)
@@ -1,176 +0,0 @@
-//  ConvertXml.cs
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
-using System.IO;
-using System.Xml;
-using System.Xml.XPath;
-using System.Xml.Xsl;
-using System.Security;
-using System.Security.Permissions;
-
-namespace MonoDevelop.Projects
-{
-	/// <summary>
-	/// This class is used to convert xml files using xslt
-	/// </summary>
-	internal class ConvertXml
-	{
-		/// <remarks>
-		/// The main module loads the three required input vars
-		/// and performs the transform
-		/// </remarks>
-		/// <param name="args">
-		/// arg1 - the input file (preferably VS.NET .csproj)
-		/// arg2 - path to XSL transform file
-		/// arg3 - path to output file (preferably SD .prjx)
-		/// </param>
-		public static void Convert(string inputFile, string xslPath, string outputFile)
-		{
-			Convert(inputFile, xslPath, outputFile, null);
-		}
-		public static void Convert(string inputFile, string xslPath, string outputFile, XsltArgumentList xsltArgList)
-		{
-			// Transform the file
-			XmlReader reader = GetXML(inputFile);
-			XmlReader oTransformed = TransformXmlToXml(reader, xslPath, xsltArgList);
-			reader.Close();
-			
-			// Output results to file path
-			XmlDocument myDoc = new XmlDocument();
-			myDoc.Load(oTransformed);
-			myDoc.Save(outputFile);
-		}
-		
-		public static void Convert(string inputFile, XmlReader xslReader, string outputFile, XsltArgumentList xsltArgList)
-		{
-			// Transform the file
-			XmlReader reader = GetXML(inputFile);
-			XmlReader oTransformed = TransformXmlToXml(reader, xslReader, xsltArgList);
-			reader.Close();
-			
-			// Output results to file path
-			XmlDocument myDoc = new XmlDocument();
-			myDoc.Load(oTransformed);
-			myDoc.Save(outputFile);
-		}
-
-		public static string ConvertToString(string inputFile, string xslPath)
-		{
-			return ConvertToString(inputFile, xslPath, null);
-		}
-		
-		public static string ConvertToString(string inputFile, string xslPath, XsltArgumentList xsltArgList)
-		{
-			// Transform the file
-			XmlReader reader = GetXML(inputFile);
-			XmlReader oTransformed = TransformXmlToXml(reader, xslPath, xsltArgList);
-			reader.Close();
-			
-			// Output results to string
-			XmlDocument myDoc = new XmlDocument();
-			myDoc.Load(oTransformed);
-			StringWriter sw = new StringWriter();
-			myDoc.Save(sw);
-			return sw.ToString();
-		}
-		
-		public static string ConvertData(string inputXml, string xslPath, XsltArgumentList xsltArgList)
-		{
-			XmlReader reader = new XmlTextReader(new StringReader(inputXml));
-			XmlReader oTransformed = TransformXmlToXml(reader, xslPath, xsltArgList);
-			reader.Close();
-			
-			// Output results to string
-			XmlDocument myDoc = new XmlDocument();
-			myDoc.Load(oTransformed);
-			StringWriter sw = new StringWriter();
-			myDoc.Save(sw);
-			return sw.ToString();
-		}
-		
-		public static string ConvertData(string inputXml, XmlReader xslReader, XsltArgumentList xsltArgList)
-		{
-			XmlReader reader = new XmlTextReader(new StringReader(inputXml));
-			XmlReader oTransformed = TransformXmlToXml(reader, xslReader, xsltArgList);
-			reader.Close();
-			
-			// Output results to string
-			XmlDocument myDoc = new XmlDocument();
-			myDoc.Load(oTransformed);
-			StringWriter sw = new StringWriter();
-			myDoc.Save(sw);
-			return sw.ToString();
-		}
-		
-		public static XmlReader TransformXmlToXml(XmlReader oXML, string XSLPath, XsltArgumentList xsltArgList)
-		{
-			XslTransform xslt = new XslTransform();
-			xslt.Load(XSLPath);
-			
-			XPathDocument inputData = new XPathDocument(oXML);
-			
-			return xslt.Transform(inputData, xsltArgList, new XmlSecureResolver (new XmlUrlResolver (), new PermissionSet (PermissionState.Unrestricted)));
-		}
-		
-		public static XmlReader TransformXmlToXml(XmlReader oXML, XmlReader XSLReader, XsltArgumentList xsltArgList)
-		{
-			XslTransform xslt = new XslTransform();
-			xslt.Load(XSLReader, new XmlSecureResolver (new XmlUrlResolver (), new PermissionSet (PermissionState.Unrestricted)), null);
-			
-			XPathDocument inputData = new XPathDocument(oXML);
-			
-			return xslt.Transform(inputData, xsltArgList, new XmlSecureResolver (new XmlUrlResolver (), new PermissionSet (PermissionState.Unrestricted)));
-		}
-		
-		/// <summary>
-		/// GetXML returns an XmlReader dependent on the contents
-		/// of the passed input param.
-		/// GetXML checks for the following conditions:
-		/// blank string returns an empty XmlReader
-		/// less-than at start assumes an XML file
-		/// back-slash at start assumes UNC path
-		/// otherwise, URL is assumed
-		/// </summary>
-		/// <param name="strInput"></param>
-		/// <returns></returns>
-		public static XmlReader GetXML(string strInput)
-		{
-			// Check if string is blank
-			if (strInput.Length == 0) {
-				// Return the empty xml reader
-				return new XmlTextReader("");
-			} else {
-					// Check if string starts with "<"
-					// If it does, it is an XML file
-					if (strInput.Substring(0,1) == "<")
-					{
-						//String could be an xml file - load
-						return new XmlTextReader(new StringReader(strInput));
-					}
-					else
-						{
-							// Assume this is a file path - return loaded XML
-							return new XmlTextReader(strInput);
-						}
-				}
-		}
-	}
-}
Index: main/src/core/MonoDevelop.Projects/MonoDevelop.Projects/CyclicBuildOrderException.cs
===================================================================
--- main/src/core/MonoDevelop.Projects/MonoDevelop.Projects/CyclicBuildOrderException.cs	(revision 135730)
+++ main/src/core/MonoDevelop.Projects/MonoDevelop.Projects/CyclicBuildOrderException.cs	(working copy)
@@ -1,41 +0,0 @@
-//  CyclicBuildOrderException.cs
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
-namespace MonoDevelop.Projects
-{
-	public class CyclicBuildOrderException : System.Exception
-	{
-		string[] cycle = null;
-		
-		public string[] Cycle {
-			get {
-				return cycle;
-			}
-		}
-		
-		public CyclicBuildOrderException()
-		{
-		}
-		public CyclicBuildOrderException(string[] cycle)
-		{
-			this.cycle = cycle;
-		}
-	}
-}
Index: main/src/core/MonoDevelop.Projects/MonoDevelop.Projects/IProjectService.cs
===================================================================
--- main/src/core/MonoDevelop.Projects/MonoDevelop.Projects/IProjectService.cs	(revision 135730)
+++ main/src/core/MonoDevelop.Projects/MonoDevelop.Projects/IProjectService.cs	(working copy)
@@ -1,57 +0,0 @@
-//  IProjectService.cs
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
-using System.Xml;
-
-using MonoDevelop.Projects;
-using MonoDevelop.Core.Serialization;
-using MonoDevelop.Core;
-
-namespace MonoDevelop.Projects
-{
-	/// <summary>
-	/// This interface describes the basic functions of the 
-	/// SharpDevelop project service.
-	/// </summary>
-	public interface IProjectService
-	{
-		bool IsSolutionItemFile (string filename);
-		
-		DataContext DataContext {
-			get;
-		}
-		
-		FileFormatManager FileFormats {
-			get;
-		}
-		
-		SolutionEntityItem ReadSolutionItem (string file, IProgressMonitor monitor);
-
-		string Export (IProgressMonitor monitor, string rootSourceFile, string targetPath, IFileFormat format);
-		string Export (IProgressMonitor monitor, string rootSourceFile, string[] childEnryFiles, string targetPath, IFileFormat format);
-
-		bool CanCreateSingleFileProject (string file);
-		Project CreateSingleFileProject (string file);
-		
-		Project CreateProject (string type, ProjectCreateInformation info, XmlElement projectOptions);
-	}
-}
Index: main/src/core/MonoDevelop.Projects/MonoDevelop.Projects/ProjectRenameEventArgs.cs
===================================================================
--- main/src/core/MonoDevelop.Projects/MonoDevelop.Projects/ProjectRenameEventArgs.cs	(revision 135730)
+++ main/src/core/MonoDevelop.Projects/MonoDevelop.Projects/ProjectRenameEventArgs.cs	(working copy)
@@ -1,59 +0,0 @@
-//  ProjectRenameEventArgs.cs
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
-using MonoDevelop.Projects;
-
-namespace MonoDevelop.Projects 
-{
-	public delegate void ProjectRenameEventHandler(object sender, ProjectRenameEventArgs e);
-	
-	public class ProjectRenameEventArgs : EventArgs
-	{ 
-		Project project;
-		string   oldName;
-		string   newName;
-		
-		public Project Project {
-			get {
-				return project;
-			}
-		}
-		
-		public string OldName {
-			get {
-				return oldName;
-			}
-		}
-		
-		public string NewName {
-			get {
-				return newName;
-			}
-		}
-		
-		public ProjectRenameEventArgs(Project project, string oldName, string newName)
-		{
-			this.project = project;
-			this.oldName = oldName;
-			this.newName = newName;
-		}
-	}
-}
Index: main/src/core/MonoDevelop.Projects/MonoDevelop.Projects/SolutionFolder.cs
===================================================================
--- main/src/core/MonoDevelop.Projects/MonoDevelop.Projects/SolutionFolder.cs	(revision 135730)
+++ main/src/core/MonoDevelop.Projects/MonoDevelop.Projects/SolutionFolder.cs	(working copy)
@@ -103,23 +103,23 @@
 					OnNameChanged (new SolutionItemRenamedEventArgs (this, oldName, name));
 				}
 			}
-		}
-
+		}
+
 		protected override FilePath GetDefaultBaseDirectory ( )
 		{
 			// Since solution folders don't are not bound to a specific directory, we have to guess it.
 			// First of all try to find a common root of all child projects
 			
 			if (ParentFolder == null)
-				return ParentSolution.BaseDirectory;
-
+				return ParentSolution.BaseDirectory;
+
 			FilePath path = GetCommonPathRoot ();
 			if (!string.IsNullOrEmpty (path))
 			    return path;
 			
 			// Now try getting the folder using the folder name
 			
-			SolutionFolder folder = this;
+			SolutionFolder folder = this;
 			path = FilePath.Empty;
 			do {
 				// Root folder name is ignored
@@ -133,13 +133,13 @@
 				return ParentFolder.BaseDirectory;
 			else
 				return path;
-		}
-
+		}
+
 		FilePath GetCommonPathRoot ( )
-		{
+		{
 			FilePath path = null;
 
-			foreach (SolutionItem it in Items) {
+			foreach (SolutionItem it in Items) {
 				FilePath subdir;
 				if (it is SolutionFolder) {
 					SolutionFolder sf = (SolutionFolder) it;
@@ -150,7 +150,7 @@
 				} else
 					subdir = it.BaseDirectory;
 				
-				if (subdir.IsNullOrEmpty)
+				if (subdir.IsNullOrEmpty)
 					return FilePath.Null;
 				
 				if (!path.IsNull) {
@@ -550,8 +550,8 @@
 			ReadOnlyCollection<SolutionItem> allProjects;
 				
 			try {
-				allProjects = GetAllBuildableEntries (configuration, true, true);
-			} catch (CyclicBuildOrderException) {
+				allProjects = GetAllBuildableEntries (configuration, true, true);
+			} catch(CyclicDependencyException) {
 				monitor.ReportError (GettextCatalog.GetString ("Cyclic dependencies are not supported."), null);
 				return new BuildResult ("", 1, 1);
 			}
Index: main/src/core/MonoDevelop.Projects/MonoDevelop.Projects/SolutionItem.cs
===================================================================
--- main/src/core/MonoDevelop.Projects/MonoDevelop.Projects/SolutionItem.cs	(revision 135730)
+++ main/src/core/MonoDevelop.Projects/MonoDevelop.Projects/SolutionItem.cs	(working copy)
@@ -33,11 +33,16 @@
 using System.CodeDom.Compiler;
 using MonoDevelop.Core;
 using MonoDevelop.Core.Serialization;
-using MonoDevelop.Projects.Extensions;
+using MonoDevelop.Projects.Extensions;
 using MonoDevelop.Core.Collections;
 
 namespace MonoDevelop.Projects
-{
+{
+	class CyclicDependencyException : Exception
+	{
+		public CyclicDependencyException () { }
+	}
+
 	public abstract class SolutionItem: IExtendedDataItem, IBuildTarget, ILoadController
 	{
 		SolutionFolder parentFolder;
@@ -107,7 +112,7 @@
 		
 		public FilePath BaseDirectory {
 			get {
-				if (baseDirectory == null) {
+				if (baseDirectory == null) {
 					FilePath dir = GetDefaultBaseDirectory ();
 					if (dir.IsNullOrEmpty)
 						dir = ".";
@@ -116,7 +121,7 @@
 				else
 					return baseDirectory;
 			}
-			set {
+			set {
 				FilePath def = GetDefaultBaseDirectory ();
 				if (value != FilePath.Null && def != FilePath.Null && value.FullPath == def.FullPath)
 					baseDirectory = null;
@@ -129,7 +134,7 @@
 		}
 		
 		public FilePath ItemDirectory {
-			get {
+			get {
 				FilePath dir = GetDefaultBaseDirectory ();
 				if (string.IsNullOrEmpty (dir))
 					dir = ".";
@@ -139,8 +144,8 @@
 		
 		internal bool HasCustomBaseDirectory {
 			get { return baseDirectory != null; }
-		}
-
+		}
+
 		protected virtual FilePath GetDefaultBaseDirectory ( )
 		{
 			return ParentSolution.BaseDirectory;
@@ -233,8 +238,8 @@
 			// Get a list of all items that need to be built (including this),
 			// and build them in the correct order
 			
-			List<SolutionItem> referenced = new List<SolutionItem> ();
-			Set<SolutionItem> visited = new Set<SolutionItem> ();
+			List<SolutionItem> referenced = new List<SolutionItem> ();
+			Set<SolutionItem> visited = new Set<SolutionItem> ();
 			GetBuildableReferencedItems (visited, referenced, this, solutionConfiguration);
 			
 			ReadOnlyCollection<SolutionItem> sortedReferenced = SolutionFolder.TopologicalSort (referenced, solutionConfiguration);
@@ -274,7 +279,7 @@
 		}
 		
 		void GetBuildableReferencedItems (Set<SolutionItem> visited, List<SolutionItem> referenced, SolutionItem item, string solutionConfiguration)
-		{
+		{
 			if (!visited.Add(item))
 				return;
 			
@@ -335,8 +340,8 @@
 		
 		static void Insert<T> (int index, IList<T> allItems, List<T> sortedItems, bool[] inserted, bool[] triedToInsert, string solutionConfiguration) where T: SolutionItem
 		{
-			if (triedToInsert[index]) {
-				throw new CyclicBuildOrderException();
+			if (triedToInsert[index]) {
+				throw new CyclicDependencyException ();
 			}
 			triedToInsert[index] = true;
 			SolutionItem insertItem = allItems[index];