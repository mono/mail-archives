//
// Locale.cs
//
// Author:
//   Miguel de Icaza (miguel@ximian.com)
//   Andreas Nahr (ClassDevelopment@A-SoftTech.com)
//   Kornél Pál <http://www.kornelpal.hu/>
//
// (C) 2001 - 2003 Ximian, Inc (http://www.ximian.com)
// Copyright (C) 2005 Kornél Pál
//

//
// Copyright (C) 2004 Novell, Inc (http://www.novell.com)
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

using System;
using System.Globalization;
using System.Reflection;
using System.Resources;

internal sealed class Locale
{
	// gettext () style resource manager
	private sealed class GetTextResourceManager : ResourceManager
	{
		// gettext () style resource set for netural culture
		// Only GetString and GetObject methods are implemented
		private sealed class GetTextResourceSet : ResourceSet
		{
			private readonly ResourceSet baseResourceSet;

			internal GetTextResourceSet (ResourceSet baseResourceSet) : base ()
			{
				this.baseResourceSet = baseResourceSet;
			}

			public override string GetString (string name, bool ignoreCase)
			{
				return name;
			}

			public override string GetString (string name)
			{
				return name;
			}

			public override object GetObject (string name, bool ignoreCase)
			{
				return baseResourceSet != null ?
					baseResourceSet.GetObject (name, ignoreCase) : null;
			}

			public override object GetObject (string name)
			{
				return baseResourceSet != null ?
					baseResourceSet.GetObject (name) : null;
			}
		}

		internal GetTextResourceManager (string baseName, Assembly assembly) : base (baseName, assembly)
		{
			ResourceSets[CultureInfo.InvariantCulture] = new GetTextResourceSet (InternalGetResourceSet(CultureInfo.InvariantCulture, true, false));
		}
	}

	private static readonly ResourceManager resources = new GetTextResourceManager (typeof(Locale).Assembly.GetName().Name, typeof(Locale).Assembly);

	private Locale ()
	{
	}

	internal static string GetText (string message)
	{
		return resources.GetString (message, null);
	}

	internal static string GetText (string format, params object [] args)
	{
		return string.Format (resources.GetString (format, null), args);
	}

	internal static object GetResource (string name)
	{
		return resources.GetObject (name);
	}
}