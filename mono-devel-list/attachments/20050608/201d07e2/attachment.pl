//
// System.Resources.CorlibResourceManager.cs
//
// Author:
//   Korn�l P�l <http://www.kornelpal.hu/>
//
// Copyright (C) 2005 Korn�l P�l
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

using System;
using System.Globalization;
using System.Threading;

namespace System.Resources
{
	// This resource manager has to be used by corlib to avoid infinite
	// GetString recursion because ResourceManager itself uses resources
	// and objects that may use resources.
	internal sealed class CorlibResourceManager : ResourceManager
	{
		private readonly LocalDataStoreSlot getStringLock = Thread.AllocateDataSlot ();

		internal CorlibResourceManager () : base ("mscorlib", typeof (object).Assembly)
		{
		}

		// Prevents infinite GetString recursion
		public override string GetString (string name, CultureInfo culture)
		{
			if (Thread.GetData (getStringLock) != null)
				// Do not localize
				return "GetString recursion: " + name;

			Thread.SetData (getStringLock, this);
			try {
				return base.GetString (name, culture);
			}
			finally {
				Thread.SetData (getStringLock, null);
			}
		}
	}
}