Index: System.Threading/Mutex.cs
===================================================================
--- System.Threading/Mutex.cs	(revision 86457)
+++ System.Threading/Mutex.cs	(working copy)
@@ -108,6 +108,8 @@
 		public Mutex (bool initiallyOwned, string name, out bool createdNew, MutexSecurity mutexSecurity)
 		{
 			Handle = CreateMutex_internal (initiallyOwned, name, out createdNew);
+			if (mutexSecurity != null)
+				mutexSecurity.Attach (SafeWaitHandle);
 		}
 
 		public MutexSecurity GetAccessControl ()
@@ -162,7 +164,9 @@
 #if NET_2_0
 		public void SetAccessControl (MutexSecurity mutexSecurity)
 		{
-			throw new NotImplementedException ();
+			if (mutexSecurity == null)
+				throw new ArgumentNullException ("mutexSecurity");
+			mutexSecurity.Attach (SafeWaitHandle);
 		}
 #endif
 	}
Index: System.Threading/EventWaitHandle.cs
===================================================================
--- System.Threading/EventWaitHandle.cs	(revision 86457)
+++ System.Threading/EventWaitHandle.cs	(working copy)
@@ -38,6 +38,8 @@
 	[ComVisible (true)]
 	public class EventWaitHandle : WaitHandle
 	{
+		EventWaitHandleSecurity security;
+
 		private EventWaitHandle (IntPtr handle)
 		{
 			Handle = handle;
@@ -70,12 +72,15 @@
 					EventWaitHandleSecurity eventSecurity)
 		{
 			Handle = NativeEventCalls.CreateEvent_internal ((mode == EventResetMode.ManualReset), initialState, name, out createdNew);
+			if (eventSecurity != null)
+				eventSecurity.Attach (SafeWaitHandle);
+			this.security = eventSecurity;
 		}
 		
 		[MonoTODO]
 		public EventWaitHandleSecurity GetAccessControl ()
 		{
-			throw new NotImplementedException ();
+			return security;
 		}
 		
 		public static EventWaitHandle OpenExisting (string name)
@@ -125,7 +130,8 @@
 		[MonoTODO]
 		public void SetAccessControl (EventWaitHandleSecurity eventSecurity)
 		{
-			throw new NotImplementedException ();
+			this.security = eventSecurity;
+			security.Attach (SafeWaitHandle);
 		}
 	}
 }
Index: System.Security.AccessControl/FileSystemSecurity.cs
===================================================================
--- System.Security.AccessControl/FileSystemSecurity.cs	(revision 86457)
+++ System.Security.AccessControl/FileSystemSecurity.cs	(working copy)
@@ -29,6 +29,8 @@
 
 #if NET_2_0
 
+using System.IO;
+using System.Runtime.InteropServices;
 using System.Security.Principal;
 
 namespace System.Security.AccessControl {
@@ -45,6 +47,11 @@
 		{
 		}
 
+		internal void Initialize (string name)
+		{
+			Initialize (true, ResourceType.FileObject, null, name, AccessControlSections.All, null, null);
+		}
+
 		public override Type AccessRightType {
 			get { return typeof (FileSystemRights); }
 		}
Index: System.Security.AccessControl/DirectorySecurity.cs
===================================================================
--- System.Security.AccessControl/DirectorySecurity.cs	(revision 86457)
+++ System.Security.AccessControl/DirectorySecurity.cs	(working copy)
@@ -34,13 +34,11 @@
 		public DirectorySecurity ()
 			: base (true)
 		{
-			throw new PlatformNotSupportedException ();
 		}
 
 		public DirectorySecurity (string name, AccessControlSections includeSections)
 			: base (true, name, includeSections)
 		{
-			throw new PlatformNotSupportedException ();
 		}
 	}
 }
Index: System.Security.AccessControl/CommonObjectSecurity.cs
===================================================================
--- System.Security.AccessControl/CommonObjectSecurity.cs	(revision 86457)
+++ System.Security.AccessControl/CommonObjectSecurity.cs	(working copy)
@@ -45,11 +45,17 @@
 		
 		public AuthorizationRuleCollection GetAccessRules (bool includeExplicit, bool includeInherited, Type targetType)
 		{
+			if (Descriptor == null || Descriptor.DiscretionaryAcl == null)
+				return new AuthorizationRuleCollection (new AuthorizationRule [0]);
+
 			throw new NotImplementedException ();
 		}
 		
 		public AuthorizationRuleCollection GetAuditRules (bool includeExplicit, bool includeInherited, Type targetType)
 		{
+			if (Descriptor == null || Descriptor.SystemAcl == null)
+				return new AuthorizationRuleCollection (new AuthorizationRule [0]);
+
 			throw new NotImplementedException ();
 		}
 		
Index: System.Security.AccessControl/CommonSecurityDescriptor.cs
===================================================================
--- System.Security.AccessControl/CommonSecurityDescriptor.cs	(revision 86457)
+++ System.Security.AccessControl/CommonSecurityDescriptor.cs	(working copy)
@@ -70,8 +70,6 @@
 			this.group = group;
 			this.systemAcl = systemAcl;
 			this.discretionaryAcl = discretionaryAcl;
-			
-			throw new NotImplementedException ();
 		}
 		
 		public override ControlFlags ControlFlags
Index: System.Security.AccessControl/MutexSecurity.cs
===================================================================
--- System.Security.AccessControl/MutexSecurity.cs	(revision 86457)
+++ System.Security.AccessControl/MutexSecurity.cs	(working copy)
@@ -29,6 +29,7 @@
 
 #if NET_2_0
 
+using System.Runtime.InteropServices;
 using System.Security.Principal;
 
 namespace System.Security.AccessControl
