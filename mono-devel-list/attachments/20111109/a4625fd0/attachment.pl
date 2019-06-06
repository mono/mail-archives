diff --git a/mcs/class/System.ServiceModel/System.ServiceModel/Logger.cs b/mcs/class/System.ServiceModel/System.ServiceModel/Logger.cs
index 0f492d7..439ac15 100644
--- a/mcs/class/System.ServiceModel/System.ServiceModel/Logger.cs
+++ b/mcs/class/System.ServiceModel/System.ServiceModel/Logger.cs
@@ -140,14 +140,16 @@ namespace System.ServiceModel
 		static void Log (TraceEventType eventType, string message, params object [] args)
 		{
 			event_id++;
+            lock (log_writer) {
 #if NET_2_1
-			log_writer.Write ("[{0}] ", event_id);
+                log_writer.Write ("[{0}] ", event_id);
 #endif
-			TraceCore (TraceEventType.Information, event_id,
-				false, Guid.Empty, // FIXME
-				message, args);
-			log_writer.WriteLine (message, args);
-			log_writer.Flush ();
+                TraceCore (TraceEventType.Information, event_id,
+                        false, Guid.Empty, // FIXME
+                        message, args);
+                log_writer.WriteLine (message, args);
+                log_writer.Flush ();
+            }
 #if !NET_2_1
 			source.TraceEvent (eventType, event_id, message, args);
 #endif
@@ -191,17 +193,19 @@ namespace System.ServiceModel
 
 			event_id++;
 
+            lock (log_writer) {
 #if NET_2_1
-			log_writer.Write ("[{0}] ", event_id);
+                log_writer.Write ("[{0}] ", event_id);
 
-			TraceCore (TraceEventType.Information, event_id, /*FIXME*/false, /*FIXME*/Guid.Empty, sw);
+                TraceCore (TraceEventType.Information, event_id, /*FIXME*/false, /*FIXME*/Guid.Empty, sw);
 #else
-			TraceCore (TraceEventType.Information, event_id, /*FIXME*/false, /*FIXME*/Guid.Empty, doc.CreateNavigator ());
+                TraceCore (TraceEventType.Information, event_id, /*FIXME*/false, /*FIXME*/Guid.Empty, doc.CreateNavigator ());
 
-			message_source.TraceData (TraceEventType.Information, event_id, doc.CreateNavigator ());
+                message_source.TraceData (TraceEventType.Information, event_id, doc.CreateNavigator ());
 #endif
 
-			log_writer.Flush ();
+                log_writer.Flush ();
+            }
 		}
 
 		#endregion
