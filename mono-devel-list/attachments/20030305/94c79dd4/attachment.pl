using System;
using System.Text;

public class TestGetString
{
    public static void Main (string[] args)
    {
	Test ("Latin1", Encoding.GetEncoding ("iso-8859-1"));
	Test ("ASCII", new ASCIIEncoding ());
    }
    
    static void Test (string name, Encoding encoding)
    {
	byte[] bytes0 = new byte[0];
	
	Console.WriteLine (name + ": GetString (byte[0])");
	try
	{
	    encoding.GetString (bytes0);
	}
	catch (Exception e)
	{
	    Console.WriteLine (e);
	}
	Console.WriteLine (name + ": GetString (byte[0], 0, 0)");
	try
	{
	    encoding.GetString (bytes0, 0, 0);
	}
	catch (Exception e)
	{
	    Console.WriteLine (e);
	}
    }
}

