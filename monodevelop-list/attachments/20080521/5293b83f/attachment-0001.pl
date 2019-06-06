Index: main/monodevelop.xml
===================================================================
--- main/monodevelop.xml	(revision 103638)
+++ main/monodevelop.xml	(working copy)
@@ -125,4 +125,8 @@
     <comment xml:lang="en">Webservices Description File</comment>
     <glob pattern="*.wsdl"/>
   </mime-type>
+  <mime-type type="text/x-nvelocity">
+    <comment xml:lang="en">NVelocity Template File</comment>
+    <glob pattern="*.vm"/>
+  </mime-type>
 </mime-info>
Index: main/src/addins/Mono.Texteditor/Mono.TextEditor.mdp
===================================================================
--- main/src/addins/Mono.Texteditor/Mono.TextEditor.mdp	(revision 103638)
+++ main/src/addins/Mono.Texteditor/Mono.TextEditor.mdp	(working copy)
@@ -78,6 +78,7 @@
     <File name="ValaSyntaxMode.xml" subtype="Code" buildaction="EmbedAsResource" />
     <File name="Mono.TextEditor/CodeSegmentPreviewWindow.cs" subtype="Code" buildaction="Compile" />
     <File name="Mono.TextEditor/ISearchEngine.cs" subtype="Code" buildaction="Compile" />
+    <File name="NVelocitySyntaxMode.xml" subtype="Code" buildaction="EmbedAsResource" />
   </Contents>
   <References>
     <ProjectReference type="Gac" localcopy="True" refto="System, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089" />
Index: main/src/addins/Mono.Texteditor/NVelocitySyntaxMode.xml
===================================================================
--- main/src/addins/Mono.Texteditor/NVelocitySyntaxMode.xml	(revision 0)
+++ main/src/addins/Mono.Texteditor/NVelocitySyntaxMode.xml	(revision 0)
@@ -0,0 +1,111 @@
+<!-- NVelocitySyntaxMode.xml
+
+ Author:
+   Patrick McEvoy <patrick@qmtech.net>
+
+ Copyright (c) 2008 Novell, Inc (http://www.novell.com)
+
+ Permission is hereby granted, free of charge, to any person obtaining a copy
+ of this software and associated documentation files (the "Software"), to deal
+ in the Software without restriction, including without limitation the rights
+ to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ copies of the Software, and to permit persons to whom the Software is
+ furnished to do so, subject to the following conditions:
+
+ The above copyright notice and this permission notice shall be included in
+ all copies or substantial portions of the Software.
+
+ THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
+ AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ THE SOFTWARE. -->
+ 
+<SyntaxMode name = "NVelocity" mimeTypes="text/x-nvelocity">
+	<EolSpan color = "comment" rule="Comment">##</EolSpan>
+	<Span color = "comment" rule="Comment">
+		<Begin>#*</Begin>
+		<End>*#</End>
+	</Span>
+
+	<Span color = "comment" rule="Comment">
+		<Begin><![CDATA[<!--]]></Begin>
+		<End><![CDATA[-->]]></End>
+	</Span>
+
+	<Span color = "markupTag" rule = "InTag">
+		<Begin>&lt;</Begin>
+		<End>&gt;</End>
+	</Span>
+	
+	<Span color = "literal" stopateol = "true" escape="\">
+		<Begin>"</Begin>
+		<End>"</End>
+	</Span>
+
+	<Span color = "literal" stopateol = "true" escape="\">
+		<Begin>&apos;</Begin>
+		<End>&apos;</End>
+	</Span>
+
+	<Rule name = "InTag">
+		<Span color = "literal" rule="InLiteral">
+			<Begin>&quot;</Begin>
+			<End>&quot;</End>
+		</Span>
+		
+		<Span color = "literal" rule="InLiteral">
+			<Begin>&apos;</Begin>
+			<End>&apos;</End>
+		</Span>
+		
+		<!-- attributes -->
+		<Match color = "markup">[A-Za-z0-9_]+(:[A-Za-z0-9_]+)?[\s\n\r]*=</Match>
+	</Rule>
+
+	<!-- Match Variables -->
+	<Match color = "kw:types">\$!?[a-zA-Z][a-zA-Z0-9_-]*</Match>
+	
+	<Keywords color = "kw:selection">
+		<Word>#elseif</Word>
+		<Word>#if</Word>
+		<Word>#end</Word>
+		<Word>#else</Word>
+		<Word>#include</Word>
+		<Word>#set</Word>
+		<Word>#macro</Word>
+		<Word>#parse</Word>
+		<Word>#stop</Word>
+		<Word>#foreach</Word>
+		<Word>#each</Word>
+		<Word>#before</Word>
+		<Word>#after</Word>
+		<Word>#between</Word>
+		<Word>#odd</Word>
+		<Word>#even</Word>
+		<Word>#nodata</Word>
+		<Word>#beforeall</Word>
+		<Word>#afterall</Word>
+		<Word>#capturefor</Word>
+		<Word>#literal</Word>
+		<Word>#conponent</Word>
+		<Word>#blockcomponent</Word>
+	</Keywords>
+	
+	<Keywords color = "kw:literals">
+		<Word>true</Word>
+		<Word>false</Word>
+		<Word>null</Word>
+	</Keywords>
+	
+	<Rule name = "Comment">
+		<Keywords color="todocomment" ignorecase="True">
+			<Word>TODO</Word>
+			<Word>FIXME</Word>
+			<Word>HACK</Word>
+			<Word>UNDONE</Word>
+		</Keywords>	
+	</Rule>
+</SyntaxMode>
Index: main/src/addins/Mono.Texteditor/Makefile.am
===================================================================
--- main/src/addins/Mono.Texteditor/Makefile.am	(revision 103638)
+++ main/src/addins/Mono.Texteditor/Makefile.am	(working copy)
@@ -77,6 +77,7 @@
 	gtk-gui/gui.stetic \
 	gtk-gui/objects.xml \
 	JavaSyntaxMode.xml \
+	NVelocitySyntaxMode.xml \
 	OblivionStyle.xml \
 	PythonSyntaxMode.xml \
 	TangoLightStyle.xml \
Index: main/monodevelop.desktop
===================================================================
--- main/monodevelop.desktop	(revision 103638)
+++ main/monodevelop.desktop	(working copy)
@@ -10,7 +10,7 @@
 StartupNotify=true
 Terminal=false
 Type=Application
-MimeType=text/x-csharp;application/x-mds;application/x-mdp;application/x-cmbx;application/x-prjx;application/x-csproj;application/x-vbproj;application/x-sln;
+MimeType=text/x-csharp;application/x-mds;application/x-mdp;application/x-cmbx;application/x-prjx;application/x-csproj;application/x-vbproj;application/x-sln;text/x-nvelocity
 Categories=Development;
 X-GNOME-Bugzilla-Bugzilla=Ximian
 X-GNOME-Bugzilla-Product=MonoDevelop