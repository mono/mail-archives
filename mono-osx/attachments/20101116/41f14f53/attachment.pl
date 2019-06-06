diff --git a/src/Foundation/NSMutableDictionary.cs b/src/Foundation/NSMutableDictionary.cs
index 367481d..db809ae 100644
--- a/src/Foundation/NSMutableDictionary.cs
+++ b/src/Foundation/NSMutableDictionary.cs
@@ -11,7 +11,7 @@ namespace MonoMac.Foundation {
 		{
 			if (objects.Length != keys.Length)
 				throw new ArgumentException ("objects and keys arrays have different sizes");
-			return FromObjectsAndKeys (objects, keys, objects.Length);
+			return FromObjectsAndKeysInternal (objects, keys);
 		}
 		
 		#region ICollection<KeyValuePair<NSObject, NSObject>>
diff --git a/src/foundation.cs b/src/foundation.cs
index 8d4328d..1f7fb9f 100644
--- a/src/foundation.cs
+++ b/src/foundation.cs
@@ -1762,6 +1762,10 @@ namespace MonoMac.Foundation
 		[Static, Internal]
 		NSMutableDictionary FromObjectsAndKeys (NSObject [] objects, NSObject [] Keys, int count);
 
+		[Export ("dictionaryWithObjects:forKeys:")]
+		[Static,Internal]
+		NSMutableDictionary FromObjectsAndKeysInternal (NSObject [] objects, NSObject [] Keys);
+		
 		[Export ("initWithDictionary:")]
 		IntPtr Constructor (NSDictionary other);
 
