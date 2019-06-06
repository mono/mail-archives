Index: Novell.Directory.Ldap/Connection.cs
===================================================================
--- Novell.Directory.Ldap/Connection.cs	(revision 47755)
+++ Novell.Directory.Ldap/Connection.cs	(working copy)
@@ -1207,6 +1207,25 @@
 		}
 ///TLS not supported in first release		
 
+		internal Stream InputStream
+		{
+			get { return in_Renamed; }
+		}
+
+		internal Stream OutputStream
+		{
+			get { return out_Renamed; }
+		}
+
+		internal void ReplaceStreams(Stream newIn, Stream newOut)
+		{
+			// wait for reader to stop, see LdapConnection.Bind
+			waitForReader(null);
+			in_Renamed = newIn;
+			out_Renamed = newOut;
+			startReader();
+		}
+
 		public class ReaderThread
 		{
 			private void  InitBlock(Connection enclosingInstance)
Index: Novell.Directory.Ldap/LdapConnection.cs
===================================================================
--- Novell.Directory.Ldap/LdapConnection.cs	(revision 47755)
+++ Novell.Directory.Ldap/LdapConnection.cs	(working copy)
@@ -36,6 +36,15 @@
 using Novell.Directory.Ldap.Utilclass;
 #if !TARGET_JVM
 using Mono.Security.Protocol.Tls;
+#else
+using org.ietf.jgss;
+using javax.security.auth;
+using javax.security.auth.login;
+using java.security;
+
+using Novell.Directory.Ldap.Security;
+using System.Collections.Specialized;
+using System.Configuration;
 #endif
 using System.Security.Cryptography.X509Certificates;
 
@@ -471,6 +480,9 @@
 		private static System.Object nameLock; // protect agentNum
 		private static int lConnNum = 0; // Debug, LdapConnection number
 		private System.String name; // String name for debug
+
+		private const string LDAP_SECURITY_MECH = "System.DirectoryServices.SecurityMech";
+		private const string LDAP_SECURITY_APP_NAME = "System.DirectoryServices.SecurityAppName";
 		
 		/// <summary> Used with search to specify that the scope of entrys to search is to
 		/// search only the base obect.
@@ -1172,10 +1184,24 @@
 		/// </exception>
 		public virtual void  Bind(System.String dn, System.String passwd)
 		{
-			Bind(Ldap_V3, dn, passwd, defSearchCons);
+			Bind(dn, passwd, AuthenticationTypes.None);
 			return ;
 		}
 		
+		public virtual void  Bind(System.String dn, System.String passwd, AuthenticationTypes authenticationTypes)
+		{
+#if TARGET_JVM
+			if (authenticationTypes != AuthenticationTypes.None &&
+				authenticationTypes != AuthenticationTypes.ServerBind &&
+				authenticationTypes != AuthenticationTypes.Anonymous)
+				BindSecure(dn, passwd, authenticationTypes);
+			else
+#endif
+				Bind(Ldap_V3, dn, passwd, defSearchCons);		
+
+			return ;
+		}
+		
 		/// <summary> Synchronously authenticates to the Ldap server (that the object is
 		/// currently connected to) using the specified name, password,
 		/// and Ldap version.
@@ -1388,7 +1414,7 @@
 		[CLSCompliantAttribute(false)]
 		public virtual void  Bind(int version, System.String dn, sbyte[] passwd, LdapConstraints cons)
 		{
-			LdapResponseQueue queue = Bind(version, dn, passwd, null, cons);
+			LdapResponseQueue queue = Bind(version, dn, passwd, null, cons, null);
 			LdapResponse res = (LdapResponse) queue.getResponse();
 			if (res != null)
 			{
@@ -1440,7 +1466,7 @@
 		[CLSCompliantAttribute(false)]
 		public virtual LdapResponseQueue Bind(int version, System.String dn, sbyte[] passwd, LdapResponseQueue queue)
 		{
-			return Bind(version, dn, passwd, queue, defSearchCons);
+			return Bind(version, dn, passwd, queue, defSearchCons, null);
 		}
 		
 		/// <summary> Asynchronously authenticates to the Ldap server (that the object is
@@ -1480,7 +1506,7 @@
 		/// message and an Ldap error code.
 		/// </exception>
 		[CLSCompliantAttribute(false)]
-		public virtual LdapResponseQueue Bind(int version, System.String dn, sbyte[] passwd, LdapResponseQueue queue, LdapConstraints cons)
+		public virtual LdapResponseQueue Bind(int version, System.String dn, sbyte[] passwd, LdapResponseQueue queue, LdapConstraints cons, string mech)
 		{
 			int msgId;
 			BindProperties bindProps;
@@ -1506,7 +1532,13 @@
 				dn = ""; // set to null if anonymous
 			}
 
-			LdapMessage msg = new LdapBindRequest(version, dn, passwd, cons.getControls());
+			LdapMessage msg;
+#if TARGET_JVM
+			if (mech != null)
+				msg = new LdapBindRequest(version, "", mech, passwd, cons.getControls());
+			else
+#endif
+				msg = new LdapBindRequest(version, dn, passwd, cons.getControls());
 			
 			msgId = msg.MessageID;
 			bindProps = new BindProperties(version, dn, "simple", anonymous, null, null);
@@ -1524,11 +1556,88 @@
 				}
 			}
 			
+#if TARGET_JVM
+			// stopping reader to enable stream replace after secure binding is complete, see Connection.ReplaceStreams()
+			if (mech != null)
+				conn.stopReaderOnReply(msgId);
+#endif
 			// The semaphore is released when the bind response is queued.
 			conn.acquireWriteSemaphore(msgId);
 			
 			return SendRequestToServer(msg, cons.TimeLimit, queue, bindProps);
 		}
