Index: Test/System.Diagnostics/TraceSourceTest.cs
===================================================================
--- Test/System.Diagnostics/TraceSourceTest.cs	(revision 0)
+++ Test/System.Diagnostics/TraceSourceTest.cs	(revision 0)
@@ -0,0 +1,76 @@
+//
+// TraceSourceTest.cs
+//
+// Author:
+//	Atsushi Enomoto  <atsushi@ximian.com>
+//
+// Copyright (C) 2007 Novell, Inc.
+//
+
+//
+// Permission is hereby granted, free of charge, to any person obtaining
+// a copy of this software and associated documentation files (the
+// "Software"), to deal in the Software without restriction, including
+// without limitation the rights to use, copy, modify, merge, publish,
+// distribute, sublicense, and/or sell copies of the Software, and to
+// permit persons to whom the Software is furnished to do so, subject to
+// the following conditions:
+// 
+// The above copyright notice and this permission notice shall be
+// included in all copies or substantial portions of the Software.
+// 
+// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
+// LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
+// OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
+// WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+//
+
+
+#if NET_2_0
+
+using NUnit.Framework;
+using System;
+using System.Text;
+using System.Collections;
+using System.Configuration;
+using System.Diagnostics;
+
+namespace MonoTests.System.Diagnostics
+{
+	[TestFixture]
+	public class TraceSourceTest
+	{
+		[Test]
+		[ExpectedException (typeof (ArgumentNullException))]
+		public void ConstructorNullName ()
+		{
+			new TraceSource (null);
+		}
+
+		[Test]
+		public void DefaultValues ()
+		{
+			TraceSource ts = new TraceSource ("foo");
+			Assert.AreEqual ("foo", ts.Name, "#1");
+			Assert.IsNotNull (ts.Switch, "#2");
+			Assert.AreEqual (SourceLevels.Off, ts.Switch.Level, "#3");
+			Assert.IsNotNull (ts.Listeners, "#4");
+			Assert.AreEqual (1, ts.Listeners.Count, "#5");
+			Assert.IsNotNull (ts.Attributes, "#6");
+			Assert.AreEqual (0, ts.Attributes.Count, "#7");
+		}
+
+		[Test]
+		[ExpectedException (typeof (ArgumentNullException))]
+		public void SetSourceSwitchNull ()
+		{
+			TraceSource ts = new TraceSource ("foo");
+			ts.Switch = null;
+		}
+	}
+}
+
+#endif
Index: Test/System.Diagnostics/SourceSwitchTest.cs
===================================================================
--- Test/System.Diagnostics/SourceSwitchTest.cs	(revision 0)
+++ Test/System.Diagnostics/SourceSwitchTest.cs	(revision 0)
@@ -0,0 +1,104 @@
+//
+// SourceSwitchTest.cs
+//
+// Author:
+//	Atsushi Enomoto  <atsushi@ximian.com>
+//
+// Copyright (C) 2007 Novell, Inc.
+//
+
+//
+// Permission is hereby granted, free of charge, to any person obtaining
+// a copy of this software and associated documentation files (the
+// "Software"), to deal in the Software without restriction, including
+// without limitation the rights to use, copy, modify, merge, publish,
+// distribute, sublicense, and/or sell copies of the Software, and to
+// permit persons to whom the Software is furnished to do so, subject to
+// the following conditions:
+// 
+// The above copyright notice and this permission notice shall be
+// included in all copies or substantial portions of the Software.
+// 
+// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
+// LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
+// OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
+// WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+//
+
+
+#if NET_2_0
+
+using NUnit.Framework;
+using System;
+using System.Text;
+using System.Collections;
+using System.Configuration;
+using System.Diagnostics;
+
+namespace MonoTests.System.Diagnostics
+{
+	[TestFixture]
+	public class SourceSwitchTest
+	{
+		[Test]
+		public void ConstructorNullName ()
+		{
+			SourceSwitch s = new SourceSwitch (null);
+			Assert.IsNull (s.DisplayName);
+		}
+
+		[Test]
+		public void ConstructorNullDefaultValue ()
+		{
+			SourceSwitch s = new SourceSwitch ("foo", null);
+		}
+
+		[Test]
+		public void ConstructorDefault ()
+		{
+			SourceSwitch s = new SourceSwitch ("foo");
+			Assert.AreEqual ("foo", s.DisplayName, "#1");
+			Assert.AreEqual (SourceLevels.Off, s.Level, "#2");
+			Assert.AreEqual (0, s.Attributes.Count, "#3");
+		}
+
+		[Test]
+		public void ShouldTrace ()
+		{
+			SourceSwitch s = new SourceSwitch ("foo");
+			s.Level = SourceLevels.Verbose;
+			Assert.IsTrue (s.ShouldTrace (TraceEventType.Critical), "#1");
+			Assert.IsTrue (s.ShouldTrace (TraceEventType.Error), "#2");
+			Assert.IsTrue (s.ShouldTrace (TraceEventType.Warning), "#3");
+			Assert.IsTrue (s.ShouldTrace (TraceEventType.Information), "#4");
+			Assert.IsTrue (s.ShouldTrace (TraceEventType.Verbose), "#5");
+			Assert.IsFalse (s.ShouldTrace (TraceEventType.Start), "#6");
+			Assert.IsFalse (s.ShouldTrace (TraceEventType.Stop), "#7");
+			Assert.IsFalse (s.ShouldTrace (TraceEventType.Suspend), "#8");
+			Assert.IsFalse (s.ShouldTrace (TraceEventType.Resume), "#9");
+			Assert.IsFalse (s.ShouldTrace (TraceEventType.Transfer), "#10");
+		}
+
+		[Test]
+		public void ShouldTrace2 ()
+		{
+			SourceSwitch s = new SourceSwitch ("foo");
+			s.Level = SourceLevels.ActivityTracing;
+			Assert.IsFalse (s.ShouldTrace (TraceEventType.Critical), "#1");
+			Assert.IsFalse (s.ShouldTrace (TraceEventType.Error), "#2");
+			Assert.IsFalse (s.ShouldTrace (TraceEventType.Warning), "#3");
+			Assert.IsFalse (s.ShouldTrace (TraceEventType.Information), "#4");
+			Assert.IsFalse (s.ShouldTrace (TraceEventType.Verbose), "#5");
+			Assert.IsTrue (s.ShouldTrace (TraceEventType.Start), "#6");
+			Assert.IsTrue (s.ShouldTrace (TraceEventType.Stop), "#7");
+			Assert.IsTrue (s.ShouldTrace (TraceEventType.Suspend), "#8");
+			Assert.IsTrue (s.ShouldTrace (TraceEventType.Resume), "#9");
+			Assert.IsTrue (s.ShouldTrace (TraceEventType.Transfer), "#10");
+		}
+	}
+}
+
+#endif
Index: Test/System.Diagnostics/ChangeLog
===================================================================
--- Test/System.Diagnostics/ChangeLog	(revision 71034)
+++ Test/System.Diagnostics/ChangeLog	(working copy)
@@ -1,3 +1,7 @@
+2007-01-17  Atsushi Enomoto  <atsushi@ximian.com>
+
+	* TRaceSourceTest.cs, SourceSwitchTest.cs : new tests.
+
 2007-01-02  Gert Driesen  <drieseng@users.sourceforge.net>
 
 	* ProcessTest.cs: Added null check tests.
