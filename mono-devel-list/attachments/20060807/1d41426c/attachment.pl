Index: System.Diagnostics/EventLogImpl.cs
===================================================================
--- System.Diagnostics/EventLogImpl.cs	(revision 63403)
+++ System.Diagnostics/EventLogImpl.cs	(working copy)
@@ -3,8 +3,10 @@
 //
 // Authors:
 //   Andreas Nahr (ClassDevelopment@A-SoftTech.com)
+//   Atsushi Enomoto  <atsushi@ximian.com>
 //
 // (C) 2003 Andreas Nahr
+// (C) 2006 Novell, Inc.
 //
 
 //
@@ -32,6 +34,10 @@
 using System.Diagnostics;
 using System.ComponentModel;
 using System.ComponentModel.Design;
+using System.Collections;
+using System.Globalization;
+using System.IO;
+using System.Net;
 
 namespace System.Diagnostics
 {
@@ -48,73 +54,352 @@
 #else
 	// Empty implementation that does not need any specific platform
 	// but should be enough to get applications to run that WRITE to eventlog
-	internal class EventLogImpl
+	class LocalFileEventLogUtil
 	{
-		public EventLogImpl (EventLog coreEventLog)
+		public const string DateFormat = "yyyyMMddHHmmssfff";
+
+		static string path = Path.GetFullPath (Environment.GetEnvironmentVariable ("MONO_LOCAL_EVENTLOG_DIR"));
+
+		public static bool IsEnabled {
+			get { return Directory.Exists (path); }
+		}
+
+		public static string GetSourceDir (string source)
 		{
+			foreach (string log in GetLogDirectories ()) {
+				string sd = Path.Combine (log, source);
+				if (Directory.Exists (sd))
+					return sd;
+			}
+			return null;
 		}
 
-		public static event EntryWrittenEventHandler EntryWritten;
+		public static string GetLogDir (string logName)
+		{
+			return Path.Combine (Path.Combine (path, "logs"), logName);
+		}
 
-		public EventLogEntryCollection Entries {
-			get {return new EventLogEntryCollection ();}
+		public static string [] GetLogDirectories ()
+		{
+			return Directory.GetDirectories (Path.Combine (path, "logs"));
 		}
+	}
 
-		public string LogDisplayName {
-			get {return "";}
+	class LocalFileEventLog : EventLogImpl
+	{
+		static readonly string [] empty_strings = new string [0];
+
+		EventLog log;
+		string source_path;
+
+		public LocalFileEventLog (EventLog log)
+			: base (log)
+		{
+			this.log = log;
+			source_path = LocalFileEventLogUtil.GetSourceDir (log.Source);
+			if (!Directory.Exists (source_path))
+				throw new SystemException (String.Format ("INTERNAL ERROR: directory for {0} does not exist.", log.Source));
 		}
 
-		public void BeginInit () {}
+		public override EventLogEntryCollection Entries {
+			get {
+				ArrayList list = new ArrayList ();
+				int index = 0;
+				foreach (string file in Directory.GetFiles (source_path, "*.log"))
+					list.Add (LoadLogEntry (file, index++));
+				return new EventLogEntryCollection ((EventLogEntry []) list.ToArray (typeof (EventLogEntry)));
+			}
+		}
 
-		public void Clear () {}
+		public override string LogDisplayName {
+			get { return log.Log; }
+		}
 
-		public void Close () {}
+		EventLogEntry LoadLogEntry (string file, int index)
+		{
+			using (TextReader tr = File.OpenText (file)) {
+				int id = int.Parse (tr.ReadLine ().Substring (9));
+				EventLogEntryType type = (EventLogEntryType)
+					Enum.Parse (typeof (EventLogEntryType), tr.ReadLine ().Substring (11));
+				string category = tr.ReadLine ().Substring (10);
+				int size = int.Parse (tr.ReadLine ().Substring (15));
+				char [] buf = new char [size];
+				tr.Read (buf, 0, size);
+				string filename = Path.GetFileName (file).Substring (0, LocalFileEventLogUtil.DateFormat.Length);
+				DateTime date = DateTime.ParseExact (filename, LocalFileEventLogUtil.DateFormat, CultureInfo.InvariantCulture);
+				byte [] bin = Convert.FromBase64String (tr.ReadToEnd ());
+				// FIXME: categoryNumber, index, userName, two dates
+				return new EventLogEntry (category, 0, index,
+					id, new string (buf), log.Source, "", log.MachineName,
+					type, date, date, bin, empty_strings);
+			}
+		}
 
-		public static void CreateEventSource (string source, string logName, string machineName) {}
+		public override void BeginInit ()
+		{
+		}
 
-		public static void Delete (string logName, string machineName) {}
+		public override void Clear ()
+		{
+			foreach (string file in Directory.GetFiles (source_path, "*.log"))
+				File.Delete (file);
+		}
 
-		public static void DeleteEventSource (string source, string machineName) {}
+		public override void Close ()
+		{
+		}
 
-		public void Dispose (bool disposing) {}
+		public override void Dispose (bool disposing)
+		{
+			Close ();
+		}
 
-		public void EndInit () {}
+		public override void EndInit ()
+		{
+		}
+	}
 
+	// Creates a log repository at MONO_LOCAL_EVENTLOG_DIR, which consists of
+	// 	- 
+	internal class LocalFileEventLogFactory : EventLogFactory
+	{
+		static readonly IPAddress local_ip = IPAddress.Parse ("127.0.0.1");
+
+		public LocalFileEventLogFactory ()
+		{
+		}
+
+		public override EventLogImpl Create (EventLog log)
+		{
+			if (!SourceExists (log.Source, log.MachineName))
+				CreateEventSource (log.Source, log.Log, log.MachineName);
+			return new LocalFileEventLog (log);
+		}
+
+		void VerifyMachine (string machineName)
+		{
+			if (machineName != ".") {
+				IPHostEntry entry =
+#if NET_2_0
+					Dns.GetHostEntry (machineName);
+#else
+					Dns.Resolve (machineName);
+#endif
+				if (Array.IndexOf (entry.AddressList, local_ip) < 0)
+					throw new NotSupportedException (String.Format ("LocalFileEventLog does not support remote machine: {0}", machineName));
+			}
+		}
+
+		public override void CreateEventSource (string source, string logName, string machineName)
+		{
+			VerifyMachine (machineName);
+
+			string sourceDir = LocalFileEventLogUtil.GetSourceDir (source);
+			if (sourceDir != null)
+				throw new ArgumentException (String.Format ("Source '{0}' already exists on the local machine.", source));
+
+			string logDir = LocalFileEventLogUtil.GetLogDir (logName);
+			if (!Directory.Exists (logDir))
+				Directory.CreateDirectory (logDir);
+			Directory.CreateDirectory (Path.Combine (logDir, source));
+		}
+
+		public override void Delete (string logName, string machineName)
+		{
+			VerifyMachine (machineName);
+
+			string logDir = LocalFileEventLogUtil.GetLogDir (logName);
+			if (Directory.Exists (logDir))
+				Directory.Delete (logDir);
+		}
+
+		public override void DeleteEventSource (string source, string machineName)
+		{
+			VerifyMachine (machineName);
+
+			string sourceDir = LocalFileEventLogUtil.GetSourceDir (source);
+			if (Directory.Exists (sourceDir))
+				Directory.Delete (sourceDir);
+			else
+				throw new ArgumentException (String.Format ("Event source '{0}' does not exist on the local machine."), source);
+		}
+
+		public override bool Exists (string logName, string machineName)
+		{
+			VerifyMachine (machineName);
+
+			return Directory.Exists (LocalFileEventLogUtil.GetLogDir (logName));
+		}
+
+		public override EventLog[] GetEventLogs (string machineName)
+		{
+			VerifyMachine (machineName);
+
+			ArrayList al = new ArrayList ();
+			foreach (string log in LocalFileEventLogUtil.GetLogDirectories ())
+				al.Add (new EventLog (log));
+			return (EventLog []) al.ToArray (typeof (EventLog));
+		}
+
+		public override string LogNameFromSourceName (string source, string machineName)
+		{
+			VerifyMachine (machineName);
+
+			string sourceDir = LocalFileEventLogUtil.GetSourceDir (source);
+			if (sourceDir == null)
+				throw new ArgumentException (String.Format ("Event source '{0}' does not exist on the local machine."), source);
+			return Directory.GetParent (sourceDir).Name;
+		}
+
+		public override bool SourceExists (string source, string machineName)
+		{
+			VerifyMachine (machineName);
+
+			return LocalFileEventLogUtil.GetSourceDir (source) != null;
+		}
+
+		public override void WriteEntry (string source, string message, EventLogEntryType type, int eventID, short category, byte[] rawData)
+		{
+			if (!SourceExists (source, "."))
+				throw new ArgumentException (String.Format ("Event source '{0}' does not exist on the local machine."), source);
+			string sourceDir = LocalFileEventLogUtil.GetSourceDir (source);
+			string path = Path.Combine (sourceDir, DateTime.Now.ToString (LocalFileEventLogUtil.DateFormat) + ".log");
+			try {
+				using (TextWriter w = File.CreateText (path)) {
+					w.WriteLine ("EventID: {0}", eventID);
+					w.WriteLine ("EntryType: {0}", type);
+					w.WriteLine ("Category: {0}", category);
+					w.WriteLine ("MessageLength: {0}", message.Length);
+					w.Write (message);
+					if (rawData != null)
+						w.Write (Convert.ToBase64String (rawData));
+				}
+			} catch (IOException) {
+				File.Delete (path);
+			}
+		}
+	}
+
+	internal abstract class EventLogImpl
+	{
+		static EventLogFactory factory;
+
+		static EventLogImpl ()
+		{
+			factory = GetFactory ();
+		}
+
+		static EventLogFactory GetFactory ()
+		{
+			if (LocalFileEventLogUtil.IsEnabled)
+				return new LocalFileEventLogFactory ();
+
+			throw new NotSupportedException (String.Format ("No EventLog implementation is supported. Consider setting MONO_LOCAL_EVENTLOG_DIR environment variable."));
+		}
+
+		EventLog log;
+
+		protected EventLogImpl (EventLog coreEventLog)
+		{
+			this.log = coreEventLog;
+		}
+
+		public static EventLogImpl Create (EventLog source)
+		{
+			return factory.Create (source);
+		}
+
+		public static event EntryWrittenEventHandler EntryWritten;
+
+		public abstract EventLogEntryCollection Entries { get; }
+
+		public abstract string LogDisplayName { get; }
+
+		public abstract void BeginInit ();
+
+		public abstract void Clear ();
+
+		public abstract void Close ();
+
+		public static void CreateEventSource (string source, string logName, string machineName)
+		{
+			factory.CreateEventSource (source, logName, machineName);
+		}
+
+		public static void Delete (string logName, string machineName)
+		{
+			factory.Delete (logName, machineName);
+		}
+
+		public static void DeleteEventSource (string source, string machineName)
+		{
+			factory.DeleteEventSource (source, machineName);
+		}
+
+		public abstract void Dispose (bool disposing);
+
+		public abstract void EndInit ();
+
 		public static bool Exists (string logName, string machineName)
 		{
-			return false;
+			return factory.Exists (logName, machineName);
 		}
 
 		public static EventLog[] GetEventLogs (string machineName)
 		{
-			return new EventLog[0];
+			return factory.GetEventLogs (machineName);
 		}
 
 		public static string LogNameFromSourceName (string source, string machineName)
 		{
-			return String.Empty;
+			return factory.LogNameFromSourceName (source, machineName);
 		}
 
 		public static bool SourceExists (string source, string machineName)
 		{
-			return false;
+			return factory.SourceExists (source, machineName);
 		}
 
 		public void WriteEntry (string message, EventLogEntryType type, int eventID, short category, byte[] rawData)
 		{
-			WriteEntry ("", message, type, eventID, category, rawData);
+			WriteEntry (log.Source, message, type, eventID, category, rawData);
 		}
 
 		public static void WriteEntry (string source, string message, EventLogEntryType type, int eventID, short category, byte[] rawData)
 		{
-			EventLogEntry Entry;
-			Entry = new EventLogEntry ("", category, 0, eventID, message, source, 
-				"", "", type, DateTime.Now, DateTime.Now, rawData, null);
-			if (EntryWritten != null)
-				EntryWritten (null, new EntryWrittenEventArgs (Entry));
+			factory.WriteEntry (source, message, type, eventID, category, rawData);
+			if (EntryWritten != null) {
+				// FIXME: some arguments are improper.
+				EventLogEntry e = new EventLogEntry ("",
+					category, 0, eventID, message, source,
+					"", ".", type, DateTime.Now, DateTime.Now,
+					rawData, null);
+				EntryWritten (null, new EntryWrittenEventArgs (e));
+			}
 		}
 	}
 
+	internal abstract class EventLogFactory
+	{
+		public abstract EventLogImpl Create (EventLog source);
+
+		public abstract void CreateEventSource (string source, string logName, string machineName);
+
+		public abstract void Delete (string logName, string machineName);
+
+		public abstract void DeleteEventSource (string source, string machineName);
+
+		public abstract bool Exists (string logName, string machineName);
+
+		public abstract EventLog[] GetEventLogs (string machineName);
+
+		public abstract string LogNameFromSourceName (string source, string machineName);
+
+		public abstract bool SourceExists (string source, string machineName);
+
+		public abstract void WriteEntry (string source, string message, EventLogEntryType type, int eventID, short category, byte[] rawData);
+	}
+
 #endif
 
 }
Index: System.Diagnostics/EventLogEntryCollection.cs
===================================================================
--- System.Diagnostics/EventLogEntryCollection.cs	(revision 63403)
+++ System.Diagnostics/EventLogEntryCollection.cs	(working copy)
@@ -39,8 +39,10 @@
 
 		private ArrayList eventLogs = new ArrayList ();
 
-		internal EventLogEntryCollection()
+		internal EventLogEntryCollection(IEnumerable entries)
 		{
+			foreach (object entry in entries)
+				eventLogs.Add (entry);
 		}
 
 		public int Count {
Index: System.Diagnostics/EventLog.cs
===================================================================
--- System.Diagnostics/EventLog.cs	(revision 63403)
+++ System.Diagnostics/EventLog.cs	(working copy)
@@ -72,7 +72,7 @@
 			this.machineName = machineName;
 			this.logName = logName;
 
-			this.Impl = new EventLogImpl (this);
+			this.Impl = EventLogImpl.Create (this);
 			EventLogImpl.EntryWritten += new EntryWrittenEventHandler (EntryWrittenHandler);
 		}
 