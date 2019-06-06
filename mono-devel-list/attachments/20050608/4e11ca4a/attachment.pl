Index: ChangeLog
===================================================================
--- ChangeLog	(revision 45568)
+++ ChangeLog	(working copy)
@@ -1,3 +1,9 @@
+2005-06-08 Ilya Kharmatsky <ilyak-at-mainsoft.com>
+
+    * SmtpMail.cs: Added TARGET_JVM directive in Send method,
+    where we will use in J2EE configuration the "native" java
+    support for obtaining the network address of localhost.
+    
 2005-04-20 Gonzalo Paniagua Javier <gonzalo@ximian.com>
 
 	* SmtpClient.cs:
Index: SmtpMail.cs
===================================================================
--- SmtpMail.cs	(revision 45614)
+++ SmtpMail.cs	(working copy)
@@ -64,7 +64,17 @@
 			// access to properties and to add some functionality
 			MailMessageWrapper messageWrapper = new MailMessageWrapper( message );
 			
+#if TARGET_JVM
+			string currentSmtpServer = smtpServer;
+			if (currentSmtpServer == "localhost")
+			{
+				java.net.InetAddress address = java.net.InetAddress.getLocalHost();
+				currentSmtpServer = address.getHostAddress();
+			}
+			SmtpClient smtp = new SmtpClient (currentSmtpServer);
+#else
 			SmtpClient smtp = new SmtpClient (smtpServer);
+#endif
 			
 			smtp.Send (messageWrapper);
 		       
