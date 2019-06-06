Index: DirectoryEntry.cs
===================================================================
--- DirectoryEntry.cs	(revision 41947)
+++ DirectoryEntry.cs	(working copy)
@@ -60,15 +60,16 @@
 		private PropertyCollection _Properties = null;
 		private string _SchemaClassName=null;
 		private bool _Nflag = false;
-		private bool _disposed;
+		private bool _usePropertyCache=true;
+		private bool _inPropertiesLoading;
 
 		/// <summary>
 		/// Returns entry's Fully distinguished name.
 		/// </summary>
 		internal string Fdn
 		{
-			get			{
-				if (_Fdn == null)				{
+			get	{
+				if (_Fdn == null) {
 					LdapUrl lUrl = new LdapUrl(Path);
 					string fDn=lUrl.getDN();
 					if(fDn != null)
@@ -123,11 +124,9 @@
 				_conn.Bind(Username,Password);
 			}
 			catch(LdapException ex)			{
-				Console.WriteLine("Error:" + ex.LdapErrorMessage);
 				throw ex;
 			}
 			catch(Exception e)			{
-				Console.WriteLine("Error:" +  e.Message);
 				throw e;
 			}
 		}
@@ -392,12 +391,12 @@
 			[MonoTODO]
 			get 
 			{
-				throw new NotImplementedException();
+				return _usePropertyCache;
 			}
 			[MonoTODO]
 			set 
 			{
-				throw new NotImplementedException();
+				_usePropertyCache = value;
 			}
 		}
 
@@ -506,7 +505,8 @@
 			get			{
 				if ( _Properties == null )				{
 
-					_Properties =  new PropertyCollection();
+					_Properties =  new PropertyCollection(this);
+					_inPropertiesLoading = true;
 
 					try					{
 						LdapSearchResults lsc=conn.Search(	Fdn,
@@ -521,7 +521,6 @@
 								nextEntry = lsc.next();
 							}
 							catch(LdapException e) 							{
-								Console.WriteLine("Error: " + e.LdapErrorMessage);
 								// Exception is thrown, go for next entry
 								throw e;
 							}
@@ -544,7 +543,9 @@
 						if(le.ResultCode == LdapException.NO_SUCH_OBJECT)
 						{	}
 					}
-
+					finally {
+						_inPropertiesLoading = false;
+					}
 				}
 				return _Properties;
 			}
@@ -580,7 +581,7 @@
 		public DirectoryEntry SchemaEntry 
 		{
 			[MonoTODO]
-			get			{
+			get			{
 				throw new NotImplementedException();
 			}
 		}
@@ -606,7 +607,6 @@
 					nextEntry = lsc.next();
 				}
 				catch(LdapException e)		{
-					Console.WriteLine("Error: " + e.LdapErrorMessage);
 					// Exception is thrown, go for next entry
 					throw e;
 				}
@@ -672,7 +672,6 @@
 					}
 					catch(LdapException e) 
 					{
-						Console.WriteLine("Error: " + e.LdapErrorMessage);
 						// Exception is thrown, go for next entry
 						throw e;
 					}
@@ -708,7 +707,9 @@
 		/// </remarks>
 		public void Close()
 		{
-			conn.Disconnect();
+			if (conn.Connected) {
+				conn.Disconnect();
+			}
 		}
 
 		/// <summary>
@@ -772,7 +773,11 @@
 		/// </param>
 		public void MoveTo(DirectoryEntry newParent)
 		{
+			string oldParentFdn = Parent.Fdn;
 			conn.Rename(Fdn, Name, newParent.Fdn, true);
+			// TBD : threat multiple name instance in path
+			Path = Path.Replace(oldParentFdn,newParent.Fdn);
+			RefreshEntry();			
 		}
 
 		/// <summary>
@@ -788,7 +793,11 @@
 		public void MoveTo(	DirectoryEntry newParent,
 							string newName	)
 		{
+			string oldParentFdn = Parent.Fdn;
 			conn.Rename(Fdn, newName, newParent.Fdn, true);
+			// TBD : threat multiple name instance in path
+			Path = Path.Replace(oldParentFdn,newParent.Fdn).Replace(Name,newName);
+			RefreshEntry();	
 		}
 
 		/// <summary>
@@ -802,7 +811,11 @@
 		/// </remarks>
 		public void Rename(	string newName	)
 		{
+			string oldName = Name;
 			conn.Rename( Fdn, newName, true);
+			// TBD : threat multiple name instance in path
+			Path = Path.Replace(oldName,newName);
+			RefreshEntry();	
 		}
 
 		/// <summary>
@@ -851,6 +864,14 @@
 		/// </remarks>
 		public void CommitChanges()
 		{
+			if(UsePropertyCache) 
+			{
+				CommitEntry();
+			}
+		}
+
+		private void CommitEntry()
+		{
 			if(!Nflag)
 			{
 				System.Collections.ArrayList modList = new System.Collections.ArrayList();
@@ -876,12 +897,13 @@
 						modList.Add( new LdapModification(LdapModification.REPLACE, attr));
 						Properties[attribute].Mbit=false;
 					}
-//					Console.WriteLine(attribute + "Total no of attr value" + Properties[attribute].Count);
 				}
-				LdapModification[] mods = new LdapModification[modList.Count]; 	
-				Type mtype=Type.GetType("System.DirectoryServices.LdapModification");
-				mods = (LdapModification[])modList.ToArray(typeof(LdapModification));
-				ModEntry(mods);
+				if (modList.Count > 0) {
+					LdapModification[] mods = new LdapModification[modList.Count]; 	
+					Type mtype=Type.GetType("System.DirectoryServices.LdapModification");
+					mods = (LdapModification[])modList.ToArray(typeof(LdapModification));
+					ModEntry(mods);
+				}
 			}
 			else
 			{
@@ -890,7 +912,6 @@
 				while(id.MoveNext())
 				{
 					string attribute=(string)id.Key;
-//					Console.WriteLine("attribute:"  + attribute + "Vals:" + Properties[attribute][0]);
 					if(Properties[attribute].Count==1)
 					{
 						String val = (String)Properties[attribute].Value;
@@ -905,10 +926,29 @@
 					}
 				}
 				LdapEntry newEntry = new LdapEntry( Fdn, attributeSet );
-				conn.Add( newEntry );			
+				conn.Add( newEntry );
+				Nflag = false;
 			}
 		}
 
+		internal void CommitDeferred()
+		{
+			if (!_inPropertiesLoading && !UsePropertyCache && !Nflag) 
+			{
+				CommitEntry();
+			}
+		}
+
+		void RefreshEntry()
+		{
+			_Properties = null;
+			_Fdn = null;
+			_Name = null;
+			_Parent = null;
+			_SchemaClassName = null;
+			InitEntry();
+		}
+
 		[MonoTODO]
 		public void RefreshCache ()
 		{
@@ -923,9 +963,8 @@
 
 		protected override void Dispose (bool disposing)
 		{
-			if (!_disposed && disposing) {
+			if (disposing) {
 				Close ();
-				_disposed = true;
 			}
 			base.Dispose (disposing);
 		}
