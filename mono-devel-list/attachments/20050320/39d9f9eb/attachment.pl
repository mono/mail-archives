Index: DirectoryEntries.cs
===================================================================
--- DirectoryEntries.cs	(revision 41947)
+++ DirectoryEntries.cs	(working copy)
@@ -199,7 +199,6 @@
 			LdapUrl curl=new LdapUrl(Burl.Host,Burl.Port,eFdn);
 			ent.Path=curl.ToString();
 			ent.Nflag = true;
-			ent.Properties["objectclass"].Add(schemaClassName);
 			return ent;
 		}
 
