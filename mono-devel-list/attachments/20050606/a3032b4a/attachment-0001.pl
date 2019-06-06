2005-06-06  Svetlana Zholkovsky <svetlanaz-at-mainsoft.com>
        * In following classes added TARGET_J2EE or/and TARGET_JVM
	    directives:
			- HttpResponse.cs
			- HttpRuntime.cs
			- HttpUtility.cs
			- CapabilitiesLoader.cs
			- HttpApplication.cs
			- HttpApplicationFactory.cs
			- HttpContext.cs
			- HttpException.cs
			- HttpRequest.cs
        * Added Mainsoft's specific files :
			- GhHttpAsyncResult.jvm.cs
		
2005-05-25  Ben Maurer  <bmaurer@ximian.com>

	* MimeTypes.cs: Remove extra spaces, they were typos. Fixes 75049.

2005-05-13 Atsushi Enomoto <atsishi@ximian.com>

	* HttpUtility.cs : UrlDecodeToBytes() incorrectly decoded escaped 
	  characters. Patch by Kazuki Oikawa.

2005-05-09 Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpRuntime.cs: PlatformID.Unix.

2005-05-08 Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpResponse.cs: cleaned up the .ctors, fix IsClientConnected and just
	Clear the _Headers array instead of creating a new ArrayList in
	ClearHeaders().

2005-05-08 Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpResponse.cs: we had 2 variables to track client connection status.
	Use only one. Increase the buffer size to 28KB when writing from a file.

	* StaticFileHandler.cs: set the Content-Type before writing the file.
	This allows flushing before all the content is written.

	* HttpApplication.cs: use the variable instead of the property when
	setting the Principal for the current process.

2005-05-08 Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* ReusableMemoryStream.cs:
	* HttpWriter.cs: keep a pool of buffers to avoid allocations.

2005-05-07 Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpResponse.cs: no need to save/restore the thread culture when
	getting the Date header. According to Ben's profiling, this is a big
	deal in performance.

	* HttpRuntime.cs: ignore exceptions that might be thrown when unloading 
	a domain.

2005-05-04 Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpApplicationFactory.cs: ignore any exception thrown when invoking
	an application event.

2005-04-23 Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpBrowserCapabilities.cs: fix Win32 property.

2005-04-21 Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpResponse.cs: only add the charset when explicitly set or for
	well-known content types.

2005-04-20 Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpCachePolicy.cs:
	* HttpAsyncResult.cs:
	* HttpClientCertificate.cs:
	* HttpException.cs:
	* HttpRuntime.cs:
	* HttpCacheVaryByHeaders.cs:
	* HttpBrowserCapabilities.cs:
	* HttpUtility.cs:
	* HttpCacheVaryByParams.cs: no more warnings.

	* QueueManager.cs: check for local connections with minLocalFreeThreads.

2005-04-19 Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* ServerVariablesCollection.cs: shuffled variables, added missing ones
	and call a method in HttpRequest to set the HTTP_ variables.

	* HttpRequest.cs: new method to add HTTP_ variables to a collection.

2005-04-19 Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpRequest.cs: GetAllHeaders was returning the value twice instead
	of 'name: value'. When HTTP_ is requested on the output, don't include
	unknown headers.

2005-03-23 Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpCookieCollection.cs: when adding more than one cookie with the
	same name, the last one is the winner.

2005-03-09 Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpRequest.cs: correctly store the value cookies in Params. Fixes
	bug #73345.

2005-02-28 Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpRequest.cs: Path and FilePath also change when RewritePath is
	called. Fixes bug #73055.

2005-02-23  Sebastien Pouliot  <sebastien@ximian.com>

	* HttpRequest.cs: Make sure that any access after a ValidateInput 
	throws an exception if the data isn't safe.

2005-02-22 Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* CapabilitiesLoader.cs: fix the path, as machine.config is now in a
	x.x/ directory below $PREFIX/etc/mono.