+
+#if TARGET_JVM
+		private void BindSecure(System.String username, System.String password, AuthenticationTypes authenticationTypes)
+		{
+			if ((authenticationTypes & AuthenticationTypes.Secure) != 0) {			
+				LoginContext loginContext = null;
+				try {					
+					AuthenticationCallbackHandler callbackHandler = new AuthenticationCallbackHandler (username,password);
+					loginContext = new LoginContext (SecurityAppName, callbackHandler);
+					loginContext.login ();
+				}
+				catch (LoginException e) {
+					throw new LdapException ("Failed to create login security context", 80, "", e);
+				}
+
+				Subject subject = loginContext.getSubject ();
+
+				Krb5Helper krb5Helper = new Krb5Helper ("ldap@" + conn.Host, subject, authenticationTypes, SecurityMech);
+				sbyte [] token = krb5Helper.ExchangeTokens (Krb5Helper.EmptyToken);
+
+				LdapResponseQueue queue = Bind(LdapConnection.Ldap_V3, username, token, null, null, "GSS-SPNEGO");
+				LdapResponse res = (LdapResponse) queue.getResponse ();
+				token = ((RfcBindResponse)res.Asn1Object.Response).ServerSaslCreds.byteValue ();
+
+				token = krb5Helper.ExchangeTokens(token == null ? Krb5Helper.EmptyToken : token);
+
+				System.IO.Stream inStream = conn.InputStream;
+				System.IO.Stream newIn = new SecureStream (inStream, krb5Helper);
+				System.IO.Stream outStream = conn.OutputStream;
+				System.IO.Stream newOut = new SecureStream (outStream, krb5Helper);
+				conn.ReplaceStreams (newIn,newOut);
+			}		
+		}
+
+		private string SecurityMech
+		{
+			get {
+				string securityMech = (string) AppDomain.CurrentDomain.GetData (LDAP_SECURITY_MECH);
+
+				if (securityMech == null) {
+					NameValueCollection config = (NameValueCollection) ConfigurationSettings.GetConfig ("System.DirectoryServices/Settings");
+					if (config != null) 
+						securityMech = config ["securitymech"];
+
+					if (securityMech == null) 
+						throw new ArgumentException("Security mechanism id not found in application settings");
+
+					AppDomain.CurrentDomain.SetData (LDAP_SECURITY_MECH,securityMech);
+				}
+				return securityMech;
+			}
+		}
+
+		private string SecurityAppName
+		{
+			get {
+				string securityAppName = (string) AppDomain.CurrentDomain.GetData (LDAP_SECURITY_APP_NAME);
+
+				if (securityAppName == null) {
+					NameValueCollection config = (NameValueCollection) ConfigurationSettings.GetConfig ("System.DirectoryServices/Settings");
+					if (config != null) 
+						securityAppName = config ["securityappname"];
+
+					if (securityAppName == null) 
+						throw new ArgumentException("Application section name not found in application settings");
+
+					AppDomain.CurrentDomain.SetData (LDAP_SECURITY_APP_NAME,securityAppName);
+				}
+				return securityAppName;
+			}
+		}
+#endif
 		
 		//*************************************************************************
 		// compare methods
Index: Novell.Directory.Ldap/AuthenticationTypes.cs
===================================================================
--- Novell.Directory.Ldap/AuthenticationTypes.cs	(revision 0)
+++ Novell.Directory.Ldap/AuthenticationTypes.cs	(revision 0)
@@ -0,0 +1,19 @@
+using System;
+
+namespace Novell.Directory.Ldap
+{
+	public enum AuthenticationTypes
+	{
+		Anonymous = 16,
+		Delegation = 256,
+	    Encryption = 2,
+	    FastBind = 32,
+	    None = 0,
+	    ReadonlyServer = 4,
+	    Sealing = 128,
+	    Secure = 1,
+	    SecureSocketsLayer = 2,
+	    ServerBind = 512,
+	    Signing = 64
+	}
+}
Index: Novell.Directory.Ldap/LdapBindRequest.cs
===================================================================
--- Novell.Directory.Ldap/LdapBindRequest.cs	(revision 47755)
+++ Novell.Directory.Ldap/LdapBindRequest.cs	(working copy)
@@ -88,6 +88,34 @@
 		{
 			return ;
 		}
+
+		/// <summary> Constructs a secure bind request.
+		/// 
+		/// </summary>
+		/// <param name="version"> The Ldap protocol version, use Ldap_V3.
+		/// Ldap_V2 is not supported.
+		/// 
+		/// </param>
+		/// <param name="dn">     If non-null and non-empty, specifies that the
+		/// connection and all operations through it should
+		/// be authenticated with dn as the distinguished
+		/// name.
+		/// 
+		/// </param>
+		/// <param name="mechanism"> Security mechanism code
+		/// 
+		/// </param>
+		/// <param name="passwd"> Security credentials
+		/// 
+		/// </param>
+		/// <param name="cont">Any controls that apply to the simple bind request,
+		/// or null if none.
+		/// </param>
+		[CLSCompliantAttribute(false)]
+		public LdapBindRequest(int version, System.String dn, String mechanism, sbyte[] credentials, LdapControl[] cont):base(LdapMessage.BIND_REQUEST, new RfcBindRequest(version, dn, mechanism, credentials), cont)
+		{
+			return ;
+		}
 		
 		/// <summary> Return an Asn1 representation of this add request.
 		/// 
