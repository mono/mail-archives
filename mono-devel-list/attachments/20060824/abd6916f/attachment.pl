//
// cs2vb.cs
//
// Author:
//   Kornél Pál <http://www.kornelpal.hu/>
//
// Copyright (C) 2006 Kornél Pál
//

//
// Permission is hereby granted, free of charge, to any person obtaining
// a copy of this software and associated documentation files (the
// "Software"), to deal in the Software without restriction, including
// without limitation the rights to use, copy, modify, merge, publish,
// distribute, sublicense, and/or sell copies of the Software, and to
// permit persons to whom the Software is furnished to do so, subject to
// the following conditions:
//
// The above copyright notice and this permission notice shall be
// included in all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
// LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
// OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
// WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

// This converter is suitable only for Consts.cs.

// There will be no hidden bugs because unsupported constructs are not
// converted that will cause compilation errors in Visual Basic compiler.

using System;
using System.Globalization;
using System.IO;
using System.Text.RegularExpressions;

internal class cs2vb
{
	private static string line;
	private static Match match;

	private static string GetSubstring (int index)
	{
		return GetSubstring (match, index);
	}

	private static string GetSubstring (Match match, int index)
	{
		return match.Groups [index].Value;
	}

	private static bool IsMatch (string pattern)
	{
		return IsMatch (line, pattern);
	}

	private static bool IsMatch (string input, string pattern)
	{
		match = Regex.Match (input, pattern, RegexOptions.CultureInvariant);
		return match.Success;
	}

	private static bool Replace (string pattern, string replacement)
	{
		return Replace (ref line, pattern, replacement);
	}

	private static bool Replace (string pattern, MatchEvaluator evaluator)
	{
		return Replace (ref line, pattern, evaluator);
	}

	private static bool Replace (ref string input, string pattern, string replacement)
	{
		if (!IsMatch (input, pattern))
			return false;

		input = Regex.Replace (input, pattern, replacement, RegexOptions.CultureInvariant);
		return true;
	}

	private static bool Replace (ref string input, string pattern, MatchEvaluator evaluator)
	{
		if (!IsMatch (input, pattern))
			return false;

		input = Regex.Replace (input, pattern, evaluator, RegexOptions.CultureInvariant);
		return true;
	}

	private static string HexEvaluator (Match match)
	{
		return "&H" + GetSubstring (match, 1).ToUpper (CultureInfo.InvariantCulture);
	}

	private static int Main ()
	{
		TextReader reader = Console.In;
		TextWriter writer = Console.Out;
		TextWriter error = Console.Error;

		while ((line = reader.ReadLine ()) != null) {
			// Empty line
			if (IsMatch (@"^\s*$")) {

			// Comment
			} else if (Replace (@"(?<=^\s*)\/\/", @"'")) {

			// Class declaration
			} else if (IsMatch (@"^(\s*)internal\s*$")) {
				string indent = GetSubstring (1);

				while ((line = reader.ReadLine ()) != null) {
					if (!IsMatch (@"^\s*$"))
						continue;

					writer.WriteLine (indent + "Friend NotInheritable Class Consts");
					writer.WriteLine (indent + "\tPrivate Sub New()");
					writer.WriteLine (indent + "\tEnd Sub");
					writer.WriteLine ();
					break;
				}
				continue;

			// End of class definition
			} else if (Replace (@"(?<=^\s*)}\s*$", @"End Class")) {

			// Compiler directives
			} else if (Replace (@"(?<=^\s*)#\s*if\s+(.*)$", @"#If $1 Then") ||
				Replace (@"(?<=^\s*)#\s*elif\s+(.*)$", @"#ElseIf $1 Then")) {

				// Operators
				Replace (@"\s*!\s*", @" Not ");
				Replace (@"\s*&&\s*", @" AndAlso ");
				Replace (@"\s*\|\|\s*", @" OrElse ");

			} else if (Replace (@"(?<=^\s*)#\s*else\s*$", @"#Else")) {
			} else if (Replace (@"(?<=^\s*)#\s*endif\s*$", @"#End If")) {

			// Not supported but causes compilation error
			} else if (Replace (@"(?<=^\s*)#\s*error\s+(.*)$", @"#Error $1")) {

			// Constants
			} else if (IsMatch (@"^(\s*)public\s+const\s+(\S+)\s+(\S+)\s*=\s*(.*)\s*;\s*$")) {
				string indent = GetSubstring (1);
				string type = GetSubstring (2);
				string name = GetSubstring (3);
				string value = GetSubstring (4);
				bool isNumeric = false;

				switch (type) {
					case "bool":
						type = "Boolean";
						Replace (ref value, @"(?<=^|\s+)true(?=$|\s)", @"True");
						Replace (ref value, @"(?<=^|\s+)false(?=$|\s)", @"False");
						break;
					case "char":
						type = "Char";
						Replace (ref value, @"(?<=^|\s+)'(\S)'(?=$|\s)", @"""$1""C");
						break;
					case "sbyte":
						type = "SByte";
						isNumeric = true;
						break;
					case "byte":
						type = "Byte";
						isNumeric = true;
						break;
					case "short":
						type = "Short";
						isNumeric = true;
						break;
					case "ushort":
						type = "UShort";
						isNumeric = true;
						break;
					case "int":
						type = "Integer";
						isNumeric = true;
						break;
					case "uint":
						type = "UInteger";
						isNumeric = true;
						break;
					case "long":
						type = "Long";
						isNumeric = true;
						break;
					case "ulong":
						type = "ULong";
						isNumeric = true;
						break;
					case "float":
						type = "Single";
						break;
					case "double":
						type = "Double";
						break;
					case "decimal":
						type = "Decimal";
						break;
					case "object":
						type = "Object";
						break;
					case "string":
						type = "String";
						break;
					default:
						error.WriteLine ("Unsupported data type found");
						return 1;
				}

				if (isNumeric)
					Replace (ref value, @"(?<=^|\s+)0[Xx]([0-9A-Fa-f]+)(?=$|\s)", new MatchEvaluator (HexEvaluator));

				line = indent + "Public Const " + name + " As " + type + " = " + value;

			} else {
				error.WriteLine ("Unsupported source line found");
				return 1;
			}

			writer.WriteLine (line);
		}

		return 0;
	}
}
