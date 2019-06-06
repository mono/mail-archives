mcs/class/Mono.Security/Mono.Security.Cryptography:
mcs/class/corlib/Mono.Security.Cryptography:

2007-05-08  Randolph Chung  <tausq@debian.org>

    * CryptoConvert.cs: Add DSA blob conversion functions.

mcs/class/Mono.Security/Test/Mono.Security.Cryptography:

2007-05-08  Randolph Chung  <tausq@debian.org>

    * CryptoConvertTest.cs: Add tests for DSA conversion functions.

Index: CryptoConvert.cs
===================================================================
--- CryptoConvert.cs	(revision 76876)
+++ CryptoConvert.cs	(working copy)
@@ -183,6 +183,68 @@
 			}
 		}
 
+		static public DSA FromCapiPrivateKeyBlobDSA (byte[] blob)
+		{
+			return FromCapiPrivateKeyBlobDSA (blob, 0);
+		}
+
+		static public DSA FromCapiPrivateKeyBlobDSA (byte[] blob, int offset)
+		{
+			if (blob == null)
+				throw new ArgumentNullException ("blob");
+			if (offset >= blob.Length)
+				throw new ArgumentException ("blob is too small.");
+
+			try {
+				if ((blob [offset] != 0x07) ||				// PRIVATEKEYBLOB (0x07)
+				    (blob [offset + 1] != 0x02) ||			// Version (0x02)
+				    (blob [offset + 2] != 0x00) ||			// Reserved (word)
+				    (blob [offset + 3] != 0x00) ||
+				    (ToUInt32LE (blob, offset + 8) != 0x32535344))	// DWORD magic
+					throw new CryptographicException ("Invalid blob header");
+
+				int bitlen = ToInt32LE (blob, offset + 12);
+				DSAParameters dsap = new DSAParameters ();
+				int bytelen = bitlen >> 3;
+				int pos = offset + 16;
+
+				dsap.P = new byte [bytelen];
+				Buffer.BlockCopy (blob, pos, dsap.P, 0, bytelen);
+				Array.Reverse (dsap.P);
+				pos += bytelen;
+
+				dsap.Q = new byte [20];
+				Buffer.BlockCopy (blob, pos, dsap.Q, 0, 20);
+				Array.Reverse (dsap.Q);
+				pos += 20;
+
+				dsap.G = new byte [bytelen];
+				Buffer.BlockCopy (blob, pos, dsap.G, 0, bytelen);
+				Array.Reverse (dsap.G);
+				pos += bytelen;
+
+				dsap.X = new byte [20];
+				Buffer.BlockCopy (blob, pos, dsap.X, 0, 20);
+				Array.Reverse (dsap.X);
+				pos += 20;
+
+				dsap.Counter = ToInt32LE (blob, pos);
+				pos += 4;
+
+				dsap.Seed = new byte [20];
+				Buffer.BlockCopy (blob, pos, dsap.Seed, 0, 20);
+				Array.Reverse (dsap.Seed);
+				pos += 20;
+
+				DSA dsa = (DSA)DSA.Create ();
+				dsa.ImportParameters (dsap);
+				return dsa;
+			}
+			catch (Exception e) {
+				throw new CryptographicException ("Invalid blob.", e);
+			}
+		}
+
 		static public byte[] ToCapiPrivateKeyBlob (RSA rsa) 
 		{
 			RSAParameters p = rsa.ExportParameters (true);
@@ -255,6 +317,60 @@
 			return blob;
 		}
 