Index: Test/System.Diagnostics/SwitchesTest.cs
===================================================================
--- Test/System.Diagnostics/SwitchesTest.cs	(revision 71034)
+++ Test/System.Diagnostics/SwitchesTest.cs	(working copy)
@@ -25,7 +25,7 @@
 		private StringBuilder ops = new StringBuilder ();
 		private const string expected = 
 			".ctor\n" +
-			"get_Value\n" +
+			"get_ValueFoo\n" +
 			"OnSwitchSettingChanged\n" +
 			"GetSetting\n";
 
@@ -35,9 +35,9 @@
 			ops.Append (".ctor\n");
 		}
 
-		public string Value {
+		public string ValueFoo {
 			get {
-				ops.Append ("get_Value\n");
+				ops.Append ("get_ValueFoo\n");
 				// ensure that the .config file is read in
 				int n = base.SwitchSetting;
 				// remove warning about unused variable
@@ -136,7 +136,7 @@
 #endif
 		public void NewSwitch ()
 		{
-			AssertEquals ("#NS:Value", "42", tns.Value);
+			AssertEquals ("#NS:ValueFoo", "42", tns.ValueFoo);
 			Assert ("#NS:Validate", tns.Validate());
 		}
 	}
Index: System.dll.sources
===================================================================
--- System.dll.sources	(revision 71034)
+++ System.dll.sources	(working copy)
@@ -436,6 +436,7 @@
 System.Diagnostics/AlphabeticalEnumConverter.cs
 System.Diagnostics/BooleanSwitch.cs
 System.Diagnostics/ConsoleTraceListener.cs
+System.Diagnostics/CorrelationManager.cs
 System.Diagnostics/CounterCreationDataCollection.cs
 System.Diagnostics/CounterCreationData.cs
 System.Diagnostics/CounterSampleCalculator.cs
@@ -488,6 +489,8 @@
 System.Diagnostics/ProcessThreadCollection.cs
 System.Diagnostics/ProcessThread.cs
 System.Diagnostics/ProcessWindowStyle.cs
+System.Diagnostics/SourceLevels.cs
+System.Diagnostics/SourceSwitch.cs
 System.Diagnostics/Switch.cs
 System.Diagnostics/Stopwatch.cs
 System.Diagnostics/TextWriterTraceListener.cs
@@ -495,10 +498,13 @@
 System.Diagnostics/ThreadState.cs
 System.Diagnostics/ThreadWaitReason.cs
 System.Diagnostics/Trace.cs
+System.Diagnostics/TraceEventCache.cs
+System.Diagnostics/TraceEventType.cs
 System.Diagnostics/TraceImpl.cs
 System.Diagnostics/TraceLevel.cs
 System.Diagnostics/TraceListenerCollection.cs
 System.Diagnostics/TraceListener.cs
+System.Diagnostics/TraceSource.cs
 System.Diagnostics/TraceSwitch.cs
 System.Diagnostics/Win32EventLog.cs
 System/FileStyleUriParser.cs
Index: System.Diagnostics/TraceSource.cs
===================================================================
--- System.Diagnostics/TraceSource.cs	(revision 0)
+++ System.Diagnostics/TraceSource.cs	(revision 0)
@@ -0,0 +1,186 @@
+//
+// TraceSource.cs
+//
+// Author:
+//	Atsushi Enomoto  <atsushi@ximian.com>
+//
+// Copyright (C) 2007 Novell, Inc.
+//
+
+//
+// Permission is hereby granted, free of charge, to any person obtaining
+// a copy of this software and associated documentation files (the
+// "Software"), to deal in the Software without restriction, including
+// without limitation the rights to use, copy, modify, merge, publish,
+// distribute, sublicense, and/or sell copies of the Software, and to
+// permit persons to whom the Software is furnished to do so, subject to
+// the following conditions:
+// 
+// The above copyright notice and this permission notice shall be
+// included in all copies or substantial portions of the Software.
+// 
+// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
+// LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
+// OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
+// WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+//
+
+#if NET_2_0
+
+using System;
+using System.Collections;
+using System.Collections.Specialized;
+
+namespace System.Diagnostics
+{
+	public class TraceSource
+	{
+		SourceSwitch source_switch;
+		TraceListenerCollection listeners =
+			new TraceListenerCollection ();
+		TraceEventCache cache = new TraceEventCache ();
+
+		public TraceSource (string name)
+			: this (name, SourceLevels.Off)
+		{
+		}
+
+		public TraceSource (string name, SourceLevels sourceLevels)
+		{
+			if (name == null)
+				throw new ArgumentNullException ("name");
+			source_switch = new SourceSwitch (name);
+			source_switch.Level = sourceLevels;
+		}
+
+		public StringDictionary Attributes {
+			get { return source_switch.Attributes; }
+		}
+
+		public TraceListenerCollection Listeners {
+			get { return listeners; }
+		}
+
+		public string Name {
+			get { return source_switch.DisplayName; }
+		}
+
+		public SourceSwitch Switch {
+			get { return source_switch; }
+			set {
+				if (value == null)
+					throw new ArgumentNullException ("value");
+				source_switch = value;
+			}
+		}
+
+		public void Close ()
+		{
+			lock (((ICollection) listeners).SyncRoot) {
+				foreach (TraceListener tl in listeners)
+					tl.Close ();
+			}
+		}
+
+		public void Flush ()
+		{
+			lock (((ICollection) listeners).SyncRoot) {
+				foreach (TraceListener tl in listeners)
+					tl.Flush ();
+			}
+		}
+
+		[Conditional ("TRACE")]
+		public void TraceData (
+			TraceEventType eventType, int id, object data)
+		{
+			if (!source_switch.ShouldTrace (eventType))
+				return;
+			lock (((ICollection) listeners).SyncRoot) {
+				foreach (TraceListener tl in listeners)
+					tl.TraceData (cache, Name, eventType, id, data);
+			}
+		}
+
+		[Conditional ("TRACE")]
+		public void TraceData (
+			TraceEventType eventType, int id, params object [] data)
+		{
+			if (!source_switch.ShouldTrace (eventType))
+				return;
+			lock (((ICollection) listeners).SyncRoot) {
+				foreach (TraceListener tl in listeners)
+					tl.TraceData (cache, Name, eventType, id, data);
+			}
+		}
+
+		[Conditional ("TRACE")]
+		public void TraceEvent (TraceEventType eventType, int id)
+		{
+			if (!source_switch.ShouldTrace (eventType))
+				return;
+			lock (((ICollection) listeners).SyncRoot) {
+				foreach (TraceListener tl in listeners)
+					tl.TraceEvent (cache, Name, eventType, id);
+			}
+		}
+
+		[Conditional ("TRACE")]
+		public void TraceEvent (TraceEventType eventType,
+			int id, string message)
+		{
+			if (!source_switch.ShouldTrace (eventType))
+				return;
+			lock (((ICollection) listeners).SyncRoot) {
+				foreach (TraceListener tl in listeners)
+					tl.TraceEvent (cache, Name, eventType, id, message);
+			}
+		}
+
+		[Conditional ("TRACE")]
+		public void TraceEvent (TraceEventType eventType,
+			int id, string format, params object [] args)
+		{
+			if (!source_switch.ShouldTrace (eventType))
+				return;
+			lock (((ICollection) listeners).SyncRoot) {
+				foreach (TraceListener tl in listeners)
+					tl.TraceEvent (cache, Name, eventType, id, format, args);
+			}
+		}
+
+		[Conditional ("TRACE")]
+		public void TraceInformation (string format)
+		{
+			TraceEvent (TraceEventType.Information, 0, format);
+		}
+
+		[Conditional ("TRACE")]
+		public void TraceInformation (
+			string format, params object [] args)
+		{
+			TraceEvent (TraceEventType.Information, 0, format, args);
+		}
+
+		[Conditional ("TRACE")]
+		public void TraceTransfer (int id, string message, Guid relatedActivityId)
+		{
+			if (!source_switch.ShouldTrace (TraceEventType.Transfer ))
+				return;
+			lock (((ICollection) listeners).SyncRoot) {
+				foreach (TraceListener tl in listeners)
+					tl.TraceTransfer (cache, Name, id, message, relatedActivityId);
+			}
+		}
+
+		protected virtual string [] GetSupportedAttributes ()
+		{
+			return null;
+		}
+	}
+}
+
+#endif
Index: System.Diagnostics/SourceLevels.cs
===================================================================
--- System.Diagnostics/SourceLevels.cs	(revision 0)
+++ System.Diagnostics/SourceLevels.cs	(revision 0)
@@ -0,0 +1,53 @@
+//
+// SourceLevels.cs
+//
+// Author:
+//	Atsushi Enomoto  <atsushi@ximian.com>
+//
+// Copyright (C) 2007 Novell, Inc.
+//
+
+//
+// Permission is hereby granted, free of charge, to any person obtaining
+// a copy of this software and associated documentation files (the
+// "Software"), to deal in the Software without restriction, including
+// without limitation the rights to use, copy, modify, merge, publish,
+// distribute, sublicense, and/or sell copies of the Software, and to
+// permit persons to whom the Software is furnished to do so, subject to
+// the following conditions:
+// 
+// The above copyright notice and this permission notice shall be
+// included in all copies or substantial portions of the Software.
+// 
+// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
+// LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
+// OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
+// WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+//
+
+#if NET_2_0
+
+using System;
+using System.ComponentModel;
+
+namespace System.Diagnostics
+{
+	[Flags]
+	public enum SourceLevels
+	{
+		Off = 0,
+		Critical = 1,
+		Error = 3,
+		Warning = 7,
+		Information = 15,
+		Verbose = 31,
+		[EditorBrowsable (EditorBrowsableState.Advanced)]
+		ActivityTracing = 0xFF00,
+		All = -1,
+	}
+}
+
+#endif
Index: System.Diagnostics/CorrelationManager.cs
===================================================================
--- System.Diagnostics/CorrelationManager.cs	(revision 0)
+++ System.Diagnostics/CorrelationManager.cs	(revision 0)
@@ -0,0 +1,73 @@
+//
+// CorrelationManager.cs
+//
+// Author:
+//	Atsushi Enomoto  <atsushi@ximian.com>
+//
+// Copyright (C) 2007 Novell, Inc.
+//
+
+//
+// Permission is hereby granted, free of charge, to any person obtaining
+// a copy of this software and associated documentation files (the
+// "Software"), to deal in the Software without restriction, including
+// without limitation the rights to use, copy, modify, merge, publish,
+// distribute, sublicense, and/or sell copies of the Software, and to
+// permit persons to whom the Software is furnished to do so, subject to
+// the following conditions:
+// 
+// The above copyright notice and this permission notice shall be
+// included in all copies or substantial portions of the Software.
+// 
+// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
+// LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
+// OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
+// WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+//
+
+#if NET_2_0
+
+using System;
+using System.Collections;
+
+namespace System.Diagnostics
+{
+	public class CorrelationManager
+	{
+		Guid activity;
+		Stack op_stack = new Stack ();
+
+		internal CorrelationManager ()
+		{
+		}
+
+		[MonoTODO]
+		public Guid ActivityId {
+			get { return activity; }
+			set { activity = value; }
+		}
+
+		public Stack LogicalOperationStack {
+			get { return op_stack; }
+		}
+
+		public void StartLogicalOperation ()
+		{
+			StartLogicalOperation (Guid.NewGuid ());
+		}
+
+		public void StartLogicalOperation (object operationId)
+		{
+			op_stack.Push (operationId);
+		}
+
+		public void StopLogicalOperation ()
+		{
+			op_stack.Pop ();
+		}
+	}
+}
+#endif
Index: System.Diagnostics/ChangeLog
===================================================================
--- System.Diagnostics/ChangeLog	(revision 71034)
+++ System.Diagnostics/ChangeLog	(working copy)
@@ -1,3 +1,14 @@
+2007-01-17  Atsushi Enomoto  <atsushi@ximian.com>
+
+	* Switch.cs : added missing .ctor(), Attributes, Value, 
+	  GetSupportedAttributes() and OnValueChanged().
+	* DiagnosticsConfigurationHandler.cs : added some hacky handler for
+	  new "sources" element. Don't wrap another ConfigurationException.
+	* TraceListener.cs : added missing trace methods.
+	* TraceSource.cs, SourceLevels.cs, CorrelationManager.cs,
+	  TraceEventCache.cs, TraceEventType.cs, SourceSwitch.cs:
+	  added missing 2.0 stuff, mostly just stubs.
+
 2007-01-12  Miguel de Icaza  <miguel@novell.com>
 
 	* Trace.cs: Add a number of 2.0 overloads.
Index: System.Diagnostics/Switch.cs
===================================================================
--- System.Diagnostics/Switch.cs	(revision 71034)
+++ System.Diagnostics/Switch.cs	(working copy)
@@ -33,6 +33,7 @@
 //
 
 using System.Collections;
+using System.Collections.Specialized;
 
 namespace System.Diagnostics
 {
@@ -63,6 +64,16 @@
 			this.description = description;
 		}
 
+		private string value;
+
+#if NET_2_0
+		protected Switch(string displayName, string description, string defaultSwitchValue)
+			: this (displayName, description)
+		{
+			this.value = defaultSwitchValue;
+		}
+#endif
+
 		public string Description {
 			get {return description;}
 		}
@@ -89,6 +100,31 @@
 			}
 		}
 