Index: Novell.Directory.Ldap.Security.jvm/ExchangeTokenPrivilegedAction.cs
===================================================================
--- Novell.Directory.Ldap.Security.jvm/ExchangeTokenPrivilegedAction.cs	(revision 0)
+++ Novell.Directory.Ldap.Security.jvm/ExchangeTokenPrivilegedAction.cs	(revision 0)
@@ -0,0 +1,73 @@
+// 
+// Novell.Directory.Ldap.Security.ExchangeTokenPrivilegedAction.cs
+//
+// Authors:
+//  Boris Kirzner <borsk@mainsoft.com>
+//	Konstantin Triger <kostat@mainsoft.com>
+//	
+// (C) 2005 Mainsoft Corporation (http://www.mainsoft.com)
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
+using System;
+
+using org.ietf.jgss;
+using java.security;
+
+namespace Novell.Directory.Ldap.Security
+{
+	internal class ExchangeTokenPrivilegedAction : PrivilegedAction
+	{
+		#region Fields
+
+		private readonly sbyte [] _token;
+		private readonly GSSContext _context;
+
+		#endregion // Fields
+
+		#region Constructors
+
+		public ExchangeTokenPrivilegedAction(GSSContext context, sbyte [] token)
+		{
+			_token = token;
+			_context = context;
+		}
+
+		#endregion // Constructors
+
+		#region Methods
+
+		public object run()
+		{
+			try {
+				sbyte [] token = _context.initSecContext (_token, 0, _token.Length);
+				return token;
+			}
+			catch (GSSException e) {
+				throw new PrivilegedActionException (e);
+			}
+		}
+
+		#endregion // Methods
+	}
+}
Index: Novell.Directory.Ldap.Security.jvm/CreateContextPrivilegedAction.cs
===================================================================
--- Novell.Directory.Ldap.Security.jvm/CreateContextPrivilegedAction.cs	(revision 0)
+++ Novell.Directory.Ldap.Security.jvm/CreateContextPrivilegedAction.cs	(revision 0)
@@ -0,0 +1,89 @@
+// 
+// Novell.Directory.Ldap.Security.CreateContextPrivilegedAction.cs
+//
+// Authors:
+//  Boris Kirzner <borsk@mainsoft.com>
+//	Konstantin Triger <kostat@mainsoft.com>
+//	
+// (C) 2005 Mainsoft Corporation (http://www.mainsoft.com)
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
+using System;
+
+using java.security;
+using org.ietf.jgss;
+
+namespace Novell.Directory.Ldap.Security
+{
+	internal class CreateContextPrivilegedAction : PrivilegedAction
+	{
+		#region Fields
+
+		private readonly bool _encryption;
+		private readonly bool _signing;
+		private readonly bool _delegation;
+		private readonly string _name;
+		private readonly string _mech;
+
+		#endregion //Fields
+
+		#region Constructors
+
+		public CreateContextPrivilegedAction(string name, string mech, bool encryption, bool signing, bool delegation)
+		{
+			_name = name;
+			_mech = mech;
+			_encryption = encryption;
+			_signing = signing;
+			_delegation = delegation;
+		}
+
+		#endregion // Constructors
+
+		#region Methods
+
+		public object run()
+		{
+			try {				
+				Oid krb5Oid = new Oid (_mech);
+				GSSManager manager = GSSManager.getInstance ();
+				GSSName serverName = manager.createName (_name, GSSName__Finals.NT_HOSTBASED_SERVICE, krb5Oid);
+				GSSContext context = manager.createContext (serverName, krb5Oid, null, GSSContext__Finals.INDEFINITE_LIFETIME);
+
+				//context.requestMutualAuth(true);  
+				context.requestConf (_encryption);
+				if (_signing)
+					context.requestInteg (_signing); 
+				context.requestCredDeleg (_delegation);
+
+				return context;
+			}
+			catch (GSSException e) {
+				throw new PrivilegedActionException (e);
+			}
+		}
+
+		#endregion // Methods
+	}
+}
Index: Novell.Directory.Ldap.Security.jvm/SecureStream.cs
===================================================================
--- Novell.Directory.Ldap.Security.jvm/SecureStream.cs	(revision 0)
+++ Novell.Directory.Ldap.Security.jvm/SecureStream.cs	(revision 0)
@@ -0,0 +1,203 @@
+// 
+// Novell.Directory.Ldap.Security.SecureStream.cs
+//
+// Authors:
+//  Boris Kirzner <borsk@mainsoft.com>
+//	Konstantin Triger <kostat@mainsoft.com>
+//	
+// (C) 2005 Mainsoft Corporation (http://www.mainsoft.com)
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
+using System;
+using System.IO;
+
+namespace Novell.Directory.Ldap.Security
+{
+	internal class SecureStream : Stream
+	{
+		#region Fields
+
+		private readonly Stream _stream;
+		private readonly Krb5Helper _helper;
+
+		private readonly byte [] _lenBuf = new byte [4];  
+		private byte [] _buffer;
+		private int _bufferPosition;
+
+		#endregion // Fields
+
+		#region Constructors
+
+		public SecureStream(Stream stream, Krb5Helper helper): base () 
+		{
+			_stream = stream;
+			_helper = helper;
+		}
+
+		#endregion // Constructors
+
+		#region Properties
+
+		public override bool CanRead 
+		{ 
+			get { return _stream.CanRead; }
+		}
+
+		public override bool CanSeek 
+		{ 
+			get { return _stream.CanSeek; } 
+		}
+
+		public override bool CanWrite 
+		{ 
+			get { return _stream.CanWrite; } 
+		}
+
+		public override long Length 
+		{ 
+			get { throw new NotSupportedException (); } 
+		}
+
+		public override long Position 
+		{ 
+			get { throw new NotSupportedException (); }
+			set { throw new NotSupportedException (); }
+		}
+
+		#endregion // Properties
+
+		#region Methods
+
+		public override void Flush()
+		{
+			_stream.Flush ();
+		}
+
+		public override int Read( byte [] buffer, int offset, int count)
+		{
+			if (_buffer == null || _bufferPosition >= _buffer.Length) {
+				int actual = Fill ();
+				while (actual == 0)
+					actual = Fill ();
+
+				if (actual == -1)
+					return -1;				
+			}
+
+			int available = _buffer.Length - _bufferPosition;
+			if (count > available) {
+				Array.Copy (_buffer, _bufferPosition, buffer, offset, available);
+				_bufferPosition = _buffer.Length;
+				return available;
+			}
+			else {
+				Array.Copy (_buffer, _bufferPosition, buffer, offset, count);
+				_bufferPosition += count;
+				return count;
+			}		
+		}
+
+		private int Fill()
+		{
+			int actual = ReadAll (_lenBuf, 4);
+	
+			if (actual != 4) 
+				return -1;
+
+			int length = NetworkByteOrderToInt (_lenBuf, 0, 4);
+
+//			if (length > _recvMaxBufSize)
+//				throw new LdapException(length + " exceeds the negotiated receive buffer size limit: " + _recvMaxBufSize, 80, "");
+
+			byte [] rawBuffer = new byte [length];
+			actual = ReadAll (rawBuffer, length);
+
+			if (actual != length)
+				throw new LdapException("Expected to read " + length + " bytes, but get " + actual, 80, "");
+
+			_buffer = _helper.Unwrap (rawBuffer, 0, length);
+			_bufferPosition = 0;
+			return _buffer.Length;
+		}
+
+		private int ReadAll(byte [] buffer, int total)
+		{
+			int count = 0;
+			int pos = 0;
+			while (total > 0) {
+				count = _stream.Read (buffer, pos, total);
+
+				if (count == -1)
+					break;
+					//return ((pos == 0) ? -1 : pos);
+
+				pos += count;
+				total -= count;
+			}
+			return pos;
+		}
+
+		public override long Seek(long offset, SeekOrigin loc)
+		{
+			return _stream.Seek (offset, loc);
+		}
+
+		public override void SetLength(long value)
+		{
+			_stream.SetLength (value);
+		}
+
+		public override void Write(byte [] buffer, int offset, int count)
+		{
+			// FIXME: use GSSCOntext.getWrapSizeLimit to divide the buffer
+			// Generate wrapped token 
+			byte [] wrappedToken = _helper.Wrap (buffer, offset, count);
+			// Write out length
+			IntToNetworkByteOrder (wrappedToken.Length, _lenBuf, 0, 4);
+			_stream.Write (_lenBuf, 0, 4);
+			// Write out wrapped token
+			_stream.Write (wrappedToken, 0, wrappedToken.Length);
+		}
+
+		private static int NetworkByteOrderToInt(byte [] buf, int start, int count) 
+		{
+			int answer = 0;
+			for (int i = 0; i < count; i++) {
+				answer <<= 8;
+				answer |= ((int)buf [start + i] & 0xff);
+			}
+			return answer;
+		}
+
+		private static void IntToNetworkByteOrder(int num, byte [] buf, int start, int count) 
+		{
+			for (int i = count-1; i >= 0; i--) {
+				buf [start + i] = (byte)(num & 0xff);
+				num >>= 8;
+			}
+		}
+
+		#endregion // Methods
+	}
+}
Index: Novell.Directory.Ldap.Security.jvm/WrapPrivilegedAction.cs
===================================================================
--- Novell.Directory.Ldap.Security.jvm/WrapPrivilegedAction.cs	(revision 0)
+++ Novell.Directory.Ldap.Security.jvm/WrapPrivilegedAction.cs	(revision 0)
@@ -0,0 +1,80 @@
+// 
+// Novell.Directory.Ldap.Security.WrapPrivilegedAction.cs
+//
+// Authors:
+//  Boris Kirzner <borsk@mainsoft.com>
+//	Konstantin Triger <kostat@mainsoft.com>
+//	
+// (C) 2005 Mainsoft Corporation (http://www.mainsoft.com)
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
+using System;
+using vmw.common;
+
+using java.security;
+using org.ietf.jgss;
+
+namespace Novell.Directory.Ldap.Security
+{
+	internal class WrapPrivilegedAction : PrivilegedAction
+	{
+		#region Fields
+
+		private readonly byte [] _buffer;
+		private readonly int _start;
+		private readonly int _len;
+		private readonly GSSContext _context;
+		private readonly MessageProp _messageProperties;
+
+		#endregion // Fields
+
+		#region Constructors
+
+		public WrapPrivilegedAction(GSSContext context, byte [] buffer, int start, int len, MessageProp messageProperties)
+		{
+			_buffer = buffer;
+			_start = start;
+			_len = len;
+			_context = context;
+			_messageProperties = messageProperties;
+		}
+
+		#endregion // Constructors
+
+		#region Methods
+
+		public object run()
+		{
+			try {
+				sbyte [] result = _context.wrap (TypeUtils.ToSByteArray (_buffer), _start, _len, _messageProperties);
+				return (byte []) TypeUtils.ToByteArray (result);
+			}
+			catch (GSSException e) {
+				throw new PrivilegedActionException (e);
+			}
+		}
+
+		#endregion // Methods
+	}
+}
Index: Novell.Directory.Ldap.Security.jvm/Krb5Helper.cs
===================================================================
--- Novell.Directory.Ldap.Security.jvm/Krb5Helper.cs	(revision 0)
+++ Novell.Directory.Ldap.Security.jvm/Krb5Helper.cs	(revision 0)
@@ -0,0 +1,154 @@
+// 
+// Novell.Directory.Ldap.Security.Krb5Helper.cs
+//
+// Authors:
+//  Boris Kirzner <borsk@mainsoft.com>
+//	Konstantin Triger <kostat@mainsoft.com>
+//	
+// (C) 2005 Mainsoft Corporation (http://www.mainsoft.com)
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
+using System;
+using vmw.common;
+
+using java.security;
+using javax.security.auth;
+using org.ietf.jgss;
+
+
+namespace Novell.Directory.Ldap.Security
+{
+	internal class Krb5Helper
+	{
+		#region Fields
+
+		internal static readonly sbyte [] EmptyToken = new sbyte [0];
+		     
+		private readonly bool _encryption;
+		private readonly bool _signing;
+		private readonly bool _delegation;
+
+		private readonly GSSContext _context;
+		private readonly MessageProp _messageProperties; 
+
+		private readonly string _name;
+		private readonly Subject _subject;
+		private readonly string _mech;
+
+		#endregion // Fields
+
+		#region Constructors
+
+		public Krb5Helper(string name, Subject subject, AuthenticationTypes authenticationTypes, string mech)
+		{
+			_name = name;
+			_subject = subject;
+			_mech = mech;
+
+			_encryption = (authenticationTypes & AuthenticationTypes.Sealing) != 0;
+			_signing = (authenticationTypes & AuthenticationTypes.Signing) != 0;
+			_delegation = (authenticationTypes & AuthenticationTypes.Delegation) != 0;
+
+			CreateContextPrivilegedAction action = new CreateContextPrivilegedAction (_name,_mech,_encryption,_signing,_delegation);
+			_context = (GSSContext) Subject.doAs (_subject,action);
+
+			// 0 is a default JGSS QoP
+			_messageProperties = new MessageProp (0, _encryption);
+		}
+
+		#endregion // Constructors
+
+		#region Properties
+
+		internal GSSContext Context
+		{
+			get { return _context; }
+		}
+
+		#endregion // Properties
+
+		#region Methods
+
+		public sbyte [] ExchangeTokens(sbyte [] clientToken)
+		{
+			if (Context.isEstablished ())
+				return Krb5Helper.EmptyToken;
+
+			sbyte [] token;
+			try {
+				ExchangeTokenPrivilegedAction action = new ExchangeTokenPrivilegedAction (Context, clientToken);
+				token = (sbyte []) Subject.doAs (_subject, action);
+			} 
+			catch (PrivilegedActionException e) {
+				throw new LdapException ("Problem performing token exchange with the server",LdapException.OTHER,"",e); 
+			}
+
+			if (Context.isEstablished ()) {
+				
+				if (Context.getConfState () != _encryption)
+					throw new LdapException ("Encryption protocol was not established layer between client and server", 80, "");
+					
+				if (Context.getCredDelegState () != _delegation) 
+					throw new LdapException ("Credential delegation was not established layer between client and server", 80, "");
+					
+				if (_signing && (Context.getIntegState () != _signing))
+					throw new LdapException ("Signing protocol was not established layer between client and server", 80, "");
+					
+				if (token == null) 
+					return EmptyToken;
+			}
+			return token;
+		}
+
+		public byte [] Wrap(byte [] outgoing, int start, int len)
+		{
+			if (!Context.isEstablished ())
+				throw new LdapException ("GSSAPI authentication not completed",LdapException.OTHER,"");
+
+			try {
+				WrapPrivilegedAction action = new WrapPrivilegedAction (Context, outgoing, start, len, _messageProperties);
+				return (byte []) Subject.doAs (_subject, action);				
+			} 
+			catch (PrivilegedActionException e) {
+				throw new LdapException ("Problem performing GSS wrap",LdapException.OTHER,"",e); 
+			}
+		}
+
+		public byte [] Unwrap(byte [] incoming, int start, int len)
+		{
+			if (!Context.isEstablished ())
+				throw new LdapException ("GSSAPI authentication not completed",LdapException.OTHER,"");
+
+			try {
+				UnwrapPrivilegedAction action = new UnwrapPrivilegedAction (Context, incoming, start, len, _messageProperties);
+				return (byte []) Subject.doAs (_subject, action);
+			} 
+			catch (PrivilegedActionException e) {
+				throw new LdapException("Problems unwrapping SASL buffer",LdapException.OTHER,"",e);
+			}
+		}
+
+		#endregion // Methods
+	}
+}
Index: Novell.Directory.Ldap.Security.jvm/ChangeLog
===================================================================
--- Novell.Directory.Ldap.Security.jvm/ChangeLog	(revision 0)
+++ Novell.Directory.Ldap.Security.jvm/ChangeLog	(revision 0)
@@ -0,0 +1,9 @@
+2005-28-07  Boris Kirzner <borisk@mainsoft.com>
+	* Novell.Directory.Ldap.Security.jvm/ExchangeTokenPrivilegedAction.cs,
+	Novell.Directory.Ldap.Security.jvm/CreateContextPrivilegedAction.cs,
+	Novell.Directory.Ldap.Security.jvm/SecureStream.cs,
+	Novell.Directory.Ldap.Security.jvm/WrapPrivilegedAction.cs,
+	Novell.Directory.Ldap.Security.jvm/Krb5Helper.cs,
+	Novell.Directory.Ldap.Security.jvm/UnwrapPrivilegedAction.cs,
+	Novell.Directory.Ldap.Security.jvm/AuthenticationCallbackHandler.cs: added
+	new classes implementing kerberos authntication support.
\ No newline at end of file
Index: Novell.Directory.Ldap.Security.jvm/UnwrapPrivilegedAction.cs
===================================================================
--- Novell.Directory.Ldap.Security.jvm/UnwrapPrivilegedAction.cs	(revision 0)
+++ Novell.Directory.Ldap.Security.jvm/UnwrapPrivilegedAction.cs	(revision 0)
@@ -0,0 +1,80 @@
+// 
+// Novell.Directory.Ldap.Security.UnwrapPrivilegedAction.cs
+//
+// Authors:
+//  Boris Kirzner <borsk@mainsoft.com>
+//	Konstantin Triger <kostat@mainsoft.com>
+//	
+// (C) 2005 Mainsoft Corporation (http://www.mainsoft.com)
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
+using System;
+using vmw.common;
+
+using java.security;
+using org.ietf.jgss;
+
+namespace Novell.Directory.Ldap.Security
+{
+	internal class UnwrapPrivilegedAction : PrivilegedAction
+	{
+		#region Fields
+
+		private readonly byte [] _buffer;
+		private readonly int _start;
+		private readonly int _len;
+		private readonly GSSContext _context;
+		private readonly MessageProp _messageProperties;
+
+		#endregion // Fields
+
+		#region Constructors
+
+		public UnwrapPrivilegedAction(GSSContext context, byte [] buffer, int start, int len, MessageProp messageProperties)
+		{
+			_buffer = buffer;
+			_start = start;
+			_len = len;
+			_context = context;
+			_messageProperties = messageProperties;
+		}
+
+		#endregion // Constructors
+
+		#region Methods
+
+		public object run()
+		{
+			try {				
+				sbyte [] result = _context.unwrap (TypeUtils.ToSByteArray (_buffer), _start, _len, _messageProperties);
+				return (byte []) TypeUtils.ToByteArray (result);
+			}
+			catch (GSSException e) {
+				throw new PrivilegedActionException (e);
+			}
+		}
+
+		#endregion // Methods
+	}
+}
Index: Novell.Directory.Ldap.Security.jvm/AuthenticationCallbackHandler.cs
===================================================================
--- Novell.Directory.Ldap.Security.jvm/AuthenticationCallbackHandler.cs	(revision 0)
+++ Novell.Directory.Ldap.Security.jvm/AuthenticationCallbackHandler.cs	(revision 0)
@@ -0,0 +1,80 @@
+// 
+// Novell.Directory.Ldap.Security.AuthenticationCallbackHandler.cs
+//
+// Authors:
+//  Boris Kirzner <borsk@mainsoft.com>
+//	Konstantin Triger <kostat@mainsoft.com>
+//	
+// (C) 2005 Mainsoft Corporation (http://www.mainsoft.com)
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
+using System;
+
+using javax.security.auth.callback;
+using java.io;
+
+namespace Novell.Directory.Ldap.Security
+{
+	internal class AuthenticationCallbackHandler : CallbackHandler
+	{
+
+		#region Fields
+
+		private readonly string _username;
+		private readonly string _password;
+
+		#endregion //Fields
+
+		#region Constructors
+
+		public AuthenticationCallbackHandler(string username, string password)
+		{
+			_username = username;
+			_password = password;
+		}
+
+		#endregion // Constructors
+
+		#region Methods
+
+		public void handle(Callback [] callbacks)
+		{
+			for (int i = 0; i < callbacks.Length; i++) {
+				if (callbacks [i] is NameCallback) {
+					NameCallback nc = (NameCallback) callbacks [i];
+					nc.setName (_username);
+				}
+				else if (callbacks [i] is PasswordCallback) {
+					PasswordCallback pc = (PasswordCallback) callbacks [i];
+					pc.setPassword (_password.ToCharArray ());
+				}
+				else {
+					throw new UnsupportedCallbackException (callbacks [i], "Unrecognized Callback");
+				}
+			}
+		}
+
+		#endregion // Methods
+	}
+}
Index: ChangeLog
===================================================================
--- ChangeLog	(revision 47755)
+++ ChangeLog	(working copy)
@@ -1,3 +1,23 @@
+2005-28-07  Boris Kirzner <borisk@mainsoft.com>
+	* Novell.Directory.Ldap.Security.jvm: added new directory containing 
+	TARGET_JVM specific classes for kerberos authentication.
+	* Novell.Directory.Ldap/AuthenticationTypes.cs: added new enum, 
+	corresponding to System.DirectoryServices.AuthenticationTypes. Used in
+	LdapConnection.Bind methods.
+	* Novell.Directory.Ldap.dll.sources: updated sources files.
+	* Novell.Directory.Ldap/LdapBindRequest.cs: added new constructor with 
+	credentials parameter passed as sbyte.
+	* Novell.Directory.Ldap/Connection.cs: added properties for accessing 
+	private input and output streams. Added method for streams replacing.
+	* Novell.Directory.Ldap/LdapConnection.cs: 
+		- changed Bind api to receive AuthenticationTypes as parameter.
+		- added TARGET_JVM-specific BindSecure method.
+		- added TARGET_JVM-specific support for creating bind requests
+		with security credentials.
+		- added TARGET_JVM-specific properties for security mechanism
+		and application section name in configuration.
+	* Novell.Directory.Ldap.vmwcsproj: updated TARGET_JVM project file.
+
 2005-27-07  Boris Kirzner <borisk@mainsoft.com>
 	* Novell.Directory.Ldap.Asn1/Asn1Enumerated.cs,
 	Novell.Directory.Ldap.Asn1/Asn1Choice.cs,
