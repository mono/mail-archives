? xml-000.cs
? xml-001-ref.xml
? xml-001.cs
? xml-002-ref.xml
? xml-002.cs
? xml-003-ref.xml
? xml-003.cs
? xml-004-ref.xml
? xml-004.cs
? xml-005-ref.xml
? xml-005.cs
? xml-006-ref.xml
? xml-006.cs
? xml-007-ref.xml
? xml-007.cs
? xml-008-ref.xml
? xml-008.cs
? xml-009-ref.xml
? xml-009.cs
? xml-010-ref.xml
? xml-010.cs
? xml-011-ref.xml
? xml-011.cs
? xml-012-ref.xml
? xml-012.cs
? xml-013-ref.xml
? xml-013.cs
? xml-014-ref.xml
? xml-014.cs
? xml-015-ref.xml
? xml-015.cs
? xml-016-ref.xml
? xml-016.cs
? xml-017-ref.xml
? xml-017.cs
? xml-018-ref.xml
? xml-018.cs
? xml-019-ref.xml
? xml-019.cs
? xml-020-ref.xml
? xml-020.cs
? xml-021-ref.xml
? xml-021.cs
? xml-022-ref.xml
? xml-022.cs
? xml-023-ref.xml
? xml-023.cs
? xml-024-ref.xml
? xml-024.cs
? xml-025-ref.xml
? xml-025.cs
? xml-025.inc
? xml-026-ref.xml
? xml-026.cs
? xml-027-ref.xml
? xml-027.cs
Index: Makefile
===================================================================
RCS file: /cvs/public/mcs/tests/Makefile,v
retrieving revision 1.181
diff -u -r1.181 Makefile
--- Makefile	13 Oct 2004 09:08:39 -0000	1.181
+++ Makefile	15 Oct 2004 20:59:01 -0000
@@ -25,6 +25,7 @@
 # He may also move some to TEST_EXCLUDE_net_2_0 if some of the merges are inappropriate for GMCS.
 #
 NEW_TEST_SOURCES_common = \
+	$(TEST_SOURCES_XML) \
 	test-297 test-287 test-294 test-299 test-300 \
 	test-301 test-302 test-303 test-304 test-305 test-306 test-307 test-259 test-309
 
@@ -77,6 +78,11 @@
 	module-1 module-2 module-3 \
 	ns0 ns
 
+TEST_SOURCES_XML = \
+	xml-001 xml-002 xml-003 xml-004 xml-005 xml-006 xml-007 xml-008 xml-009 xml-010 \
+	xml-011 xml-012 xml-013 xml-014 xml-015 xml-016 xml-017 xml-018 xml-019 xml-020 \
+	xml-021 xml-022 xml-023 xml-024 xml-025 xml-026 xml-027
+
 TEST_EXCLUDES_common = 
 
 TEST_SOURCES_default = $(NEW_TEST_SOURCES_common)
@@ -150,7 +156,7 @@
 	$(MAKE) PROFILE=net_2_0 TEST_SOURCES="$(TEST_SOURCES_net_2_0)" test-compiler-jit-real
 
 clean-local:
-	rm -f *.exe *.netmodule *.out *.pdb casts.cs
+	rm -f *.exe *.netmodule *.out *.pdb casts.cs xml-???.xml
 
 dist-local: dist-default
 	rm -f $(distdir)/casts.cs