+#if NET_2_0
+		StringDictionary attributes = new StringDictionary ();
+
+		public StringDictionary Attributes {
+			get { return attributes; }
+		}
+
+		protected string Value {
+			get { return value; }
+			set {
+				this.value = value;
+				OnValueChanged ();
+			}
+		}
+
+		protected internal virtual string [] GetSupportedAttributes ()
+		{
+			return null;
+		}
+
+		protected virtual void OnValueChanged ()
+		{
+		}
+#endif
+
 		private void GetConfigFileSetting ()
 		{
 			try {
Index: System.Diagnostics/TraceEventCache.cs
===================================================================
--- System.Diagnostics/TraceEventCache.cs	(revision 0)
+++ System.Diagnostics/TraceEventCache.cs	(revision 0)
@@ -0,0 +1,81 @@
+//
+// TraceEventCache.cs
+//
+// Author:
+//	Atsushi Enomoto  <atsushi@ximian.com>
+//
+// Copyright (C) 2007 Novell, Inc.
+//
+
+//
+// Permission is hereby granted, free of charge, to any person obtaining
+// a copy of this software and associated documentation files (the
+// "Software"), to deal in the Software without restriction, including
+// without limitation the rights to use, copy, modify, merge, publish,
+// distribute, sublicense, and/or sell copies of the Software, and to
+// permit persons to whom the Software is furnished to do so, subject to
+// the following conditions:
+// 
+// The above copyright notice and this permission notice shall be
+// included in all copies or substantial portions of the Software.
+// 
+// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
+// LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
+// OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
+// WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+//
+
+#if NET_2_0
+
+using System;
+using System.Collections;
+using System.Text;
+using System.Threading;
+
+namespace System.Diagnostics
+{
+	public class TraceEventCache
+	{
+		DateTime started;
+		CorrelationManager manager;
+
+		public TraceEventCache ()
+		{
+			started = DateTime.MinValue;
+			manager = new CorrelationManager ();
+		}
+
+		[MonoTODO]
+		public string Callstack {
+			get { throw new NotImplementedException (); }
+		}
+
+		public DateTime DateTime {
+			get {
+				if (started == DateTime.MinValue)
+					started = DateTime.Now;
+				return started;
+			}
+		}
+
+		public Stack LogicalOperationStack {
+			get { return manager.LogicalOperationStack; }
+		}
+
+		public int ProcessId {
+			get { return Process.GetCurrentProcess ().Id; }
+		}
+
+		public string ThreadId {
+			get { return Thread.CurrentThread.Name; }
+		}
+
+		public long Timestamp {
+			get { return Stopwatch.GetTimestamp (); }
+		}
+	}
+}
+#endif
Index: System.Diagnostics/DiagnosticsConfigurationHandler.cs
===================================================================
--- System.Diagnostics/DiagnosticsConfigurationHandler.cs	(revision 71034)
+++ System.Diagnostics/DiagnosticsConfigurationHandler.cs	(working copy)
@@ -33,6 +33,7 @@
 //
 using System;
 using System.Collections;
+using System.Collections.Specialized;
 using System.Configuration;
 using System.Threading;
 #if (XML_DEP)
@@ -82,6 +83,9 @@
 			elementHandlers ["assert"] = new ElementHandler (AddAssertNode);
 			elementHandlers ["switches"] = new ElementHandler (AddSwitchesNode);
 			elementHandlers ["trace"] = new ElementHandler (AddTraceNode);
+#if NET_2_0
+			elementHandlers ["sources"] = new ElementHandler (AddSourcesNode);
+#endif
 		}
 
 		public virtual object Create (object parent, object configContext, XmlNode section)
@@ -248,6 +252,9 @@
 					d ["indentsize"] = n;
 					TraceImpl.IndentSize = n;
 				}
