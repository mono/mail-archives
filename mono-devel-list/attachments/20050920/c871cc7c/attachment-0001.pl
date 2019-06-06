Index: mono.1
===================================================================
--- mono.1	(revision 50271)
+++ mono.1	(working copy)
@@ -569,6 +569,9 @@
 See the System.Diagnostics.DefaultTraceListener documentation for more
 information.
 .TP
+.I "MONO_DISABLE_MANAGED_COLLATION"
+If this environment variable is `yes', the runtime uses unmanaged collation (which actually means no culture-sensitive collation). It internally disables managed collation functionality invoked via the members of System.Globalization.CompareInfo class. Collation is enabled by default.
+.TP
 .I "MONO_XMLSERIALIZER_THS"
 Controls the threshold for the XmlSerializer to produce a custom
 serializer for a given class instead of using the Reflection-based