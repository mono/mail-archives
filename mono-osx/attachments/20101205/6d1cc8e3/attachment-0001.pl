diff --git a/src/AppKit/Enums.cs b/src/AppKit/Enums.cs
index c6d60e3..b36d7b5 100755
--- a/src/AppKit/Enums.cs
+++ b/src/AppKit/Enums.cs
@@ -1458,5 +1458,16 @@ namespace MonoMac.AppKit {
 		Open = 2,
 		Closing = 3
 	}
-
+	
+    public enum NSRuleEditorRowType{
+		Simple = 0,
+		Compound
+    };
+   
+    public enum NSRuleEditorNestingMode {
+		Single,
+		List,
+		Compound,
+		Simple
+    };	
 } 
diff --git a/src/appkit.cs b/src/appkit.cs
index 1b0343f..8508c32 100755
--- a/src/appkit.cs
+++ b/src/appkit.cs
@@ -31,6 +31,7 @@ using MonoMac.ObjCRuntime;
 using MonoMac.CoreGraphics;
 using MonoMac.CoreImage;
 using MonoMac.CoreAnimation;
+using MonoMac.CoreData;
 
 namespace MonoMac.AppKit {
 		
@@ -12769,4 +12770,203 @@ namespace MonoMac.AppKit {
 		bool Autorepeat { get; set; }
 
 	}
+	
+    [BaseType (typeof (NSObject))]
+    interface NSPredicateEditorRowTemplate {
+        [Export ("matchForPredicate:")]
+        double MatchForPredicate (NSPredicate predicate);
+
+        [Export ("templateViews")]
+        NSObject[] TemplateViews { get; }
+
+        [Export ("setPredicate:")]
+        NSPredicate Predicate { set; }
+
+        [Export ("predicateWithSubpredicates:")]
+        NSPredicate PredicateWithSubpredicates (NSPredicate[] subpredicates);
+       
+        [Export ("displayableSubpredicatesOfPredicate:")]
+        NSPredicate[] DisplayableSubpredicatesOfPredicate (NSPredicate predicate);
+
+        [Export ("initWithLeftExpressions:rightExpressions:modifier:operators:options:")]
+        //NSObject InitWithLeftExpressionsrightExpressionsmodifieroperatorsoptions (NSArray leftExpressions, NSArray rightExpressions, NSComparisonPredicateModifier modifier, NSArray operators, uint options);
+        IntPtr Constructor (NSExpression[] leftExpressions, NSExpression[] rightExpressions, NSComparisonPredicateModifier modifier, NSObject[] operators, NSComparisonPredicateOptions options);
+
+        [Export ("initWithLeftExpressions:rightExpressionAttributeType:modifier:operators:options:")]
+        //NSObject InitWithLeftExpressionsrightExpressionAttributeTypemodifieroperatorsoptions (NSArray leftExpressions, NSAttributeType attributeType, NSComparisonPredicateModifier modifier, NSArray operators, uint options);
+        IntPtr Constructor (NSExpression[] leftExpressions, NSAttributeType attributeType, NSComparisonPredicateModifier modifier, NSObject[] operators, NSComparisonPredicateOptions options);
+
+        [Export ("initWithCompoundTypes:")]
+        IntPtr Constructor (NSNumber[] compoundTypes);
+
+        [Export ("leftExpressions")]
+        NSExpression[] LeftExpressions { get; }
+
+        [Export ("rightExpressions")]
+       	NSExpression[] RightExpressions { get; }
+
+        [Export ("rightExpressionAttributeType")]
+        NSAttributeType RightExpressionAttributeType { get; }
+
+        [Export ("modifier")]
+        NSComparisonPredicateModifier Modifier { get; }
+
+        [Export ("operators")]
+        NSObject[] Operators { get; }
+
+        [Export ("options")]
+        NSComparisonPredicateOptions Options { get; }
+
+        [Export ("compoundTypes")]
+        NSNumber[] CompoundTypes { get; }
+
+        [Static]
+        [Export ("templatesWithAttributeKeyPaths:inEntityDescription:")]
+        //NSArray TemplatesWithAttributeKeyPathsinEntityDescription (NSArray keyPaths, NSEntityDescription entityDescription);
+        NSPredicateEditorRowTemplate[] GetTemplates (string[] keyPaths, NSEntityDescription entityDescription);
+
+    }
+   
+    [BaseType (typeof (NSControl), Delegates=new string [] { "Delegate" }, Events=new Type [] { typeof (NSRuleEditorDelegate)})]
+    interface NSRuleEditor {
+        [Export ("reloadCriteria")]
+        void ReloadCriteria ();
+
+        [Export ("predicate")]
+        NSPredicate Predicate { get; }
+
+        [Export ("reloadPredicate")]
+        void ReloadPredicate ();
+
+        [Export ("predicateForRow:")]
+        NSPredicate GetPredicate (int row);
+
+        [Export ("numberOfRows")]
+        int NumberOfRows { get; }
+
+        [Export ("subrowIndexesForRow:")]
+        NSIndexSet SubrowIndexes (int rowIndex);
+
+        [Export ("criteriaForRow:")]
+        NSArray Criteria (int row);
+
+        [Export ("displayValuesForRow:")]
+        NSObject[] DisplayValues (int row);
+
+        [Export ("rowForDisplayValue:")]
+        int Row (NSObject displayValue);
+
+        [Export ("rowTypeForRow:")]
+        NSRuleEditorRowType RowType (int rowIndex);
+
+        [Export ("parentRowForRow:")]
+        int ParentRow (int rowIndex);
+
+        [Export ("addRow:")]
+        void AddRow (NSObject sender);
+
+        [Export ("insertRowAtIndex:withType:asSubrowOfRow:animate:")]
+        void InsertRowAtIndex (int rowIndex, NSRuleEditorRowType rowType, int parentRow, bool shouldAnimate);
+
+        [Export ("setCriteria:andDisplayValues:forRowAtIndex:")]
+        void SetCriteria (NSArray criteria, NSArray values, int rowIndex);
+
+        [Export ("removeRowAtIndex:")]
+        void RemoveRowAtIndex (int rowIndex);
+
+        [Export ("removeRowsAtIndexes:includeSubrows:")]
+        void RemoveRowsAtIndexes (NSIndexSet rowIndexes, bool includeSubrows);
+
+        [Export ("selectedRowIndexes")]
+        NSIndexSet SelectedRows { get; }
+
+        [Export ("selectRowIndexes:byExtendingSelection:")]
+        void SelectRowIndexes (NSIndexSet indexes, bool extend);
+
+        //Detected properties
+        //[Export ("delegate")]
+        //NSRuleEditorDelegate Delegate { get; set; }
+        [Export ("delegate", ArgumentSemantic.Assign), NullAllowed]
+        NSRuleEditorDelegate WeakDelegate { get; set; }
+
+        [Wrap ("WeakDelegate")]
+        NSRuleEditorDelegate Delegate { get; set; }
+       
+        [Export ("formattingStringsFilename")]
+        string FormattingStringsFilename { get; set; }
+
+        [Export ("formattingDictionary")]
+        NSDictionary FormattingDictionary { get; set; }
+
+        [Export ("nestingMode")]
+        NSRuleEditorNestingMode NestingMode { get; set; }
+
+        [Export ("rowHeight")]
+        float RowHeight { get; set; }
+
+        [Export ("editable")]
+        bool Editable { [Bind ("isEditable")]get; set; }
+
+        [Export ("canRemoveAllRows")]
+        bool CanRemoveAllRows { get; set; }
+
+        [Export ("rowClass")]
+        Class RowClass { get; set; }
+
+        [Export ("rowTypeKeyPath")]
+        string RowTypeKeyPath { get; set; }
+
+        [Export ("subrowsKeyPath")]
+        string SubrowsKeyPath { get; set; }
+
+        [Export ("criteriaKeyPath")]
+        string CriteriaKeyPath { get; set; }
+
+        [Export ("displayValuesKeyPath")]
+        string DisplayValuesKeyPath { get; set; }
+
+    }
+
+    [BaseType (typeof (NSObject))]
+    [Model]
+    interface NSRuleEditorDelegate {
+        [Abstract]
+        [Export ("ruleEditor:numberOfChildrenForCriterion:withRowType:"), EventArgs ("NSRuleEditorNumberOfChildren"), DefaultValue(0)]
+        int NumberOfChildren (NSRuleEditor editor, NSObject criterion, NSRuleEditorRowType rowType);
+
+        [Abstract]
+        [Export ("ruleEditor:child:forCriterion:withRowType:"), EventArgs ("NSRulerEditorChildCriterion"), DefaultValue(null)]
+        NSObject ChildForCriterion (NSRuleEditor editor, int index, NSObject criterion, NSRuleEditorRowType rowType);
+
+        [Abstract]
+        [Export ("ruleEditor:displayValueForCriterion:inRow:"), EventArgs ("NSRulerEditorDisplayValue"), DefaultValue(null)]
+        NSObject DisplayValue (NSRuleEditor editor, NSObject criterion, int row);
+
+        [Abstract]
+        [Export ("ruleEditor:predicatePartsForCriterion:withDisplayValue:inRow:"), EventArgs ("NSRulerEditorPredicateParts"), DefaultValue(null)]
+        NSDictionary PredicateParts (NSRuleEditor editor, NSObject criterion, NSObject value, int row);
+
+        [Abstract]
+        [Export ("ruleEditorRowsDidChange:"), EventArgs ("NSNotification")]
+        void RowsDidChange (NSNotification notification);
+		
+		[Export ("controlTextDidEndEditing:"), EventArgs ("NSNotification")]
+		void EditingEnded (NSNotification notification);
+
+		[Export ("controlTextDidChange:"), EventArgs ("NSNotification")]
+		void Changed (NSNotification notification);
+
+		[Export ("controlTextDidBeginEditing:"), EventArgs ("NSNotification")]
+		void EditingBegan (NSNotification notification);			
+
+    }
+   
+   
+    [BaseType (typeof (NSRuleEditor))]
+    interface NSPredicateEditor {
+        //Detected properties
+        [Export ("rowTemplates")]
+        NSPredicateEditorRowTemplate[] RowTemplates { get; set; }
+
+    } 	
 }
