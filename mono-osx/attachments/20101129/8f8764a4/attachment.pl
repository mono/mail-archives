diff --git a/src/Foundation/Enum.cs b/src/Foundation/Enum.cs
index d776505..c0bce7f 100644
--- a/src/Foundation/Enum.cs
+++ b/src/Foundation/Enum.cs
@@ -267,4 +267,44 @@ namespace MonoMac.Foundation  {
 		ErrorOccurred = 1 << 3,
 		EndEncountered = 1 << 4
 	}
+
+    //Added by Kenneth J. Pouncey 2010/11/29
+    public enum NSComparisonPredicateModifier
+    {
+        Direct=0,
+        All,
+        Any
+    }
+
+    public enum NSPredicateOperatorType
+    {
+        LessThan = 0,
+        LessThanOrEqualTo,
+        GreaterThan,
+        GreaterThanOrEqualTo,
+        EqualTo,
+        NotEqualTo,
+        Matches,
+        Like,
+        BeginsWith,
+        EndsWith,
+        In,
+        CustomSelector,
+        Contains,
+        Between
+    }
+   
+    public enum NSComparisonPredicateOptions : uint
+    {
+        CaseInsensitive=0x01,
+        DiacriticInsensitive=0x02
+    }   
+   
+    public enum NSCompoundPredicateType
+    {
+        Not = 0,
+        And,
+        Or
+    }   
+  	
 }
diff --git a/src/foundation.cs b/src/foundation.cs
index 8e08a5e..e070c68 100644
--- a/src/foundation.cs
+++ b/src/foundation.cs
@@ -3303,13 +3303,6 @@ namespace MonoMac.Foundation
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
@@ -3718,5 +3711,273 @@ namespace MonoMac.Foundation
 		void FailedWithError(NSUrlDownload download, NSError error);
 	}
 #endif
