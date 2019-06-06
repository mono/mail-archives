Index: Test/System.Data/DataColumnTest.cs
===================================================================
--- Test/System.Data/DataColumnTest.cs	(revision 105623)
+++ Test/System.Data/DataColumnTest.cs	(working copy)
@@ -38,6 +38,7 @@
 using System;
 using System.ComponentModel;
 using System.Data;
+using System.Data.SqlTypes;
 
 using NUnit.Framework;
 
@@ -326,6 +327,42 @@
 		}
 
 		[Test]
+#if !NET_2_0
+		[ExpectedException (typeof (ArgumentException))]
+#endif
+		public void Defaults3 ()
+		{
+			DataColumn col = new DataColumn ("foo", typeof (SqlBoolean));
+#if NET_2_0
+			Assert.AreEqual (SqlBoolean.Null, col.DefaultValue, "#1");
+			col.DefaultValue = SqlBoolean.True;
+			// FIXME: not working yet
+			//col.DefaultValue = true;
+			//Assert.AreEqual (SqlBoolean.True, col.DefaultValue, "#2"); // not bool but SqlBoolean
+			col.DefaultValue = DBNull.Value;
+			Assert.AreEqual (SqlBoolean.Null, col.DefaultValue, "#3"); // not DBNull
+#else
+			Assert.AreEqual (DBNull.Value, col.DefaultValue, "#1");
+			col.DefaultValue = true;
+			Assert.AreEqual (true, col.DefaultValue, "#2");
+			col.DefaultValue = DBNull.Value; // throws. DBNull is not allowed!
+#endif
+		}
+
+		[Test]
+#if NET_2_0
+		[ExpectedException (typeof (DataException))]
+#else
+		[ExpectedException (typeof (ArgumentException))]
+#endif
+		public void ChangeTypeAfterSettingDefaultValue ()
+		{
+			DataColumn col = new DataColumn ("foo", typeof (SqlBoolean));
+			col.DefaultValue = true;
+			col.DataType = typeof (int);
+		}
+
+		[Test]
 		public void ExpressionSubstringlimits () {
 			DataTable t = new DataTable ();
 			t.Columns.Add ("aaa");
Index: Test/System.Data/DataTableTest.cs
===================================================================
--- Test/System.Data/DataTableTest.cs	(revision 105623)
+++ Test/System.Data/DataTableTest.cs	(working copy)
@@ -2793,7 +2793,8 @@
 			Assert.AreEqual ("Element", column2.ColumnMapping.ToString (), "test#33");
 			Assert.AreEqual ("second", column2.ColumnName, "test#34");
 			Assert.AreEqual ("System.Data.SqlTypes.SqlGuid", column2.DataType.ToString (), "test#35");
-			Assert.AreEqual ("Null", column2.DefaultValue.ToString (), "test#36");
+			Assert.AreEqual (SqlGuid.Null, column2.DefaultValue, "test#36");
+			Assert.AreEqual (typeof (SqlGuid), column2.DefaultValue.GetType (), "test#36-2");
 			Assert.IsFalse (column2.DesignMode, "test#37");
 			Assert.AreEqual ("", column2.Expression, "test#38");
 			Assert.AreEqual (-1, column2.MaxLength, "test#39");
Index: Test/System.Data/DataSetTest.cs
===================================================================
--- Test/System.Data/DataSetTest.cs	(revision 105623)
+++ Test/System.Data/DataSetTest.cs	(working copy)
@@ -133,7 +133,11 @@
 			Assert.AreEqual ("Element", column2.ColumnMapping.ToString (), "test#33");
 			Assert.AreEqual ("second", column2.ColumnName, "test#34");
 			Assert.AreEqual ("System.Data.SqlTypes.SqlGuid", column2.DataType.ToString (), "test#35");
-			Assert.AreEqual ("", column2.DefaultValue.ToString (), "test#36");
+#if NET_2_0
+			Assert.AreEqual (SqlGuid.Null, column2.DefaultValue, "test#36");
+#else
+			Assert.AreEqual (DBNull.Value, column2.DefaultValue, "test#36");
+#endif
 			Assert.IsFalse (column2.DesignMode, "test#37");
 			Assert.AreEqual ("", column2.Expression, "test#38");
 			Assert.AreEqual (-1, column2.MaxLength, "test#39");
Index: System.Data/XmlSchemaWriter.cs
===================================================================
--- System.Data/XmlSchemaWriter.cs	(revision 105623)
+++ System.Data/XmlSchemaWriter.cs	(working copy)
@@ -678,7 +678,7 @@
 					XmlConvert.ToString (col.AutoIncrementStep));
 			}
 
