? novell-directory-csc-buildable.diff
Index: Novell.Directory.Ldap/LdapAttributeSet.cs
===================================================================
RCS file: /cvs/public/mcs/class/Novell.Directory.Ldap/Novell.Directory.Ldap/LdapAttributeSet.cs,v
retrieving revision 1.4
diff -u -r1.4 LdapAttributeSet.cs
--- Novell.Directory.Ldap/LdapAttributeSet.cs	24 Jun 2004 21:48:00 -0000	1.4
+++ Novell.Directory.Ldap/LdapAttributeSet.cs	8 Jul 2004 13:08:34 -0000
@@ -52,7 +52,7 @@
 	/// </seealso>
 	/// <seealso cref="LdapEntry">
 	/// </seealso>
-	public class LdapAttributeSet:SupportClass.AbstractSetSupport, System.ICloneable//, SupportClass.SetSupport
+	public class LdapAttributeSet:AbstractSetSupport, System.ICloneable//, SupportClass.SetSupport
 	{
 		/// <summary> Returns the number of attributes in this set.
 		/// 
Index: Novell.Directory.Ldap/SupportClass.cs
===================================================================
RCS file: /cvs/public/mcs/class/Novell.Directory.Ldap/Novell.Directory.Ldap/SupportClass.cs,v
retrieving revision 1.5
diff -u -r1.5 SupportClass.cs
--- Novell.Directory.Ldap/SupportClass.cs	24 Jun 2004 21:48:47 -0000	1.5
+++ Novell.Directory.Ldap/SupportClass.cs	8 Jul 2004 13:08:34 -0000
@@ -1631,15 +1631,6 @@
 		/// <summary>
 		/// This class manages different operation with collections.
 		/// </summary>
-		public class AbstractSetSupport : SetSupport
-		{
-			/// <summary>
-			/// The constructor with no parameters to create an abstract set.
-			/// </summary>
-			public AbstractSetSupport()
-			{
-			}
-		}
 
 
 		/*******************************/
@@ -2163,4 +2154,14 @@
 				return collection.GetEnumerator();
 		}
 
+	}
+
+	public class AbstractSetSupport : SupportClass.SetSupport
+	{
+		/// <summary>
+		/// The constructor with no parameters to create an abstract set.
+		/// </summary>
+		public AbstractSetSupport()
+		{
+		}
 	}
Index: Novell.Directory.Ldap.Utilclass/RespExtensionSet.cs
===================================================================
RCS file: /cvs/public/mcs/class/Novell.Directory.Ldap/Novell.Directory.Ldap.Utilclass/RespExtensionSet.cs,v
retrieving revision 1.1
diff -u -r1.1 RespExtensionSet.cs
--- Novell.Directory.Ldap.Utilclass/RespExtensionSet.cs	3 Mar 2004 07:57:07 -0000	1.1
+++ Novell.Directory.Ldap.Utilclass/RespExtensionSet.cs	8 Jul 2004 13:08:34 -0000
@@ -29,6 +29,7 @@
 // (C) 2003 Novell, Inc (http://www.novell.com)
 //
 using System;
+
 namespace Novell.Directory.Ldap.Utilclass
 {
 	
@@ -36,7 +37,7 @@
 	/// so that it can be used to maintain a list of currently
 	/// registered extended responses.
 	/// </summary>
-	public class RespExtensionSet:SupportClass.AbstractSetSupport
+	public class RespExtensionSet:AbstractSetSupport
 	{
 		/// <summary> Returns the number of extensions in this set.
 		/// 