Index: Novell.Directory.Ldap.vmwcsproj
===================================================================
--- Novell.Directory.Ldap.vmwcsproj	(revision 47755)
+++ Novell.Directory.Ldap.vmwcsproj	(working copy)
@@ -8,14 +8,14 @@
 			</Settings>
 			<References>
 				<Reference Name="System" AssemblyName="System" HintPath="..\..\WINDOWS\Microsoft.NET\Framework\v1.1.4322\System.dll"/>
-				<Reference Name="System.Data" AssemblyName="System.Data" HintPath="..\..\WINDOWS\Microsoft.NET\Framework\v1.1.4322\System.Data.dll"/>
-				<Reference Name="System.Xml" AssemblyName="System.Xml" HintPath="..\..\WINDOWS\Microsoft.NET\Framework\v1.1.4322\System.Xml.dll"/>
+				<Reference Name="rt" AssemblyName="rt" HintPath="..\..\..\..\..\Program Files\Mainsoft\Visual MainWin for J2EE\jgac\j2sdk1.4\rt.dll" Private="False"/>
+				<Reference Name="J2SE.Helpers" AssemblyName="J2SE.Helpers" HintPath="..\..\..\..\..\Program Files\Mainsoft\Visual MainWin for J2EE\jgac\vmw4j2ee_110\J2SE.Helpers.dll" Private="False"/>
 			</References>
 		</Build>
 		<Files>
 			<Include>
