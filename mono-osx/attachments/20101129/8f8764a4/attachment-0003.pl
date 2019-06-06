diff --git a/src/AppKit/Enums.cs b/src/AppKit/Enums.cs
index 9b68eb7..31f22ee 100755
--- a/src/AppKit/Enums.cs
+++ b/src/AppKit/Enums.cs
@@ -1376,5 +1376,17 @@ namespace MonoMac.AppKit {
 		Open = 2,
 		Closing = 3
 	}
-
+	
+	//Added by Kenneth J. Pouncey 2010/11/29
+    public enum NSRuleEditorRowType{
+           Simple = 0,
+           Compound
+    };
+   
+    public enum NSRuleEditorNestingMode {
+        Single,
+           List,
+           Compound,
+           Simple
+    };	
 } 
diff --git a/src/Makefile b/src/Makefile
index 2d4e291..d4f2b8b 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -119,4 +119,4 @@ clean:
 all: MonoMac.dll
 
 update: MonoMac.dll
-	cp monomac.dll ~/.config/MonoDevelop/addins/MonoDevelop.MonoMac.2.4.0.7/MonoMac.dll
+	cp monomac.dll ~/.config/MonoDevelop/addins/MonoDevelop.MonoMac.2.4.0.8/MonoMac.dll
diff --git a/src/appkit.cs b/src/appkit.cs
index 7dafaaf..a17516e 100755
--- a/src/appkit.cs
+++ b/src/appkit.cs
@@ -31,6 +31,7 @@ using MonoMac.ObjCRuntime;
 using MonoMac.CoreGraphics;
 using MonoMac.CoreImage;
 using MonoMac.CoreAnimation;
