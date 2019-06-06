Update of /cvs/public/mcs/class/corlib/Test/System.IO
In directory mono-cvs.ximian.com:/tmp/cvs-serv567

Modified Files:
	ChangeLog FileSystemInfoTest.cs 
Log Message:
2003-06-18  Nick Drochak <ndrochak@gol.com>

	* FileSystemInfoTest.cs: Works on .NET 1.1 now. If these values are
	different on 1.0 then we need to wrap with a #if NET_1_1.
		


Index: ChangeLog
===================================================================
RCS file: /cvs/public/mcs/class/corlib/Test/System.IO/ChangeLog,v
retrieving revision 1.71
retrieving revision 1.72
diff -u -d -r1.71 -r1.72
--- ChangeLog	12 Jun 2003 08:43:33 -0000	1.71
+++ ChangeLog	18 Jun 2003 03:09:41 -0000	1.72
@@ -1,3 +1,8 @@
+2003-06-18  Nick Drochak <ndrochak@gol.com>
+
+	* FileSystemInfoTest.cs: Works on .NET 1.1 now. If these values are
+	different on 1.0 then we need to wrap with a #if NET_1_1.
+
 2003-06-12  Zoltan Varga  <vargaz@freemail.hu>
 
 	* FileStreamTest.cs: New tests for recently fixed bugs.

Index: FileSystemInfoTest.cs
===================================================================
RCS file: /cvs/public/mcs/class/corlib/Test/System.IO/FileSystemInfoTest.cs,v
retrieving revision 1.4
retrieving revision 1.5
diff -u -d -r1.4 -r1.5
--- FileSystemInfoTest.cs	29 May 2003 15:09:51 -0000	1.4
+++ FileSystemInfoTest.cs	18 Jun 2003 03:09:41 -0000	1.5
@@ -148,7 +148,7 @@
 				AssertEquals ("test#01", 1601, time.Year);
 				AssertEquals ("test#02", 1, time.Month);
 				AssertEquals ("test#03", 1, time.Day);
-				AssertEquals ("test#04", 2, time.Hour);
+				AssertEquals ("test#04", 9, time.Hour);
 				AssertEquals ("test#05", 0, time.Minute);
 				AssertEquals ("test#06", 0, time.Second);
 				AssertEquals ("test#07", 0, time.Millisecond);
@@ -159,7 +159,7 @@
 				AssertEquals ("test#08", 1601, time.Year);
 				AssertEquals ("test#09", 1, time.Month);
 				AssertEquals ("test#10", 1, time.Day);
-				AssertEquals ("test#11", 2, time.Hour);
+				AssertEquals ("test#11", 9, time.Hour);
 				AssertEquals ("test#12", 0, time.Minute);
 				AssertEquals ("test#13", 0, time.Second);
 				AssertEquals ("test#14", 0, time.Millisecond);
@@ -197,7 +197,7 @@
 				AssertEquals ("test#01", 1601, time.Year);
 				AssertEquals ("test#02", 1, time.Month);
 				AssertEquals ("test#03", 1, time.Day);
-				AssertEquals ("test#04", 2, time.Hour);
+				AssertEquals ("test#04", 9, time.Hour);
 				AssertEquals ("test#05", 0, time.Minute);
 				AssertEquals ("test#06", 0, time.Second);
 				AssertEquals ("test#07", 0, time.Millisecond);
@@ -263,7 +263,7 @@
 				AssertEquals ("test#01", 1601, time.Year);
 				AssertEquals ("test#02", 1, time.Month);
 				AssertEquals ("test#03", 1, time.Day);
-				AssertEquals ("test#04", 2, time.Hour);
+				AssertEquals ("test#04", 9, time.Hour);
 				AssertEquals ("test#05", 0, time.Minute);
 				AssertEquals ("test#06", 0, time.Second);
 				AssertEquals ("test#07", 0, time.Millisecond);

_______________________________________________
Mono-patches maillist  -  Mono-patches@ximian.com
http://lists.ximian.com/mailman/listinfo/mono-patches