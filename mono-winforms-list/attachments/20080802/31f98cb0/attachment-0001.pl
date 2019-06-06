Index: System.Windows.Forms/Control.cs
===================================================================
--- System.Windows.Forms/Control.cs	(revision 109230)
+++ System.Windows.Forms/Control.cs	(working copy)
@@ -2024,6 +2024,9 @@
 			if (form != null && form.WindowManager != null)
 				ThemeEngine.Current.ManagedWindowOnSizeInitializedOrChanged (form);
 		}
+
+		internal virtual void OnVScroll(ScrollType s) { }
+		internal virtual void OnHScroll(ScrollType s) { }
 		#endregion	// Private & Internal Methods
 
 		#region Public Static Properties
@@ -5437,7 +5440,17 @@
 					WmUpdateUIState (ref m);
 					return;
 				}
+				
+				case Msg.WM_VSCROLL: {
+					WmVScroll(ref m);
+					return;
+				}
 
+				case Msg.WM_HSCROLL: {
+					WmHScroll(ref m);
+					return;
+				}
+
 				default:
 					DefWndProc(ref m);
 					return;
@@ -5931,6 +5944,14 @@
 			}
 		}
 
+		private void WmVScroll (ref Message m) {
+			OnVScroll((ScrollType)m.WParam);
+		}
+
+		private void WmHScroll (ref Message m) {
+			OnHScroll((ScrollType)m.WParam);
+		}
+
 		#endregion
 
 		#region OnXXX methods
Index: System.Windows.Forms/ListBox.cs
===================================================================
--- System.Windows.Forms/ListBox.cs	(revision 109230)
+++ System.Windows.Forms/ListBox.cs	(working copy)
@@ -2179,6 +2179,15 @@
 				XplatUI.ScrollWindow (Handle, items_area, 0, delta, false);
 		}
 
+		internal override void OnVScroll (ScrollType s) {
+			vscrollbar.ScrollBy(s);
+		}
+
+		internal override void OnHScroll(ScrollType s)
+		{
+			hscrollbar.ScrollBy(s);
+		}
+
 		#endregion Private Methods
 
 #if NET_2_0
Index: System.Windows.Forms/ListView.cs
===================================================================
--- System.Windows.Forms/ListView.cs	(revision 109230)
+++ System.Windows.Forms/ListView.cs	(working copy)
@@ -3317,6 +3317,16 @@
 		{
 			return true;
 		}
+
+		internal override void OnVScroll(ScrollType s)
+		{
+			v_scroll.ScrollBy(s);
+		}
+
+		internal override void OnHScroll(ScrollType s)
+		{
+			h_scroll.ScrollBy(s);
+		}
 		#endregion	// Internal Methods Properties
 
 		#region Protected Methods
Index: System.Windows.Forms/ScrollableControl.cs
===================================================================
--- System.Windows.Forms/ScrollableControl.cs	(revision 109230)
+++ System.Windows.Forms/ScrollableControl.cs	(working copy)
@@ -1117,6 +1117,16 @@
 			Invalidate(false);
 			ResumeLayout(false);
 		}
+
+		internal override void OnVScroll(ScrollType s)
+		{
+			vscrollbar.ScrollBy(s);
+		}
+
+		internal override void OnHScroll(ScrollType s)
+		{
+			hscrollbar.ScrollBy(s);
+		}
 		#endregion	// Internal & Private Methods
 
 #if NET_2_0
Index: System.Windows.Forms/ScrollBar.cs
===================================================================
--- System.Windows.Forms/ScrollBar.cs	(revision 109230)
+++ System.Windows.Forms/ScrollBar.cs	(working copy)
@@ -668,6 +668,12 @@
 		}
 
 		private void SendWMScroll(ScrollBarCommands cmd) {
+			// Since the WM_?SCROLL messages actually trigger
+			// scrolling a control at the same time as the
+			// control responds to the ScrollBar events,
+			// having the ScrollBar send the WM_?SCROLL event
+			// tends to cause a double scroll.
+			/*
 			if ((Parent != null) && Parent.IsHandleCreated) {
 				if (vert) {
 					XplatUI.SendMessage(Parent.Handle, Msg.WM_VSCROLL, (IntPtr)cmd, implicit_control ? IntPtr.Zero : Handle);
@@ -675,6 +681,7 @@
 					XplatUI.SendMessage(Parent.Handle, Msg.WM_HSCROLL, (IntPtr)cmd, implicit_control ? IntPtr.Zero : Handle);
 				}
 			}
+			*/
 		}
 
 		protected virtual void OnValueChanged (EventArgs e)
@@ -1521,6 +1528,35 @@
 				Invalidate (region_to_invalidate);
 			region_to_invalidate.Dispose ();
 		}
+
+		internal void ScrollBy(ScrollType s){
+			switch (s){
+				case ScrollType.SB_LINEUP: {
+					SmallDecrement();
+					return;
+				}
+				case ScrollType.SB_LINEDOWN: {
+					SmallIncrement();
+					return;
+				}
+				case ScrollType.SB_PAGEUP: {
+					LargeDecrement();
+					return;
+				}
+				case ScrollType.SB_PAGEDOWN: {
+					LargeIncrement();
+					return;
+				}
+				case ScrollType.SB_TOP: {
+					SetHomePosition();
+					return;
+				}
+				case ScrollType.SB_BOTTOM: {
+					SetEndPosition();
+					return;
+				}
+			}
+		}
 		#endregion //Private Methods
 #if NET_2_0
 		protected override void OnMouseWheel (MouseEventArgs e)
Index: System.Windows.Forms/ScrollType.cs
===================================================================
--- System.Windows.Forms/ScrollType.cs	(revision 0)
+++ System.Windows.Forms/ScrollType.cs	(revision 0)
@@ -0,0 +1,10 @@
+namespace System.Windows.Forms{
+    internal enum ScrollType{
+        SB_LINEUP =		0,
+        SB_LINEDOWN =	1,
+        SB_PAGEUP =		2,
+        SB_PAGEDOWN =	3,
+        SB_TOP =		6,
+        SB_BOTTOM =		7,
+    }
+}
\ No newline at end of file
Index: System.Windows.Forms/TextBoxBase.cs
===================================================================
--- System.Windows.Forms/TextBoxBase.cs	(revision 109230)
+++ System.Windows.Forms/TextBoxBase.cs	(working copy)
@@ -210,6 +210,16 @@
 				return;
 			base.PaintControlBackground (pevent);
 		}
+
+		internal override void OnVScroll(ScrollType s)
+		{
+			vscroll.ScrollBy(s);
+		}
+
+		internal override void OnHScroll(ScrollType s)
+		{
+			hscroll.ScrollBy(s);
+		}
 		#endregion	// Private and Internal Methods
 
 		#region Public Instance Properties
Index: System.Windows.Forms/TreeView.cs
===================================================================
--- System.Windows.Forms/TreeView.cs	(revision 109230)
+++ System.Windows.Forms/TreeView.cs	(working copy)
@@ -2310,6 +2310,16 @@
 		}
 #endif
 
+		internal override void OnVScroll(ScrollType s)
+		{
+			vbar.ScrollBy(s);
+		}
+
+		internal override void OnHScroll(ScrollType s)
+		{
+			hbar.ScrollBy(s);
+		}
+
 		#region Stuff for ToolTips
 #if NET_2_0
 		private void MouseEnteredItem (TreeNode item)