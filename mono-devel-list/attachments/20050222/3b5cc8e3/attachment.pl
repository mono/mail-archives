Index: ReliabilityContractAttribute.cs
===================================================================
--- ReliabilityContractAttribute.cs	(revision 41077)
+++ ReliabilityContractAttribute.cs	(working copy)
@@ -2,7 +2,7 @@
 // System.Runtime.ConstrainedExecution.ReliabilityContractAttribute.cs
 //
 // Author:
-//    Duncan Mak (duncan@ximian.com)
+//    Duncan Mak (duncan@ximian.com)
 //
 // Permission is hereby granted, free of charge, to any person obtaining
 // a copy of this software and associated documentation files (the
@@ -37,30 +37,47 @@
 	[ComVisible (false)]
         public sealed class ReliabilityContractAttribute : Attribute
         {
-                Consistency consistency;
-                CER cer;
+                private Consistency consistency;
+                private Cer cer;

                 public ReliabilityContractAttribute ()
                 {
                 }

-                public ReliabilityContractAttribute (Consistency consistency, CER cer)
+		[CLSCompliant (false)]
+		public ReliabilityContractAttribute (Consistency consistency, Cer cer)
                 {
                         this.consistency = consistency;
                         this.cer = cer;
                 }

-                public CER CER {
+		[MonoTODO ("Remove this method once dependencies on CER are removed")]
+		[Obsolete ("CER has been replaced with Cer")]
+		[CLSCompliant (false)]
+		public ReliabilityContractAttribute (Consistency consistency, CER cer)
+                {
+                        this.consistency = consistency;
+                        this.cer = (Cer)(Int32)cer;
+                }
+
+		[MonoTODO ("Remove this method once dependencies on CER are removed")]
+		[Obsolete ("CER has been replaced with Cer")]
+		[CLSCompliant (false)]
+		public CER CER {
+                        get { return (CER)(Int32)cer; }
+			set { cer = (Cer)(Int32)value; }
+                }
+
+		[CLSCompliant (false)]
+		public Cer Cer {
                         get { return cer; }
 			set { cer = value; }
                 }
-
-                public Consistency ConsistencyGuarantee {
-
+
+		public Consistency ConsistencyGuarantee {
                         get { return consistency; }
-
                         set { consistency = value; }
                 }
         }
 }
-#endif
+#endif
