? class/System/System.ComponentModel.Design/RuntimeLicenseContext.cs
? class/System/Test/System.ComponentModel/LicenseManagerTests.cs
Index: class/System/ChangeLog
===================================================================
RCS file: /mono/mcs/class/System/ChangeLog,v
retrieving revision 1.68
diff -u -r1.68 ChangeLog
--- class/System/ChangeLog	11 Mar 2004 15:50:40 -0000	1.68
+++ class/System/ChangeLog	12 Mar 2004 06:09:49 -0000
@@ -1,3 +1,8 @@
+2004-03-11  Ivan Hamilton <ivan@chimerical.com.au>
+
+	* System.dll.sources: Added System/System.ComponentModel.Design/RuntimeLicenseContext.cs
+	* System_test.dll.sources : Added System.ComponentModel/LicenseManagerTests.cs
+
 2004-03-11  Zoltan Varga  <vargaz@freemail.hu>
 
 	* Makefile (all-local): Fix for non-bash shells.
Index: class/System/System.dll.sources
===================================================================
RCS file: /mono/mcs/class/System/System.dll.sources,v
retrieving revision 1.15
diff -u -r1.15 System.dll.sources
--- class/System/System.dll.sources	26 Feb 2004 18:50:37 -0000	1.15
+++ class/System/System.dll.sources	12 Mar 2004 06:09:50 -0000
@@ -294,6 +294,7 @@
 System.ComponentModel.Design/ITypeDescriptorFilterService.cs
 System.ComponentModel.Design/ITypeResolutionService.cs
 System.ComponentModel.Design/MenuCommand.cs
+System.ComponentModel.Design/RuntimeLicenseContext.cs
 System.ComponentModel.Design/SelectionTypes.cs
 System.ComponentModel.Design/ServiceContainer.cs
 System.ComponentModel.Design/ServiceCreatorCallback.cs
Index: class/System/System_test.dll.sources
===================================================================
RCS file: /mono/mcs/class/System/System_test.dll.sources,v
retrieving revision 1.10
diff -u -r1.10 System_test.dll.sources
--- class/System/System_test.dll.sources	21 Jan 2004 14:18:22 -0000	1.10
+++ class/System/System_test.dll.sources	12 Mar 2004 06:09:50 -0000
@@ -16,6 +16,7 @@
 System.Collections.Specialized/NameValueCollectionTest.cs
 System.Collections.Specialized/StringCollectionTest.cs
 System.ComponentModel/EventHandlerListTests.cs
+System.ComponentModel/LicenseManagerTests.cs
 System.ComponentModel.Design/ServiceContainerTest.cs
 System.Diagnostics/TraceTest.cs
 System.Diagnostics/SwitchesTest.cs
Index: class/System/System.ComponentModel/ChangeLog
===================================================================
RCS file: /mono/mcs/class/System/System.ComponentModel/ChangeLog,v
retrieving revision 1.86
diff -u -r1.86 ChangeLog
--- class/System/System.ComponentModel/ChangeLog	10 Dec 2003 16:49:33 -0000	1.86
+++ class/System/System.ComponentModel/ChangeLog	12 Mar 2004 06:09:50 -0000
@@ -1,3 +1,6 @@
+2004-03-08  Ivan Hamilton <ivan@chimerical.com.au>
+	* LicenseManager.cs: Implemented
+
 2003-12-10  Gonzalo Paniagua Javier <gonzalo@ximian.com>
 
 	* Win32Exception.cs: use a switch instead of creating a hashtable when
Index: class/System/System.ComponentModel/LicenseManager.cs
===================================================================
RCS file: /mono/mcs/class/System/System.ComponentModel/LicenseManager.cs,v
retrieving revision 1.2
diff -u -r1.2 LicenseManager.cs
--- class/System/System.ComponentModel/LicenseManager.cs	5 Jul 2003 12:57:43 -0000	1.2
+++ class/System/System.ComponentModel/LicenseManager.cs	12 Mar 2004 06:09:50 -0000
@@ -2,9 +2,11 @@
 // System.ComponentModel.LicenseManager.cs
 //
 // Authors:
