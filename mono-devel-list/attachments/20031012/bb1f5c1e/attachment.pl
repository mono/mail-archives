Index: class/System.Web/System.Web/HttpRequest.cs
===================================================================
RCS file: /cvs/public/mcs/class/System.Web/System.Web/HttpRequest.cs,v
retrieving revision 1.32
diff -u -r1.32 HttpRequest.cs
--- class/System.Web/System.Web/HttpRequest.cs	21 Sep 2003 03:37:27 -0000	1.32
+++ class/System.Web/System.Web/HttpRequest.cs	13 Oct 2003 00:30:45 -0000
@@ -837,7 +837,7 @@
 					qs = "?" + qs;
 
 				UriBuilder ub = new UriBuilder (_WorkerRequest.GetProtocol (),
-								_WorkerRequest.GetLocalAddress (),
+								_WorkerRequest.GetServerName (),
 								_WorkerRequest.GetLocalPort (),
 								Path,
 								qs);