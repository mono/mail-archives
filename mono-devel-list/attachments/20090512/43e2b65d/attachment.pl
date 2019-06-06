//
// System.String.cs
//
// Authors:
//   Patrik Torstensson
//   Jeffrey Stedfast (fejj@ximian.com)
//   Dan Lewis (dihlewis@yahoo.co.uk)
//   Sebastien Pouliot  <sebastien@ximian.com>
//   Marek Safar (marek.safar@seznam.cz)
//   Andreas Nahr (Classdevelopment@A-SoftTech.com)
//
// (C) 2001 Ximian, Inc.  http://www.ximian.com
// Copyright (C) 2004-2005 Novell (http://www.novell.com)
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
//
//
// This class contains all implementation for culture-insensitive methods.
// Culture-sensitive methods are implemented in the System.Globalization or
// Mono.Globalization namespace.
//
// Ensure that argument checks on methods don't overflow
//

using System.Text;
using System.Collections;
using System.Globalization;
using System.Runtime.CompilerServices;

#if NET_2_0
using System.Collections.Generic;
using System.Runtime.ConstrainedExecution;
using System.Runtime.InteropServices;
using Mono.Globalization.Unicode;
#endif

namespace System
{
	[Serializable]
#if NET_2_0
	[ComVisible (true)]
	public sealed class String : IConvertible, ICloneable, IEnumerable, IComparable, IComparable<String>, IEquatable <String>, IEnumerable<char>
#else
	public sealed class String : IConvertible, ICloneable, IEnumerable, IComparable
#endif
	{
		[NonSerialized] private int length;
		[NonSerialized] private char start_char;

		public static readonly String Empty = "";

		public static unsafe bool Equals (string a, string b)
		{
			if ((a as object) == (b as object))
				return true;

			if (a == null || b == null)
				return false;

			int len = a.length;

			if (len != b.length)
				return false;

			fixed (char* s1 = &a.start_char, s2 = &b.start_char) {
				char* s1_ptr = s1;
				char* s2_ptr = s2;

				while (len >= 8) {
					if (((int*)s1_ptr)[0] != ((int*)s2_ptr)[0] ||
						((int*)s1_ptr)[1] != ((int*)s2_ptr)[1] ||
						((int*)s1_ptr)[2] != ((int*)s2_ptr)[2] ||
						((int*)s1_ptr)[3] != ((int*)s2_ptr)[3])
						return false;

					s1_ptr += 8;
					s2_ptr += 8;
					len -= 8;
				}

				if (len >= 4) {
					if (((int*)s1_ptr)[0] != ((int*)s2_ptr)[0] ||
						((int*)s1_ptr)[1] != ((int*)s2_ptr)[1])
						return false;

					s1_ptr += 4;
					s2_ptr += 4;
					len -= 4;
				}

				if (len > 1) {
					if (((int*)s1_ptr)[0] != ((int*)s2_ptr)[0])
						return false;

					s1_ptr += 2;
					s2_ptr += 2;
					len -= 2;
				}

				return len == 0 || *s1_ptr == *s2_ptr;
			}
		}

		public static bool operator == (String a, String b)
		{
			return Equals (a, b);
		}

		public static bool operator != (String a, String b)
		{
			return !Equals (a, b);
		}

#if NET_2_0
		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, Cer.MayFail)]
#endif
		public override bool Equals (Object obj)
		{
			return Equals (this, obj as String);
		}

#if NET_2_0
		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, Cer.MayFail)]
#endif
		public bool Equals (String value)
		{
			return Equals (this, value);
		}

		[IndexerName ("Chars")]
		public unsafe char this [int index] {
			get {
				if (index < 0 || index >= length)
					throw new IndexOutOfRangeException ();
				fixed (char* c = &start_char)
					return c[index];
			}
		}

		public Object Clone ()
		{
			return this;
		}

		public TypeCode GetTypeCode ()
		{
			return TypeCode.String;
		}

		public unsafe void CopyTo (int sourceIndex, char[] destination, int destinationIndex, int count)
		{
			if (destination == null)
				throw new ArgumentNullException ("destination");

			if (sourceIndex < 0 || destinationIndex < 0 || count < 0)
				throw new ArgumentOutOfRangeException (); 

			if (sourceIndex > Length - count)
				throw new ArgumentOutOfRangeException ("sourceIndex + count > Length");

			if (destinationIndex > destination.Length - count)
				throw new ArgumentOutOfRangeException ("destinationIndex + count > destination.Length");

			fixed (char* dest = destination, src = this)
				CharCopy (dest + destinationIndex, src + sourceIndex, count);
		}

		public unsafe char[] ToCharArray ()
		{
			char[] tmp = new char [length];
			fixed (char* dest = tmp, src = this)
				CharCopy (dest, src, length);
			return tmp;
		}

		public unsafe char[] ToCharArray (int startIndex, int length)
		{
			if (startIndex < 0)
				throw new ArgumentOutOfRangeException ("startIndex", "< 0"); 
			if (length < 0)
				throw new ArgumentOutOfRangeException ("length", "< 0"); 

			if (startIndex > this.length - length)
				throw new ArgumentOutOfRangeException ("startIndex + length > this.length"); 

			char[] tmp = new char [length];
			fixed (char* dest = tmp, src = this)
				CharCopy (dest + startIndex, src, length);
			return tmp;
		}

		public String [] Split (params char [] separator)
		{
			if (separator == null || separator.Length == 0)
				separator = null;

			return SplitKeepEmpty (length, separator);
		}

		public String[] Split (char[] separator, int count)
		{
			if (count < 0)
				throw new ArgumentOutOfRangeException ("count");

			if (count == 0)
				return new String[0];
			if (count == 1) 
				return new String[1] { this };

			return SplitKeepEmpty (count - 1, separator);
		}

#if NET_2_0
		[ComVisible (false)]
		public String[] Split (char[] separator, int count, StringSplitOptions options)
		{
			if (count < 0)
				throw new ArgumentOutOfRangeException ("count", "Count cannot be less than zero.");
			if ((options != StringSplitOptions.None) && (options != StringSplitOptions.RemoveEmptyEntries))
				throw new ArgumentException ("options must be one of the values in the StringSplitOptions enumeration", "options");

			if (count == 0)
				return new String[0];
			if (separator == null || separator.Length == 0)
				separator = null;

			if (options == StringSplitOptions.RemoveEmptyEntries)
				return SplitRemoveEmpty (count - 1, separator);
			return SplitKeepEmpty (count - 1, separator);
		}

		[ComVisible (false)]
		public String[] Split (string[] separator, int count, StringSplitOptions options)
		{
			if (count < 0)
				throw new ArgumentOutOfRangeException ("count", "Count cannot be less than zero.");
			if ((options != StringSplitOptions.None) && (options != StringSplitOptions.RemoveEmptyEntries))
				throw new ArgumentException ("Illegal enum value: " + options + ".", "options");

			bool removeEmpty = (options & StringSplitOptions.RemoveEmptyEntries) == StringSplitOptions.RemoveEmptyEntries;

			if (count == 0 || (this == String.Empty && removeEmpty))
				return new String [0];

			if (separator == null || separator.Length == 0) {
				if (removeEmpty)
					return SplitRemoveEmpty (count - 1, null);
				return SplitKeepEmpty (count - 1, null);
			}

			ArrayList arr = new ArrayList ();

			int pos = 0;
			int matchCount = 0;
			while (pos < this.Length) {
				int matchIndex = -1;
				int matchPos = Int32.MaxValue;

				// Find the first position where any of the separators matches
				for (int i = 0; i < separator.Length; ++i) {
					string sep = separator [i];
					if (sep == null || sep == String.Empty)
						continue;

					int match = IndexOf (sep, pos);
					if (match > -1 && match < matchPos) {
						matchIndex = i;
						matchPos = match;
					}
				}

				if (matchIndex == -1)
					break;

				if (!(matchPos == pos && removeEmpty))
					arr.Add (this.SubstringUnchecked (pos, matchPos - pos));

				pos = matchPos + separator [matchIndex].Length;

				matchCount ++;

				if (matchCount == count - 1)
					break;
			}

			if (matchCount == 0)
				return new String [] { this };
			else {
				if (removeEmpty && pos == this.Length) {
					String[] res = new String [arr.Count];
					arr.CopyTo (0, res, 0, arr.Count);

					return res;
				}
				else {
					String[] res = new String [arr.Count + 1];
					arr.CopyTo (0, res, 0, arr.Count);
					res [arr.Count] = this.Substring (pos);

					return res;
				}
			}
		}

		[ComVisible (false)]
		public String[] Split (char[] separator, StringSplitOptions options)
		{
			if ((options != StringSplitOptions.None) && (options != StringSplitOptions.RemoveEmptyEntries))
				throw new ArgumentException ("options must be one of the values in the StringSplitOptions enumeration", "options");

			if (separator == null || separator.Length == 0)
				separator = null;

			if (options == StringSplitOptions.RemoveEmptyEntries)
				return SplitRemoveEmpty (length, separator);
			return SplitKeepEmpty (length, separator);
		}

		[ComVisible (false)]
		public String[] Split (String[] separator, StringSplitOptions options)
		{
			if ((options != StringSplitOptions.None) && (options != StringSplitOptions.RemoveEmptyEntries))
				throw new ArgumentException ("options must be one of the values in the StringSplitOptions enumeration", "options");

			if (separator == null || separator.Length == 0) {
				if (options == StringSplitOptions.RemoveEmptyEntries)
					return SplitRemoveEmpty (length, null);
				return SplitKeepEmpty (length, null);
			}

			return Split (separator, Int32.MaxValue, options);
		}

		private unsafe String[] SplitRemoveEmpty (int maxCount, char[] separator)
		{
			if (length == 0) return new String[0];
			if (maxCount == 0) return new String[1] { this };
			int found = 0;
			maxCount++; // Search one additinal split to check if empty entries follow
			int maxLocal = Math.Min (maxCount, 100);
			int* datS = stackalloc int[maxLocal]; // Allocate max 400*2 byte on stack
			int* datL = stackalloc int[maxLocal];
			bool defaultSeparator = (separator == null);
			fixed (char* source = this, toTest = separator) {
				int i = 0;
				int charCount = 0;
				for (; i < length; i++) {
					bool isSeparator = false;
					if (defaultSeparator)
						isSeparator = Char.IsWhiteSpace (source[i]);
					else {
						for (int k = 0; k < separator.Length; k++)
							if (source[i] == toTest[k]) {
								isSeparator = true;
								break;
							}
					}
					if (isSeparator) {
						if (charCount != 0) {
							datL[found] = charCount;
							datS[found++] = i - charCount;
							if (found == maxLocal) {
								if (found == maxCount)
									break;
								return SplitFallback (--maxCount, false, separator, found - 1, i);
							}
							charCount = 0;
						}
					}
					else
						charCount++;
				}
				if (found == 0) {
					if (charCount == 0)
						return new String[0];
					else if (charCount == length)
						return new String[1] { this };
					return new String[1] { SubstringUnchecked (length - charCount, charCount) };
				}

				String[] ret = new String[found];
				found--;
				for (int j = 0; j < found; j++)
					ret[j] = SubstringUnchecked (datS[j], datL[j]);

				if (charCount == 0) // We ended without hitting maxCount
					ret[found] = SubstringUnchecked (datS[found], datL[found]);
				else { // Limited by maxCount - add the remaining data
					ret[found] = SubstringUnchecked (datS[found], length - datS[found]);
				}
				return ret;
			}
		}
