diff -bduprN -x .svn -x CVS ./Novell.Directory.Ldap/ChangeLog ./Modified/Novell.Directory.Ldap/ChangeLog
--- ./Novell.Directory.Ldap/ChangeLog	2005-09-23 09:48:23.293274861 +0530
+++ ./Modified/Novell.Directory.Ldap/ChangeLog	2005-09-23 10:01:49.350186065 +0530
@@ -1,3 +1,21 @@
+2005-09-23 Palaniappan N <npalaniappan@novell.com>
+	* The folder is made in synch with the Novell Forge's C# LDAP SDK with the following updates:
+		- Changes in Connection.cs regarding appropriate handling
+	          in method ServerCertificateValidation.
+		- Added support for error code 113 SSL_HANDSHAKE_FAILED.
+		- Added two files ResultCodeMessages.txt and ExceptionMessages.txt in              
+                  Novell.Directory.Ldap.Utilclass
+		- Added support for subordinate subtree scope.
+		- Removed hard coded dependency on Mono Security
+		- Fix for a race condition in Connection.cs
+		- Updated with support for Interactiveness of SSL Handshake, 
+		  Ldap Events, Edir Events, Intermediate Response
+		- Connection.cs class is modified by synchronizing the stream 
+                  threads so as to avoid the memory consumption and handle consumption.
+		- Changed version from 2.1.1 to 2.1.4 in Connection.cs.
+		- Updated ChangeLog so that latest changes are on the top.
+
+
 2005-15-09  Boris Kirzner <borisk@mainsoft.com>
 	* Novell.Directory.Ldap.vmwcsproj: added reference to Consts.cs.in
 
diff -bduprN -x .svn -x CVS ./Novell.Directory.Ldap/Novell.Directory.Ldap/Connection.cs ./Modified/Novell.Directory.Ldap/Novell.Directory.Ldap/Connection.cs
--- ./Novell.Directory.Ldap/Novell.Directory.Ldap/Connection.cs	2005-09-23 09:48:10.574939380 +0530
+++ ./Modified/Novell.Directory.Ldap/Novell.Directory.Ldap/Connection.cs	2005-09-22 14:12:20.000000000 +0530
@@ -50,9 +50,13 @@ using Mono.Security.X509;
 #endif
 using System.Text.RegularExpressions;
 using System.Globalization;
