// 
// CGEnums.cs: definitions used for CoreAnimation
//
// Authors: Mono Team
// Kenneth J. Pouncey
//     
// Copyright 2009 Novell, Inc
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
//using System.Drawing;
//using System.Runtime.InteropServices;
//
//using MonoMac.ObjCRuntime;
//using MonoMac.Foundation;

namespace MonoMac.CoreGraphics
{
	public enum CGError : int
	{
		Success = 0,
		Failure = 1000,
		IllegalArgument = 1001,
		InvalidConnection = 1002,
		InvalidContext = 1003,
		CannotComplete = 1004,
		NotImplemented = 1006,
		RangeCheck = 1007,
		TypeCheck = 1008,
		InvalidOperation = 1010,
		NoneAvailable = 1011,

		/* Obsolete errors. */
		NameTooLong = 1005,
		NoCurrentPoint = 1009,
		ApplicationRequiresNewerSystem = 1015,
		ApplicationNotPermittedToExecute = 1016,
		ApplicationIncorrectExecutableFormatFound = 1023,
		ApplicationIsLaunching = 1024,
		ApplicationAlreadyRunning = 1025,
		ApplicationCanOnlyBeRunInOneSessionAtATime = 1026,
		ClassicApplicationsMustBeLaunchedByClassic = 1027,
		ForkFailed = 1028,
		RetryRegistration = 1029,
		First = 1000,
		Last = 1029
	}
	
	public enum CaptureOptions : int
	{
		NoOptions = 0,	/* Default behavior. */
		NoFill = (1 << 0)	/* Disables fill with black on capture. */
	}

}
