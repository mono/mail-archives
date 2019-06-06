--- mono-2.2/mcs/class/System.Data.OracleClient/System.Data.OracleClient.Oci/OciDefineHandle.cs.orig	2008-12-09 16:12:05.000000000 +0300
+++ mono-2.2/mcs/class/System.Data.OracleClient/System.Data.OracleClient.Oci/OciDefineHandle.cs	2008-12-09 16:12:35.000000000 +0300
@@ -286,7 +286,7 @@
 		void DefineNumber (int position, OracleConnection connection)
 		{
 			fieldType = typeof (System.Decimal);
-			value = OciCalls.AllocateClear (definedSize);
+			value = OciCalls.AllocateClear (definedSize * 2);
 
 			ociType = OciDataType.Char;
 
