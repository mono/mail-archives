Index: ChangeLog
===================================================================
--- ChangeLog	(revision 137766)
+++ ChangeLog	(working copy)
@@ -1,3 +1,11 @@
+2009-07-13  Carlo Kok  <ck@remobjects.com>
+
+	* Mono.Cecil.Binary/ImageWriter.cs
+	* Mono.Cecil.Metadata/MetadataWriter.cs
+	* Mono.Cecil/AssemblyFactory.cs
+	* Mono.Cecil/AssemblyInfo.cs: Support for properly writing 4.0 dlls.
+
+
 2009-06-05  Jb Evain  <jbevain@novell.com>
 
 	* Mono.Cecil/BaseAssemblyResolver.cs: properly look for the 4.0 corlib
Index: Mono.Cecil.Binary/ImageWriter.cs
===================================================================
--- Mono.Cecil.Binary/ImageWriter.cs	(revision 137766)
+++ Mono.Cecil.Binary/ImageWriter.cs	(working copy)
@@ -317,7 +317,7 @@
 		{
 			m_textWriter.Write (header.Cb);
 
-			if (m_mdWriter.TargetRuntime == TargetRuntime.NET_2_0) {
+			if (m_mdWriter.TargetRuntime >= TargetRuntime.NET_2_0) {
 				m_textWriter.Write ((ushort) 2);
 				m_textWriter.Write ((ushort) 5);
 			} else {
Index: Mono.Cecil.Metadata/MetadataWriter.cs
===================================================================
--- Mono.Cecil.Metadata/MetadataWriter.cs	(revision 137766)
+++ Mono.Cecil.Metadata/MetadataWriter.cs	(working copy)
@@ -465,6 +465,7 @@
 				heap.MajorVersion = 1;
 				heap.MinorVersion = 0;
 				break;
+			case TargetRuntime.NET_4_0 :
 			case TargetRuntime.NET_2_0 :
 				heap.MajorVersion = 2;
 				heap.MinorVersion = 0;
Index: Mono.Cecil/AssemblyFactory.cs
===================================================================
--- Mono.Cecil/AssemblyFactory.cs	(revision 137766)
+++ Mono.Cecil/AssemblyFactory.cs	(working copy)
@@ -93,10 +93,12 @@
 		static TargetRuntime CurrentRuntime ()
 		{
 			Version corlib = typeof (object).Assembly.GetName ().Version;
-			if (corlib.Major == 1)
+			if(corlib.Major == 1)
 				return corlib.Minor == 0 ? TargetRuntime.NET_1_0 : TargetRuntime.NET_1_1;
-			else // if (corlib.Major == 2)
+			else if(corlib.Major == 2)
 				return TargetRuntime.NET_2_0;
+			else //if (corlib.Major == 4)
+				return TargetRuntime.NET_4_0;
 		}
 
 		public static AssemblyDefinition DefineAssembly (string name, AssemblyKind kind)