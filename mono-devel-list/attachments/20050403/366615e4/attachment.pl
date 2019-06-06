Index: System.Xml.Xsl/ChangeLog
===================================================================
--- System.Xml.Xsl/ChangeLog	(revision 42365)
+++ System.Xml.Xsl/ChangeLog	(working copy)
@@ -1,3 +1,8 @@
+2005-04-03  Andrew Skiba <andrews@mainsoft.com>
+
+	* Multiplexer.cs : added TARGET_JVM switch (that does not support
+	unmanaged code).
+
 2005-03-22  Atsushi Enomoto  <atsushi@ximian.com>
 
 	* XslTransform.cs : commented out warned code.
Index: System.Xml.Xsl/Multiplexer.cs
===================================================================
--- System.Xml.Xsl/Multiplexer.cs	(revision 42365)
+++ System.Xml.Xsl/Multiplexer.cs	(working copy)
@@ -45,13 +45,20 @@
 		XslTransformImpl impl;
 
 		#region Constructors
+#if TARGET_JVM
 		public XslTransform ()
 		{
+			impl = new ManagedXslTransform ();
+		}
+#else
+		public XslTransform ()
+		{
 			if (Environment.GetEnvironmentVariable ("MONO_UNMANAGED_XSLT") == null)
 				impl = new ManagedXslTransform ();
 			else
 				impl = new UnmanagedXslTransform ();
 		}
+#endif
 		#endregion
 		
 		[MonoTODO ("Security check.")]
