--- mono.head/mcs/class/System.Data/Test/ProviderTests/System.Data.SqlClient/SqlDataReaderTest.cs	2010-04-09 14:54:23.000000000 +0200
+++ mono/mcs/class/System.Data/Test/ProviderTests/System.Data.SqlClient/SqlDataReaderTest.cs	2010-04-09 01:43:07.000000000 +0200
@@ -1400,6 +1400,28 @@
 			reader.Close ();
 		}
 
+		[Test]
+		public void GetValues_Values_Sequential()		
+		{
+			cmd.CommandText = "Select * from employee where id=1";
+
+			using (SqlDataReader reader = cmd.ExecuteReader(CommandBehavior.SequentialAccess)) {
+                		object[] resultValues = new object[reader.FieldCount];
+
+				Assert.IsTrue (reader.Read(), "#1" );
+
+                    		//read the values from record
+                    		reader.GetValues(resultValues);
+                    		//expected values
+                    		object[] expectedValues = new object[]{ 1, "suresh","kumar", new DateTime(1978,08,22), new DateTime(2001,03,12), "suresh@gmail.com" };
+
+                    		for (int i = 0; i < resultValues.Length; i++) {
+                    			Assert.IsNotNull( resultValues[i], "#2" );
+                    			Assert.AreEqual ( expectedValues[i], resultValues[i], "#3" );
+				}
+			}
+		}
+
 		[Test]
 		public void GetSqlValue_Index_Invalid ()
 		{