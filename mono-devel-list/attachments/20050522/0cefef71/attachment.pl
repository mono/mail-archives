Index: System.Data.Common/DataContainer.cs
===================================================================
--- System.Data.Common/DataContainer.cs	(revision 44885)
+++ System.Data.Common/DataContainer.cs	(working copy)
@@ -170,11 +170,7 @@
 			_nullValues[toIndex] = _nullValues[fromIndex];
 		}
 
-		internal virtual void SetItemFromDataRecord(int index, IDataRecord record, int field)
-		{
-			bool isDbNull = record.IsDBNull(field);
-			SetNull(index,false,isDbNull);
-		}
+		internal abstract void SetItemFromDataRecord(int index, IDataRecord record, int field);
 
 		protected int CompareNulls(int index1, int index2)
 		{
@@ -254,6 +250,12 @@
 
 			internal override void SetItemFromDataRecord(int index, IDataRecord record, int field)
 			{
+				bool isDbNull = record.IsDBNull(field);
+				if (isDbNull) {
+					SetNull(index,false,isDbNull);
+					return;
+				}
+
 				// if exception thrown, it should be caught in the  caller method
 				if (record is ISafeDataRecord) {
 					SetValue(index,((ISafeDataRecord)record).GetInt16Safe(field));
@@ -261,7 +263,6 @@
 				else {
 					this[index] = record.GetValue(field);
 				}
-				base.SetItemFromDataRecord(index,record,field);
 			}
 
 			internal override void CopyValue(int fromIndex, int toIndex)
@@ -357,6 +358,12 @@
 
 			internal override void SetItemFromDataRecord(int index, IDataRecord record, int field)
 			{
+				bool isDbNull = record.IsDBNull(field);
+				if (isDbNull) {
+					SetNull(index,false,isDbNull);
+					return;
+				}
+
 				// if exception thrown, it should be caught in the  caller method
 				if (record is ISafeDataRecord) {
 					SetValue(index,((ISafeDataRecord)record).GetInt32Safe(field));
@@ -364,7 +371,6 @@
 				else {
 					this[index] = record.GetValue(field);
 				}
-				base.SetItemFromDataRecord(index,record,field);
 			}
 
 			internal override void CopyValue(int fromIndex, int toIndex)
@@ -463,6 +469,12 @@
 
 			internal override void SetItemFromDataRecord(int index, IDataRecord record, int field)
 			{
+				bool isDbNull = record.IsDBNull(field);
+				if (isDbNull) {
+					SetNull(index,false,isDbNull);
+					return;
+				}
+
 				// if exception thrown, it should be caught in the  caller method
 				if (record is ISafeDataRecord) {
 					SetValue(index,((ISafeDataRecord)record).GetInt64Safe(field));
@@ -470,7 +482,6 @@
 				else {
 					this[index] = record.GetValue(field);
 				}
-				base.SetItemFromDataRecord(index,record,field);
 			}
 
 			internal override void CopyValue(int fromIndex, int toIndex)
@@ -570,6 +581,12 @@
 
 			internal override void SetItemFromDataRecord(int index, IDataRecord record, int field)
 			{
+				bool isDbNull = record.IsDBNull(field);
+				if (isDbNull) {
+					SetNull(index,false,isDbNull);
+					return;
+				}
+
 				// if exception thrown, it should be caught in the  caller method
 				if (record is ISafeDataRecord) {
 					SetValue(index,((ISafeDataRecord)record).GetFloatSafe(field));
@@ -577,7 +594,6 @@
 				else {
 					this[index] = record.GetValue(field);
 				}
-				base.SetItemFromDataRecord(index,record,field);
 			}
 
 			internal override void CopyValue(int fromIndex, int toIndex)
@@ -677,6 +693,12 @@
 
 			internal override void SetItemFromDataRecord(int index, IDataRecord record, int field)
 			{
+				bool isDbNull = record.IsDBNull(field);
+				if (isDbNull) {
+					SetNull(index,false,isDbNull);
+					return;
+				}
+
 				// if exception thrown, it should be caught in the  caller method
 				if (record is ISafeDataRecord) {
 					SetValue(index,((ISafeDataRecord)record).GetDoubleSafe(field));
@@ -684,7 +706,6 @@
 				else {
 					this[index] = record.GetValue(field);
 				}
-				base.SetItemFromDataRecord(index,record,field);
 			}
 
 			internal override void CopyValue(int fromIndex, int toIndex)
@@ -784,6 +805,12 @@
 
 			internal override void SetItemFromDataRecord(int index, IDataRecord record, int field)
 			{
+				bool isDbNull = record.IsDBNull(field);
+				if (isDbNull) {
+					SetNull(index,false,isDbNull);
+					return;
+				}
+
 				// if exception thrown, it should be caught in the  caller method
 				if (record is ISafeDataRecord) {
 					SetValue(index,((ISafeDataRecord)record).GetByteSafe(field));
@@ -791,7 +818,6 @@
 				else {
 					this[index] = record.GetValue(field);
 				}
-				base.SetItemFromDataRecord(index,record,field);
 			}
 
 			internal override void CopyValue(int fromIndex, int toIndex)
@@ -889,6 +915,12 @@
 
 			internal override void SetItemFromDataRecord(int index, IDataRecord record, int field)
 			{
+				bool isDbNull = record.IsDBNull(field);
+				if (isDbNull) {
+					SetNull(index,false,isDbNull);
+					return;
+				}
+
 				// if exception thrown, it should be caught in the  caller method
 				if (record is ISafeDataRecord) {
 					SetValue(index,((ISafeDataRecord)record).GetBooleanSafe(field));
@@ -1045,10 +1077,15 @@
 			#region Methods
 			internal override void SetItemFromDataRecord(int index, IDataRecord record, int field)
 			{
+				bool isDbNull = record.IsDBNull(field);
+				if (isDbNull) {
+					SetNull(index,false,isDbNull);
+					return;
+				}
+
 				// if exception thrown, it should be caught 
 				// in the  caller method
 				SetValue(index,record.GetValue(field));
-				base.SetItemFromDataRecord(index,record,field);
 			}
 
 			protected override void SetValue(int index, object value)
@@ -1067,10 +1104,21 @@
 			#region Methods
 			internal override void SetItemFromDataRecord(int index, IDataRecord record, int field)
 			{
+				bool isDbNull = record.IsDBNull(field);
+				if (isDbNull) {
+					SetNull(index,false,isDbNull);
+					return;
+				}
+
 				// if exception thrown, it should be caught 
 				// in the  caller method
-				base.SetValue(index,record.GetDateTime(field));
-				base.SetItemFromDataRecord(index,record,field);
+				// if exception thrown, it should be caught in the  caller method
+				if (record is ISafeDataRecord) {
+					SetValue(index,((ISafeDataRecord)record).GetDateTimeSafe(field));
+				}
+				else {
+					this[index] = record.GetValue(field);
+				}
 			}
 
 			protected override void SetValue(int index, object value)
@@ -1088,6 +1136,12 @@
 			#region Methods
 			internal override void SetItemFromDataRecord(int index, IDataRecord record, int field)
 			{
+				bool isDbNull = record.IsDBNull(field);
+				if (isDbNull) {
+					SetNull(index,false,isDbNull);
+					return;
+				}
+
 				// if exception thrown, it should be caught in the  caller method
 				if (record is ISafeDataRecord) {
 					SetValue(index,((ISafeDataRecord)record).GetDecimalSafe(field));
@@ -1095,7 +1149,6 @@
 				else {
 					this[index] = record.GetValue(field);
 				}
-				base.SetItemFromDataRecord(index,record,field);
 			}
 
 			protected override void SetValue(int index, object value)
@@ -1137,6 +1190,12 @@
 
 			internal override void SetItemFromDataRecord(int index, IDataRecord record, int field)
 			{
+				bool isDbNull = record.IsDBNull(field);
+				if (isDbNull) {
+					SetNull(index,false,isDbNull);
+					return;
+				}
+
 				// if exception thrown, it should be caught 
 				// in the  caller method
 				if (record is ISafeDataRecord) {
@@ -1145,7 +1204,6 @@
 				else {
 					this[index] = record.GetValue(field);
 				}
-				base.SetItemFromDataRecord(index,record,field);
 			}
 
 			internal override int CompareValues(int index1, int index2)
@@ -1226,6 +1284,12 @@
 
 			internal override void SetItemFromDataRecord(int index, IDataRecord record, int field)
 			{
+				bool isDbNull = record.IsDBNull(field);
+				if (isDbNull) {
+					SetNull(index,false,isDbNull);
+					return;
+				}
+
 				// if exception thrown, it should be caught in the  caller method
 				if (record is ISafeDataRecord) {
 					SetValue(index,((ISafeDataRecord)record).GetCharSafe(field));
@@ -1233,7 +1297,6 @@
 				else {
 					this[index] = record.GetValue(field);
 				}
-				base.SetItemFromDataRecord(index,record,field);
 			}
 
 			internal override void CopyValue(int fromIndex, int toIndex)
@@ -1330,6 +1393,12 @@
 
 			internal override void SetItemFromDataRecord(int index, IDataRecord record, int field)
 			{
+				bool isDbNull = record.IsDBNull(field);
+				if (isDbNull) {
+					SetNull(index,false,isDbNull);
+					return;
+				}
+
 				// if exception thrown, it should be caught in the  caller method
 				if (record is ISafeDataRecord) {
 					SetValue(index,(ushort)((ISafeDataRecord)record).GetInt16Safe(field));
@@ -1337,7 +1406,6 @@
 				else {
 					this[index] = record.GetValue(field);
 				}
-				base.SetItemFromDataRecord(index,record,field);
 			}
 
 			internal override void CopyValue(int fromIndex, int toIndex)
@@ -1433,6 +1501,12 @@
 
 			internal override void SetItemFromDataRecord(int index, IDataRecord record, int field)
 			{
+				bool isDbNull = record.IsDBNull(field);
+				if (isDbNull) {
+					SetNull(index,false,isDbNull);
+					return;
+				}
+
 				// if exception thrown, it should be caught in the  caller method
 				if (record is ISafeDataRecord) {
 					SetValue(index,(uint)((ISafeDataRecord)record).GetInt32Safe(field));
@@ -1440,7 +1514,6 @@
 				else {
 					this[index] = record.GetValue(field);
 				}
-				base.SetItemFromDataRecord(index,record,field);
 			}
 
 			internal override void CopyValue(int fromIndex, int toIndex)
@@ -1539,6 +1612,12 @@
 
 			internal override void SetItemFromDataRecord(int index, IDataRecord record, int field)
 			{
+				bool isDbNull = record.IsDBNull(field);
+				if (isDbNull) {
+					SetNull(index,false,isDbNull);
+					return;
+				}
+
 				// if exception thrown, it should be caught in the  caller method
 				if (record is ISafeDataRecord) {
 					SetValue(index,(ulong)((ISafeDataRecord)record).GetInt64Safe(field));
@@ -1546,7 +1625,6 @@
 				else {
 					this[index] = record.GetValue(field);
 				}
-				base.SetItemFromDataRecord(index,record,field);
 			}
 
 			internal override void CopyValue(int fromIndex, int toIndex)
@@ -1647,6 +1725,12 @@
 
 			internal override void SetItemFromDataRecord(int index, IDataRecord record, int field)
 			{
+				bool isDbNull = record.IsDBNull(field);
+				if (isDbNull) {
+					SetNull(index,false,isDbNull);
+					return;
+				}
+
 				// if exception thrown, it should be caught in the  caller method
 				if (record is ISafeDataRecord) {
 					SetValue(index,(sbyte)((ISafeDataRecord)record).GetByteSafe(field));
@@ -1654,7 +1738,6 @@
 				else {
 					this[index] = record.GetValue(field);
 				}
-				base.SetItemFromDataRecord(index,record,field);
 			}
 
 			internal override void CopyValue(int fromIndex, int toIndex)
Index: System.Data/ISafeDataRecord.cs
===================================================================
--- System.Data/ISafeDataRecord.cs	(revision 44885)
+++ System.Data/ISafeDataRecord.cs	(working copy)
@@ -1,15 +1,15 @@
-//
-// System.Data.ISafeDataRecord
-//
-// Author:
-//   Boris Kirzner (borisk@mainsoft.com)
-//
-using System;
-
-namespace System.Data
-{
-	internal interface ISafeDataRecord
-	{
+//
+// System.Data.ISafeDataRecord
+//
+// Author:
+//   Boris Kirzner (borisk@mainsoft.com)
+//
+using System;
+
+namespace System.Data
+{
+	internal interface ISafeDataRecord : IDataRecord
+	{
 		bool GetBooleanSafe(int i);
 
 		byte GetByteSafe(int i);
@@ -24,7 +24,7 @@
 
 		//string GetDataTypeName(int i);
 
-		//DateTime GetDateTime(int i);
+		DateTime GetDateTimeSafe(int i);
 
 		decimal GetDecimalSafe(int i);
 
@@ -58,6 +58,6 @@
 
 		//object this[string name]{get;}
 		
-		//object this[int i]{get;}
-	}
-}
+		//object this[int i]{get;}
+	}
+}
