Index: CapabilitiesLoader.cs
===================================================================
--- CapabilitiesLoader.cs	(revision 45036)
+++ CapabilitiesLoader.cs	(working copy)
@@ -174,7 +174,9 @@
 			lock (typeof (CapabilitiesLoader)) {
 				if (loaded)
 					return;
-
+#if TARGET_J2EE
+				string filepath = "browscap.ini";
+#else
 				string dir = Path.GetDirectoryName (WebConfigurationSettings.MachineConfigPath);
 				string filepath = Path.Combine (dir, "browscap.ini");
 				if (!File.Exists (filepath)) {
@@ -182,7 +184,7 @@
 					dir = Path.GetDirectoryName (dir);
 					filepath = Path.Combine (dir, "browscap.ini");
 				}
-
+#endif
 				try {
 					LoadFile (filepath);
 				} catch (Exception) { }
@@ -190,13 +192,38 @@
 				loaded = true;
 			}
 		}
-
+#if TARGET_J2EE
+	private static TextReader GetJavaTextReader(string filename)
+	{
+		Stream s;
+		try
+		{
+			java.lang.ClassLoader cl = (java.lang.ClassLoader)
+						AppDomain.CurrentDomain.GetData("GH_ContextClassLoader");
+			if (cl == null)
+				return null;
+			java.io.InputStream inputStream = cl.getResourceAsStream(filename);
+			s = (Stream)vmw.common.IOUtils.getStream(inputStream);
+		}
+		catch (Exception e)
+		{
+			return null;
+		}
+		return new StreamReader (s);
+	}
+#endif
 		static void LoadFile (string filename)
 		{
+#if TARGET_J2EE
+			TextReader input = GetJavaTextReader(filename);
+			if(input == null)
+				return;
+#else
 			if (!File.Exists (filename))
 				return;
 
 			TextReader input = new StreamReader (File.OpenRead (filename));
+#endif
 			string str;
 			Hashtable allhash = new Hashtable ();
 			int aux = 0;
@@ -250,6 +277,11 @@
 					defaultCaps = new Hashtable ();
 					defaultCaps.Add ("frames", "True");
 					defaultCaps.Add ("tables", "True");
+#if TARGET_J2EE
+					defaultCaps.Add ("cookies", "True");
+					defaultCaps.Add ("javaapplets", "True");
+					defaultCaps.Add ("javascript", "True");
+#endif
 					return defaultCaps;
 				}
 			}
Index: HttpContext.cs
===================================================================
--- HttpContext.cs	(revision 45036)
+++ HttpContext.cs	(working copy)
@@ -65,6 +65,10 @@
 		string errorPage;
 		IPrincipal user;
 		
+#if TARGET_J2EE
+		private object LOCK = new object();
+#endif
+
 #if NET_2_0
 		private System.Web.UI.Page lastPage;
 #endif
@@ -206,13 +210,33 @@
 			}
 		}
 
+#if TARGET_J2EE
+		public bool IsDebuggingEnabled
+		{
+			get {
+				return false;
+			}
+		}
+#else
 		public bool IsDebuggingEnabled
 		{
 			get {
 				return CompilationConfiguration.GetInstance (this).Debug;
 			}
 		}
+#endif
 
+#if TARGET_J2EE
+		private bool _timedOut;
+		internal bool TimedOut {
+			get {
+				return _timedOut;
+			}
+			set {
+				_timedOut = value;
+			}
+		}
+#endif
 		public IDictionary Items
 		{
 			get {
@@ -284,16 +308,32 @@
 			set { user = value; }
 		}
 
+#if TARGET_J2EE
 		internal bool TimeoutPossible {
-			get { return (Interlocked.CompareExchange (ref timeoutPossible, 1, 1) == 1); }
+			get { return (timeoutPossible==1);}
+		}
+		internal void EndTimeoutPossible () {
+			timeoutPossible = 0;
+		}
+		internal void TryWaitForTimeout () {
+			while (TimeoutPossible) {
+				Thread.Sleep (500);
+			}
 		}
+#endif
 		
+#if !TARGET_J2EE
+		internal bool TimeoutPossible {
+			get { return (Interlocked.CompareExchange (ref timeoutPossible, 1, 1) == 1); }
+		}
+#endif
 		internal void BeginTimeoutPossible ()
 		{
 			timeoutPossible = 1;
 			timeoutBegin = DateTime.UtcNow.Ticks;
 		}
 
+#if !TARGET_J2EE
 		internal void EndTimeoutPossible ()
 		{
 			Interlocked.CompareExchange (ref timeoutPossible, 0, 1);
@@ -305,6 +345,7 @@
 				Thread.Sleep (500);
 			}
 		}
