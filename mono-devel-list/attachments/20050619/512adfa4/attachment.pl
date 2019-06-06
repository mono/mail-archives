Index: Assembly/AssemblyInfo.cs
===================================================================
--- Assembly/AssemblyInfo.cs	(revision 45938)
+++ Assembly/AssemblyInfo.cs	(working copy)
@@ -42,6 +42,8 @@
 
 [assembly: ComVisible(false)]
 
+#if (!TARGET_JVM)
 [assembly: AssemblyDelaySign(true)]
 [assembly: AssemblyKeyFile("../msfinal.pub")]
+#endif
 
Index: Assembly/ChangeLog
===================================================================
--- Assembly/ChangeLog	(revision 45938)
+++ Assembly/ChangeLog	(working copy)
@@ -1,3 +1,6 @@
+2005-06-19 Boris Kirzner <borisk@mainsoft.coim>
+	* AssemblyInfo.cs: Added #ifdef on attributes not used in TARGET_JVM.
+	
 2004-01-15  Andreas Nahr <ClassDevelopment@A-SoftTech.com>
 
 	* Locale.cs: Added
Index: Test/System.DirectoryServices/DirectoryServicesSearchResultTest.cs
===================================================================
--- Test/System.DirectoryServices/DirectoryServicesSearchResultTest.cs	(revision 45938)
+++ Test/System.DirectoryServices/DirectoryServicesSearchResultTest.cs	(working copy)
@@ -261,16 +261,20 @@
 
 			SearchResultCollection results = ds.FindAll();
 
-			Assert.AreEqual(results[0].Path,LDAPServerRoot + "dc=myhosting,dc=example");
+			// MS works only with "LDAP" while RFC2255 states "ldap"
+			Assert.AreEqual(results[0].Path.ToLower(),(LDAPServerRoot + "dc=myhosting,dc=example").ToLower());
 			Assert.AreEqual(results[0].Path,results[0].GetDirectoryEntry().Path);
 
-			Assert.AreEqual(results[1].Path,LDAPServerRoot + "ou=people,dc=myhosting,dc=example");
+			// MS works only with "LDAP" while RFC2255 states "ldap"
+			Assert.AreEqual(results[1].Path.ToLower(),(LDAPServerRoot + "ou=people,dc=myhosting,dc=example").ToLower());
 			Assert.AreEqual(results[1].Path,results[1].GetDirectoryEntry().Path);
 
-			Assert.AreEqual(results[2].Path,LDAPServerRoot + "ou=Human Resources,ou=people,dc=myhosting,dc=example");
+			// MS works only with "LDAP" while RFC2255 states "ldap"
+			Assert.AreEqual(results[2].Path.ToLower(),(LDAPServerRoot + "ou=Human Resources,ou=people,dc=myhosting,dc=example").ToLower());
 			Assert.AreEqual(results[2].Path,results[2].GetDirectoryEntry().Path);
 
-			Assert.AreEqual(results[3].Path,LDAPServerRoot + "cn=John Smith,ou=Human Resources,ou=people,dc=myhosting,dc=example");
+			// MS works only with "LDAP" while RFC2255 states "ldap"
+			Assert.AreEqual(results[3].Path.ToLower(),(LDAPServerRoot + "cn=John Smith,ou=Human Resources,ou=people,dc=myhosting,dc=example").ToLower());
 			Assert.AreEqual(results[3].Path,results[3].GetDirectoryEntry().Path);
 		}
 
@@ -323,7 +327,8 @@
 
 			Assert.AreEqual(((ResultPropertyValueCollection)result.Properties["cn"])[0],"Barak Tsabari");
 			Assert.AreEqual(((ResultPropertyValueCollection)result.Properties["objectClass"])[0],"person");
