Index: LdapModifyDNRequest.cs
===================================================================
--- LdapModifyDNRequest.cs	(revision 42505)
+++ LdapModifyDNRequest.cs	(working copy)
@@ -139,7 +139,7 @@
 		/// <param name="cont">           Any controls that apply to the modifyDN request,
 		/// or null if none.
 		/// </param>
-		public LdapModifyDNRequest(System.String dn, System.String newRdn, System.String newParentdn, bool deleteOldRdn, LdapControl[] cont):base(LdapMessage.MODIFY_RDN_REQUEST, new RfcModifyDNRequest(new RfcLdapDN(dn), new RfcRelativeLdapDN(newRdn), new Asn1Boolean(deleteOldRdn), ((System.Object) newParentdn != null)?new RfcLdapDN(newParentdn):null), cont)
+		public LdapModifyDNRequest(System.String dn, System.String newRdn, System.String newParentdn, bool deleteOldRdn, LdapControl[] cont):base(LdapMessage.MODIFY_RDN_REQUEST, new RfcModifyDNRequest(new RfcLdapDN(dn), new RfcRelativeLdapDN(newRdn), new Asn1Boolean(deleteOldRdn), ((System.Object) newParentdn != null)?new RfcLdapSuperDN(newParentdn):null), cont)
 		{
 			return ;
 		}