+				catch (ConfigurationException e) {
+					throw;
+				}
 				catch (Exception e) {
 					throw new ConfigurationException ("The `indentsize' attribute must be an integral value.",
 							e, node);
@@ -255,6 +262,82 @@
 			}
 		}
 
+#if NET_2_0
+		static readonly Hashtable static_sources = new Hashtable ();
+
+		private void AddSourcesNode (IDictionary d, XmlNode node)
+		{
+			// FIXME: are there valid attributes?
+			ValidateInvalidAttributes (node.Attributes, node);
+			Hashtable sources = d ["sources"] as Hashtable;
+			if (sources == null) {
+				sources = new Hashtable ();
+				d ["sources"] = sources;
+			}
+			// FIXME: here I replace the table with fake static variable.
+			sources = static_sources;
+
+			foreach (XmlNode child in node.ChildNodes) {
+				XmlNodeType t = child.NodeType;
+				if (t == XmlNodeType.Whitespace || t == XmlNodeType.Comment)
+					continue;
+				if (t == XmlNodeType.Element) {
+					if (child.Name == "source")
+						AddTraceSource (sources, child);
+					else
+						ThrowUnrecognizedElement (child);
+//					ValidateInvalidAttributes (child.Attributes, child);
+				}
+				else
+					ThrowUnrecognizedNode (child);
+			}
+		}
+
+		private void AddTraceSource (Hashtable sources, XmlNode node)
+		{
+			string name = null;
+			SourceLevels levels = SourceLevels.Error;
+			StringDictionary atts = new StringDictionary ();
+			foreach (XmlAttribute a in node.Attributes) {
+				switch (a.Name) {
+				case "name":
+					name = a.Value;
+					break;
+				case "switchValue":
+					levels = (SourceLevels) Enum.Parse (typeof (SourceLevels), a.Value);
+					break;
+				default:
+					atts [a.Name] = a.Value;
+					break;
+				}
+			}
+			if (name == null)
+				throw new ConfigurationException ("Mandatory attribute 'name' is missing in 'source' element.");
+
+			// FIXME: it should raise an error for duplicate name sources.
+			if (sources.ContainsKey (name))
+				return;
+
+			TraceSource source = new TraceSource (name, levels);
+			sources.Add (source.Name, source);
+			
+			foreach (XmlNode child in node.ChildNodes) {
+				XmlNodeType t = child.NodeType;
+				if (t == XmlNodeType.Whitespace || t == XmlNodeType.Comment)
+					continue;
+				if (t == XmlNodeType.Element) {
+					if (child.Name == "listeners")
+						AddTraceListeners (child);
+					else
+						ThrowUnrecognizedElement (child);
+					ValidateInvalidAttributes (child.Attributes, child);
+				}
+				else
+					ThrowUnrecognizedNode (child);
+			}
+		}
+#endif
+
 		// only defines "add" and "remove", but "clear" also works
 		// for add, "name" and "type" are required; initializeData is optional
 		private void AddTraceListeners (XmlNode listenersNode)
