Index: RfcModifyDNRequest.cs
===================================================================
--- RfcModifyDNRequest.cs	(revision 42306)
+++ RfcModifyDNRequest.cs	(working copy)
@@ -52,6 +52,16 @@
 		//*************************************************************************
 		// Constructors for ModifyDNRequest
 		//*************************************************************************
+
+		// according to RFC 2251 :
+		// ModifyDNRequest ::= [APPLICATION 12] SEQUENCE {
+		//   entry           LDAPDN,
+		//   newrdn          RelativeLDAPDN,
+		//   deleteoldrdn    BOOLEAN,
+		//   newSuperior     [0] LDAPDN OPTIONAL
+		// }
+		// i.e. newSuperior is a context-specific 0.
+		static readonly Asn1Identifier superiorId = new Asn1Identifier(Asn1Identifier.CONTEXT,false,0x0);
 		
 		/// <summary> </summary>
 		public RfcModifyDNRequest(RfcLdapDN entry, RfcRelativeLdapDN newrdn, Asn1Boolean deleteoldrdn):this(entry, newrdn, deleteoldrdn, null)
@@ -64,8 +74,10 @@
 			add(entry);
 			add(newrdn);
 			add(deleteoldrdn);
-			if (newSuperior != null)
+			if (newSuperior != null) {
+				newSuperior.setIdentifier(superiorId);
 				add(newSuperior);
+			}
 		}
 		
 		/// <summary> Constructs a new Delete Request copying from the ArrayList of
