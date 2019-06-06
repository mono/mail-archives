Index: ResourceManager.cs
===================================================================
RCS file: /cvs/public/mcs/class/corlib/System.Resources/ResourceManager.cs,v
retrieving revision 1.16
diff -u -r1.16 ResourceManager.cs
--- ResourceManager.cs	14 Aug 2002 10:29:20 -0000	1.16
+++ ResourceManager.cs	16 Apr 2003 14:22:43 -0000
@@ -263,8 +263,12 @@
 				if(stream==null) {
 					/* Try a satellite assembly */
 					Version sat_version=GetSatelliteContractVersion(MainAssembly);
-					Assembly a=MainAssembly.GetSatelliteAssembly(culture, sat_version);
-					stream=a.GetManifestResourceStream(filename);
+					try {
+						Assembly a=MainAssembly.GetSatelliteAssembly(culture, sat_version);
+						stream = a.GetManifestResourceStream(filename);
+					}
+					catch ( Exception ex ) {
+					}
 				}
 
 				if(stream!=null && Createifnotexists==true) {
@@ -277,7 +281,7 @@
 					 * just let someone else deal
 					 * with it?
 					 */
-					set=(ResourceSet)Activator.CreateInstance(resourceSetType, args);
+					set= new ResourceSet ( stream ) /*Activator.CreateInstance(resourceSetType, args)*/;
 				}
 			} else if(resourceDir != null) {
 				/* File resources */