-			Assert.AreEqual(((ResultPropertyValueCollection)result.Properties["AdsPath"])[0],LDAPServerRoot + "cn=Barak Tsabari,ou=Human Resources,ou=people,dc=myhosting,dc=example");
+			// MS works only with "LDAP" while RFC2255 states "ldap"
+			Assert.AreEqual(((string)((ResultPropertyValueCollection)result.Properties["AdsPath"])[0]).ToLower(),(LDAPServerRoot + "cn=Barak Tsabari,ou=Human Resources,ou=people,dc=myhosting,dc=example").ToLower());
 		}
 
 		#endregion Tests
Index: Test/System.DirectoryServices/DirectoryServicesDirectoryEntryTest.cs
===================================================================
--- Test/System.DirectoryServices/DirectoryServicesDirectoryEntryTest.cs	(revision 45938)
+++ Test/System.DirectoryServices/DirectoryServicesDirectoryEntryTest.cs	(working copy)
@@ -1029,21 +1029,24 @@
 		{
 			de = new DirectoryEntry(LDAPServerConnectionString);
 
-			Assert.AreEqual(de.Parent.Path,LDAPServerRoot + "dc=example");
+			// MS works only with "LDAP" while RFC2255 states "ldap"
+			Assert.AreEqual(de.Parent.Path.ToLower(),(LDAPServerRoot + "dc=example").ToLower());
 
 			de = new DirectoryEntry(LDAPServerConnectionString,
 									LDAPServerUsername,
 									LDAPServerPassword,
 									AuthenticationTypes.ServerBind);
 
-			Assert.AreEqual(de.Parent.Path,LDAPServerRoot + "dc=example");
+			// MS works only with "LDAP" while RFC2255 states "ldap"
+			Assert.AreEqual(de.Parent.Path.ToLower(),(LDAPServerRoot + "dc=example").ToLower());
 
 			de = new DirectoryEntry(LDAPServerRoot + "cn=Barak Tsabari,ou=Human Resources,ou=people,dc=myhosting,dc=example" ,
 									LDAPServerUsername,
 									LDAPServerPassword,
 									AuthenticationTypes.ServerBind);
 
-			Assert.AreEqual(de.Parent.Path,LDAPServerRoot + "ou=Human Resources,ou=people,dc=myhosting,dc=example");
+			// MS works only with "LDAP" while RFC2255 states "ldap"
+			Assert.AreEqual(de.Parent.Path.ToLower(),(LDAPServerRoot + "ou=Human Resources,ou=people,dc=myhosting,dc=example").ToLower());
 		}
 
 
@@ -1138,6 +1141,12 @@
 
 			de.Path = wrongPath;
 			Assert.AreEqual(de.Path,wrongPath);
+
+			de = new DirectoryEntry("ldap://myhost:389/ou=people",null,null,AuthenticationTypes.None);
+			Assert.AreEqual(de.Path,"ldap://myhost:389/ou=people");
+
+			de.Path = null;
+			Assert.AreEqual(de.Path,String.Empty);
 		}
 
 
