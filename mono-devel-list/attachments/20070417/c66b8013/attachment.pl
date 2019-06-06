Index: System.Web.Configuration_2.0/ProcessModelSection.cs
===================================================================
--- System.Web.Configuration_2.0/ProcessModelSection.cs	(revision 75741)
+++ System.Web.Configuration_2.0/ProcessModelSection.cs	(working copy)
@@ -84,7 +84,7 @@
 									       new GenericEnumConverter (typeof (ProcessModelComImpersonationLevel)),
 									       PropertyHelper.DefaultValidator,
 									       ConfigurationPropertyOptions.None);
-			cpuMaskProp = new ConfigurationProperty ("cpuMask", typeof (int), 0xffffffff);
+			cpuMaskProp = new ConfigurationProperty ("cpuMask", typeof (int), (int) (int.MaxValue & 0x80000000));
 			enableProp = new ConfigurationProperty ("enable", typeof (bool), true);
 			idleTimeoutProp = new ConfigurationProperty ("idleTimeout", typeof (TimeSpan), TimeSpan.MaxValue,
 								     PropertyHelper.InfiniteTimeSpanConverter,
@@ -222,7 +222,7 @@
 			set { base[comImpersonationLevelProp] = value; }
 		}
 
-		[ConfigurationProperty ("cpuMask", DefaultValue = "0xffffffff")]
+		[ConfigurationProperty ("cpuMask", DefaultValue = (int) (int.MaxValue & 0x80000000))]
 		public int CpuMask {
 			get { return (int) base [cpuMaskProp];}
 			set { base[cpuMaskProp] = value; }