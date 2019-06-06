using System;

class Singeton
{
    Singeton() { throw new ArgumentException("I feel headache. Try again next night"); }
    public static Singeton Instance
    {
        get {
            try
            {
                return SingetonInstance.instance;
            }
            catch (System.TypeInitializationException tie)
            {
                //If commented out - it will be equavent to your Fifth version
                //if (tie.InnerException != null) throw tie.InnerException;
                throw;
            }
        } 
    }

        class SingetonInstance
        {
            // Explicit static constructor to tell C# compiler
            // not to mark type as beforefieldinit
            static SingetonInstance()
            {
            }

            // Hey ! Huston - we have a trouble here
            internal static Singeton instance = new Singeton();
        }
    }


    class Program
    {
        static void Main(string[] args)
        {
            Singeton s = null;
            Console.WriteLine("First attempt");
            try
            {
                s = Singeton.Instance;
                Console.WriteLine("Are s is null ?  {0}", s == null);
            }
            catch (ArgumentException ae)
            {
                Console.WriteLine("We got exactly that expected : " + ae);
            }
            catch (Exception e)
            {
                Console.WriteLine(e);
            }
            Console.WriteLine("Second attempt");
            try
            {
                s = Singeton.Instance;
                Console.WriteLine("Are s is null ?  {0}", s == null);
            }
            catch (ArgumentException ae)
            {
                Console.WriteLine("We got exactly that expected : " + ae);
            }
            catch (Exception e)
            {
                Console.WriteLine(e);
            }
        }
    }
