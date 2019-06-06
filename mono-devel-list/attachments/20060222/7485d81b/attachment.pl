Index: ChangeLog
===================================================================
--- ChangeLog	(revision 57123)
+++ ChangeLog	(working copy)
@@ -1,3 +1,11 @@
+2006-02-22  Atsushi Enomoto  <atsushi@ximian.com>
+
+	* WellFormedXmlWriter.cs : new file to escape invalid XML
+	  characters.
+	* mono-api-info.cs mono-api-diff.cs : don't use XmlTextWriter
+	  directly when you don't know what you are going to write.
+	  escape invalid characters as \xXX or \uUUUU.
+
 2006-01-26  Atsushi Enomoto  <atsushi@ximian.com>
 
 	* mono-api-info.cs
Index: mono-api-diff.cs
===================================================================
--- mono-api-diff.cs	(revision 57123)
+++ mono-api-diff.cs	(working copy)
@@ -30,7 +30,8 @@
 
 			XmlTextWriter writer = new XmlTextWriter (Console.Out);
 			writer.Formatting = Formatting.Indented;
-			doc.WriteTo (writer);
+			WellFormedXmlWriter wfwriter = new WellFormedXmlWriter (writer);
+			doc.WriteTo (wfwriter);
 
 			return 0;
 		}
Index: mono-api-info.cs
===================================================================
--- mono-api-info.cs	(revision 57123)
+++ mono-api-info.cs	(working copy)
@@ -37,9 +37,10 @@
 
 			XmlTextWriter writer = new XmlTextWriter (Console.Out);
 			writer.Formatting = Formatting.Indented;
+			WellFormedXmlWriter wfwriter = new WellFormedXmlWriter (writer);
 			XmlNode decl = doc.CreateXmlDeclaration ("1.0", null, null);
 			doc.InsertBefore (decl, doc.DocumentElement);
-			doc.WriteTo (writer);
+			doc.WriteTo (wfwriter);
 			return 0;
 		}
 	}
Index: Makefile
===================================================================
--- Makefile	(revision 57123)
+++ Makefile	(working copy)
@@ -28,8 +28,8 @@
 
 PROGRAM_INSTALL_DIR = $(mono_libdir)/mono/$(FRAMEWORK_VERSION)
 
-APIINFO_SOURCES = mono-api-info.cs
-APIDIFF_SOURCES = mono-api-diff.cs
+APIINFO_SOURCES = mono-api-info.cs WellFormedXmlWriter.cs
+APIDIFF_SOURCES = mono-api-diff.cs WellFormedXmlWriter.cs
 
 DISTFILES= $(CORCOMPARE_SOURCES) $(APIINFO_SOURCES) $(APIDIFF_SOURCES)
 