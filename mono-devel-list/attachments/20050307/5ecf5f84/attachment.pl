Index: System.Web.UI/Control.cs
===================================================================
--- System.Web.UI/Control.cs	(revision 41482)
+++ System.Web.UI/Control.cs	(working copy)
@@ -20,10 +20,10 @@
 // distribute, sublicense, and/or sell copies of the Software, and to
 // permit persons to whom the Software is furnished to do so, subject to
 // the following conditions:
-// 
+//
 // The above copyright notice and this permission notice shall be
 // included in all copies or substantial portions of the Software.
-// 
+//
 // THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 // EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 // MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
@@ -74,11 +74,11 @@
 		EventHandlerList _events;
 		RenderMethod _renderMethodDelegate;
 		int defaultNumberID;
- 
+
 		DataBindingCollection dataBindings;
 		Hashtable pendingVS; // may hold unused viewstate data from child controls
-		
 
+
 		/*************/
 		int stateMask;
 		const int ENABLE_VIEWSTATE 	= 1;
@@ -98,7 +98,7 @@
 		const int LOADED		= 1 << 14;
 		const int PRERENDERED		= 1 << 15;
 		/*************/
-		
+
 		static Control ()
 		{
 			defaultNameArray = new string [100];
@@ -154,23 +154,23 @@
 		[WebSysDescription ("An Identification of the control that is rendered.")]
 #if NET_2_0
 		[Themeable (true)]
-#endif                
+#endif
                 public virtual bool EnableViewState {
                         get { return ((stateMask & ENABLE_VIEWSTATE) != 0); }
 			set { SetMask (ENABLE_VIEWSTATE, value); }
                 }
-		
+
 		[MergableProperty (false), ParenthesizePropertyName (true)]
 		[WebSysDescription ("The name of the control that is rendered.")]
 #if NET_2_0
 		[Filterable (true), Themeable (true)]
-#endif                
+#endif
 
                 public virtual string ID {
                         get {
 				return (((stateMask & ID_SET) != 0) ? _userId : null);
                         }
-			
+
                         set {
 				if (value == "")
 					value = null;
@@ -180,7 +180,7 @@
 				NullifyUniqueID ();
                         }
                 }
-		
+
 		[DesignerSerializationVisibility (DesignerSerializationVisibility.Hidden)]
 		[Browsable (false)]
 		[WebSysDescription ("The container that this control is part of. The control's name has to be unique within the container.")]
@@ -202,7 +202,7 @@
 		[WebSysDescription ("The webpage that this control resides on.")]
 #if NET_2_0
 		[Bindable (true)]
-#endif                
+#endif
 		public virtual Page Page //DIT
                 {
                         get
@@ -282,11 +282,11 @@
 			else
 				stateMask &= ~m;
 		}
-		
+
 		[DefaultValue (true), Bindable (true), WebCategory ("Behavior")]
 		[WebSysDescription ("Visiblity state of the control.")]
 #if NET_2_0
-		[Localizable (true)]		
+		[Localizable (true)]
 #endif
                 public virtual bool Visible {
                         get {
@@ -449,7 +449,7 @@
 						pendingVS.Remove (index);
 						if (pendingVS.Count == 0)
 							pendingVS = null;
-					
+
 						control.LoadViewStateRecursive (vs);
 					}
 				}
@@ -457,7 +457,7 @@
 
 			if ((stateMask & LOADED) != 0)
 				control.LoadRecursive ();
-			
+
 			if ((stateMask & PRERENDERED) != 0)
 				control.PreRenderRecursiveInternal ();
 		}
@@ -511,25 +511,31 @@
 			return FindControl (id, 0);
                 }
 
