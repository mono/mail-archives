
using System;
using System.Text.RegularExpressions;



namespace Test
{
    public class TheRegex
    {


        public static void Main( string[] args )
        {
            // this works, replaces with 't'
            Regex foo = new Regex( @"\045" );  // hex 25
            string result = foo.Replace( " \u0025 ","t" );
            Console.WriteLine( "\u0025 - " + result );

            // this works, replaces with 't'
            foo = new Regex( @"\077" );  // hex 3F
            result = foo.Replace( " \u003F ","t" );
            Console.WriteLine( "\u003F - " + result );

            // this throws and exception on mono (not on .Net)
            foo = new Regex( @"\100" );  // hex 40
            result = foo.Replace( " \u0040 ","t" );
            Console.WriteLine( "\u0040 - " + result );
        }
    }
}