@@ -1272,20 +1281,21 @@
 		[Test]
 		public void DirectoryEntry_SchemaEntry()
 		{
-			//			de = new DirectoryEntry();
-			//			DirectoryEntry schemaEntry = de.SchemaEntry;
-			//
-			//			Assert.AreEqual(schemaEntry.Path,"LDAP://schema/domainDNS");
-			//			Assert.AreEqual(schemaEntry.Name,"domainDNS");
-			//			Assert.AreEqual(schemaEntry.Username,null);
-			//			Assert.AreEqual(schemaEntry.Password,null);
-			//			Assert.AreEqual(schemaEntry.UsePropertyCache,true);
-			//			Assert.AreEqual(schemaEntry.SchemaClassName,"Class");
-			//			Assert.AreEqual(schemaEntry.AuthenticationType,AuthenticationTypes.None);
+			de = new DirectoryEntry();
+			DirectoryEntry schemaEntry = de.SchemaEntry;
 
+			// MS works only with "LDAP" while RFC2255 states "ldap"
+			Assert.AreEqual(schemaEntry.Path.ToLower(),"LDAP://schema/domainDNS".ToLower());
+			Assert.AreEqual(schemaEntry.Name,"domainDNS");
+			Assert.AreEqual(schemaEntry.Username,null);
+			Assert.AreEqual(schemaEntry.Password,null);
+			Assert.AreEqual(schemaEntry.UsePropertyCache,true);
+			Assert.AreEqual(schemaEntry.SchemaClassName,"Class");
+			Assert.AreEqual(schemaEntry.AuthenticationType,AuthenticationTypes.None);
 
+
 			de = new DirectoryEntry(LDAPServerConnectionString);
-			DirectoryEntry schemaEntry = de.SchemaEntry;
+			schemaEntry = de.SchemaEntry;
 
 			Assert.AreEqual(schemaEntry.Path,LDAPServerRoot + "schema/organization");
 			Assert.AreEqual(schemaEntry.Name,"organization");
Index: Test/System.DirectoryServices/ChangeLog
===================================================================
--- Test/System.DirectoryServices/ChangeLog	(revision 45938)
+++ Test/System.DirectoryServices/ChangeLog	(working copy)
@@ -1,3 +1,10 @@
+2005-06-19 Boris Kirzner <borisk@mainsoft.coim>
+	* DirectoryServicesSearchResultTest.cs: since MS works only with "LDAP" while RFC2255 states "ldap", use lowercase comparing on ldap urls.
+	* DirectoryServicesDirectoryEntryTest.cs:
+		- Since MS works only with "LDAP" while RFC2255 states "ldap", use lowercase comparing on ldap urls.
+		- Added more Path tests.
+		- Uncommented SchemaEntry tests.
+
 2005-06-01  Sebastien Pouliot  <sebastien@ximian.com>
 
 	* DirectoryServicesPermissionTest.cs: IsSubset(null) has a different 
Index: App.config
===================================================================
--- App.config	(revision 0)
+++ App.config	(revision 0)
@@ -0,0 +1,16 @@
+<?xml version="1.0" encoding="utf-8" ?>
+<!-- Example app.config file for specifying default LDAP server information -->
+<configuration>
+  <configSections>
+      <sectionGroup name="System.DirectoryServices">
+          <section name="Settings" type="System.Configuration.NameValueSectionHandler"/>
+      </sectionGroup>
+  </configSections>
+
+  <System.DirectoryServices>
+      <Settings>
+          <add key="servername" value="xp050"/>
+          <add key="port" value="389"/>
+      </Settings>
+  </System.DirectoryServices>
+</configuration>
Index: System.DirectoryServices_test.dll.sources
===================================================================
--- System.DirectoryServices_test.dll.sources	(revision 45938)
+++ System.DirectoryServices_test.dll.sources	(working copy)
@@ -1,2 +1,6 @@
 System.DirectoryServices/DirectoryServicesPermissionAttributeTest.cs
 System.DirectoryServices/DirectoryServicesPermissionTest.cs
+System.DirectoryServices/DirectoryServicesDirectoryEntryTest.cs
+System.DirectoryServices/DirectoryServicesDirectorySearcherTest.cs
+System.DirectoryServices/DirectoryServicesSearchResultTest.cs
+
Index: ChangeLog
===================================================================
--- ChangeLog	(revision 45938)
+++ ChangeLog	(working copy)
@@ -1,3 +1,7 @@
+2005-06-19 Boris Kirzner <borisk@mainsoft.coim>
+	* System.DirectoryServices_test.dll.sources: added DirectoryServicesDirectoryEntryTest.cs,/DirectoryServicesDirectorySearcherTest.cs,DirectoryServicesSearchResultTest.cs
+	* App.config - added new file, contaning an example of specifying default LDAP server information in app config.
+
 2005-02-14  Anil Bhatia  <banil@novell.com>
 	* Fixed DoSearch() in DirectorySearcher.cs: Search scope was hardcoded
 	as LdapConnection.SCOPE_SUB. Chnaged to the value contained by
Index: System.DirectoryServices/DirectorySearcher.cs
===================================================================
--- System.DirectoryServices/DirectorySearcher.cs	(revision 45939)
+++ System.DirectoryServices/DirectorySearcher.cs	(working copy)
@@ -80,7 +80,7 @@
 		private void InitBlock()
 		{
 			_conn = new LdapConnection();
-			LdapUrl lUrl=new LdapUrl(SearchRoot.Path);
+			LdapUrl lUrl=new LdapUrl(SearchRoot.ADsPath);
 			_Host=lUrl.Host;
 			_Port=lUrl.Port;
 			_conn.Connect(_Host,_Port);
@@ -657,7 +657,7 @@
 												connScope,
 												Filter,
 												attrs,
-												false,cons);
+												PropertyNamesOnly,cons);
 
 			while(lsc.hasMore())						
 			{
@@ -680,7 +680,7 @@
 				DirectoryEntry de = new DirectoryEntry(_conn);
 				PropertyCollection pcoll = new PropertyCollection();
 //				de.SetProperties();
-				de.Path="LDAP://" + _Host+ ":" + _Port + "/" + nextEntry.DN;
+				de.Path = DirectoryEntry.GetLdapUrlString(_Host,_Port,nextEntry.DN); 
 				LdapAttributeSet attributeSet = nextEntry.getAttributeSet();
 				System.Collections.IEnumerator ienum=attributeSet.GetEnumerator();
 				if(ienum!=null)							
Index: System.DirectoryServices/ChangeLog
===================================================================
--- System.DirectoryServices/ChangeLog	(revision 45939)
+++ System.DirectoryServices/ChangeLog	(working copy)
@@ -1,3 +1,23 @@
+2005-06-19 Boris Kirzner <borisk@mainsoft.coim>
+	* DirectorySearcher.cs: 
+		- Use ADsPath property (always represents an actual url) instead of Path (may be null or empty string).
+		- Use PropertyNamesOnly property while perfoming search, so property values retrieved only when needed.
+		- Create parent path in more clean way.
+	* DirectoryEntry.cs:
+		- Use ADsPath property (always represents an actual url) instead of Path (may be null or empty string).
+		- InitEntry takes special care about rootDse entries.
+		- Path return empty string if assigned to null.
+		- Added ADsPath property. This is an "actual" entry path on the server. If user does not specifies a path, it is resolved usinf rootDse server entry properties. We need this since the user-specified PAth property should never change.
+		- Added GetProperties,SetProperties and LoadProperties methods to handle internal properties load and assignment.
+		- Added DefaultHost and DefaultPort properties, so user can specify the default LDAP server information using app config. If user does not specify it, the localhost:389 is the default.
+		- Added InitToRootDse method - initializes current entry to specified server rootDse entry.
+		- CheckEntry takes special care about rootDse entries.
+		- CommitEntry rewrited to use .NET style iteration. In addition, the method uses entry peroperties whout enforsing their reload.
+		- Implemented RefreshCache methods. 
+		- Added method GetLdapUrlString, returns LDAP URL string representation that omits default port (i.e. ldap://server/dn instead of ldap://server:389/dn), as .NET does.
+	* PropertyValueCollection.cs: removed redundant MonoTodo attributes.
+	* SearchResult.cs: if underlined result properties collection is empty, do not try lto load a properties from it.
+		
 2005-06-14  Boris Kirzner <borisk@mainsoft.com>
 	* DirectorySearcher.cs : AdsPath property should not appear in the query, but it still should appear in the SearchResult properties (by initialization from result entry path).
 
Index: System.DirectoryServices/DirectoryEntry.cs
===================================================================
--- System.DirectoryServices/DirectoryEntry.cs	(revision 45938)
+++ System.DirectoryServices/DirectoryEntry.cs	(working copy)
@@ -27,6 +27,7 @@
 // Authors:
 //   Sunil Kumar (sunilk@novell.com)
 //   Andreas Nahr (ClassDevelopment@A-SoftTech.com)
+//	 Boris Kirzner (borisk@mainsoft.com)
 //
 // (C)  Novell Inc.
 //
@@ -36,6 +37,8 @@
 using Novell.Directory.Ldap.Utilclass;
 using System.Globalization;
 using System.DirectoryServices.Design;
+using System.Collections.Specialized;
+using System.Configuration;
 
 namespace System.DirectoryServices
 {
@@ -46,7 +49,9 @@
 	[TypeConverter (typeof (DirectoryEntryConverter))]
 	public class DirectoryEntry : Component	
 	{
-		
+		private static readonly string DEFAULT_LDAP_HOST = "System.DirectoryServices.DefaultLdapHost";
+		private static readonly string DEFAULT_LDAP_PORT = "System.DirectoryServices.DefaultLdapPort";
+
 		private LdapConnection _conn = null;
 		private AuthenticationTypes _AuthenticationType=AuthenticationTypes.None;
 		private DirectoryEntries _Children;
@@ -70,12 +75,12 @@
 		{
 			get	{
 				if (_Fdn == null) {
-					LdapUrl lUrl = new LdapUrl(Path);
+					LdapUrl lUrl = new LdapUrl (ADsPath);
 					string fDn=lUrl.getDN();
 					if(fDn != null)
 						_Fdn = fDn;
 					else
-						_Fdn="";
+						_Fdn=String.Empty;
 				}
 				return _Fdn;
 			}
@@ -119,7 +124,7 @@
 		{
 			try			{
 				_conn= new LdapConnection ();
-				LdapUrl lUrl=new LdapUrl (Path);
+				LdapUrl lUrl = new LdapUrl (ADsPath);
 				_conn.Connect(lUrl.Host,lUrl.Port);
 				_conn.Bind(Username,Password);
 			}
@@ -135,15 +140,19 @@
 		/// Initializes the Entry specific properties e.g entry DN etc.
 		/// </summary>
 		void InitEntry()
-		{
-			LdapUrl lUrl=new LdapUrl (Path);
-			if(lUrl.getDN()!=null)			{
-				DN userDn = new DN(lUrl.getDN());
+		{			
+			LdapUrl lUrl = new LdapUrl (ADsPath);
+			string dn = lUrl.getDN();
+			if (dn != null ) {
+				if (String.Compare (dn,"rootDSE",true) == 0)
+					InitToRootDse (lUrl.Host,lUrl.Port);
+				else {
+				DN userDn = new DN (dn);
 				String[] lRdn = userDn.explodeDN(false);
 				_Name = (string)lRdn[0];
 				_Parent = new DirectoryEntry(conn);
-				LdapUrl cUrl=new LdapUrl(lUrl.Host,lUrl.Port,userDn.Parent.ToString());
-				_Parent.Path=cUrl.ToString();
+				_Parent.Path = GetLdapUrlString (lUrl.Host,lUrl.Port,userDn.Parent.ToString ());
+				}
 			}
 			else			{
 				_Name=lUrl.Host+":"+lUrl.Port;
@@ -273,7 +282,7 @@
 		{
 			get 
 			{
-				_Children = new DirectoryEntries(Path, conn);
+				_Children = new DirectoryEntries(ADsPath, conn);
 				return _Children;
 			}
 		}
@@ -314,7 +323,7 @@
 		{
 			get								{
 				if(_Name==null)				{
-					if(CheckEntry(conn,Path))
+					if(CheckEntry(conn,ADsPath))
 						InitEntry();
 					else
 						throw new SystemException("There is no such object on the server");
@@ -334,7 +343,7 @@
 		{
 			get			{
 				if(_Parent==null)				{
-					if(CheckEntry(conn,Path))
+					if(CheckEntry(conn,ADsPath))
 						InitEntry();
 					else
 						throw new SystemException("There is no such object on the server");
@@ -484,9 +493,28 @@
 				return _Path;
 			}
 			set			{
-				_Path = value;
+				if (value == null)
+					_Path = String.Empty;
+				else
+					_Path = value;
 			}
+		}
 
+		internal string ADsPath
+		{
+			get	{
+				if (Path == null || Path == String.Empty) {
+					DirectoryEntry rootDse = new DirectoryEntry ();
+					rootDse.InitToRootDse (null,-1);
+					string namingContext = (string) rootDse.Properties ["defaultNamingContext"].Value;
+					if ( namingContext == null )
+						namingContext = (string) rootDse.Properties ["namingContexts"].Value;
+
+					LdapUrl actualUrl= new LdapUrl (DefaultHost,DefaultPort,namingContext);
+					return actualUrl.ToString ();
+				}
+				return Path;
+			}
 		}
 
 		/// <summary>
@@ -501,51 +529,7 @@
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
+				return GetProperties (true);
 			}
 		}
 
@@ -579,12 +563,134 @@
 		public DirectoryEntry SchemaEntry 
 		{
 			[MonoTODO]
-			get			{
+			get			{
 				throw new NotImplementedException();
 			}
 		}
 
+		private string DefaultHost
+		{
+			get {
+				string defaultHost = (string) AppDomain.CurrentDomain.GetData (DEFAULT_LDAP_HOST);
+
+				if (defaultHost == null) {
+					NameValueCollection config = (NameValueCollection) ConfigurationSettings.GetConfig ("System.DirectoryServices/Settings");
+					if (config != null) 
+						defaultHost = config ["servername"];
+
+					if (defaultHost == null) 
+						defaultHost = "localhost";
+
+					AppDomain.CurrentDomain.SetData (DEFAULT_LDAP_HOST,defaultHost);
+				}
+				return defaultHost;
+			}
+		}
+
+		private int DefaultPort
+		{
+			get {
+				string defaultPortStr = (string) AppDomain.CurrentDomain.GetData (DEFAULT_LDAP_PORT);
+
+				if (defaultPortStr == null) {
+					NameValueCollection config = (NameValueCollection) ConfigurationSettings.GetConfig ("System.DirectoryServices/Settings");
+					if (config != null)
+						defaultPortStr = config ["port"];
+
+					if (defaultPortStr == null) 
+						defaultPortStr = "389";
+
+					AppDomain.CurrentDomain.SetData (DEFAULT_LDAP_PORT,defaultPortStr);
+				}
+				return Int32.Parse (defaultPortStr);
+			}
+		}
+
+		private void InitToRootDse(string host,int port)
+		{
+			if ( host == null )
+				host = DefaultHost;
+			if ( port < 0 )
+				port = DefaultPort;	
+		
+			LdapUrl rootPath = new LdapUrl (host,port,String.Empty);
+			string [] attrs = new string [] {"+","*"};
+			DirectoryEntry rootEntry = new DirectoryEntry (rootPath.ToString (),this.Username,this.Password,this.AuthenticationType);
+			DirectorySearcher searcher = new DirectorySearcher (rootEntry,null,attrs,SearchScope.Base);
+
+			SearchResult result = searcher.FindOne ();			
+			// copy properties from search result
+			PropertyCollection pcoll = new PropertyCollection ();
+			foreach (string propertyName in result.Properties.PropertyNames) {
+				System.Collections.IEnumerator enumerator = result.Properties [propertyName].GetEnumerator ();
+				if (enumerator != null)
+					while (enumerator.MoveNext ())
+						if (String.Compare (propertyName,"ADsPath",true) != 0)
+							pcoll [propertyName].Add (enumerator.Current);
+			}			
+			this.SetProperties (pcoll);
+			this._Name = "rootDSE";
+		}
+
+		private void SetProperties(PropertyCollection pcoll)
+		{
+			_Properties = pcoll;
+		}
+
 		/// <summary>
+		/// Returns entry properties.
+		/// </summary>
+		/// <param name="forceLoad">Specifies whenever to force the properties load from the server if local property cache is empty.</param>
+		/// <returns></returns>
+		private PropertyCollection GetProperties(bool forceLoad)
+		{
+			if (_Properties == null) {
+				// load properties into a different collection 
+				// to preserve original collection state if exception occurs
+				PropertyCollection properties = new PropertyCollection (this);
+				if (forceLoad && !Nflag)				
+					LoadProperties (properties,null);
+
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
+				LdapSearchResults lsc=conn.Search (Fdn,LdapConnection.SCOPE_BASE,"objectClass=*",null,false);
+				if (lsc.hasMore ()) {
+					LdapEntry nextEntry = lsc.next ();
+					string [] lowcasePropertyNames = null;
+					int length = 0;
+					if (propertyNames != null) {
+						length = propertyNames.Length;
+						lowcasePropertyNames = new string [length];
+						for(int i=0; i < length; i++)
+							lowcasePropertyNames [i] = propertyNames [i].ToLower ();
+					}
+					foreach (LdapAttribute attribute in nextEntry.getAttributeSet ())	{
+						string attributeName = attribute.Name;
+						if ((propertyNames == null) || (Array.IndexOf (lowcasePropertyNames,attributeName.ToLower ()) != -1)) {
+							properties [attributeName].Value = null;
+							properties [attributeName].AddRange (attribute.StringValueArray);
+							properties [attributeName].Mbit=false;
+						}
+					}
+				}
+			}
+			finally {
+				_inPropertiesLoading = false;
+			}
+		}
+
+		/// <summary>
 		/// Searches an entry in the Ldap directory and returns the attribute value
 		/// </summary>
 		/// <param name="attrName">attribute whose value is required</param>
@@ -651,8 +757,12 @@
 			string eDn=lUrl.getDN();
 			if(eDn==null)
 			{
-				eDn="";
+				eDn = String.Empty;
 			}
+			// rootDSE is a "virtual" entry that always exists
+			else if (String.Compare (eDn,"rootDSE",true) == 0)
+				return true;
+
 			string[] attrs={"objectClass"};
 			try
 			{
@@ -862,38 +972,37 @@
 		/// </remarks>
 		public void CommitChanges()
 		{
-			if(UsePropertyCache) 
-			{
-				CommitEntry();
-			}
-		}
-
-		private void CommitEntry()
+			if(UsePropertyCache) 
+			{
+				CommitEntry();
+			}
+		}
+
+		private void CommitEntry()
 		{
+			PropertyCollection properties = GetProperties(false);
 			if(!Nflag)
 			{
 				System.Collections.ArrayList modList = new System.Collections.ArrayList();
-				System.Collections.IDictionaryEnumerator id = Properties.GetEnumerator();
-				while(id.MoveNext())
+				foreach (string attribute in properties.PropertyNames)
 				{
-					string attribute=(string)id.Key;
 					LdapAttribute attr=null;
-					if(Properties[attribute].Mbit)
+					if (properties [attribute].Mbit)
 					{
-						if(Properties[attribute].Count==1)
+						if (properties [attribute].Count == 1)
 						{
-							String val = (String)Properties[attribute].Value;
+							string val = (string) properties [attribute].Value;
 							attr = new LdapAttribute( attribute , val);
 						}
 						else
 						{
-							Object[] vals=(Object [])Properties[attribute].Value;
-							String[] aStrVals= new String[Properties[attribute].Count];
-							Array.Copy(vals,0,aStrVals,0,Properties[attribute].Count);
+							object[] vals =(object []) properties [attribute].Value;
+							string[] aStrVals = new string [properties [attribute].Count];
+							Array.Copy (vals,0,aStrVals,0,properties [attribute].Count);
 							attr = new LdapAttribute( attribute , aStrVals);
 						}
 						modList.Add( new LdapModification(LdapModification.REPLACE, attr));
-						Properties[attribute].Mbit=false;
+						properties [attribute].Mbit=false;
 					}
 				}
 				if (modList.Count > 0) {
@@ -906,20 +1015,18 @@
 			else
 			{
 				LdapAttributeSet attributeSet = new LdapAttributeSet();
-				System.Collections.IDictionaryEnumerator id = Properties.GetEnumerator();
-				while(id.MoveNext())
+				foreach (string attribute in properties.PropertyNames)
 				{
-					string attribute=(string)id.Key;
-					if(Properties[attribute].Count==1)
+					if (properties [attribute].Count == 1)
 					{
-						String val = (String)Properties[attribute].Value;
+						string val = (string) properties [attribute].Value;
 						attributeSet.Add(new LdapAttribute(attribute, val));                
 					}
 					else
 					{
-						Object[] vals=(Object [])Properties[attribute].Value;
-						String[] aStrVals= new String[Properties[attribute].Count];
-						Array.Copy(vals,0,aStrVals,0,Properties[attribute].Count);
+						object[] vals = (object []) properties [attribute].Value;
+						string[] aStrVals = new string [properties [attribute].Count];
+						Array.Copy (vals,0,aStrVals,0,properties [attribute].Count);
 						attributeSet.Add( new LdapAttribute( attribute , aStrVals));
 					}
 				}
@@ -929,12 +1036,12 @@
 			}
 		}
 
-		internal void CommitDeferred()
-		{
-			if (!_inPropertiesLoading && !UsePropertyCache && !Nflag) 
-			{
-				CommitEntry();
-			}
+		internal void CommitDeferred()
+		{
+			if (!_inPropertiesLoading && !UsePropertyCache && !Nflag) 
+			{
+				CommitEntry();
+			}
 		}
 
 		void RefreshEntry()
@@ -947,16 +1054,23 @@
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
@@ -966,5 +1080,15 @@
 			}
 			base.Dispose (disposing);
 		}
+
+		internal static string GetLdapUrlString(string host, int port, string dn)
+		{
+			LdapUrl lUrl;
+			if (port == LdapConnection.DEFAULT_PORT)
+				lUrl = new LdapUrl (host,0,dn);
+			else
+				lUrl = new LdapUrl (host,port,dn);
+			return lUrl.ToString();
+		}
 	}
 }
Index: System.DirectoryServices/PropertyValueCollection.cs
===================================================================
--- System.DirectoryServices/PropertyValueCollection.cs	(revision 45938)
+++ System.DirectoryServices/PropertyValueCollection.cs	(working copy)
@@ -135,6 +135,7 @@
 				copy_to[index++] = o;
 		}
 
+		[MonoTODO]
 		protected override void OnClearComplete ()
 		{
 			if (_parent != null) {
@@ -142,6 +143,7 @@
 			}
 		}
 
+		[MonoTODO]
 		protected override void OnInsertComplete (int index, object value)
 		{
 			if (_parent != null) {
@@ -149,6 +151,7 @@
 			}
 		}
 
+		[MonoTODO]
 		protected override void OnRemoveComplete (int index, object value)
 		{
 			if (_parent != null) {
@@ -156,6 +159,7 @@
 			}
 		}
 
+		[MonoTODO]
 		protected override void OnSetComplete (int index, object oldValue, object newValue)
 		{
 			if (_parent != null) {
Index: System.DirectoryServices/SearchResult.cs
===================================================================
--- System.DirectoryServices/SearchResult.cs	(revision 45938)
+++ System.DirectoryServices/SearchResult.cs	(working copy)
@@ -109,7 +109,7 @@
 								String val = (String)Rproperties[attribute].Value;
 								rpVal.Add(val);
 							}
-							else
+							else if (Rproperties[attribute].Count > 1)
 							{
 								Object[] vals=(Object [])Rproperties[attribute].Value;
 //								String[] aStrVals= new String[_Entry.Properties[attribute].Count];
