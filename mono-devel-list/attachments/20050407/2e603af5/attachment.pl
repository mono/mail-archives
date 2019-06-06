Index: DirectoryEntry.cs
===================================================================
--- DirectoryEntry.cs	(revision 42415)
+++ DirectoryEntry.cs	(working copy)
@@ -501,51 +501,7 @@
 		public PropertyCollection Properties
 		{
 			get			{
-				if ( _Properties == null )				{
-
-					_Properties =  new PropertyCollection(this);
-					_inPropertiesLoading = true;
-
-					try					{
-						LdapSearchResults lsc=conn.Search(	Fdn,
-															LdapConnection.SCOPE_BASE,
-															"objectClass=*",
-															null,
-															false);
-						while(lsc.hasMore())						{
-
-							LdapEntry nextEntry = null;
-							try 							{
-								nextEntry = lsc.next();
-							}
-							catch(LdapException e) 							{
-								// Exception is thrown, go for next entry
-								throw e;
-							}
-							LdapAttributeSet attributeSet = nextEntry.getAttributeSet();
-							System.Collections.IEnumerator ienum=attributeSet.GetEnumerator();
-							if(ienum!=null)							{
-								while(ienum.MoveNext())				{
-									LdapAttribute attribute=(LdapAttribute)ienum.Current;
-									string attributeName = attribute.Name;
-									_Properties[attributeName].AddRange(attribute.StringValueArray);
-									_Properties[attributeName].Mbit=false;
-									//							string attributeVal = attribute.StringValue;
-									//							_Properties[attributeName].Add(attributeVal);
-								}
-							}
-							break;
-						}
-					}
-					catch( LdapException le)					{
-						if(le.ResultCode == LdapException.NO_SUCH_OBJECT)
-						{	}
-					}
-					finally {
-						_inPropertiesLoading = false;
-					}
-				}
-				return _Properties;
+				return GetProperties(true);
 			}
 		}
 
@@ -584,6 +540,60 @@
 			}
 		}
 
+		/// <summary>
+		/// Returns entry properties.
+		/// </summary>
+		/// <param name="forceLoad">Specifies whenever to force the properties load from the server if local property cache is empty.</param>
+		/// <returns></returns>
+		private PropertyCollection GetProperties(bool forceLoad)
+		{
+			if (_Properties == null) {
+				// load properties into a different collection 
+				// to preserve original collection state if exception occurs
+				PropertyCollection properties = new PropertyCollection(this);
+				if (forceLoad && !Nflag) {				
+					LoadProperties(properties,null);
+				}
+				_Properties = properties ;
+			}			
+			return _Properties;
+		}
+
+		/// <summary>
+		/// Loads the values of the specified properties into the property cache.
+		/// </summary>
+		/// <param name="propertyNames">An array of the specified properties.</param>
+		private void LoadProperties(PropertyCollection properties,string[] propertyNames)
+		{
+			_inPropertiesLoading = true;
+			try	{
+				LdapSearchResults lsc=conn.Search(Fdn,LdapConnection.SCOPE_BASE,"objectClass=*",null,false);
+				if(lsc.hasMore()) {
+					LdapEntry nextEntry = lsc.next();
+					string[] lowcasePropertyNames = null;
+					int length = 0;
+					if (propertyNames != null) {
+						length = propertyNames.Length;
+						lowcasePropertyNames = new string[length];
+						for(int i=0; i < length; i++) {
+							lowcasePropertyNames[i] = propertyNames[i].ToLower();
+						}
+					}
+					foreach(LdapAttribute attribute in nextEntry.getAttributeSet())	{
+						string attributeName = attribute.Name;
+						if ((propertyNames == null) || (Array.IndexOf(lowcasePropertyNames,attributeName.ToLower()) != -1)) {
+							properties[attributeName].Value = null;
+							properties[attributeName].AddRange(attribute.StringValueArray);
+							properties[attributeName].Mbit=false;
+						}
+					}
+				}
+			}
+			finally {
+				_inPropertiesLoading = false;
+			}
+		}
+
 		/// <summary>
 		/// Searches an entry in the Ldap directory and returns the attribute value
 		/// </summary>