Index: System.Diagnostics/TraceEventType.cs
===================================================================
--- System.Diagnostics/TraceEventType.cs	(revision 0)
+++ System.Diagnostics/TraceEventType.cs	(revision 0)
@@ -0,0 +1,57 @@
+//
+// SourceLevels.cs
+//
+// Author:
+//	Atsushi Enomoto  <atsushi@ximian.com>
+//
+// Copyright (C) 2007 Novell, Inc.
+//
+
+//
+// Permission is hereby granted, free of charge, to any person obtaining
+// a copy of this software and associated documentation files (the
+// "Software"), to deal in the Software without restriction, including
+// without limitation the rights to use, copy, modify, merge, publish,
+// distribute, sublicense, and/or sell copies of the Software, and to
+// permit persons to whom the Software is furnished to do so, subject to
+// the following conditions:
+// 
+// The above copyright notice and this permission notice shall be
+// included in all copies or substantial portions of the Software.
+// 
+// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
+// LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
+// OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
+// WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+//
+
+#if NET_2_0
+
+using System.ComponentModel;
+
+namespace System.Diagnostics
+{
+	public enum TraceEventType
+	{
+		Critical = 1,
+		Error = 2,
+		Warning = 4,
+		Information = 8,
+		Verbose = 16,
+		[EditorBrowsable (EditorBrowsableState.Advanced)]
+		Start = 0x100,
+		[EditorBrowsable (EditorBrowsableState.Advanced)]
+		Stop = 0x200,
+		[EditorBrowsable (EditorBrowsableState.Advanced)]
+		Suspend = 0x400,
+		[EditorBrowsable (EditorBrowsableState.Advanced)]
+		Resume = 0x800,
+		[EditorBrowsable (EditorBrowsableState.Advanced)]
+		Transfer = 0x1000,
+	}
+}
+
+#endif
Index: System.Diagnostics/SourceSwitch.cs
===================================================================
--- System.Diagnostics/SourceSwitch.cs	(revision 0)
+++ System.Diagnostics/SourceSwitch.cs	(revision 0)
@@ -0,0 +1,87 @@
+//
+// SourceSwitch.cs
+//
+// Author:
+//	Atsushi Enomoto  <atsushi@ximian.com>
+//
+// Copyright (C) 2007 Novell, Inc.
+//
+
+//
+// Permission is hereby granted, free of charge, to any person obtaining
+// a copy of this software and associated documentation files (the
+// "Software"), to deal in the Software without restriction, including
+// without limitation the rights to use, copy, modify, merge, publish,
+// distribute, sublicense, and/or sell copies of the Software, and to
+// permit persons to whom the Software is furnished to do so, subject to
+// the following conditions:
+// 
+// The above copyright notice and this permission notice shall be
+// included in all copies or substantial portions of the Software.
+// 
+// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
+// LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
+// OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
+// WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+//
+
+#if NET_2_0
+
+using System;
+
+namespace System.Diagnostics
+{
+	public class SourceSwitch : Switch
+	{
+		// FIXME: better explanation.
+		const string description = "Source switch.";
+
+		SourceLevels level;
+
+		public SourceSwitch (string displayName)
+			: this (displayName, String.Empty)
+		{
+		}
+
+		public SourceSwitch (string displayName, string defaultSwitchValue)
+			: base (displayName, description, defaultSwitchValue)
+		{
+		}
+		
+		public SourceLevels Level {
+			get { return level; }
+			set { level = value; }
+		}
+
+		public bool ShouldTrace (TraceEventType eventType)
+		{
+			switch (eventType) {
+			case TraceEventType.Critical:
+				return (level & SourceLevels.Critical) != 0;
+			case TraceEventType.Error:
+				return (level & SourceLevels.Error) != 0;
+			case TraceEventType.Warning:
+				return (level & SourceLevels.Warning) != 0;
+			case TraceEventType.Information:
+				return (level & SourceLevels.Information) != 0;
+			case TraceEventType.Verbose:
+				return (level & SourceLevels.Verbose) != 0;
+			case TraceEventType.Start:
+			case TraceEventType.Stop:
+			case TraceEventType.Suspend:
+			case TraceEventType.Resume:
+			case TraceEventType.Transfer:
+			default:
+				return (level & SourceLevels.ActivityTracing) != 0;
+			}
+		}
+
+		protected override void OnValueChanged ()
+		{
+		}
+	}
+}
+#endif
Index: System.Diagnostics/TraceListener.cs
===================================================================
--- System.Diagnostics/TraceListener.cs	(revision 71034)
+++ System.Diagnostics/TraceListener.cs	(working copy)
@@ -32,6 +32,7 @@
 //
 
 using System;