@@ -212,85 +216,87 @@ namespace System.ServiceModel
 			bool hasRelatedActivity, Guid relatedActivity,
 			/*int level, bool wrapData, */params object [] data)
 		{
+            // Can we assert that log_writer is indeed locked?
+
 			string source = "mono(dummy)";
 			int level = 2;
 			bool wrapData = true;
-			var w = xml_writer;
 
-			w.WriteStartElement ("E2ETraceEvent", e2e_ns);
+            var w = xml_writer;
+            w.WriteStartElement ("E2ETraceEvent", e2e_ns);
 
-			// <System>
-			w.WriteStartElement ("System", sys_ns);
-			w.WriteStartElement ("EventID", sys_ns);
-			w.WriteString (XmlConvert.ToString (id));
-			w.WriteEndElement ();
-			w.WriteStartElement ("Type", sys_ns);
-			// ...what to write here?
-			w.WriteString ("3");
-			w.WriteEndElement ();
-			w.WriteStartElement ("SubType", sys_ns);
-			// FIXME: it does not seem always to match eventType value ...
-			w.WriteAttributeString ("Name", eventType.ToString ());
-			// ...what to write here?
-			w.WriteString ("0");
-			w.WriteEndElement ();
-			// ...what to write here?
-			w.WriteStartElement ("Level", sys_ns);
-			w.WriteString (level.ToString ());
-			w.WriteEndElement ();
-			w.WriteStartElement ("TimeCreated", sys_ns);
-			w.WriteAttributeString ("SystemTime", XmlConvert.ToString (DateTime.Now, XmlDateTimeSerializationMode.RoundtripKind));
-			w.WriteEndElement ();
-			w.WriteStartElement ("Source", sys_ns);
-			w.WriteAttributeString ("Name", source);
-			w.WriteEndElement ();
-			w.WriteStartElement ("Correlation", sys_ns);
-			w.WriteAttributeString ("ActivityID", String.Concat ("{", Guid.Empty, "}"));
-			w.WriteEndElement ();
-			w.WriteStartElement ("Execution", sys_ns);
-			w.WriteAttributeString ("ProcessName", "mono (dummy)");
-			w.WriteAttributeString ("ProcessID", "0");
-			w.WriteAttributeString ("ThreadID", Thread.CurrentThread.ManagedThreadId.ToString ());
-			w.WriteEndElement ();
-			w.WriteStartElement ("Channel", sys_ns);
-			// ...what to write here?
-			w.WriteEndElement ();
-			w.WriteStartElement ("Computer");
-			w.WriteString ("localhost(dummy)");
-			w.WriteEndElement ();
+            // <System>
+            w.WriteStartElement ("System", sys_ns);
+            w.WriteStartElement ("EventID", sys_ns);
+            w.WriteString (XmlConvert.ToString (id));
+            w.WriteEndElement ();
+            w.WriteStartElement ("Type", sys_ns);
+            // ...what to write here?
+            w.WriteString ("3");
+            w.WriteEndElement ();
+            w.WriteStartElement ("SubType", sys_ns);
+            // FIXME: it does not seem always to match eventType value ...
+            w.WriteAttributeString ("Name", eventType.ToString ());
+            // ...what to write here?
+            w.WriteString ("0");
+            w.WriteEndElement ();
+            // ...what to write here?
+            w.WriteStartElement ("Level", sys_ns);
+            w.WriteString (level.ToString ());
+            w.WriteEndElement ();
+            w.WriteStartElement ("TimeCreated", sys_ns);
+            w.WriteAttributeString ("SystemTime", XmlConvert.ToString (DateTime.Now, XmlDateTimeSerializationMode.RoundtripKind));
+            w.WriteEndElement ();
+            w.WriteStartElement ("Source", sys_ns);
+            w.WriteAttributeString ("Name", source);
+            w.WriteEndElement ();
+            w.WriteStartElement ("Correlation", sys_ns);
+            w.WriteAttributeString ("ActivityID", String.Concat ("{", Guid.Empty, "}"));
+            w.WriteEndElement ();
+            w.WriteStartElement ("Execution", sys_ns);
+            w.WriteAttributeString ("ProcessName", "mono (dummy)");
+            w.WriteAttributeString ("ProcessID", "0");
+            w.WriteAttributeString ("ThreadID", Thread.CurrentThread.ManagedThreadId.ToString ());
+            w.WriteEndElement ();
+            w.WriteStartElement ("Channel", sys_ns);
+            // ...what to write here?
+            w.WriteEndElement ();
+            w.WriteStartElement ("Computer");
+            w.WriteString ("localhost(dummy)");
+            w.WriteEndElement ();
 
-			w.WriteEndElement ();
+            w.WriteEndElement ();
 
-			// <ApplicationData>
-			w.WriteStartElement ("ApplicationData", e2e_ns);
-			w.WriteStartElement ("TraceData", e2e_ns);
-			foreach (object o in data) {
-				if (wrapData)
-					w.WriteStartElement ("DataItem", e2e_ns);
+            // <ApplicationData>
+            w.WriteStartElement ("ApplicationData", e2e_ns);
+            w.WriteStartElement ("TraceData", e2e_ns);
+            foreach (object o in data) {
+                if (wrapData)
+                    w.WriteStartElement ("DataItem", e2e_ns);
 #if MOONLIGHT
-				// in moonlight we don't have XPathNavigator, so just use raw string...
-				if (o != null)
-					w.WriteString (o.ToString ());
+                // in moonlight we don't have XPathNavigator, so just use raw string...
+                if (o != null)
+                    w.WriteString (o.ToString ());
 #else
-				if (o is XPathNavigator)
-					// the output ignores xmlns difference between the parent (E2ETraceEvent and the content node).
-					// To clone such behavior, I took this approach.
-					w.WriteRaw (XPathNavigatorToString ((XPathNavigator) o));
-				else if (o != null)
-					w.WriteString (o.ToString ());
+                if (o is XPathNavigator)
+                    // the output ignores xmlns difference between the parent (E2ETraceEvent and the content node).
+                    // To clone such behavior, I took this approach.
+                    w.WriteRaw (XPathNavigatorToString ((XPathNavigator) o));
+                else if (o != null)
+                    w.WriteString (o.ToString ());
 #endif
-				if (wrapData)
-					w.WriteEndElement ();
-			}
-			w.WriteEndElement ();
-			w.WriteEndElement ();
+                if (wrapData)
+                    w.WriteEndElement ();
+            }
+            w.WriteEndElement ();
+            w.WriteEndElement ();
 
-			w.WriteEndElement ();
+            w.WriteEndElement ();
 
-			w.Flush (); // for XmlWriter
-			log_writer.WriteLine ();
-			log_writer.Flush (); // for TextWriter
-		}
+            w.Flush (); // for XmlWriter
+            log_writer.WriteLine ();
+            log_writer.Flush (); // for TextWriter
+        }
 
 		static readonly XmlWriterSettings xml_writer_settings = new XmlWriterSettings () { OmitXmlDeclaration = true };
 