2005-02-22 Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpRequest.cs: fail on unicode full-width '<' and '>' too. Fixes
	a security report (http://secunia.com/advisories/14325) that wan't
	reported to us before public disclosure.

2005-02-18 Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpResponse.cs: send the calculated content length even when it's 0.
	Fixes bug #72655.

2005-02-04  Lluis Sanchez Gual <lluis@novell.com>

	* HttpContext.cs: Added internal property to keep a reference to
	the last accessed page. Page uses this to implement PreviousPage.

2005-02-02  Lluis Sanchez Gual <lluis@novell.com>

	* ProcessModelInfo.cs: Fixed warning.

2005-02-01 Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* TraceContext.cs: writing a message without any other argument is not
	a warniing. Fixes bug #72017.

2005-01-20 Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpApplication.cs: if there are no more handlers, finish the
	request and ensure we call Complete on it. Now FreeTextBox 3.0 works.

2004-12-21 Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpRequest.cs: honor the maxRequestSize limit from machine.config.

2004-12-15 Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpApplication.cs: reread application CultureInfo as web.config
	might have changed. Fixes bug #62539.

2004-11-30 Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpResponse.cs: fixed ApplyAppPathModifier to insert the session ID.

2004-11-29 Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpApplicationFactory.cs: monitor changes in global.asax and bin
	directory and shutdown the application when that happens. Fixes bug
	#49651.

2004-11-29 Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* ReusableMemoryStream.cs: copied from System.IO.MemoryStream and
	slightly modified to allow expanding the buffer for cases on which the
	regular MemoryStream don't allow it.

	* HttpWriter.cs: use the new ReusableMemoryStream and fix bug #59841.
	Otherwise we would have to allocate a new MemoryStream...

2004-11-28 Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpApplication.cs: Create() is now GetInstance().

2004-11-18 Lluis Sanchez Gual <lluis@novell.com>

	* SiteMapNodeCollection.cs: Added missing properties.
	* HttpParseException.cs: Added 2.0 methods and properties.
	* SiteMapNode.cs: Added missing methods and properties.
	* SiteMapProvider.cs, XmlSiteMapProvider.cs, 
	SiteMapProviderCollection.cs: IProvider does not exist any
	more, it is now	ProviderBase.
	* ISiteMapProvider.cs: Deleted.
	* ParserErrorCollection.cs, ParserError.cs, SiteMapResolveEventArgs.cs:
	  Implemented.
	* SiteMap.cs: Minor fixes.	

2004-11-15 Lluis Sanchez Gual <lluis@novell.com>

	* SiteMapProviderCollection.cs: Fixed warning.
	* HttpApplication.cs: Added new 2.0 events.

2004-11-12 Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpResponse.cs: added internl SetHeadersSent.
	* HttpRuntime.cs: don't throw the 'headers already sent' exception
	if we're sending a runtime error.

2004-11-11 Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpApplication.cs: undo the TimeoutManager.(Add|Remove) shuffling.
	It causes troubles under heavy load.

2004-11-08 Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* SiteMap.cs: don't lock on Type.
	* CapabilitiesLoader.cs: avoid 2 locks when loading data.

2004-11-08 Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpRequest.cs: patch by Dennis Gervalle that fixes PhysicalPath in
	presence of rewriting.

2004-10-27 Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpApplication.cs: don't hang if a sync step is aborted. Fixes the
	system.web portion of bug #68270.

2004-10-10 Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* TraceContext.cs: don't cast to Page is the handler it's
	not a page.

2004-10-06 Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpRequest.cs: CurrentExecutionFilePath is the one that
	changes when Transfer or Execute are used, not FilePath.

	* HttpServerUtility.cs: moved form saving/restoring from
	Transfer to Execute, as it's needed there too. the query string is
	correctly set now. Fixes bug #67388.

	* HttpContext.cs: use SetCurrentExePath instead of SetFilePath.

2004-10-03 Ben Maurer  <bmaurer@ximian.com>

	* HttpResponse.cs: use UtcNow

2004-10-01 Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpResponse.cs: SuppressContent does not throw and clears all the
	buffered output. Fixes bug #67213.

2004-09-30 Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpUtility.cs: UrlPathEncode is static. Fixes bug #67155.

2004-09-29 Ben Maurer  <bmaurer@ximian.com>

	* HttpContext.cs, TimeoutManager: Use DateTime.UtcNow.

2004-09-25 Ben Maurer  <bmaurer@ximian.com>

	* HttpApplication.cs: Make sure requests are removed from
	the timeout manager. Fixes a major leak. #66751.

2004-09-24 Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpApplicationFactory.cs:
	* HttpRuntime.cs: implemented UnloadAppDomain and be ready for domain
	unloading.

2004-09-12 Ben Maurer  <bmaurer@ximian.com>

	* HttpContext.cs: use CallContext. It is a little bit faster.

2004-09-09 Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpStaticObjectsCollection.cs: don't share static session objects
	declared in the application file across the application, but on a
	per-session basis. Fixes bug #65446.

2004-09-09 Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpServerUtility.cs: in Transfer(path), don't keep form data if
	the transfer is done from inside a page that received a postback.
	Fixes bug #65613.

2004-09-08 Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpValueCollection.cs: fixed signature of ToString (). Closes bug
	#65392.

2004-09-06 Ben Maurer  <bmaurer@users.sourceforge.net>

	* HttpWriter.cs (.ctor): Dont create teh StreamWriter twice
	(Clear): Don't recreate the MemoryStream and StreamWriter

2004-09-05 Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpApplication.cs: only add/remove to/from the timeout
	manager when we're in a interruptible step.

2004-09-05 Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* TraceContext.cs: when IsEnabled has not been set, return the value
	from the TraceManager. Fixes bug #63469.

2004-08-31 Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpRuntime.cs: initialize the response writer when finishing a
	request because it cannot be queued. Under heavy load we made new
	requests be processed before the ones that might be queued. This is
	no longer the case.

	* QueueManager.cs: instead of queueing/dequeuing separately, we now
	have a single method that does everything needed to decide which one
	will be the next request processed.

2004-08-27 Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpRuntime.cs: removed initializations to null in .cctor. Prevent
	other requests from avoiding the lock if they are received before the
	configuration system is inited. Ensure that the queue manager is not
	null before using it (it can be null while the first request is being
	processed).

2004-08-22 Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpServerUtility.cs: ensure we have a full virtual path for the
	request being executed.

2004-08-02  Duncan Mak  <duncan@ximian.com>

	* ApplicationShutdownReason.cs: Fixed typos.

	* HttpCookieMode.cs:
	* HttpDataTransferMode.cs:
	* HttpRequestPriority.cs: Added [Serializable] attribute.
	
2004-08-02  Duncan Mak  <duncan@ximian.com>

	* ApplicationShutdownReason.cs:
	* HttpCookieMode.cs:
	* HttpDataTransferMode.cs:
	* HttpRequestPriority.cs: Added 2.0 enumerations.
	
2004-07-21 Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpApplication.cs: the file not found might be a dependency.

2004-07-20 Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpCookie.cs: use invariant when formatting expires date. Fixes bug
	#61690.

2004-07-07 Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpApplication.cs: don't keep the session around if we got it from
	the context. Fixes bug #61232.

2004-07-06 Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpUtility.cs: fixed stupid bug in UrlDecode from bytes. Closes bug
	#61181.

2004-07-02 Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* TraceContext.cs: added internal HaveTrace property whose
	value is true when the page has a Trace attribute.

2004-06-15 Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* TraceData.cs: fixed <br> output. Closes bug #60181.

2004-06-11  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpUtility.cs: check for control characters in the string to encode
	or decode and return the same string if there are none.

2004-06-11  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpApplication.cs: change/restore the IPrincipal in their own methods
	and make them internal.

2004-06-09  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpContext.cs: reverting Pedro's patch and sending mail with test
	to mono-devel.

2004-06-09  Pedro Mart�nez Juli�  <yoros@wanadoo.es>

	* HttpContext: User property returns its own "user" value because
	the context can walk through different Threads. When "User" property
	is changed, change "Thread.CurrentPrincipal" too.

2004-06-08  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpRequest.cs: removed extra ^Ms and fixed style of last patch.

2004-06-08  Alon Gazit  <along@mainsoft.com>

	* HttpRequest.cs: Add a patch for HttpRequest.ServerVariables.

2004-06-07  Sebastien Pouliot  <sebastien@ximian.com>

	* HttpContext.cs: User property now get/set Thread.CurrentPrincipal.
	Fix (at least partially) #59683.

2004-06-07  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpRequest.cs: reverting patch from Alon Gazit. Uses the above file
	that doesn't compile.

2004-06-07  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* TraceData.cs: fixes nullref in an application that relies on
	r ["Message"] not being null. Closes bug #59679.

2004-06-07  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpCachePolicy.cs: implemented SetAllowResponseInBrowserHistory.

2004-06-07  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpRuntime.cs: implemented a 5 simple properties that were TODOs.

2004-06-07  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpBrowserCapabilities.cs: implemented ClrVersion and GetClrVersions.
	* HttpException.cs: removed MonoTODO.

2004-06-05  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* TraceContext.cs: don't check if HttpRuntime.TraceManager
	is enabled when writing.

2004-06-04  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpRequest.cs: added ClientTarget internal property.

2004-06-03  Lluis Sanchez Gual <lluis@ximian.com>

	* HttpApplication.cs: Clear the http handler list after releasing the
	  handlers.

2004-06-02  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* TraceData.cs: html-encode the messages written to the trace. Fixes
	bug #59431.

2004-06-01  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpWorkerRequest.cs: the hashtables are now case-insensitive. Thanks
	to Markus Kr�utner.

2004-05-31  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpRequest.cs: nullify _sRequestRootVirtualDir and baseVirtualDir
	when SetFilePath is called. This way the cached values are reset and
	get the right value in case someone (namely SessionStateModule + 
	cookieless session) changes the FilePath after the property cached its
	value. Fixes bug #59364.

2004-05-27	Patrik Torstensson <totte@hiddenpeaks.com>

	* HttpApplicationFactory.cs: Added SignalError (still todo)

2004-05-26  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpResponse.cs: remove hardcoded "HTTP/1.0" version that kept
	chunked encoding disabled. Fixed chunked suffix and end. Send the
	'lastchunk' marked when in the final Flush even if the content length
	is 0. This makes mod-mono-server work fine with chunked encoding.
	 
	* HttpRuntime.cs: Set the _firstRequest* variables to true
	earlier. TraceContext don't take any parameter now.

	* TraceManager.cs: don't need a context. Use GetAppConfig.

2004-05-25  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpApplication.cs: set culture/uiculture from configuration and
	restore it after each step. Fixes bug #52851.

2004-05-18  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpUtility.cs: use lower case in UrlEncode like MS does. Delay
	entities hashtable creation until it's really needed.

2004-05-18  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpApplicationFactory.cs: if no module matches the name found for a
	possible event, ignore it. Fixes bug #58542.

2004-05-16	Patrik Torstensson <totte@hiddenpeaks.com>

	* HttpRuntime (Init): Removed old todo
	* HttApplication : Implemented IHttpHandlerFactory recycling
	
2004-04-28	Patrik Torstensson

	* HttpApplicationState.cs: Performance, usage of ReaderWriter lock,
	removed MonoTodo

2004-04-16  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpUtility.cs: return null in HtmlDecode for null input instead of
	throwing an exception. Patch by Jan Jaros (bug #57083).

2004-04-10  Vladimir Vukicevic  <vladimir@pobox.com>

	* TimeoutManager.cs: Swap the order of initialization of contexts
	and the Timer, to avoid race condition of CheckTimeouts being called
	before contexts gets initialized.

2004-03-27  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpRequestStream.cs: patch from Jan Jaros that fixes bug #56080.
	Now the posted file content does not have the boundaries and headers
	included.

2004-03-25  Alon Gazit <along@mainsoft.com>

	* HttpRequest.cs: fix ValidateCookieCollection() to prevent
	InvalidCastException.

2004-03-15  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpValueCollection.cs: don't UrlDecode cookies. Fixes bug #55254.

2004-03-01  Larry Ewing  <lewing@ximian.com>

	* HttpUtility.cs: fix UrlEncodeToBytes count check.

2004-02-12  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpServerUtility.cs:
	* HttpUtility.cs: added some checks for null. Fixed UrlPathEncode (bug
	#53670).

2004-02-12  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpUtility.cs: fixed length check. Closes bug #54201.
	Thanks to Michal Moskal. Use MemoryStream instead of an ArrayList when
	decoding.

2004-02-11  Jackson Harper <jackson@ximian.com>

	* TraceData.cs: Use ToString for cookie/header/var name values so
	null is handled properly.
	
2004-02-09  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpApplication.cs: ApplicationState is inited by the factory so,
	return that value in the property. when we use the context Session,
	cache it in the instance field.

	* HttpApplicationFactory.cs: fixed target Type for the event when
	hooking application and module events. Initialize application
	and session scope objects. Fixes non-aplication events hook up.

	* HttpStaticObjectsCollection.cs: added StaticItem and delay the
	creation of the objects until they are requested.

2004-01-28  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpApplicationFactory.cs: fixlet for session events hook.

2004-01-28  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpApplicationFactory.cs: attach all events from Type and BaseType
	at the same time. Fixes bug #53454.

2004-01-27  Jackson Harper <jackson@ximian.com>

	* HttpCachePolicy.cs: varybyparams::GetResponseHeader can return
	null now, dont hadd the header if it does.
	* HttpCacheVaryByParams.cs: Return null if there are no items.

2004-01-23  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpCachePolicy.cs: it's not public.
	* HttpRuntime.cs: wait for requests before disposing the queue.

2004-01-15  Jackson Harper <jackson@ximian.com>

	* HttpCachePolicy.cs: Fix typo causing varyby params headers to be
	created when they shouldn't be.
	
2004-01-14  Jackson Harper <jackson@ximian.com>

	* TraceData.cs: Fix some typos in the output text. Fix control
	position when adding controls recursively.
	
2004-01-14  Jackson Harper <jackson@ximian.com>

	* HttpCachePolicy.cs: Expose duration and sliding properties.
	
2004-01-14  Jackson Harper <jackson@ximian.com>

	* HttpCachePolicy.cs: Add an event that is fired when the
	cacheability is updated. The response uses this to determine
	whether or not it needs to cache itself.
	* HttpResponse.cs: When the cacheability is updated either create
	or dispose of the cached raw response based on whether or not we
	wil need it. This allows output caching to be controlled
	programatically.
	
2004-01-12  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpContext.cs: add setter for ConfigTimeout.
	* HttpException.cs: added Description property and HTML encode some
	unescaped values.

	* HttpRequest.cs: support request validation.

	* HttpRequestValidationException.cs: added message and description.

	* HttpServerUtility.cs: implemented ScriptTimeout.

2004-01-11  Jackson Harper <jackson@ximian.com>

	* TraceManager.cs: Dont crash if there is no trace config element.
	
2004-01-11  Jackson Harper <jackson@ximian.com>

	* HttpRequest.cs: Add property for determining if the request is
	local or not.
	
2004-01-10  Jackson Harper <jackson@ximian.com>

	* TraceContext.cs: Handle tracing when it is enabled in the config
	file but not on the page.
	* TraceManager.cs: Get settings from the configuration object.
	* HttpRuntime.cs: Create trace manager in the first request start
	so it can get configuration settings.
	
2004-01-10  Jackson Harper <jackson@ximian.com>

	* TraceContext.cs: Save the request path in the trace data.
	* TraceData.cs: Add RequestPath property, make some rendering
	methods internal static so the TraceHandler can use them.
	* TraceManager.cs: Expose trace data, add a method for clearing
	trace data.
	
2004-01-10  Jackson Harper <jackson@ximian.com>

	* HttpRuntime.cs: Add trace manager
	* TraceManager.cs: New class for handling trace configuration and
	storing trace data objects.
	* TraceContext.cs: Save trace data to the trace manager. Fix typo.
	
2004-01-10  Jackson Harper <jackson@ximian.com>

	* TraceData.cs: New class for storing trace data. Data is stored
	here instead of the trace context so it can be saved and accessed
	from the trace handler.
	* TraceContext.cs: Save data in the TraceData object, let the
	trace data object handle the rendering.
	
2004-01-08  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpRequest.cs: use ContentEncoding for QueryString. Fixes bug #52577.
	Thanks to Jan Jaros (mono-bug@jerryweb.info).

	* HttpRequestValidationException.cs: fix comment.

2004-01-06  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpException.cs: default to error 500. Fixes bug #52623.

2004-01-04  Jackson Harper <jackson@ximian.com>

	* TraceContext.cs: Store and render trace info times. Also render
	cookie sizes. Remove debug code.
	
2004-01-04  Jackson Harper <jackson@ximian.com>

	* HttpResponse.cs: Set the cached response date header so it can
	be updated.
	* HttpResponseHeader.cs: Let values be set so we can update cached 
	response header values.
	
2004-01-04  Jackson Harper <jackson@ximian.com>

	* HttpResponse.cs: Implement RemoveOutputCacheItem.
	
2004-01-04  Jackson Harper <jackson@ximian.com>

	* HttpCachePolicy.cs: Add internal method to get the vary by custom string
	* HttpCacheVaryByHeaders.cs: Add internal method to get the header names.
	
2004-01-03  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpRuntime.cs: implemented MachineConfigurationDirectory,

2004-1-1  Alon Gazit <along@mainsoft.com>
	* HttpWriter.cs: add check in Write() in order to prevent
	NullReferenceException.

2004-1-1  Alon Gazit <along@mainsoft.com>
	* HttpResponse.cs: implemented ExpiresAbsolute and Expires.

2003-12-18  Jackson Harper <jackson@ximian.com>

	* TraceContext.cs: Write () methods are not warnings.
	
2003-12-18  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpBrowserCapabilities.cs: added GetClrVersions ().
	* HttpCachePolicy.cs: added SetAllowResponseInBrowserHistory ().
	* HttpContext.cs: added set_Current and RewritePath (s, s, s) for 1.1.
	* HttpRequest.cs: added set_ContentType, SetPathInfo and ValidateInput.
	* HttpRequestValidationException.cs: new class for 1.1
	* HttpResponse.cs: added RedirectLocation.
	* HttpRuntime.cs: added UnloadAppDomain.
	* HttpServerUtility.cs: Execute (s, t, b) is internal for < 1.2
	* HttpUtility.cs: copied UrlPathEncode from HttpServerUtility.
	* HttpWorkerRequest.cs: added [ComVisible] and made the ctor public.

2003-12-17  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpContext.cs: implemented IsCustomErrorEnabled and
	IsDebuggingEnabled. Added internal ErrorPage property.

	* HttpRuntime.cs: on error, check if we have a custom error page enabled
	to handle it and redirect.

	* HttpResponse.cs: added RedirectCustomError (), which actually does
	the redirection to the error page.
	
2003-12-16  Jackson Harper <jackson@ximian.com>

	* TraceContext.cs: Render all the data, and the stylesheet.
	
2003-12-16  Jackson Harper <jackson@ximian.com>

	* TraceContext.cs: Add incomplete render method.
	
2003-12-16  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* CapabilitiesLoader.cs: loads browser detection and capabilities data
	from browscap.ini file by Gary J. Keith.

	* HttpBrowserCapabilities.cs: removed almost all TODOs.

	* HttpRequest.cs: fixed Browser property.

2003-12-15  Jackson Harper <jackson@ximian.com>

	* TraceContext.cs: Initial implementation of storing data.
	* HttpContext.cs: Create and expose a trace object.
	
2003-12-04  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpApplication.cs: ThreadAbortException is ok on Redirect.
	* HttpContext.cs: added TimeoutPossible property.
	* HttpResponse.cs: throw ThreadAbortException if End () is called within
	a step in which is possible to timeout.

	Fixes bug #51703.

2003-12-04  Jackson Harper <jackson@ximian.com>

	* HttpRequest.cs: Cleanup method.
	
2003-12-04  Jackson Harper <jackson@ximian.com>

	* HttpValueCollection.cs: Allow blank value names. Posting
	<blank>=SomeValue is valid. And occurs if a radio button does
	not have its name set.
	
2003-12-03  Jackson Harper <jackson@ximian.com>

	* HttpResponse.cs: Actually apply an app path modifier in
	ApplyAppPathModifer and add a method to set the app path modifier.
	* HttpRequest.cs: Add utility method for setting a request header.
	
2003-12-02  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpApplication.cs: handle FileNotFound and DirectoryNotFound
	exceptions when creating the handler to generate a better error page.

	* HttpException.cs: display the http_code if available.  Changed all
	\n by \r\n to make the hidden stack trace readable.
	
	* StaticFileHandler.cs: don't send the real path in th eerror.

2003-12-02  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpContext.cs: updated GetConfig and GetAppConfig to new API.
	
	* HttpResponse.cs: separate initialization of the HttpWriter, as it
	tries to read configuration settings while the config. system is not
	available (ie, before the first request).
	
	* HttpRuntime.cs: delayed queueManager and response writer
	initialization until the configuration system is working.

2003-11-26  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpRuntime.cs: added request queue handling.

	* QueueManager.cs: simple request queue.
	
	* TimeoutManager.cs: added some locks to prevent the enumerator used in
	CheckTimeouts to be out of synch.

2003-11-25  Jackson Harper <jackson@ximian.com>

	* HttpStaticObjectsCollection.cs: Add methods for serialization
	and conversion to/from byte arrays.
	
2003-11-21  Jackson Harper <jackson@ximian.com>

	* HttpResponse.cs: When caching data set the content length in the
	cached repsonse so that only that amount will be written back to
	the client. Add method to write a range of binary data.
	* HttpCacheVaryByParams.cs: Add method to retrieve param names.
	
2003-11-21  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpApplication.cs:
	* HttpContext.cs:
	* HttpRuntime.cs: add timeout handling.
	* TimeoutManager.cs: new class that takes care of aborting threads on
	timeout.

2003-11-19  Jackson Harper <jackson@ximian.com>

	* HttpWriter.cs: Use a constant for the buffer size so the cache
	can get the buffer size. Add method to get the buffer.
	* HttpResponse.cs: Methods for getting data to cache, and setting
	vars from the cache.
	* HttpCachePolicy.cs: Expose a pages cache expire time.
	
2003-11-18  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpResponse.cs: 
	* HttpWriter.cs: some fixes to allow closing a response stream without
	messing the rest.

2003-11-13  Jackson Harper  <jackson@ximian.com>

	* HttpCachePolicy.cs: Make sure cacheability and maxage get
	set. Add method to set Http response header data
	* HttpCacheVaryByParams.cs: Add method to create a response header.
	* HttpCacheability.cs: Add ServerAndPrivate and ServerAndNoCache.
	* HttpResponse.cs: Set cache headers.
	
2003-11-11 Ben Maurer  <bmaurer@users.sourceforge.net>

	* HttpModuleCollection.cs (GetKey): Recursion, again!

2003-11-11 Ben Maurer  <bmaurer@users.sourceforge.net>

	* HttpClientCertificate.cs (ValidUntil): recursion!

2003-11-08 Ben Maurer  <bmaurer@users.sourceforge.net>

	* SiteMapNode.cs (GetDataSourceView): Implement.
	* SiteMapProvider.cs: Typo fixing.
	* XmlSiteMapProvider.cs: We shouldnt resolve here.
	
2003-11-08 Ben Maurer  <bmaurer@users.sourceforge.net>

	* SiteMap.cs (Init): implement a hack that doesnt need the config
	stuff. Should do that later.
	* SiteMapNodeCollection (OnValidate): Fix recursion.
	* SiteMapProvider.cs: We dont implement some culture stuff work
	around it. Fix typo.
	* XmlSiteMapProvider.cs: Added.
	
2003-11-07 Ben Maurer  <bmaurer@users.sourceforge.net>

	* ISiteMapProvider.cs:
	* SiteMap.cs:
	* SiteMapNode.cs:
	* SiteMapNodeCollection.cs:
	* SiteMapProvider.cs:
	* SiteMapProviderCollection.cs: V2 sitemap related stuff.

2003-11-07  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpRequest.cs: don't attempt to read more bytes than specified
	content length.

2003-11-05  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpRequest.cs:
	* HttpResponse.cs:
	* HttpUtility.cs:
	* HttpValueCollection.cs: encoding fixes/updates.

	* HttpWriter.cs: when updating the encoding, flush the existing stream.
	Encoding updates.

2003-11-04 Ben Maurer  <bmaurer@users.sourceforge.net>

	* HttpContext.cs (IsCustomErrorEnabled): dont throw exception, just
	return false (which makes sense, as the custom errors *arent* enabled;
	ie they dont work.
	* HttpResponseStream.cs: you actually can write with len = 0

2003-11-03 Jackson Harper <jackson@ximian.com>

	* HttpResponse.cs (ContentEncoding): Throw
	ArgumentNullException. Patch by Yaron Shkop.
	
2003-10-30  Atsushi Enomoto <ginga@kit.hi-ho.ne.jp>

	* HttpMultipartContentParser.cs : Quick fix for cygwin build. 
	  CSC complains that constant char cannot be casted as byte.

2003-10-22  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpApplication.cs: added AssemblyLocation property.

2003-10-18  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpApplicationFactory.cs: use NoParamsInvoker.
	* HttpRequest.cs: support request filters.
	* HttpRequestStream.cs: mono-stylized and added new Set method.

	* NoParamsInvoker.cs: proxy class to invoke user-provided methods
	without parameters that are invoked by EventHandlers.

2003-10-13  Lluis Sanchez Gual <lluis@ximian.com>

	* HttpResponse.cs: Changed harcoded switch to en-US culture to a switch
	  to invariant culture.

2003-10-11  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpResponse.cs:
	* HttpServerUtility.cs: change the response writer in Execute. Thanks
	to Rich Alimi <rich@velvetsea.net> for noticing this.

2003-10-11  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpApplicationFactory.cs: support for wiring up events without
	parameters.

2003-10-06  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpUtility.cs: small memory usage reduction.

2003-10-01  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpApplication.cs: pass the Uri, not the file path to
	when looking for a handler.

2003-09-21  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpRequest.cs: small fix needed when reading big POST data.

2003-09-04  Lluis Sanchez Gual <lluis@ximian.com>

	* HttpRequest.cs: Url property: use GetLocalAddress() to get the address
	  (this will get the address from the request headers).

2003-09-04  Lluis Sanchez Gual <lluis@ximian.com>

	* HttpServerUtility.cs: In Transfer(), preserve the query string if
	  told to do so.

2003-08-29  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpApplication.cs: ensure we do all the EndRequest steps. Don't
	filter the output on error.
	
	* HttpResponse.cs: modified DoFilter to allow bypassing filtering.

2003-08-27  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpApplication.cs: when the request is completed or an
	error happens, execute all the delegates attached to EndRequest, not
	only the last one. This makes xsp/test/authtest work again.
	
	* HttpMethodNotAllowedHandler.cs: fixed description for http
	status code.

2003-08-22  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpRequest.cs: quick way of checking that the path is within the
	root for the application. Thanks to Johannes for reporting.
	
	* HttpRuntime.cs: use the status code from teh exception when it'ss a
	HttpException.

	* StaticFileHandler.cs: forbidden is 403.

2003-08-20  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpServerUtility.cs: fixed path and query. Path by Rich Alimi
	<rich@velvetsea.net>.

2003-08-19  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpException.cs: make the unhandled error more like the MS one.
	* HttpRuntime.cs: set a 500 error code on unhandled exceptions.

2003-08-19  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpResponse.cs: flush headers when the body length is 0.
	* StaticFileHandler.cs: added If-Modified-Since handling patch slightly
	modified from the original by Piers Haken <piersh@friskit.com>.

2003-08-14  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpResponse.cs: another patch from totte and me. This one prevents
	writing output if the client have disconnected and filters the data
	when there's a non-final Flush in the middle of the process.

2003-08-12  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpApplication.cs: fixed typos. Closes bug #44197.

2003-08-12  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpApplication.cs:
	* HttpApplicationFactory.cs: fix duplicate application OnStart events.

	Patch by Patrik Torstensson.

2003-08-11  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpApplicationFactory.cs: use the correct Delegate.CreateDelegate
	overload. The previous one only admits static methods.

2003-08-01  Andreas Nahr <ClassDevelopment@A-SoftTech.com>

	* ProcessModelInfo.cs: Fixed signature

2003-07-30  Andreas Nahr <ClassDevelopment@A-SoftTech.com>

	* WebCategoryAttribute.cs: Implemented localization
	* WebSysDescriptionAttribute.cs: Implemented localization

2003-07-23  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpRuntime.cs: also clear the headers that may have been set upon
	error processing the request.

2003-07-23  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpResponseStreamProxy.cs: reformatted. Fixed infinite recursion in
	Write method.

	* HttpWriter.cs: flush the filter after writing.

2003-07-22  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpWriter.cs: avoid duplicating the MemoryStream byte buffer.

2003-07-08  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpContext.cs: Session doesn't have a setter.

	* HttpResponse.cs: Request is private.

2003-07-03  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpRequest.cs: fixed Headers property. It was getting known headers
	values instead of known headers names.

2003-07-01  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpApplication.cs: prevent nullref if an error happens before context
	is set.
	* HttpException.cs: small fix in the stack trace sent.
	* HttpUtility.cs: the lock is not needed.

2003-06-30  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpRequest.cs: added REMOTE_PORT.
	* HttpValueCollection.cs: fixed bug #45490.

2003-05-13  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpApplication.cs:
	* HttpApplicationFactory.cs: fire application start and session
	start/end events.

2003-05-06  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpException.cs: encode as HTML the inner exception that
	is appended as a comment at the end of error pages.

2003-05-03  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpWriter.cs: don't do anything in Flush. Fixes #42249.

2003-05-01  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HtmlizedException.cs: added more virtual methods.

	* HttpException.cs:  some work on the output when there's a source
	file present.

2003-04-30  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HtmlizedException.cs: simplified to cope with the new interface.

	* HttpApplicationFactory.cs: use the application file parser to get the 
	application Type.
	
	* HttpException.cs: small changes. Needs some more work on
	ParseExceptions.
	
2003-03-25  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpRequest.cs: fixed Url property.

2003-03-24  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HtmlizedException.cs:
	* HttpException.cs: display the correct line number in error messages.

2003-03-22  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpCachePolicy.cs: implemented all TODOs.
	* HttpRequestStream.cs: make it internal.

2003-03-18  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpContext.cs: implemented RewritePath in other way.
	* HttpRequest.cs: removed SetPhysicalPath and added SetForm.
	* HttpServerUtility.cs: implemented Transfer (string, bool).

2003-03-16  Daniel Lopez Ridruejo <daniel @ rawbyte.com>
	* HttpContext.cs : Implemented RewritePath
	* HttpRequest.cs : Added internal function SetPhysicalPath

2003-03-14  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpServerUtility.cs: implemented Transfer ().

2003-03-13  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpRuntime.cs: Cache no longer have a Dispose method.

	* HttpServerUtility.cs: removed MonoTODO.

2003-03-03  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpHelper.cs: store the values in an ArrayList to get them in correct
	order.

2003-02-17  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpApplicationFactory.cs: Global.asax takes precedence over
	global.asax if it exists.

	* HttpRequest.cs: use allowCrossAppMapping in MapPath.

2003-02-17  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpApplication.cs: CreateHttpHandler is now internal.

	* HttpRequest.cs: allow setting QueryStringRaw, which
	invalidates the data obtained from the previous value. Added internal
	SetFilePath method.

	* HttpServerUtility.cs: implemented Execute and GetLastError.

2003-02-17  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpServerUtility.cs: style.

2003-02-13  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpApplication.cs: only execute the EndRequest step on error
	condition or request marked as completed. This prevent page events from
	being called when, for example, the url authorization module forbids
	the request.

2003-02-12  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpRequest.cs: implemented the indexer.

2003-02-11  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HtmlizedException.cs: base class for exceptions that makes it easy to
	generate error pages.

	* HttpException.cs: improved error displaying.

	* HttpRuntime.cs: removed debugging output.

2003-02-06  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpApplication.cs: display the error instead of hanging when we get
	any error before the last step of the request.

2003-02-04  Tim Haynes <thaynes@openlinksw.com>

	* HttpApplicationFactory.cs: fixed HttpRuntime.Close() to decrement
	instance counter.

2003-01-29  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpRequest.cs: added BaseVirtualDir property and use it in MapPath.

2003-01-17  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpRequest.cs: implemented CurrentExecutionFilePath.

2003-01-10  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpApplication.cs: keep _lasterror if no context. Attach
	application events *after* modules initialization (if not, User is not
	set when the user handler is called).
	
	* HttpApplicationFactory.cs: made all methods related to
	AttachEvents static. I will fix OnStart/OnEnd for application and
	session later.
	
	* HttpRequest.cs: don't initialize cookies twice.

2003-01-10  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpResponse.cs:
	(ApplyAppPathModifiers): return the root directory for "".

2003-01-08  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpUtility.cs: fixed HtmlDecode to avoid ArgumentOutOfRangeException.

2003-01-04  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpApplication.cs: added new state to handle default authentication.

2003-01-03  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpContext.cs: removed hack to get the User.

2003-01-03  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpUtility.cs: fixed bug #36038. Thanks to juancri@tagnet.org for
	reporting the bug and how to fix it.

2002-12-20  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpCookie.cs: send 'expires' in the header.

2002-12-19  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpValueCollection.cs: patch from Botjan Vizin 
	<bostjan.vizin@siol.net> that implements ToString (bool).

2002-12-18  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpApplicationFactory.cs: add the context as parameter when building
	the application Type.
	
	* HttpCookie.cs: new internal constructor.
	* HttpCookieCollection.cs: new internal method to make a cookie expire.

	* HttpRequest.cs: MapPath fixes.
	* HttpResponse.cs: implemented ApplyAppPathModifier.
	* HttpRuntime.cs: fixed typo in AppDomainAppVirtualPath.

2002-12-17  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpContext.cs: hack to create a default user when there's no one.
	Implemented GetConfig (string).

	* HttpRequest.cs: fixes to MapPath (string).

2002-12-12  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpRuntime.cs: avoid nulls and exception when getting resource
	format strings.

	* StaticFileHandler.cs: added file name to error message.

2002-12-05  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpResponse.cs: avoid sending chunked content for HTTP/1.1.

2002-12-02  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpApplicationFactory.cs: get the events from the application class,
	fire Application/Session Start/End and add the others as application
	events.

2002-11-30  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpApplicationFactory.cs: compile global.asax file if it exists.

2002-11-27  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpRequest.cs: provide a default Browser until we detect it.
	* HttpResponse.cs:
	(End): do not close the connection here.
	(Flush (bool)): send the headers when, for example, Redirect () is
	called.

2002-11-12  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpException.cs: simple error output.

2002-11-12  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpApplication.cs: style.
	* HttpException.cs: style.
	* HttpRuntime.cs: only flush the response if there are no errors.
	Otherwise, write an error output.
	* HttpWriter.cs: change Unicode to UTF8.

2002-11-09  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpApplication.cs: don't begin the request using ExecuteNextAsync
	(it fails to work on NetServ).

	* HttpWorkerRequest.cs: typo.

2002-11-07  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpValueCollection.cs: the value may contain trailing '=' as it is
	UrlEncoded. Don't split name=value based on '='.

2002-11-02  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpCookie.cs: made GetCookieHeader internal.

	* HttpRequest.cs: get cookies from request.

	* HttpResponse.cs: send cookies. Implemented
	AddFileDependencies (). Added check for _Writer == null in Flush
	(Patrik ;-). Clear the content if HEAD or SupressContent == true.
	Removed redirect hack used in old server.

2002-10-31  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpRequest.cs: fixed GetRawContent (). Now it only tries to read at
	most ContentLength bytes.

	* HttpResponse.cs: now it sends the headers. Added
	X-Powered-By header :-).

	* HttpRuntime.cs: fixed typo.

	* HttpValueCollection.cs: cosmetic changes.

2002-10-27  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpApplication.cs: reenabled a few lines of code
	(ThreadPool already fixed). 
	
	* HttpRequest.cs:
	* HttpResponse.cs:
	* HttpUtility.cs:
	* HttpValueCollection.cs:
	* HttpWriter.cs: Use WebEncoding.Encoding.

2002-10-25  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpWriter.cs: changed encoding of the writer from Unicode to UTF8.
	This fixes sending bytes and allows mixing byte with chars.

2002-10-25  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpResponse.cs: implemented WriteFile methods.
	* MimeTypes.cs: removed duplicated entries.

2002-10-24  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpResponse.cs: don't throw exception in a couple of
	methods not yet implemented.

2002-10-08  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpApplication.cs: fixed type and handle factories when creating
	IHttpHandler for a request.

2002-10-08  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpApplication.cs: use handlers from configuration.
	* HttpContext.cs: get handlers from ConfigurationSettings.

2002-10-02  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpMethodNotAllowedHandler.cs:
	* HttpRuntime.cs:
	* StaticFileHandler.cs: Modified file.

	* HttpUtility.cs: implemented all missing methods.


2002-09-30  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* System.Web/HttpApplication.cs: use the static file handler.
	* System.Web/HttpForbiddenHandler.cs: handler to forbid access.
	* System.Web/HttpMethodNotAllowedHandler.cs: handler for method not
	allowed.
	
	* System.Web/HttpUtility.cs: finished all UrlDecode methods.
	* System.Web/MimeTypes.cs: map from file extension to MIME type.
	* System.Web/StaticFileHandler.cs: serves static files

2002-09-28  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* System.Web/HttpApplication.cs:
	* System.Web/HttpApplicationFactory.cs:
	* System.Web/HttpRequest.cs:
	* System.Web/HttpRuntime.cs: we are now able to compile pages and use
	HttpApplication, HttpRuntime and SimpleWorkerRequest.

2002-09-25  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpApplication.cs: added some missing methods.
	* HttpApplicationFactory.cs: get event handlers for the application.
	* HttpAsyncResult.cs: little fixes.
	* HttpRequest.cs: make Encoding work even with no worker request.

2002-08-26  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpWorkerRequest.cs: mcs doesn't go crazy. It's just me, that forgot
	to add HttpMapPath to the list file...

2002-08-26  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpWorkerRequest.cs: fixes compilation with mcs. I will add a bug
	report when i get a test case.

2002-08-26  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpApplicationFactory.cs:
	* HttpCachePolicy.cs:
	* HttpResponseHeader.cs:
	* HttpResponseStream.cs:
	* HttpResponseStreamProxy.cs:
	* HttpValueCollection.cs: misc. fixes based on class status page.

	* IHttpMapPath.cs: New file.

	* HttpRequest.cs: implemented ContentEncoding.
	* HttpWorkerRequest.cs: mono-stylized and implemented
	SendResponseFromMemory.

2002-08-18  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpContext.cs: reformatted.
	* HttpStaticObjectsCollection.cs: implemented GetEnumertor, CopyTo and
	the indexer.

2002-08-05  Patrik Torstensson <ptorsten@hotmail.com>

	* HttpApplication.cs: Implemented a state machine to allow handling of
	HttpModules and HttpHandlers. Implementation of async handlers. 
								 
	* HttpApplicationFactory.cs: Factory for creating HttpApplication
	instances, including caching.
	
	* HttpRuntime.cs: Usage of the new HttpApplicationFactory to get a
	application instance to execute requests in and implementation of 
	request execution (still no request queue). 
							 
	* HttpAsyncResult.cs: New file to handle async module results.						
							 
	* HttpRequest.cs: Change signature of Dispose
	* HttpResponse.cs: new internal method allowing filtering to happen
	during the request flow in the state machine.

2002-07-28  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpApplication.cs: events were not being initialized.

2002-07-25  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* ProcessModelInfo.cs: fixed compilation.

2002-07-25  Tim Coleman <tim@timcoleman.com>
	* ProcessModelInfo.cs:
		New class added
	* HttpParseException.cs:
	* HttpCompileException.cs:
	* HttpUnhandledException.cs:
		Internal constructors added to these

2002-07-24  Tim Coleman <tim@timcoleman.com>
	* ProcessInfo.cs: 
		Fix constructor, reference to shutdownreason.

2002-07-24  Tim Coleman <tim@timcoleman.com>
	* HttpCachePolicy.cs:
		Added stubbs to this class.
	* HttpCacheability.cs:
	* HttpCacheRevalidation.cs:
	* HttpValidationStatus.cs:
	* ProcessShutdownReason.cs:
	* ProcessStatus.cs:
	* TraceMode.cs:
		Reorder the enumerations (and in some cases make
		one-based) in order to agree with the .NET 
		implementation, based on the class status page.
	* ProcessInfo.cs:
		Implementation of this class.

2002-07-23  Tim Coleman <tim@timcoleman.com>
	* HttpCompileException.cs:
	* HttpParseException.cs:
	* HttpUnhandledException.cs:
		New stubbs created.
	* HttpApplication.cs:
	* HttpBrowserCapabilities.cs:
		Added missing methods stubbs and attributes based
		on the class status page.  Also reformatted some
		source for consistency.

2002-07-23  Tim Coleman <tim@timcoleman.com>
	* HttpUtility.cs: Moved entities hashtable into main
		class as a static object, so we don't instantiate
		a new one every time.  Also put the hashtable
		building into a lock block.

2002-07-22  Tim Coleman <tim@timcoleman.com>
	* HttpUtility.cs: Cleanup of the code, implementation
		of HtmlDecode/HtmlEncode functions

2002-07-14  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpResponse.cs: quick&dirty hack to make redirection work. Should
	be out of there once we have SimpleWorkerRequest.

2002-07-13  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpUtility.cs: little typo, big headache.

2002-07-10  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpRuntime.cs: don't throw NotImplemented in a couple of methods.

2002-06-30  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* System.Web/HttpResponse.cs: 

	Fixes based on class status page:
	
		- Add attributes (DefaultEvent, ParseChildren).
		- Fix declarations.
		- Explicitly implement some interfaces (IPostBackDataHandler
		and IPostBackEventHandler).
		- Implemented some missing methods.

2002-06-29  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpContext.cs:
	(Session): return null instead of throwing an exception.

	* HttpRequest.cs:
	(HttpMethod): return RequestType if not set.
	(GetRawContent): return QueryString if we don't have a
	HttpWorkerRequest.

	* HttpUtility.cs: fixed Decode and Encode.

2002-06-25  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpApplication.cs:
	* HttpContext.cs: added System.Web.SessionState namespace.

	* HttpSessionState.cs: removed. It is under
	System.Web.SessionState.

2002-06-10  Duncan Mak  <duncan@ximian.com>

	* HttpBrowserCapabilities.cs (BackgroundSounds): Fixed typo.

2002-06-04  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpRequest.cs: implemented Browser property.

2002-06-03  Gonzalo Paniagua Javier <gonzalo@ximian.com>

	* HttpBrowserCapabilities.cs: stubbed out.

2002-05-18  Miguel de Icaza  <miguel@ximian.com>

	* HttpRuntime.cs: Reformat file.

2002-05-07  Duncan Mak  <duncan@ximian.com>

	* HttpBrowserCapabilities.cs: Added, replacing
	HttpBrowserCapabilites because of typo.

	* HttpBrowserCapabilites.cs: Removed, replaced by above.

	* HttpRequest.cs (Browser): Fixed typo.

2002-04-12  Patrik Torstensson <patrik.torstensson@labs2.com>

	* HttpApplication.cs: Minor updates
	* HttpApplicationState.cs: Ready.
	* HttpClientCertificate.cs: Signature updates
	* HttpValueCollection.cs: ready
	* HttpStaticObjectsCollection.cs: ready
	* HttpResponseHeader.cs: made internal only
	* HttpResponse.cs: Signature updates
	* HttpPostedFile.cs: ready
	* HttpCacheVaryByHeaders.cs: ready (except communication to policy)
	* HttpCacheVaryByParams.cs: ready (except communication to policy)
	
	System.Web is now over 60% ready.. 

2002-04-11  Patrik Torstensson <patrik.torstensson@labs2.com>

	* HttpException.cs: 95% ready, only windows dependent code left
	* HttpFileCollection.cs: Finished.
	* HttpRequest.cs: Minor fixes and fixed signature problems
	* HttpResponse.cs: Implementation of missing methods and signature problems
	* HttpResponseHeader.cs: Fixed signature problems
	* HttpRuntime.cs: Fixed signature problems
	* HttpServerUtility.cs: Added support for HttpApplication
	* HttpSessionState.cs: Fixed signature issues
	* HttpUtility.cs: fixed signature issues
	* HttpValueCollection.cs: Support for cookie parsing and fixed signature issues
	* HttpWorkerRequest.cs: Fixed small signature issue
	* HttpWriter.cs: Fixed signature issue
	* HttpApplication.cs: Basic implementation
	* HttpApplicationState.cs: Small fixes to support major change comming up
	* HttpBrowserCapabilities.cs: Added Type method
	* HttpClientCertificate.cs: Almost ready, needs to parse certificate.
	* HttpContext.cs: Fixed signature issues and added last methods.
	* HttpCookie.cs: Full implementation
	* HttpCookieCollection.cs: Full implementation
	* TraceContext.cs: Methods implemented.
	* HttpPostedFile.cs: Placeholder
	* HttpStaticObjectsCollection.cs: Placeholder
	* HttpModuleCollection.cs: Ready, will be used during the major revamp.
	
	* Fixed a number of other small signature problems also (class status page)
	
	
2002-04-10  Patrik Torstensson <patrik.torstensson@labs2.com>

    * HttpWorkerRequest.EndOfSendNotification.cs Removed (included in WorkerRequest)
    * Checkin of all new files (noted in last changenote)

2002-04-10  Patrik Torstensson <patrik.torstensson@labs2.com>

    * HttpContext.cs: First implementation (basic support, few methods left to impl)
    * HttpException.cs: Partial implementation (basic support)
    * HttpHelper.cs: Header parse helper, used by runtime (non public)
    * HttpRequest.cs: Implementation (all methods there, not all fully impl)
    * HttpRequestStream.cs: Full implementation
    * HttpResponse.cs: Partial implementation(almost all methods)
    * HttpResponseHeader.cs: Header helper
    * HttpResponseStream.cs: Full implementation - Response stream support
    * HttpResponseStreamProxy.cs: Implementation - filter support
    * HttpRuntime.cs: Rewrite to support one IHttpModule (use for testing the runtime)
	* HttpServerUtility.cs: Implemented usage of HttpContext for methods
	                        and moved encoding functions to HttpUtility.

    * HttpUtility.cs: Added encoding/decoding functions from HttpServerUtility and
                      added the Attribute encoding functions.

    * HttpValueCollection.cs: Implementation.
    * HttpWorkerRequest.cs: Rewrite and implementation of all methods (ready)
    * HttpWriter.cs: Implementation (with filter support)    

    * HttpFileCollection: Added dummy class (placeholder)
    * HttpApplication.cs: Added dummy class (placeholder)
    * HttpApplicationState.cs: Added dummy class (placeholder)
    * HttpBrowserCapabilities.cs: Added dummy class (placeholder)
    * HtttpCachePolicy.cs: Added dummy class (placeholder)
    * HttpClientCertificate.cs: Added dummy class (placeholder)
    * HttpSessionState.cs: Added dummy class (placeholder)
    * TraceContext.cs: Added dummy class (placeholder)
    

2002/04/10  Nick Drochak <ndrochak@gol.com>

	* HttpServerUtility.cs: Fix build breaker.

2002-03-28  Wictor Wil�n  <wictor@iBizkit.se>

	* HttpServerUtils.cs : Added some more functionality
	
2002-03-28  Martin Baulig  <martin@gnome.org>

	* HttpServerUtils.cs (UrlDecode): You cannot implicitly cast a
	char to a string, use ToString() instead.

2002-03-16  Gaurav Vaish  <gavish@iitk.ac.in>

	* WebCategoryAttribute.cs
	                       : Added private attribute.

2002-03-16  Gaurav Vaish  <gavish@iitk.ac.in>

	* HttpRuntime.cs       : Stubbed methods for
	          FormatStringResource(...) in agreement with the various
	          overloads available at String.Format(...)

2002-01-08  Gaurav Vaish  <gavish@iitk.ac.in>

	* TODOAttribute.cs     : Added, as an internal class to the assembly

2002-01-03  Nick Drochak  <ndrochak@gol.com>

	* HttpRuntime.cs: remove uneeded exception variable from catch and
	initialize remaining instance members to avoid compile warnings

2002-01-02  Nick Drochak  <ndrochak@gol.com>

	* HttpRuntime.cs: fix spelling error/variable name change.

2001-12-18  Gaurav Vaish <gvaish@iitk.ac.in>

        * HttpRuntime.cs       : Initial implementation

2001-08-29  Bob Smith  <bob@thestuff.net>

        * HttpWorkerRequest.cs: Partial Implementation.

2001-08-16  Bob Smith  <bob@thestuff.net>

         * HttpCookieCollection.cs, HttpCookie.cs: Bug fixes.

2001-08-09  Bob Smith  <bob@thestuff.net>

         * BeginEventHandler.cs: Implemented.
         * EndEventHandler.cs: Implemented.
         * HttpCacheability.cs: Implemented.
         * HttpCacheRevalidation.cs: Implemented.
         * HttpCacheValidateHandler.cs: Implemented.
         * HttpCookieCollection.cs: Implemented.
         * HttpCookie.cs: Implemented.
         * HttpValidationStatus.cs: Implemented.
         * HttpWorkerRequest.EndOfSendNotification.cs: Implemented.
         * IHttpAsyncHandler.cs: Implemented.
         * IHttpHandler.cs: Implemented.
         * IHttpHandlerFactory.cs: Implemented.
         * IHttpModule.cs: Implemented.
         * ProcessShutdownReason.cs: Implemented.
         * ProcessStatus.cs: Implemented.
         * TraceMode.cs: Implemented.
