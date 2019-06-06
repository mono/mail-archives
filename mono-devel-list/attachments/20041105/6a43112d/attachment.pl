--- AppDomain-1.0.4.cs	2004-10-27 19:42:23.000000000 +0200
+++ AppDomain-1.0.4-patched.cs	2004-11-05 09:51:58.586710400 +0100
@@ -611,8 +611,16 @@
 			if (friendlyName == null)
 				throw new System.ArgumentNullException ("friendlyName");
 
-			if (info == null)
-				throw new ArgumentNullException ("info");
+			if (info == null) {
+				// if null, get default domain's SetupInformation
+				AppDomain def = AppDomain.DefaultDomain;
+				if (def == null)
+					info = new AppDomainSetup ();	// we're default!
+				else
+					info = def.SetupInformation;
+			}
+			else
+				info = new AppDomainSetup (info);	// copy
 
 			// todo: allow setup in the other domain
 