-				<File RelPath="Novell.Directory.Ldap\.cvsignore" BuildAction="None"/>
 				<File RelPath="Novell.Directory.Ldap\AssemblyInfo.cs" SubType="Code" BuildAction="Compile"/>
+				<File RelPath="Novell.Directory.Ldap\AuthenticationTypes.cs" SubType="Code" BuildAction="Compile"/>
 				<File RelPath="Novell.Directory.Ldap\Connection.cs" SubType="Code" BuildAction="Compile"/>
 				<File RelPath="Novell.Directory.Ldap\InterThreadException.cs" SubType="Code" BuildAction="Compile"/>
 				<File RelPath="Novell.Directory.Ldap\LdapAbandonRequest.cs" SubType="Code" BuildAction="Compile"/>
@@ -207,6 +207,13 @@
 				<File RelPath="Novell.Directory.Ldap.Rfc2251\RfcSearchResultReference.cs" SubType="Code" BuildAction="Compile"/>
 				<File RelPath="Novell.Directory.Ldap.Rfc2251\RfcSubstringFilter.cs" SubType="Code" BuildAction="Compile"/>
 				<File RelPath="Novell.Directory.Ldap.Rfc2251\RfcUnbindRequest.cs" SubType="Code" BuildAction="Compile"/>
+				<File RelPath="Novell.Directory.Ldap.Security.jvm\AuthenticationCallbackHandler.cs" SubType="Code" BuildAction="Compile"/>
+				<File RelPath="Novell.Directory.Ldap.Security.jvm\CreateContextPrivilegedAction.cs" SubType="Code" BuildAction="Compile"/>
+				<File RelPath="Novell.Directory.Ldap.Security.jvm\ExchangeTokenPrivilegedAction.cs" SubType="Code" BuildAction="Compile"/>
+				<File RelPath="Novell.Directory.Ldap.Security.jvm\Krb5Helper.cs" SubType="Code" BuildAction="Compile"/>
+				<File RelPath="Novell.Directory.Ldap.Security.jvm\SecureStream.cs" SubType="Code" BuildAction="Compile"/>
+				<File RelPath="Novell.Directory.Ldap.Security.jvm\UnwrapPrivilegedAction.cs" SubType="Code" BuildAction="Compile"/>
+				<File RelPath="Novell.Directory.Ldap.Security.jvm\WrapPrivilegedAction.cs" SubType="Code" BuildAction="Compile"/>
 				<File RelPath="Novell.Directory.Ldap.Utilclass\ArrayEnumeration.cs" SubType="Code" BuildAction="Compile"/>
 				<File RelPath="Novell.Directory.Ldap.Utilclass\AttributeQualifier.cs" SubType="Code" BuildAction="Compile"/>
 				<File RelPath="Novell.Directory.Ldap.Utilclass\Base64.cs" SubType="Code" BuildAction="Compile"/>
