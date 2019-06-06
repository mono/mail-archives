diff --git a/mcs/class/Mono.Security/Mono.Security.X509/X509Stores.cs b/mcs/class/Mono.Security/Mono.Security.X509/X509Stores.cs
index bfe7451..eab4eae 100644
--- a/mcs/class/Mono.Security/Mono.Security.X509/X509Stores.cs
+++ b/mcs/class/Mono.Security/Mono.Security.X509/X509Stores.cs
@@ -47,6 +47,7 @@ namespace Mono.Security.X509 {
 		private X509Store _personal;
 		private X509Store _other;
 		private X509Store _intermediate;
+		private X509Store _trusted_people;
 		private X509Store _trusted;
 		private X509Store _untrusted;
 
@@ -87,6 +88,16 @@ namespace Mono.Security.X509 {
 			}
 		}
 
+		public X509Store TrustedPeople {
+			get { 
+				if (_trusted_people == null) {
+					string path = Path.Combine (_storePath, Names.TrustedPeople);
+					_trusted_people = new X509Store (path, true);
+				}
+				return _trusted_people; 
+			}
+		}
+
 		public X509Store TrustedRoot {
 			get { 
 				if (_trusted == null) {
@@ -121,6 +132,9 @@ namespace Mono.Security.X509 {
 			if (_intermediate != null)
 				_intermediate.Clear ();
 			_intermediate = null;
+			if (_trusted_people != null)
+				_trusted_people.Clear ();
+			_trusted_people = null;
 			if (_trusted != null)
 				_trusted.Clear ();
 			_trusted = null;
@@ -149,6 +163,7 @@ namespace Mono.Security.X509 {
 			public const string Personal = "My";
 			public const string OtherPeople = "AddressBook";
 			public const string IntermediateCA = "CA";
+			public const string TrustedPeople = "TrustedPeople";
 			public const string TrustedRoot = "Trust";
 			public const string Untrusted = "Disallowed";
 			
diff --git a/mcs/tools/security/certmgr.cs b/mcs/tools/security/certmgr.cs
index 5799fcf..f73cd54 100644
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
@@ -151,6 +157,8 @@ namespace Mono.Tools {
 				case "Root": // special case (same as trusted root)
 				case X509Stores.Names.TrustedRoot:
 					return stores.TrustedRoot;
+				case X509Stores.Names.TrustedPeople:
+					return stores.TrustedPeople;
 				case X509Stores.Names.Untrusted:
 					return stores.Untrusted;
 			}
@@ -168,7 +176,7 @@ namespace Mono.Tools {
 			return Convert.FromBase64String (base64);
 		}
 
-		static X509CertificateCollection LoadCertificates (string filename) 
+		static X509CertificateCollection LoadCertificates (string filename, string password) 
 		{
 			X509Certificate x509 = null;
 			X509CertificateCollection coll = new X509CertificateCollection ();
@@ -196,8 +204,11 @@ namespace Mono.Tools {
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
@@ -236,11 +247,11 @@ namespace Mono.Tools {
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
@@ -531,13 +542,19 @@ namespace Mono.Tools {
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
