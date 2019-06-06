Index: App.config
===================================================================
--- App.config	(revision 46985)
+++ App.config	(working copy)
@@ -11,6 +11,8 @@
       <Settings>
           <add key="servername" value="xp050"/>
           <add key="port" value="389"/>
+          <add key="securitymech" value="1.2.840.113554.1.2.2"/>
+          <add key="securityappname" value="com.mainsoft.system.directoryservices"/>
       </Settings>
   </System.DirectoryServices>
 </configuration>
Index: System.DirectoryServices.vmwcsproj
===================================================================
--- System.DirectoryServices.vmwcsproj	(revision 46985)
+++ System.DirectoryServices.vmwcsproj	(working copy)
@@ -8,8 +8,6 @@
 			</Settings>
 			<References>
 				<Reference Name="System" AssemblyName="System" HintPath="..\..\WINDOWS\Microsoft.NET\Framework\v1.1.4322\System.dll"/>
-				<Reference Name="System.Data" AssemblyName="System.Data" HintPath="..\..\WINDOWS\Microsoft.NET\Framework\v1.1.4322\System.Data.dll"/>
-				<Reference Name="System.Xml" AssemblyName="System.Xml" HintPath="..\..\WINDOWS\Microsoft.NET\Framework\v1.1.4322\System.Xml.dll"/>
 				<Reference Name="Novell.Directory.Ldap" Project="{0B45F886-E6BB-4871-B9C1-77A0D92DA76E}" Package="{83B010C7-76FC-4FAD-A26C-00D7EFE60256}"/>
 			</References>
 		</Build>
@@ -46,6 +44,6 @@
 				<File RelPath="System.DirectoryServices.Design\DirectoryEntryConverter.cs" SubType="Code" BuildAction="Compile"/>
 			</Include>
 		</Files>
-		<UserProperties project.JDKType="1.4.2_05" REFS.JarPath.system.xml="..\..\Program Files\Mainsoft\Visual MainWin for J2EE\jgac\vmw4j2ee_110\System.Xml.jar" REFS.JarPath.system.data="..\..\Program Files\Mainsoft\Visual MainWin for J2EE\jgac\vmw4j2ee_110\System.Data.jar" REFS.JarPath.system="..\..\Program Files\Mainsoft\Visual MainWin for J2EE\jgac\vmw4j2ee_110\System.jar"/>
+		<UserProperties project.JDKType="1.4.2_05" REFS.JarPath.system="..\..\Program Files\Mainsoft\Visual MainWin for J2EE\jgac\vmw4j2ee_110\System.jar" jarserver="ipa"/>
 	</CSHARP>
 	<VisualMainWin><Project Prop2023="1.4.2_05" Prop2024="" Prop2026="" Prop2015="" Version="1.6.0" ProjectType="1"/><References/><Configs><Config Prop2000="1" Prop2001="0" Prop2002="0" Prop2003="0" Prop2004="0" Prop2005="0" Prop2006="" Prop2007="" Prop2008="" Prop2009="" Prop2010="" Prop2011="-1" Prop2012="0" Prop2013="" Prop2014="0" Prop2016="" Prop2027="" Prop2019="0" Prop2020="285212672" Prop2021="4096" Prop2022="0" Prop2017="0" Prop2018="-1" Name="Debug"/><Config Prop2000="0" Prop2001="0" Prop2002="0" Prop2003="0" Prop2004="0" Prop2005="0" Prop2006="" Prop2007="" Prop2008="" Prop2009="" Prop2010="" Prop2011="-1" Prop2012="0" Prop2013="" Prop2014="0" Prop2016="" Prop2027="" Prop2019="0" Prop2020="285212672" Prop2021="4096" Prop2022="0" Prop2017="0" Prop2018="0" Name="Release_Java"/><Config Prop2000="0" Prop2001="0" Prop2002="0" Prop2003="0" Prop2004="0" Prop2005="0" Prop2006="" Prop2007="" Prop2008="" Prop2009="" Prop2010="" Prop2011="-1" Prop2012="0" Prop2013="" Prop2014="0" Prop2016="" Prop2027="" Prop2019="0" Prop2020="285212672" Prop2021="4096" Prop2022="0" Prop2017="0" Prop2018="-1" Name="Debug_Java"/></Configs></VisualMainWin></VisualStudioProject>
Index: ChangeLog
===================================================================
--- ChangeLog	(revision 46985)
+++ ChangeLog	(working copy)
@@ -1,3 +1,7 @@
+2005-28-07  Boris Kirzner <borisk@mainsoft.com>
+	* System.DirectoryServices.vmwcsproj: updated TARGET_JVM project file.
+	* App.config: added addition supported key examples.
+
 2005-05-07  Boris Kirzner <borisk@mainsoft.com>	
 	* System.DirectoryServices.vmwcsproj: Project file converted 
 	to Developer Edition format. Removed ClearCase references.
Index: System.DirectoryServices/ChangeLog
===================================================================
--- System.DirectoryServices/ChangeLog	(revision 46985)
+++ System.DirectoryServices/ChangeLog	(working copy)
@@ -1,3 +1,7 @@
+2005-28-07  Boris Kirzner <borisk@mainsoft.com>
+	* DirectoryEntry.cs: pass AuthenticationType as a parameter for
+	LdapConnection.Bind.
+
 2005-06-19 Boris Kirzner <borisk@mainsoft.coim>
 	* DirectorySearcher.cs: 
 		- Use ADsPath property (always represents an actual url) 
Index: System.DirectoryServices/DirectoryEntry.cs
===================================================================
--- System.DirectoryServices/DirectoryEntry.cs	(revision 46985)
+++ System.DirectoryServices/DirectoryEntry.cs	(working copy)
@@ -126,7 +126,7 @@
 				_conn= new LdapConnection ();
 				LdapUrl lUrl = new LdapUrl (ADsPath);
 				_conn.Connect(lUrl.Host,lUrl.Port);
-				_conn.Bind(Username,Password);
+				_conn.Bind(Username,Password, (Novell.Directory.Ldap.AuthenticationTypes)AuthenticationType);
 			}
 			catch(LdapException ex)			{
 				throw ex;