+		static public byte[] ToCapiPrivateKeyBlob (DSA dsa)
+		{
+			DSAParameters p = dsa.ExportParameters (true);
+			int keyLength = p.P.Length; // in bytes
+
+			// header + P + Q + G + X + count + seed
+			byte[] blob = new byte [16 + keyLength + 20 + keyLength + 20 + 4 + 20];
+
+			blob [0] = 0x07;	// Type - PRIVATEKEYBLOB (0x07)
+			blob [1] = 0x02;	// Version - Always CUR_BLOB_VERSION (0x02)
+			// [2], [3]		// RESERVED - Always 0
+			blob [5] = 0x22;	// ALGID
+			blob [8] = 0x44;	// Magic
+			blob [9] = 0x53;
+			blob [10] = 0x53;
+			blob [11] = 0x32;
+
+			byte[] bitlen = GetBytesLE (keyLength << 3);
+			blob [12] = bitlen [0];
+			blob [13] = bitlen [1];
+			blob [14] = bitlen [2];
+			blob [15] = bitlen [3];
+
+			int pos = 16;
+			byte[] part = p.P;
+			Array.Reverse (part);
+			Buffer.BlockCopy (part, 0, blob, pos, keyLength);
+			pos += keyLength;
+
+			part = p.Q;
+			Array.Reverse (part);
+			Buffer.BlockCopy (part, 0, blob, pos, 20);
+			pos += 20;
+
+			part = p.G;
+			Array.Reverse (part);
+			Buffer.BlockCopy (part, 0, blob, pos, keyLength);
+			pos += keyLength;
+
+			part = p.X;
+			Array.Reverse (part);
+			Buffer.BlockCopy (part, 0, blob, pos, 20);
+			pos += 20;
+
+			Buffer.BlockCopy (GetBytesLE (p.Counter), 0, blob, pos, 4);
+			pos += 4;
+
+			part = p.Seed;
+			Array.Reverse (part);
+			Buffer.BlockCopy (part, 0, blob, pos, 20);
+
+			return blob;
+		}
+
 		static public RSA FromCapiPublicKeyBlob (byte[] blob) 
 		{
 			return FromCapiPublicKeyBlob (blob, 0);
@@ -316,6 +432,70 @@
 			}
 		}
 
+		static public DSA FromCapiPublicKeyBlobDSA (byte[] blob)
+		{
+			return FromCapiPublicKeyBlobDSA (blob, 0);
+		}
+
+		static public DSA FromCapiPublicKeyBlobDSA (byte[] blob, int offset)
+		{
+			if (blob == null)
+				throw new ArgumentNullException ("blob");
+			if (offset >= blob.Length)
+				throw new ArgumentException ("blob is too small.");
+
+			try
+			{
+				if ((blob [offset] != 0x06) ||				// PUBLICKEYBLOB (0x06)
+				    (blob [offset + 1] != 0x02) ||			// Version (0x02)
+				    (blob [offset + 2] != 0x00) ||			// Reserved (word)
+				    (blob [offset + 3] != 0x00) ||
+				    (ToUInt32LE (blob, offset + 8) != 0x31535344))	// DWORD magic
+					throw new CryptographicException ("Invalid blob header");
+
+				int bitlen = ToInt32LE (blob, offset + 12);
+				DSAParameters dsap = new DSAParameters ();
+				int bytelen = bitlen >> 3;
+				int pos = offset + 16;
+
+				dsap.P = new byte [bytelen];
+				Buffer.BlockCopy (blob, pos, dsap.P, 0, bytelen);
+				Array.Reverse (dsap.P);
+				pos += bytelen;
+
+				dsap.Q = new byte [20];
+				Buffer.BlockCopy (blob, pos, dsap.Q, 0, 20);
+				Array.Reverse (dsap.Q);
+				pos += 20;
+
+				dsap.G = new byte [bytelen];
+				Buffer.BlockCopy (blob, pos, dsap.G, 0, bytelen);
+				Array.Reverse (dsap.G);
+				pos += bytelen;
+
+				dsap.Y = new byte [bytelen];
+				Buffer.BlockCopy (blob, pos, dsap.Y, 0, bytelen);
+				Array.Reverse (dsap.Y);
+				pos += bytelen;
+
+				dsap.Counter = ToInt32LE (blob, pos);
+				pos += 4;
+
+				dsap.Seed = new byte [20];
+				Buffer.BlockCopy (blob, pos, dsap.Seed, 0, 20);
+				Array.Reverse (dsap.Seed);
+				pos += 20;
+
+				DSA dsa = (DSA)DSA.Create ();
+				dsa.ImportParameters (dsap);
+				return dsa;
+			}
+			catch (Exception e)
+			{
+				throw new CryptographicException ("Invalid blob.", e);
+			}
+		}
+
 		static public byte[] ToCapiPublicKeyBlob (RSA rsa) 
 		{
 			RSAParameters p = rsa.ExportParameters (false);
@@ -352,6 +532,62 @@
 			return blob;
 		}
 
