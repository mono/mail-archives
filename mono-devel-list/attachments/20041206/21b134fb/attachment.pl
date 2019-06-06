Index: MethodCoverageItem.cs
===================================================================
--- MethodCoverageItem.cs	(revision 36912)
+++ MethodCoverageItem.cs	(working copy)
@@ -1,7 +1,7 @@
 
 using System;
 using System.Collections;
-using Mono.CSharp.Debugger;
+using Mono.CompilerServices.SymbolWriter;
 
 namespace MonoCov {
 
Index: CoverageModel.cs
===================================================================
--- CoverageModel.cs	(revision 36912)
+++ CoverageModel.cs	(working copy)
@@ -6,7 +6,7 @@
 using System.Reflection;
 using System.Text.RegularExpressions;
 
-using Mono.CSharp.Debugger;
+using Mono.CompilerServices.SymbolWriter;
 
 namespace MonoCov {
 
Index: gui/gtk/MonoCov.cs
===================================================================
--- gui/gtk/MonoCov.cs	(revision 36912)
+++ gui/gtk/MonoCov.cs	(working copy)
@@ -13,6 +13,7 @@
 using Gnome;
 using Glade;
 using GtkSharp;
+using GLib;
 using System;
 using System.Reflection;
 using System.IO;
Index: symbols.cs
===================================================================
--- symbols.cs	(revision 36912)
+++ symbols.cs	(working copy)
@@ -4,7 +4,7 @@
 using System.Xml;
 using System.IO;
 using System.Reflection;
-using Mono.CSharp.Debugger;
+using Mono.CompilerServices.SymbolWriter;
 
 public class SymbolDumper {
 
Index: coverage.c
===================================================================
--- coverage.c	(revision 36912)
+++ coverage.c	(working copy)
@@ -3,12 +3,14 @@
 #include <string.h>
 #include <errno.h>
 
+#include "mono/metadata/verify.h"
 #include "mono/metadata/tabledefs.h"
-#include "mono/metadata/class.h"
-#include "mono/metadata/mono-debug.h"
-#include "mono/metadata/debug-helpers.h"
+#include "mono/metadata/metadata-internals.h"
+#include "mono/metadata/mono-debug-debugger.h"
 #include "mono/metadata/profiler.h"
+#include "mono/metadata/marshal.h"
 
+
 struct _MonoProfiler {
 	/* Contains the methods for which we have coverage data */
 	GHashTable *methods;
Index: Makefile
===================================================================
--- Makefile	(revision 36912)
+++ Makefile	(working copy)
@@ -10,7 +10,7 @@
 	gui/gtk/MonoCov.cs \
 	gui/gtk/CoverageView.cs \
 	gui/gtk/SourceWindow.cs
-GUI_LIBS = -r gtk-sharp.dll -r gdk-sharp.dll -r glib-sharp.dll -r glade-sharp.dll -r gnome-sharp.dll -r System.Drawing -resource:gui/gtk/monocov.glade,monocov.glade
+GUI_LIBS = -pkg:gtk-sharp -pkg:gnome-sharp -pkg:glade-sharp -r System.Drawing -resource:gui/gtk/monocov.glade,monocov.glade
 else
 GUI_SRCS = \
 	gui/qt/MonoCov.cs \
@@ -33,7 +33,7 @@
 	$(GUI_SRCS)
 
 monocov.exe: $(SRCS) style.xsl .gui-$(GUI)
-	mcs -g /target:exe /out:$@ -define:GUI_$(GUI) -r Mono.CSharp.Debugger -r Mono.GetOptions $(GUI_LIBS) $(SRCS) -resource:style.xsl,style.xsl -resource:trans.gif,trans.gif
+	mcs -g /target:exe /out:$@ -define:GUI_$(GUI) -r Mono.CompilerServices.SymbolWriter -r Mono.GetOptions $(GUI_LIBS) $(SRCS) -resource:style.xsl,style.xsl -resource:trans.gif,trans.gif
 
 .gui-gtk:
 	@rm -f .gui-*
@@ -44,10 +44,10 @@
 	@touch .gui-qt
 
 symbols.exe: symbols.cs
-	mcs -g /target:exe /out:$@ -r Mono.CSharp.Debugger symbols.cs
+	mcs -g /target:exe /out:$@ -r Mono.CompilerServices.SymbolWriter symbols.cs
 
 nunit-console.exe: nunit-console.cs
-	mcs -r NUnit.Framework -r Mono.GetOptions nunit-console.cs
+	mcs -r nunit.framework -r Mono.GetOptions nunit-console.cs
 
 libmono-profiler-monocov.so: coverage.c
 	$(CC) -g -I$(MONO_ROOT) `pkg-config --cflags glib-2.0` --shared -o $@ $^