@@ -228,6 +235,6 @@
 				<File RelPath="Novell.Directory.Ldap.Utilclass\TokenTypes.cs" SubType="Code" BuildAction="Compile"/>
 			</Include>
 		</Files>
-		<UserProperties project.JDKType="1.4.2_05" REFS.JarPath.system.xml="..\..\Program Files\Mainsoft\Visual MainWin for J2EE\jgac\vmw4j2ee_110\System.Xml.jar" REFS.JarPath.system.data="..\..\Program Files\Mainsoft\Visual MainWin for J2EE\jgac\vmw4j2ee_110\System.Data.jar" REFS.JarPath.system="..\..\Program Files\Mainsoft\Visual MainWin for J2EE\jgac\vmw4j2ee_110\System.jar"/>
+		<UserProperties REFS.JarPath.j2se.helpers="..\..\..\..\..\Program Files\Mainsoft\Visual MainWin for J2EE\jgac\vmw4j2ee_110\J2SE.Helpers.jar" REFS.JarPath.rt="..\..\..\..\..\Program Files\Mainsoft\Visual MainWin for J2EE\j2sdk1.4\lib\rt.jar" jarserver="ipa" REFS.JarPath.system="..\..\Program Files\Mainsoft\Visual MainWin for J2EE\jgac\vmw4j2ee_110\System.jar" project.JDKType="1.4.2_05"/>
 	</CSHARP>