+		static public byte[] ToCapiPublicKeyBlob (DSA dsa)
+		{
+			DSAParameters p = dsa.ExportParameters (false);
+			int keyLength = p.P.Length; // in bytes
+
+			// header + P + Q + G + Y + count + seed
+			byte[] blob = new byte [16 + keyLength + 20 + keyLength + keyLength + 4 + 20];
+
+			blob [0] = 0x06;	// Type - PUBLICKEYBLOB (0x06)
+			blob [1] = 0x02;	// Version - Always CUR_BLOB_VERSION (0x02)
+			// [2], [3]		// RESERVED - Always 0
+			blob [5] = 0x22;	// ALGID
+			blob [8] = 0x44;	// Magic
+			blob [9] = 0x53;
+			blob [10] = 0x53;
+			blob [11] = 0x31;
+
+			byte[] bitlen = GetBytesLE (keyLength << 3);
+			blob [12] = bitlen [0];
+			blob [13] = bitlen [1];
+			blob [14] = bitlen [2];
+			blob [15] = bitlen [3];
+
+			int pos = 16;
+			byte[] part;
+
+			part = p.P;
+			Array.Reverse (part);
+			Buffer.BlockCopy (part, 0, blob, pos, keyLength);
+			pos += keyLength;
+
+			part = p.Q;
+			Array.Reverse (part);
+			Buffer.BlockCopy (part, 0, blob, pos, 20);
+			pos += 20;
+
+			part = p.G;
+			Array.Reverse (part);
+			Buffer.BlockCopy (part, 0, blob, pos, keyLength);
+			pos += keyLength;
+
+			part = p.Y;
+			Array.Reverse (part);
+			Buffer.BlockCopy (part, 0, blob, pos, keyLength);
+			pos += keyLength;
+
+			Buffer.BlockCopy (GetBytesLE (p.Counter), 0, blob, pos, 4);
+			pos += 4;
+
+			part = p.Seed;
+			Array.Reverse (part);
+			Buffer.BlockCopy (part, 0, blob, pos, 20);
+
+			return blob;
+		}
+
 		// PRIVATEKEYBLOB
 		// PUBLICKEYBLOB
 		static public RSA FromCapiKeyBlob (byte[] blob) 
@@ -382,6 +618,27 @@
 			throw new CryptographicException ("Unknown blob format.");
 		}
 
+		static public DSA FromCapiKeyBlobDSA (byte[] blob)
+		{
+			return FromCapiKeyBlobDSA (blob, 0);
+		}
+
+		static public DSA FromCapiKeyBlobDSA (byte[] blob, int offset)
+		{
+			if (blob == null)
+				throw new ArgumentNullException ("blob");
+			if (offset >= blob.Length)
+				throw new ArgumentException ("blob is too small.");
+
+			switch (blob [offset]) {
+				case 0x06:
+					return FromCapiPublicKeyBlobDSA (blob, offset);
+				case 0x07:
+					return FromCapiPrivateKeyBlobDSA (blob, offset);
+			}
+			throw new CryptographicException ("Unknown blob format.");
+		}
+
 		static public byte[] ToCapiKeyBlob (AsymmetricAlgorithm keypair, bool includePrivateKey) 
 		{
 			if (keypair == null)
@@ -390,6 +647,8 @@
 			// check between RSA and DSA (and potentially others like DH)
 			if (keypair is RSA)
 				return ToCapiKeyBlob ((RSA)keypair, includePrivateKey);
+			else if (keypair is DSA)
+				return ToCapiKeyBlob ((DSA)keypair, includePrivateKey);
 			else
 				return null;	// TODO
 		}
@@ -405,6 +664,17 @@
 				return ToCapiPublicKeyBlob (rsa);
 		}
 
