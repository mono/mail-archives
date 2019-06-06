diff --git a/mcs/class/System.Configuration/System.Configuration/NameValueConfigurationCollection.cs b/mcs/class/System.Configuration/System.Configuration/NameValueConfigurationCollection.cs
index bfabab9..7415838 100644
--- a/mcs/class/System.Configuration/System.Configuration/NameValueConfigurationCollection.cs
+++ b/mcs/class/System.Configuration/System.Configuration/NameValueConfigurationCollection.cs
@@ -41,6 +41,13 @@ namespace System.Configuration {
 					   CollectionType = ConfigurationElementCollectionType.AddRemoveClearMap)]
 	public sealed class NameValueConfigurationCollection : ConfigurationElementCollection
 	{
+		static ConfigurationPropertyCollection properties;
+
+		static NameValueConfigurationCollection ()
+		{
+			properties = new ConfigurationPropertyCollection ();
+		}
+
 		public NameValueConfigurationCollection ()
 		{
 		}
@@ -62,7 +69,7 @@ namespace System.Configuration {
 
 		protected internal override ConfigurationPropertyCollection Properties {
 			get {
-				throw new NotImplementedException ();
+				return properties;
 			}
 		}
 
diff --git a/mcs/class/corlib/System.IO/DirectoryInfo.cs b/mcs/class/corlib/System.IO/DirectoryInfo.cs
index b837274..ee22e4b 100644
--- a/mcs/class/corlib/System.IO/DirectoryInfo.cs
+++ b/mcs/class/corlib/System.IO/DirectoryInfo.cs
@@ -203,14 +203,25 @@ #endif
 #if NET_2_0
 		// additional search methods
 
-		[MonoTODO ("AllDirectories isn't implemented")]
 		public DirectoryInfo[] GetDirectories (string pattern, SearchOption searchOption)
 		{
 			switch (searchOption) {
 			case SearchOption.TopDirectoryOnly:
 				return GetDirectories (pattern);
 			case SearchOption.AllDirectories:
-				throw new NotImplementedException ();
+				Queue workq = new Queue(GetDirectories(pattern));
+				Queue doneq = new Queue();
+				while (workq.Count > 0)
+					{
+						DirectoryInfo cinfo = (DirectoryInfo) workq.Dequeue();
+						DirectoryInfo[] cinfoDirs = cinfo.GetDirectories(pattern);
+						foreach (DirectoryInfo i in cinfoDirs) workq.Enqueue(i);
+						doneq.Enqueue(cinfo);
+					}
+
+				DirectoryInfo[] infos = new DirectoryInfo[doneq.Count];
+				doneq.CopyTo(infos, 0);
+				return infos;
 			default:
 				string msg = Locale.GetText ("Invalid enum value '{0}' for '{1}'.", searchOption, "SearchOption");
 				throw new ArgumentOutOfRangeException ("searchOption", msg);
diff --git a/mcs/class/corlib/Test/System.IO/DirectoryInfoTest.cs b/mcs/class/corlib/Test/System.IO/DirectoryInfoTest.cs
index 766ad1b..12ee262 100644
--- a/mcs/class/corlib/Test/System.IO/DirectoryInfoTest.cs
+++ b/mcs/class/corlib/Test/System.IO/DirectoryInfoTest.cs
@@ -325,15 +325,20 @@ namespace MonoTests.System.IO
 				Directory.CreateDirectory (path + DSC + "test210");
 				Directory.CreateDirectory (path + DSC + "atest330");
 				Directory.CreateDirectory (path + DSC + "test220");
+				Directory.CreateDirectory (path + DSC + "rest");
+				Directory.CreateDirectory (path + DSC + "rest" + DSC + "subdir");
 				File.Create (path + DSC + "filetest").Close ();
 				
-				AssertEquals ("test#02", 4, info.GetDirectories ("*").Length);
+				AssertEquals ("test#02", 5, info.GetDirectories ("*").Length);
 				AssertEquals ("test#03", 3, info.GetDirectories ("test*").Length);
 				AssertEquals ("test#04", 2, info.GetDirectories ("test?20").Length);
 				AssertEquals ("test#05", 0, info.GetDirectories ("test?").Length);
 				AssertEquals ("test#06", 0, info.GetDirectories ("test[12]*").Length);
 				AssertEquals ("test#07", 2, info.GetDirectories ("test2*0").Length);
 				AssertEquals ("test#08", 4, info.GetDirectories ("*test*").Length);
+#if NET_2_0
+				AssertEquals ("test#09", 6, info.GetDirectories ("*", SearchOption.AllDirectories).Length);
+#endif
 				
 			} finally {
 				DeleteDir (path);