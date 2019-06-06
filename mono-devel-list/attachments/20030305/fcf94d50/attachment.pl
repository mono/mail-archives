using System;

public class TestDBNullTypeCode
{
    public static void Main (string[] args)
    {
	Type type = DBNull.Value.GetType ();
	TypeCode typeCode = Type.GetTypeCode (type);
	Console.WriteLine ("DBNull Type: {0}", type);
	Console.WriteLine ("DBNull TypeCode: {0}", typeCode);
    }
}