+		static public byte[] ToCapiKeyBlob (DSA dsa, bool includePrivateKey)
+		{
+			if (dsa == null)
+				throw new ArgumentNullException ("dsa");
+
+			if (includePrivateKey)
+				return ToCapiPrivateKeyBlob (dsa);
+			else
+				return ToCapiPublicKeyBlob (dsa);
+		}
+
 		static public string ToHex (byte[] input) 
 		{
 			if (input == null)

Index: CryptoConvertTest.cs
===================================================================
--- CryptoConvertTest.cs	(revision 76876)
+++ CryptoConvertTest.cs	(working copy)
@@ -264,10 +264,10 @@
 			byte[] publicKey = CryptoConvert.ToCapiKeyBlob (rsa, false);
 			AssertEquals ("RSA-PublicKey", BitConverter.ToString (strongNamePublicKey, 12), BitConverter.ToString (publicKey));
 			
-			// TODO dsa (not implemented yet)
 			AsymmetricAlgorithm dsa = DSA.Create ();
-			AssertNull ("DSA-KeyPair", CryptoConvert.ToCapiKeyBlob (dsa, true));
-			AssertNull ("DSA-PublicKey", CryptoConvert.ToCapiKeyBlob (dsa, false));
+			dsa.FromXmlString (dsaKeyPairString);
+			AssertEquals ("DSA-KeyPair", dsaPrivBlob, CryptoConvert.ToCapiKeyBlob (dsa, true));
+			AssertEquals ("DSA-PublicKey", BitConverter.ToString (dsaPubBlob), BitConverter.ToString (CryptoConvert.ToCapiKeyBlob (dsa, false)));
 		}
 
 		[Test]
@@ -330,7 +330,233 @@
 			AssertEquals ("PublicKey-2", BitConverter.ToString (strongNamePublicKey, 12), BitConverter.ToString (publicKey));
 		}
 
