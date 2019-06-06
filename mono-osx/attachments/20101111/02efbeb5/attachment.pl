>From 15e57788c2f4847116571a6aed2edf9b27775607 Mon Sep 17 00:00:00 2001
From: Alex Shulgin <alexander.shulgin@yessoftware.com>
Date: Thu, 11 Nov 2010 13:03:09 +0200
Subject: [PATCH 1/2] Adding WebView delegate protocols.

---
 src/WebKit/Enums.cs |   19 +++++
 src/webkit.cs       |  186 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 203 insertions(+), 2 deletions(-)

diff --git a/src/WebKit/Enums.cs b/src/WebKit/Enums.cs
index 9b235bb..09f6dbc 100644
--- a/src/WebKit/Enums.cs
+++ b/src/WebKit/Enums.cs
@@ -57,4 +57,23 @@ namespace MonoMac.WebKit {
 	public enum WebCacheModel {
 		DocumentViewer, DocumentBrowser, PrimaryWebBrowser
 	}
+
+	[Flags]
+	public enum WebDragDestinationAction {
+		None    = 0,
+		DHtml   = 1,
+		Edit    = 2,
+		Load    = 4,
+		Any     = int.MaxValue
+	} 
+
+	[Flags]
+	public enum WebDragSourceAction {
+		None         = 0,
+		DHtml        = 1,
+		Image        = 2,
+		Link         = 4,
+		Selection    = 8,
+		Any          = int.MaxValue
+	} 
 }
diff --git a/src/webkit.cs b/src/webkit.cs
index 9147bb1..c14e161 100644
--- a/src/webkit.cs
+++ b/src/webkit.cs
@@ -1251,6 +1251,49 @@ namespace MonoMac.WebKit {
 
 	}
 