#endif

		private unsafe String[] SplitKeepEmpty (int maxCount, char[] separator)
		{
			if (maxCount == 0) return new String[1] { this };
			int found = 0;
			int maxLocal = Math.Min (maxCount, 200); // Allocate max 800 byte on stack
			int* dat = stackalloc int[maxLocal];
			bool defaultSeparator = (separator == null);
			fixed (char* source = this, toTest = separator) {
				int i = 0;
				for (int charCount = 0; i < length; i++) {
					bool isSeparator = false;
					if (defaultSeparator)
						isSeparator = Char.IsWhiteSpace (source[i]);
					else {
						for (int k = 0; k < separator.Length; k++)
							if (source[i] == toTest[k]) {
								isSeparator = true;
								break;
							}
					}
					if (isSeparator) {
						dat[found++] = charCount;
						if (found == maxLocal) {
							if (found == maxCount)
								break;
							return SplitFallback (maxCount, true, separator, found - 1, i);
						}
						charCount = 0;
					}
					else
						charCount++;
				}
				if (found == 0)
					return new String[1] { this };

				String[] ret = new String[found + 1];
				int pos = 0;
				for (int j = 0; j < found; j++) {
					ret[j] = SubstringUnchecked (pos, dat[j]);
					pos += dat[j] + 1;
				}
				ret[found] = SubstringUnchecked (pos, length - pos);
				return ret;
			}
		}

		private unsafe String[] SplitFallback (int maxCount, bool keepEmpty, char[] separator, int found, int startPos)
		{
			// found should to be > 1, checks are not made in this fallback method
			fixed (char* source = this, toTest = separator) {
				int charCountPrimary = 0;
				for (int i = startPos; i < length; i++) {
					bool isSeparator = false;
					if (separator == null)
						isSeparator = Char.IsWhiteSpace (source[i]);
					else {
						for (int k = 0; k < separator.Length; k++)
							if (source[i] == toTest[k]) {
								isSeparator = true;
								break;
							}
					}
					if (isSeparator) {
						if (keepEmpty)
							found++;
						else
							if (charCountPrimary > 0)
								found++;
						charCountPrimary = 0;
						if (found == maxCount)
							break;
					}
					else
						charCountPrimary++;
				}

				String[] ret = new String[found + 1];
				int charCount = 0;
				int resultPos = 0;

				int charPos = 0;
				for (; resultPos < found; charPos++) {
					bool isSeparator = false;
					if (separator == null)
						isSeparator = Char.IsWhiteSpace (source[charPos]);
					else {
						for (int k = 0; k < separator.Length; k++)
							if (source[charPos] == toTest[k]) {
								isSeparator = true;
								break;
							}
					}
					if (isSeparator) {
						if (charCount > 0)
							ret[resultPos++] = SubstringUnchecked (charPos - charCount, charCount);
						else
							if (keepEmpty)
								ret[resultPos++] = String.Empty;
						charCount = 0;
					}
					else
						charCount++;
				}
				if (keepEmpty)
					ret[resultPos] = SubstringUnchecked (charPos, length - charPos);
				else if (found == maxCount) // Case where empty results may appear before the rest
					ret[resultPos] = SubstringUnchecked (charPos, length - charPos).TrimStart (separator);
				else // Case where empty results may appear before and after the rest
					ret[resultPos] = SubstringUnchecked (charPos, length - charPos).Trim (separator);

				return ret;
			}
		}

		public String Substring (int startIndex)
		{
			if (startIndex == 0)
				return this;

			if (startIndex < 0 || startIndex > this.length)
				throw new ArgumentOutOfRangeException ("startIndex");

			return SubstringUnchecked (startIndex, this.length - startIndex);
		}

		public String Substring (int startIndex, int length)
		{
			if (length < 0)
				throw new ArgumentOutOfRangeException ("length", "< 0");
			if (startIndex < 0)
				throw new ArgumentOutOfRangeException ("startIndex", "< 0");
			if (startIndex > this.length - length)
				throw new ArgumentOutOfRangeException ("startIndex + length > this.length");

			return SubstringUnchecked (startIndex, length);
		}

		internal unsafe String SubstringUnchecked (int startIndex, int length)
		{
			if (length == 0)
				return String.Empty;

			string tmp = InternalAllocateStr (length);
			fixed (char* dest = tmp, src = this) {
				CharCopy (dest, src + startIndex, length);
			}
			return tmp;
		}

		public String Trim ()
		{
			if (length == 0) 
				return String.Empty;
			int start = FindNotWhiteSpace (0, length, 1);

			if (start == length)
				return String.Empty;

			int end = FindNotWhiteSpace (length - 1, start, -1);

			int newLength = end - start + 1;
			if (newLength == length)
				return this;

			return SubstringUnchecked (start, newLength);
		}

		public String Trim (params char[] trimChars)
		{
			if (trimChars == null || trimChars.Length == 0)
				return Trim ();

			if (length == 0) 
				return String.Empty;
			int start = FindNotInTable (0, length, 1, trimChars);

			if (start == length)
				return String.Empty;

			int end = FindNotInTable (length - 1, start, -1, trimChars);

			int newLength = end - start + 1;
			if (newLength == length)
				return this;

			return SubstringUnchecked (start, newLength);
		}

		public String TrimStart (params char[] trimChars)
		{
			if (length == 0) 
				return String.Empty;
			int start;
			if (trimChars == null || trimChars.Length == 0)
				start = FindNotWhiteSpace (0, length, 1);
			else
				start = FindNotInTable (0, length, 1, trimChars);

			if (start == 0)
				return this;

			return SubstringUnchecked (start, length - start);
		}

		public String TrimEnd (params char[] trimChars)
		{
			if (length == 0) 
				return String.Empty;
			int end;
			if (trimChars == null || trimChars.Length == 0)
				end = FindNotWhiteSpace (length - 1, -1, -1);
			else
				end = FindNotInTable (length - 1, -1, -1, trimChars);

			end++;
			if (end == length)
				return this;

			return SubstringUnchecked (0, end);
		}

		private int FindNotWhiteSpace (int pos, int target, int change)
		{
			while (pos != target) {
				char c = this[pos];
				if (c < 0x85) {
					if (c != 0x20) {
						if (c < 0x9 || c > 0xD)
							return pos;
					}
				}
				else {
					if (c != 0xA0 && c != 0xFEFF && c != 0x3000) {
#if NET_2_0
						if (c != 0x85 && c != 0x1680 && c != 0x2028 && c != 0x2029)
#endif
							if (c < 0x2000 || c > 0x200B)
								return pos;
					}
				}
				pos += change;
			}
			return pos;
		}

		private unsafe int FindNotInTable (int pos, int target, int change, char[] table)
		{
			fixed (char* tablePtr = table, thisPtr = this) {
				while (pos != target) {
					char c = thisPtr[pos];
					int x = 0;
					while (x < table.Length) {
						if (c == tablePtr[x])
							break;
						x++;
					}
					if (x == table.Length)
						return pos;
					pos += change;
				}
			}
			return pos;
		}

		public static int Compare (String strA, String strB)
		{
			return CultureInfo.CurrentCulture.CompareInfo.Compare (strA, strB, CompareOptions.None);
		}

		public static int Compare (String strA, String strB, bool ignoreCase)
		{
			return CultureInfo.CurrentCulture.CompareInfo.Compare (strA, strB, ignoreCase ? CompareOptions.IgnoreCase : CompareOptions.None);
		}

		public static int Compare (String strA, String strB, bool ignoreCase, CultureInfo culture)
		{
			if (culture == null)
				throw new ArgumentNullException ("culture");

			return culture.CompareInfo.Compare (strA, strB, ignoreCase ? CompareOptions.IgnoreCase : CompareOptions.None);
		}

		public static int Compare (String strA, int indexA, String strB, int indexB, int length)
		{
			return Compare (strA, indexA, strB, indexB, length, false, CultureInfo.CurrentCulture);
		}

		public static int Compare (String strA, int indexA, String strB, int indexB, int length, bool ignoreCase)
		{
			return Compare (strA, indexA, strB, indexB, length, ignoreCase, CultureInfo.CurrentCulture);
		}
		
		public static int Compare (String strA, int indexA, String strB, int indexB, int length, bool ignoreCase, CultureInfo culture)
		{
			if (culture == null)
				throw new ArgumentNullException ("culture");

			if ((indexA > strA.Length) || (indexB > strB.Length) || (indexA < 0) || (indexB < 0) || (length < 0))
				throw new ArgumentOutOfRangeException ();

			if (length == 0)
				return 0;
			
			if (strA == null) {
				if (strB == null) {
					return 0;
				} else {
					return -1;
				}
			}
			else if (strB == null) {
				return 1;
			}

			CompareOptions compopts;

			if (ignoreCase)
				compopts = CompareOptions.IgnoreCase;
			else
				compopts = CompareOptions.None;

			// Need to cap the requested length to the
			// length of the string, because
			// CompareInfo.Compare will insist that length
			// <= (string.Length - offset)

			int len1 = length;
			int len2 = length;
			
			if (length > (strA.Length - indexA)) {
				len1 = strA.Length - indexA;
			}

			if (length > (strB.Length - indexB)) {
				len2 = strB.Length - indexB;
			}

			// ENHANCE: Might call internal_compare_switch directly instead of doing all checks twice
			return culture.CompareInfo.Compare (strA, indexA, len1, strB, indexB, len2, compopts);
		}
#if NET_2_0
		public static int Compare (string strA, string strB, StringComparison comparisonType)
		{
			switch (comparisonType) {
			case StringComparison.CurrentCulture:
				return Compare (strA, strB, false, CultureInfo.CurrentCulture);
			case StringComparison.CurrentCultureIgnoreCase:
				return Compare (strA, strB, true, CultureInfo.CurrentCulture);
			case StringComparison.InvariantCulture:
				return Compare (strA, strB, false, CultureInfo.InvariantCulture);
			case StringComparison.InvariantCultureIgnoreCase:
				return Compare (strA, strB, true, CultureInfo.InvariantCulture);
			case StringComparison.Ordinal:
				return CompareOrdinalUnchecked (strA, 0, Int32.MaxValue, strB, 0, Int32.MaxValue);
			case StringComparison.OrdinalIgnoreCase:
				return CompareOrdinalCaseInsensitiveUnchecked (strA, 0, Int32.MaxValue, strB, 0, Int32.MaxValue);
			default:
				string msg = Locale.GetText ("Invalid value '{0}' for StringComparison", comparisonType);
				throw new ArgumentException (msg, "comparisonType");
			}
		}

		public static int Compare (string strA, int indexA, string strB, int indexB, int length, StringComparison comparisonType)
		{
			switch (comparisonType) {
			case StringComparison.CurrentCulture:
				return Compare (strA, indexA, strB, indexB, length, false, CultureInfo.CurrentCulture);
			case StringComparison.CurrentCultureIgnoreCase:
				return Compare (strA, indexA, strB, indexB, length, true, CultureInfo.CurrentCulture);
			case StringComparison.InvariantCulture:
				return Compare (strA, indexA, strB, indexB, length, false, CultureInfo.InvariantCulture);
			case StringComparison.InvariantCultureIgnoreCase:
				return Compare (strA, indexA, strB, indexB, length, true, CultureInfo.InvariantCulture);
			case StringComparison.Ordinal:
				return CompareOrdinal (strA, indexA, strB, indexB, length);
			case StringComparison.OrdinalIgnoreCase:
				return CompareOrdinalCaseInsensitive (strA, indexA, strB, indexB, length);
			default:
				string msg = Locale.GetText ("Invalid value '{0}' for StringComparison", comparisonType);
				throw new ArgumentException (msg, "comparisonType");
			}
		}

		public static bool Equals (string a, string b, StringComparison comparisonType)
		{
			return String.Compare (a, b, comparisonType) == 0;
		}

		public bool Equals (string value, StringComparison comparisonType)
		{
			return String.Compare (value, this, comparisonType) == 0;
		}
