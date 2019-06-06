Index: class/corlib/Mono.Security.Cryptography/CryptoTools.cs
===================================================================
--- class/corlib/Mono.Security.Cryptography/CryptoTools.cs	(revision 101257)
+++ class/corlib/Mono.Security.Cryptography/CryptoTools.cs	(working copy)
@@ -133,7 +133,7 @@
 				// 4. if data is still present fill the "block" with the remainder
 				blockCount = cb - n;
 				if (blockCount > 0)
-					Buffer.BlockCopy (rgb, n, block, 0, blockCount);
+					Buffer.BlockCopy (rgb, n + ib, block, 0, blockCount);
 			}
 		}
 	
Index: class/corlib/Test/System.Security.Cryptography/HMACSHA1Test.cs
===================================================================
--- class/corlib/Test/System.Security.Cryptography/HMACSHA1Test.cs	(revision 101257)
+++ class/corlib/Test/System.Security.Cryptography/HMACSHA1Test.cs	(working copy)
@@ -121,6 +121,7 @@
 		CheckC (testName, key, data, result);
 		CheckD (testName, key, data, result);
 		CheckE (testName, key, data, result);
+		CheckF (testName, key, data, result);
 	}
 
 	public void CheckA (string testName, byte[] key, byte[] data, byte[] result) 
@@ -175,6 +176,16 @@
 		Assert.AreEqual (result, algo.Hash, testName + "e");
 	}
 
+	public void CheckF (string testName, byte[] key, byte[] data, byte[] result)
+	{
+		algo = new HMACSHA1 (key);
+		byte[] temp = new byte[data.Length + 2];
+		for (int i = 0; i < data.Length; i ++)
+			temp[i + 1] = data[i];
+		byte[] hmac = algo.ComputeHash (temp, 1, data.Length);
+		Assert.AreEqual (result, hmac, testName + "f");
+	}
+
 	[Test]
 	public void FIPS198_A1 () 
 	{