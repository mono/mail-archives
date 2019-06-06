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
diff --git a/src/foundation.cs b/src/foundation.cs
index aaa7dbb..ee9f99c 100644
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
@@ -2100,6 +2134,40 @@ namespace MonoMac.Foundation
 		//Detected properties
 		[Export ("queuePriority")]
 		NSOperationQueuePriority QueuePriority { get; set; }
+		
+       // Cocoa Bindings
+        [Export ("exposedBindings")]
+        NSArray ExposedBindings ();
+
+        [Export ("valueClassForBinding:")]
+        Class ValueClassForBinding (string binding);
+
+        [Export ("bind:toObject:withKeyPath:options:")]
+        void Bind (string binding, NSObject observable, string keyPath, [NullAllowed] NSDictionary options);
+
+        [Export ("unbind:")]
+        void Unbind (string binding);
+
+        [Export ("infoForBinding:")]
+        NSDictionary InfoForBinding (string binding);
+
+        [Export ("optionDescriptionsForBinding:")]
+        NSArray OptionDescriptionsForBinding (string aBinding);
+
+        [Static]
+        [Export ("defaultPlaceholderForMarker:withBinding:")]
+        NSObject DefaultPlaceholderForMarkerWithBinding (NSObject marker, string binding);
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
 
 	[BaseType (typeof (NSOperation))]