+#endif
 
 		internal bool CheckIfTimeout (DateTime dt)
 		{
Index: HttpResponse.cs
===================================================================
--- HttpResponse.cs	(revision 45036)
+++ HttpResponse.cs	(working copy)
@@ -113,6 +113,12 @@
 			 _WorkerRequest = WorkerRequest;
 		}
 
+#if TARGET_J2EE
+	public HttpWorkerRequest WorkerRequest{
+		get{ return _WorkerRequest; }
+	}
+#endif
+
 		internal void InitializeWriter ()
 		{
 			// We cannot do this in the .ctor because HttpWriter uses configuration and
@@ -156,6 +162,8 @@
 			ArrayList oHeaders = new ArrayList (_Headers);
 
 			oHeaders.Add (new HttpResponseHeader ("X-Powered-By", "Mono"));
+
+#if !TARGET_J2EE
 			string date = DateTime.UtcNow.ToString ("ddd, d MMM yyyy HH:mm:ss ", CultureInfo.InvariantCulture);
 			HttpResponseHeader date_header = new HttpResponseHeader ("Date", date + "GMT");
 			oHeaders.Add (date_header);
@@ -167,6 +175,7 @@
 				oHeaders.Add (new HttpResponseHeader (HttpWorkerRequest.HeaderContentLength,
 								      _lContentLength.ToString ()));
 			}
+#endif
 
 			// Apache2 only auto-adds 'charset=blah' for text/plain and text/html
 			if (_sContentType != null) {
@@ -229,7 +238,11 @@
 			foreach (HttpResponseHeader oHeader in oHeaders)
 				oHeader.SendContent (_WorkerRequest);
 			
+#if !TARGET_J2EE //in J2EE env. we are setting headers into
+                //HttpServletResponse instance -> headers are
+                //still not sent
 			_bHeadersSent = true;
+#endif
 		}
 
 		public string Status
@@ -736,7 +749,11 @@
 				return;
 
 			if (_Context.TimeoutPossible)
+#if !TARGET_J2EE
 				Thread.CurrentThread.Abort (new StepCompleteRequest ());
+#else
+				throw new vmw.@internal.j2ee.StopExecutionException();
+#endif
 
 			Flush ();
 			_bEnded = true;