+	
+	//Added by Kenneth J. Pouncey 2010/11/29
+    [BaseType (typeof (NSObject))]
+    [Since (4,0)]
+    interface NSPredicate {
+
+       
+        [Static]
+        [Export ("predicateWithFormat:argumentArray:")]
+        NSPredicate FromFormat (string predicateFormat, NSObject[] arguments);
+
+        //[Static]
+        //[Export ("predicateWithFormat:...")]
+        //NSPredicate PredicateWithFormat... (string predicateFormat,, );
+
+        //[Static]
+        //[Export ("predicateWithFormat:arguments:")]
+        //NSPredicate PredicateWithFormatarguments (string predicateFormat, va_list argList);
+
+        [Static]
+        [Export ("predicateWithValue:")]
+        //NSPredicate PredicateWithValue (bool value);
+        NSPredicate FromValue (bool value);
+
+        //[Export ("predicateWithBlock:idevaluatedObject,NSDictionary*bindings))block")]
+        //NSPredicate PredicateWithBlockidevaluatedObject,NSDictionary*bindings))block (BOOL (^ (id, );
+       
+
+        [Export ("predicateFormat")]
+        string PredicateFormat { get; }
+
+        [Export ("predicateWithSubstitutionVariables:")]
+        NSPredicate PredicateWithSubstitutionVariables (NSDictionary variables);
+
+        [Export ("evaluateWithObject:")]
+        bool EvaluateWithObject (NSObject obj);
+
+        [Export ("evaluateWithObject:substitutionVariables:")]
+        bool EvaluateWithObject (NSObject obj, NSDictionary bindings);
+       
+    }
+
+   
+    [BaseType (typeof (NSPredicate))]
+    interface NSComparisonPredicate {
+        [Static]
+        [Export ("predicateWithLeftExpression:rightExpression:modifier:type:options:")]
+        //NSPredicate PredicateWithLeftExpressionrightExpressionmodifiertypeoptions (NSExpression lhs, NSExpression rhs, NSComparisonPredicateModifier modifier, NSPredicateOperatorType type, uint options);
+        NSPredicate FromModifierTypeAndOptions ( NSExpression lhs, NSExpression rhs, NSComparisonPredicateModifier modifier, NSPredicateOperatorType type, NSComparisonPredicateOptions options);
+
+        [Static]
+        [Export ("predicateWithLeftExpression:rightExpression:customSelector:")]
+        //NSPredicate PredicateWithLeftExpressionrightExpressioncustomSelector (NSExpression lhs, NSExpression rhs, Selector selector);
+        NSPredicate FromSelector (NSExpression lhs, NSExpression rhs, Selector selector);
+
+        [Export ("initWithLeftExpression:rightExpression:modifier:type:options:")]
+        //NSObject InitWithLeftExpressionrightExpressionmodifiertypeoptions (NSExpression lhs, NSExpression rhs, NSComparisonPredicateModifier modifier, NSPredicateOperatorType type, uint options);
+        IntPtr Constructor (NSExpression lhs, NSExpression rhs, NSComparisonPredicateModifier modifier, NSPredicateOperatorType type, NSComparisonPredicateOptions options);
+       
+        [Export ("initWithLeftExpression:rightExpression:customSelector:")]
+        //NSObject InitWithLeftExpressionrightExpressioncustomSelector (NSExpression lhs, NSExpression rhs, Selector selector);
+        IntPtr Constructor (NSExpression lhs, NSExpression rhs, Selector selector);
+
+        [Export ("predicateOperatorType")]
+        NSPredicateOperatorType PredicateOperatorType { get; }
+
+        [Export ("comparisonPredicateModifier")]
+        NSComparisonPredicateModifier ComparisonPredicateModifier { get; }
+
+        [Export ("leftExpression")]
+        NSExpression LeftExpression { get; }
+
+        [Export ("rightExpression")]
+        NSExpression RightExpression { get; }
+
+        [Export ("customSelector")]
+        Selector CustomSelector { get; }
+
+        [Export ("options")]
+        NSComparisonPredicateOptions Options { get; }
+
+    }
+
+    [BaseType (typeof (NSPredicate))]
+    interface NSCompoundPredicate {
+        [Export ("initWithType:subpredicates:")]
+        IntPtr Constructor (NSCompoundPredicateType type, NSPredicate[] subpredicates);
+
+        [Export ("compoundPredicateType")]
+        NSCompoundPredicateType Type { get; }
+
+        [Export ("subpredicates")]
+        NSPredicate[] Subpredicates { get; }
+
+        [Static]
+        [Export ("andPredicateWithSubpredicates:")]
+        NSPredicate AndPredicateWithSubpredicates (NSPredicate[] subpredicates);
+
+        [Static]
+        [Export ("orPredicateWithSubpredicates:")]
+        NSPredicate OrPredicateWithSubpredicates (NSArray subpredicates);
+
+        [Static]
+        [Export ("notPredicateWithSubpredicate:")]
+        NSPredicate NotPredicateWithSubpredicate (NSPredicate predicate);
+
+    }
+   
+    [BaseType (typeof (NSObject), Delegates=new string [] { "Delegate" }, Events=new Type [] { typeof (NSMetadataQueryDelegate)})]
+    interface NSMetadataQuery {
+        //[Export ("init")]
+        //NSObject Init ();
+        //IntPtr Constructor();
+       
+        [Export ("startQuery")]
+        bool StartQuery ();
+
+        [Export ("stopQuery")]
+        void StopQuery ();
+
+        [Export ("isStarted")]
+        bool IsStarted ();
+
+        [Export ("isGathering")]
+        bool IsGathering ();
+
+        [Export ("isStopped")]
+        bool IsStopped ();
+
+        [Export ("disableUpdates")]
+        void DisableUpdates ();
+
+        [Export ("enableUpdates")]
+        void EnableUpdates ();
+
+        [Export ("resultCount")]
+        uint ResultCount ();
+
+        [Export ("resultAtIndex:")]
+        NSObject ResultAtIndex (uint idx);
+
+        [Export ("results")]
+        NSMetadataItem[] Results ();
+
+        [Export ("indexOfResult:")]
+        uint IndexOfResult (NSObject result);
+
+        [Export ("valueLists")]
+        NSDictionary ValueLists ();
+
+        [Export ("groupedResults")]
+        NSArray GroupedResults ();
+
+        [Export ("valueOfAttribute:forResultAtIndex:")]
+        NSObject ValueOfAttributeforResultAtIndex (string attrName, uint idx);
+
+        //Detected properties
+        //[Export ("delegate")]
+        //NSMetadataQueryDelegate Delegate { get; set; }
+        [Export ("delegate", ArgumentSemantic.Assign), NullAllowed]
+        NSMetadataQueryDelegate WeakDelegate { get; set; }
+
+        [Wrap ("WeakDelegate")]
+        NSMetadataQueryDelegate Delegate { get; set; }
+       
+        [Export ("predicate")]
+        NSPredicate Predicate { get; set; }
+
+        [Export ("sortDescriptors")]
+        NSSortDescriptor[] SortDescriptors { get; set; }
+
+        [Export ("valueListAttributes")]
+        NSObject[] ValueListAttributes { get; set; }
+
+        [Export ("groupingAttributes")]
+        NSArray GroupingAttributes { get; set; }
+
+        [Export ("notificationBatchingInterval")]
+        double NotificationBatchingInterval { get; set; }
+
+        [Export ("searchScopes")]
+        NSArray SearchScopes { get; set; }
+       
+        // There is no info associated with these notifications
+        [Field ("NSMetadataQueryDidStartGatheringNotification")]
+        NSString DidStartGatheringNotification { get; }
+   
+        [Field ("NSMetadataQueryGatheringProgressNotification")]
+        NSString GatheringProgressNotification { get; }
+       
+        [Field ("NSMetadataQueryDidFinishGatheringNotification")]
+        NSString DidFinishGatheringNotification { get; }
+       
+        [Field ("NSMetadataQueryDidUpdateNotification")]
+        NSString DidUpdateNotification { get; }
+       
+        [Field ("NSMetadataQueryResultContentRelevanceAttribute")]
+        NSString ResultContentRelevanceAttribute { get; }
+       
+        // Scope constants for defined search locations
+        [Field ("NSMetadataQueryUserHomeScope")]
+        NSString UserHomeScope { get; }
+       
+        [Field ("NSMetadataQueryLocalComputerScope")]
+        NSString LocalComputerScope { get; }
+       
+        [Field ("NSMetadataQueryNetworkScope")]
+        NSString QueryNetworkScope { get; }
+    }
+
+    [BaseType (typeof (NSObject))]
+    [Model]
+    interface NSMetadataQueryDelegate {
+        [Export ("metadataQuery:replacementObjectForResultObject:"), EventArgs ("NSMetadataQueryObject"), DefaultValue(null)]
+        NSObject MetadataQueryReplacementObjectForResultObject (NSMetadataQuery query, NSMetadataItem result);
+
+        [Export ("metadataQuery:replacementValueForAttribute:value:"), EventArgs ("NSMetadataQueryValue"), DefaultValue(null)]
+        NSObject MetadataQueryReplacementValueForAttributevalue (NSMetadataQuery query, string attrName, NSObject attrValue);
+
+    }
+
+    [BaseType (typeof (NSObject))]
+    interface NSMetadataItem {
+        [Export ("valueForAttribute:")]
+        NSObject ValueForAttribute (string key);
+
+        [Export ("valuesForAttributes:")]
+        NSDictionary ValuesForAttributes (NSArray keys);
+
+        [Export ("attributes")]
+        NSArray Attributes ();
+
+    }
+
+    [BaseType (typeof (NSObject))]
+    interface NSMetadataQueryAttributeValueTuple {
+        [Export ("attribute")]
+        string Attribute ();
+
+        [Export ("value")]
+        NSObject Value ();
+
+        [Export ("count")]
+        uint Count ();
+
+    }
+
+    [BaseType (typeof (NSObject))]
+    interface NSMetadataQueryResultGroup {
+        [Export ("attribute")]
+        string Attribute ();
+
+        [Export ("value")]
+        NSObject Value ();
+
+        [Export ("subgroups")]
+        NSArray Subgroups ();
+
+        [Export ("resultCount")]
+        uint ResultCount ();
+
+        [Export ("resultAtIndex:")]
+        NSObject ResultAtIndex (uint idx);
+
+        [Export ("results")]
+        NSArray Results ();
+
+    }	
 }
 