+		/* DSA key tests */
+		static byte[] dsaPrivBlob = { 7, 2, 0, 0, 0, 34, 0, 0, 68, 83,
+			83, 50, 0, 4, 0, 0, 69, 144, 99, 249,
+			41, 174, 97, 185, 66, 236, 179, 197, 182, 101,
+			146, 165, 47, 36, 234, 199, 170, 99, 97, 8,
+			224, 141, 189, 97, 86, 96, 240, 53, 69, 135,
+			123, 169, 165, 64, 50, 51, 144, 131, 158, 151,
+			218, 224, 159, 194, 166, 107, 132, 201, 148, 74,
+			38, 62, 231, 221, 157, 216, 239, 66, 248, 68,
+			26, 23, 123, 253, 157, 123, 65, 199, 109, 138,
+			231, 217, 247, 170, 81, 51, 43, 252, 66, 210,
+			75, 127, 68, 147, 141, 213, 174, 251, 109, 152,
+			244, 113, 14, 194, 198, 222, 69, 157, 146, 154,
+			224, 158, 46, 181, 204, 251, 10, 124, 153, 26,
+			239, 105, 199, 53, 43, 51, 255, 118, 213, 58,
+			111, 212, 166, 235, 29, 143, 53, 193, 210, 7,
+			78, 198, 7, 3, 219, 0, 57, 81, 179, 46,
+			58, 180, 61, 222, 145, 109, 165, 23, 119, 162,
+			91, 55, 48, 230, 133, 54, 103, 58, 139, 99,
+			146, 149, 90, 197, 167, 60, 164, 35, 90, 168,
+			150, 138, 107, 17, 219, 191, 163, 4, 98, 13,
+			109, 98, 122, 178, 247, 46, 73, 124, 53, 228,
+			137, 21, 20, 45, 214, 217, 202, 51, 87, 45,
+			78, 190, 19, 209, 249, 13, 31, 88, 52, 108,
+			196, 110, 54, 19, 252, 189, 80, 216, 191, 222,
+			192, 10, 112, 231, 67, 104, 154, 205, 1, 172,
+			194, 226, 187, 60, 252, 104, 176, 27, 87, 244,
+			217, 166, 140, 245, 97, 187, 64, 188, 103, 129,
+			194, 56, 206, 61, 169, 66, 171, 49, 234, 206,
+			29, 141, 249, 110, 171, 127, 135, 23, 20, 58,
+			156, 16, 252, 185, 148, 20, 202, 87, 124, 160,
+			65, 169, 243, 32, 164, 19, 59, 58, 188, 109,
+			43, 1, 150, 0, 0, 0, 203, 217, 189, 181,
+			208, 230, 19, 165, 199, 206, 44, 204, 209, 156,
+			80, 26, 199, 66, 198, 13 };
+
+		static byte[] dsaPubBlob = { 6, 2, 0, 0, 0, 34, 0, 0, 68, 83,
+			83, 49, 0, 4, 0, 0, 69, 144, 99, 249,
+			41, 174, 97, 185, 66, 236, 179, 197, 182, 101,
+			146, 165, 47, 36, 234, 199, 170, 99, 97, 8,
+			224, 141, 189, 97, 86, 96, 240, 53, 69, 135,
+			123, 169, 165, 64, 50, 51, 144, 131, 158, 151,
+			218, 224, 159, 194, 166, 107, 132, 201, 148, 74,
+			38, 62, 231, 221, 157, 216, 239, 66, 248, 68,
+			26, 23, 123, 253, 157, 123, 65, 199, 109, 138,
+			231, 217, 247, 170, 81, 51, 43, 252, 66, 210,
+			75, 127, 68, 147, 141, 213, 174, 251, 109, 152,
+			244, 113, 14, 194, 198, 222, 69, 157, 146, 154,
+			224, 158, 46, 181, 204, 251, 10, 124, 153, 26,
+			239, 105, 199, 53, 43, 51, 255, 118, 213, 58,
+			111, 212, 166, 235, 29, 143, 53, 193, 210, 7,
+			78, 198, 7, 3, 219, 0, 57, 81, 179, 46,
+			58, 180, 61, 222, 145, 109, 165, 23, 119, 162,
+			91, 55, 48, 230, 133, 54, 103, 58, 139, 99,
+			146, 149, 90, 197, 167, 60, 164, 35, 90, 168,
+			150, 138, 107, 17, 219, 191, 163, 4, 98, 13,
+			109, 98, 122, 178, 247, 46, 73, 124, 53, 228,
+			137, 21, 20, 45, 214, 217, 202, 51, 87, 45,
+			78, 190, 19, 209, 249, 13, 31, 88, 52, 108,
+			196, 110, 54, 19, 252, 189, 80, 216, 191, 222,
+			192, 10, 112, 231, 67, 104, 154, 205, 1, 172,
+			194, 226, 187, 60, 252, 104, 176, 27, 87, 244,
+			217, 166, 140, 245, 97, 187, 64, 188, 103, 129,
+			194, 56, 206, 61, 169, 66, 171, 49, 234, 206,
+			29, 141, 249, 110, 171, 127, 135, 23, 20, 58,
+			156, 16, 185, 163, 1, 154, 216, 44, 43, 101,
+			67, 65, 35, 30, 70, 97, 44, 194, 46, 9,
+			182, 125, 162, 93, 231, 223, 50, 55, 14, 218,
+			93, 6, 176, 10, 195, 91, 83, 98, 73, 65,
+			88, 250, 7, 120, 0, 155, 35, 138, 54, 37,
+			80, 125, 44, 51, 25, 29, 198, 18, 107, 84,
+			60, 27, 227, 218, 32, 74, 62, 76, 222, 6,
+			76, 129, 254, 197, 53, 189, 4, 243, 203, 94,
+			73, 190, 102, 196, 88, 170, 17, 199, 119, 180,
+			205, 151, 184, 12, 168, 236, 81, 117, 49, 223,
+			204, 69, 50, 246, 230, 124, 57, 208, 75, 5,
+			178, 58, 7, 193, 224, 103, 60, 233, 2, 242,
+			82, 53, 252, 157, 202, 146, 231, 255, 250, 38,
+			150, 0, 0, 0, 203, 217, 189, 181, 208, 230,
+			19, 165, 199, 206, 44, 204, 209, 156, 80, 26,
+			199, 66, 198, 13 };
+
+		static string dsaKeyPairString = "<DSAKeyValue><P>66bUbzrVdv8zKzXHae8amXwK+8y1Lp7gmpKdRd7Gwg5x9Jht+67VjZNEf0vSQvwrM1Gq99nnim3HQXud/XsXGkT4Qu/Ynd3nPiZKlMmEa6bCn+Dal56DkDMyQKWpe4dFNfBgVmG9jeAIYWOqx+okL6WSZbbFs+xCuWGuKfljkEU=</P><Q>3j20Oi6zUTkA2wMHxk4H0sE1jx0=</Q><G>EJw6FBeHf6tu+Y0dzuoxq0KpPc44woFnvEC7YfWMptn0VxuwaPw8u+LCrAHNmmhD53AKwN6/2FC9/BM2bsRsNFgfDfnRE75OLVczytnWLRQVieQ1fEku97J6Ym0NYgSjv9sRa4qWqFojpDynxVqVkmOLOmc2heYwN1uidxelbZE=</G><Y>Jvr/55LKnfw1UvIC6Txn4MEHOrIFS9A5fOb2MkXM3zF1UeyoDLiXzbR3xxGqWMRmvkley/MEvTXF/oFMBt5MPkog2uMbPFRrEsYdGTMsfVAlNoojmwB4B/pYQUliU1vDCrAGXdoONzLf512ifbYJLsIsYUYeI0FDZSss2JoBo7k=</Y><Seed>DcZCxxpQnNHMLM7HpRPm0LW92cs=</Seed><PgenCounter>lg==</PgenCounter><X>ASttvDo7E6Qg86lBoHxXyhSUufw=</X></DSAKeyValue>";
+		static string dsaPubKeyString =  "<DSAKeyValue><P>66bUbzrVdv8zKzXHae8amXwK+8y1Lp7gmpKdRd7Gwg5x9Jht+67VjZNEf0vSQvwrM1Gq99nnim3HQXud/XsXGkT4Qu/Ynd3nPiZKlMmEa6bCn+Dal56DkDMyQKWpe4dFNfBgVmG9jeAIYWOqx+okL6WSZbbFs+xCuWGuKfljkEU=</P><Q>3j20Oi6zUTkA2wMHxk4H0sE1jx0=</Q><G>EJw6FBeHf6tu+Y0dzuoxq0KpPc44woFnvEC7YfWMptn0VxuwaPw8u+LCrAHNmmhD53AKwN6/2FC9/BM2bsRsNFgfDfnRE75OLVczytnWLRQVieQ1fEku97J6Ym0NYgSjv9sRa4qWqFojpDynxVqVkmOLOmc2heYwN1uidxelbZE=</G><Y>Jvr/55LKnfw1UvIC6Txn4MEHOrIFS9A5fOb2MkXM3zF1UeyoDLiXzbR3xxGqWMRmvkley/MEvTXF/oFMBt5MPkog2uMbPFRrEsYdGTMsfVAlNoojmwB4B/pYQUliU1vDCrAGXdoONzLf512ifbYJLsIsYUYeI0FDZSss2JoBo7k=</Y><Seed>DcZCxxpQnNHMLM7HpRPm0LW92cs=</Seed><PgenCounter>lg==</PgenCounter></DSAKeyValue>";
+
 		[Test]
