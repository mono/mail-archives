Index: System.Collections/ArrayList.cs
===================================================================
--- System.Collections/ArrayList.cs	(revision 46725)
+++ System.Collections/ArrayList.cs	(working copy)
@@ -2082,7 +2082,7 @@
 
 				array = new object[m_InnerCount];
 
-				m_InnerArrayList.CopyTo(0, array, 0, m_InnerCount);
+				m_InnerArrayList.CopyTo(m_InnerIndex, array, 0, m_InnerCount);
 
 				return array;
 			}
@@ -2093,7 +2093,7 @@
 
 				array = Array.CreateInstance(elementType, m_InnerCount);
 
-				m_InnerArrayList.CopyTo(0, array, 0, m_InnerCount);
+				m_InnerArrayList.CopyTo(m_InnerIndex, array, 0, m_InnerCount);
 
 				return array;
 			}
Index: Test/System.Collections/ArrayListTest.cs
===================================================================
--- Test/System.Collections/ArrayListTest.cs	(revision 46725)
+++ Test/System.Collections/ArrayListTest.cs	(working copy)
@@ -916,6 +916,23 @@
 			AssertEquals("Munging 'a' should mess up 'b'",
 				     true, errorThrown);
 		}
+		{
+			char[] chars = {'a', 'b', 'c', 'd', 'e', 'f'};
+			ArrayList a = new ArrayList(chars);
+			ArrayList b = a.GetRange(3, 3);
+			object[] obj_chars = b.ToArray ();
+			for (int i = 0; i < 3; i++) {
+				char c = (char) obj_chars[i];
+				AssertEquals("range.ToArray didn't work",
+					     chars[i+3], c);
+			}
+			char[] new_chars = (char[]) b.ToArray (typeof (char));
+			for (int i = 0; i < 3; i++) {
+				AssertEquals("range.ToArray with type didn't work",
+					     chars[i+3], new_chars[i]);
+			}
+
+		}
 	}
 
 	[Test]