@@ -971,6 +988,11 @@
 
 		public void WriteFile (string filename, bool readIntoMemory)
 		{
+#if TARGET_J2EE
+			if ((this.Request != null) && ((filename.Length <= 2)
+					|| ((filename[0] != '\\') && (filename[1] != ':'))))
+				filename = Request.MapPath(filename);
+#endif
 			FileStream fs = null;
 			try {
 				fs = File.OpenRead (filename);
@@ -989,6 +1011,11 @@
 		public void WriteFile (string filename, long offset, long size)
 		{
 			FileStream fs = null;
+#if TARGET_J2EE
+			if ((this.Request != null) && ((filename.Length <= 2)
+				|| ((filename[0] != '\\') && (filename[1] != ':'))))
+				filename = Request.MapPath(filename);
+#endif
 			try {
 				fs = File.OpenRead (filename);
 				WriteFromStream (fs, offset, size, 30702);
@@ -1013,6 +1040,9 @@
 		[MonoTODO()]
 		internal void OnCookieAdd (HttpCookie cookie)
 		{
+#if TARGET_J2EE	//naive implementation
+			Request.Cookies.Add(cookie);
+#endif
 		}
 
 		[MonoTODO("Do we need this?")]
Index: HttpException.cs
===================================================================
--- HttpException.cs	(revision 45036)
+++ HttpException.cs	(working copy)
@@ -34,8 +34,10 @@
 using System.Runtime.Serialization;
 using System.Runtime.InteropServices;
 using System.Text;
-using System.Web.Compilation;
 using System.Web.Util;
+#if !TARGET_J2EE
+using System.Web.Compilation;
+#endif
 
 namespace System.Web
 {
@@ -133,11 +135,17 @@
 				builder.Append ("<table summary=\"Stack Trace\" width=\"100%\" " +
 						"bgcolor=\"#ffffc\">\r\n<tr><td>");
 				WriteTextAsCode (builder, InnerException.ToString ());
+#if TARGET_J2EE //Required, because toString of Java doesn't print stackTrace
+				WriteTextAsCode (builder, InnerException.StackTrace);
+#endif
 				builder.Append ("</td></tr>\r\n</table>\r\n<p>\r\n");
 			}
 
 			builder.Append ("<hr>\r\n</body>\r\n</html>\r\n");
 			builder.AppendFormat ("<!--\r\n{0}\r\n-->\r\n", HttpUtility.HtmlEncode (this.ToString ()));
+#if TARGET_J2EE //Required, because toString of Java doesn't print stackTrace
+			builder.AppendFormat ("<!--\r\n{0}\r\n-->\r\n", HttpUtility.HtmlEncode (this.StackTrace));
+#endif
 
 			return builder.ToString ();
 		}
@@ -150,7 +158,44 @@
 			string res = HttpUtility.HtmlEncode (s);
 			return res.Replace ("\r\n", "<br />");
 		}
+#if TARGET_J2EE
+		string GetHtmlizedErrorMessage ()
+		{
+			StringBuilder builder = new StringBuilder ("<html>\r\n<title>");
+			HtmlizedException exc = (HtmlizedException) this.InnerException;
+			builder.Append (exc.Title);
+			builder.AppendFormat ("</title><body bgcolor=\"white\">" +
+					      "<h1><font color=\"red\">Server Error in '{0}' " +
+					      "Application</font></h1><hr>\r\n",
+					      HttpRuntime.AppDomainAppVirtualPath);
 		
+			builder.AppendFormat ("<h2><font color=\"maroon\"><i>{0}</i></font></h2>\r\n", exc.Title);
+			builder.AppendFormat ("<b>Description: </b>{0}\r\n<p>\r\n", HtmlEncode (exc.Description));
+			builder.AppendFormat ("<b>Error message: </b>{0}\r\n<p>\r\n", HtmlEncode (exc.ErrorMessage));
+
+			if (exc.FileName != null)
+				builder.AppendFormat ("<b>File name: </b> {0}", HtmlEncode (exc.FileName));
+
+			if (exc.FileText != null) {
+				if (exc.SourceFile != exc.FileName)
+					builder.AppendFormat ("<p><b>Source File: </b>{0}", exc.SourceFile);
+
+				builder.Append ("\r\n<p>\r\n");
+
+				builder.Append ("<table summary=\"Source file\" width=\"100%\" " +
+							"bgcolor=\"#ffffc\">\r\n<tr><td>");
+					WriteSource (builder, exc);
+					builder.Append ("</td></tr>\r\n</table>\r\n<p>\r\n");
+			}
+
+			builder.Append ("<hr>\r\n</body>\r\n</html>\r\n");
+			builder.AppendFormat ("<!--\r\n{0}\r\n-->\r\n", HtmlEncode (exc.ToString ()));
+			builder.AppendFormat ("<!--\r\n{0}\r\n-->\r\n", HtmlEncode (exc.StackTrace));
+			return builder.ToString ();
+		}
+#endif
+
+#if !TARGET_J2EE
 		string GetHtmlizedErrorMessage ()
 		{
 			StringBuilder builder = new StringBuilder ("<html>\r\n<title>");
@@ -197,7 +242,7 @@
 			builder.AppendFormat ("<!--\r\n{0}\r\n-->\r\n", HtmlEncode (exc.ToString ()));
 			return builder.ToString ();
 		}
-
+#endif
 		static void WriteTextAsCode (StringBuilder builder, string text)
 		{
 			builder.Append ("<code><pre>\r\n");
@@ -205,6 +250,17 @@
 			builder.Append ("</pre></code>\r\n");
 		}
 
+#if TARGET_J2EE
+		static void WriteSource (StringBuilder builder, HtmlizedException e)
+		{
+			builder.Append ("<code><pre>");
+			WritePageSource (builder, e);
+			builder.Append ("</pre></code>\r\n");
+		}
+
+#endif
+
+#if !TARGET_J2EE
 		static void WriteSource (StringBuilder builder, HtmlizedException e)
 		{
 			builder.Append ("<code><pre>");
@@ -215,6 +271,7 @@
 
 			builder.Append ("</pre></code>\r\n");
 		}
+#endif
 		
 		static void WriteCompilationSource (StringBuilder builder, HtmlizedException e)
 		{
Index: HttpRuntime.cs
===================================================================
--- HttpRuntime.cs	(revision 45036)
+++ HttpRuntime.cs	(working copy)
@@ -51,7 +51,26 @@
 		private static IStackWalk unrestrictedStackWalk;
 		private static IStackWalk reflectionStackWalk;
 
+#if !TARGET_JVM
 		private static HttpRuntime _runtime;
+#else		
+		private static object _ghLock = new object(); 
+		static private HttpRuntime _runtime {
+			get {
+				HttpRuntime runtime = (HttpRuntime)AppDomain.CurrentDomain.GetData("HttpRuntime");
+				if (runtime == null)
+					lock (_ghLock) {
+						runtime = (HttpRuntime)AppDomain.CurrentDomain.GetData("HttpRuntime");
+						if (runtime == null) {
+							runtime = new HttpRuntime();
+							runtime.Init();
+							AppDomain.CurrentDomain.SetData("HttpRuntime", runtime);
+						}
+					}
+				return runtime;
+			}
+		}
+#endif
 		private static string appDomainAppId;
 		private static string appDomainId;
 		private static string appDomainAppPath;
@@ -73,11 +92,13 @@
 		private WaitCallback doRequestCallback;
 		private int pendingCallbacks;
 
+#if !TARGET_JVM
 		static HttpRuntime ()
 		{
 			_runtime = new HttpRuntime ();
 			_runtime.Init();
 		}
+#endif
 
 		public HttpRuntime ()
 		{
@@ -253,9 +274,11 @@
 			WaitForRequests (2000);
 			queueManager.Dispose (); // Send a 503 to all queued requests
 			queueManager = null;
-			
 			_cache = null;
-			HttpApplicationFactory.EndApplication ();
+#if TARGET_JVM
+			_cache.Destroy();
+#endif
+			HttpApplicationFactory.EndApplication();
 		}
 
 		void OnDomainUnload (object o, EventArgs args)
@@ -374,7 +397,9 @@
 
 		public static string AppDomainAppId {
 			get {
+#if !TARGET_JVM				
 				if (appDomainAppId == null)
+#endif				
 					appDomainAppId = (string) AppDomain.CurrentDomain.GetData (".appId");
 
 				return appDomainAppId;
@@ -383,7 +408,9 @@
 
 		public static string AppDomainAppPath {
 			get {
+#if !TARGET_JVM				
 				if (appDomainAppPath == null)
+#endif				
 					appDomainAppPath = (string) AppDomain.CurrentDomain.GetData (".appPath");
 
 				return appDomainAppPath;
@@ -392,7 +419,9 @@
 
 		public static string AppDomainAppVirtualPath {
 			get {
+#if !TARGET_JVM				
 				if (appDomainAppVirtualPath == null)
+#endif				
 					appDomainAppVirtualPath = (string) AppDomain.CurrentDomain.GetData (".appVPath");
 
 				return appDomainAppVirtualPath;
@@ -401,7 +430,9 @@
 
 		public static string AppDomainId {
 			get {
+#if !TARGET_JVM				
 				if (appDomainId == null)
+#endif				
 					appDomainId = (string) AppDomain.CurrentDomain.GetData (".domainId");
 
 				return appDomainId;
Index: HttpRequest.cs
===================================================================
--- HttpRequest.cs	(revision 45036)
+++ HttpRequest.cs	(working copy)
@@ -38,6 +38,10 @@
 using System.Web.Configuration;
 using System.Web.Util;
 
+#if TARGET_J2EE
+using vmw.common;
+#endif
+
 namespace System.Web {
 	[MonoTODO("Review security in all path access function")]
 	public sealed class HttpRequest {
@@ -98,6 +102,9 @@
 		bool checkedQueryString;
 #endif
 
+#if TARGET_J2EE
+		private string _sGhFilePath;
+#endif
 		public HttpRequest(string Filename, string Url, string Querystring) {
 			_iContentLength = -1;
 			_iTotalBytes = -1;
@@ -574,6 +581,25 @@
 			}
 		}
 
+#if TARGET_J2EE
+		internal string GhFilePath {
+			get {
+				if (null == _sGhFilePath) {
+					_sGhFilePath = FilePath;
+					if (_sGhFilePath == null)
+						return null;
+
+					if (_sGhFilePath.StartsWith(IAppDomainConfig.WAR_ROOT_SYMBOL))
+						_sGhFilePath = _sGhFilePath.Substring(IAppDomainConfig.WAR_ROOT_SYMBOL.Length);
+					if (_sGhFilePath.StartsWith(HttpRuntime.AppDomainAppVirtualPath))
+						_sGhFilePath = _sGhFilePath.Substring(HttpRuntime.AppDomainAppVirtualPath.Length);
+				}
+
+				return _sGhFilePath;
+			}
+		}
+#endif
+
 		HttpFileCollection files;
 		public HttpFileCollection Files {
 			get {
@@ -1116,6 +1142,15 @@
 			if (_WorkerRequest == null)
 				throw new HttpException ("No HttpWorkerRequest!!!");
 
+#if TARGET_J2EE
+			if (baseVirtualDir.Equals(BaseVirtualDir))
+			{
+				string val =  System.Web.GH.PageMapper.GetFromMapPathCache(virtualPath);
+				if (val != null)
+					return val;
+			}
+#endif
+
 			if (virtualPath == null || virtualPath.Length == 0)
 				virtualPath = ".";
 			else
@@ -1123,7 +1158,10 @@
 
 			if (virtualPath.IndexOf (':') != -1)
 				throw new ArgumentException ("Invalid path -> " + virtualPath);
-
+#if TARGET_J2EE
+			if (virtualPath.StartsWith(IAppDomainConfig.WAR_ROOT_SYMBOL))
+				return 	virtualPath;
+#endif
 			if (System.IO.Path.DirectorySeparatorChar != '/')
 				virtualPath = virtualPath.Replace (System.IO.Path.DirectorySeparatorChar, '/');
 
Index: HttpApplicationFactory.cs
===================================================================
--- HttpApplicationFactory.cs	(revision 45036)
+++ HttpApplicationFactory.cs	(working copy)
@@ -34,8 +34,13 @@
 using System.IO;
 using System.Reflection;
 using System.Web.UI;
-using System.Web.Compilation;
 using System.Web.SessionState;
+#if !TARGET_J2EE
+using System.Web.Compilation;
+#else
+using System.Web.Configuration;
+using vmw.common;
+#endif
 
 namespace System.Web {
 	class HttpApplicationFactory {
@@ -57,8 +62,20 @@
 
 		static IHttpHandler custApplication;
 
+#if TARGET_J2EE
+		static private HttpApplicationFactory s_Factory {
+					get {
+						HttpApplicationFactory factory = (HttpApplicationFactory)AppDomain.CurrentDomain.GetData("HttpApplicationFactory");
+						if (factory == null) {
+							factory = new HttpApplicationFactory();
+							AppDomain.CurrentDomain.SetData("HttpApplicationFactory", factory);
+						}
+						return factory;
+					}
+		}
+#else
 		static private HttpApplicationFactory s_Factory = new HttpApplicationFactory();
-
+#endif
 		public HttpApplicationFactory() {
 			_appInitialized = false;
 			_appFiredEnd = false;
@@ -76,7 +93,25 @@
 
 			return Path.Combine (physicalAppPath, "global.asax");
 		}
+#if TARGET_J2EE
+		void CompileApp(HttpContext context)
+		{
+
+			try
+			{
+				String url = IAppDomainConfig.WAR_ROOT_SYMBOL+"/global.asax";
+				_appType = System.Web.GH.PageMapper.GetObjectType(url);
+			}
+			catch (Exception e)
+			{
+				_appType = typeof (System.Web.HttpApplication);
+			}
+			_state = new HttpApplicationState ();
+
+		}
+#endif
 
+#if !TARGET_J2EE
 		void CompileApp (HttpContext context)
 		{
 			if (File.Exists (_appFilename)) {
@@ -92,6 +127,7 @@
 				_state = new HttpApplicationState ();
 			}
 		}
+#endif
 
 		static bool IsEventHandler (MethodInfo m)
 		{
@@ -333,6 +369,23 @@
 			}
 		}
 
+#if TARGET_J2EE
+		internal HttpApplication GetPublicInstance()
+		{
+			HttpApplication app = null;
+
+			lock (_appFreePublicList)
+			{
+				if (_appFreePublicInstances > 0)
+				{
+					app = (HttpApplication) _appFreePublicList.Pop();
+					_appFreePublicInstances--;
+				}
+			}
+			return app;
+		}
+#endif
+
 		private IHttpHandler GetPublicInstance(HttpContext context) {
 			HttpApplication app = null;
 
@@ -382,6 +435,17 @@
 		}
 		
 		static internal HttpApplicationState ApplicationState {
+#if TARGET_J2EE
+			get {
+				if (null == s_Factory._state) {
+					HttpStaticObjectsCollection app = null;
+					HttpStaticObjectsCollection ses = null;
+					s_Factory._state = new HttpApplicationState (app, ses);
+				}
+
+				return s_Factory._state;
+			}
+#else
 			get {
 				if (null == s_Factory._state) {
 					HttpStaticObjectsCollection app = MakeStaticCollection (GlobalAsaxCompiler.ApplicationObjects);
@@ -391,6 +455,7 @@
 
 				return s_Factory._state;
 			}
+#endif
 		}
 
 		internal static void EndApplication() {
Index: HttpUtility.cs
===================================================================
--- HttpUtility.cs	(revision 45036)
+++ HttpUtility.cs	(working copy)
@@ -329,7 +329,39 @@
 		{
 			output.Write(HtmlAttributeEncode(s));
 		}
+#if TARGET_J2EE //performance optimization
+		public static string HtmlAttributeEncode (string s)
+		{
+			if (null == s)
+				return null;
+
+			if (s.IndexOf ('&') == -1 && s.IndexOf ('"') == -1)
+				return s;
+
+			StringBuilder output = new StringBuilder (s);
+			for (int i = 0 ; i < output.Length ; i++)
+			{
+				char c = output[i];
+				switch (c)
+				{
+					case '&' :
+						output.Remove(i,1);
+						output.Insert (i,"&amp;");
+						i+=4;
+						break;
+					case '\"' :
+						output.Remove(i,1);
+						output.Insert (i,"&quot;");
+						i+=5;
+						break;
+				}
+			}
+
+			return output.ToString();
+		}
+#endif
 	
+#if !TARGET_J2EE
 		public static string HtmlAttributeEncode (string s) 
 		{
 			if (null == s) 
@@ -354,7 +386,7 @@
 	
 			return output.ToString();
 		}
-	
+#endif
 		public static string UrlDecode (string str) 
 		{
 			return UrlDecode(str, Encoding.UTF8);
Index: HttpApplication.cs
===================================================================
--- HttpApplication.cs	(revision 45036)
+++ HttpApplication.cs	(working copy)
@@ -1056,7 +1056,11 @@
 			internal void Start ()
 			{
 				Reset ();
+#if !TARGET_J2EE
 				ExecuteNextAsync (null);
+#else
+				ExecuteNext(null);
+#endif
 			}
 
 			internal void ExecuteNextAsync (Exception lasterror)
@@ -1131,6 +1135,37 @@
 				ExecuteNext ((Exception) obj);
 			}
 
+#if TARGET_J2EE
+			private Exception HandleJavaException(Exception obj)
+			{
+				Exception lasterror = null;
+
+				if (obj is System.Reflection.TargetInvocationException ) 
+				{
+					lasterror = obj.InnerException;
+#if DEBUG
+					if (lasterror is java.lang.reflect.InvocationTargetException) {
+						Console.WriteLine("Got java.lang.reflect.InvocationTargetException caused by");
+						java.lang.reflect.InvocationTargetException e1 = (java.lang.reflect.InvocationTargetException)lasterror;
+						Console.WriteLine("{0},{1}", e1.getTargetException().GetType(), e1.getTargetException().Message);
+						Console.WriteLine(e1.getTargetException().StackTrace);
+					} else
+#endif
+					if (lasterror is vmw.@internal.j2ee.StopExecutionException) 
+					{
+						lasterror = null;
+						_app.CompleteRequest ();
+					}
+#if DEBUG
+					else {
+						Console.WriteLine("Error 1!!! {0}:{1}", lasterror.GetType(), lasterror.Message);
+						Console.WriteLine(lasterror.StackTrace);
+					}
+#endif				
+				}
+				return lasterror;
+			}
+#endif
 			private Exception ExecuteState (IStateHandler state, ref bool readysync)
 			{
 				Exception lasterror = null;
@@ -1146,13 +1181,23 @@
 							_app.Context.EndTimeoutPossible ();
 						}
 					}
-
+#if TARGET_J2EE		//Catch case of aborting by timeout
+					if (_app.Context.TimedOut) {
+						_app.CompleteRequest ();
+						return null;
+					}
+#endif
 					if (state.PossibleToTimeout) {
 						// Async Execute
 						_app.Context.TryWaitForTimeout ();
 					}
 
 					readysync = state.CompletedSynchronously;
+#if TARGET_J2EE		// Finishing execution for End without error
+				}catch (vmw.@internal.j2ee.StopExecutionException){
+					lasterror = null;
+					_app.CompleteRequest ();
+#endif
 				} catch (ThreadAbortException obj) {
 					object o = obj.ExceptionState;
 					Type type = (o != null) ? o.GetType () : null;
@@ -1165,7 +1210,11 @@
 						_app.CompleteRequest ();
 					}
 				} catch (Exception obj) {
+#if TARGET_J2EE
+					lasterror = HandleJavaException(obj);
+#else
 					lasterror = obj;
+#endif
 				}
 
 				return lasterror;
@@ -1203,10 +1252,16 @@
 
 #region Constructor
 
+#if TARGET_J2EE
+		public HttpApplication ()
+		{
+		}
+#else
 		public HttpApplication ()
 		{
 			assemblyLocation = GetType ().Assembly.Location;
 		}
+#endif
 
 #endregion
 
@@ -1341,7 +1396,14 @@
 			HttpContext.Context = _savedContext;
 			RestorePrincipal ();
 		}
-
+#if TARGET_J2EE
+		internal void SetPrincipal (IPrincipal principal)
+		{
+		}
+		internal void RestorePrincipal ()
+		{
+		}
+#else
 		internal void SetPrincipal (IPrincipal principal)
 		{
 			// Don't overwrite _savedUser if called from inside a step
@@ -1359,7 +1421,7 @@
 			Thread.CurrentPrincipal = _savedUser;
 			_savedUser = null;
 		}
-
+#endif
 		internal void ClearError ()
 		{
 			_lastError = null;
@@ -1583,6 +1645,14 @@
 		[Browsable (false)]
 		[DesignerSerializationVisibility (DesignerSerializationVisibility.Hidden)]
 		public HttpSessionState Session {
+#if TARGET_J2EE
+			get {
+				if (null != _Context && null != _Context.Session)
+					return _Context.Session;
+
+				throw new HttpException ("Failed to get session object");
+			}
+#else
 			get {
 				if (null != _Session)
 					return _Session;
@@ -1592,6 +1662,7 @@
 
 				throw new HttpException ("Failed to get session object");
 			}
+#endif
 		}
 
 		[Browsable (false)]
