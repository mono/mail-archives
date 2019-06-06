--- ChangeLog.orig	Sun May  9 07:59:50 2004
+++ ChangeLog	Sun May  9 07:59:25 2004
@@ -1,3 +1,11 @@
+2004-05-09  Rogerio Pereira Araujo <webmaster@cisnet.com.br>
+
+	* System.Data.OracleClient.Oci/OciDefineHandle.cs: fixed a bug with
+	NUMBER data type when no parameter is passed to OracleCommand. 
+	* System.Data.OracleClient.Oci/OciDefineHandle.cs: changed the Encondig
+	on VARCHAR fields from UTF8 to Default because latin character is 
+	being lost	
+
 2004-04-10  Gonzalo Paniagua Javier <gonzalo@ximian.com>
 
 	* System.Data.OracleClient.Oci/OciDefineHandle.cs: added support for