+		public void FromCapiKeyBlobDSA ()
+		{
+			DSA dsa = CryptoConvert.FromCapiKeyBlobDSA (dsaPrivBlob);
+			AssertEquals ("KeyPair", dsaKeyPairString, dsa.ToXmlString (true));
+			AssertEquals ("PublicKey", dsaPubKeyString, dsa.ToXmlString (false));
+		}
+
+		[Test]
+		[ExpectedException (typeof (ArgumentNullException))]
+		public void FromCapiKeyBlobDSA_Null ()
+		{
+			DSA dsa = CryptoConvert.FromCapiKeyBlobDSA (null);
+		}
+
+		[Test]
+		[ExpectedException (typeof (ArgumentException))]
+		public void FromCapiKeyBlobDSA_InvalidOffset ()
+		{
+			DSA dsa = CryptoConvert.FromCapiKeyBlobDSA (new byte [0], 0);
+		}
+
+		[Test]
+		[ExpectedException (typeof (CryptographicException))]
+		public void FromCapiKeyBlobDSA_UnknownBlob ()
+		{
+			byte[] blob = new byte [334];
+			DSA dsa = CryptoConvert.FromCapiKeyBlobDSA (blob, 0);
+		}
+
+		[Test]
+		public void FromCapiPrivateKeyBlobDSA ()
+		{
+			DSA dsa = CryptoConvert.FromCapiPrivateKeyBlobDSA (dsaPrivBlob, 0);
+			AssertEquals ("KeyPair", dsaKeyPairString, dsa.ToXmlString (true));
+		}
+
+		[Test]
+		[ExpectedException (typeof (ArgumentNullException))]
+		public void FromCapiPrivateKeyBlobDSA_Null ()
+		{
+			DSA dsa = CryptoConvert.FromCapiPrivateKeyBlobDSA (null);
+		}
+
+		[Test]
+		[ExpectedException (typeof (ArgumentException))]
+		public void FromCapiPrivateKeyBlobDSA_InvalidOffset ()
+		{
+			DSA dsa = CryptoConvert.FromCapiPrivateKeyBlobDSA (new byte[0], 0);
+		}
+
+		[Test]
+		[ExpectedException (typeof (CryptographicException))]
+		public void FromCapiPrivateKeyBlobDSA_Invalid ()
+		{
+			byte[] blob = new byte[334];
+			DSA dsa = CryptoConvert.FromCapiPrivateKeyBlobDSA (blob, 0);
+		}
+
+		[Test]
+		public void FromCapiPublicKeyBlobDSA ()
+		{
+			DSA dsa = CryptoConvert.FromCapiPublicKeyBlobDSA (dsaPubBlob, 0);
+			AssertEquals ("PublicKey", dsaPubKeyString, dsa.ToXmlString (false));
+		}
+
+		[Test]
+		[ExpectedException (typeof (ArgumentNullException))]
+		public void FromCapiPublicKeyBlobDSA_Null ()
+		{
+			DSA dsa = CryptoConvert.FromCapiPublicKeyBlobDSA (null);
+		}
+
+		[Test]
+		[ExpectedException (typeof (ArgumentException))]
+		public void FromCapiPublicKeyBlobDSA_InvalidOffset ()
+		{
+			DSA dsa = CryptoConvert.FromCapiPublicKeyBlobDSA (new byte[0], 0);
+		}
+
+		[Test]
+		[ExpectedException (typeof (CryptographicException))]
+		public void FromCapiPublicKeyBlobDSA_Invalid ()
+		{
+			byte[] blob = new byte[400];
+			DSA dsa = CryptoConvert.FromCapiPublicKeyBlobDSA (blob, 0);
+		}
+
+		[Test]
+		public void ToCapiKeyBlob_DSA ()
+		{
+			DSA dsa = DSA.Create ();
+			dsa.FromXmlString (dsaKeyPairString);
+			byte[] keypair = CryptoConvert.ToCapiKeyBlob (dsa, true);
+			AssertEquals ("KeyPair", dsaPrivBlob, keypair);
+
+			byte[] pubkey = CryptoConvert.ToCapiKeyBlob (dsa, false);
+			AssertEquals ("PublicKey", BitConverter.ToString (dsaPubBlob), BitConverter.ToString (pubkey));
+		}
+
+		[Test]
+		[ExpectedException (typeof (ArgumentNullException))]
+		public void ToCapiKeyBlob_DSANull ()
+		{
+			DSA dsa = null;
+			CryptoConvert.ToCapiKeyBlob (dsa, false);
+		}
+
+		[Test]
+		public void ToCapiPrivateKeyBlob_DSA ()
+		{
+			DSA dsa = DSA.Create ();
+			dsa.FromXmlString (dsaKeyPairString);
+			byte[] keypair = CryptoConvert.ToCapiPrivateKeyBlob (dsa);
+			AssertEquals ("KeyPair", dsaPrivBlob, keypair);
+		}
+
+		[Test]
+		[ExpectedException (typeof (CryptographicException))]
+		public void ToCapiPrivateKeyBlob_PublicKeyOnly_DSA ()
+		{
+			DSA dsa = DSA.Create ();
+			dsa.FromXmlString (dsaPubKeyString);
+			byte[] pubkey = CryptoConvert.ToCapiPrivateKeyBlob (dsa);
+		}
+
+		[Test]
+		public void ToCapiPublicKeyBlob_DSA ()
+		{
+			DSA dsa = DSA.Create ();
+			// full keypair
+			dsa.FromXmlString (dsaKeyPairString);
+			byte[] pubkey = CryptoConvert.ToCapiPublicKeyBlob (dsa);
+			AssertEquals ("PublicKey-1", BitConverter.ToString (dsaPubBlob), BitConverter.ToString (pubkey));
+
+			// public key only
+			dsa.FromXmlString (dsaPubKeyString);
+			pubkey = CryptoConvert.ToCapiPublicKeyBlob (dsa);
+			AssertEquals ("PublicKey-2", BitConverter.ToString (dsaPubBlob), BitConverter.ToString (pubkey));
+		}
+
+		[Test]
 		public void FromHex () 
 		{
 			AssertNull ("FromHex(null)", CryptoConvert.FromHex (null));
