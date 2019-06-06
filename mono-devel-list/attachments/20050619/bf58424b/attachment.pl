Index: Novell.Directory.Ldap/Connection.cs
===================================================================
--- Novell.Directory.Ldap/Connection.cs	(revision 45568)
+++ Novell.Directory.Ldap/Connection.cs	(working copy)
@@ -34,8 +34,10 @@
 using Novell.Directory.Ldap.Asn1;
 using Novell.Directory.Ldap.Rfc2251;
 using Novell.Directory.Ldap.Utilclass;
+#if !TARGET_JVM
 using Mono.Security.Protocol.Tls;
 using Mono.Security.X509.Extensions;
+#endif
 using Syscert = System.Security.Cryptography.X509Certificates;
 using System.Security.Cryptography;
 using System.Net;
@@ -43,7 +45,9 @@
 using System.Collections;
 using System.IO;
 using System.Text;
+#if !TARGET_JVM
 using Mono.Security.X509;
+#endif
 using System.Text.RegularExpressions;
 using System.Globalization;
 
@@ -682,6 +686,7 @@
 			{
 				if ((in_Renamed == null) || (out_Renamed == null))
 				{
+#if !TARGET_JVM
 					if(Ssl)
 					{
 						this.host = host;
@@ -704,10 +709,13 @@
 						out_Renamed = (System.IO.Stream) sslstream;
 					}
 					else{
+#endif
 						socket = new System.Net.Sockets.TcpClient(host, port);				
 						in_Renamed = (System.IO.Stream) socket.GetStream();
 						out_Renamed = (System.IO.Stream) socket.GetStream();
+#if !TARGET_JVM
 					}
+#endif
 				}
 				else
 				{
@@ -1113,7 +1121,7 @@
 		/* package */
 		internal void  startTLS()
 		{
-			
+#if !TARGET_JVM			
 			try
 			{
 				waitForReader(null);
@@ -1145,6 +1153,7 @@
 				throw new LdapException("The host is unknown", LdapException.CONNECT_ERROR, null, uhe);
 			}
 			return ;
+#endif
 		}
 		
 		/*
Index: Novell.Directory.Ldap/LdapConnection.cs
===================================================================
--- Novell.Directory.Ldap/LdapConnection.cs	(revision 45568)
+++ Novell.Directory.Ldap/LdapConnection.cs	(working copy)
@@ -34,7 +34,9 @@
 using Novell.Directory.Ldap.Asn1;
 using Novell.Directory.Ldap.Rfc2251;
 using Novell.Directory.Ldap.Utilclass;
+#if !TARGET_JVM
 using Mono.Security.Protocol.Tls;
+#endif
 using System.Security.Cryptography.X509Certificates;
 
 namespace Novell.Directory.Ldap
Index: Novell.Directory.Ldap/AssemblyInfo.cs
===================================================================
--- Novell.Directory.Ldap/AssemblyInfo.cs	(revision 45568)
+++ Novell.Directory.Ldap/AssemblyInfo.cs	(working copy)
@@ -69,6 +69,8 @@
 	[assembly: AssemblyVersion ("1.0.3300.0")]
 #endif
 
+#if (!TARGET_JVM)
 [assembly: AssemblyDelaySign (true)]
 [assembly: AssemblyKeyFile ("../mono.pub")]
+#endif
 
Index: ChangeLog
===================================================================
--- ChangeLog	(revision 45568)
+++ ChangeLog	(working copy)
@@ -1,3 +1,6 @@
+2005-19-06  Boris Kirzner <borisk@mainsoft.com>
+	* Novell.Directory.Ldap/AssemblyInfo.cs, Novell.Directory.Ldap/Connection.cs, Novell.Directory.Ldap/LdapConnection.cs: added ifdef to exclude the code not used in TARGET_JVM.
+
 2005-04-05  Boris Kirzner <borisk@mainsoft.com>
 	* Added Novell.Directory.Ldap.Rfc2251/RfcLdapSuperDN.cs to sources.
 
