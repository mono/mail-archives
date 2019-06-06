diff --git a/mcs/tools/security/certmgr.cs b/mcs/tools/security/certmgr.cs
index 5799fcf..20e1427 100644
--- a/mcs/tools/security/certmgr.cs
+++ b/mcs/tools/security/certmgr.cs
@@ -137,6 +137,12 @@ namespace Mono.Tools {
 			return type;
 		}
 
+		static bool GetPasswordArg (string arg) 
+		{
+			Action action = Action.None;
+			return GetCommand (arg) == "PASS";
+		}
+		
 		static X509Store GetStoreFromName (string storeName, bool machine) 
 		{
 			X509Stores stores = ((machine) ? X509StoreManager.LocalMachine : X509StoreManager.CurrentUser);
@@ -168,7 +174,7 @@ namespace Mono.Tools {
 			return Convert.FromBase64String (base64);
 		}
 
-		static X509CertificateCollection LoadCertificates (string filename) 
+		static X509CertificateCollection LoadCertificates (string filename, string password) 
 		{
 			X509Certificate x509 = null;
 			X509CertificateCollection coll = new X509CertificateCollection ();
@@ -196,8 +202,11 @@ namespace Mono.Tools {
 					break;
 				case ".P12":
 				case ".PFX":
-					// TODO - support PKCS12 with passwords
-					PKCS12 p12 = PKCS12.LoadFromFile (filename);
+					PKCS12 p12;
+					if (password != null)
+						p12 = PKCS12.LoadFromFile (filename, password);
+					else
+						p12 = PKCS12.LoadFromFile (filename);
 					coll.AddRange (p12.Certificates);
 					p12 = null;
 					break;
@@ -236,11 +245,11 @@ namespace Mono.Tools {
 			return list;
 		}
 
-		static void Add (ObjectType type, X509Store store, string file, bool verbose) 
+		static void Add (ObjectType type, X509Store store, string file, string password, bool verbose) 
 		{
 			switch (type) {
 				case ObjectType.Certificate:
-					X509CertificateCollection coll = LoadCertificates (file);
+					X509CertificateCollection coll = LoadCertificates (file, password);
 					foreach (X509Certificate x509 in coll) {
 						store.Import (x509);
 					}
@@ -531,13 +540,19 @@ namespace Mono.Tools {
 				}
 			}
 
+			// --pass yourpassword
+			bool hasPwd = n + 1 < args.Length && GetPasswordArg (args [n]);
+			string password = hasPwd ? args [++n] : null;
+			if (hasPwd)
+				n++;
+
 			string file = (n < args.Length) ? args [n] : null;
 
 			// now action!
 			try {
 				switch (action) {
 				case Action.Add:
-					Add (type, store, file, verbose);
+					Add (type, store, file, password, verbose);
 					break;
 				case Action.Delete:
 					Delete (type, store, file, verbose);