#endif
		public int CompareTo (Object value)
		{
			if (value == null)
				return 1;

			if (!(value is String))
				throw new ArgumentException ();

			return String.Compare (this, (String) value);
		}

		public int CompareTo (String strB)
		{
			if (strB == null)
				return 1;

			return Compare (this, strB);
		}

		public static int CompareOrdinal (String strA, String strB)
		{
			return CompareOrdinalUnchecked (strA, 0, Int32.MaxValue, strB, 0, Int32.MaxValue);
		}

		public static int CompareOrdinal (String strA, int indexA, String strB, int indexB, int length)
		{
			if ((indexA > strA.Length) || (indexB > strB.Length) || (indexA < 0) || (indexB < 0) || (length < 0))
				throw new ArgumentOutOfRangeException ();

			return CompareOrdinalUnchecked (strA, indexA, length, strB, indexB, length);
		}

		internal static int CompareOrdinalCaseInsensitive (String strA, int indexA, String strB, int indexB, int length)
		{
			if ((indexA > strA.Length) || (indexB > strB.Length) || (indexA < 0) || (indexB < 0) || (length < 0))
				throw new ArgumentOutOfRangeException ();

			return CompareOrdinalCaseInsensitiveUnchecked (strA, indexA, length, strB, indexB, length);
		}

		internal static unsafe int CompareOrdinalUnchecked (String strA, int indexA, int lenA, String strB, int indexB, int lenB)
		{
			if (strA == null) {
				if (strB == null)
					return 0;
				else
					return -1;
			} else if (strB == null) {
				return 1;
			}
			int lengthA = Math.Min (lenA, strA.Length - indexA);
			int lengthB = Math.Min (lenB, strB.Length - indexB);

			if (lengthA == lengthB && Object.ReferenceEquals (strA, strB))
				return 0;

			fixed (char* aptr = strA, bptr = strB) {
				char* ap = aptr + indexA;
				char* end = ap + Math.Min (lengthA, lengthB);
				char* bp = bptr + indexB;
				while (ap < end) {
					if (*ap != *bp)
						return *ap - *bp;
					ap++;
					bp++;
				}
				return lengthA - lengthB;
			}
		}

		internal static unsafe int CompareOrdinalCaseInsensitiveUnchecked (String strA, int indexA, int lenA, String strB, int indexB, int lenB)
		{
			// Same as above, but checks versus uppercase characters
			if (strA == null) {
				if (strB == null)
					return 0;
				else
					return -1;
			} else if (strB == null) {
				return 1;
			}
			int lengthA = Math.Min (lenA, strA.Length - indexA);
			int lengthB = Math.Min (lenB, strB.Length - indexB);

			if (lengthA == lengthB && Object.ReferenceEquals (strA, strB))
				return 0;

			fixed (char* aptr = strA, bptr = strB) {
				char* ap = aptr + indexA;
				char* end = ap + Math.Min (lengthA, lengthB);
				char* bp = bptr + indexB;
				while (ap < end) {
					if (*ap != *bp) {
						char c1 = Char.ToUpperInvariant (*ap);
						char c2 = Char.ToUpperInvariant (*bp);
						if (c1 != c2)
							return c1 - c2;
					}
					ap++;
					bp++;
				}
				return lengthA - lengthB;
			}
		}

		public bool EndsWith (String value)
		{
			return CultureInfo.CurrentCulture.CompareInfo.IsSuffix (this, value, CompareOptions.None);
		}

#if NET_2_0
		public
#else
		internal
#endif
		bool EndsWith (String value, bool ignoreCase, CultureInfo culture)
		{
			if (culture == null)
				culture = CultureInfo.CurrentCulture;

			return culture.CompareInfo.IsSuffix (this, value,
				ignoreCase ? CompareOptions.IgnoreCase : CompareOptions.None);
		}

		// Following methods are culture-insensitive
		public int IndexOfAny (char [] anyOf)
		{
			if (anyOf == null)
				throw new ArgumentNullException ("anyOf");
			if (this.length == 0)
				return -1;

			return IndexOfAnyUnchecked (anyOf, 0, this.length);
		}

		public int IndexOfAny (char [] anyOf, int startIndex)
		{
			if (anyOf == null)
				throw new ArgumentNullException ("anyOf");
			if (startIndex < 0 || startIndex > this.length)
				throw new ArgumentOutOfRangeException ("startIndex");

			return IndexOfAnyUnchecked (anyOf, startIndex, this.length - startIndex);
		}

		public int IndexOfAny (char [] anyOf, int startIndex, int count)
		{
			if (anyOf == null)
				throw new ArgumentNullException ("anyOf");
			if (startIndex < 0)
				throw new ArgumentOutOfRangeException ("startIndex", "< 0");
			if (count < 0)
				throw new ArgumentOutOfRangeException ("count", "< 0");
			if (startIndex > this.length - count)
				throw new ArgumentOutOfRangeException ("startIndex + count > this.length");

			return IndexOfAnyUnchecked (anyOf, startIndex, count);
		}

		private unsafe int IndexOfAnyUnchecked (char[] anyOf, int startIndex, int count)
		{
			if (anyOf.Length == 0)
				return -1;

			if (anyOf.Length == 1)
				return IndexOfUnchecked (anyOf[0], startIndex, count);

			fixed (char* any = anyOf) {
				// FIXME: My assumption is this may fail on 64-bit Systems
				// Switch to char*
				int highest = *any;
				int lowest = *any;

				char* end_any_ptr = any + anyOf.Length;
				char* any_ptr = any;
				while (++any_ptr != end_any_ptr) {
					if (*any_ptr > highest) {
						highest = *any_ptr;
						continue;
					}

					if (*any_ptr < lowest)
						lowest = *any_ptr;
				}

				fixed (char* start = &start_char) {
					char* ptr = start + startIndex;
					char* end_ptr = ptr + count;

					while (ptr != end_ptr) {
						if (*ptr > highest || *ptr < lowest) {
							ptr++;
							continue;
						}

						if (*ptr == *any)
							return (int)(ptr - start);

						any_ptr = any;
						while (++any_ptr != end_any_ptr) {
							if (*ptr == *any_ptr)
								return (int)(ptr - start);
						}

						ptr++;
					}
				}
			}
			return -1;
		}


#if NET_2_0
		public int IndexOf (string value, StringComparison comparisonType)
		{
			return IndexOf (value, 0, this.Length, comparisonType);
		}

		public int IndexOf (string value, int startIndex, StringComparison comparisonType)
		{
			return IndexOf (value, startIndex, this.Length - startIndex, comparisonType);
		}

		public int IndexOf (string value, int startIndex, int count, StringComparison comparisonType)
		{
			switch (comparisonType) {
			case StringComparison.CurrentCulture:
				return CultureInfo.CurrentCulture.CompareInfo.IndexOf (this, value, startIndex, count, CompareOptions.None);
			case StringComparison.CurrentCultureIgnoreCase:
				return CultureInfo.CurrentCulture.CompareInfo.IndexOf (this, value, startIndex, count, CompareOptions.IgnoreCase);
			case StringComparison.InvariantCulture:
				return CultureInfo.InvariantCulture.CompareInfo.IndexOf (this, value, startIndex, count, CompareOptions.None);
			case StringComparison.InvariantCultureIgnoreCase:
				return CultureInfo.InvariantCulture.CompareInfo.IndexOf (this, value, startIndex, count, CompareOptions.IgnoreCase);
			case StringComparison.Ordinal:
				return IndexOfOrdinal (value, startIndex, count, CompareOptions.Ordinal);
			case StringComparison.OrdinalIgnoreCase:
				return IndexOfOrdinal (value, startIndex, count, CompareOptions.OrdinalIgnoreCase);
			default:
				string msg = Locale.GetText ("Invalid value '{0}' for StringComparison", comparisonType);
				throw new ArgumentException (msg, "comparisonType");
			}
		}

#endif

		internal unsafe int IndexOfOrdinal (string value, int startIndex, int count, CompareOptions options)
		{
			if (value == null)
				throw new ArgumentNullException ("value");
			if (startIndex < 0)
				throw new ArgumentOutOfRangeException ("startIndex");
			if (count < 0 || (this.length - startIndex) < count)
				throw new ArgumentOutOfRangeException ("count");

			if (options == CompareOptions.Ordinal)
				return IndexOfOrdinalUnchecked (value, startIndex, count);
			return IndexOfOrdinalIgnoreCaseUnchecked (value, startIndex, count);
		}

		internal unsafe int IndexOfOrdinalUnchecked (string value, int startIndex, int count)
		{
			int valueLen = value.Length;
			if (valueLen <= 1) {
				if (valueLen == 1)
					return IndexOfUnchecked (value[0], startIndex, count);
				return 0;
			}

			fixed (char* thisptr = this, valueptr = value) {
				char* ap = thisptr + startIndex;
				char* thisEnd = ap + count - valueLen + 1;
				while (ap != thisEnd) {
					if (*ap == *valueptr) {
						for (int i = 1; i < valueLen; i++) {
							if (ap[i] != valueptr[i])
								goto NextVal;
						}
						return (int)(ap - thisptr);
					}
					NextVal:
					ap++;
				}
			}
			return -1;
		}

		internal unsafe int IndexOfOrdinalIgnoreCaseUnchecked (string value, int startIndex, int count)
		{
			int valueLen = value.Length;
			if (valueLen == 0)
				return 0;

			fixed (char* thisptr = this, valueptr = value) {
				char* ap = thisptr + startIndex;
				char* thisEnd = ap + count - valueLen + 1;
				while (ap != thisEnd) {
					for (int i = 0; i < valueLen; i++) {
						if (Char.ToUpperInvariant (ap[i]) != Char.ToUpperInvariant (valueptr[i]))
							goto NextVal;
					}
					return (int)(ap - thisptr);
					NextVal:
					ap++;
				}
			}
			return -1;
		}