-			if (col.DefaultValue.ToString () != String.Empty)
+			if (!DataColumn.GetDefaultValueForType (col.DataType).Equals (col.DefaultValue))
 				w.WriteAttributeString ("default",
 					DataSet.WriteObjectXml (col.DefaultValue));
 
@@ -792,7 +792,7 @@
 
 				if (!col.AllowDBNull)
 					w.WriteAttributeString ("use", "required");
-				if (col.DefaultValue.ToString () != String.Empty)
+				if (col.DefaultValue != DataColumn.GetDefaultValueForType (col.DataType))
 					w.WriteAttributeString ("default",
 						DataSet.WriteObjectXml (col.DefaultValue));
 
Index: System.Data/DataColumn.cs
===================================================================
--- System.Data/DataColumn.cs	(revision 105623)
+++ System.Data/DataColumn.cs	(working copy)
@@ -90,7 +90,7 @@
 		private string _caption;
 		private MappingType _columnMapping;
 		private string _columnName = String.Empty;
-		private object _defaultValue = DBNull.Value;
+		private object _defaultValue = GetDefaultValueForType (null);
 		private string _expression;
 		private IExpression _compiledExpression;
 		private PropertyCollection _extendedProperties = new PropertyCollection ();
@@ -465,6 +465,8 @@
                                         throw new InvalidConstraintException ("Cannot change datatype, " + 
                                                                               "when column is part of a relation");
                                 
+				Type prevType = _dataContainer != null ? _dataContainer.Type : null; // current
+
 #if NET_2_0
 				if (_dataContainer != null && _dataContainer.Type == typeof (DateTime))
 					_datetimeMode = DataSetDateTime.UnspecifiedLocal;
@@ -482,6 +484,13 @@
 						AutoIncrement = false;
 					}
 				}
+
+				if (DefaultValue != GetDefaultValueForType (prevType))
+					SetDefaultValue (DefaultValue, true);
+#if NET_2_0
+				else
+					_defaultValue = GetDefaultValueForType (DataType);
+#endif
 			}
 		}
 
@@ -507,9 +516,15 @@
 					throw new ArgumentException("Can not set default value while" +
 						" AutoIncrement is true on this column.");
 				}
+				SetDefaultValue (value, false);
+			}
+		}
 
+		void SetDefaultValue (object value, bool forcedTypeCheck)
+		{
+			{
 				object tmpObj;
-				if (!this._defaultValue.Equals(value)) {		
+				if (forcedTypeCheck|| !this._defaultValue.Equals(value)) {
 					if (value == null) {
 						tmpObj = DBNull.Value;
 					}
@@ -517,16 +532,24 @@
 						tmpObj = value;
 					}
 
-					if ((this.DataType != typeof (object))&& (tmpObj != DBNull.Value)) {
+					if (!this.DataType.IsInstanceOfType (tmpObj) && tmpObj != DBNull.Value) {
 						try {
 							//Casting to the new type
 							tmpObj= Convert.ChangeType(tmpObj,this.DataType);
 						}
 						catch (InvalidCastException) {
-							throw new InvalidCastException("Default Value type is not compatible with" + 
-								" column type.");
+							string msg = String.Format ("Default Value of type '{0}' is not compatible with column type '{1}'", tmpObj.GetType (), DataType);
+#if NET_2_0
+							throw new DataException(msg);
+#else
+							throw new ArgumentException(msg);
+#endif
 						}
 					}
+#if NET_2_0
+					if (tmpObj == DBNull.Value)
+						tmpObj = GetDefaultValueForType (DataType);
+#endif
 					_defaultValue = tmpObj;
 				}
 
@@ -1004,6 +1027,19 @@
 #endif
 			return true;
 		}
+
+		internal static object GetDefaultValueForType (Type type)
+		{
+#if NET_2_0
+			if (type == null)
+				return DBNull.Value;
+			if (type.Namespace == "System.Data.SqlTypes" && type.Assembly == typeof (DataColumn).Assembly)
+				// For SqlXxx types, set SqlXxx.Null instead of DBNull.Value.
+				return Activator.CreateInstance (type);
+#endif
+			return DBNull.Value;
+		}
+
 		#endregion // Methods
 	}
 }