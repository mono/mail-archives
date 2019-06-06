// Compiler options: -doc:xml-025.xml
// Note that it could not be compiled to generate reference output as it is.
// csc needs '\\' instead of '/' for file specification.

namespace Testing
{
   /// <include file='../xml-025.inc' path='/foo' />
   public class Test
   {
	public static void Main ()
	{
	}

	/// <include file='../xml-025.inc' path='/root'/>
	public string S1;

	/// <include file='../xml-025.inc' path='/root/child'/>
	public string S2;

	/// <include file='../xml-025.inc' path='/root/@attr'/>
	public string S3;
   }
}
