Index: mcs/class/System.Security/System.Security.Cryptography.Xml/SignedXml.cs
===================================================================
--- mcs/class/System.Security/System.Security.Cryptography.Xml/SignedXml.cs	(revision 137850)
+++ mcs/class/System.Security/System.Security.Cryptography.Xml/SignedXml.cs	(working copy)
@@ -595,17 +595,28 @@
 				return false;
 
 			byte[] actual = macAlg.ComputeHash (s);
-			// HMAC signature may be partial
+			// HMAC signature may be partial and specified by <HMACOutputLength>
 			if (m_signature.SignedInfo.SignatureLength != null) {
-				int length = actual.Length;
-				try {
-					// SignatureLength is in bits
-					length = (Int32.Parse (m_signature.SignedInfo.SignatureLength) >> 3);
-				}
-				catch {
-				}
+				int length = Int32.Parse (m_signature.SignedInfo.SignatureLength);
+				// we only support signatures with a multiple of 8 bits
+				// and the value must match the signature length
+				if ((length & 7) != 0)
+					throw new CryptographicException ("Signature length must be a multiple of 8 bits.");
 
-				if (length != actual.Length) {
+				// SignatureLength is in bits (and we works on bytes, only in multiple of 8 bits)
+				// and both values must match for a signature to be valid
+				length >>= 3;
+				if (length != m_signature.SignatureValue.Length)
+					throw new CryptographicException ("Invalid signature length.");
+
+				// is the length "big" enough to make the signature meaningful ? 
+				// we use a minimum of 80 bits (10 bytes) or half the HMAC normal output length
+				// e.g. HMACMD5 output 128 bits but our minimum is 80 bits (not 64 bits)
+				int minimum = Math.Max (10, actual.Length / 2);
+				if (length < minimum)
+					throw new CryptographicException ("HMAC signature is too small");
+
+				if (length < actual.Length) {
 					byte[] trunked = new byte [length];
 					Buffer.BlockCopy (actual, 0, trunked, 0, length);
 					actual = trunked;
