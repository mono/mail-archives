Spam detection software, running on the system "polystimulus.com", has
identified this incoming email as possible spam.  The original message
has been attached to this so you can view it (if it isn't spam) or label
similar future email.  If you have any questions, see
the administrator of that system for details.

Content preview:  baseType.GetInterfaceMap(...) return a InterfaceMapping.
  InterfaceMapping is a struct (so its a value type) and can't be null, so
  Assert.IsNotNull isn't really correct. However on mono, with the
  following test case: --- using System; namespace TestApp { class Program
  { public static void Main (string[] args) { System.Type baseType =
  typeof(System.Byte[]); Console.WriteLine("Type has {0} interfaces.",
  baseType.GetInterfaces().Length); foreach (System.Type iface in
  baseType.GetInterfaces()) { Console.WriteLine(iface.FullName);
  Console.WriteLine(baseType.GetInterfaceMap(iface).TargetType.FullName);
  } } } } -- [...] 

Content analysis details:   (5.5 points, 5.0 required)

 pts rule name              description
---- ---------------------- --------------------------------------------------
 2.0 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
                            [68.95.150.106 listed in dnsbl.sorbs.net]
 1.8 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
                            [<http://dsbl.org/listing?68.95.150.106>]
 1.7 RCVD_IN_NJABL_DUL      RBL: NJABL: dialup sender did non-local SMTP
                            [68.95.150.106 listed in combined.njabl.org]


