Index: postgresql.html
===================================================================
--- postgresql.html	(revision 36405)
+++ postgresql.html	(working copy)
@@ -106,7 +106,7 @@
 
 	<li>There is another .NET data provider for PostgreSQL named <a href="http://sourceforge.net/projects/pgsqlclient/">PgSqlClient</a>, but I do not know if it works with Mono.</li>
 
-	<li>If none of the above providers meet your needs.  There is the ODBC and OLEDB providers included with Mono.</li>
+	<li>If none of the above providers meet your needs.  There are the ODBC and OLEDB providers included with Mono.</li>
 
 	<li>Bugs with Mono or the data provider should be reported
 	in Mono's Bugzilla <a href="http://bugzilla.ximian.com/">here</a>.  If you
@@ -126,6 +126,7 @@
 		<ul>
 			<li>Builds and Runs on both Microsoft .NET and Mono.</li>
 			<li>Works using SQL# (command-line and Gtk# versions)</li>
+            <li>Can be used with Postgresql 7.x and above</li>
 			<li>You can send insert, update, delete queries
 				through NpgsqlCommand.ExecuteNonQuery() method.</li>
 			<li>You can send queries like, select count(*) from table, select version()
@@ -139,12 +140,39 @@
 NpgsqlEventLog.LogName = "NpgsqlTests.LogFile";   // LogFile.
 </pre>
 
-			<li>You can use Npgsql with Mono (Thanks Kristis Makris). It is not working perfectly.</li>
 			<li>There is a winforms test suite (Thanks Dave Page).</li>
-			<li>Clearer code in NpgsqlConnection removing *magic* numbers and constants. (Thanks Kristis Makris)</li>
 			<li>Better support of ODBC-like ConnectionString in NpgsqlConnection (Thanks Dave Page)</li>
-			<li>Thanks Ulrich Sprick for all discussion and ideas.</li>
-		</ul>
+			<li>You can use parameter names with Npgsql (:) or SqlServer (@) prefix style. This easy porting of
+            code from Sql server to postgresql </li>
+            <li>You can use native large object support</li>
+            
+		
+            <li>Supports the following data types:
+            
+                <ul>
+                    <li> Bigint </li>
+                    <li> Boolean </li>
+                    <li> Box </li>
+                    <li> Bytea </li>
+                    <li> Circle </li>
+                    <li> Date </li>
+                    <li> Double </li>
+                    <li> Integer </li>
+                    <li> Line </li>
+                    <li> LSeg </li>
+                    <li> Money </li>
+                    <li> Numeric </li>
+                    <li> Path </li>
+                    <li> Point </li>
+                    <li> Polygon </li>
+                    <li> Real </li>
+                    <li> Smallint </li>
+                    <li> Text </li>
+                    <li> Time </li>
+                    <li> Timestamp </li>
+                </ul>
+            </li>
+        </ul>
 	</li>
 </ul>
 
@@ -163,19 +191,19 @@
 
 	<li>Any features for Npgsql should be implemented in Npgsql's main cvs repository at
 	gborg.postgresql.org.  Most bugs should be fixed in gborg.postgresql.org's cvs.
-	Only bugs neccessary for building and running of Npgsql	on Mono can be done in Mono cvs,
+	Only bugs neccessary for building and running of Npgsql	on Mono can be done in Mono svn,
 	but once applied they should be sent to Npgsql's mailing list
 	at gborg.postgresql.org for inclusion into cvs there.  Whenever there is
 	a release of Npgsql (determined by Francisco Figueiredo jr. or a release
 	of Mono (determined by Miguel de Icaza), then the Npgsql source
 	in gborg.postgresql.org's cvs will be used to update the Npgsql source in
-	Mono's cvs.
+	Mono's svn.
 	</li>
 
 	<li>Add any missing functionality to Npgsql. If this funtionality works on
 	.NET but not on Mono, implement the missing features or fix the bugs in Mono</li>
 <p>
-	<li>Npgsql has been replaced Mono.Data.PostgreSqlClient as the provider of
+	<li>Npgsql replaced Mono.Data.PostgreSqlClient as the provider of
 	choice to use.  Mono.Data.PostgreSqlClient is deprecated and is no longer included in
 	Mono releases.  Please use Npgsql for PostgreSQL data access.</li>
 
@@ -259,9 +287,11 @@
 mono TestExample.exe
 </pre>
 	</li>
+    <li> More examples can be found in Npgsql Users Manual <a href="http://gborg.postgresql.org/project/npgsql/cvs/co.php/Npgsql/docs/UserManual.htm">here</a>
 </ul>
 
 
+
 <!-- **************************************** -->
 <!--  PostgreSQL Installation Instructions -->
 <!-- **************************************** -->
