Index: HttpRequest.cs
===================================================================
RCS file: /mono/mcs/class/System.Web/System.Web/HttpRequest.cs,v
retrieving revision 1.32
diff -u -b -w -p -u -r1.32 HttpRequest.cs
--- HttpRequest.cs	21 Sep 2003 03:37:27 -0000	1.32
+++ HttpRequest.cs	1 Oct 2003 10:03:43 -0000
@@ -51,6 +51,7 @@ namespace System.Web {
 
 		private HttpWorkerRequest _WorkerRequest;
 		private HttpRequestStream	_oInputStream;
+		private Stream _oRequestFilter;
 		private HttpClientCertificate _ClientCert;
 
 		private HttpValueCollection _oServerVariables;
@@ -527,14 +528,16 @@ namespace System.Web {
 			}
 		}
 
-		[MonoTODO("Use stream filter in the request stream")]
 		public Stream Filter {
 			get {
-				throw new NotImplementedException();
+				if( _oRequestFilter != null )
+					return _oRequestFilter;
+				else
+					return InputStream;
 			}
 
 			set {
-				throw new NotImplementedException();
+				_oRequestFilter = value;
 			}
 		}
 
@@ -814,7 +817,10 @@ namespace System.Web {
 		public int TotalBytes {
 			get {
 				if (_iTotalBytes == -1) {
-					if (null != InputStream) {
+					if (null != _oRequestFilter) {
+						_iTotalBytes = (int) _oRequestFilter.Length;
+					}
+					else if (null != InputStream) {
 						_iTotalBytes = (int) InputStream.Length;
 					} else {
 						_iTotalBytes = 0;
@@ -952,7 +958,12 @@ namespace System.Web {
 
 			byte [] arrData = new byte[iSize];
 			
-			int iRetSize = InputStream.Read(arrData, 0, iSize);
+			int iRetSize =0;
+
+			if( _oRequestFilter != null )
+				iRetSize = _oRequestFilter.Read(arrData, 0, iSize);
+			else
+				iRetSize = InputStream.Read(arrData, 0, iSize);
 			if (iRetSize != iSize) {
 				byte [] tmpData = new byte[iRetSize];
 				if (iRetSize > 0) {
