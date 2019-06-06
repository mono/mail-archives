//
// System.ComponentModel.SyntaxCheck
//
// Author:
//  Andreas Nahr (ClassDevelopment@A-SoftTech.com)
//
// (C) 2003 Andreas Nahr
//

using System.IO;

namespace System.ComponentModel
{

    public class SyntaxCheck
    {

        private SyntaxCheck ()
        {
        }

        public static bool CheckMachineName(string value)
        {
            // FIXME correct implementation?
            return Environment.MachineName.Equals (value);
        }

        public static bool CheckPath(string value)
        {
            // FIXME correct implementation?
            try
            {
                System.IO.Path.GetFullPath (value);
            }
            catch
            {
                return false;
            }
            return true;
        }

        public static bool CheckRootedPath(string value)
        {
            // FIXME correct implementation?
            try
            {
                return System.IO.Path.IsPathRooted (value);
            }
            catch
            {
                return false;
            }
        }
	}
}
