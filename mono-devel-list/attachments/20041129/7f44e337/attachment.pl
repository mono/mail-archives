Index: browser/monodoc.dll.config.in
===================================================================
--- browser/monodoc.dll.config.in	(revision 36744)
+++ browser/monodoc.dll.config.in	(working copy)
@@ -1,3 +1,3 @@
 <config>
-        <path docsPath="@monodocdir@" />
+        <path docsPath="@monodoc_refdir@" />
 </config>
Index: browser/Makefile.am
===================================================================
--- browser/Makefile.am	(revision 36744)
+++ browser/Makefile.am	(working copy)
@@ -1,10 +1,22 @@
 assemblydir = $(libdir)
-monodoc_DATA = browser.exe assembler.exe normalize.exe monodoc.xml mod.exe validate.exe
+
+if WITH_GTK
+monodoc_gtk_DADA = browser.exe
+endif
+
+monodoc_DATA = $(monodoc_gtk_DATA) assembler.exe normalize.exe monodoc.xml mod.exe validate.exe
 noinst_DATA = monodoc.dll monodoc.dll.config
-CLEANFILES = monodoc.dll assembler.exe browser.exe normalize.exe mod.exe validate.exe
+CLEANFILES = monodoc.dll assembler.exe $(monodoc_unix_DATA) normalize.exe mod.exe validate.exe
 DISTCLEANFILE = AssemblyInfo.cs
 CSC=mcs
 
+if USE_CYGPATH
+GACDIR=`cygpath -w $(libdir)`
+GACROOT=`cygpath -w $(DESTDIR)$(libdir)`
+else
+GACDIR=$(libdir)
+GACROOT=$(DESTDIR)$(libdir)
+endif
 
 monodoc_sources = \
 	$(srcdir)/colorizer.cs		\
@@ -83,7 +95,7 @@
 	$(CSC) -debug -out:monodoc.dll -target:library /resource:$(srcdir)/mono-ecma.xsl,mono-ecma.xsl /resource:$(srcdir)/ecmaspec-html.xsl,ecmaspec-html.xsl $(monodoc_sources) -r:ICSharpCode.SharpZipLib.dll -r:System.Web -r:System.Web.Services
 
 monodoc.dll.config: $(srcdir)/monodoc.dll.config.in Makefile
-	if sed 's,@''monodocdir@,$(monodocdir),' $(srcdir)/monodoc.dll.config.in > $@t; then mv $@t $@; else rm -f $@t ; exit 1; fi
+	if sed 's,@''monodoc_refdir@,$(monodoc_refdir),' $(srcdir)/monodoc.dll.config.in > $@t; then mv $@t $@; else rm -f $@t ; exit 1; fi
 
 b: browser.exe
 	MONO_PATH=. mono --debug browser.exe
@@ -132,7 +144,7 @@
 	scp tables.sql server.cs server.asmx monodoc.dll root@www.go-mono.com:
 
 install-data-local:
-	$(GACUTIL) /i monodoc.dll /f /package gtk-sharp /gacdir $(DESTDIR)$(libdir)
+	$(GACUTIL) /i monodoc.dll /f /package gtk-sharp /gacdir $(GACDIR) /root $(GACROOT)
 
 uninstall-local:
-	$(GACUTIL) /u monodoc /package gtk-sharp /gacdir $(DESTDIR)$(libdir)
+	$(GACUTIL) /u monodoc /package gtk-sharp /gacdir $(GACDIR)
Index: configure.in
===================================================================
--- configure.in	(revision 36744)
+++ configure.in	(working copy)
@@ -23,11 +23,27 @@
 ALL_LINGUAS="ca"
 AM_GLIB_GNU_GETTEXT
 
+with_gtk=yes
+use_cygpath=no
+monodoc_refdir=$monodocdir
+case "$host" in
+	*-*-mingw*|*-*-cygwin*)
+		with_gtk=no
+		monodoc_refdir=.
+		use_cygpath=yes
+		;;
+esac
+AC_SUBST(monodoc_refdir)
 
-GTKSHARP_REQUIRED_VERSION=0.91
-MONO_REQUIRED_VERSION=0.90
-PKG_CHECK_MODULES(BASE_DEPENDENCIES, gtk-sharp >= $GTKSHARP_REQUIRED_VERSION gtkhtml-sharp >= $GTKSHARP_REQUIRED_VERSION glade-sharp >= $GTKSHARP_REQUIRED_VERSION mono >= $MONO_REQUIRED_VERSION)
+AM_CONDITIONAL(WITH_GTK, test x$with_gtk = xyes)
+AM_CONDITIONAL(USE_CYGPATH, test x$use_cygpath = xyes)
 
+if test "x$with_gtk" = "xyes" ; then
+  GTKSHARP_REQUIRED_VERSION=0.91
+  MONO_REQUIRED_VERSION=0.90
+  PKG_CHECK_MODULES(BASE_DEPENDENCIES, gtk-sharp >= $GTKSHARP_REQUIRED_VERSION gtkhtml-sharp >= $GTKSHARP_REQUIRED_VERSION glade-sharp >= $GTKSHARP_REQUIRED_VERSION mono >= $MONO_REQUIRED_VERSION)
+fi
+
 AC_OUTPUT([
 Makefile
 browser/Makefile