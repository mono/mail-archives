Index: OdbcParameterTest.cs
===================================================================
--- OdbcParameterTest.cs	(revision 107988)
+++ OdbcParameterTest.cs	(working copy)
@@ -60,6 +60,10 @@
 			param = new OdbcParameter ("test", OdbcType.NText);
 			Assert.AreEqual (null, param.Value, "#6");
 			Assert.AreEqual (OdbcType.NText, param.OdbcType, "#7");
+			
+			param = new OdbcParameter ("test", OdbcType.Binary);
+			Assert.AreEqual (null, param.Value, "#8");
+			Assert.AreEqual (OdbcType.Binary, param.OdbcType, "#9");
                 }
 
         }
