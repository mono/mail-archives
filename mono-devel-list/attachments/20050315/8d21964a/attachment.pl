Index: DirectorySearcher.cs
===================================================================
--- DirectorySearcher.cs	(revision 41792)
+++ DirectorySearcher.cs	(working copy)
@@ -47,7 +47,7 @@
 
 		private DirectoryEntry _SearchRoot=null;
 		private bool _CacheResults=true;
-		private TimeSpan _ClientTimeout = new TimeSpan(-1);
+		private TimeSpan _ClientTimeout = new TimeSpan(-10000000);
 		private string _Filter="(objectClass=*)";
 		private int _PageSize=0;
 		private StringCollection _PropertiesToLoad=new StringCollection();
@@ -56,23 +56,22 @@
 						System.DirectoryServices.ReferralChasingOption.External;
 		private SearchScope _SearchScope=
 						System.DirectoryServices.SearchScope.Subtree;
-		private TimeSpan _ServerPageTimeLimit=new TimeSpan(-1);
-		private int _SizeLimit=1000;
+		private TimeSpan _ServerPageTimeLimit=new TimeSpan(-10000000);
+		private TimeSpan _serverTimeLimit = new TimeSpan(-10000000);
+		private int _SizeLimit=0;
 		private LdapConnection _conn = null;
 		private string _Host=null;
 		private int _Port=389;
 		private SearchResultCollection _SrchColl=null;
-		private bool emptycoll=true;
 
 		internal SearchResultCollection SrchColl 
 		{
 			get
 			{
-				if (emptycoll)
+				if (_SrchColl == null)
 				{
 					_SrchColl =  new SearchResultCollection();
 					DoSearch();
-					emptycoll=false;
 				}
 				return _SrchColl;
 			}
@@ -111,7 +110,7 @@
 			}
 			set
 			{
-				CacheResults = value;
+				_CacheResults = value;
 			}
 		}
 
@@ -177,6 +176,7 @@
 			set
 			{
 				_Filter = value;
+				ClearCachedResults();
 			}
 		}
 
@@ -299,6 +299,7 @@
 			set
 			{
 				_SearchRoot = value;
+				ClearCachedResults();
 			}
 		}
 
@@ -321,6 +322,7 @@
 			set
 			{
 				_SearchScope =  value;
+				ClearCachedResults();
 			}
 		}
 
@@ -371,12 +373,12 @@
 			[MonoTODO]
 			get
 			{
-				throw new NotImplementedException();
+				return _serverTimeLimit;
 			}
 			[MonoTODO]
 			set
 			{
-				throw new NotImplementedException();
+				_serverTimeLimit = value;
 			}
 		}
 
@@ -406,6 +408,9 @@
 			}
 			set
 			{
+				if (value < 0) {
+					throw new ArgumentException();
+				}
 				_SizeLimit =  value;
 			}
 		}
@@ -597,6 +602,9 @@
 		/// </returns>
 		public SearchResult FindOne()
 		{
+			if (SrchColl.Count == 0) {
+				return null;
+			}
 			return SrchColl[0];
 		}
 
@@ -614,8 +622,12 @@
 		private void DoSearch()
 		{
 			InitBlock();
+			if (!PropertiesToLoad.Contains("ADsPath")) {
+				PropertiesToLoad.Add("ADsPath");
+			}
 			String[] attrs= new String[PropertiesToLoad.Count];
 			PropertiesToLoad.CopyTo(attrs,0);
+
 			int connScope = LdapConnection.SCOPE_SUB;
 			switch (_SearchScope)
 			{
@@ -635,6 +647,7 @@
 			  connScope = LdapConnection.SCOPE_SUB;
 			  break;
 			}
+
 			LdapSearchResults lsc=_conn.Search(	SearchRoot.Fdn,
 								connScope,
 												Filter,
@@ -672,10 +685,13 @@
 //						de.Properties[attributeName].Mbit=false;
 					}
 				}
+				if (!pcoll.Contains("ADsPath")) {
+					pcoll["ADsPath"].Add(nextEntry.DN);
+				}
 //				_SrchColl.Add(new SearchResult(de,PropertiesToLoad));
 				_SrchColl.Add(new SearchResult(de,pcoll));
 			}
-		return;
+			return;
 		}
 
 		[MonoTODO]
@@ -684,6 +700,11 @@
 			throw new NotImplementedException();
 		}
 
+		private void ClearCachedResults()
+		{
+			_SrchColl = null;
+		}
+
 	}
 }
 