+using System.Runtime.InteropServices;
 using System.Diagnostics;
 
 namespace System.Diagnostics {
@@ -152,6 +153,53 @@
 		{
 			WriteLine (category + ": " + message);
 		}
+
+#if NET_2_0
+		[ComVisible (false)]
+		[MonoTODO]
+		public virtual void TraceData (TraceEventCache eventCache, string source,
+			TraceEventType eventType, int id, object data)
+		{
+			throw new NotImplementedException ();
+		}
+
+		[ComVisible (false)]
+		[MonoTODO]
+		public virtual void TraceData (TraceEventCache eventCache, string source,
+			TraceEventType eventType, int id, params object [] data)
+		{
+			throw new NotImplementedException ();
+		}
+
+		[ComVisible (false)]
+		[MonoTODO]
+		public virtual void TraceEvent (TraceEventCache eventCache, string source, TraceEventType eventType, int id)
+		{
+			throw new NotImplementedException ();
+		}
+
+		[ComVisible (false)]
+		[MonoTODO]
+		public virtual void TraceEvent (TraceEventCache eventCache, string source, TraceEventType eventType,
+			int id, string message)
+		{
+			throw new NotImplementedException ();
+		}
+
+		[ComVisible (false)]
+		[MonoTODO]
+		public virtual void TraceEvent (TraceEventCache eventCache, string source, TraceEventType eventType, int id, string format, params object [] args)
+		{
+			throw new NotImplementedException ();
+		}
+
+		[ComVisible (false)]
+		[MonoTODO]
+		public virtual void TraceTransfer (TraceEventCache eventCache, string source, int id, string message, Guid relatedActivityId)
+		{
+			throw new NotImplementedException ();
+		}
+#endif
 	}
 }
 
