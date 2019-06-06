--- corlib/System.Reflection/AssemblyName.cs	2005-06-09 06:38:09.000000000 -0400
+++ corlib/System.Reflection/AssemblyName.cs	2005-08-30 13:45:08.000000000 -0400
@@ -102,7 +102,7 @@
 			codebase = si.GetString ("_CodeBase");
 			version = (Version)si.GetValue ("_Version", typeof (Version));
 			publicKey = (byte[])si.GetValue ("_PublicKey", typeof (byte[]));
-			keyToken = (byte[])si.GetValue ("_PublicToken", typeof (byte[]));
+			keyToken = (byte[])si.GetValue ("_PublicKeyToken", typeof (byte[]));
 			hashalg = (AssemblyHashAlgorithm)si.GetValue ("_HashAlgorithm", typeof (AssemblyHashAlgorithm));
 			keypair = (StrongNameKeyPair)si.GetValue ("_StrongNameKeyPair", typeof (StrongNameKeyPair));
 			versioncompat = (AssemblyVersionCompatibility)si.GetValue ("_VersionCompatibility", typeof (AssemblyVersionCompatibility));
@@ -265,7 +265,7 @@
 
 			info.AddValue ("_Name", name);
 			info.AddValue ("_PublicKey", publicKey);
-			info.AddValue ("_PublicToken", keyToken);
+			info.AddValue ("_PublicKeyToken", keyToken);
 			info.AddValue ("_CultureInfo", cultureinfo != null ? cultureinfo.LCID : -1);
 			info.AddValue ("_CodeBase", codebase);
 			info.AddValue ("_Version", Version);