#if NET_2_0

		public int LastIndexOf (string value, StringComparison comparisonType)
		{
			return LastIndexOf (value, value.Length - 1, value.Length, comparisonType);
		}

		public int LastIndexOf (string value, int startIndex, StringComparison comparisonType)
		{
			return LastIndexOf (value, startIndex, startIndex + 1, comparisonType);
		}

		public int LastIndexOf (string value, int startIndex, int count, StringComparison comparisonType)
		{
			switch (comparisonType) {
			case StringComparison.CurrentCulture:
				return CultureInfo.CurrentCulture.CompareInfo.LastIndexOf (this, value, startIndex, count, CompareOptions.None);
			case StringComparison.CurrentCultureIgnoreCase:
				return CultureInfo.CurrentCulture.CompareInfo.LastIndexOf (this, value, startIndex, count, CompareOptions.IgnoreCase);
			case StringComparison.InvariantCulture:
				return CultureInfo.InvariantCulture.CompareInfo.LastIndexOf (this, value, startIndex, count, CompareOptions.None);
			case StringComparison.InvariantCultureIgnoreCase:
				return CultureInfo.InvariantCulture.CompareInfo.LastIndexOf (this, value, startIndex, count, CompareOptions.IgnoreCase);
			case StringComparison.Ordinal:
				return LastIndexOfOrdinal (value, startIndex, count, CompareOptions.Ordinal);
			case StringComparison.OrdinalIgnoreCase:
				return LastIndexOfOrdinal (value, startIndex, count, CompareOptions.OrdinalIgnoreCase);
			default:
				string msg = Locale.GetText ("Invalid value '{0}' for StringComparison", comparisonType);
				throw new ArgumentException (msg, "comparisonType");
			}
		}
#endif

		internal unsafe int LastIndexOfOrdinal (string value, int startIndex, int count, CompareOptions options)
		{
			if (value == null)
				throw new ArgumentNullException ("value");
			if (startIndex < 0)
				throw new ArgumentOutOfRangeException ("startIndex");
			if (count < 0 || (startIndex - count) < 0)
				throw new ArgumentOutOfRangeException ("count");

			if (options == CompareOptions.Ordinal)
				return LastIndexOfOrdinalUnchecked (value, startIndex, count);
			return LastIndexOfOrdinalIgnoreCaseUnchecked (value, startIndex, count);
		}

		internal unsafe int LastIndexOfOrdinalUnchecked (string value, int startIndex, int count)
		{
			int valueLen = value.Length;
			if (valueLen <= 1) {
				if (valueLen == 1)
					return LastIndexOfUnchecked (value[0], startIndex, count);
				return 0;
			}

			fixed (char* thisptr = this, valueptr = value) {
				char* ap = thisptr + startIndex;
				char* thisEnd = ap - count;
				while (ap != thisEnd) {
					if (*ap == *valueptr) {
						for (int i = 1; i < valueLen; i++) {
							if (ap[i] != valueptr[i])
								goto NextVal;
						}
						return (int)(ap - thisptr);
					}
					NextVal:
					ap--;
				}
			}
			return -1;
		}

		internal unsafe int LastIndexOfOrdinalIgnoreCaseUnchecked (string value, int startIndex, int count)
		{
			int valueLen = value.Length;
			if (valueLen == 0)
				return 0;

			fixed (char* thisptr = this, valueptr = value) {
				char* ap = thisptr + startIndex;
				char* thisEnd = ap - count;
				while (ap != thisEnd) {
					for (int i = 0; i < valueLen; i++) {
						if (Char.ToUpperInvariant (ap[i]) != Char.ToUpperInvariant (valueptr[i]))
							goto NextVal;
					}
					return (int)(ap - thisptr);
					NextVal:
					ap--;
				}
			}
			return -1;
		}

		// Following methods are culture-insensitive
		public int IndexOf (char value)
		{
			if (this.length == 0)
				return -1;

			return IndexOfUnchecked (value, 0, this.length);
		}

		public int IndexOf (char value, int startIndex)
		{
			if (startIndex < 0)
				throw new ArgumentOutOfRangeException ("startIndex", "< 0");
			if (startIndex > this.length)
				throw new ArgumentOutOfRangeException ("startIndex", "startIndex > this.length");

			if ((startIndex == 0 && this.length == 0) || (startIndex == this.length))
				return -1;

			return IndexOfUnchecked (value, startIndex, this.length - startIndex);
		}

		public int IndexOf (char value, int startIndex, int count)
		{
			if (startIndex < 0)
				throw new ArgumentOutOfRangeException ("startIndex", "< 0");
			if (count < 0)
				throw new ArgumentOutOfRangeException ("count", "< 0");
			if (startIndex > this.length - count)
				throw new ArgumentOutOfRangeException ("startIndex + count > this.length");

			if ((startIndex == 0 && this.length == 0) || (startIndex == this.length) || (count == 0))
				return -1;

			return IndexOfUnchecked (value, startIndex, count);
		}

		unsafe int IndexOfUnchecked (char value, int startIndex, int count)
		{
			// It helps JIT compiler to optimize comparison
			int value_32 = (int)value;

			fixed (char* start = &start_char) {
				char* ptr = start + startIndex;
				char* end_ptr = ptr + (count >> 3 << 3);

				while (ptr != end_ptr) {
					if (*ptr == value_32)
						return (int)(ptr - start);
					if (ptr[1] == value_32)
						return (int)(ptr - start + 1);
					if (ptr[2] == value_32)
						return (int)(ptr - start + 2);
					if (ptr[3] == value_32)
						return (int)(ptr - start + 3);
					if (ptr[4] == value_32)
						return (int)(ptr - start + 4);
					if (ptr[5] == value_32)
						return (int)(ptr - start + 5);
					if (ptr[6] == value_32)
						return (int)(ptr - start + 6);
					if (ptr[7] == value_32)
						return (int)(ptr - start + 7);

					ptr += 8;
				}

				end_ptr += count & 0x07;
				while (ptr != end_ptr) {
					if (*ptr == value_32)
						return (int)(ptr - start);

					ptr++;
				}
				return -1;
			}
		}

		// Following methods are culture-sensitive
		public int IndexOf (String value)
		{
			if (value == null)
				throw new ArgumentNullException ("value");
			if (value.length == 0)
				return 0;
			if (this.length == 0)
				return -1;
			return CultureInfo.CurrentCulture.CompareInfo.IndexOf (this, value, 0, length);
		}

		public int IndexOf (String value, int startIndex)
		{
			return IndexOf (value, startIndex, this.length - startIndex);
		}

		public int IndexOf (String value, int startIndex, int count)
		{
			if (value == null)
				throw new ArgumentNullException ("value");
			if (startIndex < 0)
				throw new ArgumentOutOfRangeException ("startIndex", "< 0");
			if (count < 0)
				throw new ArgumentOutOfRangeException ("count", "< 0");
			if (startIndex > this.length - count)
				throw new ArgumentOutOfRangeException ("startIndex + count > this.length");

			if (value.length == 0)
				return startIndex;

			if (startIndex == 0 && this.length == 0)
				return -1;

			if (count == 0)
				return -1;

			return CultureInfo.CurrentCulture.CompareInfo.IndexOf (this, value, startIndex, count);
		}

		// Following methods are culture-insensitive
		public int LastIndexOfAny (char [] anyOf)
		{
			if (anyOf == null)
				throw new ArgumentNullException ("anyOf");

			return LastIndexOfAnyUnchecked (anyOf, this.length - 1, this.length);
		}

		public int LastIndexOfAny (char [] anyOf, int startIndex)
		{
			if (anyOf == null) 
				throw new ArgumentNullException ("anyOf");

			if (startIndex < 0 || startIndex >= this.length)
				throw new ArgumentOutOfRangeException ();

			if (this.length == 0)
				return -1;

			return LastIndexOfAnyUnchecked (anyOf, startIndex, startIndex + 1);
		}

		public int LastIndexOfAny (char [] anyOf, int startIndex, int count)
		{
			if (anyOf == null) 
				throw new ArgumentNullException ("anyOf");

			if ((startIndex < 0) || (startIndex >= this.Length))
				throw new ArgumentOutOfRangeException ("startIndex", "< 0 || > this.Length");
			if ((count < 0) || (count > this.Length))
				throw new ArgumentOutOfRangeException ("count", "< 0 || > this.Length");
			if (startIndex - count + 1 < 0)
				throw new ArgumentOutOfRangeException ("startIndex - count + 1 < 0");

			if (this.length == 0)
				return -1;

			return LastIndexOfAnyUnchecked (anyOf, startIndex, count);
		}

		unsafe int LastIndexOfAnyUnchecked (char [] anyOf, int startIndex, int count)
		{
			fixed (char* start = this, testStart = anyOf) {
				char* ptr = start + startIndex;
				char* ptrEnd = ptr - count;
				char* test;
				char* testEnd = testStart + anyOf.Length;

				while (ptr != ptrEnd) {
					test = testStart;
					while (test != testEnd) {
						if (*test == *ptr)
							return (int)(ptr - start);
						test++;
					}
					ptr--;
				}
				return -1;
			}
		}

		// Following methods are culture-insensitive
		public int LastIndexOf (char value)
		{
			if (this.length == 0)
				return -1;
			
			return LastIndexOfUnchecked (value, this.length - 1, this.length);
		}

		public int LastIndexOf (char value, int startIndex)
		{
			return LastIndexOf (value, startIndex, startIndex + 1);
		}

		public int LastIndexOf (char value, int startIndex, int count)
		{
			if (startIndex == 0 && this.length == 0)
				return -1;

			// >= for char (> for string)
			if ((startIndex < 0) || (startIndex >= this.Length))
				throw new ArgumentOutOfRangeException ("startIndex", "< 0 || >= this.Length");
			if ((count < 0) || (count > this.Length))
				throw new ArgumentOutOfRangeException ("count", "< 0 || > this.Length");
			if (startIndex - count + 1 < 0)
				throw new ArgumentOutOfRangeException ("startIndex - count + 1 < 0");

			return LastIndexOfUnchecked (value, startIndex, count);
		}

		unsafe int LastIndexOfUnchecked (char value, int startIndex, int count)
		{
			// It helps JIT compiler to optimize comparison
			int value_32 = (int)value;

			fixed (char* start = &start_char) {
				char* ptr = start + startIndex;
				char* end_ptr = ptr - (count >> 3 << 3);

				while (ptr != end_ptr) {
					if (*ptr == value_32)
						return (int)(ptr - start);
					if (ptr[-1] == value_32)
						return (int)(ptr - start) - 1;
					if (ptr[-2] == value_32)
						return (int)(ptr - start) - 2;
					if (ptr[-3] == value_32)
						return (int)(ptr - start) - 3;
					if (ptr[-4] == value_32)
						return (int)(ptr - start) - 4;
					if (ptr[-5] == value_32)
						return (int)(ptr - start) - 5;
					if (ptr[-6] == value_32)
						return (int)(ptr - start) - 6;
					if (ptr[-7] == value_32)
						return (int)(ptr - start) - 7;

					ptr -= 8;
				}

				end_ptr -= count & 0x07;
				while (ptr != end_ptr) {
					if (*ptr == value_32)
						return (int)(ptr - start);

					ptr--;
				}
				return -1;
			}
		}

		// Following methods are culture-sensitive
		public int LastIndexOf (String value)
		{
			if (this.length == 0)
				// This overload does additional checking
				return LastIndexOf (value, 0, 0);
			else
				return LastIndexOf (value, this.length - 1, this.length);
		}

		public int LastIndexOf (String value, int startIndex)
		{
			if (value == null)
				throw new ArgumentNullException ("value");
			int max = startIndex;
			if (max < this.Length)
				max++;
			return LastIndexOf (value, startIndex, max);
		}

		public int LastIndexOf (String value, int startIndex, int count)
		{
			if (value == null)
				throw new ArgumentNullException ("value");
			// -1 > startIndex > for string (0 > startIndex >= for char)
			if ((startIndex < -1) || (startIndex > this.Length))
				throw new ArgumentOutOfRangeException ("startIndex", "< 0 || > this.Length");
			if ((count < 0) || (count > this.Length))
				throw new ArgumentOutOfRangeException ("count", "< 0 || > this.Length");
			if (startIndex - count + 1 < 0)
				throw new ArgumentOutOfRangeException ("startIndex - count + 1 < 0");

			if (value.Length == 0)
				return startIndex;

			if (startIndex == 0 && this.length == 0)
				return -1;

			// This check is needed to match undocumented MS behaviour
			if (this.length == 0 && value.length > 0)
				return -1;

			if (count == 0)
				return -1;

			if (startIndex == this.Length)
				startIndex--;
			return CultureInfo.CurrentCulture.CompareInfo.LastIndexOf (this, value, startIndex, count);
		}

