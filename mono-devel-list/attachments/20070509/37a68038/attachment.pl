mcs/class/corlib/System.Security.Cryptography:

2007-05-08  Randolph Chung  <tausq@debian.org>

    * DSACryptoServiceProvider.cs: Implement the ImportCspBlob and
    ExportCspBlob methods by calling into CryptoConvert.

mcs/class/corlib/Test/System.Security.Cryptography:

2007-05-08  Randolph Chung  <tausq@debian.org>

	* DSACryptoServiceProviderTest.cs: Remove "NotWorking" annotation
	for the blob tests that should now pass.

Index: DSACryptoServiceProvider.cs
===================================================================
--- DSACryptoServiceProvider.cs	(revision 76876)
+++ DSACryptoServiceProvider.cs	(working copy)
@@ -277,20 +277,39 @@
 			get { return null; }
 		}
 
-		[MonoTODO ("call into CryptoConvert (doesn't currently support DSA)")]
 		[ComVisible (false)]
 		public byte[] ExportCspBlob (bool includePrivateParameters)
 		{
-			throw new NotImplementedException ("CryptoConvert doesn't currently support DSA");
+			byte[] blob = null;
+			if (includePrivateParameters)
+				blob = CryptoConvert.ToCapiPrivateKeyBlob (this);
+			else
+				blob = CryptoConvert.ToCapiPublicKeyBlob (this);
+			return blob;
 		}
 
-		[MonoTODO ("call into CryptoConvert (doesn't currently support DSA)")]
 		[ComVisible (false)]
 		public void ImportCspBlob (byte[] rawData)
 		{
 			if (rawData == null)
 				throw new ArgumentNullException ("rawData");
-			throw new NotImplementedException ("CryptoConvert doesn't currently support DSA");
+			DSA dsa = CryptoConvert.FromCapiKeyBlobDSA (rawData);
+			if (dsa is DSACryptoServiceProvider) {
+				DSAParameters dsap = dsa.ExportParameters (!(dsa as DSACryptoServiceProvider).PublicOnly);
+				ImportParameters (dsap);
+			} else {
+				// we can't know from DSA if the private key is available
+				try {
+					// so we try it...
+					DSAParameters dsap = dsa.ExportParameters (true);
+					ImportParameters (dsap);
+				}
+				catch {
+					// and fall back
+					DSAParameters dsap = dsa.ExportParameters (false);
+					ImportParameters (dsap);
+				}
+			}
 		}
 #endif
 	}

Index: DSACryptoServiceProviderTest.cs
===================================================================
--- DSACryptoServiceProviderTest.cs	(revision 76876)
+++ DSACryptoServiceProviderTest.cs	(working copy)
@@ -966,7 +966,6 @@
 	}
 
 	[Test]
-	[Category ("NotWorking")]
 	public void ExportCspBlob_Full ()
 	{
 		dsa = new DSACryptoServiceProvider (minKeySize);
@@ -978,7 +977,6 @@
 	}
 
 	[Test]
-	[Category ("NotWorking")]
 	public void ExportCspBlob_PublicOnly ()
 	{
 		dsa = new DSACryptoServiceProvider (minKeySize);
@@ -991,7 +989,6 @@
 
 	[Test]
 	[ExpectedException (typeof (CryptographicException))]
-	[Category ("NotWorking")]
 	public void ExportCspBlob_MissingPrivateKey ()
 	{
 		dsa = new DSACryptoServiceProvider (minKeySize);
@@ -1002,7 +999,6 @@
 	}
 
 	[Test]
-	[Category ("NotWorking")]
 	public void ExportCspBlob_MissingPrivateKey_PublicOnly ()
 	{
 		dsa = new DSACryptoServiceProvider (minKeySize);
@@ -1014,7 +1010,6 @@
 	}
 
 	[Test]
-	[Category ("NotWorking")]
 	public void ImportCspBlob_Keypair ()
 	{
 		byte[] blob = new byte [336] { 0x07, 0x02, 0x00, 0x00, 0x00, 0x22, 0x00, 0x00, 0x44, 0x53, 0x53, 0x32, 0x00, 0x04, 0x00, 0x00, 0xD3,
@@ -1042,7 +1037,6 @@
 	}
 
 	[Test]
-	[Category ("NotWorking")]
 	public void ExportCspBlob_PublicKey ()
 	{
 		byte[] blob = new byte [444] { 0x06, 0x02, 0x00, 0x00, 0x00, 0x22, 0x00, 0x00, 0x44, 0x53, 0x53, 0x31, 0x00, 0x04, 0x00, 0x00, 0xD3, 
@@ -1084,7 +1078,6 @@
 
 	[Test]
 	[ExpectedException (typeof (CryptographicException))]
-	[Category ("NotWorking")]
 	public void ImportCspBlob_Bad ()
 	{
 		byte[] blob = new byte [148]; // valid size for public key
