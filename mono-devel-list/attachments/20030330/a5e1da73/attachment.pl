Index: list
===================================================================
RCS file: /mono/mcs/class/System.Web/list,v
retrieving revision 1.42
diff -b -u -2 -r1.42 list
--- list	24 Mar 2003 17:51:25 -0000	1.42
+++ list	30 Mar 2003 14:05:55 -0000
@@ -373,4 +373,6 @@
 System.Web.SessionState/SessionStateModule.cs
 System.Web.SessionState/SessionStateSectionHandler.cs
+System.Web.SessionState/SessionInProcHandler.cs
+System.Web.SessionState/ISessionHandler.cs
 System.Web.Compilation/AspComponentFoundry.cs
 System.Web.Compilation/AspElements.cs
Index: System.Web/HttpContext.cs
===================================================================
RCS file: /mono/mcs/class/System.Web/System.Web/HttpContext.cs,v
retrieving revision 1.13
diff -b -u -2 -r1.13 HttpContext.cs
--- System.Web/HttpContext.cs	18 Mar 2003 01:55:24 -0000	1.13
+++ System.Web/HttpContext.cs	30 Mar 2003 14:05:56 -0000
@@ -25,4 +25,5 @@
 		private HttpServerUtility _Server;
 		private HttpApplication _oApplication;
+		private HttpSessionState _oSession;
 		private HttpWorkerRequest _oWorkerRequest;
 		private IHttpHandler _Handler;
@@ -202,5 +203,9 @@
 		{
 			get {
-				return (HttpSessionState) Items ["sessionstate"];
+				return (HttpSessionState) _oSession;
+			}
+
+			set {
+				_oSession=value;
 			}
 		}
Index: System.Web.SessionState/HttpSessionState.cs
===================================================================
RCS file: /mono/mcs/class/System.Web/System.Web.SessionState/HttpSessionState.cs,v
retrieving revision 1.6
diff -b -u -2 -r1.6 HttpSessionState.cs
--- System.Web.SessionState/HttpSessionState.cs	13 Mar 2003 19:44:44 -0000	1.6
+++ System.Web.SessionState/HttpSessionState.cs	30 Mar 2003 14:05:56 -0000
@@ -81,4 +81,5 @@
 	public bool IsNewSession {
 		get { return _newSession; }
+		set { _newSession=value; }
 	}
 
Index: System.Web.SessionState/SessionStateModule.cs
===================================================================
RCS file: /mono/mcs/class/System.Web/System.Web.SessionState/SessionStateModule.cs,v
retrieving revision 1.4
diff -b -u -2 -r1.4 SessionStateModule.cs
--- System.Web.SessionState/SessionStateModule.cs	13 Mar 2003 19:44:44 -0000	1.4
+++ System.Web.SessionState/SessionStateModule.cs	30 Mar 2003 14:05:56 -0000
@@ -4,19 +4,20 @@
 // Authors:
 //	Gonzalo Paniagua Javier (gonzalo@ximian.com)
+//      Stefan Görling (stefan@gorling.se)
 //
 // (C) 2002,2003 Ximian, Inc (http://www.ximian.com)
-//
+// (C) 2003 Stefan Görling (http://www.gorling.se)
+
 using System.Web;
+using System.Runtime.Remoting.Messaging;
 
 namespace System.Web.SessionState
 {
 	[MonoTODO]
-	public sealed class SessionStateModule : IHttpModule
+	 public sealed class SessionStateModule : IHttpModule, IRequiresSessionState
 	{
 		static SessionConfig config;
 		Type handlerType;
-		object handler;
-		
-		class SessionInProcHandler {}
+		ISessionHandler handler;
 		
 		public SessionStateModule ()
@@ -26,4 +27,6 @@
 		public void Dispose ()
 		{
+		    if (handler!=null)
+			handler.Dispose();
 		}
 
@@ -51,6 +54,8 @@
 			}
 
-			if (handlerType != null && handler == null)
-				handler = Activator.CreateInstance (handlerType);
+			if (handlerType != null && handler == null) {
+				handler = (ISessionHandler)Activator.CreateInstance (handlerType);
+				handler.Init(app); //initialize
+			}
 		}
 
@@ -65,5 +70,17 @@
 		IAsyncResult OnBeginAcquireState (object o, EventArgs args, AsyncCallback cb, object data)
 		{
-			return null;
+
+			HttpApplication application = (HttpApplication)o;
+			HttpContext context = application.Context;
+
+			if (handler!=null)
+			    handler.UpdateContext(context);
+			
+
+		// In the future, we might want to move the Async stuff down to the interface level, if we're going to support other than InProc, we might actually want to do things async, now we simply fake it.
+		HttpAsyncResult result=new HttpAsyncResult(cb,this);
+		result.Complete(true,o,null);
+
+		return result;
 		}
 
@@ -76,3 +93,6 @@
 	}
 }
+
+
+
 