#if NET_2_0
		public bool Contains (String value)
		{
			return IndexOf (value) != -1;
		}

		public static bool IsNullOrEmpty (String value)
		{
			return (value == null) || (value.Length == 0);
		}

		public string Normalize ()
		{
			return Normalization.Normalize (this, 0);
		}

		public string Normalize (NormalizationForm form)
		{
			switch (form) {
			default:
				return Normalization.Normalize (this, 0);
			case NormalizationForm.FormD:
				return Normalization.Normalize (this, 1);
			case NormalizationForm.FormKC:
				return Normalization.Normalize (this, 2);
			case NormalizationForm.FormKD:
				return Normalization.Normalize (this, 3);
			}
		}

		public bool IsNormalized ()
		{
			return Normalization.IsNormalized (this, 0);
		}

		public bool IsNormalized (NormalizationForm form)
		{
			switch (form) {
			default:
				return Normalization.IsNormalized (this, 0);
			case NormalizationForm.FormD:
				return Normalization.IsNormalized (this, 1);
			case NormalizationForm.FormKC:
				return Normalization.IsNormalized (this, 2);
			case NormalizationForm.FormKD:
				return Normalization.IsNormalized (this, 3);
			}
		}

		public string Remove (int startIndex)
		{
			if (startIndex < 0)
				throw new ArgumentOutOfRangeException ("startIndex", "StartIndex can not be less than zero");
			if (startIndex >= this.length)
				throw new ArgumentOutOfRangeException ("startIndex", "StartIndex must be less than the length of the string");

			return Remove (startIndex, this.length - startIndex);
		}
#endif

		public String PadLeft (int totalWidth)
		{
			return PadLeft (totalWidth, ' ');
		}

		public unsafe String PadLeft (int totalWidth, char paddingChar)
		{
			//LAMESPEC: MSDN Doc says this is reversed for RtL languages, but this seems to be untrue

			if (totalWidth < 0)
				throw new ArgumentOutOfRangeException ("totalWidth", "< 0");

			if (totalWidth <= this.length)
				return this;

			String tmp = InternalAllocateStr (totalWidth);

			fixed (char* dest = tmp, src = this) {
				char* padPos = dest;
				char* padTo = dest + (totalWidth - length);
				while (padPos != padTo)
					*padPos++ = paddingChar;

				CharCopy (padTo, src, length);
			}
			return tmp;
		}

		public String PadRight (int totalWidth)
		{
			return PadRight (totalWidth, ' ');
		}

		public unsafe String PadRight (int totalWidth, char paddingChar)
		{
			//LAMESPEC: MSDN Doc says this is reversed for RtL languages, but this seems to be untrue

			if (totalWidth < 0)
				throw new ArgumentOutOfRangeException ("totalWidth", "< 0");

			if (totalWidth <= this.length)
				return this;

			String tmp = InternalAllocateStr (totalWidth);

			fixed (char* dest = tmp, src = this) {
				CharCopy (dest, src, length);

				char* padPos = dest + length;
				char* padTo = dest + totalWidth;
				while (padPos != padTo)
					*padPos++ = paddingChar;
			}
			return tmp;
		}

		public bool StartsWith (String value)
		{
			return CultureInfo.CurrentCulture.CompareInfo.IsPrefix (this, value, CompareOptions.None);
		}

#if NET_2_0
		[ComVisible (false)]
		public bool StartsWith (string value, StringComparison comparisonType)
		{
			switch (comparisonType) {
			case StringComparison.CurrentCulture:
				return CultureInfo.CurrentCulture.CompareInfo.IsPrefix (this, value, CompareOptions.None);
			case StringComparison.CurrentCultureIgnoreCase:
				return CultureInfo.CurrentCulture.CompareInfo.IsPrefix (this, value, CompareOptions.IgnoreCase);
			case StringComparison.InvariantCulture:
				return CultureInfo.InvariantCulture.CompareInfo.IsPrefix (this, value, CompareOptions.None);
			case StringComparison.InvariantCultureIgnoreCase:
				return CultureInfo.InvariantCulture.CompareInfo.IsPrefix (this, value, CompareOptions.IgnoreCase);
			case StringComparison.Ordinal:
				return CultureInfo.CurrentCulture.CompareInfo.IsPrefix (this, value, CompareOptions.Ordinal);
			case StringComparison.OrdinalIgnoreCase:
				return CultureInfo.CurrentCulture.CompareInfo.IsPrefix (this, value, CompareOptions.OrdinalIgnoreCase);
			default:
				string msg = Locale.GetText ("Invalid value '{0}' for StringComparison", comparisonType);
				throw new ArgumentException (msg, "comparisonType");
			}
		}

		[ComVisible (false)]
		public bool EndsWith (string value, StringComparison comparisonType)
		{
			switch (comparisonType) {
			case StringComparison.CurrentCulture:
				return CultureInfo.CurrentCulture.CompareInfo.IsSuffix (this, value, CompareOptions.None);
			case StringComparison.CurrentCultureIgnoreCase:
				return CultureInfo.CurrentCulture.CompareInfo.IsSuffix (this, value, CompareOptions.IgnoreCase);
			case StringComparison.InvariantCulture:
				return CultureInfo.InvariantCulture.CompareInfo.IsSuffix (this, value, CompareOptions.None);
			case StringComparison.InvariantCultureIgnoreCase:
				return CultureInfo.InvariantCulture.CompareInfo.IsSuffix (this, value, CompareOptions.IgnoreCase);
			case StringComparison.Ordinal:
				return CultureInfo.CurrentCulture.CompareInfo.IsSuffix (this, value, CompareOptions.Ordinal);
			case StringComparison.OrdinalIgnoreCase:
				return CultureInfo.CurrentCulture.CompareInfo.IsSuffix (this, value, CompareOptions.OrdinalIgnoreCase);
			default:
				string msg = Locale.GetText ("Invalid value '{0}' for StringComparison", comparisonType);
				throw new ArgumentException (msg, "comparisonType");
			}
		}

#endif

#if NET_2_0
		public
#else
		internal
#endif
		bool StartsWith (String value, bool ignoreCase, CultureInfo culture)
		{
			if (culture == null)
				culture = CultureInfo.CurrentCulture;
			
			return culture.CompareInfo.IsPrefix (this, value, ignoreCase ? CompareOptions.IgnoreCase : CompareOptions.None);
		}

		// Following method is culture-insensitive
		public unsafe String Replace (char oldChar, char newChar)
		{
			if (this.length == 0 || oldChar == newChar)
				return this;

			int start_pos = IndexOfUnchecked (oldChar, 0, this.length);
			if (start_pos == -1)
				return this;

			if (start_pos < 4)
				start_pos = 0;

			string tmp = InternalAllocateStr(length);
			fixed (char* dest = tmp, src = &start_char) {
				if (start_pos != 0)
					CharCopy(dest, src, start_pos);

				char* end_ptr = dest + length;
				char* dest_ptr = dest + start_pos;
				char* src_ptr = src + start_pos;

				while (dest_ptr != end_ptr) {
					if (*src_ptr == oldChar)
						*dest_ptr = newChar;
					else
						*dest_ptr = *src_ptr;

					++src_ptr;
					++dest_ptr;
				}
			}
			return tmp;
		}

		// According to docs the following method is culture-insensitive using ordinal search
		public String Replace (String oldValue, String newValue)
		{
			if (oldValue == null)
				throw new ArgumentNullException ("oldValue");

			if (oldValue.Length == 0)
				throw new ArgumentException ("oldValue is the empty string.");

			if (this.Length == 0)
				return this;
			
			if (newValue == null)
				newValue = String.Empty;

			return ReplaceUnchecked (oldValue, newValue);
		}

		private unsafe String ReplaceUnchecked (String oldValue, String newValue)
		{
			if (oldValue.length > length)
				return this;
			if (oldValue.length == 1 && newValue.length == 1) {
				return Replace (oldValue[0], newValue[0]);
				// ENHANCE: It would be possible to special case oldValue.length == newValue.length
				// because the length of the target would be this.length
			}

			const int maxValue = 200; // Allocate 800 byte maximum
			int* dat = stackalloc int[maxValue];
			fixed (char* source = this, replace = newValue) {
				int i = 0, count = 0;
				while (i < length) {
					int found = IndexOfOrdinalUnchecked (oldValue, i, length - i);
					if (found < 0)
						break;
					else {
						if (count <= maxValue)
							dat[count++] = found;
						else 
							return ReplaceFallback (oldValue, newValue);
					}
					i = found + oldValue.Length;
				}
				int nlen = length + (newValue.length - oldValue.length) * count;
				String tmp = InternalAllocateStr (nlen);

				int curPos = 0, lastReadPos = 0;
				fixed (char* dest = tmp) {
					for (int j = 0; j < count; j++) {
						int precopy = dat[j] - lastReadPos;
						CharCopy (dest + curPos, source + lastReadPos, precopy);
						curPos += precopy;
						lastReadPos = dat[j] + oldValue.length;
						CharCopy (dest + curPos, replace, newValue.length);
						curPos += newValue.length;
					}
					CharCopy (dest + curPos, source + lastReadPos, length - lastReadPos);
				}
				return tmp;
			}
		}

		private String ReplaceFallback (String oldValue, String newValue)
		{
			StringBuilder sb = new StringBuilder ();
			for (int i = 0; i < length;) {
				int found = IndexOfOrdinalUnchecked (oldValue, i, length - i);
				if (found < 0) {
					sb.Append (SubstringUnchecked (i, length - i));
					break;
				}
				sb.Append (SubstringUnchecked (i, found - i));
				sb.Append (newValue);
				i = found + oldValue.Length;
			}
			return sb.ToString ();

		}

		public unsafe String Remove (int startIndex, int count)
		{
			if (startIndex < 0)
				throw new ArgumentOutOfRangeException ("startIndex", "< 0");
			if (count < 0)
				throw new ArgumentOutOfRangeException ("count", "< 0");
			if (startIndex > this.length - count)
				throw new ArgumentOutOfRangeException ("startIndex + count > this.length");

			String tmp = InternalAllocateStr (this.length - count);

			fixed (char *dest = tmp, src = this) {
				char *dst = dest;
				CharCopy (dst, src, startIndex);
				int skip = startIndex + count;
				dst += startIndex;
				CharCopy (dst, src + skip, length - skip);
			}
			return tmp;
		}

		public String ToLower ()
		{
			return ToLower (CultureInfo.CurrentCulture);
		}

		public String ToLower (CultureInfo culture)
		{
			if (culture == null)
				throw new ArgumentNullException ("culture");

			if (culture.LCID == 0x007F) // Invariant
				return ToLowerInvariant ();

			return culture.TextInfo.ToLower (this);
		}

