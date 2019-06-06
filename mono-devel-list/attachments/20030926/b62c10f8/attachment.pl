Index: Decimal.cs
===================================================================
RCS file: /cvs/public/mcs/class/corlib/System/Decimal.cs,v
retrieving revision 1.12
diff -u -r1.12 Decimal.cs
--- Decimal.cs	12 Sep 2002 15:38:21 -0000	1.12
+++ Decimal.cs	27 Sep 2003 02:33:46 -0000
@@ -908,98 +908,88 @@
 	    return TypeCode.Decimal;
 	}
 
-	[MonoTODO]
-	public static byte ToByte(decimal value)
+	public static byte ToByte(decimal d)
 	{
-		if(value < Byte.MinValue || value > Byte.MaxValue) {
+		if(d < Byte.MinValue || d > Byte.MaxValue) {
 			throw new OverflowException("Invalid value");
 		}
-		throw new NotImplementedException();
+		return Convert.ToByte (d);
 	}
 
-	[MonoTODO]
 	public static double ToDouble(decimal d)
 	{
-		throw new NotImplementedException();
+		return Convert.ToDouble (d);
 	}
 
-	[MonoTODO]
-	public static short ToInt16(decimal value)
+	public static short ToInt16(decimal d)
 	{
-		if(value < Int16.MinValue || value > Int16.MaxValue) {
+		if(d < Int16.MinValue || d > Int16.MaxValue) {
 			throw new OverflowException("Invalid value");
 		}
-		throw new NotImplementedException();
+		return Convert.ToInt16 (d);
 	}
 
-	[MonoTODO]
 	public static int ToInt32(decimal d)
 	{
 		if(d < Int32.MinValue || d > Int32.MaxValue) {
 			throw new OverflowException("Invalid value");
 		}
-		throw new NotImplementedException();
+		return Convert.ToInt32 (d);
 	}
 
-	[MonoTODO]
 	public static long ToInt64(decimal d)
 	{
 		if(d < Int64.MinValue || d > Int64.MaxValue) {
 			throw new OverflowException("Invalid value");
 		}
-		throw new NotImplementedException();
+		return Convert.ToInt64 (d);
 	}
 
 	[MonoTODO]
-	public static long ToOACurrency(decimal value)
+	public static long ToOACurrency(decimal d)
 	{
-		throw new NotImplementedException();
+		throw new NotImplementedException ();
 	}
 
-	[MonoTODO]
 	[CLSCompliant(false)]
-	public static sbyte ToSByte(decimal value)
+	public static sbyte ToSByte(decimal d)
 	{
-		if(value < SByte.MinValue || value > SByte.MaxValue) {
+		if(d < SByte.MinValue || d > SByte.MaxValue) {
 			throw new OverflowException("Invalid value");
 		}
-		throw new NotImplementedException();
+		return Convert.ToSByte (d);
 	}
 
-	[MonoTODO]
 	public static float ToSingle(decimal d)
 	{
-		throw new NotImplementedException();
+		return (float) d;
 	}
 
-	[MonoTODO]
 	[CLSCompliant(false)]
-	public static ushort ToUInt16(decimal value)
+	public static ushort ToUInt16(decimal d)
 	{
-		if(value < UInt16.MinValue || value > UInt16.MaxValue) {
+		if(d < UInt16.MinValue || d > UInt16.MaxValue) {
 			throw new OverflowException("Invalid value");
 		}
-		throw new NotImplementedException();
+		return Convert.ToUInt16 (d);
 	}
 
-	[MonoTODO]
 	[CLSCompliant(false)]
 	public static uint ToUInt32(decimal d)
 	{
 		if(d < 0 || d > UInt32.MaxValue) {
 			throw new OverflowException("Invalid value");
 		}
-		throw new NotImplementedException();
+		return Convert.ToUInt32 (d);
 	}
 
-	[MonoTODO]
 	[CLSCompliant(false)]
 	public static ulong ToUInt64(decimal d)
 	{
 		if(d < 0 || d > UInt64.MaxValue) {
 			throw new OverflowException("Invalid value");
 		}
-		throw new NotImplementedException();
+		return Convert.ToUInt64 (d);
 	}
 		
 	object IConvertible.ToType (Type conversionType, IFormatProvider provider)
