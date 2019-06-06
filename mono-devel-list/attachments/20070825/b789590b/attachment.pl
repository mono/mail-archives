Index: System.Diagnostics/ProcessStartInfo.cs
===================================================================
--- System.Diagnostics/ProcessStartInfo.cs	(revision 84839)
+++ System.Diagnostics/ProcessStartInfo.cs	(working copy)
@@ -56,9 +56,14 @@
 		private bool redirect_standard_output = false;
 		private bool use_shell_execute = true;
 		private ProcessWindowStyle window_style = ProcessWindowStyle.Normal;
+		private Encoding encoding_stderr, encoding_stdout;
+		private string username, domain;
 #if NET_2_0
-		private Encoding encoding_stderr, encoding_stdout;
+		private SecureString password;
+#else
+		private object password; // dummy
 #endif
+		private bool load_user_profile;
 
 		public ProcessStartInfo() 
 		{
@@ -288,5 +293,27 @@
 				working_directory = value == null ? String.Empty : value;
 			}
 		}
+
+#if NET_2_0
+		public bool LoadUserProfile {
+			get { return load_user_profile; }
+			set { load_user_profile = value; }
+		}
+
+		public string UserName {
+			get { return username; }
+			set { username = value; }
+		}
+
+		public string Domain {
+			get { return domain; }
+			set { domain = value; }
+		}
+
+		public SecureString Password {
+			get { return password; }
+			set { password = value; }
+		}
+#endif
 	}
 }
Index: System.Diagnostics/Process.cs
===================================================================
--- System.Diagnostics/Process.cs	(revision 84839)
+++ System.Diagnostics/Process.cs	(working copy)
@@ -40,6 +40,7 @@
 using System.Runtime.InteropServices;
 using System.Security.Permissions;
 using System.Collections;
+using System.Security;
 using System.Threading;
 
 namespace System.Diagnostics {
@@ -67,6 +68,10 @@
 			public int tid;
 			public string [] envKeys;
 			public string [] envValues;
+			public string UserName;
+			public string Domain;
+			public IntPtr Password;
+			public bool LoadUserProfile;
 		};
 		
 		IntPtr process_handle;
@@ -933,8 +938,15 @@
 				throw new InvalidOperationException ("UseShellExecute must be false in order to use environment variables.");
 			}
 
-			ret = ShellExecuteEx_internal (startInfo,
-						       ref proc_info);
+			FillUserInfo (startInfo, ref proc_info);
+			try {
+				ret = ShellExecuteEx_internal (startInfo,
+							       ref proc_info);
+			} finally {
+				if (proc_info.Password != IntPtr.Zero)
+					Marshal.FreeBSTR (proc_info.Password);
+				proc_info.Password = IntPtr.Zero;
+			}
 			if (!ret) {
 				throw new Win32Exception (-proc_info.pid);
 			}
@@ -1026,9 +1038,16 @@
 				stderr_wr = MonoIO.ConsoleError;
 			}
 
-			ret = CreateProcess_internal (startInfo,
-						      stdin_rd, stdout_wr, stderr_wr,
-						      ref proc_info);
+			FillUserInfo (startInfo, ref proc_info);
+			try {
+				ret = CreateProcess_internal (startInfo,
+							      stdin_rd, stdout_wr, stderr_wr,
+							      ref proc_info);
+			} finally {
+				if (proc_info.Password != IntPtr.Zero)
+					Marshal.FreeBSTR (proc_info.Password);
+				proc_info.Password = IntPtr.Zero;
+			}
 			if (!ret) {
 				if (startInfo.RedirectStandardInput == true) {
 					MonoIO.Close (stdin_rd, out error);
@@ -1086,6 +1105,19 @@
 			return(ret);
 		}
 
+		// Note that ProcInfo.Password must be freed.
+		private static void FillUserInfo (ProcessStartInfo startInfo, ref ProcInfo proc_info)
+		{
+#if NET_2_0
+			if (startInfo.UserName != null) {
+				proc_info.UserName = startInfo.UserName;
+				proc_info.Domain = startInfo.Domain;
+				proc_info.Password = Marshal.SecureStringToBSTR (startInfo.Password);
+				proc_info.LoadUserProfile = startInfo.LoadUserProfile;
+			}
+#endif
+		}
+
 		private static bool Start_common (ProcessStartInfo startInfo,
 						  Process process)
 		{
@@ -1102,6 +1134,10 @@
 #endif
 			
 			if (startInfo.UseShellExecute) {
+#if NET_2_0
+				if (startInfo.UserName != null)
+					throw new InvalidOperationException ("UserShellExecute must be false if an explicit UserName is specified when starting a process");
+#endif
 				return (Start_shell (startInfo, process));
 			} else {
 				return (Start_noshell (startInfo, process));
@@ -1144,6 +1180,21 @@
                        return Start(new ProcessStartInfo(fileName, arguments));
 		}
 
+#if NET_2_0
+		public static Process Start(string fileName, string username, SecureString password, string domain) {
+			return Start(fileName, null, username, password, domain);
+		}
+
+		public static Process Start(string fileName, string arguments, string username, SecureString password, string domain) {
+			ProcessStartInfo psi = new ProcessStartInfo(fileName, arguments);
+			psi.UserName = username;
+			psi.Password = password;
+			psi.Domain = domain;
+			psi.UseShellExecute = false;
+			return Start(psi);
+		}
+#endif
+
 		public override string ToString() {
 			return(base.ToString() +
 			       " (" + this.ProcessName + ")");