#if NET_2_0
		public unsafe String ToLowerInvariant ()
#else
		internal unsafe String ToLowerInvariant ()
#endif
		{
			string tmp = InternalAllocateStr (length);
			fixed (char* source = &start_char, dest = tmp) {

				char* destPtr = (char*)dest;
				char* sourcePtr = (char*)source;

				for (int n = 0; n < length; n++) {
					*destPtr = Char.ToLowerInvariant (*sourcePtr);
					sourcePtr++;
					destPtr++;
				}
			}
			return tmp;
		}

		public String ToUpper ()
		{
			return ToUpper (CultureInfo.CurrentCulture);
		}

		public String ToUpper (CultureInfo culture)
		{
			if (culture == null)
				throw new ArgumentNullException ("culture");

			if (culture.LCID == 0x007F) // Invariant
				return ToUpperInvariant ();

			return culture.TextInfo.ToUpper (this);
		}

#if NET_2_0
		public unsafe String ToUpperInvariant ()
#else
		internal unsafe String ToUpperInvariant ()
#endif
		{
			string tmp = InternalAllocateStr (length);
			fixed (char* source = &start_char, dest = tmp) {

				char* destPtr = (char*)dest;
				char* sourcePtr = (char*)source;

				for (int n = 0; n < length; n++) {
					*destPtr = Char.ToUpperInvariant (*sourcePtr);
					sourcePtr++;
					destPtr++;
				}
			}
			return tmp;
		}

		public override String ToString ()
		{
			return this;
		}

		public String ToString (IFormatProvider provider)
		{
			return this;
		}

		public static String Format (String format, Object arg0)
		{
			return Format (null, format, new Object[] {arg0});
		}

		public static String Format (String format, Object arg0, Object arg1)
		{
			return Format (null, format, new Object[] {arg0, arg1});
		}

		public static String Format (String format, Object arg0, Object arg1, Object arg2)
		{
			return Format (null, format, new Object[] {arg0, arg1, arg2});
		}

		public static string Format (string format, params object[] args)
		{
			return Format (null, format, args);
		}
	
		public static string Format (IFormatProvider provider, string format, params object[] args)
		{
			StringBuilder b = new StringBuilder ();
			FormatHelper (b, provider, format, args);
			return b.ToString ();
		}
		
		internal static void FormatHelper (StringBuilder result, IFormatProvider provider, string format, params object[] args)
		{
			if (format == null || args == null)
				throw new ArgumentNullException ();

			int ptr = 0;
			int start = ptr;
			while (ptr < format.length) {
				char c = format[ptr ++];

				if (c == '{') {
					result.Append (format, start, ptr - start - 1);

					// check for escaped open bracket

					if (format[ptr] == '{') {
						start = ptr ++;
						continue;
					}

					// parse specifier
				
					int n, width;
					bool left_align;
					string arg_format;

					ParseFormatSpecifier (format, ref ptr, out n, out width, out left_align, out arg_format);
					if (n >= args.Length)
						throw new FormatException ("Index (zero based) must be greater than or equal to zero and less than the size of the argument list.");

					// format argument

					object arg = args[n];

					string str;
					ICustomFormatter formatter = null;
					if (provider != null)
						formatter = provider.GetFormat (typeof (ICustomFormatter))
							as ICustomFormatter;
					if (arg == null)
						str = String.Empty;
					else if (formatter != null)
						str = formatter.Format (arg_format, arg, provider);
					else if (arg is IFormattable)
						str = ((IFormattable)arg).ToString (arg_format, provider);
					else
						str = arg.ToString ();

					// pad formatted string and append to result

					if (width > str.length) {
						const char padchar = ' ';
						int padlen = width - str.length;

						if (left_align) {
							result.Append (str);
							result.Append (padchar, padlen);
						}
						else {
							result.Append (padchar, padlen);
							result.Append (str);
						}
					}
					else
						result.Append (str);

					start = ptr;
				}
				else if (c == '}' && ptr < format.length && format[ptr] == '}') {
					result.Append (format, start, ptr - start - 1);
					start = ptr ++;
				}
				else if (c == '}') {
					throw new FormatException ("Input string was not in a correct format.");
				}
			}

			if (start < format.length)
				result.Append (format, start, format.Length - start);
		}

		public unsafe static String Copy (String str)
		{
			if (str == null)
				throw new ArgumentNullException ("str");

			int length = str.length;

			String tmp = InternalAllocateStr (length);
			if (length != 0) {
				fixed (char *dest = tmp, src = str) {
					CharCopy (dest, src, length);
				}
			}
			return tmp;
		}

		public static String Concat (Object obj)
		{
			if (obj == null)
				return String.Empty;

			return obj.ToString ();
		}

		public unsafe static String Concat (Object obj1, Object obj2)
		{
			string s1, s2;

			s1 = (obj1 != null) ? obj1.ToString () : null;
			s2 = (obj2 != null) ? obj2.ToString () : null;
			
			if (s1 == null) {
				if (s2 == null)
					return String.Empty;
				else
					return s2;
			} else if (s2 == null)
				return s1;

			String tmp = InternalAllocateStr (s1.Length + s2.Length);
			if (s1.Length != 0) {
				fixed (char *dest = tmp, src = s1) {
					CharCopy (dest, src, s1.length);
				}
			}
			if (s2.Length != 0) {
				fixed (char *dest = tmp, src = s2) {
					CharCopy (dest + s1.Length, src, s2.length);
				}
			}

			return tmp;
		}

		public static String Concat (Object obj1, Object obj2, Object obj3)
		{
			string s1, s2, s3;
			if (obj1 == null)
				s1 = String.Empty;
			else
				s1 = obj1.ToString ();

			if (obj2 == null)
				s2 = String.Empty;
			else
				s2 = obj2.ToString ();

			if (obj3 == null)
				s3 = String.Empty;
			else
				s3 = obj3.ToString ();

			return Concat (s1, s2, s3);
		}

#if ! BOOTSTRAP_WITH_OLDLIB
		[CLSCompliant(false)]
		public static String Concat (Object obj1, Object obj2, Object obj3,
					     Object obj4, __arglist)
		{
			string s1, s2, s3, s4;

			if (obj1 == null)
				s1 = String.Empty;
			else
				s1 = obj1.ToString ();

			if (obj2 == null)
				s2 = String.Empty;
			else
				s2 = obj2.ToString ();

			if (obj3 == null)
				s3 = String.Empty;
			else
				s3 = obj3.ToString ();

			ArgIterator iter = new ArgIterator (__arglist);
			int argCount = iter.GetRemainingCount();

			StringBuilder sb = new StringBuilder ();
			if (obj4 != null)
				sb.Append (obj4.ToString ());

			for (int i = 0; i < argCount; i++) {
				TypedReference typedRef = iter.GetNextArg ();
				sb.Append (TypedReference.ToObject (typedRef));
			}

			s4 = sb.ToString ();

			return Concat (s1, s2, s3, s4);			
		}
