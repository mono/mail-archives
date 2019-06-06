Index: System.Configuration/ConfigurationElementCollection.cs
===================================================================
--- System.Configuration/ConfigurationElementCollection.cs	(revision 69925)
+++ System.Configuration/ConfigurationElementCollection.cs	(working copy)
@@ -149,12 +149,17 @@
 
 		protected void BaseAdd (ConfigurationElement element, bool throwIfExists)
 		{
-			if (throwIfExists && BaseIndexOf (element) != -1)
-				throw new ConfigurationException ("Duplicate element in collection");
+			if (BaseIndexOf (element) != -1)
+				// there already an identical element exists.
+				// In such case, simply do nothing (even if 
+				// ThrowOnDuplicate is true).
+				return;
 			if (IsReadOnly ())
 				throw new ConfigurationErrorsException ("Collection is read only.");
 			
 			int old_index = IndexOfKey (GetElementKey (element));
+			if (ThrowOnDuplicate && old_index >= 0)
+				throw new ConfigurationException ("Duplicate element in collection");
 			if (IsAlternate) {
 				list.Insert (inheritedLimitIndex, element);
 				inheritedLimitIndex++;