-	<VisualMainWin><Project Prop2023="1.4.2_05" Prop2024="" Prop2026="" Prop2015="" Version="1.6.0" ProjectType="1"/><References/><Configs><Config Prop2000="0" Prop2001="0" Prop2002="0" Prop2003="0" Prop2004="0" Prop2005="0" Prop2006="" Prop2007="" Prop2008="" Prop2009="" Prop2010="" Prop2011="0" Prop2012="0" Prop2013="" Prop2014="0" Prop2016="" Prop2027="" Prop2019="0" Prop2020="285212672" Prop2021="4096" Prop2022="0" Prop2017="0" Prop2018="0" Name="Release_Java"/><Config Prop2000="1" Prop2001="0" Prop2002="0" Prop2003="0" Prop2004="0" Prop2005="0" Prop2006="" Prop2007="" Prop2008="" Prop2009="" Prop2010="" Prop2011="0" Prop2012="0" Prop2013="" Prop2014="0" Prop2016="" Prop2027="" Prop2019="0" Prop2020="285212672" Prop2021="4096" Prop2022="0" Prop2017="0" Prop2018="-1" Name="Debug"/><Config Prop2000="0" Prop2001="0" Prop2002="0" Prop2003="0" Prop2004="0" Prop2005="0" Prop2006="" Prop2007="" Prop2008="" Prop2009="" Prop2010="" Prop2011="0" Prop2012="0" Prop2013="" Prop2014="0" Prop2016="" Prop2027="" Prop2019="0" Prop2020="285212672" Prop2021="4096" Prop2022="0" Prop2017="0" Prop2018="-1" Name="Debug_Java"/></Configs></VisualMainWin></VisualStudioProject>
+	<VisualMainWin><Project Prop2023="1.4.2_05" Prop2024="" Prop2026="" Prop2015="" Version="1.6.0" ProjectType="1"/><References/><Configs><Config Prop2000="1" Prop2001="0" Prop2002="0" Prop2003="0" Prop2004="0" Prop2005="0" Prop2006="" Prop2007="" Prop2008="" Prop2009="" Prop2010="" Prop2011="0" Prop2012="0" Prop2013="" Prop2014="0" Prop2016="" Prop2027="" Prop2019="0" Prop2020="285212672" Prop2021="4096" Prop2022="0" Prop2017="0" Prop2018="-1" Name="Debug"/><Config Prop2000="0" Prop2001="0" Prop2002="0" Prop2003="0" Prop2004="0" Prop2005="0" Prop2006="" Prop2007="" Prop2008="" Prop2009="" Prop2010="" Prop2011="0" Prop2012="0" Prop2013="" Prop2014="0" Prop2016="" Prop2027="" Prop2019="0" Prop2020="285212672" Prop2021="4096" Prop2022="0" Prop2017="0" Prop2018="0" Name="Release_Java"/><Config Prop2000="0" Prop2001="0" Prop2002="0" Prop2003="0" Prop2004="0" Prop2005="0" Prop2006="" Prop2007="" Prop2008="" Prop2009="" Prop2010="" Prop2011="0" Prop2012="0" Prop2013="" Prop2014="0" Prop2016="" Prop2027="" Prop2019="0" Prop2020="285212672" Prop2021="4096" Prop2022="0" Prop2017="0" Prop2018="-1" Name="Debug_Java"/></Configs></VisualMainWin></VisualStudioProject>
Index: Novell.Directory.Ldap.dll.sources
===================================================================
--- Novell.Directory.Ldap.dll.sources	(revision 47755)
+++ Novell.Directory.Ldap.dll.sources	(working copy)
@@ -86,6 +86,7 @@
 Novell.Directory.Ldap.Rfc2251/RfcExtendedRequest.cs
 Novell.Directory.Ldap.Rfc2251/RfcExtendedResponse.cs
 Novell.Directory.Ldap.Rfc2251/RfcIntermediateResponse.cs
+Novell.Directory.Ldap/AuthenticationTypes.cs
 Novell.Directory.Ldap/LdapConnection.cs
 Novell.Directory.Ldap/LdapAuthHandler.cs
 Novell.Directory.Ldap/LdapBindHandler.cs