-		Control LookForControlByName (string id)
-		{
-			if (!HasControls ())
-				return null;
+				Control LookForControlByName (string id)
+				{
+					if (!HasControls ())
+						return null;
+					ArrayList foundControls = new ArrayList();
+					foreach (Control c in Controls) {
+						if (String.Compare (id, c._userId, true) == 0)
+							foundControls.Add(c);
 
-			foreach (Control c in Controls) {
-				if (String.Compare (id, c._userId, true) == 0)
-					return c;
-
-				if ((c.stateMask & IS_NAMING_CONTAINER) == 0 && c.HasControls ()) {
-					Control child = c.LookForControlByName (id);
-					if (child != null)
-						return child;
+						if ((c.stateMask & IS_NAMING_CONTAINER) == 0 && c.HasControls ()) {
+							Control child = c.LookForControlByName (id);
+							if (child != null)
+								foundControls.Add(c);
+						}
+					}
+					if(foundControls.Count > 1)
+						throw new HttpException("Found " + foundControls.Count + " components with same ID - " + id);
+					else if(foundControls.Count == 0)
+						return null;
+					else
+						return (Control) foundControls[0];
 				}
-			}
 
-			return null;
-		}
-		
+
+
                 protected virtual Control FindControl (string id, int pathOffset)
                 {
 			EnsureChildControls ();
@@ -548,7 +554,7 @@
 			int colon = id.IndexOf (':', pathOffset);
 			if (colon == -1)
 				return LookForControlByName (id.Substring (pathOffset));
-			
+
 			string idfound = id.Substring (pathOffset, colon - pathOffset);
 			namingContainer = LookForControlByName (idfound);
 			if (namingContainer == null)
@@ -620,7 +626,7 @@
                                 if (eh != null) eh(this, e);
                         }
                 }
-                
+
                 protected void RaiseBubbleEvent(object source, EventArgs args)
                 {
 			Control c = Parent;
@@ -667,7 +673,7 @@
 
                         stateMask |= TRACK_VIEWSTATE;
                 }
-                
+
                 public virtual void Dispose()
                 {
                         if (_events != null)
@@ -761,19 +767,19 @@
                 {
 			#if NET_2_0
 			bool foundDataItem = false;
-			
+
 			if ((stateMask & IS_NAMING_CONTAINER) != 0 && Page != null) {
 				object o = DataBinder.GetDataItem (this, out foundDataItem);
 				if (foundDataItem)
 					Page.PushDataItemContext (o);
 			}
-			
+
 			try {
 			#endif
-				
+
 				OnDataBinding (EventArgs.Empty);
 				DataBindChildren();
-			
+
 			#if NET_2_0
 			} finally {
 				if (foundDataItem)
@@ -781,16 +787,16 @@
 			}
 			#endif
                 }
-		
+
 		#if NET_2_0
 		protected virtual
 		#endif
-		
+
 		void DataBindChildren ()
 		{
 			if (!HasControls ())
 				return;
-			
+
 			int len = Controls.Count;
 			for (int i = 0; i < len; i++) {
 				Control c = Controls [i];
@@ -820,7 +826,7 @@
 
 			if (relativeUrl [0] == '#')
 				return relativeUrl;
-			
+
 			string ts = TemplateSourceDirectory;
 			if (ts == "" || !UrlUtils.IsRelativeUrl (relativeUrl))
 				return relativeUrl;
@@ -855,7 +861,7 @@
 				int len = Controls.Count;
 				for (int i=0;i<len;i++)
 				{
-					Control c = Controls[i];					
+					Control c = Controls[i];
 					c.UnloadRecursive (dispose);
 				}
 			}
@@ -872,7 +878,7 @@
 				OnPreRender (EventArgs.Empty);
 				if (!HasControls ())
 					return;
-				
+
 				int len = Controls.Count;
 				for (int i=0;i<len;i++)
 				{
@@ -889,7 +895,7 @@
 				if ((stateMask & IS_NAMING_CONTAINER) != 0)
 					namingContainer = this;
 
-				if (namingContainer != null && 
+				if (namingContainer != null &&
 				    namingContainer._userId == null &&
 				    namingContainer.AutoID)
 					namingContainer._userId = namingContainer.GetDefaultName () + "b";
@@ -902,7 +908,7 @@
 					c._namingContainer = namingContainer;
 					if (namingContainer != null && c._userId == null && c.AutoID)
 						c._userId = namingContainer.GetDefaultName () + "c";
-					c.InitRecursive (namingContainer);	
+					c.InitRecursive (namingContainer);
 				}
 			}
 
@@ -933,7 +939,7 @@
 					if (ctrlState == null)
 						continue;
 
-					if (controlList == null) 
+					if (controlList == null)
 					{
 						controlList = new ArrayList ();
 						controlStates = new ArrayList ();
@@ -950,7 +956,7 @@
 
 			return new Triplet (thisState, controlList, controlStates);
                 }
-                
+
 		internal void LoadViewStateRecursive (object savedState)
                 {
 			if (!EnableViewState || savedState == null)
@@ -979,12 +985,12 @@
 
 			stateMask |= VIEWSTATE_LOADED;
                 }
-                
+
                 void IParserAccessor.AddParsedSubObject(object obj)
                 {
                 	AddParsedSubObject(obj);
                 }
-                
+
                 DataBindingCollection IDataBindingsAccessor.DataBindings
                 {
                 	get
@@ -994,7 +1000,7 @@
                 		return dataBindings;
                 	}
                 }
-                
+
                 bool IDataBindingsAccessor.HasDataBindings
                 {
                 	get
@@ -1002,7 +1008,7 @@
                 		return (dataBindings!=null && dataBindings.Count>0);
                 	}
                 }
