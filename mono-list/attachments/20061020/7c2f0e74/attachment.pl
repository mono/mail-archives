--- MySqlPoolManager.cs.ori	2006-10-20 22:35:16.932249600 +0200
+++ MySqlPoolManager.cs	2006-10-20 22:36:01.866862400 +0200
@@ -29,26 +29,14 @@
 	/// </summary>
 	internal sealed class MySqlPoolManager
 	{
-		private static Hashtable pools;
+		private static Hashtable pools = new Hashtable();
 
 		public MySqlPoolManager()
 		{
 		}
 
-		/// <summary>
-		/// 
-		/// </summary>
-		private static void Initialize()
-		{
-			pools = new Hashtable();
-		}
-
 		public static MySqlPool GetPool(MySqlConnectionString settings)
 		{
-			// make sure the manager is initialized
-			if (MySqlPoolManager.pools == null)
-				MySqlPoolManager.Initialize();
-
 			string text = settings.GetConnectionString(true);
 
 			lock (pools.SyncRoot)