@@ -870,30 +880,29 @@
 
 		private void CommitEntry()
 		{
-			if(!Nflag)
+			PropertyCollection properties = GetProperties(false);
+			if (!Nflag)
 			{
 				System.Collections.ArrayList modList = new System.Collections.ArrayList();
-				System.Collections.IDictionaryEnumerator id = Properties.GetEnumerator();
-				while(id.MoveNext())
+				foreach(string attribute in properties.PropertyNames)
 				{
-					string attribute=(string)id.Key;
 					LdapAttribute attr=null;
-					if(Properties[attribute].Mbit)
+					if(properties[attribute].Mbit)
 					{
-						if(Properties[attribute].Count==1)
+						if(properties[attribute].Count==1)
 						{
-							String val = (String)Properties[attribute].Value;
+							String val = (String)properties[attribute].Value;
 							attr = new LdapAttribute( attribute , val);
 						}
 						else
 						{
-							Object[] vals=(Object [])Properties[attribute].Value;
-							String[] aStrVals= new String[Properties[attribute].Count];
-							Array.Copy(vals,0,aStrVals,0,Properties[attribute].Count);
+							Object[] vals=(Object [])properties[attribute].Value;
+							String[] aStrVals= new String[properties[attribute].Count];
+							Array.Copy(vals,0,aStrVals,0,properties[attribute].Count);
 							attr = new LdapAttribute( attribute , aStrVals);
 						}
 						modList.Add( new LdapModification(LdapModification.REPLACE, attr));
-						Properties[attribute].Mbit=false;
+						properties[attribute].Mbit=false;
 					}
 				}
 				if (modList.Count > 0) {
@@ -906,20 +915,18 @@
 			else
 			{
 				LdapAttributeSet attributeSet = new LdapAttributeSet();
-				System.Collections.IDictionaryEnumerator id = Properties.GetEnumerator();
-				while(id.MoveNext())
+				foreach(string attribute in properties.PropertyNames)
 				{
-					string attribute=(string)id.Key;
-					if(Properties[attribute].Count==1)
+					if(properties[attribute].Count==1)
 					{
-						String val = (String)Properties[attribute].Value;
+						String val = (String)properties[attribute].Value;
 						attributeSet.Add(new LdapAttribute(attribute, val));                
 					}
 					else
 					{
-						Object[] vals=(Object [])Properties[attribute].Value;
-						String[] aStrVals= new String[Properties[attribute].Count];
-						Array.Copy(vals,0,aStrVals,0,Properties[attribute].Count);
+						Object[] vals=(Object [])properties[attribute].Value;
+						String[] aStrVals= new String[properties[attribute].Count];
+						Array.Copy(vals,0,aStrVals,0,properties[attribute].Count);
 						attributeSet.Add( new LdapAttribute( attribute , aStrVals));
 					}
 				}
@@ -947,16 +954,23 @@
 			InitEntry();
 		}
 
-		[MonoTODO]
+		/// <summary>
+		/// Loads the values of the specified properties into the property cache.
+		/// </summary>
 		public void RefreshCache ()
 		{
-			throw new NotImplementedException ("System.DirectoryServices.DirectoryEntry.RefreshCache()");
+			// note that GetProperties must be called with false, elswere infinite loop will be caused
+			LoadProperties(GetProperties(false),null);
 		}
 
-		[MonoTODO]
-		public void RefreshCache (string[] args)
+		/// <summary>
+		/// Loads the values of the specified properties into the property cache.
+		/// </summary>
+		/// <param name="propertyNames">An array of the specified properties. </param>
+		public void RefreshCache (string[] propertyNames)
 		{
-			throw new NotImplementedException ("System.DirectoryServices.DirectoryEntry.RefreshCache(System.String[])");
+			// note that GetProperties must be called with false, elswere infinite loop will be caused
+			LoadProperties(GetProperties(false),propertyNames);
 		}
 
 		protected override void Dispose (bool disposing)