@@ -36,14 +37,21 @@
 	public sealed class MutexSecurity : NativeObjectSecurity
 	{
 		public MutexSecurity ()
+			: base (false, ResourceType.KernelObject)
 		{
 		}
 
 		public MutexSecurity (string name,
 				      AccessControlSections includeSections)
+			: base (false, ResourceType.KernelObject, name, includeSections)
 		{
 		}
 		
+		internal void Attach (SafeHandle handle)
+		{
+			Initialize (false, ResourceType.KernelObject, handle, null, AccessControlSections.All, null, null);
+		}
+		
 		public override Type AccessRightType {
 			get { return typeof (MutexRights); }
 		}
Index: System.Security.AccessControl/ControlFlags.cs
===================================================================
--- System.Security.AccessControl/ControlFlags.cs	(revision 86457)
+++ System.Security.AccessControl/ControlFlags.cs	(working copy)
@@ -29,6 +29,7 @@
 #if NET_2_0
 
 namespace System.Security.AccessControl {
+	// SECURITY_DESCRIPTOR_CONTROL in Windows API.
 	[Flags]
 	public enum ControlFlags {
 		None					= 0x0000,
Index: System.Security.AccessControl/ObjectSecurity.cs
===================================================================
--- System.Security.AccessControl/ObjectSecurity.cs	(revision 86457)
+++ System.Security.AccessControl/ObjectSecurity.cs	(working copy)
@@ -36,11 +36,6 @@
 {
 	public abstract class ObjectSecurity
 	{
-		internal ObjectSecurity ()
-		{
-			/* Give it a 0-param constructor */
-		}
-		
 		protected ObjectSecurity (bool isContainer, bool isDS)
 		{
 			is_container = isContainer;
@@ -50,6 +45,7 @@
 		bool is_container, is_ds;
 		bool access_rules_modified, audit_rules_modified;
 		bool group_modified, owner_modified;
+		CommonSecurityDescriptor security_descriptor;
 
 		public abstract Type AccessRightType { get; }
 		
@@ -116,21 +112,28 @@
 			get { return owner_modified; }
 			set { owner_modified = value; }
 		}
-	
+
+		internal CommonSecurityDescriptor Descriptor {
+			get { return security_descriptor; }
+		}
+
 		public abstract AccessRule AccessRuleFactory (IdentityReference identityReference, int accessMask, bool isInherited, InheritanceFlags inheritanceFlags, PropagationFlags propagationFlags, AccessControlType type);
 		
 		public abstract AuditRule AuditRuleFactory (IdentityReference identityReference, int accessMask, bool isInherited, InheritanceFlags inheritanceFlags, PropagationFlags propagationFlags, AuditFlags flags);
-		
-		[MonoTODO]
+
+		internal void Initialize (CommonSecurityDescriptor sd)
+		{
+			security_descriptor = sd;
+		}
+
 		public IdentityReference GetGroup (Type targetType)
 		{
-			throw new NotImplementedException ();
+			return security_descriptor.Group;
 		}
 		
-		[MonoTODO]
 		public IdentityReference GetOwner (Type targetType)
 		{
-			throw new NotImplementedException ();
+			return security_descriptor.Owner;
 		}
 		
 		[MonoTODO]
@@ -192,13 +195,19 @@
 		[MonoTODO]
 		public void SetGroup (IdentityReference identity)
 		{
-			throw new NotImplementedException ();
+			if (identity == null)
+				throw new ArgumentNullException ("identity");
+			group_modified = true;
+			security_descriptor.Group = (SecurityIdentifier) identity.Translate (typeof (SecurityIdentifier));
 		}
 		
 		[MonoTODO]
 		public void SetOwner (IdentityReference identity)
 		{
-			throw new NotImplementedException ();
+			if (identity == null)
+				throw new ArgumentNullException ("identity");
+			owner_modified = true;
+			security_descriptor.Owner = (SecurityIdentifier) identity.Translate (typeof (SecurityIdentifier));
 		}
 		
 		[MonoTODO]
Index: System.Security.AccessControl/DiscretionaryAcl.cs
===================================================================
--- System.Security.AccessControl/DiscretionaryAcl.cs	(revision 86457)
+++ System.Security.AccessControl/DiscretionaryAcl.cs	(working copy)
@@ -56,6 +56,7 @@
 
 		RawAcl raw_acl;
 
+		[MonoTODO]
 		public void AddAccess (AccessControlType accessType,
 				       SecurityIdentifier sid, int accessMask,
 				       InheritanceFlags inheritanceFlags,
@@ -65,6 +66,7 @@
 			// CommonAce?
 		}
 		
+		[MonoTODO]
 		public void AddAccess (AccessControlType accessType,
 				       SecurityIdentifier sid, int accessMask,
 				       InheritanceFlags inheritanceFlags,
@@ -77,6 +79,7 @@
 			throw new NotImplementedException ();
 		}
 		
+		[MonoTODO]
 		public bool RemoveAccess (AccessControlType accessType,
 					  SecurityIdentifier sid,
 					  int accessMask,
@@ -86,6 +89,7 @@
 			throw new NotImplementedException ();
 		}
 		
+		[MonoTODO]
 		public bool RemoveAccess (AccessControlType accessType,
 					  SecurityIdentifier sid,
 					  int accessMask,
@@ -98,6 +102,7 @@
 			throw new NotImplementedException ();
 		}
 		
+		[MonoTODO]
 		public void RemoveAccessSpecific (AccessControlType accessType,
 						  SecurityIdentifier sid,
 						  int accessMask,
@@ -107,6 +112,7 @@
 			throw new NotImplementedException ();
 		}
 		
+		[MonoTODO]
 		public void RemoveAccessSpecific (AccessControlType accessType,
 						  SecurityIdentifier sid,
 						  int accessMask,
@@ -119,6 +125,7 @@
 			throw new NotImplementedException ();
 		}
 		
+		[MonoTODO]
 		public void SetAccess (AccessControlType accessType,
 				       SecurityIdentifier sid,
 				       int accessMask,
@@ -128,6 +135,7 @@
 			throw new NotImplementedException ();
 		}
 		
+		[MonoTODO]
 		public void SetAccess (AccessControlType accessType,
 				       SecurityIdentifier sid,
 				       int accessMask,
Index: System.Security.AccessControl/NativeObjectSecurity.cs
===================================================================
--- System.Security.AccessControl/NativeObjectSecurity.cs	(revision 86457)
+++ System.Security.AccessControl/NativeObjectSecurity.cs	(working copy)
@@ -1,10 +1,11 @@
 //
 // System.Security.AccessControl.NativeObjectSecurity implementation
 //
-// Author:
+// Authors:
 //	Dick Porter  <dick@ximian.com>
+//	Atsushi Enomoto  <atsushi@ximian.com>
 //
-// Copyright (C) 2005, 2006 Novell, Inc (http://www.novell.com)
+// Copyright (C) 2005-2007 Novell, Inc (http://www.novell.com)
 //
 // Permission is hereby granted, free of charge, to any person obtaining
 // a copy of this software and associated documentation files (the
@@ -29,22 +30,19 @@
 #if NET_2_0
 
 using System.Runtime.InteropServices;
+using System.Security.Principal;
 
 namespace System.Security.AccessControl {
 
 	public abstract class NativeObjectSecurity : CommonObjectSecurity {
 
 		protected internal delegate Exception ExceptionFromErrorCode (int errorCode, string name, SafeHandle handle, object context);
-		
-		internal NativeObjectSecurity ()
-			: base (false)
-		{
-			/* Give it a 0-param constructor */
-		}
-		
+
+		ExceptionFromErrorCode error_generator;
+
 		protected NativeObjectSecurity (bool isContainer,
 						ResourceType resourceType)
-			: base (isContainer)
+			: this (isContainer, resourceType, null, null)
 		{
 		}
 
@@ -52,15 +50,16 @@
 						ResourceType resourceType,
 						ExceptionFromErrorCode exceptionFromErrorCode,
 						object exceptionContext)
-			: this (isContainer, resourceType)
+			: base (isContainer)
 		{
+			// nothing to initialize.
 		}
 		
 		protected NativeObjectSecurity (bool isContainer,
 						ResourceType resourceType,
 						SafeHandle handle,
 						AccessControlSections includeSections)
-			: this (isContainer, resourceType)
+			: this (isContainer, resourceType, handle, includeSections, null, null)
 		{
 		}
 		
@@ -68,7 +67,7 @@
 						ResourceType resourceType,
 						string name,
 						AccessControlSections includeSections)
-			: this (isContainer, resourceType)
+			: this (isContainer, resourceType, name, includeSections, null, null)
 		{
 		}
 		
@@ -78,8 +77,10 @@
 						AccessControlSections includeSections,
 						ExceptionFromErrorCode exceptionFromErrorCode,
 						object exceptionContext)
-			: this (isContainer, resourceType, handle, includeSections)
+			: base (isContainer)
 		{
+			Initialize (false, resourceType, handle, null, includeSections, exceptionFromErrorCode, exceptionContext);
+			this.error_generator = exceptionFromErrorCode;
 		}
 		
 		protected NativeObjectSecurity (bool isContainer,
@@ -88,10 +89,36 @@
 						AccessControlSections includeSections,
 						ExceptionFromErrorCode exceptionFromErrorCode,
 						object exceptionContext)
-			: this (isContainer, resourceType, name, includeSections)
+			: base (isContainer)
 		{
+			Initialize (true, resourceType, null, name, includeSections, exceptionFromErrorCode, exceptionContext);
+			this.error_generator = exceptionFromErrorCode;
 		}
-		
+
+		internal void Initialize (bool isNamed, ResourceType resourceType,
+					  SafeHandle handle, string name,
+					  AccessControlSections includeSections,
+					  ExceptionFromErrorCode exceptionFromErrorCode,
+					  object exceptionContext)
+		{
+			if (AclMarshal.IsWindows)
+				Win32SecurityInfo (isNamed, resourceType, handle, name, includeSections, exceptionFromErrorCode, exceptionContext);
+			else if (AclMarshal.IsPosix)
+				throw new NotImplementedException ();
+			else
+				throw new PlatformNotSupportedException ();
+		}
+
+		void Win32SecurityInfo (bool isNamed, ResourceType resourceType,
+				        SafeHandle handle, string name,
+				        AccessControlSections includeSections,
+				        ExceptionFromErrorCode exceptionFromErrorCode,
+				        object exceptionContext)
+		{
+			CommonSecurityDescriptor sd = AclMarshal.GetSecurityDescriptor (IsContainer, IsDS, resourceType, isNamed, handle, name, includeSections, exceptionFromErrorCode, exceptionContext);
+			Initialize (sd);
+		}
+
 		protected override sealed void Persist (SafeHandle handle,
 							AccessControlSections includeSections)
 		{
Index: System.Security.AccessControl/SecurityInfos.cs
===================================================================
--- System.Security.AccessControl/SecurityInfos.cs	(revision 86457)
+++ System.Security.AccessControl/SecurityInfos.cs	(working copy)
@@ -29,6 +29,8 @@
 #if NET_2_0
 
 namespace System.Security.AccessControl {
+	// SECURITY_INFORMATION in Windows API.
+	// It exists in the public API, but is never used publicly.
 	[Flags]
 	public enum SecurityInfos {
 		Owner			= 0x1,
Index: System.Security.AccessControl/EventWaitHandleSecurity.cs
===================================================================
--- System.Security.AccessControl/EventWaitHandleSecurity.cs	(revision 86457)
+++ System.Security.AccessControl/EventWaitHandleSecurity.cs	(working copy)
@@ -29,6 +29,7 @@
 
 #if NET_2_0
 
+using System.Runtime.InteropServices;
 using System.Security.Principal;
 
 namespace System.Security.AccessControl
@@ -36,8 +37,8 @@
 	public sealed class EventWaitHandleSecurity : NativeObjectSecurity
 	{
 		public EventWaitHandleSecurity ()
+			: base (false, ResourceType.KernelObject)
 		{
-			throw new NotImplementedException ();
 		}
 
 		public override Type AccessRightType {
@@ -52,6 +53,11 @@
 			get { return typeof (EventWaitHandleAuditRule); }
 		}
 		
+		internal void Attach (SafeHandle handle)
+		{
+			Initialize (false, ResourceType.KernelObject, handle, null, AccessControlSections.All, null, null);
+		}
+
 		// AccessRule
 		
 		public override AccessRule AccessRuleFactory (IdentityReference identityReference, int accessMask, bool isInherited, InheritanceFlags inheritanceFlags, PropagationFlags propagationFlags, AccessControlType type)
Index: System.Security.AccessControl/AccessControlSections.cs
===================================================================
--- System.Security.AccessControl/AccessControlSections.cs	(revision 86457)
+++ System.Security.AccessControl/AccessControlSections.cs	(working copy)
@@ -29,7 +29,6 @@
 #if NET_2_0
 
 namespace System.Security.AccessControl {
-
 	[Flags]
 	public enum AccessControlSections {
 		None,
Index: System.Security.AccessControl/CryptoKeySecurity.cs
===================================================================
--- System.Security.AccessControl/CryptoKeySecurity.cs	(revision 86457)
+++ System.Security.AccessControl/CryptoKeySecurity.cs	(working copy)
@@ -40,11 +40,13 @@
 		
 		[MonoTODO]
 		public CryptoKeySecurity ()
+			: base (false, ResourceType.KernelObject)
 		{
 		}
 
 		[MonoTODO]
 		public CryptoKeySecurity (CommonSecurityDescriptor securityDescriptor)
+			: base (false, ResourceType.KernelObject)
 		{
 			this.securityDescriptor = securityDescriptor;
 		}
Index: System.Security.AccessControl/ResourceType.cs
===================================================================
--- System.Security.AccessControl/ResourceType.cs	(revision 86457)
+++ System.Security.AccessControl/ResourceType.cs	(working copy)
@@ -29,6 +29,7 @@
 #if NET_2_0
 
 namespace System.Security.AccessControl {
+	// SE_OBJECT_TYPE in Windows API
 	public enum ResourceType {
 		Unknown			= 0,
 		FileObject		= 1,
Index: System.Security.AccessControl/RegistrySecurity.cs
===================================================================
--- System.Security.AccessControl/RegistrySecurity.cs	(revision 86457)
+++ System.Security.AccessControl/RegistrySecurity.cs	(working copy)
@@ -34,6 +34,7 @@
 namespace System.Security.AccessControl {
 	public sealed class RegistrySecurity : NativeObjectSecurity {
 		public RegistrySecurity ()
+			: base (false, ResourceType.RegistryKey)
 		{
 		}
 		
@@ -49,68 +50,84 @@
 			get { return typeof (RegistryAuditRule); }
 		}
 		
+		// AccessRule
+		
+		[MonoTODO]
 		public override AccessRule AccessRuleFactory (IdentityReference identityReference, int accessMask, bool isInherited, InheritanceFlags inheritanceFlags, PropagationFlags propagationFlags, AccessControlType type)
 		{
 			// FIXME: isInherited is unused
 			return new RegistryAccessRule (identityReference, (RegistryRights) accessMask, inheritanceFlags, propagationFlags, type);
 		}
 		
+		[MonoTODO]
 		public void AddAccessRule (RegistryAccessRule rule)
 		{
 			throw new NotImplementedException ();
 		}
 		
-		public void AddAuditRule (RegistryAuditRule rule)
+		[MonoTODO]
+		public bool RemoveAccessRule (RegistryAccessRule rule)
 		{
 			throw new NotImplementedException ();
 		}
 		
-		public override AuditRule AuditRuleFactory (IdentityReference identityReference, int accessMask, bool isInherited, InheritanceFlags inheritanceFlags, PropagationFlags propagationFlags, AuditFlags flags)
+		[MonoTODO]
+		public void RemoveAccessRuleAll (RegistryAccessRule rule)
 		{
-			// FIXME: isInherited is unused
-			return new RegistryAuditRule (identityReference, (RegistryRights) accessMask, inheritanceFlags, propagationFlags, flags);
+			throw new NotImplementedException ();
 		}
 		
-		public bool RemoveAccessRule (RegistryAccessRule rule)
+		[MonoTODO]
+		public void RemoveAccessRuleSpecific (RegistryAccessRule rule)
 		{
 			throw new NotImplementedException ();
 		}
 		
-		public void RemoveAccessRuleAll (RegistryAccessRule rule)
+		[MonoTODO]
+		public void ResetAccessRule (RegistryAccessRule rule)
 		{
 			throw new NotImplementedException ();
 		}
 		
-		public void RemoveAccessRuleSpecific (RegistryAccessRule rule)
+		[MonoTODO]
+		public void SetAccessRule (RegistryAccessRule rule)
 		{
 			throw new NotImplementedException ();
 		}
 		
-		public bool RemoveAuditRule (RegistryAuditRule rule)
+		// AuditRule
+		
+		public override AuditRule AuditRuleFactory (IdentityReference identityReference, int accessMask, bool isInherited, InheritanceFlags inheritanceFlags, PropagationFlags propagationFlags, AuditFlags flags)
 		{
-			throw new NotImplementedException ();
+			// FIXME: isInherited is unused
+			return new RegistryAuditRule (identityReference, (RegistryRights) accessMask, inheritanceFlags, propagationFlags, flags);
 		}
 		
-		public void RemoveAuditRuleAll (RegistryAuditRule rule)
+		[MonoTODO]
+		public void AddAuditRule (RegistryAuditRule rule)
 		{
 			throw new NotImplementedException ();
 		}
 		
-		public void RemoveAuditRuleSpecific (RegistryAuditRule rule)
+		[MonoTODO]
+		public bool RemoveAuditRule (RegistryAuditRule rule)
 		{
 			throw new NotImplementedException ();
 		}
 		
-		public void ResetAccessRule (RegistryAccessRule rule)
+		[MonoTODO]
+		public void RemoveAuditRuleAll (RegistryAuditRule rule)
 		{
 			throw new NotImplementedException ();
 		}
 		
-		public void SetAccessRule (RegistryAccessRule rule)
+		[MonoTODO]
+		public void RemoveAuditRuleSpecific (RegistryAuditRule rule)
 		{
 			throw new NotImplementedException ();
 		}
 		
+		[MonoTODO]
 		public void SetAuditRule (RegistryAuditRule rule)
 		{
 			throw new NotImplementedException ();
Index: System.Security.AccessControl/AuthorizationRuleCollection.cs
===================================================================
--- System.Security.AccessControl/AuthorizationRuleCollection.cs	(revision 86457)
+++ System.Security.AccessControl/AuthorizationRuleCollection.cs	(working copy)
@@ -35,7 +35,7 @@
 {
 	public sealed class AuthorizationRuleCollection : ReadOnlyCollectionBase
 	{
-		private AuthorizationRuleCollection (AuthorizationRule [] rules)
+		internal AuthorizationRuleCollection (AuthorizationRule [] rules)
 		{
 			InnerList.AddRange (rules);
 		}
Index: System.Security.AccessControl/SystemAcl.cs
===================================================================
--- System.Security.AccessControl/SystemAcl.cs	(revision 86457)
+++ System.Security.AccessControl/SystemAcl.cs	(working copy)
@@ -53,15 +53,17 @@
 
 		RawAcl raw_acl;
 
+		[MonoTODO]
 		public void AddAudit (AuditFlags auditFlags,
 				      SecurityIdentifier sid, int accessMask,
 				      InheritanceFlags inheritanceFlags,
 				      PropagationFlags propagationFlags)
 		{
-			// CommonAce?
+			// AddAuditAccessAce(CommonAce)?
 			throw new NotImplementedException ();
 		}
 		
+		[MonoTODO]
 		public void AddAudit (AuditFlags auditFlags,
 				      SecurityIdentifier sid, int accessMask,
 				      InheritanceFlags inheritanceFlags,
@@ -70,10 +72,11 @@
 				      Guid objectType,
 				      Guid inheritedObjectType)
 		{
-			// ObjectAce?
+			// AddAuditAccessAce(ObjectAce)?
 			throw new NotImplementedException ();
 		}
 		
+		[MonoTODO]
 		public bool RemoveAudit (AuditFlags auditFlags,
 					 SecurityIdentifier sid,
 					 int accessMask,
@@ -83,6 +86,7 @@
 			throw new NotImplementedException ();
 		}
 		
+		[MonoTODO]
 		public bool RemoveAudit (AuditFlags auditFlags,
 					 SecurityIdentifier sid,
 					 int accessMask,
@@ -95,6 +99,7 @@
 			throw new NotImplementedException ();
 		}
 		
+		[MonoTODO]
 		public void RemoveAuditSpecific (AuditFlags auditFlags,
 						 SecurityIdentifier sid,
 						 int accessMask,
@@ -104,6 +109,7 @@
 			throw new NotImplementedException ();
 		}
 		
+		[MonoTODO]
 		public void RemoveAuditSpecific (AuditFlags auditFlags,
 						 SecurityIdentifier sid,
 						 int accessMask,
@@ -116,6 +122,7 @@
 			throw new NotImplementedException ();
 		}
 		
+		[MonoTODO]
 		public void SetAudit (AuditFlags auditFlags,
 				      SecurityIdentifier sid,
 				      int accessMask,
@@ -125,6 +132,7 @@
 			throw new NotImplementedException ();
 		}
 		
+		[MonoTODO]
 		public void SetAudit (AuditFlags auditFlags,
 				      SecurityIdentifier sid,
 				      int accessMask,
Index: System.Security.AccessControl/FileSecurity.cs
===================================================================
--- System.Security.AccessControl/FileSecurity.cs	(revision 86457)
+++ System.Security.AccessControl/FileSecurity.cs	(working copy)
@@ -1,10 +1,11 @@
 //
 // System.Security.AccessControl.FileSecurity implementation
 //
-// Author:
+// Authors:
 //	Dick Porter  <dick@ximian.com>
+//	Atsushi Enomoto  <atsushi@ximian.com>
 //
-// Copyright (C) 2006 Novell, Inc (http://www.novell.com)
+// Copyright (C) 2006-2007 Novell, Inc (http://www.novell.com)
 //
 // Permission is hereby granted, free of charge, to any person obtaining
 // a copy of this software and associated documentation files (the
@@ -28,19 +29,21 @@
 
 #if NET_2_0
 
-namespace System.Security.AccessControl {
-	public sealed class FileSecurity : FileSystemSecurity {
+namespace System.Security.AccessControl
+{
+	public sealed class FileSecurity : FileSystemSecurity
+	{
+		[MonoTODO]
 		public FileSecurity ()
 			: base (false)
 		{
-			throw new PlatformNotSupportedException ();
 		}
 
+		[MonoTODO]
 		public FileSecurity (string fileName,
 				     AccessControlSections includeSections)
 			: base (false, fileName, includeSections)
 		{
-			throw new PlatformNotSupportedException ();
 		}
 	}
 }
Index: System.Security.AccessControl/AclMarshal.cs
===================================================================
--- System.Security.AccessControl/AclMarshal.cs	(revision 0)
+++ System.Security.AccessControl/AclMarshal.cs	(revision 0)
@@ -0,0 +1,331 @@
+//
+// AclMarshal.cs
+//
+// Author:
+//	Atsushi Enomoto  <atsushi@ximian.com>
+//
+// Copyright (C) 2007 Novell, Inc (http://www.novell.com)
+//
+// Permission is hereby granted, free of charge, to any person obtaining
+// a copy of this software and associated documentation files (the
+// "Software"), to deal in the Software without restriction, including
+// without limitation the rights to use, copy, modify, merge, publish,
+// distribute, sublicense, and/or sell copies of the Software, and to
+// permit persons to whom the Software is furnished to do so, subject to
+// the following conditions:
+// 
+// The above copyright notice and this permission notice shall be
+// included in all copies or substantial portions of the Software.
+// 
+// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
+// LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
+// OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
+// WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+//
+
+#if NET_2_0
+
+using System;
+using System.Runtime.InteropServices;
+using System.Security.Principal;
+
+namespace System.Security.AccessControl
+{
+	internal static class AclMarshal
+	{
+		public static SecurityInfos ToSecurityInfos (AccessControlSections sections)
+		{
+			SecurityInfos ret = default (SecurityInfos);
+			if ((sections & AccessControlSections.Audit) != 0)
+				ret |= SecurityInfos.SystemAcl;
+			if ((sections & AccessControlSections.Access) != 0)
+				ret |= SecurityInfos.DiscretionaryAcl;
+			if ((sections & AccessControlSections.Owner) != 0)
+				ret |= SecurityInfos.Owner;
+			if ((sections & AccessControlSections.Group) != 0)
+				ret |= SecurityInfos.Group;
+			return ret;
+		}
+
+		public static CommonSecurityDescriptor GetSecurityDescriptor (
+			bool isContainer, bool isDS, ResourceType resourceType, bool isNamed, SafeHandle handle, string name,
+			AccessControlSections includeSections, 
+			NativeObjectSecurity.ExceptionFromErrorCode exceptionFromErrorCode,
+			object exceptionContext)
+		{
+			IntPtr owner, group, dAclPtr, sAclPtr, sd;
+			int error;
+			SecurityInfos infos = AclMarshal.ToSecurityInfos (includeSections);
+
+			// FIXME: disable once it is done
+			// FIXME: it is not working
+			if ((infos & SecurityInfos.SystemAcl) != 0)
+				//AclMarshal.EnableSecurityName ();
+				infos ^= SecurityInfos.SystemAcl;
+
+			if (isNamed)
+				error = AclMarshal.GetNamedSecurityInfo (name, resourceType, infos, out owner, out group, out dAclPtr, out sAclPtr, out sd);
+			else
+				error = AclMarshal.GetSecurityInfo (handle, resourceType, infos, out owner, out group, out dAclPtr, out sAclPtr, out sd);
+
+			if (error != 0) {
+				if (exceptionFromErrorCode != null)
+					throw exceptionFromErrorCode (error, name, null, exceptionContext);
+				else
+					throw new SystemException (String.Format ("Win32 error during attempt to retrieve ACL: {0}", error));
+			}
+
+			IntPtr ptr;
+			SecurityIdentifier groupIdent, ownerIdent;
+
+			AclMarshal.ConvertSidToStringSid (group, out ptr);
+			try {
+				string s = Marshal.PtrToStringUni (ptr);
+				groupIdent = new SecurityIdentifier (s);
+			} finally {
+				Marshal.FreeHGlobal (ptr);
+			}
+
+			AclMarshal.ConvertSidToStringSid (owner, out ptr);
+			try {
+				string s = Marshal.PtrToStringUni (ptr);
+				ownerIdent = new SecurityIdentifier (s);
+			} finally {
+				Marshal.FreeHGlobal (ptr);
+			}
+
+			// FIXME: implement
+			SystemAcl sacl = null;
+			GetExplicitAccessesFromAcl (sAclPtr);
+			DiscretionaryAcl dacl = null;
+			GetExplicitAccessesFromAcl (dAclPtr);
+
+			ControlFlags cf;
+			int revision;
+			AclMarshal.GetSecurityDescriptorControl (sd, out cf, out revision);
+
+			return new CommonSecurityDescriptor (isContainer, isDS, cf, ownerIdent, groupIdent, sacl, dacl);
+		}
+
+		static ExplicitAccess [] GetExplicitAccessesFromAcl (IntPtr acl)
+		{
+			if (acl == IntPtr.Zero)
+				return null;
+			int nEntries;
+			IntPtr entries;
+			if (GetExplicitEntriesFromAcl (acl, out nEntries, out entries) != 0)
+				throw new SystemException ("Failed at GetExplicitEntriesFromAcl");
+			int easize = Marshal.SizeOf (typeof (ExplicitAccess));
+			ExplicitAccess [] accesses = new ExplicitAccess [nEntries];
+			for (int i = 0; i < accesses.Length; i++)
+				accesses [i] = (ExplicitAccess) Marshal.PtrToStructure ((IntPtr) ((int) entries + i * easize), typeof (ExplicitAccess));
+
+			return accesses;
+		}
+
+		const string SecurityNamePrivilege = "SeSecurityPrivilege";
+		const int TokenAdjustPrivileges = 0x0020;
+		const int TokenQuery = 0x0008;
+		const int SecurityPrivilegeEnabled = 2;
+
+		// FIXME: it is still not working somehow.
+		static void EnableSecurityName ()
+		{
+			Luid luid;
+			IntPtr hToken;
+			IntPtr prevState; // dummy
+			int retLen; // dummy
+
+			if (!OpenProcessToken (GetCurrentProcess (),
+				TokenAdjustPrivileges | TokenQuery, out hToken))
+				throw new SystemException ("Failed to Open the process token");
+
+			if (!LookupPrivilegeValue (null, SecurityNamePrivilege, out luid))
+				throw new SystemException ("Failed at LookupPrivilegeValue");
+
+			TokenPrivileges tp = new TokenPrivileges (
+				new LuidAndAttributes (luid, SecurityPrivilegeEnabled));
+
+			IntPtr ptr = tp.ToGlobalHPtr ();
+			try {
+				if (AdjustTokenPrivileges (hToken, false, ptr, Marshal.SizeOf (tp), out prevState, out retLen) != 0)
+					throw new SystemException ("Failed at AdjustTokenPrivileges");
+			} finally {
+				Marshal.FreeHGlobal (ptr);
+			}
+		}
+
+		public static bool IsWindows {
+			get {
+				switch (Environment.OSVersion.Platform) {
+				case PlatformID.Unix:
+					return false;
+				default:
+					return true;
+				}
+			}
+		}
+
+		public static bool IsPosix {
+			get {
+				// FIXME: implement
+				return !IsWindows;
+			}
+		}
+
+		// Process.GetCurrentProcess().Handle is unavailable in mscorlib
+		[DllImport ("kernel32")]
+		static extern IntPtr GetCurrentProcess ();
+
+		[DllImport ("advapi32")]
+		static extern bool OpenProcessToken (IntPtr process, int flags, out IntPtr handleToken);
+
+		[DllImport ("advapi32")]
+		static extern bool LookupPrivilegeValue (string systemName, string name, out Luid luid);
+
+		[DllImport ("advapi32")]
+		static extern int AdjustTokenPrivileges (IntPtr handle, bool disableAllPrivileges, IntPtr newState, int bufferLength, out IntPtr prevState, out int returnLength);
+
+		[DllImport ("advapi32")]
+		static extern int GetNamedSecurityInfo (
+			string name, ResourceType objectType,
+			SecurityInfos securityInfo, out IntPtr owner,
+			out IntPtr group, out IntPtr dAcl, out IntPtr sAcl,
+			out IntPtr securityDescriptor);
+
+		[DllImport ("advapi32")]
+		static extern int GetSecurityInfo (
+			SafeHandle handle, ResourceType objectType,
+			SecurityInfos securityInfo, out IntPtr owner,
+			out IntPtr group, out IntPtr dAcl, out IntPtr sAcl,
+			out IntPtr securityDescriptor);
+
+		// I left output param as IntPtr as it must be freed
+		[DllImport ("advapi32")]
+		static extern int ConvertSidToStringSid (IntPtr sid, out IntPtr str);
+
+		[DllImport ("advapi32")]
+		static extern int GetSecurityDescriptorControl (IntPtr sd, out ControlFlags flags, out int revision);
+
+//		[DllImport ("advapi32")]
+//		static extern bool GetSecurityDescriptorDacl (IntPtr pSecurityDescriptor, out bool lpbDaclPresent, out IntPtr pDacl, out bool lpbDaclDefaulted);
+
+//		[DllImport ("advapi32")]
+//		static extern bool GetSecurityDescriptorSacl (IntPtr pSecurityDescriptor, out bool lpbSaclPresent, out IntPtr pSacl, out bool lpbSaclDefaulted);
+
+		[DllImport ("advapi32")]
+		static extern int GetExplicitEntriesFromAcl (IntPtr pacl, out int pcCountOfExplicitEntries, out IntPtr pListOfExplicitEntries);
+
+		[StructLayout (LayoutKind.Sequential)]
+		struct TokenPrivileges
+		{
+			public readonly int Count;
+			public readonly LuidAndAttributes [] Privileges;
+
+			public TokenPrivileges (params LuidAndAttributes [] array)
+			{
+				Count = array.Length;
+				Privileges = array;
+			}
+
+			public IntPtr ToGlobalHPtr ()
+			{
+				int size = Marshal.SizeOf (typeof (LuidAndAttributes));
+				int intSize = Marshal.SizeOf (typeof (int));
+				IntPtr ptr = Marshal.AllocHGlobal (intSize + size * Count);
+				Marshal.WriteInt32 (ptr, Count);
+				for (int i = 0; i < Count; i++) {
+					Marshal.WriteInt32 (ptr, intSize + i * size, Privileges [i].Luid.LowPart);
+					Marshal.WriteInt32 (ptr, intSize + i * size + 4, Privileges [i].Luid.HighPart);
+					Marshal.WriteInt32 (ptr, intSize + i * size + 8, Privileges [i].Attributes);
+				}
+				return ptr;
+			}
+		}
+
+		[StructLayout (LayoutKind.Sequential)]
+		struct LuidAndAttributes
+		{
+			public LuidAndAttributes (Luid luid, int attr)
+			{
+				Luid = luid;
+				Attributes = attr;
+			}
+
+			public readonly Luid Luid;
+			public readonly int Attributes;
+		}
+
+		[StructLayout (LayoutKind.Sequential)]
+		struct Luid
+		{
+			public int LowPart;
+			public int HighPart;
+		}
+
+		[StructLayout (LayoutKind.Sequential)]
+		struct Acl
+		{
+			public byte AclRevision;
+			public byte Sbz1;
+			public short AclSize;
+			public short AceCount;
+			public short Sbz2;
+		}
+
+		struct ExplicitAccess
+		{
+			public int AccessPermissions;
+			public AccessMode AccessMode;
+			public InheritanceFlags Inheritance;
+			public Trustee Trustee;
+		}
+
+		enum AccessMode
+		{
+			NOT_USED_ACCESS = 0,
+			GRANT_ACCESS,
+			SET_ACCESS,
+			DENY_ACCESS,
+			REVOKE_ACCESS,
+			SET_AUDIT_SUCCESS,
+			SET_AUDIT_FAILURE
+		}
+
+		struct Trustee
+		{
+			IntPtr pMultipleTrustee; // must be NULL
+			int MultipleTrusteeOperation; // must be NO_MULTIPLE_TRUSTEE
+			TrusteeForm TrusteeForm;
+			TrusteeType TrusteeType;
+			IntPtr TrusteeName;
+		}
+
+		enum TrusteeForm
+		{
+			Sid,
+			Name,
+			BadForm,
+			ObjectsAndSid,
+			ObjectsAndName
+		}
+
+		enum TrusteeType
+		{
+			TRUSTEE_IS_UNKNOWN,
+			TRUSTEE_IS_USER,
+			TRUSTEE_IS_GROUP,
+			TRUSTEE_IS_DOMAIN,
+			TRUSTEE_IS_ALIAS,
+			TRUSTEE_IS_WELL_KNOWN_GROUP,
+			TRUSTEE_IS_DELETED,
+			TRUSTEE_IS_INVALID,
+			TRUSTEE_IS_COMPUTER
+		}
+	}
+}
+
+#endif

Property changes on: System.Security.AccessControl/AclMarshal.cs
___________________________________________________________________
Name: svn:eol-style
   + native

Index: corlib.dll.sources
===================================================================
--- corlib.dll.sources	(revision 86457)
+++ corlib.dll.sources	(working copy)
@@ -1087,6 +1087,7 @@
 System.Security.AccessControl/AceFlags.cs
 System.Security.AccessControl/AceQualifier.cs
 System.Security.AccessControl/AceType.cs
+System.Security.AccessControl/AclMarshal.cs
 System.Security.AccessControl/AuditFlags.cs
 System.Security.AccessControl/AuditRule.cs
 System.Security.AccessControl/AuthorizationRule.cs
Index: corlib_test.dll.sources
===================================================================
--- corlib_test.dll.sources	(revision 86457)
+++ corlib_test.dll.sources	(working copy)
@@ -161,6 +161,7 @@
 System.Runtime.Versioning/VersioningHelperTest.cs
 System/SByteTest.cs
 System.Security/CodeAccessPermissionTest.cs
+System.Security.AccessControl/CommonSecurityDescriptorTest.cs
 System.Security.Cryptography/AllTests2.cs
 System.Security.Cryptography/AsymmetricAlgorithmTest.cs
 System.Security.Cryptography/CipherModeTest.cs
Index: Test/System.Security.AccessControl/CommonSecurityDescriptorTest.cs
===================================================================
--- Test/System.Security.AccessControl/CommonSecurityDescriptorTest.cs	(revision 0)
+++ Test/System.Security.AccessControl/CommonSecurityDescriptorTest.cs	(revision 0)
@@ -0,0 +1,70 @@
+//
+// CommonSecurityDescriptorTest.cs
+//
+// Author:
+//	Atsushi Enomoto  <atsushi@ximian.com>
+//
+// Copyright (C) 2007 Novell, Inc (http://www.novell.com)
+//
+// Permission is hereby granted, free of charge, to any person obtaining
+// a copy of this software and associated documentation files (the
+// "Software"), to deal in the Software without restriction, including
+// without limitation the rights to use, copy, modify, merge, publish,
+// distribute, sublicense, and/or sell copies of the Software, and to
+// permit persons to whom the Software is furnished to do so, subject to
+// the following conditions:
+// 
+// The above copyright notice and this permission notice shall be
+// included in all copies or substantial portions of the Software.
+// 
+// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
+// LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
+// OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
+// WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+//
+#if NET_2_0
+
+using System;
+using System.Security.AccessControl;
+using System.Security.Principal;
+using NUnit.Framework;
+
+namespace MonoTests.System.Security.AccessControl
+{
+	[TestFixture]
+	public class CommonSecurityDescriptorTest
+	{
+		public static bool Supported ()
+		{
+			switch (Environment.OSVersion.Platform) {
+			case PlatformID.Unix:
+				return false;
+			}
+			return true;
+		}
+
+		[Test]
+		[Category ("NotWorking")] // WindowsIdentity.Owner is missing
+		public void ConstructorNullSaclDacl ()
+		{
+			if (!Supported ())
+				return;
+			// null is allowed
+			WindowsIdentity ident = WindowsIdentity.GetCurrent ();
+			new CommonSecurityDescriptor (false, false, ControlFlags.None, ident.Owner, ident.User, null, null);
+		}
+
+		[Test]
+		public void ConstructorNullOwnerGroup ()
+		{
+			if (!Supported ())
+				return;
+			WindowsIdentity ident = WindowsIdentity.GetCurrent ();
+			new CommonSecurityDescriptor (false, false, ControlFlags.None, null, null, null, null);
+		}
+	}
+}
+#endif

Property changes on: Test/System.Security.AccessControl/CommonSecurityDescriptorTest.cs
___________________________________________________________________
Name: svn:eol-style
   + native

Index: System.IO/Directory.cs
===================================================================
--- System.IO/Directory.cs	(revision 86457)
+++ System.IO/Directory.cs	(working copy)
@@ -96,7 +96,10 @@
 		[MonoTODO ("DirectorySecurity not implemented")]
 		public static DirectoryInfo CreateDirectory (string path, DirectorySecurity directorySecurity)
 		{
-			return(CreateDirectory (path));
+			DirectoryInfo info = CreateDirectory (path);
+			if (directorySecurity != null)
+				SetAccessControl (path, directorySecurity);
+			return info;
 		}
 #endif
 
@@ -410,7 +413,11 @@
 #if NET_2_0
 		public static void SetAccessControl (string path, DirectorySecurity directorySecurity)
 		{
-			throw new NotImplementedException ();
+			if (path == null)
+				throw new ArgumentNullException ("path");
+			if (directorySecurity == null)
+				throw new ArgumentNullException ("directorySecurity");
+			directorySecurity.Initialize (path);
 		}
 #endif
 
@@ -533,13 +540,13 @@
 		[MonoNotSupported ("DirectorySecurity isn't implemented")]
 		public static DirectorySecurity GetAccessControl (string path, AccessControlSections includeSections)
 		{
-			throw new PlatformNotSupportedException ();
+			return new DirectorySecurity (path, includeSections);
 		}
 
 		[MonoNotSupported ("DirectorySecurity isn't implemented")]
 		public static DirectorySecurity GetAccessControl (string path)
 		{
-			throw new PlatformNotSupportedException ();
+			return GetAccessControl (path, AccessControlSections.All);
 		}
 #endif
 	}