Index: System_test.dll.sources
===================================================================
--- System_test.dll.sources	(revision 71034)
+++ System_test.dll.sources	(working copy)
@@ -142,6 +142,8 @@
 System.Configuration/SettingsPropertyValueTest.cs
 System.Diagnostics/EventLogTest.cs
 System.Diagnostics/StopwatchTest.cs
+System.Diagnostics/SourceSwitchTest.cs
+System.Diagnostics/TraceSourceTest.cs
 System.Diagnostics/TraceTest.cs
 System.Diagnostics/SwitchesTest.cs
 System.Diagnostics/DiagnosticsConfigurationHandlerTest.cs
Index: ChangeLog
===================================================================
--- ChangeLog	(revision 71034)
+++ ChangeLog	(working copy)
@@ -1,3 +1,11 @@
+2007-01-17  Atsushi Enomoto  <atsushi@ximian.com>
+
+	* System.dll.sources: added new sources:
+	  TraceSource.cs, SourceLevels.cs, CorrelationManager.cs,
+	  TraceEventCache.cs, TraceEventType.cs and SourceSwitch.cs.
+	* System_test.dll.sources: added new tests:
+	  TraceSourceTest.cs and SourceSwitchTest.cs.
+
 2007-01-11  Dick Porter  <dick@ximian.com>
 
 	* System.dll.sources: Add System.Net.Sockets/{IOControlCode,SocketInformation,SocketInformationOptions,TransmitFileOptions}.cs