- 
+
 		internal bool AutoID
 		{
 			get { return (stateMask & AUTOID) != 0; }
@@ -1018,7 +1024,7 @@
                 {
 			AutoID = false;
                 }
-                
+
 		protected internal virtual void RemovedControl (Control control)
 		{
 			control.UnloadRecursive (false);
@@ -1030,48 +1036,48 @@
 #if NET_2_0
 		protected string GetWebResourceUrl (string resourceName)
 		{
-			return Page.GetWebResourceUrl (GetType(), resourceName); 
-		} 
+			return Page.GetWebResourceUrl (GetType(), resourceName);
+		}
 
 		string IUrlResolutionService.ResolveClientUrl (string url)
 		{
-			throw new NotImplementedException ();               
+			throw new NotImplementedException ();
 		}
 
-		ControlBuilder IControlBuilderAccessor.ControlBuilder { 
+		ControlBuilder IControlBuilderAccessor.ControlBuilder {
 			get {throw new NotImplementedException (); }
 		}
 
 		IDictionary IControlDesignerAccessor.GetDesignModeState ()
 		{
-			throw new NotImplementedException ();               
+			throw new NotImplementedException ();
 		}
-	
+
 		void IControlDesignerAccessor.SetDesignModeState (IDictionary designData)
 		{
-			throw new NotImplementedException ();               
+			throw new NotImplementedException ();
 		}
 
 		void IControlDesignerAccessor.SetOwnerControl (Control control)
 		{
-			throw new NotImplementedException ();               
+			throw new NotImplementedException ();
 		}
-		
-		IDictionary IControlDesignerAccessor.UserData { 
+
+		IDictionary IControlDesignerAccessor.UserData {
 			get { throw new NotImplementedException (); }
 		}
-       
+
 		ExpressionBindingCollection expressionBindings;
 
-		ExpressionBindingCollection IExpressionsAccessor.Expressions { 
-			get { 
+		ExpressionBindingCollection IExpressionsAccessor.Expressions {
+			get {
 				if (expressionBindings == null)
 					expressionBindings = new ExpressionBindingCollection ();
 				return expressionBindings;
-			} 
+			}
 		}
-		
-		bool IExpressionsAccessor.HasExpressions { 
+
+		bool IExpressionsAccessor.HasExpressions {
 			get {
 				return (expressionBindings != null && expressionBindings.Count > 0);
 			}
@@ -1082,16 +1088,16 @@
 		{
 			throw new NotImplementedException();
 		}
-		
+
 		protected internal virtual void LoadControlState (object state)
 		{
 		}
-		
+
 		protected internal virtual object SaveControlState ()
 		{
 			return null;
 		}
-		
+
 #endif
         }
 }