+using MonoMac.CoreData;
 
 namespace MonoMac.AppKit {
 		
@@ -12768,4 +12769,194 @@ namespace MonoMac.AppKit {
 		bool Autorepeat { get; set; }
 
 	}
+	
+	//Added by Kenneth J. Pouncey 2010/11/29
+    [BaseType (typeof (NSObject))]
+    interface NSPredicateEditorRowTemplate {
+        [Export ("matchForPredicate:")]
+        double MatchForPredicate (NSPredicate predicate);
+
+        [Export ("templateViews")]
+        NSArray TemplateViews ();
+
+        [Export ("setPredicate:")]
+        void SetPredicate (NSPredicate predicate);
+
+        [Export ("predicateWithSubpredicates:")]
+        NSPredicate PredicateWithSubpredicates (NSArray subpredicates);
+       
+        [Export ("displayableSubpredicatesOfPredicate:")]
+        NSArray DisplayableSubpredicatesOfPredicate (NSPredicate predicate);
+
+        [Export ("initWithLeftExpressions:rightExpressions:modifier:operators:options:")]
+        //NSObject InitWithLeftExpressionsrightExpressionsmodifieroperatorsoptions (NSArray leftExpressions, NSArray rightExpressions, NSComparisonPredicateModifier modifier, NSArray operators, uint options);
+        IntPtr Constructor (NSArray leftExpressions, NSArray rightExpressions, NSComparisonPredicateModifier modifier, NSArray operators, uint options);
+
+        [Export ("initWithLeftExpressions:rightExpressionAttributeType:modifier:operators:options:")]
+        //NSObject InitWithLeftExpressionsrightExpressionAttributeTypemodifieroperatorsoptions (NSArray leftExpressions, NSAttributeType attributeType, NSComparisonPredicateModifier modifier, NSArray operators, uint options);
+        IntPtr Constructor (NSArray leftExpressions, NSAttributeType attributeType, NSComparisonPredicateModifier modifier, NSArray operators, uint options);
+
+        [Export ("initWithCompoundTypes:")]
+        IntPtr Constructor (NSArray compoundTypes);
+
+        [Export ("leftExpressions")]
+        NSArray LeftExpressions ();
+
+        [Export ("rightExpressions")]
+        NSArray RightExpressions ();
+
+        [Export ("rightExpressionAttributeType")]
+        NSAttributeType RightExpressionAttributeType ();
+
+        [Export ("modifier")]
+        NSComparisonPredicateModifier Modifier ();
+
+        [Export ("operators")]
+        NSArray Operators ();
+
+        [Export ("options")]
+        uint Options ();
+
+        [Export ("compoundTypes")]
+        NSArray CompoundTypes ();
+
+        [Static]
+        [Export ("templatesWithAttributeKeyPaths:inEntityDescription:")]
+        NSArray TemplatesWithAttributeKeyPathsinEntityDescription (NSArray keyPaths, NSEntityDescription entityDescription);
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
+        NSPredicate PredicateForRow (int row);
+
+        [Export ("numberOfRows")]
+        int NumberOfRows { get; }
+
+        [Export ("subrowIndexesForRow:")]
+        NSIndexSet SubrowIndexesForRow (int rowIndex);
+
+        [Export ("criteriaForRow:")]
+        NSArray CriteriaForRow (int row);
+
+        [Export ("displayValuesForRow:")]
+        NSObject[] DisplayValuesForRow (int row);
+
+        [Export ("rowForDisplayValue:")]
+        int RowForDisplayValue (NSObject displayValue);
+
+        [Export ("rowTypeForRow:")]
+        NSRuleEditorRowType RowTypeForRow (int rowIndex);
+
+        [Export ("parentRowForRow:")]
+        int ParentRowForRow (int rowIndex);
+
+        [Export ("addRow:")]
+        void AddRow (NSObject sender);
+
+        [Export ("insertRowAtIndex:withType:asSubrowOfRow:animate:")]
+        void InsertRowAtIndexwithTypeasSubrowOfRowanimate (int rowIndex, NSRuleEditorRowType rowType, int parentRow, bool shouldAnimate);
+
+        [Export ("setCriteria:andDisplayValues:forRowAtIndex:")]
+        void SetCriteriaandDisplayValuesforRowAtIndex (NSArray criteria, NSArray values, int rowIndex);
+
+        [Export ("removeRowAtIndex:")]
+        void RemoveRowAtIndex (int rowIndex);
+
+        [Export ("removeRowsAtIndexes:includeSubrows:")]
+        void RemoveRowsAtIndexesincludeSubrows (NSIndexSet rowIndexes, bool includeSubrows);
+
+        [Export ("selectedRowIndexes")]
+        NSIndexSet SelectedRowIndexes { get; }
+
+        [Export ("selectRowIndexes:byExtendingSelection:")]
+        void SelectRowIndexesbyExtendingSelection (NSIndexSet indexes, bool extend);
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
+        int RuleEditorNumberOfChildrenForCriterionWithRowType (NSRuleEditor editor, NSObject criterion, NSRuleEditorRowType rowType);
+
+        [Abstract]
+        [Export ("ruleEditor:child:forCriterion:withRowType:"), EventArgs ("NSRulerEditorChildCriterion"), DefaultValue(null)]
+        NSObject RuleEditorChildForCriterionWithRowType (NSRuleEditor editor, int index, NSObject criterion, NSRuleEditorRowType rowType);
+
+        [Abstract]
+        [Export ("ruleEditor:displayValueForCriterion:inRow:"), EventArgs ("NSRulerEditorDisplayValue"), DefaultValue(null)]
+        NSObject RuleEditorDisplayValueForCriterioninRow (NSRuleEditor editor, NSObject criterion, int row);
+
+        [Abstract]
+        [Export ("ruleEditor:predicatePartsForCriterion:withDisplayValue:inRow:"), EventArgs ("NSRulerEditorPredicateParts"), DefaultValue(null)]
+        NSDictionary RuleEditorPredicatePartsForCriterionWithDisplayValueinRow (NSRuleEditor editor, NSObject criterion, NSObject value, int row);
+
+        [Abstract]
+        [Export ("ruleEditorRowsDidChange:"), EventArgs ("NSNotification")]
+        void RuleEditorRowsDidChange (NSNotification notification);
+
+    }
+   
+   
+    [BaseType (typeof (NSRuleEditor))]
+    interface NSPredicateEditor {
+        //Detected properties
+        [Export ("rowTemplates")]
+        NSArray RowTemplates { get; set; }
+
+    }	
 }
