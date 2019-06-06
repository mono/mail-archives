Index: data/net_2_0/DefaultWsdlHelpGenerator.aspx
===================================================================
--- data/net_2_0/DefaultWsdlHelpGenerator.aspx	(revision 67354)
+++ data/net_2_0/DefaultWsdlHelpGenerator.aspx	(working copy)
@@ -88,7 +88,7 @@
 	Page.DataBind();
 	
 	ProfileViolations = new BasicProfileViolationCollection ();
-	WebServicesInteroperability.CheckConformance (WsiClaims.BP10, descriptions, ProfileViolations);
+	WebServicesInteroperability.CheckConformance (WsiProfiles.BasicProfile1_1, descriptions, ProfileViolations);
 }
 
 void BuildOperationInfo ()
