Index: Test/System.Windows.Forms/ControlTest.cs
===================================================================
--- Test/System.Windows.Forms/ControlTest.cs	(revision 48259)
+++ Test/System.Windows.Forms/ControlTest.cs	(working copy)
@@ -590,6 +590,62 @@
 			delegateCalled = true;
 		}
 
+
+		  public void InvokeTest2 () {                       
+			Control c = null;
+                        Control parent = null;
+                        Control grandParent = null;
+                        delegateCalled = false;
+                        try {
+                                c = new Control ();
+                                parent = new Control ();
+                                grandParent = new Control ();
+                                parent.Controls.Add(c);
+                                grandParent.Controls.Add(parent);
+                                IAsyncResult result;
+                                grandParent.CreateControl ();
+                                result = c.BeginInvoke (new TestDelegate (delegate_call));
+                                c.EndInvoke (result);
+                                Assert.AreEqual (true, delegateCalled, "Invoke2");
+                        } finally {
+                                if (c != null)
+                                        c.Dispose ();
+                                if (parent != null)
+                                        parent.Dispose ();
+                                if (grandParent != null)
+                                        grandParent.Dispose ();
+                                                                                                    
+                        }
+                }
+
+		[Test]
+                [ExpectedException(typeof(System.InvalidOperationException))]  
+	        public void InvokeException2 () {
+                        Control c = null;
+                        Control parent = null;
+                        Control grandParent = null;
+                        delegateCalled = false;
+                        try {
+                                c = new Control ();
+                                parent = new Control ();
+                                grandParent = new Control ();
+                                parent.Controls.Add(c);
+                                grandParent.Controls.Add(parent);
+                                IAsyncResult result;
+                                result = c.BeginInvoke (new TestDelegate (delegate_call));
+                                c.EndInvoke (result);
+                                Assert.AreEqual (true, delegateCalled, "Invoke2");
+                        } finally {
+                                if (c != null)
+                                        c.Dispose ();
+                                if (parent != null)
+                                        parent.Dispose ();
+                                if (grandParent != null)
+                                        grandParent.Dispose ();
+                                                                                                    
+                        }
+                }
+
 		[Test]
 		public void FindFormTest () {
 			Form f = new Form ();
Index: Test/System.Windows.Forms/ChangeLog
===================================================================
--- Test/System.Windows.Forms/ChangeLog	(revision 48259)
+++ Test/System.Windows.Forms/ChangeLog	(working copy)
@@ -1,3 +1,6 @@
+2005-08-11  Umadevi S <sumadevi@novell.com>
+	* ControlTest.cs : Added more cases for BeginInvoke Test
+
 2005-08-10  Ritvik Mayank  <mritvik@novell.com>
 
 	* ControlTest.cs : Commented out test for GetChildAtPointSkip (feature not
Index: System.Windows.Forms/Control.cs
===================================================================
--- System.Windows.Forms/Control.cs	(revision 48257)
+++ System.Windows.Forms/Control.cs	(working copy)
@@ -633,7 +633,23 @@
 		#endregion	// Internal Properties
 
 		#region Private & Internal Methods
-		internal static IAsyncResult BeginInvokeInternal (Delegate method, object [] args) {
+		internal IAsyncResult BeginInvokeInternal (Delegate method, object [] args) {
+
+			Control temp = this.parent;
+                        bool hasHandle = false;
+                        if (!IsHandleCreated) {
+                                while (temp != null)
+                                {
+                                       if (temp.IsHandleCreated) {
+                                                hasHandle = true;
+                                                break;
+                                        }
+                                        temp = temp.parent;
+                                }
+                                if (!hasHandle)
+                                        throw new InvalidOperationException("Cannot call Invoke or InvokeAsync on a control until the window handle is created");
+                        }
+                                        
 			AsyncMethodResult result = new AsyncMethodResult ();
 			AsyncMethodData data = new AsyncMethodData ();
 
@@ -652,6 +668,7 @@
 #endif
 
 			XplatUI.SendAsyncMethod (data);
+			method.DynamicInvoke(args);			
 			return result;
 		}
 
@@ -1564,12 +1581,8 @@
 		[Localizable(true)]
 		public ImeMode ImeMode {
 			get {
-				 if (ime_mode == DefaultImeMode) {
-                                	if (parent != null)
-                                                return parent.ImeMode;
-                                        else
-                                                return ImeMode.NoControl; // default value
-                                }
+				if (ime_mode == DefaultImeMode) 
+					return parent != null ? parent.ImeMode : ImeMode.NoControl;
 				return ime_mode;
 			}
 
@@ -1687,11 +1700,12 @@
 					if (!parent.Controls.Contains(this)) {
 						parent.Controls.Add(this);
 					}
+					
+					if (IsHandleCreated) {
+						XplatUI.SetParent(Handle, value.Handle);
+						InitLayout();
+					}
 
-					XplatUI.SetParent(Handle, value.Handle);
-
-					InitLayout();
-
 					OnParentChanged(EventArgs.Empty);
 				}
 			}
@@ -1771,13 +1785,8 @@
 		[Localizable(true)]
 		public virtual RightToLeft RightToLeft {
 			get {
-				if (right_to_left == RightToLeft.Inherit) {
-					if (parent != null)
-						return parent.RightToLeft;
-					else
-						return RightToLeft.No; // default value
-				}
-				return right_to_left;
+				if (right_to_left == RightToLeft.Inherit)
+					return parent != null ? parent.RightToLeft : RightToLeft.No; 				     return right_to_left;
 			}
 
 			set {
@@ -2574,7 +2583,7 @@
 		}
 
 		public virtual void ResetText() {
-			text = "";
+			text = String.Empty;
 		}
 
 		public void ResumeLayout() {
Index: System.Windows.Forms/ChangeLog
===================================================================
--- System.Windows.Forms/ChangeLog	(revision 48256)
+++ System.Windows.Forms/ChangeLog	(working copy)
@@ -1,4 +1,8 @@
 2005-08-11 Umadevi S <sumadevi@novell.com>
+	* Control.cs: Fixed BeginInvoke to fire event, check if handle exists to start.
+	 
+
+2005-08-11 Umadevi S <sumadevi@novell.com>
 	* Contorl.cs: Fixed ResetRightToLeft and ResetImeMode to work correctly
 
 2005-08-10  Umadevi S <sumadevi@novell.com>
