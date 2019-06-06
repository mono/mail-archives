diff --git a/samples/PopupBindings/Person.cs b/samples/PopupBindings/Person.cs
index a98fb32..bfb5065 100644
--- a/samples/PopupBindings/Person.cs
+++ b/samples/PopupBindings/Person.cs
@@ -8,87 +8,100 @@ namespace PopupBindings
 {
 	public partial class Person : NSObject
 	{
-		NSMutableDictionary personValues;
-		static NSString NAME = new NSString ("name");
-		static NSString AGE = new NSString ("age");
-		static NSString ADDRESS_STREET = new NSString ("addressStreet");
-		static NSString ADDRESS_CITY = new NSString ("addressCity");
-		static NSString ADDRESS_STATE = new NSString ("addressState");
-		static NSString ADDRESS_ZIP = new NSString ("addressZip");
-		
-		public Person (NSMutableDictionary attributes)
+		Dictionary<string, object> personValues;
+		static string NAME = "name";
+		static string AGE = "age";
+		static string ADDRESS_STREET = "addressStreet";
+		static string ADDRESS_CITY = "addressCity";
+		static string ADDRESS_STATE = "addressState";
+		static string ADDRESS_ZIP = "addressZip";
+
+		string[] keys = new string[] {NAME,AGE,ADDRESS_STREET,ADDRESS_CITY, ADDRESS_STATE,ADDRESS_ZIP};
+
+		public Person (object[] attributes)
 		{
-			this.personValues = new NSMutableDictionary(attributes);	
+			Dictionary<string,object> newAttributes = new Dictionary<string, object>();
+			for (int x = 0; x < keys.Length; x++)
+			{
+				newAttributes.Add(keys[x],attributes[x]);
+			}
+
+			this.personValues = newAttributes;	
 		}
 		
 		[Export ("name")]
-		public NSString Name
+		public string Name
 		{
 			get {
-				return (NSString) personValues.ObjectForKey (NAME);	
+				return personValues[NAME].ToString();	
+			}
+			
+			set
+			{
+				personValues[NAME] = value;
 			}
 		}
 
 		[Export ("age")]
-		public NSNumber Age {
+		public int Age {
 			get {
-				return (NSNumber) personValues.ObjectForKey (AGE);	
+				return (int)personValues[AGE];	
+			}
+			set
+			{
+				personValues[AGE] = value;
 			}
-		}
-		
-		// Get a value for a key.  Not using this method but instead
-		//  used the [Export("xxxxxx")] method.
-		//public override NSObject ValueForKey (NSString key)
-		//{
-		//	return attributeValues[key];
-		//}
-		
-		public override void SetValueForKey (NSObject value, NSString key)
-		{
-			
-			if (personValues.ContainsKey (key))
-				personValues [key] = value;	
-			else
-				base.SetValueForKey (value, key);
-
-			// you can also just do a simple:
-			//attributeValues[key] = value;
-			
 		}
 		
 		[Export("addressStreet")]
-		public NSString AddressStreet {
+		public string AddressStreet {
 			get {
-				return (NSString) personValues [ADDRESS_STREET];	
+				return personValues[ADDRESS_STREET].ToString();	
+			}
+			set
+			{
+				personValues[ADDRESS_STREET] = value;
 			}
 		}
 		
 		[Export("addressCity")]
-		public NSString AddressCity {
+		public string AddressCity {
 			get {
-				return (NSString)personValues[ADDRESS_CITY];	
+				return personValues[ADDRESS_CITY].ToString();	
+			}
+			set
+			{
+				personValues[ADDRESS_CITY] = value;
 			}
 		}
 		
 		[Export ("addressState")]
-		public NSString AddressState {
+		public string AddressState {
 			get {
-				return (NSString)personValues[ADDRESS_STATE];	
+				return personValues[ADDRESS_STATE].ToString();	
+			}
+			set
+			{
+				personValues[ADDRESS_STATE] = value;
 			}
 		}
 		
 		[Export ("addressZip")]
-		public NSString AddressZip {
+		public string AddressZip {
 			get {
-				return (NSString)personValues.ObjectForKey(ADDRESS_ZIP);	
+				return personValues[ADDRESS_ZIP].ToString();	
+			}
+			set
+			{
+				personValues[ADDRESS_ZIP] = value;
 			}
 		}
 		
-		public NSMutableDictionary Attributes
+		public Dictionary<string,object> Attributes
 		{
 			get { return personValues; }
 			set {
-				personValues = NSMutableDictionary.FromDictionary(value);	
+				personValues = value;	
 			}
 		}
 		
diff --git a/samples/PopupBindings/PopupBindings.csproj b/samples/PopupBindings/PopupBindings.csproj
index 90529fd..5ef6af4 100644
--- a/samples/PopupBindings/PopupBindings.csproj
+++ b/samples/PopupBindings/PopupBindings.csproj
@@ -66,10 +66,8 @@
   </ItemGroup>
   <ItemGroup>
     <None Include="Info.plist" />
+    <None Include="README.md" />
   </ItemGroup>
   <Import Project="$(MSBuildBinPath)\Microsoft.CSharp.targets" />
   <Import Project="$(MSBuildExtensionsPath)\Mono\MonoMac\v0.0\Mono.MonoMac.targets" />
-  <ItemGroup>
-    <Content Include="ReadMe.txt" />
-  </ItemGroup>
 </Project>
\ No newline at end of file
diff --git a/samples/PopupBindings/TestWindowController.cs b/samples/PopupBindings/TestWindowController.cs
index c61ebeb..f7c4253 100644
--- a/samples/PopupBindings/TestWindowController.cs
+++ b/samples/PopupBindings/TestWindowController.cs
@@ -10,16 +10,6 @@ namespace PopupBindings
 	public partial class TestWindowController : MonoMac.AppKit.NSWindowController
 	{
 		
-		static NSString NAME = new NSString("name");
-		static NSString AGE = new NSString("age");
-		static NSString ADDRESS_STREET = new NSString("addressStreet");
-		static NSString ADDRESS_CITY = new NSString("addressCity");
-		static NSString ADDRESS_STATE = new NSString("addressState");
-		static NSString ADDRESS_ZIP = new NSString("addressZip");
-
-		List<NSObject> keys = new List<NSObject> {NAME,AGE,ADDRESS_STREET,ADDRESS_CITY,
-														ADDRESS_STATE,ADDRESS_ZIP};
-		
 		#region Constructors
 
 		// Called when created from unmanaged code
@@ -57,39 +47,39 @@ namespace PopupBindings
 		{
 			//base.AwakeFromNib ();
 			
-			List<NSObject> values = new List<NSObject> {new NSString("Joe Smith"),
-				                                        NSNumber.FromInt32(21),
-				                                        new NSString("451 University Avenue"),
-				                                        new NSString("Palo Alto"), 
-														new NSString("CA"),
-				                                        new NSString("94301")};
+			object[] values = new object[] {"Joe Smith",
+				                                        21,
+				                                        "451 University Avenue",
+				                                        "Palo Alto", 
+									"CA",
+				                                        "94301"};
 
 			addNewPerson(values);
 
-			values = new List<NSObject> {new NSString("John Doe"),
-				                                        NSNumber.FromInt32(31),
-				                                        new NSString("767 Fifth Ave."),
-				                                        new NSString("New York"), 
-														new NSString("NY"),
-				                                        new NSString("10153")};
+			values = new object[] {"John Doe",
+		                                       31,
+		                                        "767 Fifth Ave.",
+		                                        "New York", 
+							"NY",
+		                                        "10153"};
 
 			addNewPerson(values);
 			
-			values = new List<NSObject> {new NSString("Sally Sixpack"),
-				                                        NSNumber.FromInt32(41),
-				                                        new NSString("679 North Michigan Ave."),
-				                                        new NSString("Chicago"), 
-														new NSString("IL"),
-				                                        new NSString("60611")};
+			values = new object[] {"Sally Sixpack",
+		                                        41,
+		                                        "679 North Michigan Ave.",
+		                                        "Chicago", 
+							"IL",
+		                                        "60611"};
 
 			addNewPerson(values);
 			
-			values = new List<NSObject> {new NSString("John Q. Public"),
-				                                        NSNumber.FromInt32(141),
-				                                        new NSString("5085 Westheimer Rd."),
-				                                        new NSString("Houston"), 
-														new NSString("TX"),
-				                                        new NSString("77056")};
+			values = new object[] {"John Q. Public",
+		                                        141,
+		                                        "5085 Westheimer Rd.",
+		                                        "Houston", 
+							"TX",
+		                                        "77056"};
 
 			addNewPerson(values);			
 
@@ -97,10 +87,9 @@ namespace PopupBindings
 			arrayController.SelectionIndex = 0;
 		}
 		
-		private void addNewPerson(List<NSObject> properties)
+		private void addNewPerson(object[] properties)
 		{
-			NSMutableDictionary propertiesDict = NSMutableDictionary.FromObjectsAndKeys(properties.ToArray(),keys.ToArray());
-			arrayController.AddObject(new Person(propertiesDict));			
+			arrayController.AddObject(new Person(properties));			
 		}
 	}
 }