+using System.Reflection;
 
 namespace Novell.Directory.Ldap
 {
+	public delegate bool CertificateValidationCallback(
+		Syscert.X509Certificate certificate,
+		int[] certificateErrors);
 	
 	/// <summary> The class that creates a connection to the Ldap server. After the
 	/// connection is made, a thread is created that reads data from the
@@ -78,6 +82,38 @@ namespace Novell.Directory.Ldap
 	/*package*/
 	sealed class Connection
 	{
+		public event CertificateValidationCallback OnCertificateValidation;
+		public  enum    CertificateProblem  : long
+		{
+			CertEXPIRED                   = 0x800B0101,
+			CertVALIDITYPERIODNESTING     = 0x800B0102,
+			CertROLE                      = 0x800B0103,
+			CertPATHLENCONST              = 0x800B0104,
+			CertCRITICAL                  = 0x800B0105,
+			CertPURPOSE                   = 0x800B0106,
+			CertISSUERCHAINING            = 0x800B0107,
+			CertMALFORMED                 = 0x800B0108,
+			CertUNTRUSTEDROOT             = 0x800B0109,
+			CertCHAINING                  = 0x800B010A,
+			CertREVOKED                   = 0x800B010C,
+			CertUNTRUSTEDTESTROOT         = 0x800B010D,
+			CertREVOCATION_FAILURE        = 0x800B010E,
+			CertCN_NO_MATCH               = 0x800B010F,
+			CertWRONG_USAGE               = 0x800B0110,
+			CertUNTRUSTEDCA               = 0x800B0112
+		}
+		private static String GetProblemMessage(CertificateProblem Problem)
+		{
+			String ProblemMessage = "";
+			String ProblemCodeName = CertificateProblem.GetName(typeof(CertificateProblem), Problem);
+			if(ProblemCodeName != null)
+				ProblemMessage = ProblemMessage + ProblemCodeName;
+			else
+				ProblemMessage = "Unknown Certificate Problem";
+			return ProblemMessage;
+		}
+ 
+		private ArrayList handshakeProblemsEncountered = new ArrayList();
 		private void  InitBlock()
 		{
 			writeSemaphore = new System.Object();
@@ -292,8 +328,8 @@ namespace Novell.Directory.Ldap
 		private BindProperties bindProperties = null;
 		private int bindSemaphoreId = 0; // 0 is never used by to lock a semaphore
 		
-		private SupportClass.ThreadClass reader = null; // New thread that reads data from the server.
-		private SupportClass.ThreadClass deadReader = null; // Identity of last reader thread
+		private Thread reader = null; // New thread that reads data from the server.
+		private Thread deadReader = null; // Identity of last reader thread
 		private System.IO.IOException deadReaderException = null; // Last exception of reader
 		
 		private LBEREncoder encoder;
@@ -515,14 +551,14 @@ namespace Novell.Directory.Ldap
 		*
 		* @param the thread id to match
 		*/
-		private void  waitForReader(SupportClass.ThreadClass thread)
+		private void  waitForReader(Thread thread)
 		{
 			// wait for previous reader thread to terminate
 			System.Threading.Thread rInst;
 			System.Threading.Thread tInst;
 			if(reader!=null)
 			{
-				rInst=reader.Instance;
+				rInst=reader;
 			}
 			else
 			{
@@ -531,7 +567,7 @@ namespace Novell.Directory.Ldap
 
 			if(thread!=null)
 			{
-				tInst=thread.Instance;
+				tInst=thread;
 			}
 			else
 			{
@@ -572,7 +608,7 @@ namespace Novell.Directory.Ldap
 				}
 				if(reader!=null)
 				{
-					rInst=reader.Instance;
+					rInst=reader;
 				}
 				else
 				{
@@ -581,7 +617,7 @@ namespace Novell.Directory.Ldap
 
 				if(thread!=null)
 				{
-					tInst=thread.Instance;
+					tInst=thread;
 				}
 				else
 				{
@@ -615,7 +651,18 @@ namespace Novell.Directory.Ldap
                         Syscert.X509Certificate certificate,
                         int[]                   certificateErrors)
                 {
+			if (null != OnCertificateValidation)
+			{
+				return OnCertificateValidation(certificate, certificateErrors);
+			}
 			
+			return DefaultCertificateValidationHandler(certificate, certificateErrors);
+		}
+	
+		public bool DefaultCertificateValidationHandler(
+			Syscert.X509Certificate certificate,
+			int[]                   certificateErrors)
+		{
 			bool retFlag=false;
 
                         if (certificateErrors != null &&
@@ -631,6 +678,7 @@ namespace Novell.Directory.Ldap
                                                                                                 
        		                         for (int i = 0; i < certificateErrors.Length; i++)
                		                 {
+						handshakeProblemsEncountered.Add((CertificateProblem)((uint)certificateErrors[i]));
                        		                 Console.WriteLine(certificateErrors[i]);
                                 	 }
 					retFlag = false;
@@ -696,17 +744,55 @@ namespace Novell.Directory.Ldap
 						IPEndPoint ephost = new IPEndPoint(hostadd,port);
 						sock.Connect(ephost);
 						NetworkStream nstream = new NetworkStream(sock,true);
+						// Load Mono.Security.dll
+						Assembly a;
+						try
+						{
+							a = Assembly.LoadFrom("Mono.Security.dll");
+						}
+						catch(System.IO.FileNotFoundException)
+						{
+							throw new LdapException(ExceptionMessages.SSL_PROVIDER_MISSING, LdapException.SSL_PROVIDER_NOT_FOUND, null);
+						}
+						Type tSslClientStream = a.GetType("Mono.Security.Protocol.Tls.SslClientStream");
+						BindingFlags flags = (BindingFlags.NonPublic  | BindingFlags.Public |
+							BindingFlags.Static | BindingFlags.Instance | BindingFlags.DeclaredOnly);
+
+						object[] consArgs = new object[4];
+						consArgs[0] = nstream;
+						consArgs[1] = host;
+						consArgs[2] = false;
+						Type tSecurityProtocolType = a.GetType("Mono.Security.Protocol.Tls.SecurityProtocolType");
+						Enum objSPType = (Enum)(Activator.CreateInstance(tSecurityProtocolType));
+						int nSsl3Val = (int) Enum.Parse(tSecurityProtocolType, "Ssl3");
+						int nTlsVal = (int) Enum.Parse(tSecurityProtocolType, "Tls");
+						consArgs[3] = Enum.ToObject(tSecurityProtocolType, nSsl3Val | nTlsVal);
+
+						object objSslClientStream = 
+							Activator.CreateInstance(tSslClientStream, consArgs);
+
+						// Register ServerCertValidationDelegate handler
+						PropertyInfo pi = tSslClientStream.GetProperty("ServerCertValidationDelegate");
+						pi.SetValue(objSslClientStream, 
+							Delegate.CreateDelegate(pi.PropertyType, this, "ServerCertificateValidation"),
+							null);
+						
+						// Get the in and out streams
+						in_Renamed = (System.IO.Stream) objSslClientStream;
+						out_Renamed = (System.IO.Stream) objSslClientStream;
+						/*
 						SslClientStream sslstream = new SslClientStream(
 											nstream,
 											host,
 											false,
 											Mono.Security.Protocol.Tls.SecurityProtocolType.Ssl3|Mono.Security.Protocol.Tls.SecurityProtocolType.Tls);
-						sslstream.ServerCertValidationDelegate += new CertificateValidationCallback(ServerCertificateValidation);
-//						byte[] buffer = new byte[0];
-//						sslstream.Read(buffer, 0, buffer.Length);
-//						sslstream.doHandshake();												
+						sslstream.ServerCertValidationDelegate += new CertificateValidationCallback(ServerCertificateValidation);*/
+						//						byte[] buffer = new byte[0];
+						//						sslstream.Read(buffer, 0, buffer.Length);
+						//						sslstream.doHandshake();												
+						/*
  						in_Renamed = (System.IO.Stream) sslstream;
-						out_Renamed = (System.IO.Stream) sslstream;
+						out_Renamed = (System.IO.Stream) sslstream;*/
 					}
 					else{
 #endif
@@ -892,13 +978,34 @@ namespace Novell.Directory.Ldap
 				{
 					throw new System.IO.IOException("Output stream not initialized");
 				}
+				if (!(myOut.CanWrite))
+				{
+					return;
+				}
 				sbyte[] ber = msg.Asn1Object.getEncoding(encoder);
 				myOut.Write(SupportClass.ToByteArray(ber), 0, ber.Length);
 				myOut.Flush();
 			}
 			catch (System.IO.IOException ioe)
 			{
-				
+				if ((msg.Type == LdapMessage.BIND_REQUEST) &&
+					(ssl))
+				{
+					string strMsg = "Following problem(s) occurred while establishing SSL based Connection : ";
+					if (handshakeProblemsEncountered.Count > 0)
+					{
+						strMsg += GetProblemMessage((CertificateProblem)handshakeProblemsEncountered[0]); 
+						for (int nProbIndex = 1; nProbIndex < handshakeProblemsEncountered.Count; nProbIndex++)
+						{
+							strMsg += ", " + GetProblemMessage((CertificateProblem)handshakeProblemsEncountered[nProbIndex]);
+						} 
+					}
+					else
+					{
+						strMsg += "Unknown Certificate Problem";
+					}
+					throw new LdapException(strMsg, new System.Object[]{host, port}, LdapException.SSL_HANDSHAKE_FAILED, null, ioe);
+				}				
 				/*
 				* IOException could be due to a server shutdown notification which
 				* caused our Connection to quit.  If so we send back a slightly
@@ -924,6 +1031,7 @@ namespace Novell.Directory.Ldap
 			finally
 			{
 				freeWriteSemaphore(id);
+				handshakeProblemsEncountered.Clear();
 			}
 			return ;
 		}
@@ -988,7 +1096,7 @@ namespace Novell.Directory.Ldap
 			
 			int semId = acquireWriteSemaphore(semaphoreId);
 			// Now send unbind if socket not closed
-			if ((bindProperties != null) && (out_Renamed != null) && (!bindProperties.Anonymous))
+			if ((bindProperties != null) && (out_Renamed != null) && (out_Renamed.CanWrite) && (!bindProperties.Anonymous))
 			{
 				try
 				{
@@ -1005,10 +1113,10 @@ namespace Novell.Directory.Ldap
 			}
 			bindProperties = null;
 			
-			in_Renamed = null;
-			out_Renamed = null;
 			if (socket != null)
 			{
+				// Just before closing the sockets, abort the reader thread
+				reader.Abort();
 				// Close the socket
 				try
 				{
@@ -1018,14 +1126,20 @@ namespace Novell.Directory.Ldap
 						sock.Close();
 					}
 					else
+					{
+						if(in_Renamed != null)
+							in_Renamed.Close();						
 						socket.Close();
 				}
+				}
 				catch (System.IO.IOException ie)
 				{
 					// ignore problem closing socket
 				}
 				socket = null;
 				sock = null;
+				in_Renamed=null;
+				out_Renamed=null;
 			}
 			freeWriteSemaphore(semId);
 			return ;
@@ -1086,8 +1200,7 @@ namespace Novell.Directory.Ldap
 		internal void  startReader()
 		{
 			// Start Reader Thread
-			SupportClass.ThreadClass r =new SupportClass.ThreadClass(new System.Threading.ThreadStart(new ReaderThread(this).Run));
-//			Thread r = new Thread(new ThreadStart(new ReaderThread(this).Run));
+			Thread r = new Thread(new ThreadStart(new ReaderThread(this).Run));
 			r.IsBackground = true; // If the last thread running, allow exit.
 			r.Start();
 			waitForReader(r);
@@ -1132,15 +1245,44 @@ namespace Novell.Directory.Ldap
 				sock.Connect(ephost);
 */
 //				NetworkStream nstream = new NetworkStream(this.socket,true);
+				// Load Mono.Security.dll
+				Assembly a = Assembly.LoadFrom("Mono.Security.dll");
+				Type tSslClientStream = a.GetType("Mono.Security.Protocol.Tls.SslClientStream");
+				BindingFlags flags = (BindingFlags.NonPublic  | BindingFlags.Public |
+					BindingFlags.Static | BindingFlags.Instance | BindingFlags.DeclaredOnly);
+
+				object[] consArgs = new object[4];
+				consArgs[0] = socket.GetStream();
+				consArgs[1] = host;
+				consArgs[2] = false;
+				Type tSecurityProtocolType = a.GetType("Mono.Security.Protocol.Tls.SecurityProtocolType");
+				Enum objSPType = (Enum)(Activator.CreateInstance(tSecurityProtocolType));
+				int nSsl3Val = (int) Enum.Parse(tSecurityProtocolType, "Ssl3");
+				int nTlsVal = (int) Enum.Parse(tSecurityProtocolType, "Tls");
+				consArgs[3] = Enum.ToObject(tSecurityProtocolType, nSsl3Val | nTlsVal);
+
+				object objSslClientStream = 
+					Activator.CreateInstance(tSslClientStream, consArgs);
+
+				// Register ServerCertValidationDelegate handler
+				EventInfo ei = tSslClientStream.GetEvent("ServerCertValidationDelegate");
+				ei.AddEventHandler(objSslClientStream, 
+					Delegate.CreateDelegate(ei.EventHandlerType, this, "ServerCertificateValidation"));
+						
+				// Get the in and out streams
+				in_Renamed = (System.IO.Stream) objSslClientStream;
+				out_Renamed = (System.IO.Stream) objSslClientStream;
+
+				/*
 				SslClientStream sslstream = new SslClientStream(
 									socket.GetStream(),
-//									nstream,
+									nstream,
 									host,
 									false,
 									Mono.Security.Protocol.Tls.SecurityProtocolType.Ssl3| Mono.Security.Protocol.Tls.SecurityProtocolType.Tls);
 				sslstream.ServerCertValidationDelegate = new CertificateValidationCallback(ServerCertificateValidation);
 				this.in_Renamed = (System.IO.Stream) sslstream;
-				this.out_Renamed = (System.IO.Stream) sslstream;
+				this.out_Renamed = (System.IO.Stream) sslstream;*/
 			}
 			catch (System.IO.IOException ioe)
 			{
@@ -1258,7 +1400,7 @@ namespace Novell.Directory.Ldap
 				InterThreadException notify = null;
 				Message info = null;
 				System.IO.IOException ioex = null;
-				this.enclosingInstance.reader = SupportClass.ThreadClass.Current();				
+				this.enclosingInstance.reader = System.Threading.Thread.CurrentThread;				
 //				Enclosing_Instance.reader = SupportClass.ThreadClass.Current();
 //				Console.WriteLine("Inside run:" + this.enclosingInstance.reader.Name);
 				try
@@ -1358,6 +1500,12 @@ namespace Novell.Directory.Ldap
 						}
 					}
 				}
+				catch(ThreadAbortException tae)
+				{
+					// Abort has been called on reader
+					// before closing sockets, from shutdown
+					return;
+				}
 				catch (System.IO.IOException ioe)
 				{
 					
@@ -1516,7 +1664,7 @@ namespace Novell.Directory.Ldap
 		static Connection()
 		{
 			nameLock = new System.Object();
-			sdk = new System.Text.StringBuilder("2.1.1").ToString();
+			sdk = new System.Text.StringBuilder("2.1.4").ToString();
 			protocol = 3;
 		}
 	}
diff -bduprN -x .svn -x CVS ./Novell.Directory.Ldap/Novell.Directory.Ldap/LdapAttributeSet.cs ./Modified/Novell.Directory.Ldap/Novell.Directory.Ldap/LdapAttributeSet.cs
--- ./Novell.Directory.Ldap/Novell.Directory.Ldap/LdapAttributeSet.cs	2005-09-23 09:48:10.614934146 +0530
+++ ./Modified/Novell.Directory.Ldap/Novell.Directory.Ldap/LdapAttributeSet.cs	2005-09-22 14:15:54.000000000 +0530
@@ -52,7 +52,7 @@ namespace Novell.Directory.Ldap
 	/// </seealso>
 	/// <seealso cref="LdapEntry">
 	/// </seealso>
-	public class LdapAttributeSet:AbstractSetSupport, System.ICloneable//, SupportClass.SetSupport
+	public class LdapAttributeSet:SupportClass.AbstractSetSupport, System.ICloneable//, SupportClass.SetSupport
 	{
 		/// <summary> Returns the number of attributes in this set.
 		/// 
diff -bduprN -x .svn -x CVS ./Novell.Directory.Ldap/Novell.Directory.Ldap/LdapBindRequest.cs ./Modified/Novell.Directory.Ldap/Novell.Directory.Ldap/LdapBindRequest.cs
--- ./Novell.Directory.Ldap/Novell.Directory.Ldap/LdapBindRequest.cs	2005-09-23 09:48:10.623932969 +0530
+++ ./Modified/Novell.Directory.Ldap/Novell.Directory.Ldap/LdapBindRequest.cs	2005-09-22 14:16:58.000000000 +0530
@@ -111,11 +111,6 @@ namespace Novell.Directory.Ldap
 		/// <param name="cont">Any controls that apply to the simple bind request,
 		/// or null if none.
 		/// </param>
-		[CLSCompliantAttribute(false)]
-		public LdapBindRequest(int version, System.String dn, String mechanism, sbyte[] credentials, LdapControl[] cont):base(LdapMessage.BIND_REQUEST, new RfcBindRequest(version, dn, mechanism, credentials), cont)
-		{
-			return ;
-		}
 		
 		/// <summary> Return an Asn1 representation of this add request.
 		/// 
diff -bduprN -x .svn -x CVS ./Novell.Directory.Ldap/Novell.Directory.Ldap/LdapConnection.cs ./Modified/Novell.Directory.Ldap/Novell.Directory.Ldap/LdapConnection.cs
--- ./Novell.Directory.Ldap/Novell.Directory.Ldap/LdapConnection.cs	2005-09-23 09:48:10.578938857 +0530
+++ ./Modified/Novell.Directory.Ldap/Novell.Directory.Ldap/LdapConnection.cs	2005-09-22 14:19:28.000000000 +0530
@@ -587,6 +587,18 @@ namespace Novell.Directory.Ldap
 		/// <summary> The OID string that identifies a StartTLS request and response.</summary>
 		private const System.String START_TLS_OID = "1.3.6.1.4.1.1466.20037";
 		
+		public event CertificateValidationCallback UserDefinedServerCertValidationDelegate
+		{
+			add
+			{
+				this.conn.OnCertificateValidation += value;
+			}
+
+			remove
+			{
+				this.conn.OnCertificateValidation -= value;
+			}
+		}
 		/*
 		* Constructors
 		*/
diff -bduprN -x .svn -x CVS ./Novell.Directory.Ldap/Novell.Directory.Ldap/LdapException.cs ./Modified/Novell.Directory.Ldap/Novell.Directory.Ldap/LdapException.cs
--- ./Novell.Directory.Ldap/Novell.Directory.Ldap/LdapException.cs	2005-09-23 09:48:10.572939642 +0530
+++ ./Modified/Novell.Directory.Ldap/Novell.Directory.Ldap/LdapException.cs	2005-09-22 14:25:44.000000000 +0530
@@ -758,6 +758,17 @@ namespace Novell.Directory.Ldap
 		/// </summary>
 		public const int TLS_NOT_SUPPORTED = 112;
 		
+                /// <summary> Indicates that SSL Handshake could not succeed.
+                ///
+                /// SSL_HANDSHAKE_FAILED = 113
+                /// </summary>
+                public const int SSL_HANDSHAKE_FAILED = 113;
+ 
+		/// <summary> Indicates that SSL Provider could not be found.
+		///
+		/// SSL_PROVIDER_NOT_FOUND = 114
+		/// </summary>
+		public const int SSL_PROVIDER_NOT_FOUND = 114;
 		/*
 		* Note: Error strings have been pulled out into
 		* ResultCodeMessages.properties
diff -bduprN -x .svn -x CVS ./Novell.Directory.Ldap/Novell.Directory.Ldap/Message.cs ./Modified/Novell.Directory.Ldap/Novell.Directory.Ldap/Message.cs
--- ./Novell.Directory.Ldap/Novell.Directory.Ldap/Message.cs	2005-09-23 09:48:10.620933361 +0530
+++ ./Modified/Novell.Directory.Ldap/Novell.Directory.Ldap/Message.cs	2005-09-22 14:32:32.000000000 +0530
@@ -466,7 +466,10 @@ namespace Novell.Directory.Ldap
 			{
 				return ;
 			}
+			lock(replies)
+			{
 			replies.Add(message);
+			}
 			message.RequestingMessage = msg; // Save request message info
 			switch (message.Type)
 			{
diff -bduprN -x .svn -x CVS ./Novell.Directory.Ldap/Novell.Directory.Ldap/SupportClass.cs ./Modified/Novell.Directory.Ldap/Novell.Directory.Ldap/SupportClass.cs
--- ./Novell.Directory.Ldap/Novell.Directory.Ldap/SupportClass.cs	2005-09-23 09:48:10.590937287 +0530
+++ ./Modified/Novell.Directory.Ldap/Novell.Directory.Ldap/SupportClass.cs	2005-09-22 14:45:30.000000000 +0530
@@ -1631,6 +1631,15 @@ using System;
 		/// <summary>
 		/// This class manages different operation with collections.
 		/// </summary>
+		public class AbstractSetSupport : SetSupport
+		{
+			/// <summary>
+			/// The constructor with no parameters to create an abstract set.
+			/// </summary>
+			public AbstractSetSupport()
+			{
+			}
+		}
 
 
 		/*******************************/
@@ -2155,13 +2164,3 @@ using System;
 		}
 
 	}
-
-	public class AbstractSetSupport : SupportClass.SetSupport
-	{
-		/// <summary>
-		/// The constructor with no parameters to create an abstract set.
-		/// </summary>
-		public AbstractSetSupport()
-		{
-		}
-	}
diff -bduprN -x .svn -x CVS ./Novell.Directory.Ldap/Novell.Directory.Ldap.Utilclass/ExceptionMessages.cs ./Modified/Novell.Directory.Ldap/Novell.Directory.Ldap.Utilclass/ExceptionMessages.cs
--- ./Novell.Directory.Ldap/Novell.Directory.Ldap.Utilclass/ExceptionMessages.cs	2005-09-23 09:48:17.537028228 +0530
+++ ./Modified/Novell.Directory.Ldap/Novell.Directory.Ldap.Utilclass/ExceptionMessages.cs	2005-09-22 14:59:02.000000000 +0530
@@ -110,6 +110,7 @@ namespace Novell.Directory.Ldap.Utilclas
 		public const System.String NO_SCHEMA = "NO_SCHEMA";
 		public const System.String READ_MULTIPLE = "READ_MULTIPLE";
 		public const System.String CANNOT_BIND = "CANNOT_BIND";
+		public const System.String SSL_PROVIDER_MISSING = "SSL_PROVIDER_MISSING";
 		
 		//End constants
 		
diff -bduprN -x .svn -x CVS ./Novell.Directory.Ldap/Novell.Directory.Ldap.Utilclass/ExceptionMessages.txt ./Modified/Novell.Directory.Ldap/Novell.Directory.Ldap.Utilclass/ExceptionMessages.txt
--- ./Novell.Directory.Ldap/Novell.Directory.Ldap.Utilclass/ExceptionMessages.txt	1970-01-01 05:30:00.000000000 +0530
+++ ./Modified/Novell.Directory.Ldap/Novell.Directory.Ldap.Utilclass/ExceptionMessages.txt	2005-07-11 16:27:14.000000000 +0530
@@ -0,0 +1,63 @@
+TOSTRING={0}: {1} ({2}) {3}
+SERVER_MSG={0}: Server Message: {1}
+MATCHED_DN={0}: Matched DN: {1}
+FAILED_REFERRAL={0}: Failed Referral: {1}
+REFERRAL_ITEM={0}: Referral: {1}
+CONNECTION_ERROR=Unable to connect to server {0}:{1}
+CONNECTION_IMPOSSIBLE=Unable to reconnect to server, application has never called connect()
+CONNECTION_WAIT=Connection lost waiting for results from {0}:{1}
+CONNECTION_FINALIZED=Connection closed by the application finalizing the object
+CONNECTION_CLOSED=Connection closed by the application disconnecting
+CONNECTION_READER=Reader thread terminated
+DUP_ERROR=RfcLdapMessage: Cannot duplicate message built from the input stream
+REFERENCE_ERROR=Error attempting to follow a search continuation reference
+REFERRAL_ERROR=Error attempting to follow a referral
+REFERRAL_LOCAL=LdapSearchResults.{0}(): No entry found & request is not complete
+REFERRAL_SEND=Error sending request to referred server
+REFERENCE_NOFOLLOW=Search result reference received, and referral following is off
+REFERRAL_BIND=LdapBind.bind() function returned null
+REFERRAL_BIND_MATCH=Could not match LdapBind.bind() connection with Server Referral URL list
+NO_DUP_REQUEST=Cannot duplicate message to follow referral for {0} request, not allowed
+SERVER_CONNECT_ERROR=Error connecting to server {0} while attempting to follow a referral
+NO_SUP_PROPERTY=Requested property is not supported.
+ENTRY_PARAM_ERROR=Invalid Entry parameter
+DN_PARAM_ERROR=Invalid DN parameter
+RDN_PARAM_ERROR=Invalid DN or RDN parameter
+OP_PARAM_ERROR=Invalid extended operation parameter, no OID specified
+PARAM_ERROR=Invalid parameter
+DECODING_ERROR=Error Decoding responseValue
+ENCODING_ERROR=Encoding Error
+IO_EXCEPTION=I/O Exception on host {0}, port {1}
+INVALID_ESCAPE=Invalid value in escape sequence \"{0}\"
+SHORT_ESCAPE=Incomplete escape sequence
+UNEXPECTED_END=Unexpected end of filter
+MISSING_LEFT_PAREN=Unmatched parentheses, left parenthesis missing
+NO_OPTION=Semicolon present, but no option specified
+MISSING_RIGHT_PAREN=Unmatched parentheses, right parenthesis missing
+EXPECTING_RIGHT_PAREN=Expecting right parenthesis, found \"{0}\"
+EXPECTING_LEFT_PAREN=Expecting left parenthesis, found \"{0}\"
+NO_ATTRIBUTE_NAME=Missing attribute description
+NO_DN_NOR_MATCHING_RULE=DN and matching rule not specified
+NO_MATCHING_RULE=Missing matching rule
+INVALID_FILTER_COMPARISON=Invalid comparison operator
+INVALID_CHAR_IN_FILTER=The invalid character \"{0}\" needs to be escaped as \"{1}\"
+INVALID_ESC_IN_DESCR=Escape sequence not allowed in attribute description
+INVALID_CHAR_IN_DESCR=Invalid character \"{0}\" in attribute description
+NOT_AN_ATTRIBUTE=Schema element is not an LdapAttributeSchema object
+UNEQUAL_LENGTHS=Length of attribute Name array does not equal length of Flags array
+IMPROPER_REFERRAL=Referral not supported for command {0}
+NOT_IMPLEMENTED=Method LdapConnection.startTLS not implemented
+NO_MEMORY=All results could not be stored in memory, sort failed
+SERVER_SHUTDOWN_REQ=Received unsolicited notification from server {0}:{1} to shutdown
+INVALID_ADDRESS=Invalid syntax for address with port; {0}
+UNKNOWN_RESULT=Unknown Ldap result code {0}
+OUTSTANDING_OPERATIONS=Cannot start or stop TLS because outstanding Ldap operations exist on this connection
+WRONG_FACTORY=StartTLS cannot use the set socket factory because it does not implement LdapTLSSocketFactory
+NO_TLS_FACTORY=StartTLS failed because no LdapTLSSocketFactory has been set for this Connection
+NO_STARTTLS=An attempt to stopTLS on a connection where startTLS had not been called
+STOPTLS_ERROR=Error stopping TLS: Error getting input & output streams from the original socket
+MULTIPLE_SCHEMA=Multiple schema found when reading the subschemaSubentry for {0}
+NO_SCHEMA=No schema found when reading the subschemaSubentry for {0}
+READ_MULTIPLE=Read response is ambiguous, multiple entries returned
+CANNOT_BIND=Cannot bind. Use PoolManager.getBoundConnection()
+SSL_PROVIDER_MISSING=Please ensure that SSL Provider is properly installed.
diff -bduprN -x .svn -x CVS ./Novell.Directory.Ldap/Novell.Directory.Ldap.Utilclass/ResourcesHandler.cs ./Modified/Novell.Directory.Ldap/Novell.Directory.Ldap.Utilclass/ResourcesHandler.cs
--- ./Novell.Directory.Ldap/Novell.Directory.Ldap.Utilclass/ResourcesHandler.cs	2005-09-23 09:48:17.556025741 +0530
+++ ./Modified/Novell.Directory.Ldap/Novell.Directory.Ldap.Utilclass/ResourcesHandler.cs	2005-09-22 15:03:14.000000000 +0530
@@ -30,6 +30,10 @@
 //
 
 using System;
+using System.Resources;
+using System.Threading;
+using System.Reflection;
+using System.Text;
 
 namespace Novell.Directory.Ldap.Utilclass
 {
@@ -102,33 +106,26 @@ namespace Novell.Directory.Ldap.Utilclas
 		/// </returns>
 		public static System.String getMessage(System.String messageOrKey, System.Object[] arguments, System.Globalization.CultureInfo locale)
 		{
-			System.String pattern;
-			System.Resources.ResourceManager messages = null;
-			
-			if ((System.Object) messageOrKey == null)
+			if (defaultMessages == null)
 			{
-				messageOrKey = "";
+				defaultMessages = new ResourceManager("Ldap2._1._2.ExceptionMessages", Assembly.GetExecutingAssembly());
 			}
 			
-			try
-			{
-				if ((locale == null) || defaultLocale.Equals(locale))
-				{
+			if (defaultLocale == null)
+				defaultLocale = Thread.CurrentThread.CurrentUICulture;
+
+			if (locale == null)
 					locale = defaultLocale;
-					// Default Locale
-					if (defaultMessages == null)
+
+			if (messageOrKey == null)
 					{
-						System.Threading.Thread.CurrentThread.CurrentUICulture = defaultLocale;
-						defaultMessages = System.Resources.ResourceManager.CreateFileBasedResourceManager(pkg + "ExceptionMessages", "", null);
-					}
-					messages = defaultMessages;
+				messageOrKey = "";
 				}
-				else
+			
+			string pattern;
+			try
 				{
-					System.Threading.Thread.CurrentThread.CurrentUICulture = locale;
-					messages = System.Resources.ResourceManager.CreateFileBasedResourceManager(pkg + "ExceptionMessages", "", null);
-				}
-				pattern = messages.GetString(messageOrKey);
+				pattern = defaultMessages.GetString(messageOrKey, locale);
 			}
 			catch (System.Resources.MissingManifestResourceException mre)
 			{
@@ -138,8 +135,11 @@ namespace Novell.Directory.Ldap.Utilclas
 			// Format the message if arguments were passed
 			if (arguments != null)
 			{
-//				MessageFormat mf = new MessageFormat(pattern);
-				pattern=System.String.Format(locale,pattern,arguments);
+				StringBuilder strB = new StringBuilder();
+				strB.AppendFormat(pattern, arguments);
+				pattern = strB.ToString();
+				//				MessageFormat mf = new MessageFormat(pattern);
+				//				pattern=System.String.Format(locale,pattern,arguments);
 //				mf.setLocale(locale);
 				//this needs to be reset with the new local - i18n defect in java
 //				mf.applyPattern(pattern);
@@ -177,38 +177,34 @@ namespace Novell.Directory.Ldap.Utilclas
 		/// </returns>
 		public static System.String getResultString(int code, System.Globalization.CultureInfo locale)
 		{
-			System.Resources.ResourceManager messages;
-			System.String result;
-			try
-			{
-				if ((locale == null) || defaultLocale.Equals(locale))
-				{
-					locale = defaultLocale;
-					// Default Locale
 					if (defaultResultCodes == null)
 					{
-//						System.Threading.Thread.CurrentThread.CurrentUICulture = defaultLocale;
-						defaultResultCodes = System.Resources.ResourceManager.CreateFileBasedResourceManager(pkg + "ResultCodeMessages", "", null);
-					}
-					messages = defaultResultCodes;
+/*
+				defaultResultCodes = ResourceManager.CreateFileBasedResourceManager("ResultCodeMessages", "Resources", null);*/
+				defaultResultCodes = new ResourceManager("ResultCodeMessages", Assembly.GetExecutingAssembly());
 				}
-				else
+
+			if (defaultLocale == null)
+				defaultLocale = Thread.CurrentThread.CurrentUICulture;
+
+			if (locale == null)
+				locale = defaultLocale;
+
+			string result;
+			try
 				{
-					System.Threading.Thread.CurrentThread.CurrentUICulture = locale;
-					messages = System.Resources.ResourceManager.CreateFileBasedResourceManager(pkg + "ResultCodeMessages", "", null);
-				}
-//				result = messages.GetString(System.Convert.ToString(code));
-				result = Convert.ToString(code);
+				result = defaultResultCodes.GetString(Convert.ToString(code), defaultLocale);
 			}
-			catch (System.Resources.MissingManifestResourceException mre)
+			catch (ArgumentNullException mre)
 			{
-				result = getMessage(ExceptionMessages.UNKNOWN_RESULT, new System.Object[]{code}, locale);
+				result = getMessage(ExceptionMessages.UNKNOWN_RESULT, new Object[]{code}, locale);
 			}
 			return result;
 		}
+
 		static ResourcesHandler()
 		{
-//			defaultLocale = System.Globalization.CultureInfo.CurrentCulture;
+			defaultLocale = Thread.CurrentThread.CurrentUICulture;
 		}
 	} //end class ResourcesHandler
 }
diff -bduprN -x .svn -x CVS ./Novell.Directory.Ldap/Novell.Directory.Ldap.Utilclass/RespExtensionSet.cs ./Modified/Novell.Directory.Ldap/Novell.Directory.Ldap.Utilclass/RespExtensionSet.cs
--- ./Novell.Directory.Ldap/Novell.Directory.Ldap.Utilclass/RespExtensionSet.cs	2005-09-23 09:48:17.530029144 +0530
+++ ./Modified/Novell.Directory.Ldap/Novell.Directory.Ldap.Utilclass/RespExtensionSet.cs	2005-09-22 15:08:52.000000000 +0530
@@ -37,7 +37,7 @@ namespace Novell.Directory.Ldap.Utilclas
 	/// so that it can be used to maintain a list of currently
 	/// registered extended responses.
 	/// </summary>
-	public class RespExtensionSet:AbstractSetSupport
+	public class RespExtensionSet:SupportClass.AbstractSetSupport
 	{
 		/// <summary> Returns the number of extensions in this set.
 		/// 
diff -bduprN -x .svn -x CVS ./Novell.Directory.Ldap/Novell.Directory.Ldap.Utilclass/ResultCodeMessages.txt ./Modified/Novell.Directory.Ldap/Novell.Directory.Ldap.Utilclass/ResultCodeMessages.txt
--- ./Novell.Directory.Ldap/Novell.Directory.Ldap.Utilclass/ResultCodeMessages.txt	1970-01-01 05:30:00.000000000 +0530
+++ ./Modified/Novell.Directory.Ldap/Novell.Directory.Ldap.Utilclass/ResultCodeMessages.txt	2005-08-25 15:07:26.000000000 +0530
@@ -0,0 +1,61 @@
+0=Success

+1=Operations Error

+2=Protocol Error

+3=Timelimit Exceeded

+4=Sizelimit Exceeded

+5=Compare False

+6=Compare True

+7=Authentication Method Not Supported

+8=Strong Authentication Required

+9=Partial Results

+10=Referral

+11=Administrative Limit Exceeded

+12=Unavailable Critical Extension

+13=Confidentiality Required

+14=SASL Bind In Progress

+16=No Such Attribute

+17=Undefined Attribute Type

+18=Inappropriate Matching

+19=Constraint Violation

+20=Attribute Or Value Exists

+21=Invalid Attribute Syntax

+32=No Such Object

+33=Alias Problem

+34=Invalid DN Syntax

+35=Is Leaf

+36=Alias Dereferencing Problem

+48=Inappropriate Authentication

+49=Invalid Credentials

+50=Insufficient Access Rights

+51=Busy

+52=Unavailable

+53=Unwilling To Perform

+54=Loop Detect

+64=Naming Violation

+65=Object Class Violation

+66=Not Allowed On Non-leaf

+67=Not Allowed On RDN

+68=Entry Already Exists

+69=Object Class Modifications Prohibited

+71=Affects Multiple DSAs

+80=Other

+81=Server Down

+82=Local Error

+83=Encoding Error

+84=Decoding Error

+85=Ldap Timeout

+86=Authentication Unknown

+87=Filter Error

+88=User Cancelled

+89=Parameter Error

+90=No Memory

+91=Connect Error

+92=Ldap Not Supported

+93=Control Not Found

+94=No Results Returned

+95=More Results To Return

+96=Client Loop

+97=Referral Limit Exceeded

+112=TLS not supported

+113=SSL handshake failed

+114=SSL Provider not found
\ No newline at end of file
