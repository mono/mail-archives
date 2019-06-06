Index: System.Xml.Xsl/XslTransform.cs
===================================================================
--- System.Xml.Xsl/XslTransform.cs	(revision 68495)
+++ System.Xml.Xsl/XslTransform.cs	(working copy)
@@ -42,6 +42,25 @@
 namespace System.Xml.Xsl {
 	public sealed class XslTransform {
 
+		internal static readonly bool TemplateStackFrameError;
+		internal static readonly TextWriter TemplateStackFrameOutput;
+
+		static XslTransform ()
+		{
+			string env = Environment.GetEnvironmentVariable ("MONO_XSLT_STACK_FRAME");
+			switch (env) {
+			case "stdout":
+				TemplateStackFrameOutput = Console.Out;
+				break;
+			case "stderr":
+				TemplateStackFrameOutput = Console.Error;
+				break;
+			case "error":
+				TemplateStackFrameError = true;
+				break;
+			}
+		}
+
 		CompiledStylesheet s;
 		XmlResolver xmlResolver = new XmlUrlResolver ();
 
Index: System.Xml.Xsl/XsltException.cs
===================================================================
--- System.Xml.Xsl/XsltException.cs	(revision 68495)
+++ System.Xml.Xsl/XsltException.cs	(working copy)
@@ -64,6 +64,7 @@
 		int lineNumber;
 		int linePosition;
 		string sourceUri;
+		string templateFrames;
 
 		#endregion
 
@@ -91,6 +92,7 @@
 			lineNumber = info.GetInt32 ("lineNumber");
 			linePosition = info.GetInt32 ("linePosition");
 			sourceUri = info.GetString ("sourceUri");
+			templateFrames = info.GetString ("templateFrames");
 		}
 
 		internal XsltException (string msgFormat, string message, Exception innerException, int lineNumber, int linePosition, string sourceUri)
@@ -132,7 +134,7 @@
 
 		public override string Message {
 			get {
-				return base.Message;
+				return templateFrames != null ? base.Message + templateFrames : base.Message;
 			}
 		}
 
@@ -155,8 +157,14 @@
 			info.AddValue ("lineNumber", lineNumber);
 			info.AddValue ("linePosition", linePosition);
 			info.AddValue ("sourceUri", sourceUri);
+			info.AddValue ("templateFrames", templateFrames);
 		}
 
+		internal void AddTemplateFrame (string frame)
+		{
+			templateFrames += frame;
+		}
+
 		#endregion
 	}
 }
Index: Mono.Xml.Xsl/XslStylesheet.cs
===================================================================
--- Mono.Xml.Xsl/XslStylesheet.cs	(revision 68495)
+++ Mono.Xml.Xsl/XslStylesheet.cs	(working copy)
@@ -64,6 +64,8 @@
 
 		XslTemplateTable templates;
 
+		string baseURI;
+
 		// stylesheet attributes
 		string version;
 		XmlQualifiedName [] extensionElementPrefixes;
@@ -107,6 +109,10 @@
 			get { return templates; }
 		}
 
+		public string BaseURI {
+			get { return baseURI; }
+		}
+
 		public string Version {
 			get { return version; }
 		}
@@ -120,6 +126,7 @@
 			c.PushStylesheet (this);
 			
 			templates = new XslTemplateTable (this);
+			baseURI = c.Input.BaseURI;
 
 			// move to root element
 			while (c.Input.NodeType != XPathNodeType.Element)
Index: Mono.Xml.Xsl/XslTemplate.cs
===================================================================
--- Mono.Xml.Xsl/XslTemplate.cs	(revision 68495)
+++ Mono.Xml.Xsl/XslTemplate.cs	(working copy)
@@ -350,9 +350,45 @@
 				c.Input.MoveToParent ();
 			}
 		}
-		
+
+		string LocationMessage {
+			get {
+				XslCompiledElementBase op = (XslCompiledElementBase) content;
+				return String.Format (" from\nxsl:template {0} at {1} ({2},{3})", Match, style.BaseURI, op.LineNumber, op.LinePosition);
+			}
+		}
+
+		void AppendTemplateFrame (XsltException ex)
+		{
+			ex.AddTemplateFrame (LocationMessage);
+		}
+
 		public virtual void Evaluate (XslTransformProcessor p, Hashtable withParams)
 		{
+			if (XslTransform.TemplateStackFrameError) {
+				try {
+					EvaluateCore (p, withParams);
+				} catch (XsltException ex) {
+					AppendTemplateFrame (ex);
+					throw ex;
+				} catch (Exception ex) {
+					// Note that this catch causes different
+					// type of error to be thrown (esp.
+					// this causes NUnit test regression).
+					XsltException e = new XsltException ("Error during XSLT processing: ", null, p.CurrentNode);
+					AppendTemplateFrame (e);
+					throw e;
+				}
+			}
+			else
+				EvaluateCore (p, withParams);
+		}
+
+		void EvaluateCore (XslTransformProcessor p, Hashtable withParams)
+		{
+			if (XslTransform.TemplateStackFrameOutput != null)
+				XslTransform.TemplateStackFrameOutput.WriteLine (LocationMessage);
+
 			p.PushStack (stackSize);
 
 			if (parameters != null) {