Common subdirectories: System.Web.SessionState2/CVS and System.Web.SessionState/CVS
diff -N -c System.Web.SessionState2/ISessionHandler.cs System.Web.SessionState/ISessionHandler.cs
*** System.Web.SessionState2/ISessionHandler.cs	Thu Jan  1 01:00:00 1970
--- System.Web.SessionState/ISessionHandler.cs	Sat Mar 29 17:29:52 2003
***************
*** 0 ****
--- 1,19 ----
+ //
+ // System.Web.SessionState.ISessionHandler
+ //
+ // Authors:
+ //	Stefan Görling, (stefan@gorling.se)
+ //
+ // (C) 2003 Stefan Görling
+ //
+ // This interface is simple, but as it's internal it shouldn't be hard to change it if we need to.
+ //
+ namespace System.Web.SessionState {
+ public interface ISessionHandler
+ {
+       void Dispose();
+       void Init(HttpApplication context);
+       void UpdateContext(HttpContext context);
+ }
+ }
+ 
diff -N -c System.Web.SessionState2/SessionInProcHandler.cs System.Web.SessionState/SessionInProcHandler.cs
*** System.Web.SessionState2/SessionInProcHandler.cs	Thu Jan  1 01:00:00 1970
--- System.Web.SessionState/SessionInProcHandler.cs	Sun Mar 30 13:21:09 2003
***************
*** 0 ****
--- 1,118 ----
+ //
+ // System.Web.SessionState.SessionInProcHandler
+ //
+ // Authors:
+ //	Stefan Görling (stefan@gorling.se)
+ //
+ // (C) 2003 Stefan Görling
+ //
+ 
+ /*
+ 	This is a rather lazy implementation, but it does the trick for me.
+ 
+ 	TODO:
+ 	    * Remove abandoned sessions., preferably by a worker thread sleeping most of the time.
+             * Increase session security, for example by using UserAgent i hashcode.
+ 	    * Generate SessionID:s in a good (more random) way.
+ */
+ using System;
+ using System.Collections;
+ 
+ namespace System.Web.SessionState
+ {
+ 
+ 	// Container object, containing the current session state and when it was last accessed.
+     public class SessionContainer {
+ 	private HttpSessionState _state;
+ 	private long _last_access;
+ 
+ 	public SessionContainer(HttpSessionState state) {
+ 	    _state=state;
+ 	    this.Touch();
+ 	}
+ 
+ 	public void Touch() {
+ 	    _last_access=DateTime.Now.Millisecond;	    
+ 	}
+ 	
+ 	public HttpSessionState SessionState {
+ 	    get { 
+ 		//Check if we should abandon it.
+ 		if (_state!=null && (DateTime.Now.Millisecond-_last_access)>(_state.Timeout*60*1000))
+ 		    _state.Abandon();
+ 
+ 		return _state;
+ 	    }
+ 	    set {
+ 		_state=value;
+ 		this.Touch();
+ 	    }
+ 	}
+ 
+     }
+ 
+ 
+ 	public class SessionInProcHandler : ISessionHandler
+ 	{
+ 	    protected Hashtable _sessionTable;
+ 	    const string COOKIE_NAME="ASPSESSION"; // The name of the cookie.
+ 	    const int SESSION_LIFETIME=45; // The length of a session, in minutes. After this length, it's abandoned due to idle.
+ 
+ 	public void Dispose() {
+ 		_sessionTable=null;
+ 	}
+      	public void Init(HttpApplication context) {
+ 		_sessionTable=new Hashtable();
+ 	}
+ 
+ 
+ 	//this is the code that actually do stuff.
+ 	public void UpdateContext(HttpContext context) {
+ 	    SessionContainer container=null;
+ 
+ 		//first we try to get the cookie.
+ 		// if we have a cookie, we look it up in the table.
+ 		if (context.Request.Cookies[COOKIE_NAME]!=null) {
+ 		    container=(SessionContainer)_sessionTable[context.Request.Cookies[COOKIE_NAME].Value];
+ 
+ 		    // if we have a session, and it is not expired, set isNew to false and return it.
+ 		    if (container!=null && container.SessionState!=null && !container.SessionState.IsAbandoned) {
+ 			container.SessionState.IsNewSession=false; // Can we do this? It feels safe, but what do I know.
+ 			container.Touch(); // update the timestamp.
+ 			context.Session=container.SessionState; // Can we do this? It feels safe, but what do I know.
+ 			return; // and we're done
+ 		    }else if(container!=null) {
+ 			//A empty or expired session, lets kill it.
+ 			_sessionTable[context.Request.Cookies[COOKIE_NAME]]=null;
+ 		    }
+ 		}
+ 
+ 
+ 		// else we create a new session.
+ 		string sessionID=System.Guid.NewGuid().ToString();
+ 		container=new SessionContainer(new HttpSessionState(sessionID, // unique identifier
+ 								    new SessionDictionary(), // dictionary
+ 				   new HttpStaticObjectsCollection(),
+ 								    SESSION_LIFETIME, //lifetime befor death.
+ 								    true, //new session
+ 								    false, // is cookieless
+ 								    SessionStateMode.InProc,
+ 								    false)); //readonly
+ 		// puts it in the table.
+ 		_sessionTable[sessionID]=container;
+ 
+ 		// and returns it.
+ 		context.Session=container.SessionState;
+ 
+ 
+ 		// sets the session cookie. We're assuming that session scope is the default mode.
+ 		context.Response.AppendCookie(new HttpCookie(COOKIE_NAME,sessionID));
+ 
+ 		// And we're done!
+ 	}
+ 
+ 	}
+ }
+ 
+ 
+ 