+//   Ivan Hamilton (ivan@chimerical.com.au)
 //   Martin Willemoes Hansen (mwh@sysrq.dk)
 //   Andreas Nahr (ClassDevelopment@A-SoftTech.com)
 //
+// (C) 2004 Ivan Hamilton
 // (C) 2003 Martin Willemoes Hansen
 // (C) 2003 Andreas Nahr
 //
@@ -14,6 +16,7 @@
 	public sealed class LicenseManager
 	{
 		private static LicenseContext mycontext = null;
+		private static object contextLockUser = null;
 
 		private LicenseManager ()
 		{
@@ -21,24 +24,27 @@
 
 		public static LicenseContext CurrentContext {
 			get {
-				lock (mycontext) {
+				lock (typeof(LicenseManager)) {
+					//Tests indicate a System.ComponentModel.Design.RuntimeLicenseContext should be returned.
+					if  (mycontext==null)
+						mycontext = new Design.RuntimeLicenseContext();
 					return mycontext;
 				}
 			} 
 			set { 
-				lock (mycontext) {
-					mycontext = value;
+				lock (typeof(LicenseManager)) {
+					if (contextLockUser==null) {
+						mycontext = value;
+					} else {
+						throw new InvalidOperationException("The CurrentContext property of the LicenseManager is currently locked and cannot be changed.");
+					}
 				}
 			}
 		}
 
 		public static LicenseUsageMode UsageMode {
-			get { 
-				lock (mycontext) 
-				{
-					return mycontext.UsageMode;
-
-				}
+			get {
+				return CurrentContext.UsageMode;
 			}
 		}
 
@@ -48,55 +54,135 @@
 			return CreateWithContext (type, creationContext, new object[0]);
 		}
 
-		[MonoTODO]
 		public static object CreateWithContext (Type type, 
 							LicenseContext creationContext, 
 							object[] args)
 		{
-			throw new NotImplementedException();
+			object newObject = null;
+			lock (typeof(LicenseManager)) {
+				object lockObject=new object();
+				LicenseContext oldContext=CurrentContext;
+				CurrentContext=creationContext;
+				LockContext(lockObject);
+				try {
+					newObject = Activator.CreateInstance(type, args);
+				} catch (Reflection.TargetInvocationException exception) {
+					throw exception.InnerException;
+				} finally {
+					UnlockContext(lockObject);
+					CurrentContext=oldContext;
+				}
+			}
+			return newObject;
 		}
 
-		[MonoTODO]
 		public static bool IsLicensed (Type type)
 		{
-			throw new NotImplementedException();
+			License license=null;
+			if (!privateGetLicense(type, null, false, out license)) {
+				return false;
+			} else {
+				if (license!=null)
+					license.Dispose();
+				return true;
+			}
 		}
 
-		[MonoTODO]
 		public static bool IsValid (Type type)
+		//This method does not throw a LicenseException when it cannot grant a valid License
 		{
-			throw new NotImplementedException();
+			License license=null;
+			if (!privateGetLicense(type, null, false, out license)) {
+				return false;
+			} else {
+				if (license!=null)
+					license.Dispose();
+				return true;
+			}
 		}
 
-		[MonoTODO]
 		public static bool IsValid (Type type, object instance, 
 					    out License license)
+		//This method does not throw a LicenseException when it cannot grant a valid License
 		{
-			throw new NotImplementedException();
+			return privateGetLicense(type, null, false, out license);
 		}
 
-		[MonoTODO]
 		public static void LockContext (object contextUser)
 		{
-			throw new NotImplementedException();
+			lock (typeof(LicenseManager)) {
+				contextLockUser=contextUser;
+			}
 		}
 
-		[MonoTODO]
 		public static void UnlockContext (object contextUser)
 		{
-			throw new NotImplementedException();
+			lock (typeof(LicenseManager)) {
+				//Ignore if we're not locked
+				if (contextLockUser==null)
+					return;
+				//Don't unlock if not locking user
+				if (contextLockUser!=contextUser)
+					throw new ArgumentException("The CurrentContext property of the LicenseManager can only be unlocked with the same contextUser.");
+				//Remove lock
+				contextLockUser=null;
+			}
 		}
 
-		[MonoTODO]
 		public static void Validate (Type type)
+		// Throws a  LicenseException if the type is licensed, but a License could not be granted. 
 		{
-			throw new NotImplementedException();
+			License license=null;
+			if (!privateGetLicense(type, null, true, out license))
+				throw new LicenseException(type, null);
+			if (license!=null)
+				license.Dispose();
 		}
 
-		[MonoTODO]
 		public static License Validate (Type type, object instance)
+		// Throws a  LicenseException if the type is licensed, but a License could not be granted. 
 		{
-			throw new NotImplementedException();
+			License license=null;
+			if (!privateGetLicense(type, instance, true, out license))
+				throw new LicenseException(type, instance);
+			return license;
+		}
+
+		private static bool privateGetLicense (Type type, object instance, bool allowExceptions, out License license) 
+		//Returns if a component is licensed, and the license if provided
+		{
+			bool isLicensed=false;
+			License foundLicense=null;
+			//Get the LicProc Attrib for our type
+			LicenseProviderAttribute licenseproviderattribute = (LicenseProviderAttribute) Attribute.GetCustomAttribute(type, typeof(LicenseProviderAttribute), true);
+			//Check it's got an attrib
+			if (licenseproviderattribute != null) {
+				Type licenseprovidertype = licenseproviderattribute.LicenseProvider;
+				//Check the attrib has a type
+				if (licenseprovidertype!=null) {
+					//Create the provider
+					LicenseProvider licenseprovider = (LicenseProvider) Activator.CreateInstance(licenseprovidertype);
+					//Check we've got the provider
+					if (licenseprovider!=null) {
+						//Call provider, throw an LicenseException if error.
+						foundLicense=licenseprovider.GetLicense(CurrentContext, type, instance, allowExceptions);
+						if (foundLicense!=null)
+							isLicensed=true;
+						//licenseprovider.Dispose();
+					} else {
+						//There is was some problem creating the provider
+					}
+					//licenseprovidertype.Dispose();
+				} else {
+					//licenseprovidertype is null
+				}
+				//licenseproviderattribute.Dispose();
+			} else {
+				//Didn't have a LicenseProviderAttribute, so it's licensed
+				isLicensed=true;
+			}
+			license=foundLicense;
+			return isLicensed;
 		}
 	}
 }
Index: class/System/System.ComponentModel.Design/Changelog
===================================================================
RCS file: /mono/mcs/class/System/System.ComponentModel.Design/Changelog,v
retrieving revision 1.6
diff -u -r1.6 Changelog
--- class/System/System.ComponentModel.Design/Changelog	31 Aug 2003 23:35:51 -0000	1.6
+++ class/System/System.ComponentModel.Design/Changelog	12 Mar 2004 06:09:50 -0000
@@ -1,3 +1,6 @@
+2004-03-07  Ivan Hamilton <ivan@chimerical.com.au>
+	* RuntimeLicenseContext.cs: Added
+
 2003-08-31  Alexandre Pigolkine <pigolkine@gmx.de>
 	* ServiceContainer.cs		implemented
 
Index: class/System/Test/System.ComponentModel/ChangeLog
===================================================================
RCS file: /mono/mcs/class/System/Test/System.ComponentModel/ChangeLog,v
retrieving revision 1.2
diff -u -r1.2 ChangeLog
--- class/System/Test/System.ComponentModel/ChangeLog	30 Oct 2002 15:13:51 -0000	1.2
+++ class/System/Test/System.ComponentModel/ChangeLog	12 Mar 2004 06:09:50 -0000
@@ -1,3 +1,7 @@
+2004-03-08  Ivan Hamilton <ivan@chimerical.com.au>
+
+        * LicenseManagerTests.cs: new test
+
 2002-10-30  Gonzalo Paniagua Javier <gonzalo@ximian.com>
 
 	* AllTests.cs:
