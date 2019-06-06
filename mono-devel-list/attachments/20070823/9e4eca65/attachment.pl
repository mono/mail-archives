Index: Makefile
===================================================================
--- Makefile	(revision 84522)
+++ Makefile	(working copy)
@@ -40,6 +40,8 @@
 SECURITY_DEP_FILE := $(wildcard ../lib/$(PROFILE)/$(SECURITY_DEP))
 CONFIGURATION_DEP := System.Configuration.dll
 CONFIGURATION_DEP_FILE := $(wildcard ../lib/$(PROFILE)/$(CONFIGURATION_DEP))
+PREBUILT_DEP := System.dll
+PREBUILT_DEP_FILE := $(wildcard ../lib/$(PROFILE)/$(PREBUILT_DEP))
 CYCLIC_DEPS += $(SECURITY_DEP) $(CONFIGURATION_DEP)
 CYCLIC_DEP_FILES += $(SECURITY_DEP_FILE) $(CONFIGURATION_DEP_FILE)
 LIB_MCS_FLAGS = -nowarn:618 -d:CONFIGURATION_2_0 -unsafe $(RESOURCE_FILES:%=-resource:%)
@@ -95,10 +97,14 @@
 endif
 
 ifdef CONFIGURATION_DEP_FILE
-LIB_MCS_FLAGS += -define:CONFIGURATION_DEP -r:$(CONFIGURATION_DEP) -r:PrebuiltSystem=$(topdir)/class/lib/$(PROFILE)/System.dll
+LIB_MCS_FLAGS += -define:CONFIGURATION_DEP -r:$(CONFIGURATION_DEP)
 $(the_lib): $(CONFIGURATION_DEP_FILE)
 endif
 
+ifdef PREBUILT_DEP_FILE
+LIB_MCS_FLAGS += -r:PrebuiltSystem=$(topdir)/class/lib/$(PROFILE)/System.dll
+endif
+
 $(test_lib): $(test_lib).config $(TEST_RESOURCES)
 
 $(test_lib).config: Test/test-config-file
Index: System.Net.Security/SslStream.cs
===================================================================
--- System.Net.Security/SslStream.cs	(revision 84522)
+++ System.Net.Security/SslStream.cs	(working copy)
@@ -3,9 +3,10 @@
 //
 // Authors:
 //	Tim Coleman (tim@timcoleman.com)
+//	Atsushi Enomoto (atsushi@ximian.com)
 //
 // Copyright (C) Tim Coleman, 2004
-// (c) 2004 Novell, Inc. (http://www.novell.com)
+// (c) 2004,2007 Novell, Inc. (http://www.novell.com)
 //
 
 //
@@ -29,7 +30,8 @@
 // WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 //
 
-#if NET_2_0 
+#if NET_2_0 && SECURITY_DEP
+extern alias PrebuiltSystem;
 
 using System;
 using System.IO;
@@ -37,44 +39,61 @@
 using System.Security.Authentication;
 using System.Security.Cryptography.X509Certificates;
 using System.Security.Principal;
+using System.Security.Cryptography;
+using Mono.Security.Protocol.Tls;
 
