using System;
using System.Collections;

public class CustomException : ApplicationException
{
}

class Foo {
    static void Main(string[] args) {
        try {
            throw new CustomException();
        }
	catch (CustomException ex) {
            Bad (ex, new Object());
            // Good (ex);
        }
    }

    static void Bad (Exception ex, object o)
    {
        try {
            throw ex;
        }
        catch (CustomException e)
        {
            Console.WriteLine (e);
            Console.WriteLine (o);
        }
    }

    static void Good (Exception ex)
    {
        try {
            throw ex;
        }
        catch (CustomException e)
        {
            Console.WriteLine (e);
        }
    }
}