+	[BaseType (typeof (NSObject))]
+	[Model]
+	interface WebFrameLoadDelegate {
+		[Export ("webView:didStartProvisionalLoadForFrame:")]
+		void DidStartProvisionalLoadForFrame (WebView sender, WebFrame frame);
+
+		[Export ("webView:didReceiveServerRedirectForProvisionalLoadForFrame:")]
+		void DidReceiveServerRedirectForProvisionalLoadForFrame (WebView sender, WebFrame frame);
+
+		[Export ("webView:didFailProvisionalLoadWithError:forFrame:")]
+		void DidFailProvisionalLoadWithErrorforFrame (WebView sender, NSError error, WebFrame frame);
+
+		[Export ("webView:didCommitLoadForFrame:")]
+		void DidCommitLoadForFrame (WebView sender, WebFrame frame);
+
+		[Export ("webView:didReceiveTitle:forFrame:")]
+		void DidReceiveTitle (WebView sender, string title, WebFrame frame);
+
+		[Export ("webView:didReceiveIcon:forFrame:")]
+		void DidReceiveIcon (WebView sender, NSImage image, WebFrame frame);
+
+		[Export ("webView:didFinishLoadForFrame:")]
+		void DidFinishLoadForFrame (WebView sender, WebFrame frame);
+
+		[Export ("webView:didFailLoadWithError:forFrame:")]
+		void DidFailLoadWithError (WebView sender, NSError error, WebFrame frame);
+
+		[Export ("webView:didChangeLocationWithinPageForFrame:")]
+		void DidChangeLocationWithinPageForFrame (WebView sender, WebFrame frame);
+
+		[Export ("webView:willPerformClientRedirectToURL:delay:fireDate:forFrame:")]
+		void WillPerformClientRedirectToUrl (WebView sender, NSUrl url, double seconds, NSDate date, WebFrame frame);
+
+		[Export ("webView:didCancelClientRedirectForFrame:")]
+		void DidCancelClientRedirectForFrame (WebView sender, WebFrame frame);
+
+		[Export ("webView:willCloseFrame:")]
+		void WillCloseFrame (WebView sender, WebFrame frame);
+
+		[Export ("webView:didClearWindowObject:forFrame:")]
+		void DidClearWindowObject (WebView webView, WebScriptObject windowObject, WebFrame frame);
+	}
+
 	[BaseType (typeof (NSView))]
 	interface WebFrameView {
 		[Export ("webFrame")]
@@ -1301,6 +1344,21 @@ namespace MonoMac.WebKit {
 		string AlternateTitle { get; set; }
 	}
 
+	[BaseType (typeof (NSObject))]
+	[Model]
+	interface WebOpenPanelResultListener {
+		[Abstract]
+		[Export ("chooseFilename:")]
+		void ChooseFilename (string fileName);
+
+		[Abstract]
+		[Export ("chooseFilenames:")]
+		void ChooseFilenames (string[] fileNames);
+
+		[Abstract]
+		[Export ("cancel")]
+		void Cancel ();
+	}
 
 	[BaseType (typeof (NSObject))]
 	interface WebPreferences {
@@ -1444,6 +1502,124 @@ namespace MonoMac.WebKit {
 		void SetException (string description);
 	}
 
+	[BaseType (typeof (NSObject))]
+	[Model]
+	interface WebUIDelegate {
+		[Export ("webView:createWebViewWithRequest:")]
+		WebView CreateWebViewWithRequest (WebView sender, NSUrlRequest request);
+
+		[Export ("webViewShow:")]
+		void WebViewShow (WebView sender);
+
+		[Export ("webView:createWebViewModalDialogWithRequest:")]
+		WebView CreateWebViewModalDialogWithRequest (WebView sender, NSUrlRequest request);
+
+		[Export ("webViewRunModal:")]
+		void WebViewRunModal (WebView sender);
+
+		[Export ("webViewClose:")]
+		void WebViewClose (WebView sender);
+
+		[Export ("webViewFocus:")]
+		void WebViewFocus (WebView sender);
+
+		[Export ("webViewUnfocus:")]
+		void WebViewUnfocus (WebView sender);
+
+		[Export ("webViewFirstResponder:")]
+		NSResponder WebViewFirstResponder (WebView sender);
+
+		[Export ("webView:makeFirstResponder:")]
+		void MakeFirstResponder (WebView sender, NSResponder responder);
+
+		[Export ("webView:setStatusText:")]
+		void SetStatusText (WebView sender, string text);
+
+		[Export ("webViewStatusText:")]
+		string WebViewStatusText (WebView sender);
+
+		[Export ("webViewAreToolbarsVisible:")]
+		bool WebViewAreToolbarsVisible (WebView sender);
+
+		[Export ("webView:setToolbarsVisible:")]
+		void SetToolbarsVisible (WebView sender, bool visible);
+
+		[Export ("webViewIsStatusBarVisible:")]
+		bool WebViewIsStatusBarVisible (WebView sender);
+
+		[Export ("webView:setStatusBarVisible:")]
+		void SetStatusBarVisible (WebView sender, bool visible);
+
+		[Export ("webViewIsResizable:")]
+		bool WebViewIsResizable (WebView sender);
+
+		[Export ("webView:setResizable:")]
+		void SetResizable (WebView sender, bool resizable);
+
+		[Export ("webView:setFrame:")]
+		void SetFrame (WebView sender, RectangleF frame);
+
+		[Export ("webViewFrame:")]
+		RectangleF WebViewFrame (WebView sender);
+
+		[Export ("webView:runJavaScriptAlertPanelWithMessage:initiatedByFrame:")]
+		void RunJavaScriptAlertPanelWithMessage (WebView sender, string message, WebFrame frame);
+
+		[Export ("webView:runJavaScriptConfirmPanelWithMessage:initiatedByFrame:")]
+		bool RunJavaScriptConfirmPanelWithMessage (WebView sender, string message, WebFrame frame);
+
+		[Export ("webView:runJavaScriptTextInputPanelWithPrompt:defaultText:initiatedByFrame:")]
+		string RunJavaScriptTextInputPanelWithPrompt (WebView sender, string prompt, string defaultText, WebFrame frame);
+
+		[Export ("webView:runBeforeUnloadConfirmPanelWithMessage:initiatedByFrame:")]
+		bool RunBeforeUnloadConfirmPanelWithMessage (WebView sender, string message, WebFrame frame);
+
+		[Export ("webView:runOpenPanelForFileButtonWithResultListener:")]
+		void RunOpenPanelForFileButtonWithResultListener (WebView sender, NSObject resultListener);
+
+		[Export ("webView:runOpenPanelForFileButtonWithResultListener:allowMultipleFiles:")]
+		void RunOpenPanelForFileButtonWithResultListener (WebView sender, NSObject resultListener, bool allowMultipleFiles);
+
+		[Export ("webView:mouseDidMoveOverElement:modifierFlags:")]
+		void MouseDidMoveOverElement (WebView sender, NSDictionary elementInformation, uint modifierFlags);
+
+		[Export ("webView:contextMenuItemsForElement:defaultMenuItems:")]
+		NSMenuItem[] ContextMenuItemsForElement (WebView sender, NSDictionary element, NSMenuItem[] defaultMenuItems);
+
+		[Export ("webView:validateUserInterfaceItem:defaultValidation:")]
+		bool ValidateUserInterfaceItem (WebView webView, NSObject item, bool defaultValidation);
+
+		[Export ("webView:shouldPerformAction:fromSender:")]
+		bool ShouldPerformAction (WebView webView, Selector action, NSObject sender);
+
+		[Export ("webView:dragDestinationActionMaskForDraggingInfo:")]
+		uint DragDestinationActionMaskForDraggingInfo (WebView webView, NSObject draggingInfo);
+
+		[Export ("webView:willPerformDragDestinationAction:forDraggingInfo:")]
+		void WillPerformDragDestinationActionforDraggingInfo (WebView webView, WebDragDestinationAction action, NSObject draggingInfo);
+
+		[Export ("webView:dragSourceActionMaskForPoint:")]
+		uint DragSourceActionMaskForPoint (WebView webView, PointF point);
+
+		[Export ("webView:willPerformDragSourceAction:fromPoint:withPasteboard:")]
+		void WillPerformDragSourceAction (WebView webView, WebDragSourceAction action, PointF point, NSPasteboard pasteboard);
+
+		[Export ("webView:printFrameView:")]
+		void PrintFrameView (WebView sender, WebFrameView frameView);
+
+		[Export ("webViewHeaderHeight:")]
+		float WebViewHeaderHeight (WebView sender);
+
+		[Export ("webViewFooterHeight:")]
+		float WebViewFooterHeight (WebView sender);
+
+		[Export ("webView:drawHeaderInRect:")]
+		void DrawHeaderInRect (WebView sender, RectangleF rect);
+
+		[Export ("webView:drawFooterInRect:")]
+		void DrawFooterInRect (WebView sender, RectangleF rect);
+	}
+
 	[BaseType (typeof (NSView))]
 	interface WebView {
 		[Export ("canShowMIMEType:")]
@@ -1475,8 +1651,11 @@ namespace MonoMac.WebKit {
 		[Export ("close")]
 		void Close ();
 
+		[Wrap ("WeakUIDelegate")]
+		WebUIDelegate UIDelegate { get; set; }
+
 		[Export ("UIDelegate")]
-		NSObject UIDelegate { get; set; }
+		NSObject WeakUIDelegate { get; set; }
 
 		[Export ("mainFrame")]
 		WebFrame MainFrame { get; }
@@ -1564,8 +1743,11 @@ namespace MonoMac.WebKit {
 		[Export ("downloadDelegate")]
 		NSObject DownloadDelegate { get; set; }
 
+		[Wrap ("WeakFrameLoadDelegate")]
+		WebFrameLoadDelegate FrameLoadDelegate { get; set; }
+
 		[Export ("frameLoadDelegate")]
-		NSObject FrameLoadDelegate { get; set; }
+		NSObject WeakFrameLoadDelegate { get; set; }
 
 		[Export ("policyDelegate")]
 		NSObject PolicyDelegate { get; set; }
-- 
1.7.2