#endif

		public unsafe static String Concat (String s1, String s2)
		{
			if (s1 == null || s1.Length == 0) {
				if (s2 == null || s2.Length == 0)
					return String.Empty;
				return s2;
			}

			if (s2 == null || s2.Length == 0)
				return s1; 

			String tmp = InternalAllocateStr (s1.length + s2.length);

			fixed (char *dest = tmp, src = s1)
				CharCopy (dest, src, s1.length);
			fixed (char *dest = tmp, src = s2)
				CharCopy (dest + s1.Length, src, s2.length);

			return tmp;
		}

		public unsafe static String Concat (String s1, String s2, String s3)
		{
			if (s1 == null || s1.Length == 0){
				if (s2 == null || s2.Length == 0){
					if (s3 == null || s3.Length == 0)
						return String.Empty;
					return s3;
				} else {
					if (s3 == null || s3.Length == 0)
						return s2;
				}
				s1 = String.Empty;
			} else {
				if (s2 == null || s2.Length == 0){
					if (s3 == null || s3.Length == 0)
						return s1;
					else
						s2 = String.Empty;
				} else {
					if (s3 == null || s3.Length == 0)
						s3 = String.Empty;
				}
			}

			String tmp = InternalAllocateStr (s1.length + s2.length + s3.length);

			if (s1.Length != 0) {
				fixed (char *dest = tmp, src = s1) {
					CharCopy (dest, src, s1.length);
				}
			}
			if (s2.Length != 0) {
				fixed (char *dest = tmp, src = s2) {
					CharCopy (dest + s1.Length, src, s2.length);
				}
			}
			if (s3.Length != 0) {
				fixed (char *dest = tmp, src = s3) {
					CharCopy (dest + s1.Length + s2.Length, src, s3.length);
				}
			}

			return tmp;
		}

		public unsafe static String Concat (String s1, String s2, String s3, String s4)
		{
			if (s1 == null && s2 == null && s3 == null && s4 == null)
				return String.Empty;

			if (s1 == null)
				s1 = String.Empty;
			if (s2 == null)
				s2 = String.Empty;
			if (s3 == null)
				s3 = String.Empty;
			if (s4 == null)
				s4 = String.Empty;

			String tmp = InternalAllocateStr (s1.length + s2.length + s3.length + s4.length);

			if (s1.Length != 0) {
				fixed (char *dest = tmp, src = s1) {
					CharCopy (dest, src, s1.length);
				}
			}
			if (s2.Length != 0) {
				fixed (char *dest = tmp, src = s2) {
					CharCopy (dest + s1.Length, src, s2.length);
				}
			}
			if (s3.Length != 0) {
				fixed (char *dest = tmp, src = s3) {
					CharCopy (dest + s1.Length + s2.Length, src, s3.length);
				}
			}
			if (s4.Length != 0) {
				fixed (char *dest = tmp, src = s4) {
					CharCopy (dest + s1.Length + s2.Length + s3.Length, src, s4.length);
				}
			}

			return tmp;
		}

		public static String Concat (params Object[] args)
		{
			if (args == null)
				throw new ArgumentNullException ("args");

			int argLen = args.Length;
			if (argLen == 0)
				return String.Empty;

			string [] strings = new string [argLen];
			int len = 0;
			for (int i = 0; i < argLen; i++) {
				if (args[i] != null) {
					strings[i] = args[i].ToString ();
					len += strings[i].length;
				}
			}
			if (len == 0)
				return String.Empty;

			return ConcatInternal (strings, len);
		}

		public static String Concat (params String[] values)
		{
			if (values == null)
				throw new ArgumentNullException ("values");

			int len = 0;
			for (int i = 0; i < values.Length; i++) {
				String s = values[i];
				if (s != null)
					len += s.length;
			}
			if (len == 0)
				return String.Empty;

			return ConcatInternal (values, len);
		}

		private static unsafe String ConcatInternal (String[] values, int length)
		{
			String tmp = InternalAllocateStr (length);

			fixed (char* dest = tmp) {
				int pos = 0;
				for (int i = 0; i < values.Length; i++) {
					String source = values[i];
					if (source != null) {
						fixed (char* src = source) {
							CharCopy (dest + pos, src, source.length);
						}
						pos += source.Length;
					}
				}
			}
			return tmp;
		}

		public unsafe String Insert (int startIndex, String value)
		{
			if (value == null)
				throw new ArgumentNullException ("value");

			if (startIndex < 0 || startIndex > this.length)
				throw new ArgumentOutOfRangeException ();

			if (value.Length == 0)
				return this;
			if (this.Length == 0)
				return value;
			String tmp = InternalAllocateStr (this.length + value.length);

			fixed (char *dest = tmp, src = this, val = value) {
				char *dst = dest;
				CharCopy (dst, src, startIndex);
				dst += startIndex;
				CharCopy (dst, val, value.length);
				dst += value.length;
				CharCopy (dst, src + startIndex, length - startIndex);
			}
			return tmp;
		}

		public static string Intern (string str)
		{
			if (str == null)
				throw new ArgumentNullException ("str");

			return InternalIntern (str);
		}

		public static string IsInterned (string str)
		{
			if (str == null)
				throw new ArgumentNullException ("str");

			return InternalIsInterned (str);
		}
	
		public static string Join (string separator, string [] value)
		{
			if (value == null)
				throw new ArgumentNullException ("value");
			if (separator == null)
				separator = String.Empty;

			return JoinUnchecked (separator, value, 0, value.Length);
		}

		public static string Join (string separator, string[] value, int startIndex, int count)
		{
			if (value == null)
				throw new ArgumentNullException ("value");
			if (startIndex < 0)
				throw new ArgumentOutOfRangeException ("startIndex", "< 0");
			if (count < 0)
				throw new ArgumentOutOfRangeException ("count", "< 0");
			if (startIndex > value.Length - count)
				throw new ArgumentOutOfRangeException ("startIndex", "startIndex + count > value.length");

			if (startIndex == value.Length)
				return String.Empty;
			if (separator == null)
				separator = String.Empty;

			return JoinUnchecked (separator, value, startIndex, count);
		}

		private static unsafe string JoinUnchecked (string separator, string[] value, int startIndex, int count)
		{
			// Unchecked parameters
			// startIndex, count must be >= 0; startIndex + count must be <= value.length
			// separator and value must not be null

			int length = 0;
			int maxIndex = startIndex + count;
			// Precount the number of characters that the resulting string will have
			for (int i = startIndex; i < maxIndex; i++) {
				String s = value[i];
				if (s != null)
					length += s.length;
			}
			length += separator.length * (count - 1);
			if (length <= 0)
				return String.Empty;

			String tmp = InternalAllocateStr (length);

			maxIndex--;
			fixed (char* dest = tmp, sepsrc = separator) {
				// Copy each string from value except the last one and add a separator for each
				int pos = 0;
				for (int i = startIndex; i < maxIndex; i++) {
					String source = value[i];
					if (source != null) {
						if (source.Length > 0) {
							fixed (char* src = source)
								CharCopy (dest + pos, src, source.Length);
							pos += source.Length;
						}
					}
					if (separator.Length > 0) {
						CharCopy (dest + pos, sepsrc, separator.Length);
						pos += separator.Length;
					}
				}
				// Append last string that does not get an additional separator
				String sourceLast = value[maxIndex];
				if (sourceLast != null) {
					if (sourceLast.Length > 0) {
						fixed (char* src = sourceLast)
							CharCopy (dest + pos, src, sourceLast.Length);
					}
				}
			}
			return tmp;
		}

		bool IConvertible.ToBoolean (IFormatProvider provider)
		{
			return Convert.ToBoolean (this, provider);
		}

		byte IConvertible.ToByte (IFormatProvider provider)
		{
			return Convert.ToByte (this, provider);
		}

		char IConvertible.ToChar (IFormatProvider provider)
		{
			return Convert.ToChar (this, provider);
		}

		DateTime IConvertible.ToDateTime (IFormatProvider provider)
		{
			return Convert.ToDateTime (this, provider);
		}

		decimal IConvertible.ToDecimal (IFormatProvider provider)
		{
			return Convert.ToDecimal (this, provider);
		}

		double IConvertible.ToDouble (IFormatProvider provider)
		{
			return Convert.ToDouble (this, provider);
		}

		short IConvertible.ToInt16 (IFormatProvider provider)
		{
			return Convert.ToInt16 (this, provider);
		}

		int IConvertible.ToInt32 (IFormatProvider provider)
		{
			return Convert.ToInt32 (this, provider);
		}

		long IConvertible.ToInt64 (IFormatProvider provider)
		{
			return Convert.ToInt64 (this, provider);
		}
	
		sbyte IConvertible.ToSByte (IFormatProvider provider)
		{
			return Convert.ToSByte (this, provider);
		}

		float IConvertible.ToSingle (IFormatProvider provider)
		{
			return Convert.ToSingle (this, provider);
		}

		object IConvertible.ToType (Type conversionType, IFormatProvider provider)
		{
			return Convert.ToType (this, conversionType,  provider);
		}

		ushort IConvertible.ToUInt16 (IFormatProvider provider)
		{
			return Convert.ToUInt16 (this, provider);
		}

		uint IConvertible.ToUInt32 (IFormatProvider provider)
		{
			return Convert.ToUInt32 (this, provider);
		}

		ulong IConvertible.ToUInt64 (IFormatProvider provider)
		{
			return Convert.ToUInt64 (this, provider);
		}

		public int Length {
			get {
				return length;
			}
		}

		public CharEnumerator GetEnumerator ()
		{
			return new CharEnumerator (this);
		}

#if NET_2_0
		IEnumerator<char> IEnumerable<char>.GetEnumerator ()
		{
			return new CharEnumerator (this);
		}
#endif

		IEnumerator IEnumerable.GetEnumerator ()
		{
			return new CharEnumerator (this);
		}

		private static void ParseFormatSpecifier (string str, ref int ptr, out int n, out int width,
		                                          out bool left_align, out string format)
		{
			// parses format specifier of form:
			//   N,[\ +[-]M][:F]}
			//
			// where:

			try {
				// N = argument number (non-negative integer)

				n = ParseDecimal (str, ref ptr);
				if (n < 0)
					throw new FormatException ("Input string was not in a correct format.");

				// M = width (non-negative integer)

				if (str[ptr] == ',') {
					// White space between ',' and number or sign.
					++ptr;
					while (Char.IsWhiteSpace (str [ptr]))
						++ptr;
					int start = ptr;

					format = str.Substring (start, ptr - start);

					left_align = (str [ptr] == '-');
					if (left_align)
						++ ptr;

					width = ParseDecimal (str, ref ptr);
					if (width < 0)
						throw new FormatException ("Input string was not in a correct format.");
				}
				else {
					width = 0;
					left_align = false;
					format = String.Empty;
				}

				// F = argument format (string)

				if (str[ptr] == ':') {
					int start = ++ ptr;
					while (str[ptr] != '}')
						++ ptr;

					format += str.Substring (start, ptr - start);
				}
				else
					format = null;

				if (str[ptr ++] != '}')
					throw new FormatException ("Input string was not in a correct format.");
			}
			catch (IndexOutOfRangeException) {
				throw new FormatException ("Input string was not in a correct format.");
			}
		}

		private static int ParseDecimal (string str, ref int ptr)
		{
			int p = ptr;
			int n = 0;
			while (true) {
				char c = str[p];
				if (c < '0' || '9' < c)
					break;

				n = n * 10 + c - '0';
				++ p;
			}

			if (p == ptr)
				return -1;

			ptr = p;
			return n;
		}

		internal unsafe void InternalSetChar (int idx, char val)
		{
			if ((uint) idx >= (uint) Length)
				throw new ArgumentOutOfRangeException ("idx");

			fixed (char * pStr = &start_char) 
			{
				pStr [idx] = val;
			}
		}

		internal unsafe void InternalSetLength (int newLength)
		{
			if (newLength > length)
				throw new ArgumentOutOfRangeException ("newLength", "newLength as to be <= length");

			// zero terminate, we can pass string objects directly via pinvoke
			// we also zero the rest of the string, since the new GC needs to be
			// able to handle the changing size (it will skip the 0 bytes).
			fixed (char * pStr = &start_char) {
				char *p = pStr + newLength;
				char *end = pStr + length;
				while (p < end) {
					p [0] = '\0';
					p++;
				}
			}
			length = newLength;
		}

#if NET_2_0
		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, Cer.MayFail)]
