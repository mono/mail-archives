Index: DirectorySearcher.cs
===================================================================
--- DirectorySearcher.cs	(revision 42068)
+++ DirectorySearcher.cs	(working copy)
@@ -44,10 +44,10 @@
 	/// </summary>
 	public class DirectorySearcher : Component	
 	{
-
+		private static readonly TimeSpan DefaultTimeSpan = new TimeSpan(-TimeSpan.TicksPerSecond);
 		private DirectoryEntry _SearchRoot=null;
 		private bool _CacheResults=true;
-		private TimeSpan _ClientTimeout = new TimeSpan(-10000000);
+		private TimeSpan _ClientTimeout = DefaultTimeSpan;
 		private string _Filter="(objectClass=*)";
 		private int _PageSize=0;
 		private StringCollection _PropertiesToLoad=new StringCollection();
@@ -56,8 +56,8 @@
 						System.DirectoryServices.ReferralChasingOption.External;
 		private SearchScope _SearchScope=
 						System.DirectoryServices.SearchScope.Subtree;
-		private TimeSpan _ServerPageTimeLimit=new TimeSpan(-10000000);
-		private TimeSpan _serverTimeLimit = new TimeSpan(-10000000);
+		private TimeSpan _ServerPageTimeLimit = DefaultTimeSpan;
+		private TimeSpan _serverTimeLimit = DefaultTimeSpan;
 		private int _SizeLimit=0;
 		private LdapConnection _conn = null;
 		private string _Host=null;
@@ -602,6 +602,7 @@
 		/// </returns>
 		public SearchResult FindOne()
 		{
+			// TBD : should search for no more than single result
 			if (SrchColl.Count == 0) {
 				return null;
 			}
@@ -627,36 +628,42 @@
 			}
 			String[] attrs= new String[PropertiesToLoad.Count];
 			PropertiesToLoad.CopyTo(attrs,0);
+			
+			LdapSearchConstraints cons = _conn.SearchConstraints;
+			if (SizeLimit > 0) {
+				cons.MaxResults = SizeLimit;
+			}
+			if (ServerTimeLimit != DefaultTimeSpan) {
+				cons.ServerTimeLimit = (int)ServerTimeLimit.TotalSeconds;
+			}
 
-			int connScope = LdapConnection.SCOPE_SUB;
-			switch (_SearchScope)
-			{
-			case SearchScope.Base:
-			  connScope = LdapConnection.SCOPE_BASE;
-			  break;
-
-			case SearchScope.OneLevel:
-			  connScope = LdapConnection.SCOPE_ONE;
-			  break;
-
-			case SearchScope.Subtree:
-			  connScope = LdapConnection.SCOPE_SUB;
-			  break;
-
-			default:
-			  connScope = LdapConnection.SCOPE_SUB;
-			  break;
+			int connScope = LdapConnection.SCOPE_SUB;
+			switch (_SearchScope)
+			{
+			case SearchScope.Base:
+			  connScope = LdapConnection.SCOPE_BASE;
+			  break;
+
+			case SearchScope.OneLevel:
+			  connScope = LdapConnection.SCOPE_ONE;
+			  break;
+
+			case SearchScope.Subtree:
+			  connScope = LdapConnection.SCOPE_SUB;
+			  break;
+
+			default:
+			  connScope = LdapConnection.SCOPE_SUB;
+			  break;
 			}
-
 			LdapSearchResults lsc=_conn.Search(	SearchRoot.Fdn,
-								connScope,
+												connScope,
 												Filter,
 												attrs,
-												false);
+												false,cons);
 
 			while(lsc.hasMore())						
 			{
-
 				LdapEntry nextEntry = null;
 				try 							
 				{
@@ -664,9 +671,14 @@
 				}
 				catch(LdapException e) 							
 				{
-					Console.WriteLine("Error: " + e.LdapErrorMessage);
-					// Exception is thrown, go for next entry
-					throw e;
+					switch (e.ResultCode) {
+						// in case of this return codes exception should not be thrown
+						case LdapException.SIZE_LIMIT_EXCEEDED:
+						case LdapException.TIME_LIMIT_EXCEEDED:
+							continue;
+						default :
+							throw e;
+					}
 				}
 				DirectoryEntry de = new DirectoryEntry(_conn);
 				PropertyCollection pcoll = new PropertyCollection();
@@ -686,7 +698,7 @@
 					}
 				}
 				if (!pcoll.Contains("ADsPath")) {
-					pcoll["ADsPath"].Add(nextEntry.DN);
+					pcoll["ADsPath"].Add(de.Path);
 				}
 //				_SrchColl.Add(new SearchResult(de,PropertiesToLoad));
 				_SrchColl.Add(new SearchResult(de,pcoll));
@@ -697,7 +709,12 @@
 		[MonoTODO]
 		protected override void Dispose(bool disposing)
 		{
-			throw new NotImplementedException();
+			if (disposing) {
+				if(_conn.Connected) {
+					_conn.Disconnect();
+				}
+			}
+			base.Dispose(disposing);
 		}
 
 		private void ClearCachedResults()