+using CipherAlgorithmType = System.Security.Authentication.CipherAlgorithmType;
+using HashAlgorithmType = System.Security.Authentication.HashAlgorithmType;
+using ExchangeAlgorithmType = System.Security.Authentication.ExchangeAlgorithmType;
+
+using MonoCipherAlgorithmType = Mono.Security.Protocol.Tls.CipherAlgorithmType;
+using MonoHashAlgorithmType = Mono.Security.Protocol.Tls.HashAlgorithmType;
+using MonoExchangeAlgorithmType = Mono.Security.Protocol.Tls.ExchangeAlgorithmType;
+using MonoSecurityProtocolType = Mono.Security.Protocol.Tls.SecurityProtocolType;
+
+using X509CertificateCollection = PrebuiltSystem::System.Security.Cryptography.X509Certificates.X509CertificateCollection;
+
 namespace System.Net.Security 
 {
+	[MonoLimitation ("Non-X509Certificate2 certificate is not supported")]
 	public class SslStream : AuthenticatedStream
 	{
 		#region Fields
 
-		int readTimeout;
-		int writeTimeout;
+		int read_timeout;
+		int write_timeout;
+		SslStreamBase ssl_stream;
+		RemoteCertificateValidationCallback validation_callback;
+		LocalCertificateSelectionCallback selection_callback;
 
 		#endregion // Fields
 
 		#region Constructors
 
-		[MonoTODO]
 		public SslStream (Stream innerStream)
-			: base (innerStream, false)
+			: this (innerStream, false)
 		{
 		}
 
-		[MonoTODO]
 		public SslStream (Stream innerStream, bool leaveStreamOpen)
 			: base (innerStream, leaveStreamOpen)
 		{
 		}
-#if SECURITY_DEP
-		[MonoTODO]
+
+		[MonoTODO ("certValidationCallback is not passed X509Chain and SslPolicyErrors correctly")]
 		public SslStream (Stream innerStream, bool leaveStreamOpen, RemoteCertificateValidationCallback certValidationCallback)
-			: base (innerStream, leaveStreamOpen)
+			: this (innerStream, leaveStreamOpen, certValidationCallback, null)
 		{
 		}
 
-		[MonoTODO]
+		[MonoTODO ("certValidationCallback is not passed X509Chain and SslPolicyErrors correctly")]
 		public SslStream (Stream innerStream, bool leaveStreamOpen, RemoteCertificateValidationCallback certValidationCallback, LocalCertificateSelectionCallback certSelectionCallback)
 			: base (innerStream, leaveStreamOpen)
 		{
+			// they are nullable.
+			validation_callback = certValidationCallback;
+			selection_callback = certSelectionCallback;
 		}
-#endif
 		#endregion // Constructors
 
 		#region Properties
@@ -87,231 +106,420 @@
 			get { return InnerStream.CanSeek; }
 		}
 
-		[MonoTODO]
 		public override bool CanTimeout {
-			get { throw new NotImplementedException (); }
+			get { return InnerStream.CanTimeout; }
 		}
 
 		public override bool CanWrite {
 			get { return InnerStream.CanWrite; }
 		}
 
-		[MonoTODO]
-		public virtual bool CheckCertRevocationStatus {
-			get { throw new NotImplementedException (); }
+		public override long Length {
+			get { return InnerStream.Length; }
 		}
 
-		[MonoTODO]
-		public virtual CipherAlgorithmType CipherAlgorithm  {
-			get { throw new NotImplementedException (); }
+		public override long Position {
+			get { return InnerStream.Position; }
+			set {
+				throw new NotSupportedException ("This stream does not support seek operations");
+			}
 		}
 
-		[MonoTODO]
-		public virtual int CipherStrength  {
-			get { throw new NotImplementedException (); }
-		}
+		// AuthenticatedStream overrides
 
-		[MonoTODO]
-		public virtual HashAlgorithmType HashAlgorithm  {
-			get { throw new NotImplementedException (); }
-		}
-
-		[MonoTODO]
-		public virtual int HashStrength  {
-			get { throw new NotImplementedException (); }
-		}
-
-		[MonoTODO]
 		public override bool IsAuthenticated { 
-			get { throw new NotImplementedException (); }
+			get { return ssl_stream != null; }
 		}
 
-		[MonoTODO]
 		public override bool IsEncrypted { 
-			get { throw new NotImplementedException (); }
+			get { return IsAuthenticated; }
 		}
 
-		[MonoTODO]
 		public override bool IsMutuallyAuthenticated { 
-			get { throw new NotImplementedException (); }
+			get { return IsAuthenticated && (IsServer ? RemoteCertificate != null : LocalCertificate != null); }
 		}
 
-		[MonoTODO]
 		public override bool IsServer { 
-			get { throw new NotImplementedException (); }
+			get { return ssl_stream is SslServerStream; }
 		}
 
-		[MonoTODO]
 		public override bool IsSigned { 
-			get { throw new NotImplementedException (); }
+			get { return IsAuthenticated; }
 		}
 
-		[MonoTODO]
-		public virtual ExchangeAlgorithmType KeyExchangeAlgorithm { 
-			get { throw new NotImplementedException (); }
+		[MonoTODO ("The property exists but not supported")]
+		public override int ReadTimeout {
+			get { return read_timeout; }
+			set { read_timeout = value; }
 		}
 
-		[MonoTODO]
-		public virtual int KeyExchangeStrength { 
-			get { throw new NotImplementedException (); }
+		[MonoTODO ("The property exists but not supported")]
+		public override int WriteTimeout {
+			get { return write_timeout; }
+			set { write_timeout = value; }
 		}
 
-		public override long Length {
-			get { return InnerStream.Length; }
+		// SslStream
+
+		public virtual bool CheckCertRevocationStatus {
+			get {
+				if (!IsAuthenticated)
+					return false;
+
+				return ssl_stream.CheckCertRevocationStatus;
+			}
 		}
 
-		[MonoTODO]
-		public virtual X509Certificate LocalCertificate {
-			get { throw new NotImplementedException (); }
+		public virtual CipherAlgorithmType CipherAlgorithm  {
+			get {
+				CheckConnectionAuthenticated ();
+
+				switch (ssl_stream.CipherAlgorithm) {
+				case MonoCipherAlgorithmType.Des:
+					return CipherAlgorithmType.Des;
+				case MonoCipherAlgorithmType.None:
+					return CipherAlgorithmType.None;
+				case MonoCipherAlgorithmType.Rc2:
+					return CipherAlgorithmType.Rc2;
+				case MonoCipherAlgorithmType.Rc4:
+					return CipherAlgorithmType.Rc4;
+				case MonoCipherAlgorithmType.SkipJack:
+					break;
+				case MonoCipherAlgorithmType.TripleDes:
+					return CipherAlgorithmType.TripleDes;
+				case MonoCipherAlgorithmType.Rijndael:
+					switch (ssl_stream.CipherStrength) {
+					case 128:
+						return CipherAlgorithmType.Aes128;
+					case 192:
+						return CipherAlgorithmType.Aes192;
+					case 256:
+						return CipherAlgorithmType.Aes256;
+					}
+					break;
+				}
+
+				throw new InvalidOperationException ("Not supported cipher algorithm is in use. It is likely a bug in SslStream.");
+			}
 		}
 
-		public override long Position {
-			get { return InnerStream.Position; }
-			set { InnerStream.Position = value; }
+		public virtual int CipherStrength  {
+			get {
+				CheckConnectionAuthenticated ();
+
+				return ssl_stream.CipherStrength;
+			}
 		}
 
-		public override int ReadTimeout {
-			get { return readTimeout; }
-			set { readTimeout = value; }
+		public virtual HashAlgorithmType HashAlgorithm  {
+			get {
+				CheckConnectionAuthenticated ();
+
+				switch (ssl_stream.HashAlgorithm) {
+				case MonoHashAlgorithmType.Md5:
+					return HashAlgorithmType.Md5;
+				case MonoHashAlgorithmType.None:
+					return HashAlgorithmType.None;
+				case MonoHashAlgorithmType.Sha1:
+					return HashAlgorithmType.Sha1;
+				}
+
+				throw new InvalidOperationException ("Not supported hash algorithm is in use. It is likely a bug in SslStream.");
+			}
 		}
 
-		[MonoTODO]
+		public virtual int HashStrength  {
+			get {
+				CheckConnectionAuthenticated ();
+
+				return ssl_stream.HashStrength;
+			}
+		}
+
+		public virtual ExchangeAlgorithmType KeyExchangeAlgorithm { 
+			get {
+				CheckConnectionAuthenticated ();
+
+				switch (ssl_stream.KeyExchangeAlgorithm) {
+				case MonoExchangeAlgorithmType.DiffieHellman:
+					return ExchangeAlgorithmType.DiffieHellman;
+				case MonoExchangeAlgorithmType.Fortezza:
+					break;
+				case MonoExchangeAlgorithmType.None:
+					return ExchangeAlgorithmType.None;
+				case MonoExchangeAlgorithmType.RsaKeyX:
+					return ExchangeAlgorithmType.RsaKeyX;
+				case MonoExchangeAlgorithmType.RsaSign:
+					return ExchangeAlgorithmType.RsaSign;
+				}
+
+				throw new InvalidOperationException ("Not supported exchange algorithm is in use. It is likely a bug in SslStream.");
+			}
+		}
+
+		public virtual int KeyExchangeStrength { 
+			get {
+				CheckConnectionAuthenticated ();
+
+				return ssl_stream.KeyExchangeStrength;
+			}
+		}
+
+		public virtual X509Certificate LocalCertificate {
+			get {
+				CheckConnectionAuthenticated ();
+
+				return IsServer ? ssl_stream.ServerCertificate : ((SslClientStream) ssl_stream).SelectedClientCertificate;
+			}
+		}
+
 		public virtual X509Certificate RemoteCertificate {
-			get { throw new NotImplementedException (); }
+			get {
+				CheckConnectionAuthenticated ();
+
+				return !IsServer ? ssl_stream.ServerCertificate : ((SslServerStream) ssl_stream).ClientCertificate;
+			}
 		}
 
-		[MonoTODO]
 		public virtual SslProtocols SslProtocol {
-			get { throw new NotImplementedException (); }
-		}
+			get {
+				CheckConnectionAuthenticated ();
 
-		public override int WriteTimeout {
-			get { return writeTimeout; }
-			set { writeTimeout = value; }
+				switch (ssl_stream.SecurityProtocol) {
+				case MonoSecurityProtocolType.Default:
+					return SslProtocols.Default;
+				case MonoSecurityProtocolType.Ssl2:
+					return SslProtocols.Ssl2;
+				case MonoSecurityProtocolType.Ssl3:
+					return SslProtocols.Ssl3;
+				case MonoSecurityProtocolType.Tls:
+					return SslProtocols.Tls;
+				}
+
+				throw new InvalidOperationException ("Not supported SSL/TLS protocol is in use. It is likely a bug in SslStream.");
+			}
 		}
 
 		#endregion // Properties
 
 		#region Methods
 
-		[MonoTODO]
+		AsymmetricAlgorithm GetPrivateKey (X509Certificate cert, string targetHost)
+		{
+			// FIXME: what can I do for non-X509Certificate2 ?
+			X509Certificate2 cert2 = cert as X509Certificate2;
+			return cert2 != null ? cert2.PrivateKey : null;
+		}
+
+		X509Certificate OnCertificateSelection (X509CertificateCollection clientCerts, X509Certificate serverCert, string targetHost, X509CertificateCollection serverRequestedCerts)
+		{
+			string [] acceptableIssuers = new string [serverRequestedCerts != null ? serverRequestedCerts.Count : 0];
+			for (int i = 0; i < acceptableIssuers.Length; i++)
+				acceptableIssuers [i] = serverRequestedCerts [i].GetIssuerName ();
+			return selection_callback (this, targetHost, clientCerts, serverCert, acceptableIssuers);
+		}
+
 		public virtual IAsyncResult BeginAuthenticateAsClient (string targetHost, AsyncCallback asyncCallback, object asyncState)
 		{
-			throw new NotImplementedException ();
+			return BeginAuthenticateAsClient (targetHost, new X509CertificateCollection (), SslProtocols.Tls, false, asyncCallback, asyncState);
 		}
 
-		[MonoTODO]
 		public virtual IAsyncResult BeginAuthenticateAsClient (string targetHost, X509CertificateCollection clientCertificates, SslProtocols sslProtocolType, bool checkCertificateRevocation, AsyncCallback asyncCallback, object asyncState)
 		{
-			throw new NotImplementedException ();
+			if (IsAuthenticated)
+				throw new InvalidOperationException ("This SslStream is already authenticated");
+
+			SslClientStream s = new SslClientStream (InnerStream,  targetHost, !LeaveInnerStreamOpen, GetMonoSslProtocol (sslProtocolType), clientCertificates);
+			s.CheckCertRevocationStatus = checkCertificateRevocation;
+
+			// Due to the Mono.Security internal, it cannot reuse
+			// the delegated argument, as Mono.Security creates 
+			// another instance of X509Certificate which lacks 
+			// private key but is filled the private key via this
+			// delegate.
+			s.PrivateKeyCertSelectionDelegate = delegate (X509Certificate cert, string host) {
+				string hash = cert.GetCertHashString ();
+				// ... so, we cannot use the delegate argument.
+				foreach (X509Certificate cc in clientCertificates) {
+					if (cc.GetCertHashString () != hash)
+						continue;
+					X509Certificate2 cert2 = cc as X509Certificate2;
+					cert2 = cert2 ?? new X509Certificate2 (cc);
+					return cert2.PrivateKey;
+				}
+				return null;
+			};
+
+			if (validation_callback != null)
+				s.ServerCertValidationDelegate = delegate (X509Certificate cert, int [] certErrors) {
+					// FIXME: X509Chain is not provided
+					// FIXME: SslPolicyErrors is incomplete
+					SslPolicyErrors errors = certErrors.Length > 0 ? SslPolicyErrors.RemoteCertificateChainErrors : SslPolicyErrors.None;
+					return validation_callback (this, cert, null, errors);
+				};
+			if (selection_callback != null)
+				s.ClientCertSelectionDelegate = OnCertificateSelection;
+
+			ssl_stream = s;
+
+			return BeginWrite (new byte [0], 0, 0, asyncCallback, asyncState);
 		}
 
-		[MonoTODO]
 		public override IAsyncResult BeginRead (byte[] buffer, int offset, int count, AsyncCallback asyncCallback, object asyncState)
 		{
-			throw new NotImplementedException ();
+			CheckConnectionAuthenticated ();
+
+			return ssl_stream.BeginRead (buffer, offset, count, asyncCallback, asyncState);
 		}
 
-		[MonoTODO]
 		public virtual IAsyncResult BeginAuthenticateAsServer (X509Certificate serverCertificate, AsyncCallback callback, object asyncState)
 		{
-			throw new NotImplementedException ();
+			return BeginAuthenticateAsServer (serverCertificate, false, SslProtocols.Tls, false, callback, asyncState);
 		}
 
-		[MonoTODO]
 		public virtual IAsyncResult BeginAuthenticateAsServer (X509Certificate serverCertificate, bool clientCertificateRequired, SslProtocols sslProtocolType, bool checkCertificateRevocation, AsyncCallback callback, object asyncState)
 		{
-			throw new NotImplementedException ();
+			if (IsAuthenticated)
+				throw new InvalidOperationException ("This SslStream is already authenticated");
+
+			SslServerStream s = new SslServerStream (InnerStream, serverCertificate, clientCertificateRequired, !LeaveInnerStreamOpen, GetMonoSslProtocol (sslProtocolType));
+			s.CheckCertRevocationStatus = checkCertificateRevocation;
+			// Due to the Mono.Security internal, it cannot reuse
+			// the delegated argument, as Mono.Security creates 
+			// another instance of X509Certificate which lacks 
+			// private key but is filled the private key via this
+			// delegate.
+			s.PrivateKeyCertSelectionDelegate = delegate (X509Certificate cert, string targetHost) {
+				// ... so, we cannot use the delegate argument.
+				X509Certificate2 cert2 = serverCertificate as X509Certificate2 ?? new X509Certificate2 (serverCertificate);
+				return cert2 != null ? cert2.PrivateKey : null;
+			};
+
+			if (validation_callback != null)
+				s.ClientCertValidationDelegate = delegate (X509Certificate cert, int [] certErrors) {
+					// FIXME: X509Chain is not provided
+					// FIXME: SslPolicyErrors is incomplete
+					SslPolicyErrors errors = certErrors.Length > 0 ? SslPolicyErrors.RemoteCertificateChainErrors : SslPolicyErrors.None;
+					return validation_callback (this, cert, null, errors);
+				};
+
+			ssl_stream = s;
+
+			return BeginRead (new byte [0], 0, 0, callback, asyncState);
 		}
 
-		[MonoTODO]
+		MonoSecurityProtocolType GetMonoSslProtocol (SslProtocols ms)
+		{
+			switch (ms) {
+			case SslProtocols.Ssl2:
+				return MonoSecurityProtocolType.Ssl2;
+			case SslProtocols.Ssl3:
+				return MonoSecurityProtocolType.Ssl3;
+			case SslProtocols.Tls:
+				return MonoSecurityProtocolType.Tls;
+			default:
+				return MonoSecurityProtocolType.Default;
+			}
+		}
+
 		public override IAsyncResult BeginWrite (byte[] buffer, int offset, int count, AsyncCallback asyncCallback, object asyncState)
 		{
-			throw new NotImplementedException ();
+			CheckConnectionAuthenticated ();
+
+			return ssl_stream.BeginWrite (buffer, offset, count, asyncCallback, asyncState);
 		}
 
-		[MonoTODO]
 		public virtual void AuthenticateAsClient (string targetHost)
 		{
-			throw new NotImplementedException ();
+			AuthenticateAsClient (targetHost, new X509CertificateCollection (), SslProtocols.Tls, false);
 		}
 
-		[MonoTODO]
 		public virtual void AuthenticateAsClient (string targetHost, X509CertificateCollection clientCertificates, SslProtocols sslProtocolType, bool checkCertificateRevocation)
 		{
-			throw new NotImplementedException ();
+			EndAuthenticateAsClient (BeginAuthenticateAsClient (
+				targetHost, clientCertificates, sslProtocolType, checkCertificateRevocation, null, null));
 		}
 
-		[MonoTODO]
 		public virtual void AuthenticateAsServer (X509Certificate serverCertificate)
 		{
-			throw new NotImplementedException ();
+			AuthenticateAsServer (serverCertificate, false, SslProtocols.Tls, false);
 		}
 
-		[MonoTODO]
 		public virtual void AuthenticateAsServer (X509Certificate serverCertificate, bool clientCertificateRequired, SslProtocols sslProtocolType, bool checkCertificateRevocation)
 		{
-			throw new NotImplementedException ();
+			EndAuthenticateAsServer (BeginAuthenticateAsServer (
+				serverCertificate, clientCertificateRequired, sslProtocolType, checkCertificateRevocation, null, null));
 		}
 
-		[MonoTODO]
 		protected override void Dispose (bool disposing)
 		{
+			if (disposing) {
+				if (ssl_stream != null)
+					ssl_stream.Dispose ();
+				ssl_stream = null;
+			}
 			base.Dispose (disposing);
 		}
 
-		[MonoTODO]
 		public virtual void EndAuthenticateAsClient (IAsyncResult asyncResult)
 		{
-			throw new NotImplementedException ();
+			CheckConnectionAuthenticated ();
+
+			if (CanRead)
+				ssl_stream.EndRead (asyncResult);
+			else
+				ssl_stream.EndWrite (asyncResult);
 		}
 
-		[MonoTODO]
-		public override int EndRead (IAsyncResult asyncResult)
+		public virtual void EndAuthenticateAsServer (IAsyncResult asyncResult)
 		{
-			throw new NotImplementedException ();
+			CheckConnectionAuthenticated ();
+
+			if (CanRead)
+				ssl_stream.EndRead (asyncResult);
+			else
+				ssl_stream.EndWrite (asyncResult);
 		}
 
-		[MonoTODO]
-		public virtual void EndAuthenticateAsServer (IAsyncResult asyncResult)
+		public override int EndRead (IAsyncResult asyncResult)
 		{
-			throw new NotImplementedException ();
+			CheckConnectionAuthenticated ();
+
+			return ssl_stream.EndRead (asyncResult);
 		}
 
-		[MonoTODO]
 		public override void EndWrite (IAsyncResult asyncResult)
 		{
-			throw new NotImplementedException ();
+			CheckConnectionAuthenticated ();
+
+			ssl_stream.EndWrite (asyncResult);
 		}
 
-		[MonoTODO]
 		public override void Flush ()
 		{
+			CheckConnectionAuthenticated ();
+
 			InnerStream.Flush ();
 		}
 
-		[MonoTODO]
 		public override int Read (byte[] buffer, int offset, int count)
 		{
-			throw new NotImplementedException ();
+			return EndRead (BeginRead (buffer, offset, count, null, null));
 		}
 
-		[MonoTODO]
 		public override long Seek (long offset, SeekOrigin origin)
 		{
-			throw new NotImplementedException ();
+			throw new NotSupportedException ("This stream does not support seek operations");
 		}
 
-		[MonoTODO]
 		public override void SetLength (long value)
 		{
-			throw new NotImplementedException ();
+			InnerStream.SetLength (value);
 		}
 
-		[MonoTODO]
 		public override void Write (byte[] buffer, int offset, int count)
 		{
-			throw new NotImplementedException ();
+			EndWrite (BeginWrite (buffer, offset, count, null, null));
 		}
 
 		public void Write (byte[] buffer)
@@ -319,6 +527,12 @@
 			Write (buffer, 0, buffer.Length);
 		}
 
+		void CheckConnectionAuthenticated ()
+		{
+			if (!IsAuthenticated)
+				throw new InvalidOperationException ("This operation is invalid until it is successfully authenticated");
+		}
+
 		#endregion // Methods
 	}
 }
Index: System.Net.Security/LocalCertificateSelectionCallback.cs
===================================================================
--- System.Net.Security/LocalCertificateSelectionCallback.cs	(revision 84522)
+++ System.Net.Security/LocalCertificateSelectionCallback.cs	(working copy)
@@ -29,10 +29,13 @@
 // WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 //
 
-#if NET_2_0 
+#if NET_2_0 && SECURITY_DEP
+extern alias PrebuiltSystem;
 
 using System.Security.Cryptography.X509Certificates;
 
+using X509CertificateCollection = PrebuiltSystem::System.Security.Cryptography.X509Certificates.X509CertificateCollection;
+
 namespace System.Net.Security 
 {
 	public delegate X509Certificate LocalCertificateSelectionCallback (