diff --git a/src/Foundation/Enum.cs b/src/Foundation/Enum.cs
index d776505..3334f1d 100644
--- a/src/Foundation/Enum.cs
+++ b/src/Foundation/Enum.cs
@@ -267,4 +267,43 @@ namespace MonoMac.Foundation  {
 		ErrorOccurred = 1 << 3,
 		EndEncountered = 1 << 4
 	}
+	
+	//Added by Kenneth J. Pouncey 2010/11/19
+	public enum NSComparisonPredicateModifier
+	{
+		Direct=0,
+		All,
+		Any
+	}
+
+	public enum NSPredicateOperatorType
+	{
+		LessThan = 0,
+		LessThanOrEqualTo,
+		GreaterThan,
+		GreaterThanOrEqualTo,
+		EqualTo,
+		NotEqualTo,
+		Matches,
+		Like,
+		BeginsWith,
+		EndsWith,
+		In,
+		CustomSelector,
+		Contains,
+		Between
+	}
+	
+	public enum NSComparisonPredicateOptions : uint
+	{
+		CaseInsensitive=0x01,
+		DiacriticInsensitive=0x02
+	}	
+	
+	public enum NSCompoundPredicateType
+	{
+		Not = 0,
+		And,
+		Or
+	}	
 }
diff --git a/src/Foundation/NSDictionary.cs b/src/Foundation/NSDictionary.cs
index 8ef3cb4..d82338f 100644
--- a/src/Foundation/NSDictionary.cs
+++ b/src/Foundation/NSDictionary.cs
@@ -28,6 +28,24 @@ using MonoMac.ObjCRuntime;
 namespace MonoMac.Foundation {
 
 	public partial class NSDictionary : IDictionary, IDictionary<NSObject, NSObject> {
+		
+		public static NSDictionary FromObjectsAndKeys (NSObject [] objects, NSObject [] keys)
+		{
+			if (objects.Length != keys.Length)
+				throw new ArgumentException ("objects and keys arrays have different sizes");
+			return FromObjectsAndKeysInternal (objects, keys);
+		}
+
+		public static NSDictionary FromObjectsAndKeys (NSObject [] objects, NSObject [] keys, int count)
+		{
+			if (objects.Length != keys.Length)
+				throw new ArgumentException ("objects and keys arrays have different sizes");
+			if (count < 1 || objects.Length < count || keys.Length < count)
+				throw new ArgumentException ("count");
+			
+			return FromObjectsAndKeysInternal (objects, keys);
+		}
+		
 		internal bool ContainsKeyValuePair (KeyValuePair<NSObject, NSObject> pair)
 		{
 			NSObject value;
diff --git a/src/Foundation/NSMutableDictionary.cs b/src/Foundation/NSMutableDictionary.cs
index bece217..29ed853 100644
--- a/src/Foundation/NSMutableDictionary.cs
+++ b/src/Foundation/NSMutableDictionary.cs
@@ -199,15 +199,16 @@ namespace MonoMac.Foundation {
 		}
 
 		static readonly NSObject marker = new NSObject ();
-
-		public bool ContainsKey (NSObject key)
-		{
-			if (key == null)
-				throw new ArgumentNullException ("key");
-			var keys   = NSArray.FromNSObjects (new [] {key});
-			var values = ObjectsForKeys (keys, marker);
-			return object.ReferenceEquals (marker, values [0]);
-		}
+		
+		// Commented out as this was not working.  Kenneth J. Pouncey 2010/11/18
+//		public bool ContainsKey (NSObject key)
+//		{
+//			if (key == null)
+//				throw new ArgumentNullException ("key");
+//			var keys   = NSArray.FromNSObjects (new [] {key});
+//			var values = ObjectsForKeys (keys, marker);
+//			return object.ReferenceEquals (marker, values [0]);
+//		}
 
 		public bool Remove (NSObject key)
 		{
diff --git a/src/foundation.cs b/src/foundation.cs
index aaa7dbb..b2505e9 100644
--- a/src/foundation.cs
+++ b/src/foundation.cs
@@ -2053,6 +2053,40 @@ namespace MonoMac.Foundation
 
 		[Field ("NSKeyValueChangeNotificationIsPriorKey")]
 		NSString ChangeNotificationIsPriorKey { get; }
+
+       // Cocoa Bindings added by Kenneth J. Pouncey 2010/11/17
+        [Export ("exposedBindings")]
+        NSString[] ExposedBindings ();
+
+        [Export ("valueClassForBinding:")]
+        Class BindingValueClass (string binding);
+
+        [Export ("bind:toObject:withKeyPath:options:")]
+        void Bind (string binding, NSObject observable, string keyPath, [NullAllowed] NSDictionary options);
+
+        [Export ("unbind:")]
+        void Unbind (string binding);
+
+        [Export ("infoForBinding:")]
+        NSDictionary BindingInfo (string binding);
+
+        [Export ("optionDescriptionsForBinding:")]
+        NSObject[] BindingOptionDescriptions (string aBinding);
+
+        [Static]
+        [Export ("defaultPlaceholderForMarker:withBinding:")]
+        NSObject BindingDefaultPlaceholder (NSObject marker, string binding);
+
+        [Export ("objectDidEndEditing:")]
+        void ObjectDidEndEditing (NSObject editor);
+
+        [Export ("commitEditing")]
+        bool CommitEditing ();
+
+        [Export ("commitEditingWithDelegate:didCommitSelector:contextInfo:")]
+        //void CommitEditingWithDelegateDidCommitSelectorContextInfo (NSObject objDelegate, Selector didCommitSelector, IntPtr contextInfo);
+        void CommitEditing (NSObject objDelegate, Selector didCommitSelector, IntPtr contextInfo);
+		
 	}
 	
 	[BaseType (typeof (NSObject))]
@@ -3207,13 +3241,6 @@ namespace MonoMac.Foundation
 		uint ActiveProcessorCount { get; }
 	}
 
-	[BaseType (typeof (NSObject))]
-	[Since (4,0)]
-	interface NSPredicate {
-		[Export ("evaluateWithObject:")]
-		bool EvaluateWithObject (NSObject obj);
-	}
-
 	[BaseType (typeof (NSMutableData))]
 	[Since (4,0)]
 	interface NSPurgeableData {
@@ -3622,5 +3649,273 @@ namespace MonoMac.Foundation
 		void FailedWithError(NSUrlDownload download, NSError error);
 	}
 #endif
+
+	[BaseType (typeof (NSObject))]
+	[Since (4,0)]
+	interface NSPredicate {
+
+		
+		[Static]
+		[Export ("predicateWithFormat:argumentArray:")]
+		NSPredicate FromFormat (string predicateFormat, NSObject[] arguments);
+
+		//[Static]
+		//[Export ("predicateWithFormat:...")]
+		//NSPredicate PredicateWithFormat... (string predicateFormat,, );
+
+		//[Static]
+		//[Export ("predicateWithFormat:arguments:")]
+		//NSPredicate PredicateWithFormatarguments (string predicateFormat, va_list argList);
+
+		[Static]
+		[Export ("predicateWithValue:")]
+		//NSPredicate PredicateWithValue (bool value);
+		NSPredicate FromValue (bool value);
+
+		//[Export ("predicateWithBlock:idevaluatedObject,NSDictionary*bindings))block")]
+		//NSPredicate PredicateWithBlockidevaluatedObject,NSDictionary*bindings))block (BOOL (^ (id, );
+		
+
+		[Export ("predicateFormat")]
+		string PredicateFormat { get; }
+
+		[Export ("predicateWithSubstitutionVariables:")]
+		NSPredicate PredicateWithSubstitutionVariables (NSDictionary variables);
+
+		[Export ("evaluateWithObject:")]
+		bool EvaluateWithObject (NSObject obj);
+
+		[Export ("evaluateWithObject:substitutionVariables:")]
+		bool EvaluateWithObject (NSObject obj, NSDictionary bindings);
+		
+	}
+
+	
+	[BaseType (typeof (NSPredicate))]
+	interface NSComparisonPredicate {
+		[Static]
+		[Export ("predicateWithLeftExpression:rightExpression:modifier:type:options:")]
+		//NSPredicate PredicateWithLeftExpressionrightExpressionmodifiertypeoptions (NSExpression lhs, NSExpression rhs, NSComparisonPredicateModifier modifier, NSPredicateOperatorType type, uint options);
+		NSPredicate FromModifierTypeAndOptions ( NSExpression lhs, NSExpression rhs, NSComparisonPredicateModifier modifier, NSPredicateOperatorType type, NSComparisonPredicateOptions options);
+
+		[Static]
+		[Export ("predicateWithLeftExpression:rightExpression:customSelector:")]
+		//NSPredicate PredicateWithLeftExpressionrightExpressioncustomSelector (NSExpression lhs, NSExpression rhs, Selector selector);
+		NSPredicate FromSelector (NSExpression lhs, NSExpression rhs, Selector selector);
+
+		[Export ("initWithLeftExpression:rightExpression:modifier:type:options:")]
+		//NSObject InitWithLeftExpressionrightExpressionmodifiertypeoptions (NSExpression lhs, NSExpression rhs, NSComparisonPredicateModifier modifier, NSPredicateOperatorType type, uint options);
+		IntPtr Constructor (NSExpression lhs, NSExpression rhs, NSComparisonPredicateModifier modifier, NSPredicateOperatorType type, NSComparisonPredicateOptions options);
+		
+		[Export ("initWithLeftExpression:rightExpression:customSelector:")]
+		//NSObject InitWithLeftExpressionrightExpressioncustomSelector (NSExpression lhs, NSExpression rhs, Selector selector);
+		IntPtr Constructor (NSExpression lhs, NSExpression rhs, Selector selector);
+
+		[Export ("predicateOperatorType")]
+		NSPredicateOperatorType PredicateOperatorType { get; }
+
+		[Export ("comparisonPredicateModifier")]
+		NSComparisonPredicateModifier ComparisonPredicateModifier { get; }
+
+		[Export ("leftExpression")]
+		NSExpression LeftExpression { get; }
+
+		[Export ("rightExpression")]
+		NSExpression RightExpression { get; }
+
+		[Export ("customSelector")]
+		Selector CustomSelector { get; }
+
+		[Export ("options")]
+		NSComparisonPredicateOptions Options { get; }
+
+	}
+
+	[BaseType (typeof (NSPredicate))]
+	interface NSCompoundPredicate {
+		[Export ("initWithType:subpredicates:")]
+		IntPtr Constructor (NSCompoundPredicateType type, NSPredicate[] subpredicates);
+
+		[Export ("compoundPredicateType")]
+		NSCompoundPredicateType Type { get; }
+
+		[Export ("subpredicates")]
+		NSPredicate[] Subpredicates { get; } 
+
+		[Static]
+		[Export ("andPredicateWithSubpredicates:")]
+		NSPredicate AndPredicateWithSubpredicates (NSPredicate[] subpredicates);
+
+		[Static]
+		[Export ("orPredicateWithSubpredicates:")]
+		NSPredicate OrPredicateWithSubpredicates (NSArray subpredicates);
+
+		[Static]
+		[Export ("notPredicateWithSubpredicate:")]
+		NSPredicate NotPredicateWithSubpredicate (NSPredicate predicate);
+
+	}
+	
+	[BaseType (typeof (NSObject), Delegates=new string [] { "Delegate" }, Events=new Type [] { typeof (NSMetadataQueryDelegate)})]
+	interface NSMetadataQuery {
+		//[Export ("init")]
+		//NSObject Init ();
+		//IntPtr Constructor();
+		
+		[Export ("startQuery")]
+		bool StartQuery ();
+
+		[Export ("stopQuery")]
+		void StopQuery ();
+
+		[Export ("isStarted")]
+		bool IsStarted ();
+
+		[Export ("isGathering")]
+		bool IsGathering ();
+
+		[Export ("isStopped")]
+		bool IsStopped ();
+
+		[Export ("disableUpdates")]
+		void DisableUpdates ();
+
+		[Export ("enableUpdates")]
+		void EnableUpdates ();
+
+		[Export ("resultCount")]
+		uint ResultCount ();
+
+		[Export ("resultAtIndex:")]
+		NSObject ResultAtIndex (uint idx);
+
+		[Export ("results")]
+		NSMetadataItem[] Results ();
+
+		[Export ("indexOfResult:")]
+		uint IndexOfResult (NSObject result);
+
+		[Export ("valueLists")]
+		NSDictionary ValueLists ();
+
+		[Export ("groupedResults")]
+		NSArray GroupedResults ();
+
+		[Export ("valueOfAttribute:forResultAtIndex:")]
+		NSObject ValueOfAttributeforResultAtIndex (string attrName, uint idx);
+
+		//Detected properties
+		//[Export ("delegate")]
+		//NSMetadataQueryDelegate Delegate { get; set; }
+		[Export ("delegate", ArgumentSemantic.Assign), NullAllowed]
+		NSMetadataQueryDelegate WeakDelegate { get; set; }
+
+		[Wrap ("WeakDelegate")]
+		NSMetadataQueryDelegate Delegate { get; set; }
+		
+		[Export ("predicate")]
+		NSPredicate Predicate { get; set; }
+
+		[Export ("sortDescriptors")]
+		NSSortDescriptor[] SortDescriptors { get; set; }
+
+		[Export ("valueListAttributes")]
+		NSObject[] ValueListAttributes { get; set; }
+
+		[Export ("groupingAttributes")]
+		NSArray GroupingAttributes { get; set; }
+
+		[Export ("notificationBatchingInterval")]
+		double NotificationBatchingInterval { get; set; }
+
+		[Export ("searchScopes")]
+		NSArray SearchScopes { get; set; }
+		
+		// There is no info associated with these notifications
+		[Field ("NSMetadataQueryDidStartGatheringNotification")]
+		NSString DidStartGatheringNotification { get; }
+	
+		[Field ("NSMetadataQueryGatheringProgressNotification")]
+		NSString GatheringProgressNotification { get; }
+		
+		[Field ("NSMetadataQueryDidFinishGatheringNotification")]
+		NSString DidFinishGatheringNotification { get; }
+		
+		[Field ("NSMetadataQueryDidUpdateNotification")]
+		NSString DidUpdateNotification { get; }
+		
+		[Field ("NSMetadataQueryResultContentRelevanceAttribute")]
+		NSString ResultContentRelevanceAttribute { get; }
+		
+		// Scope constants for defined search locations
+		[Field ("NSMetadataQueryUserHomeScope")]
+		NSString UserHomeScope { get; }
+		
+		[Field ("NSMetadataQueryLocalComputerScope")]
+		NSString LocalComputerScope { get; }
+		
+		[Field ("NSMetadataQueryNetworkScope")]
+		NSString QueryNetworkScope { get; }
+	}
+
+	[BaseType (typeof (NSObject))]
+	[Model]
+	interface NSMetadataQueryDelegate {
+		[Export ("metadataQuery:replacementObjectForResultObject:"), EventArgs ("NSMetadataQueryObject"), DefaultValue(null)]
+		NSObject MetadataQueryReplacementObjectForResultObject (NSMetadataQuery query, NSMetadataItem result);
+
+		[Export ("metadataQuery:replacementValueForAttribute:value:"), EventArgs ("NSMetadataQueryValue"), DefaultValue(null)]
+		NSObject MetadataQueryReplacementValueForAttributevalue (NSMetadataQuery query, string attrName, NSObject attrValue);
+
+	}
+
+	[BaseType (typeof (NSObject))]
+	interface NSMetadataItem {
+		[Export ("valueForAttribute:")]
+		NSObject ValueForAttribute (string key);
+
+		[Export ("valuesForAttributes:")]
+		NSDictionary ValuesForAttributes (NSArray keys);
+
+		[Export ("attributes")]
+		NSArray Attributes ();
+
+	}
+
+	[BaseType (typeof (NSObject))]
+	interface NSMetadataQueryAttributeValueTuple {
+		[Export ("attribute")]
+		string Attribute ();
+
+		[Export ("value")]
+		NSObject Value ();
+
+		[Export ("count")]
+		uint Count ();
+
+	}
+
+	[BaseType (typeof (NSObject))]
+	interface NSMetadataQueryResultGroup {
+		[Export ("attribute")]
+		string Attribute ();
+
+		[Export ("value")]
+		NSObject Value ();
+
+		[Export ("subgroups")]
+		NSArray Subgroups ();
+
+		[Export ("resultCount")]
+		uint ResultCount ();
+
+		[Export ("resultAtIndex:")]
+		NSObject ResultAtIndex (uint idx);
+
+		[Export ("results")]
+		NSArray Results ();
+
+	}
+
 }
 
