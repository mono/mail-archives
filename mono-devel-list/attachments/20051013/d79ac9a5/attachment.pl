Index: mbas/Test/misc/Makefile
===================================================================
--- mbas/Test/misc/Makefile	(revision 51681)
+++ mbas/Test/misc/Makefile	(working copy)
@@ -12,7 +12,7 @@
 	$(RUNTIME) $(RUNTIME_FLAGS) --debug WriteOK.exe --sayho /about -say:this,that,those /say:what?
 
 WriteOK.exe: $(WRITEOK_SOURCES) Makefile ../../mbas.exe
-	$(BASCOMPILE) --stacktrace --reference=Mono.GetOptions -r:System.Data,System.Messaging --main WriteOK $(WRITEOK_SOURCES) &> verbose.log
+	$(BASCOMPILE) --stacktrace --reference=Mono.GetOptions -r:System.Data,System.Messaging --main WriteOK $(WRITEOK_SOURCES) 2>&1 > verbose.log
 	@grep "Compilation" verbose.log
 
 verbose:
@@ -20,15 +20,15 @@
 	$(MAKE) LOCAL_MBAS_FLAGS='--verbosegetoptions --verbose --stacktrace' WriteOK.exe
 
 aspx_temp.dll: aspx_temp.vb Makefile ../../mbas.exe
-	$(BASCOMPILE) --stacktrace /target:library /r:"System.dll" /r:"System.Xml.dll" /r:"System.Data.dll" /r:"System.Web.dll" /r:"System.Web.Services.dll" /r:"System.Drawing.dll" -- aspx_temp.vb  &> verbose.aspx.log
+	$(BASCOMPILE) --stacktrace /target:library /r:"System.dll" /r:"System.Xml.dll" /r:"System.Data.dll" /r:"System.Web.dll" /r:"System.Web.Services.dll" /r:"System.Drawing.dll" -- aspx_temp.vb  2>&1 > verbose.aspx.log
 	@grep "Compilation" verbose.aspx.log
 
 test.exe: test.vb ctest.vb Makefile ../../mbas.exe
-	$(BASCOMPILE) -r:System.Windows.Forms -r:System.Drawing test.vb ctest.vb &> verbose.test.log
+	$(BASCOMPILE) -r:System.Windows.Forms -r:System.Drawing test.vb ctest.vb 2>&1 > verbose.test.log
 	@grep "Compilation" verbose.test.log
 
 gtk.exe: gtk.vb Makefile ../../mbas.exe
-	$(BASCOMPILE) -pkg:gtk-sharp gtk.vb &> verbose.gtk.log
+	$(BASCOMPILE) -pkg:gtk-sharp gtk.vb 2>&1 > verbose.gtk.log
 	@grep "Compilation" verbose.gtk.log
 
 profile: $(WRITEOK_SOURCES) Makefile

