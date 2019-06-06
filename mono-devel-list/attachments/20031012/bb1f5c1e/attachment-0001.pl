Index: server/MonoWorkerRequest.cs
===================================================================
RCS file: /mono/xsp/server/MonoWorkerRequest.cs,v
retrieving revision 1.19
diff -u -r1.19 MonoWorkerRequest.cs
--- server/MonoWorkerRequest.cs	3 Oct 2003 18:51:34 -0000	1.19
+++ server/MonoWorkerRequest.cs	13 Oct 2003 00:19:02 -0000
@@ -161,6 +161,28 @@
 		{
 			return "localhost";
 		}
+		public override string GetServerName ()
+		{
+			string hostHeader = GetKnownRequestHeader(HeaderHost);
+			if (hostHeader == null || hostHeader.Length == 0)
+			{
+				hostHeader = GetLocalAddress();
+			}
+			else
+			{
+				int colonIndex = hostHeader.IndexOf(':');
+				if (colonIndex > 0)
+				{
+					hostHeader = hostHeader.Substring(0, colonIndex);
+				}
+				else if (colonIndex == 0)
+				{
+					hostHeader = GetLocalAddress();
+				}
+			}
+			return hostHeader;
+		}
+
 
 		public override int GetLocalPort ()
 		{
Index: server/XSPApplicationHost.cs
===================================================================
RCS file: /mono/xsp/server/XSPApplicationHost.cs,v
retrieving revision 1.18
diff -u -r1.18 XSPApplicationHost.cs
--- server/XSPApplicationHost.cs	9 Oct 2003 20:32:54 -0000	1.18
+++ server/XSPApplicationHost.cs	13 Oct 2003 00:19:02 -0000
@@ -241,7 +241,7 @@
 			while (!stop){
 				client = listen_socket.Accept ();
 				WebTrace.WriteLine ("Accepted connection.");
-				Worker worker = new Worker (client, listen_socket.LocalEndPoint, this);
+				Worker worker = new Worker (client, client.LocalEndPoint, this);
 				ThreadPool.QueueUserWorkItem (new WaitCallback (worker.Run));
 			}
 
Index: server/XSPWorkerRequest.cs
===================================================================
RCS file: /mono/xsp/server/XSPWorkerRequest.cs,v
retrieving revision 1.26
diff -u -r1.26 XSPWorkerRequest.cs
--- server/XSPWorkerRequest.cs	9 Oct 2003 20:32:54 -0000	1.26
+++ server/XSPWorkerRequest.cs	13 Oct 2003 00:19:03 -0000
@@ -124,25 +124,8 @@
 			response = new MemoryStream ();
 			status = "HTTP/1.0 200 OK\r\n";
 			
-			int i = -1;
-			string url = GetKnownRequestHeader (HeaderHost);
-			if (url != null)
-				i = url.LastIndexOf (":");
-
-			if (i == -1) {
-				localPort = 80;
-				localAddress = url;
-			} else {
-				try {
-					localPort = int.Parse (url.Substring (i+1));
-				} catch {
-					// May be we should send a 50x error?
-
-					localPort = 80;
-				}
-
-				localAddress = url.Substring (0, i);
-			}
+			localPort = ((IPEndPoint) localEP).Port;
+			localAddress = ((IPEndPoint) localEP).Address.ToString();
 		}
 
 		void FillBuffer ()
@@ -395,12 +378,6 @@
 			return ((IPEndPoint) remoteEP).Port;
 		}
 
-
-		public override string GetServerName ()
-		{
-			WebTrace.WriteLine ("GetServerName()");
-			return "localhost";
-		}
 
 		public override string GetServerVariable (string name)
 		{