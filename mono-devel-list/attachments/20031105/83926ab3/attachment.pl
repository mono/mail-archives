--- mcs/class/System.Drawing/gdiplus/Makefile.orig	2003-11-05 16:20:03.000000000 +0200
+++ mcs/class/System.Drawing/gdiplus/Makefile	2003-11-05 16:20:20.000000000 +0200
@@ -42,7 +42,7 @@
 install-local: all-local
 	$(MKINSTALLDIRS) $(DESTDIR)$(prefix)/lib
 	if test -f $(gdiplus); then \
-		$(INSTALL_LIB) $(gdiplus) $(DESTDIR)$(prefix)/lib \
+		$(INSTALL_LIB) $(gdiplus) $(DESTDIR)$(prefix)/lib; \
 	fi
 
 dist-local: dist-default
