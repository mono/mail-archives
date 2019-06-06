Index: System.Net.Configuration/SmtpNetworkElement.cs
===================================================================
--- System.Net.Configuration/SmtpNetworkElement.cs	(revision 68672)
+++ System.Net.Configuration/SmtpNetworkElement.cs	(working copy)
@@ -47,10 +47,10 @@
                 static SmtpNetworkElement ()
                 {
                         defaultCredentialsProp = new ConfigurationProperty ("defaultCredentials", typeof (bool), false);
-                        hostProp = new ConfigurationProperty ("host", typeof (string));
-                        passwordProp = new ConfigurationProperty ("password", typeof (string));
-                        portProp = new ConfigurationProperty ("port", typeof (int), 25);
-                        userNameProp = new ConfigurationProperty ("userName", typeof (string));
+                        hostProp = new ConfigurationProperty ("host", typeof (string), null);
+						passwordProp = new ConfigurationProperty ("password", typeof (string), null);
+                        portProp = new ConfigurationProperty ("port", typeof (int), 25);
+						userNameProp = new ConfigurationProperty ("userName", typeof (string), null);
                         properties = new ConfigurationPropertyCollection ();
 
                         properties.Add (defaultCredentialsProp);
Index: System.Net.Configuration/SmtpSection.cs
===================================================================
--- System.Net.Configuration/SmtpSection.cs	(revision 68672)
+++ System.Net.Configuration/SmtpSection.cs	(working copy)
@@ -47,9 +47,9 @@
                 static SmtpSection ()
                 {
                         deliveryMethodProp = new ConfigurationProperty ("deliveryMethod", typeof (SmtpDeliveryMethod), SmtpDeliveryMethod.Network);
-                        fromProp = new ConfigurationProperty ("from", typeof (string));
-                        networkProp = new ConfigurationProperty ("network", typeof (SmtpNetworkElement));
-                        specifiedPickupDirectoryProp = new ConfigurationProperty ("specifiedPickupDirectory", typeof (SmtpSpecifiedPickupDirectoryElement));
+                        fromProp = new ConfigurationProperty ("from", typeof (string), null);
+                        networkProp = new ConfigurationProperty ("network", typeof (SmtpNetworkElement), null);
+                        specifiedPickupDirectoryProp = new ConfigurationProperty ("specifiedPickupDirectory", typeof (SmtpSpecifiedPickupDirectoryElement), null);
                         properties = new ConfigurationPropertyCollection ();
 
                         properties.Add (deliveryMethodProp);
Index: System.Net.Mail/Attachment.cs
===================================================================
--- System.Net.Mail/Attachment.cs	(revision 68672)
+++ System.Net.Mail/Attachment.cs	(working copy)
@@ -34,7 +34,8 @@
 using System.Net.Mime;
 using System.Text;
 
-namespace System.Net.Mail {
+namespace System.Net.Mail
+{
 	public class Attachment : AttachmentBase
 	{
 		#region Fields
@@ -46,39 +47,43 @@
 
 		#region Constructors
 
-		[MonoTODO]
-		public Attachment (string fileName) : base (fileName)
-		{
+		public Attachment (string fileName)
+			: base (fileName) {
+			InitName (fileName);
 		}
 
-		[MonoTODO]
-		public Attachment (string fileName, string mediaType) : base (fileName, mediaType)
-		{
+		public Attachment (string fileName, string mediaType)
+			: base (fileName, mediaType) {
+			InitName (fileName);
 		}
 
-		[MonoTODO]
-		public Attachment (string fileName, ContentType contentType) : base (fileName, contentType)
-		{
+		public Attachment (string fileName, ContentType contentType)
+			: base (fileName, contentType) {
+			InitName (fileName);
 		}
 
 		[MonoTODO]
-		public Attachment (Stream contentStream, ContentType contentType) : base (contentStream, contentType)
-		{
+		public Attachment (Stream contentStream, ContentType contentType)
+			: base (contentStream, contentType) {
+			//FIXME: What should we do with the name???
 		}
 
 		[MonoTODO]
-		public Attachment (Stream contentStream, string mediaType) : base (contentStream, mediaType)
-		{
+		public Attachment (Stream contentStream, string mediaType)
+			: base (contentStream, mediaType) {
+			//FIXME: What should we do with the name???
 		}
 
 		[MonoTODO]
-		public Attachment (Stream contentStream, string name, string mediaType) : base (contentStream, mediaType)
-		{
+		public Attachment (Stream contentStream, string name, string mediaType)
+			: base (contentStream, mediaType) {
+			if (name == null) {
+				throw new ArgumentNullException ("name");
+			}
+
 			Name = name;
 		}
 
-
-
 		#endregion // Constructors
 
 		#region Properties
@@ -89,7 +94,7 @@
 
 		public string Name {
 			get { return ContentType.Name; }
-			set { 
+			set {
 				if (value == null)
 					throw new ArgumentNullException ();
 				if (value.Equals (""))
@@ -107,10 +112,9 @@
 		#endregion // Properties
 
 		#region Methods
-		
+
 		[MonoTODO]
-		public static Attachment CreateAttachmentFromString (string content, ContentType contentType)
-		{
+		public static Attachment CreateAttachmentFromString (string content, ContentType contentType) {
 			MemoryStream ms = new MemoryStream ();
 			StreamWriter sw = new StreamWriter (ms);
 			sw.Write (content);
@@ -118,10 +122,9 @@
 			ms.Position = 0;
 			return new Attachment (ms, contentType);
 		}
-		
+
 		[MonoTODO]
-		public static Attachment CreateAttachmentFromString (string content, string name)
-		{
+		public static Attachment CreateAttachmentFromString (string content, string name) {
 			MemoryStream ms = new MemoryStream ();
 			StreamWriter sw = new StreamWriter (ms);
 			sw.Write (content);
@@ -129,10 +132,9 @@
 			ms.Position = 0;
 			return new Attachment (ms, name);
 		}
-		
+
 		[MonoTODO]
-		public static Attachment CreateAttachmentFromString (string content, string name, Encoding encoding, string mediaType)
-		{
+		public static Attachment CreateAttachmentFromString (string content, string name, Encoding encoding, string mediaType) {
 			MemoryStream ms = new MemoryStream ();
 			StreamWriter sw = new StreamWriter (ms);
 			sw.Write (content);
@@ -142,6 +144,15 @@
 		}
 
 		#endregion // Methods
+
+		private void InitName (string fileName) {
+			if (fileName == null) {
+				throw new ArgumentNullException ("fileName");
+			}
+
+			Name = fileName.Substring (fileName.LastIndexOf ('\\') + 1);
+		}
+
 	}
 }
 
Index: System.Net.Mail/AttachmentBase.cs
===================================================================
--- System.Net.Mail/AttachmentBase.cs	(revision 68672)
+++ System.Net.Mail/AttachmentBase.cs	(working copy)
@@ -33,8 +33,11 @@
 using System.IO;
 using System.Net.Mime;
 using System.Text;
+using System.Web;
+using System.Collections;
 
-namespace System.Net.Mail {
+namespace System.Net.Mail
+{
 	public abstract class AttachmentBase : IDisposable
 	{
 		#region Fields
@@ -48,8 +51,7 @@
 
 		#region Constructors
 
-		protected AttachmentBase (Stream contentStream)
-		{
+		protected AttachmentBase (Stream contentStream) {
 			if (contentStream == null)
 				throw new ArgumentNullException ();
 			this.contentStream = contentStream;
@@ -58,8 +60,7 @@
 			transferEncoding = TransferEncoding.Base64;
 		}
 
-		protected AttachmentBase (Stream contentStream, ContentType contentType)
-		{
+		protected AttachmentBase (Stream contentStream, ContentType contentType) {
 			if (contentStream == null || contentType == null)
 				throw new ArgumentNullException ();
 			this.contentStream = contentStream;
@@ -67,8 +68,7 @@
 			transferEncoding = TransferEncoding.Base64;
 		}
 
-		protected AttachmentBase (Stream contentStream, string mediaType)
-		{
+		protected AttachmentBase (Stream contentStream, string mediaType) {
 			if (contentStream == null)
 				throw new ArgumentNullException ();
 			this.contentStream = contentStream;
@@ -76,18 +76,15 @@
 			transferEncoding = TransferEncoding.Base64;
 		}
 
-		protected AttachmentBase (string fileName)
-		{
+		protected AttachmentBase (string fileName) {
 			if (fileName == null)
 				throw new ArgumentNullException ();
 			contentStream = File.OpenRead (fileName);
-			contentType.MediaType = MediaTypeNames.Application.Octet;
-			contentType.CharSet = null;
+			contentType = new ContentType (MimeTypes.GetMimeType (fileName));
 			transferEncoding = TransferEncoding.Base64;
 		}
 
-		protected AttachmentBase (string fileName, ContentType contentType)
-		{
+		protected AttachmentBase (string fileName, ContentType contentType) {
 			if (fileName == null)
 				throw new ArgumentNullException ();
 			contentStream = File.OpenRead (fileName);
@@ -95,8 +92,7 @@
 			transferEncoding = TransferEncoding.Base64;
 		}
 
-		protected AttachmentBase (string fileName, string mediaType)
-		{
+		protected AttachmentBase (string fileName, string mediaType) {
 			if (fileName == null)
 				throw new ArgumentNullException ();
 			contentStream = File.OpenRead (fileName);
@@ -135,18 +131,475 @@
 
 		#region Methods
 
-		public void Dispose ()
-		{
+		public void Dispose () {
 			Dispose (true);
 			//GC.SuppressFinalize (this);
 		}
 
 		[MonoTODO]
-		protected virtual void Dispose (bool disposing)
-		{
+		protected virtual void Dispose (bool disposing) {
 		}
 
 		#endregion // Methods
+		private class MimeTypes
+		{
+			static Hashtable mimeTypes;
+
+			static MimeTypes () {
+#if NET_2_0
+				mimeTypes = new Hashtable (StringComparer.InvariantCultureIgnoreCase);
+#else
+			    mimeTypes = new Hashtable (CaseInsensitiveHashCodeProvider.DefaultInvariant,
+						   CaseInsensitiveComparer.DefaultInvariant);
+#endif
+
+				mimeTypes.Add ("3dm", "x-world/x-3dmf");
+				mimeTypes.Add ("3dmf", "x-world/x-3dmf");
+				mimeTypes.Add ("aab", "application/x-authorware-bin");
+				mimeTypes.Add ("aam", "application/x-authorware-map");
+				mimeTypes.Add ("aas", "application/x-authorware-seg");
+				mimeTypes.Add ("abc", "text/vnd.abc");
+				mimeTypes.Add ("acgi", "text/html");
+				mimeTypes.Add ("afl", "video/animaflex");
+				mimeTypes.Add ("ai", "application/postscript");
+				mimeTypes.Add ("aif", "audio/aiff");
+				mimeTypes.Add ("aifc", "audio/aiff");
+				mimeTypes.Add ("aiff", "audio/aiff");
+				mimeTypes.Add ("aim", "application/x-aim");
+				mimeTypes.Add ("aip", "text/x-audiosoft-intra");
+				mimeTypes.Add ("ani", "application/x-navi-animation");
+				mimeTypes.Add ("aos", "application/x-nokia-9000-communicator-add-on-software");
+				mimeTypes.Add ("aps", "application/mime");
+				mimeTypes.Add ("art", "image/x-jg");
+				mimeTypes.Add ("asf", "video/x-ms-asf");
+				mimeTypes.Add ("asm", "text/x-asm");
+				mimeTypes.Add ("asp", "text/asp");
+				mimeTypes.Add ("asx", "application/x-mplayer2");
+				mimeTypes.Add ("au", "audio/x-au");
+				mimeTypes.Add ("avi", "video/avi");
+				mimeTypes.Add ("avs", "video/avs-video");
+				mimeTypes.Add ("bcpio", "application/x-bcpio");
+				mimeTypes.Add ("bm", "image/bmp");
+				mimeTypes.Add ("bmp", "image/bmp");
+				mimeTypes.Add ("boo", "application/book");
+				mimeTypes.Add ("book", "application/book");
+				mimeTypes.Add ("boz", "application/x-bzip2");
+				mimeTypes.Add ("bsh", "application/x-bsh");
+				mimeTypes.Add ("bz", "application/x-bzip");
+				mimeTypes.Add ("bz2", "application/x-bzip2");
+				mimeTypes.Add ("c", "text/plain");
+				mimeTypes.Add ("c++", "text/plain");
+				mimeTypes.Add ("cat", "application/vnd.ms-pki.seccat");
+				mimeTypes.Add ("cc", "text/plain");
+				mimeTypes.Add ("ccad", "application/clariscad");
+				mimeTypes.Add ("cco", "application/x-cocoa");
+				mimeTypes.Add ("cdf", "application/cdf");
+				mimeTypes.Add ("cer", "application/pkix-cert");
+				mimeTypes.Add ("cha", "application/x-chat");
+				mimeTypes.Add ("chat", "application/x-chat");
+				mimeTypes.Add ("class", "application/java");
+				mimeTypes.Add ("conf", "text/plain");
+				mimeTypes.Add ("cpio", "application/x-cpio");
+				mimeTypes.Add ("cpp", "text/plain");
+				mimeTypes.Add ("cpt", "application/x-cpt");
+				mimeTypes.Add ("crl", "application/pkix-crl");
+				mimeTypes.Add ("crt", "application/pkix-cert");
+				mimeTypes.Add ("csh", "application/x-csh");
+				mimeTypes.Add ("css", "text/css");
+				mimeTypes.Add ("cxx", "text/plain");
+				mimeTypes.Add ("dcr", "application/x-director");
+				mimeTypes.Add ("deepv", "application/x-deepv");
+				mimeTypes.Add ("def", "text/plain");
+				mimeTypes.Add ("der", "application/x-x509-ca-cert");
+				mimeTypes.Add ("dif", "video/x-dv");
+				mimeTypes.Add ("dir", "application/x-director");
+				mimeTypes.Add ("dl", "video/dl");
+				mimeTypes.Add ("doc", "application/msword");
+				mimeTypes.Add ("dot", "application/msword");
+				mimeTypes.Add ("dp", "application/commonground");
+				mimeTypes.Add ("drw", "application/drafting");
+				mimeTypes.Add ("dv", "video/x-dv");
+				mimeTypes.Add ("dvi", "application/x-dvi");
+				mimeTypes.Add ("dwf", "drawing/x-dwf (old)");
+				mimeTypes.Add ("dwg", "application/acad");
+				mimeTypes.Add ("dxf", "application/dxf");
+				mimeTypes.Add ("dxr", "application/x-director");
+				mimeTypes.Add ("el", "text/x-script.elisp");
+				mimeTypes.Add ("elc", "application/x-elc");
+				mimeTypes.Add ("eps", "application/postscript");
+				mimeTypes.Add ("es", "application/x-esrehber");
+				mimeTypes.Add ("etx", "text/x-setext");
+				mimeTypes.Add ("evy", "application/envoy");
+				mimeTypes.Add ("f", "text/plain");
+				mimeTypes.Add ("f77", "text/plain");
+				mimeTypes.Add ("f90", "text/plain");
+				mimeTypes.Add ("fdf", "application/vnd.fdf");
+				mimeTypes.Add ("fif", "image/fif");
+				mimeTypes.Add ("fli", "video/fli");
+				mimeTypes.Add ("flo", "image/florian");
+				mimeTypes.Add ("flx", "text/vnd.fmi.flexstor");
+				mimeTypes.Add ("fmf", "video/x-atomic3d-feature");
+				mimeTypes.Add ("for", "text/plain");
+				mimeTypes.Add ("fpx", "image/vnd.fpx");
+				mimeTypes.Add ("frl", "application/freeloader");
+				mimeTypes.Add ("funk", "audio/make");
+				mimeTypes.Add ("g", "text/plain");
+				mimeTypes.Add ("g3", "image/g3fax");
+				mimeTypes.Add ("gif", "image/gif");
+				mimeTypes.Add ("gl", "video/gl");
+				mimeTypes.Add ("gsd", "audio/x-gsm");
+				mimeTypes.Add ("gsm", "audio/x-gsm");
+				mimeTypes.Add ("gsp", "application/x-gsp");
+				mimeTypes.Add ("gss", "application/x-gss");
+				mimeTypes.Add ("gtar", "application/x-gtar");
+				mimeTypes.Add ("gz", "application/x-gzip");
+				mimeTypes.Add ("gzip", "application/x-gzip");
+				mimeTypes.Add ("h", "text/plain");
+				mimeTypes.Add ("hdf", "application/x-hdf");
+				mimeTypes.Add ("help", "application/x-helpfile");
+				mimeTypes.Add ("hgl", "application/vnd.hp-HPGL");
+				mimeTypes.Add ("hh", "text/plain");
+				mimeTypes.Add ("hlb", "text/x-script");
+				mimeTypes.Add ("hlp", "application/x-helpfile");
+				mimeTypes.Add ("hpg", "application/vnd.hp-HPGL");
+				mimeTypes.Add ("hpgl", "application/vnd.hp-HPGL");
+				mimeTypes.Add ("hqx", "application/binhex");
+				mimeTypes.Add ("hta", "application/hta");
+				mimeTypes.Add ("htc", "text/x-component");
+				mimeTypes.Add ("htm", "text/html");
+				mimeTypes.Add ("html", "text/html");
+				mimeTypes.Add ("htmls", "text/html");
+				mimeTypes.Add ("htt", "text/webviewhtml");
+				mimeTypes.Add ("htx", "text/html");
+				mimeTypes.Add ("ice", "x-conference/x-cooltalk");
+				mimeTypes.Add ("ico", "image/x-icon");
+				mimeTypes.Add ("idc", "text/plain");
+				mimeTypes.Add ("ief", "image/ief");
+				mimeTypes.Add ("iefs", "image/ief");
+				mimeTypes.Add ("iges", "application/iges");
+				mimeTypes.Add ("igs", "application/iges");
+				mimeTypes.Add ("ima", "application/x-ima");
+				mimeTypes.Add ("imap", "application/x-httpd-imap");
+				mimeTypes.Add ("inf", "application/inf");
+				mimeTypes.Add ("ins", "application/x-internett-signup");
+				mimeTypes.Add ("ip", "application/x-ip2");
+				mimeTypes.Add ("isu", "video/x-isvideo");
+				mimeTypes.Add ("it", "audio/it");
+				mimeTypes.Add ("iv", "application/x-inventor");
+				mimeTypes.Add ("ivr", "i-world/i-vrml");
+				mimeTypes.Add ("ivy", "application/x-livescreen");
+				mimeTypes.Add ("jam", "audio/x-jam");
+				mimeTypes.Add ("jav", "text/plain");
+				mimeTypes.Add ("java", "text/plain");
+				mimeTypes.Add ("jcm", "application/x-java-commerce");
+				mimeTypes.Add ("jfif", "image/jpeg");
+				mimeTypes.Add ("jfif-tbnl", "image/jpeg");
+				mimeTypes.Add ("jpe", "image/jpeg");
+				mimeTypes.Add ("jpeg", "image/jpeg");
+				mimeTypes.Add ("jpg", "image/jpeg");
+				mimeTypes.Add ("jps", "image/x-jps");
+				mimeTypes.Add ("js", "application/x-javascript");
+				mimeTypes.Add ("jut", "image/jutvision");
+				mimeTypes.Add ("kar", "audio/midi");
+				mimeTypes.Add ("ksh", "text/x-script.ksh");
+				mimeTypes.Add ("la", "audio/nspaudio");
+				mimeTypes.Add ("lam", "audio/x-liveaudio");
+				mimeTypes.Add ("latex", "application/x-latex");
+				mimeTypes.Add ("list", "text/plain");
+				mimeTypes.Add ("lma", "audio/nspaudio");
+				mimeTypes.Add ("log", "text/plain");
+				mimeTypes.Add ("lsp", "application/x-lisp");
+				mimeTypes.Add ("lst", "text/plain");
+				mimeTypes.Add ("lsx", "text/x-la-asf");
+				mimeTypes.Add ("ltx", "application/x-latex");
+				mimeTypes.Add ("m", "text/plain");
+				mimeTypes.Add ("m1v", "video/mpeg");
+				mimeTypes.Add ("m2a", "audio/mpeg");
+				mimeTypes.Add ("m2v", "video/mpeg");
+				mimeTypes.Add ("m3u", "audio/x-mpequrl");
+				mimeTypes.Add ("man", "application/x-troff-man");
+				mimeTypes.Add ("map", "application/x-navimap");
+				mimeTypes.Add ("mar", "text/plain");
+				mimeTypes.Add ("mbd", "application/mbedlet");
+				mimeTypes.Add ("mc$", "application/x-magic-cap-package-1.0");
+				mimeTypes.Add ("mcd", "application/mcad");
+				mimeTypes.Add ("mcf", "image/vasa");
+				mimeTypes.Add ("mcp", "application/netmc");
+				mimeTypes.Add ("me", "application/x-troff-me");
+				mimeTypes.Add ("mht", "message/rfc822");
+				mimeTypes.Add ("mhtml", "message/rfc822");
+				mimeTypes.Add ("mid", "audio/midi");
+				mimeTypes.Add ("midi", "audio/midi");
+				mimeTypes.Add ("mif", "application/x-mif");
+				mimeTypes.Add ("mime", "message/rfc822");
+				mimeTypes.Add ("mjf", "audio/x-vnd.AudioExplosion.MjuiceMediaFile");
+				mimeTypes.Add ("mjpg", "video/x-motion-jpeg");
+				mimeTypes.Add ("mm", "application/base64");
+				mimeTypes.Add ("mme", "application/base64");
+				mimeTypes.Add ("mod", "audio/mod");
+				mimeTypes.Add ("moov", "video/quicktime");
+				mimeTypes.Add ("mov", "video/quicktime");
+				mimeTypes.Add ("movie", "video/x-sgi-movie");
+				mimeTypes.Add ("mp2", "video/mpeg");
+				mimeTypes.Add ("mp3", "audio/mpeg3");
+				mimeTypes.Add ("mpa", "audio/mpeg");
+				mimeTypes.Add ("mpc", "application/x-project");
+				mimeTypes.Add ("mpe", "video/mpeg");
+				mimeTypes.Add ("mpeg", "video/mpeg");
+				mimeTypes.Add ("mpg", "video/mpeg");
+				mimeTypes.Add ("mpga", "audio/mpeg");
+				mimeTypes.Add ("mpp", "application/vnd.ms-project");
+				mimeTypes.Add ("mpt", "application/x-project");
+				mimeTypes.Add ("mpv", "application/x-project");
+				mimeTypes.Add ("mpx", "application/x-project");
+				mimeTypes.Add ("mrc", "application/marc");
+				mimeTypes.Add ("ms", "application/x-troff-ms");
+				mimeTypes.Add ("mv", "video/x-sgi-movie");
+				mimeTypes.Add ("my", "audio/make");
+				mimeTypes.Add ("mzz", "application/x-vnd.AudioExplosion.mzz");
+				mimeTypes.Add ("nap", "image/naplps");
+				mimeTypes.Add ("naplps", "image/naplps");
+				mimeTypes.Add ("nc", "application/x-netcdf");
+				mimeTypes.Add ("ncm", "application/vnd.nokia.configuration-message");
+				mimeTypes.Add ("nif", "image/x-niff");
+				mimeTypes.Add ("niff", "image/x-niff");
+				mimeTypes.Add ("nix", "application/x-mix-transfer");
+				mimeTypes.Add ("nsc", "application/x-conference");
+				mimeTypes.Add ("nvd", "application/x-navidoc");
+				mimeTypes.Add ("oda", "application/oda");
+				mimeTypes.Add ("omc", "application/x-omc");
+				mimeTypes.Add ("omcd", "application/x-omcdatamaker");
+				mimeTypes.Add ("omcr", "application/x-omcregerator");
+				mimeTypes.Add ("p", "text/x-pascal");
+				mimeTypes.Add ("p10", "application/pkcs10");
+				mimeTypes.Add ("p12", "application/pkcs-12");
+				mimeTypes.Add ("p7a", "application/x-pkcs7-signature");
+				mimeTypes.Add ("p7c", "application/pkcs7-mime");
+				mimeTypes.Add ("p7m", "application/pkcs7-mime");
+				mimeTypes.Add ("p7r", "application/x-pkcs7-certreqresp");
+				mimeTypes.Add ("p7s", "application/pkcs7-signature");
+				mimeTypes.Add ("part", "application/pro_eng");
+				mimeTypes.Add ("pas", "text/pascal");
+				mimeTypes.Add ("pbm", "image/x-portable-bitmap");
+				mimeTypes.Add ("pcl", "application/x-pcl");
+				mimeTypes.Add ("pct", "image/x-pict");
+				mimeTypes.Add ("pcx", "image/x-pcx");
+				mimeTypes.Add ("pdb", "chemical/x-pdb");
+				mimeTypes.Add ("pdf", "application/pdf");
+				mimeTypes.Add ("pfunk", "audio/make");
+				mimeTypes.Add ("pgm", "image/x-portable-graymap");
+				mimeTypes.Add ("pic", "image/pict");
+				mimeTypes.Add ("pict", "image/pict");
+				mimeTypes.Add ("pkg", "application/x-newton-compatible-pkg");
+				mimeTypes.Add ("pko", "application/vnd.ms-pki.pko");
+				mimeTypes.Add ("pl", "text/plain");
+				mimeTypes.Add ("plx", "application/x-PiXCLscript");
+				mimeTypes.Add ("pm", "image/x-xpixmap");
+				mimeTypes.Add ("pm4", "application/x-pagemaker");
+				mimeTypes.Add ("pm5", "application/x-pagemaker");
+				mimeTypes.Add ("png", "image/png");
+				mimeTypes.Add ("pnm", "application/x-portable-anymap");
+				mimeTypes.Add ("pot", "application/mspowerpoint");
+				mimeTypes.Add ("pov", "model/x-pov");
+				mimeTypes.Add ("ppa", "application/vnd.ms-powerpoint");
+				mimeTypes.Add ("ppm", "image/x-portable-pixmap");
+				mimeTypes.Add ("pps", "application/mspowerpoint");
+				mimeTypes.Add ("ppt", "application/mspowerpoint");
+				mimeTypes.Add ("ppz", "application/mspowerpoint");
+				mimeTypes.Add ("pre", "application/x-freelance");
+				mimeTypes.Add ("prt", "application/pro_eng");
+				mimeTypes.Add ("ps", "application/postscript");
+				mimeTypes.Add ("pvu", "paleovu/x-pv");
+				mimeTypes.Add ("pwz", "application/vnd.ms-powerpoint");
+				mimeTypes.Add ("py", "text/x-script.phyton");
+				mimeTypes.Add ("pyc", "applicaiton/x-bytecode.python");
+				mimeTypes.Add ("qcp", "audio/vnd.qcelp");
+				mimeTypes.Add ("qd3", "x-world/x-3dmf");
+				mimeTypes.Add ("qd3d", "x-world/x-3dmf");
+				mimeTypes.Add ("qif", "image/x-quicktime");
+				mimeTypes.Add ("qt", "video/quicktime");
+				mimeTypes.Add ("qtc", "video/x-qtc");
+				mimeTypes.Add ("qti", "image/x-quicktime");
+				mimeTypes.Add ("qtif", "image/x-quicktime");
+				mimeTypes.Add ("ra", "audio/x-pn-realaudio");
+				mimeTypes.Add ("ram", "audio/x-pn-realaudio");
+				mimeTypes.Add ("ras", "application/x-cmu-raster");
+				mimeTypes.Add ("rast", "image/cmu-raster");
+				mimeTypes.Add ("rexx", "text/x-script.rexx");
+				mimeTypes.Add ("rf", "image/vnd.rn-realflash");
+				mimeTypes.Add ("rgb", "image/x-rgb");
+				mimeTypes.Add ("rm", "application/vnd.rn-realmedia");
+				mimeTypes.Add ("rmi", "audio/mid");
+				mimeTypes.Add ("rmm", "audio/x-pn-realaudio");
+				mimeTypes.Add ("rmp", "audio/x-pn-realaudio");
+				mimeTypes.Add ("rng", "application/ringing-tones");
+				mimeTypes.Add ("rnx", "application/vnd.rn-realplayer");
+				mimeTypes.Add ("roff", "application/x-troff");
+				mimeTypes.Add ("rp", "image/vnd.rn-realpix");
+				mimeTypes.Add ("rpm", "audio/x-pn-realaudio-plugin");
+				mimeTypes.Add ("rss", "text/xml");
+				mimeTypes.Add ("rt", "text/richtext");
+				mimeTypes.Add ("rtf", "text/richtext");
+				mimeTypes.Add ("rtx", "text/richtext");
+				mimeTypes.Add ("rv", "video/vnd.rn-realvideo");
+				mimeTypes.Add ("s", "text/x-asm");
+				mimeTypes.Add ("s3m", "audio/s3m");
+				mimeTypes.Add ("sbk", "application/x-tbook");
+				mimeTypes.Add ("scm", "application/x-lotusscreencam");
+				mimeTypes.Add ("sdml", "text/plain");
+				mimeTypes.Add ("sdp", "application/sdp");
+				mimeTypes.Add ("sdr", "application/sounder");
+				mimeTypes.Add ("sea", "application/sea");
+				mimeTypes.Add ("set", "application/set");
+				mimeTypes.Add ("sgm", "text/sgml");
+				mimeTypes.Add ("sgml", "text/sgml");
+				mimeTypes.Add ("sh", "text/x-script.sh");
+				mimeTypes.Add ("shar", "application/x-bsh");
+				mimeTypes.Add ("shtml", "text/html");
+				mimeTypes.Add ("sid", "audio/x-psid");
+				mimeTypes.Add ("sit", "application/x-sit");
+				mimeTypes.Add ("skd", "application/x-koan");
+				mimeTypes.Add ("skm", "application/x-koan");
+				mimeTypes.Add ("skp", "application/x-koan");
+				mimeTypes.Add ("skt", "application/x-koan");
+				mimeTypes.Add ("sl", "application/x-seelogo");
+				mimeTypes.Add ("smi", "application/smil");
+				mimeTypes.Add ("smil", "application/smil");
+				mimeTypes.Add ("snd", "audio/basic");
+				mimeTypes.Add ("sol", "application/solids");
+				mimeTypes.Add ("spc", "application/x-pkcs7-certificates");
+				mimeTypes.Add ("spl", "application/futuresplash");
+				mimeTypes.Add ("spr", "application/x-sprite");
+				mimeTypes.Add ("sprite", "application/x-sprite");
+				mimeTypes.Add ("src", "application/x-wais-source");
+				mimeTypes.Add ("ssi", "text/x-server-parsed-html");
+				mimeTypes.Add ("ssm", "application/streamingmedia");
+				mimeTypes.Add ("sst", "application/vnd.ms-pki.certstore");
+				mimeTypes.Add ("step", "application/step");
+				mimeTypes.Add ("stl", "application/sla");
+				mimeTypes.Add ("stp", "application/step");
+				mimeTypes.Add ("sv4cpio", "application/x-sv4cpio");
+				mimeTypes.Add ("sv4crc", "application/x-sv4crc");
+				mimeTypes.Add ("svf", "image/x-dwg");
+				mimeTypes.Add ("svr", "application/x-world");
+				mimeTypes.Add ("swf", "application/x-shockwave-flash");
+				mimeTypes.Add ("t", "application/x-troff");
+				mimeTypes.Add ("talk", "text/x-speech");
+				mimeTypes.Add ("tar", "application/x-tar");
+				mimeTypes.Add ("tbk", "application/toolbook");
+				mimeTypes.Add ("tcl", "text/x-script.tcl");
+				mimeTypes.Add ("tcsh", "text/x-script.tcsh");
+				mimeTypes.Add ("tex", "application/x-tex");
+				mimeTypes.Add ("texi", "application/x-texinfo");
+				mimeTypes.Add ("texinfo", "application/x-texinfo");
+				mimeTypes.Add ("text", "text/plain");
+				mimeTypes.Add ("tgz", "application/x-compressed");
+				mimeTypes.Add ("tif", "image/tiff");
+				mimeTypes.Add ("tiff", "image/tiff");
+				mimeTypes.Add ("tr", "application/x-troff");
+				mimeTypes.Add ("tsi", "audio/tsp-audio");
+				mimeTypes.Add ("tsp", "audio/tsplayer");
+				mimeTypes.Add ("tsv", "text/tab-separated-values");
+				mimeTypes.Add ("turbot", "image/florian");
+				mimeTypes.Add ("txt", "text/plain");
+				mimeTypes.Add ("uil", "text/x-uil");
+				mimeTypes.Add ("uni", "text/uri-list");
+				mimeTypes.Add ("unis", "text/uri-list");
+				mimeTypes.Add ("unv", "application/i-deas");
+				mimeTypes.Add ("uri", "text/uri-list");
+				mimeTypes.Add ("uris", "text/uri-list");
+				mimeTypes.Add ("ustar", "multipart/x-ustar");
+				mimeTypes.Add ("uu", "text/x-uuencode");
+				mimeTypes.Add ("uue", "text/x-uuencode");
+				mimeTypes.Add ("vcd", "application/x-cdlink");
+				mimeTypes.Add ("vcs", "text/x-vCalendar");
+				mimeTypes.Add ("vda", "application/vda");
+				mimeTypes.Add ("vdo", "video/vdo");
+				mimeTypes.Add ("vew", "application/groupwise");
+				mimeTypes.Add ("viv", "video/vivo");
+				mimeTypes.Add ("vivo", "video/vivo");
+				mimeTypes.Add ("vmd", "application/vocaltec-media-desc");
+				mimeTypes.Add ("vmf", "application/vocaltec-media-file");
+				mimeTypes.Add ("voc", "audio/voc");
+				mimeTypes.Add ("vos", "video/vosaic");
+				mimeTypes.Add ("vox", "audio/voxware");
+				mimeTypes.Add ("vqe", "audio/x-twinvq-plugin");
+				mimeTypes.Add ("vqf", "audio/x-twinvq");
+				mimeTypes.Add ("vql", "audio/x-twinvq-plugin");
+				mimeTypes.Add ("vrml", "application/x-vrml");
+				mimeTypes.Add ("vrt", "x-world/x-vrt");
+				mimeTypes.Add ("vsd", "application/x-visio");
+				mimeTypes.Add ("vst", "application/x-visio");
+				mimeTypes.Add ("vsw", "application/x-visio");
+				mimeTypes.Add ("w60", "application/wordperfect6.0");
+				mimeTypes.Add ("w61", "application/wordperfect6.1");
+				mimeTypes.Add ("w6w", "application/msword");
+				mimeTypes.Add ("wav", "audio/wav");
+				mimeTypes.Add ("wb1", "application/x-qpro");
+				mimeTypes.Add ("wbmp", "image/vnd.wap.wbmp");
+				mimeTypes.Add ("web", "application/vnd.xara");
+				mimeTypes.Add ("wiz", "application/msword");
+				mimeTypes.Add ("wk1", "application/x-123");
+				mimeTypes.Add ("wmf", "windows/metafile");
+				mimeTypes.Add ("wml", "text/vnd.wap.wml");
+				mimeTypes.Add ("wmlc", "application/vnd.wap.wmlc");
+				mimeTypes.Add ("wmls", "text/vnd.wap.wmlscript");
+				mimeTypes.Add ("wmlsc", "application/vnd.wap.wmlscriptc");
+				mimeTypes.Add ("word", "application/msword");
+				mimeTypes.Add ("wp", "application/wordperfect");
+				mimeTypes.Add ("wp5", "application/wordperfect");
+				mimeTypes.Add ("wp6", "application/wordperfect");
+				mimeTypes.Add ("wpd", "application/wordperfect");
+				mimeTypes.Add ("wq1", "application/x-lotus");
+				mimeTypes.Add ("wri", "application/mswrite");
+				mimeTypes.Add ("wrl", "application/x-world");
+				mimeTypes.Add ("wrz", "model/vrml");
+				mimeTypes.Add ("wsc", "text/scriplet");
+				mimeTypes.Add ("wsrc", "application/x-wais-source");
+				mimeTypes.Add ("wtk", "application/x-wintalk");
+				mimeTypes.Add ("xbm", "image/x-xbitmap");
+				mimeTypes.Add ("xdr", "video/x-amt-demorun");
+				mimeTypes.Add ("xgz", "xgl/drawing");
+				mimeTypes.Add ("xif", "image/vnd.xiff");
+				mimeTypes.Add ("xl", "application/excel");
+				mimeTypes.Add ("xla", "application/excel");
+				mimeTypes.Add ("xlb", "application/excel");
+				mimeTypes.Add ("xlc", "application/excel");
+				mimeTypes.Add ("xld", "application/excel");
+				mimeTypes.Add ("xlk", "application/excel");
+				mimeTypes.Add ("xll", "application/excel");
+				mimeTypes.Add ("xlm", "application/excel");
+				mimeTypes.Add ("xls", "application/excel");
+				mimeTypes.Add ("xlt", "application/excel");
+				mimeTypes.Add ("xlv", "application/excel");
+				mimeTypes.Add ("xlw", "application/excel");
+				mimeTypes.Add ("xm", "audio/xm");
+				mimeTypes.Add ("xml", "text/xml");
+				mimeTypes.Add ("xmz", "xgl/movie");
+				mimeTypes.Add ("xpix", "application/x-vnd.ls-xpix");
+				mimeTypes.Add ("xpm", "image/xpm");
+				mimeTypes.Add ("x-png", "image/png");
+				mimeTypes.Add ("xsr", "video/x-amt-showrun");
+				mimeTypes.Add ("xwd", "image/x-xwd");
+				mimeTypes.Add ("xyz", "chemical/x-pdb");
+				mimeTypes.Add ("z", "application/x-compressed");
+				mimeTypes.Add ("zip", "application/zip");
+				mimeTypes.Add ("zsh", "text/x-script.zsh");
+			}
+
+			public static string GetMimeType (string fileName) {
+				string result = null;
+				int dot = fileName.LastIndexOf ('.');
+
+				if (dot != -1 && fileName.Length > dot + 1)
+					result = mimeTypes [fileName.Substring (dot + 1)] as string;
+
+				if (result == null)
+					result = "application/octet-stream";
+
+				return result;
+			}
+		}
 	}
 }
 
Index: System.Net.Mail/MailAddress.cs
===================================================================
--- System.Net.Mail/MailAddress.cs	(revision 68672)
+++ System.Net.Mail/MailAddress.cs	(working copy)
@@ -32,8 +32,9 @@
 
 using System.Text;
 
-namespace System.Net.Mail {
-	public class MailAddress 
+namespace System.Net.Mail
+{
+	public class MailAddress
 	{
 		#region Fields
 
@@ -45,17 +46,18 @@
 
 		#region Constructors
 
-		public MailAddress (string address) : this (address, null)
-		{
+		public MailAddress (string address)
+			: this (address, null) {
 		}
 
-		public MailAddress (string address, string displayName) : this (address, displayName, Encoding.Default)
-		{
+		public MailAddress (string address, string displayName)
+			: this (address, displayName, Encoding.Default) {
 		}
 
-		public MailAddress (string address, string name, Encoding displayNameEncoding)
-		{
-			this.address = address;
+		public MailAddress (string address, string name, Encoding displayNameEncoding) {
+			if (!(address [0] == '<' && address [address.Length - 1] == '>'))
+				this.address = "<" + address + ">";
+
 			this.displayName = name;
 			//this.displayNameEncoding = displayNameEncoding;
 		}
@@ -64,7 +66,7 @@
 
 		#region Properties
 
-		public string Address {	
+		public string Address {
 			get { return address; }
 		}
 
@@ -83,33 +85,27 @@
 		#endregion // Properties
 
 		#region Methods
-		
-		public override bool Equals (object obj)
-		{
+
+		public override bool Equals (object obj) {
 			return Equals (obj as MailAddress);
 		}
 
-		bool Equals (MailAddress other)
-		{
+		bool Equals (MailAddress other) {
 			return other != null && Address == other.Address;
 		}
 
-		public override int GetHashCode ()
-		{
+		public override int GetHashCode () {
 			return address.GetHashCode ();
 		}
 
-		public override string ToString ()
-		{
+		public override string ToString () {
 			StringBuilder sb = new StringBuilder ();
 			if (DisplayName != null && DisplayName.Length > 0) {
 				sb.Append ("\"");
 				sb.Append (DisplayName);
 				sb.Append ("\"");
 				sb.Append (" ");
-				sb.Append ("<");
 				sb.Append (Address);
-				sb.Append (">");
 			}
 			else {
 				sb.Append (Address);
Index: System.Net.Mail/MailMessage.cs
===================================================================
--- System.Net.Mail/MailMessage.cs	(revision 68672)
+++ System.Net.Mail/MailMessage.cs	(working copy)
@@ -35,7 +35,8 @@
 using System.Net.Mime;
 using System.Text;
 
-namespace System.Net.Mail {
+namespace System.Net.Mail
+{
 	[MonoTODO]
 	public class MailMessage : IDisposable
 	{
@@ -60,20 +61,8 @@
 
 		#region Constructors
 
-		public MailMessage ()
-		{
-		}
-
-		[MonoTODO ("FormatException")]
-		public MailMessage (MailAddress from, MailAddress to)
-		{
-			if (from == null || to == null)
-				throw new ArgumentNullException ();
-			
-			From = from;
-
+		public MailMessage () {
 			this.to = new MailAddressCollection ();
-			this.to.Add (to);
 
 			alternateViews = new AlternateViewCollection ();
 			attachments = new AttachmentCollection ();
@@ -84,16 +73,25 @@
 			headers.Add ("MIME-Version", "1.0");
 		}
 
+		[MonoTODO ("FormatException")]
+		public MailMessage (MailAddress from, MailAddress to)
+			: this () {
+			if (from == null || to == null)
+				throw new ArgumentNullException ();
+
+			From = from;
+
+			this.to.Add (to);
+		}
+
 		public MailMessage (string from, string to)
-			: this (new MailAddress (from), new MailAddress (to))
-		{
+			: this (new MailAddress (from), new MailAddress (to)) {
 			if (from == null || to == null)
 				throw new ArgumentNullException ();
 		}
 
 		public MailMessage (string from, string to, string subject, string body)
-			: this (new MailAddress (from), new MailAddress (to))
-		{
+			: this (new MailAddress (from), new MailAddress (to)) {
 			if (from == null || to == null)
 				throw new ArgumentNullException ();
 			Body = body;
@@ -195,14 +193,12 @@
 
 		#region Methods
 
-		public void Dispose ()
-		{
+		public void Dispose () {
 			Dispose (true);
 			GC.SuppressFinalize (this);
 		}
 
-		protected virtual void Dispose (bool disposing)
-		{
+		protected virtual void Dispose (bool disposing) {
 		}
 
 		#endregion // Methods
Index: System.Net.Mail/SmtpClient.cs
===================================================================
--- System.Net.Mail/SmtpClient.cs	(revision 68672)
+++ System.Net.Mail/SmtpClient.cs	(working copy)
@@ -40,8 +40,12 @@
 using System.Security.Cryptography.X509Certificates;
 using System.Text;
 using System.Threading;
+using System.Reflection;
+using System.Net.Configuration;
+using System.Configuration;
 
-namespace System.Net.Mail {
+namespace System.Net.Mail
+{
 	public class SmtpClient
 	{
 		#region Fields
@@ -60,7 +64,8 @@
 		NetworkStream stream;
 		StreamWriter writer;
 		StreamReader reader;
-		int boundaryIndex;
+		int boundaryIndex;
+		MailAddress defaultFrom;
 
 		Mutex mutex = new Mutex ();
 
@@ -71,31 +76,38 @@
 		#region Constructors
 
 		public SmtpClient ()
-			: this (null, 0)
-		{
+			: this (null, 0) {
 		}
 
 		public SmtpClient (string host)
-			: this (host, 0)
-		{
+			: this (host, 0) {
 		}
 
-		[MonoTODO ("Load default settings from configuration.")]
-		public SmtpClient (string host, int port)
-		{
-			// FIXME: load from configuration
-			if (String.IsNullOrEmpty (host))
-				Host = "127.0.0.1";
-			else
-				Host = host;
-			
-			// FIXME: load from configuration
-			if (port == 0)
-				Port = 25;
-			else
-				Port = port;
-
-			// FIXME: load credentials from configuration
+		public SmtpClient (string host, int port) {
+
+			SmtpSection cfg = (SmtpSection) ConfigurationManager.GetSection ("system.net/mailSettings/smtp");
+
+			if (cfg != null) {
+				this.host = cfg.Network.Host;
+				this.port = cfg.Network.Port;
+				if (cfg.Network.UserName != null) {
+					string password = String.Empty;
+
+					if (cfg.Network.Password != null)
+						password = cfg.Network.Password;
+
+					Credentials = new CCredentialsByHost (cfg.Network.UserName, password);
+				}
+
+				if (cfg.From != null)
+					defaultFrom = new MailAddress (cfg.From);
+			}
+
+			if (!String.IsNullOrEmpty (host))
+				this.host = host;
+
+			if (port != 0)
+				this.port = port;
 		}
 
 		#endregion // Constructors
@@ -104,7 +116,7 @@
 
 		[MonoTODO]
 		public X509CertificateCollection ClientCertificates {
-			get { return clientCertificates; }
+			get { throw new NotImplementedException ("Client certificates are not supported"); return clientCertificates; }
 		}
 
 		public ICredentialsByHost Credentials {
@@ -142,10 +154,10 @@
 		public int Port {
 			get { return port; }
 			[MonoTODO ("Check to make sure an email is not being sent.")]
-			set { 
+			set {
 				if (value <= 0)
 					throw new ArgumentOutOfRangeException ();
-				port = value; 
+				port = value;
 			}
 		}
 
@@ -157,74 +169,103 @@
 		public int Timeout {
 			get { return timeout; }
 			[MonoTODO ("Check to make sure an email is not being sent.")]
-			set { 
+			set {
 				if (value < 0)
 					throw new ArgumentOutOfRangeException ();
-				timeout = value; 
+				timeout = value;
 			}
 		}
 
 		[MonoTODO]
 		public bool UseDefaultCredentials {
-			get { return useDefaultCredentials; }
-			set { useDefaultCredentials = value; }
+			get { return useDefaultCredentials; }
+			set { throw new NotImplementedException ("Default credentials are not supported"); }
 		}
 
 		#endregion // Properties
 
-		#region Events 
+		#region Events
 
 		public event SendCompletedEventHandler SendCompleted;
 
-		#endregion // Events 
+		#endregion // Events
 
 		#region Methods
 
-		private void EndSection (string section)
-		{
+		private void EndSection (string section) {
 			SendData (String.Format ("--{0}--", section));
+			SendData (string.Empty);
 		}
 
-		private string GenerateBoundary ()
-		{
+		private string GenerateBoundary () {
 			string output = GenerateBoundary (boundaryIndex);
 			boundaryIndex += 1;
 			return output;
 		}
 
-		private static string GenerateBoundary (int index)
-		{
+		private static string GenerateBoundary (int index) {
 			return String.Format ("--boundary_{0}_{1}", index, Guid.NewGuid ().ToString ("D"));
 		}
 
-		private bool IsError (SmtpResponse status)
-		{
+		private bool IsError (SmtpResponse status) {
 			return ((int) status.StatusCode) >= 400;
 		}
 
-		protected void OnSendCompleted (AsyncCompletedEventArgs e)
-		{
+		protected void OnSendCompleted (AsyncCompletedEventArgs e) {
 			if (SendCompleted != null)
 				SendCompleted (this, e);
 		}
 
-		private SmtpResponse Read ()
-		{
-			SmtpResponse response;
+		private SmtpResponse Read () {
+			byte [] buffer = new byte [512];
+			int position = 0;
+			bool lastLine = false;
 
-			char[] buf = new char [3];
-			reader.Read (buf, 0, 3);
-			reader.Read ();
+			do {
+				int readLength = stream.Read (buffer, position, buffer.Length - position);
+				if (readLength > 0) {
+					int available = position + readLength - 1;
+					if (available > 4 && (buffer [available] == '\n' || buffer [available] == '\r'))
+						for (int index = available - 3; ; index--) {
+							if (index < 0 || buffer [index] == '\n' || buffer [index] == '\r') {
+								lastLine = buffer [index + 4] == ' ';
+								break;
+							}
+						}
 
-			response.StatusCode = (SmtpStatusCode) Int32.Parse (new String (buf));
-			response.Description = reader.ReadLine ();
+					// move position
+					position += readLength;
 
-			return response;
+					// check if buffer is full
+					if (position == buffer.Length) {
+						byte [] newBuffer = new byte [buffer.Length * 2];
+						Array.Copy (buffer, 0, newBuffer, 0, buffer.Length);
+						buffer = newBuffer;
+					}
+				}
+				else {
+					break;
+				}
+			} while (!lastLine);
+
+			if (position > 0) {
+				Encoding encoding = new ASCIIEncoding ();
+
+				string line = encoding.GetString (buffer, 0, position - 1);
+
+				// parse the line to the lastResponse object
+				SmtpResponse response = SmtpResponse.Parse (line);
+
+				return response;
+			}
+			else {
+				throw new System.IO.IOException ("Connection closed");
+			}
 		}
 
-		[MonoTODO ("Need to work on message attachments.")]
-		public void Send (MailMessage message)
-		{
+		public void Send (MailMessage message) {
+			CheckHostAndPort ();
+
 			// Block while sending
 			mutex.WaitOne ();
 
@@ -234,48 +275,57 @@
 			stream = client.GetStream ();
 			writer = new StreamWriter (stream);
 			reader = new StreamReader (stream);
-			boundaryIndex = 0;
-			string boundary = GenerateBoundary ();
 
-			bool hasAlternateViews = (message.AlternateViews.Count > 0);
-			bool hasAttachments = (message.Attachments.Count > 0);
-
 			status = Read ();
 			if (IsError (status))
-				throw new SmtpException (status.StatusCode);
+				throw new SmtpException (status.StatusCode, status.Description);
 
-			// HELO
-			status = SendCommand (Command.Helo, Dns.GetHostName ());
-			if (IsError (status))
-				throw new SmtpException (status.StatusCode);
+			// EHLO
+			status = SendCommand (Command.Ehlo, Dns.GetHostName ());
 
+			if (IsError (status)) {
+				throw new SmtpException (status.StatusCode, status.Description);
+			}
+
+			if (EnableSsl) {
+				InitiateSecureConnection ();
+			}
+
+			PerformAuthentication ();
+
+			MailAddress from = message.From;
+
+			if (from == null)
+				from = defaultFrom;
+			
 			// MAIL FROM:
-			status = SendCommand (Command.MailFrom, message.From.Address);
-			if (IsError (status))
-				throw new SmtpException (status.StatusCode);
+			status = SendCommand (Command.MailFrom, from.Address);
+			if (IsError (status)) {
+				throw new SmtpException (status.StatusCode, status.Description);
+			}
 
 			// Send RCPT TO: for all recipients
 			List<SmtpFailedRecipientException> sfre = new List<SmtpFailedRecipientException> ();
 
-			for (int i = 0; i < message.To.Count; i ++) {
+			for (int i = 0; i < message.To.Count; i++) {
 				status = SendCommand (Command.RcptTo, message.To [i].Address);
-				if (IsError (status)) 
-					sfre.Add (new SmtpFailedRecipientException (status.StatusCode, message.To [i].Address.ToString ()));
+				if (IsError (status))
+					sfre.Add (new SmtpFailedRecipientException (status.StatusCode, message.To [i].Address));
 			}
-			for (int i = 0; i < message.CC.Count; i ++) {
+			for (int i = 0; i < message.CC.Count; i++) {
 				status = SendCommand (Command.RcptTo, message.CC [i].Address);
-				if (IsError (status)) 
-					sfre.Add (new SmtpFailedRecipientException (status.StatusCode, message.CC [i].Address.ToString ()));
+				if (IsError (status))
+					sfre.Add (new SmtpFailedRecipientException (status.StatusCode, message.CC [i].Address));
 			}
-			for (int i = 0; i < message.Bcc.Count; i ++) {
+			for (int i = 0; i < message.Bcc.Count; i++) {
 				status = SendCommand (Command.RcptTo, message.Bcc [i].Address);
-				if (IsError (status)) 
-					sfre.Add (new SmtpFailedRecipientException (status.StatusCode, message.Bcc [i].Address.ToString ()));
+				if (IsError (status))
+					sfre.Add (new SmtpFailedRecipientException (status.StatusCode, message.Bcc [i].Address));
 			}
 
 #if TARGET_JVM // List<T>.ToArray () is not supported
 			if (sfre.Count > 0) {
-				SmtpFailedRecipientException[] xs = new SmtpFailedRecipientException[sfre.Count];
+				SmtpFailedRecipientException [] xs = new SmtpFailedRecipientException [sfre.Count];
 				sfre.CopyTo (xs);
 				throw new SmtpFailedRecipientsException ("failed recipients", xs);
 			}
@@ -283,25 +333,13 @@
 			if (sfre.Count >0)
 				throw new SmtpFailedRecipientsException ("failed recipients", sfre.ToArray ());
 #endif
-
 			// DATA
 			status = SendCommand (Command.Data);
 			if (IsError (status))
-				throw new SmtpException (status.StatusCode);
+				throw new SmtpException (status.StatusCode, status.Description);
 
-			// Figure out the message content type
-			ContentType messageContentType = message.BodyContentType;
-			if (hasAttachments || hasAlternateViews) {
-				messageContentType.Boundary = boundary;
-
-				if (hasAttachments)
-					messageContentType.MediaType = "multipart/mixed";
-				else
-					messageContentType.MediaType = "multipart/alternative";
-			}
-
 			// Send message headers
-			SendHeader (HeaderName.From, message.From.ToString ());
+			SendHeader (HeaderName.From, from.ToString ());
 			SendHeader (HeaderName.To, message.To.ToString ());
 			if (message.CC.Count > 0)
 				SendHeader (HeaderName.Cc, message.CC.ToString ());
@@ -312,78 +350,30 @@
 			foreach (string s in message.Headers.AllKeys)
 				SendHeader (s, message.Headers [s]);
 
-			SendHeader ("Content-Type", messageContentType.ToString ());
-			SendData ("");
+			AddPriorityHeader (message);
 
-			if (hasAlternateViews) {
-				string innerBoundary = boundary;
+			bool hasAlternateViews = (message.AlternateViews.Count > 0);
+			bool hasAttachments = (message.Attachments.Count > 0);
 
-				// The body is *technically* an alternative view.  The body text goes FIRST because
-				// that is most compatible with non-MIME readers.
-				//
-				// If there are attachments, then the main content-type is multipart/mixed and
-				// the subpart has type multipart/alternative.  Then all of the views have their
-				// own types.  
-				//
-				// If there are no attachments, then the main content-type is multipart/alternative
-				// and we don't need this subpart.
-
-				if (hasAttachments) {
-					innerBoundary = GenerateBoundary ();
-					ContentType contentType = new ContentType ("multipart/alternative");
-					contentType.Boundary = innerBoundary;
-					StartSection (boundary, contentType);
-				}
-				
-				// Start the section for the body text.  This is either section "1" or "0" depending
-				// on whether there are attachments.
-
-				StartSection (innerBoundary, messageContentType, TransferEncoding.QuotedPrintable);
-				SendData (message.Body);
-
-				// Send message attachments.
-				SendAttachments (message.Attachments, innerBoundary);
-
-				if (hasAttachments) 
-					EndSection (innerBoundary);
+			if (hasAttachments || hasAlternateViews) {
+				SendMultipartBody (message);
 			}
 			else {
-				// If this is multipart then we need to send a boundary before the body.
-				if (hasAttachments) {
-					// FIXME: check this
-					ContentType contentType = new ContentType ("multipart/alternative");
-					StartSection (boundary, contentType, TransferEncoding.QuotedPrintable);
-				}
-				SendData (message.Body);
+				SendSimpleBody (message);
 			}
 
-			// Send attachments
-			if (hasAttachments) {
-				string innerBoundary = boundary;
-
-				// If we have alternate views and attachments then we need to nest this part inside another
-				// boundary.  Otherwise, we are cool with the boundary we have.
-
-				if (hasAlternateViews) {
-					innerBoundary = GenerateBoundary ();
-					ContentType contentType = new ContentType ("multipart/mixed");
-					contentType.Boundary = innerBoundary;
-					StartSection (boundary, contentType);
-				}
-
-				SendAttachments (message.Attachments, innerBoundary);
-
-				if (hasAlternateViews)
-					EndSection (innerBoundary);
-			}
-
 			SendData (".");
 
 			status = Read ();
 			if (IsError (status))
-				throw new SmtpException (status.StatusCode);
+				throw new SmtpException (status.StatusCode, status.Description);
 
-			status = SendCommand (Command.Quit);
+			try {
+				status = SendCommand (Command.Quit);
+			}
+			catch (System.IO.IOException) {
+				//We excuse server for the rude connection closing as a response to QUIT
+			}
 
 			writer.Close ();
 			reader.Close ();
@@ -394,45 +384,133 @@
 			mutex.ReleaseMutex ();
 		}
 
-		public void Send (string from, string to, string subject, string body)
-		{
+		public void Send (string from, string to, string subject, string body) {
 			Send (new MailMessage (from, to, subject, body));
 		}
 
-		private void SendData (string data)
-		{
+		private void SendData (string data) {
 			writer.WriteLine (data);
 			writer.Flush ();
 		}
 
 		[MonoTODO]
-		public void SendAsync (MailMessage message, object userToken)
-		{
+		public void SendAsync (MailMessage message, object userToken) {
 			Send (message);
 			OnSendCompleted (new AsyncCompletedEventArgs (null, false, userToken));
 		}
 
-		public void SendAsync (string from, string to, string subject, string body, object userToken)
-		{
+		public void SendAsync (string from, string to, string subject, string body, object userToken) {
 			SendAsync (new MailMessage (from, to, subject, body), userToken);
 		}
 
 		[MonoTODO]
-		public void SendAsyncCancel ()
-		{
+		public void SendAsyncCancel () {
 			throw new NotImplementedException ();
 		}
 
-		private void SendAttachments (AttachmentCollection attachments, string boundary)
-		{
+		private void AddPriorityHeader (MailMessage message) {
+			switch (message.Priority) {
+			case MailPriority.High:
+				SendHeader (HeaderName.Priority, "Urgent");
+				SendHeader (HeaderName.Importance, "high");
+				SendHeader (HeaderName.XPriority, "1");
+				break;
+			case MailPriority.Low:
+				SendHeader (HeaderName.Priority, "Non-Urgent");
+				SendHeader (HeaderName.Importance, "low");
+				SendHeader (HeaderName.XPriority, "5");
+				break;
+			}
+		}
+
+		private void SendSimpleBody (MailMessage message) {
+			SendHeader ("Content-Type", message.BodyContentType.ToString ());
+			SendData (string.Empty);
+
+			SendData (message.Body);
+		}
+
+		private void SendMultipartBody (MailMessage message) {
+			boundaryIndex = 0;
+			string boundary = GenerateBoundary ();
+
+			// Figure out the message content type
+			ContentType messageContentType = message.BodyContentType;
+			messageContentType.Boundary = boundary;
+			messageContentType.MediaType = "multipart/mixed";
+
+			SendHeader ("Content-Type", messageContentType.ToString ());
+			SendData (string.Empty);
+
+			SendData (message.Body);
+			SendData (string.Empty);
+
+			message.AlternateViews.Add (AlternateView.CreateAlternateViewFromString (message.Body, new ContentType ("text/plain")));
+
+			if (message.AlternateViews.Count > 0) {
+				SendAlternateViews (message, boundary);
+			}
+
+			if (message.Attachments.Count > 0) {
+				SendAttachments (message, boundary);
+			}
+
+			EndSection (boundary);
+		}
+
+		private void SendAlternateViews (MailMessage message, string boundary) {
+			AlternateViewCollection alternateViews = message.AlternateViews;
+
+			string inner_boundary = GenerateBoundary ();
+
+			ContentType messageContentType = message.BodyContentType;
+			messageContentType.Boundary = inner_boundary;
+			messageContentType.MediaType = "multipart/alternative";
+
+			StartSection (boundary, messageContentType);
+
+			for (int i = 0; i < alternateViews.Count; i += 1) {
+				ContentType contentType = new ContentType (alternateViews [i].ContentType.ToString ());
+				StartSection (inner_boundary, contentType, alternateViews [i].TransferEncoding);
+
+				switch (alternateViews [i].TransferEncoding) {
+				case TransferEncoding.Base64:
+					byte [] content = new byte [alternateViews [i].ContentStream.Length];
+					alternateViews [i].ContentStream.Read (content, 0, content.Length);
+#if TARGET_JVM
+					SendData (Convert.ToBase64String (content));
+#else
+					    SendData (Convert.ToBase64String (content, Base64FormattingOptions.InsertLineBreaks));
+#endif
+					break;
+				case TransferEncoding.QuotedPrintable:
+					StreamReader sr = new StreamReader (alternateViews [i].ContentStream);
+					SendData (ToQuotedPrintable (sr.ReadToEnd ()));
+					break;
+				//case TransferEncoding.SevenBit:
+				//case TransferEncoding.Unknown:
+				default:
+					SendData ("TO BE IMPLEMENTED");
+					break;
+				}
+
+				SendData (string.Empty);
+			}
+
+			EndSection (inner_boundary);
+		}
+
+		private void SendAttachments (MailMessage message, string boundary) {
+			AttachmentCollection attachments = message.Attachments;
+
 			for (int i = 0; i < attachments.Count; i += 1) {
-				// FIXME: check this
-				ContentType contentType = new ContentType ("multipart/alternative");
-				StartSection (boundary, contentType, attachments [i].TransferEncoding);
+				ContentType contentType = new ContentType (attachments [i].ContentType.ToString ());
+				attachments [i].ContentDisposition.FileName = attachments [i].Name;
+				StartSection (boundary, contentType, attachments [i].TransferEncoding, attachments [i].ContentDisposition);
 
 				switch (attachments [i].TransferEncoding) {
 				case TransferEncoding.Base64:
-					byte[] content = new byte [attachments [i].ContentStream.Length];
+					byte [] content = new byte [attachments [i].ContentStream.Length];
 					attachments [i].ContentStream.Read (content, 0, content.Length);
 #if TARGET_JVM
 					SendData (Convert.ToBase64String (content));
@@ -450,46 +528,51 @@
 					SendData ("TO BE IMPLEMENTED");
 					break;
 				}
+
+				SendData (string.Empty);
 			}
 		}
 
-		private SmtpResponse SendCommand (string command, string data)
-		{
+		private SmtpResponse SendCommand (string command, string data) {
 			writer.Write (command);
 			writer.Write (" ");
 			SendData (data);
 			return Read ();
 		}
 
-		private SmtpResponse SendCommand (string command)
-		{
+		private SmtpResponse SendCommand (string command) {
 			writer.WriteLine (command);
 			writer.Flush ();
 			return Read ();
 		}
 
-		private void SendHeader (string name, string value)
-		{
+		private void SendHeader (string name, string value) {
 			SendData (String.Format ("{0}: {1}", name, value));
 		}
 
-		private void StartSection (string section, ContentType sectionContentType)
-		{
+		private void StartSection (string section, ContentType sectionContentType) {
+			SendData (string.Empty);
 			SendData (String.Format ("--{0}", section));
 			SendHeader ("content-type", sectionContentType.ToString ());
-			SendData ("");
+			SendData (string.Empty);
 		}
 
-		private void StartSection (string section, ContentType sectionContentType,TransferEncoding transferEncoding)
-		{
+		private void StartSection (string section, ContentType sectionContentType, TransferEncoding transferEncoding) {
 			SendData (String.Format ("--{0}", section));
 			SendHeader ("content-type", sectionContentType.ToString ());
 			SendHeader ("content-transfer-encoding", GetTransferEncodingName (transferEncoding));
-			SendData ("");
+			SendData (string.Empty);
 		}
 
-		private string ToQuotedPrintable (string input)
-		{
+		private void StartSection (string section, ContentType sectionContentType, TransferEncoding transferEncoding, ContentDisposition contentDisposition) {
+			SendData (String.Format ("--{0}", section));
+			SendHeader ("content-type", sectionContentType.ToString ());
+			SendHeader ("content-transfer-encoding", GetTransferEncodingName (transferEncoding));
+			SendHeader ("content-disposition", contentDisposition.ToString ());
+			SendData (string.Empty);
+		}
+
+		private string ToQuotedPrintable (string input) {
 			StringReader reader = new StringReader (input);
 			StringWriter writer = new StringWriter ();
 			int i;
@@ -506,8 +589,7 @@
 			return writer.GetStringBuilder ().ToString ();
 		}
 
-		private static string GetTransferEncodingName (TransferEncoding encoding)
-		{
+		private static string GetTransferEncodingName (TransferEncoding encoding) {
 			switch (encoding) {
 			case TransferEncoding.QuotedPrintable:
 				return "quoted-printable";
@@ -519,26 +601,91 @@
 			return "unknown";
 		}
 
-/*
-		[MonoTODO]
-		private sealed ContextAwareResult IGetContextAwareResult.GetContextAwareResult ()
-		{
+		private void InitiateSecureConnection () {
+			SmtpResponse response = SendCommand (Command.StartTls);
+
+			if (IsError (response)) {
+				throw new SmtpException (SmtpStatusCode.GeneralFailure, "Server does not support secure connections.");
+			}
+
+			ChangeToSSLSocket ();
+		}
+
+		private bool ChangeToSSLSocket () {
+#if TARGET_JVM
+			java.lang.Class c = vmw.common.TypeUtils.ToClass (stream);
+			java.lang.reflect.Method m = c.getMethod ("ChangeToSSLSocket", null);
+			m.invoke (stream, new object [] { });
+
+			return true;
+
+#else
 			throw new NotImplementedException ();
+#endif
+		}
+
+		void CheckHostAndPort () {
+			if (String.IsNullOrEmpty (Host))
+				throw new InvalidOperationException ("The SMTP host was not specified");
+
+			if (Port == 0)
+				Port = 25;
 		}
-*/
+		
+		void PerformAuthentication () {
+			if (UseDefaultCredentials) {
+				Authenticate (
+					CredentialCache.DefaultCredentials.GetCredential (new System.Uri ("smtp://" + host), "basic").UserName,
+					CredentialCache.DefaultCredentials.GetCredential (new System.Uri ("smtp://" + host), "basic").Password);
+			}
+			else if (Credentials != null) {
+				Authenticate (
+					Credentials.GetCredential (host, port, "smtp").UserName,
+					Credentials.GetCredential (host, port, "smtp").Password);
+			}
+		}
+
+		void Authenticate (string Username, string Password) {
+			SmtpResponse status = SendCommand (Command.AuthLogin);
+			if (((int) status.StatusCode) != 334) {
+				throw new SmtpException (status.StatusCode, status.Description);
+			}
+
+			status = SendCommand (Convert.ToBase64String (Encoding.ASCII.GetBytes (Username)));
+			if (((int) status.StatusCode) != 334) {
+				throw new SmtpException (status.StatusCode, status.Description);
+			}
+
+			status = SendCommand (Convert.ToBase64String (Encoding.ASCII.GetBytes (Password)));
+			if (IsError (status)) {
+				throw new SmtpException (status.StatusCode, status.Description);
+			}
+		}
+		/*
+				[MonoTODO]
+				private sealed ContextAwareResult IGetContextAwareResult.GetContextAwareResult ()
+				{
+					throw new NotImplementedException ();
+				}
+		*/
 		#endregion // Methods
 
 		// The Command struct is used to store constant string values representing SMTP commands.
-		private struct Command {
+		private struct Command
+		{
 			public const string Data = "DATA";
 			public const string Helo = "HELO";
+			public const string Ehlo = "EHLO";
 			public const string MailFrom = "MAIL FROM:";
 			public const string Quit = "QUIT";
 			public const string RcptTo = "RCPT TO:";
+			public const string StartTls = "STARTTLS";
+			public const string AuthLogin = "AUTH LOGIN";
 		}
 
 		// The HeaderName struct is used to store constant string values representing mail headers.
-		private struct HeaderName {
+		private struct HeaderName
+		{
 			public const string ContentTransferEncoding = "Content-Transfer-Encoding";
 			public const string ContentType = "Content-Type";
 			public const string Bcc = "Bcc";
@@ -548,14 +695,53 @@
 			public const string To = "To";
 			public const string MimeVersion = "MIME-Version";
 			public const string MessageId = "Message-ID";
+			public const string Priority = "Priority";
+			public const string Importance = "Importance";
+			public const string XPriority = "X-Priority";
 		}
 
 		// This object encapsulates the status code and description of an SMTP response.
-		private struct SmtpResponse {
+		private struct SmtpResponse
+		{
 			public SmtpStatusCode StatusCode;
 			public string Description;
+
+			public static SmtpResponse Parse (string line) {
+				SmtpResponse response = new SmtpResponse ();
+
+				if (line.Length < 4)
+					throw new SmtpException ("Response is to short " +
+								   line.Length + ".");
+
+				if ((line [3] != ' ') && (line [3] != '-'))
+					throw new SmtpException ("Response format is wrong.(" +
+								 line + ")");
+
+				// parse the response code
+				response.StatusCode = (SmtpStatusCode) Int32.Parse (line.Substring (0, 3));
+
+				// set the rawsponse
+				response.Description = line;
+
+				return response;
+			}
 		}
-	}
+	}
+
+	class CCredentialsByHost : ICredentialsByHost
+	{
+		public CCredentialsByHost (string userName, string password) {
+			this.userName = userName;
+			this.password = password;
+		}
+
+		public NetworkCredential GetCredential (string host, int port, string authenticationType) {
+			return new NetworkCredential (userName, password);
+		}
+
+		private string userName;
+		private string password;
+	}
 }
 
 #endif // NET_2_0