#endif
		// When modifying it, GetCaseInsensitiveHashCode() should be modified as well.
		public unsafe override int GetHashCode ()
		{
			fixed (char * c = this) {
				char * cc = c;
				char * end = cc + length - 1;
				int h = 0;
				for (;cc < end; cc += 2) {
					h = (h << 5) - h + *cc;
					h = (h << 5) - h + cc [1];
				}
				++end;
				if (cc < end)
					h = (h << 5) - h + *cc;
				return h;
			}
		}

		internal unsafe int GetCaseInsensitiveHashCode ()
		{
			fixed (char * c = this) {
				char * cc = c;
				char * end = cc + length - 1;
				int h = 0;
				for (;cc < end; cc += 2) {
					h = (h << 5) - h + Char.ToUpperInvariant (*cc);
					h = (h << 5) - h + Char.ToUpperInvariant (cc [1]);
				}
				++end;
				if (cc < end)
					h = (h << 5) - h + Char.ToUpperInvariant (*cc);
				return h;
			}
		}

		// Certain constructors are redirected to CreateString methods with
		// matching argument list. The this pointer should not be used.

		private unsafe String CreateString (sbyte* value)
		{
			if (value == null)
				return String.Empty;

			byte* bytes = (byte*) value;
			int length = 0;

			try {
				while (bytes++ [0] != 0)
					length++;
			} catch (NullReferenceException) {
				throw new ArgumentOutOfRangeException ("value", "Value does not refer to a valid string.");
#if NET_2_0
			} catch (AccessViolationException) {
				throw new ArgumentOutOfRangeException ("value", "Value does not refer to a valid string.");
#endif
			}

			return CreateString (value, 0, length, null);
		}

		private unsafe String CreateString (sbyte* value, int startIndex, int length)
		{
			return CreateString (value, startIndex, length, null);
		}

		private unsafe String CreateString (sbyte* value, int startIndex, int length, Encoding enc)
		{
			if (length < 0)
				throw new ArgumentOutOfRangeException ("length", "Non-negative number required.");
			if (startIndex < 0)
				throw new ArgumentOutOfRangeException ("startIndex", "Non-negative number required.");
			if (value + startIndex < value)
				throw new ArgumentOutOfRangeException ("startIndex", "Value, startIndex and length do not refer to a valid string.");

			bool isDefaultEncoding;

			if (isDefaultEncoding = (enc == null)) {
#if NET_2_0
				if (value == null)
					throw new ArgumentNullException ("value");
				if (length == 0)
#else
				if (value == null || length == 0)
#endif
					return String.Empty;

				enc = Encoding.Default;
			}

			byte [] bytes = new byte [length];

			if (length != 0)
				fixed (byte* bytePtr = bytes)
					try {
						memcpy (bytePtr, (byte*) (value + startIndex), length);
					} catch (NullReferenceException) {
#if !NET_2_0
						if (!isDefaultEncoding)
							throw;
#endif

						throw new ArgumentOutOfRangeException ("value", "Value, startIndex and length do not refer to a valid string.");
#if NET_2_0
					} catch (AccessViolationException) {
						if (!isDefaultEncoding)
							throw;

						throw new ArgumentOutOfRangeException ("value", "Value, startIndex and length do not refer to a valid string.");
#endif
					}

			// GetString () is called even when length == 0
			return enc.GetString (bytes);
		}

		unsafe string CreateString (char *value)
		{
			if (value == null)
				return string.Empty;
			char *p = value;
			int i = 0;
			while (*p != 0) {
				++i;
				++p;
			}
			string result = InternalAllocateStr (i);

			if (i != 0) {
				fixed (char *dest = result) {
					CharCopy (dest, value, i);
				}
			}
			return result;
		}

		unsafe string CreateString (char *value, int startIndex, int length)
		{
			if (length == 0)
				return string.Empty;
			if (value == null)
				throw new ArgumentNullException ("value");
			if (startIndex < 0)
				throw new ArgumentOutOfRangeException ("startIndex");
			if (length < 0)
				throw new ArgumentOutOfRangeException ("length");

			string result = InternalAllocateStr (length);

			fixed (char *dest = result) {
				CharCopy (dest, value + startIndex, length);
			}
			return result;
		}

		unsafe string CreateString (char [] val, int startIndex, int length)
		{
			if (val == null)
				throw new ArgumentNullException ("val");
			if (startIndex < 0)
				throw new ArgumentOutOfRangeException ("startIndex");
			if (length < 0)
				throw new ArgumentOutOfRangeException ("length");
			if (startIndex > val.Length - length)
				throw new ArgumentOutOfRangeException ("Out of range");
			if (length == 0)
				return string.Empty;

			string result = InternalAllocateStr (length);

			fixed (char *dest = result, src = val) {
				CharCopy (dest, src + startIndex, length);
			}
			return result;
		}

		unsafe string CreateString (char [] val)
		{
			if (val == null)
				return string.Empty;
			if (val.Length == 0)
				return string.Empty;
			string result = InternalAllocateStr (val.Length);

			fixed (char *dest = result, src = val) {
				CharCopy (dest, src, val.Length);
			}
			return result;
		}

		unsafe string CreateString (char c, int count)
		{
			if (count < 0)
				throw new ArgumentOutOfRangeException ("count");
			if (count == 0)
				return string.Empty;
			string result = InternalAllocateStr (count);
			fixed (char *dest = result) {
				char *p = dest;
				char *end = p + count;
				while (p < end) {
					*p = c;
					p++;
				}
			}
			return result;
		}

		/* helpers used by the runtime as well as above or eslewhere in corlib */
		internal static unsafe void memset (byte *dest, int val, int len)
		{
			if (len < 8) {
				while (len != 0) {
					*dest = (byte)val;
					++dest;
					--len;
				}
				return;
			}
			if (val != 0) {
				val = val | (val << 8);
				val = val | (val << 16);
			}
			// align to 4
			int rest = (int)dest & 3;
			if (rest != 0) {
				rest = 4 - rest;
				len -= rest;
				do {
					*dest = (byte)val;
					++dest;
					--rest;
				} while (rest != 0);
			}
			while (len >= 16) {
				((int*)dest) [0] = val;
				((int*)dest) [1] = val;
				((int*)dest) [2] = val;
				((int*)dest) [3] = val;
				dest += 16;
				len -= 16;
			}
			while (len >= 4) {
				((int*)dest) [0] = val;
				dest += 4;
				len -= 4;
			}
			// tail bytes
			while (len > 0) {
				*dest = (byte)val;
				dest++;
				len--;
			}
		}

		static unsafe void memcpy4 (byte *dest, byte *src, int size) {
			/*while (size >= 32) {
				// using long is better than int and slower than double
				// FIXME: enable this only on correct alignment or on platforms
				// that can tolerate unaligned reads/writes of doubles
				((double*)dest) [0] = ((double*)src) [0];
				((double*)dest) [1] = ((double*)src) [1];
				((double*)dest) [2] = ((double*)src) [2];
				((double*)dest) [3] = ((double*)src) [3];
				dest += 32;
				src += 32;
				size -= 32;
			}*/
			while (size >= 16) {
				((int*)dest) [0] = ((int*)src) [0];
				((int*)dest) [1] = ((int*)src) [1];
				((int*)dest) [2] = ((int*)src) [2];
				((int*)dest) [3] = ((int*)src) [3];
				dest += 16;
				src += 16;
				size -= 16;
			}
			while (size >= 4) {
				((int*)dest) [0] = ((int*)src) [0];
				dest += 4;
				src += 4;
				size -= 4;
			}
			while (size > 0) {
				((byte*)dest) [0] = ((byte*)src) [0];
				dest += 1;
				src += 1;
				--size;
			}
		}
		static unsafe void memcpy2 (byte *dest, byte *src, int size) {
			while (size >= 8) {
				((short*)dest) [0] = ((short*)src) [0];
				((short*)dest) [1] = ((short*)src) [1];
				((short*)dest) [2] = ((short*)src) [2];
				((short*)dest) [3] = ((short*)src) [3];
				dest += 8;
				src += 8;
				size -= 8;
			}
			while (size >= 2) {
				((short*)dest) [0] = ((short*)src) [0];
				dest += 2;
				src += 2;
				size -= 2;
			}
			if (size > 0)
				((byte*)dest) [0] = ((byte*)src) [0];
		}
		static unsafe void memcpy1 (byte *dest, byte *src, int size) {
			while (size >= 8) {
				((byte*)dest) [0] = ((byte*)src) [0];
				((byte*)dest) [1] = ((byte*)src) [1];
				((byte*)dest) [2] = ((byte*)src) [2];
				((byte*)dest) [3] = ((byte*)src) [3];
				((byte*)dest) [4] = ((byte*)src) [4];
				((byte*)dest) [5] = ((byte*)src) [5];
				((byte*)dest) [6] = ((byte*)src) [6];
				((byte*)dest) [7] = ((byte*)src) [7];
				dest += 8;
				src += 8;
				size -= 8;
			}
			while (size >= 2) {
				((byte*)dest) [0] = ((byte*)src) [0];
				((byte*)dest) [1] = ((byte*)src) [1];
				dest += 2;
				src += 2;
				size -= 2;
			}
			if (size > 0)
				((byte*)dest) [0] = ((byte*)src) [0];
		}

		internal static unsafe void memcpy (byte *dest, byte *src, int size) {
			// FIXME: if pointers are not aligned, try to align them
			// so a faster routine can be used. Handle the case where
			// the pointers can't be reduced to have the same alignment
			// (just ignore the issue on x86?)
			if ((((int)dest | (int)src) & 3) != 0) {
				if (((int)dest & 1) != 0 && ((int)src & 1) != 0 && size >= 1) {
					dest [0] = src [0];
					++dest;
					++src;
					--size;
				}
				if (((int)dest & 2) != 0 && ((int)src & 2) != 0 && size >= 2) {
					((short*)dest) [0] = ((short*)src) [0];
					dest += 2;
					src += 2;
					size -= 2;
				}
				if ((((int)dest | (int)src) & 1) != 0) {
					memcpy1 (dest, src, size);
					return;
				}
				if ((((int)dest | (int)src) & 2) != 0) {
					memcpy2 (dest, src, size);
					return;
				}
			}
			memcpy4 (dest, src, size);
		}

		internal static unsafe void CharCopy (char *dest, char *src, int count) {
			// Same rules as for memcpy, but with the premise that 
			// chars can only be aligned to even addresses if their
			// enclosing types are correctly aligned
			if ((((int)(byte*)dest | (int)(byte*)src) & 3) != 0) {
				if (((int)(byte*)dest & 2) != 0 && ((int)(byte*)src & 2) != 0 && count > 0) {
					((short*)dest) [0] = ((short*)src) [0];
					dest++;
					src++;
					count--;
				}
				if ((((int)(byte*)dest | (int)(byte*)src) & 2) != 0) {
					memcpy2 ((byte*)dest, (byte*)src, count * 2);
					return;
				}
			}
			memcpy4 ((byte*)dest, (byte*)src, count * 2);
		}

		internal static unsafe void CharCopyReverse (char *dest, char *src, int count)
		{
			dest += count;
			src += count;
			for (int i = count; i > 0; i--) {
				dest--;
				src--;
				*dest = *src;
			}	
		}

		internal static unsafe void CharCopy (String target, int targetIndex, String source, int sourceIndex, int count)
		{
			fixed (char* dest = target, src = source)
				CharCopy (dest + targetIndex, src + sourceIndex, count);
		}

		internal static unsafe void CharCopy (String target, int targetIndex, Char[] source, int sourceIndex, int count)
		{
			fixed (char* dest = target, src = source)
				CharCopy (dest + targetIndex, src + sourceIndex, count);
		}

		// Use this method if you cannot block copy from left to right (e.g. because you are coping within the same string)
		internal static unsafe void CharCopyReverse (String target, int targetIndex, String source, int sourceIndex, int count)
		{
			fixed (char* dest = target, src = source)
				CharCopyReverse (dest + targetIndex, src + sourceIndex, count);
		}

		[CLSCompliant (false), MethodImplAttribute (MethodImplOptions.InternalCall)]
		unsafe public extern String (char *value);

		[CLSCompliant (false), MethodImplAttribute (MethodImplOptions.InternalCall)]
		unsafe public extern String (char *value, int startIndex, int length);

		[CLSCompliant (false), MethodImplAttribute (MethodImplOptions.InternalCall)]
		unsafe public extern String (sbyte *value);

		[CLSCompliant (false), MethodImplAttribute (MethodImplOptions.InternalCall)]
		unsafe public extern String (sbyte *value, int startIndex, int length);

		[CLSCompliant (false), MethodImplAttribute (MethodImplOptions.InternalCall)]
		unsafe public extern String (sbyte *value, int startIndex, int length, Encoding enc);

		[MethodImplAttribute (MethodImplOptions.InternalCall)]
		public extern String (char [] val, int startIndex, int length);

		[MethodImplAttribute (MethodImplOptions.InternalCall)]
		public extern String (char [] val);

		[MethodImplAttribute (MethodImplOptions.InternalCall)]
		public extern String (char c, int count);

		[MethodImplAttribute (MethodImplOptions.InternalCall)]
		internal extern static String InternalAllocateStr (int length);

		[MethodImplAttribute (MethodImplOptions.InternalCall)]
		private extern static string InternalIntern (string str);

		[MethodImplAttribute (MethodImplOptions.InternalCall)]
		private extern static string InternalIsInterned (string str);
	}
}
