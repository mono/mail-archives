using System;
using NUnit.Framework;
using System.Runtime.Serialization.Formatters.Binary;
using System.IO;
using System.Text;

//
// The MSFT v2.0.50727 implementation was analysed and the following unit-tests show the results.
//
// Where:
// y = A non-empty value passed (String/Exception respectively).
// N = null passed.
// E = String.Empty passed.
//
// CAD = "Cannot access a disposed object."
// ON  = "Object name: '<objectName>'."
// ODT = "Exception of type 'System.ObjectDisposedException' was thrown."
//
//                          message
//                          | objectName
//                          | | exception
//                          | | |   Resultant 'Message' text
//                          | | |   |
//----------------------------------------------------------------------
// #ctor(String)
//                          - y -   CAD+ON
//                          - N -   CAD
//                          - E -   CAD
//----------------------------------------------------------------------
// #ctor(String,String)
//                          y y -   M+ON
//                          N y -   ODT+ON
//                          E y -   ""+ON
//                          -----
//                          y N -   M
//                          N N -   ODT
//                          E N -   ""
//                          -----
//                          y E -   M
//                          N E -   ODT
//                          E E -   ""
//----------------------------------------------------------------------
// #ctor(String,Exception)
//                          - y y   M
//                          - N y   ODT
//                          - E y   ""
//                          -----
//                          - y -   M
//                          - N -   ODT
//                          - E -   ""
//----------------------------------------------------------------------
//
// They also show that the ObjectName property returns an empty string if it was set to null.
//
// By-hand analysis of the Binary Serialization output shows the same is true there.
//

namespace MonoTests.System
{
	[TestFixture]
	public class ObjectDisposedExceptionMessageAndObjectNamePropertyTest
	{
		const string ExOfTypeWasThrown = "Exception of type 'System.ObjectDisposedException' was thrown.";

		//------------------------------------------------------------------
		const string TestObjectName = "oobbjjName";
		const string TestMessage = "Mmssgg";
		const string TestExceptionMessage = "InExMsg";

		//------------------------------------------------------------------
		private void DoTestMessage (string expected, Exception ex)
		{
			String message = ex.Message;
			Assert.AreEqual (expected, message);
		}

		// This exception has the following constructors:
		//public ObjectDisposedException (string objectName);
		//protected ObjectDisposedException (SerializationInfo info, StreamingContext context);
		//public ObjectDisposedException (string message, Exception innerException);
		//public ObjectDisposedException (string objectName, string message);

		//-----------------------
		//Testing: public ObjectDisposedException (string objectName);
		//-----------------------
		[Test]
		public void String_NonEmpty ()
		{
			String objectName = TestObjectName;
			Exception ex = new ObjectDisposedException (objectName);
			DoTestMessage ("Cannot access a disposed object.\r\nObject name: '" + TestObjectName + "'.", ex); //HACK
		}
		[Test]
		public void String_Null ()
		{
			String objectName = null;
			Exception ex = new ObjectDisposedException (objectName);
			DoTestMessage ("Cannot access a disposed object.", ex);
		}
		[Test]
		public void String_Empty ()
		{
			String objectName = String.Empty;
			Exception ex = new ObjectDisposedException (objectName);
			DoTestMessage ("Cannot access a disposed object.", ex);
		}

		//-----------------------
		//Testing: public ObjectDisposedException (string objectName, string message);
		//-----------------------
		[Test]
		public void StringString_NonEmptyNonEmpty ()
		{
			String objectName = TestObjectName;
			String message = TestMessage;
			Exception ex = new ObjectDisposedException (objectName, message);
			DoTestMessage (TestMessage + "\r\nObject name: '" + TestObjectName + "'.", ex);
		}
		[Test]
		public void StringString_NonEmptyNull ()
		{
			String objectName = TestObjectName;
			String message = null;
			Exception ex = new ObjectDisposedException (objectName, message);
			DoTestMessage (ExOfTypeWasThrown + "\r\nObject name: '" + TestObjectName + "'.", ex);
		}
		[Test]
		public void StringString_NonEmptyEmpty ()
		{
			String objectName = TestObjectName;
			String message = String.Empty;
			Exception ex = new ObjectDisposedException (objectName, message);
			DoTestMessage ("\r\nObject name: '" + TestObjectName + "'.", ex);
		}

		[Test]
		public void StringString_NullNonEmpty ()
		{
			String objectName = null;
			String message = TestMessage;
			Exception ex = new ObjectDisposedException (objectName, message);
			DoTestMessage (TestMessage, ex);
		}
		[Test]
		public void StringString_NullNull ()
		{
			String objectName = null;
			String message = null;
			Exception ex = new ObjectDisposedException (objectName, message);
			DoTestMessage (ExOfTypeWasThrown, ex);
		}
		[Test]
		public void StringString_NullEmpty ()
		{
			String objectName = null;
			String message = String.Empty;
			Exception ex = new ObjectDisposedException (objectName, message);
			DoTestMessage ("", ex);
		}

		[Test]
		public void StringString_EmptyNonEmpty ()
		{
			String objectName = String.Empty;
			String message = TestMessage;
			Exception ex = new ObjectDisposedException (objectName, message);
			DoTestMessage (TestMessage, ex);
		}
		[Test]
		public void StringString_EmptyNull ()
		{
			String objectName = String.Empty;
			String message = null;
			Exception ex = new ObjectDisposedException (objectName, message);
			DoTestMessage (ExOfTypeWasThrown, ex);
		}
		[Test]
		public void StringString_EmptyEmpty ()
		{
			String objectName = String.Empty;
			String message = String.Empty;
			Exception ex = new ObjectDisposedException (objectName, message);
			DoTestMessage ("", ex);
		}

		//-----------------------
		//Testing: public ObjectDisposedException (string message, Exception innerException);
		//-----------------------
		[Test]
		public void StringException_NonEmptyValue ()
		{
			String message = TestMessage;
			Exception innerException = new RankException ("zoo");
			Exception ex = new ObjectDisposedException (message, innerException);
			DoTestMessage (TestMessage, ex);
		}
		[Test]
		public void StringException_NullValue ()
		{
			String message = null;
			Exception innerException = new RankException ("zoo");
			Exception ex = new ObjectDisposedException (message, innerException);
			DoTestMessage (ExOfTypeWasThrown, ex);
		}
		[Test]
		public void StringException_EmptyValue ()
		{
			String message = String.Empty;
			Exception innerException = new RankException ("zoo");
			Exception ex = new ObjectDisposedException (message, innerException);
			DoTestMessage ("", ex);
		}

		[Test]
		public void StringException_NonEmptyNull ()
		{
			String message = TestMessage;
			Exception innerException = null;
			Exception ex = new ObjectDisposedException (message, innerException);
			DoTestMessage (TestMessage, ex);
		}
		[Test]
		public void StringException_NullNull ()
		{
			String message = null;
			Exception innerException = null;
			Exception ex = new ObjectDisposedException (message, innerException);
			DoTestMessage (ExOfTypeWasThrown, ex);
		}
		[Test]
		public void StringException_EmptyNull ()
		{
			String message = String.Empty;
			Exception innerException = null;
			Exception ex = new ObjectDisposedException (message, innerException);
			DoTestMessage ("", ex);
		}

		//-----------------------
		// Test ObjectName property
		//-----------------------
		[Test]
		public void ObjectNameNotSet ()
		{
			ObjectDisposedException ex = new ObjectDisposedException (TestMessage, new RankException ("zoo"));
			Assert.AreEqual (string.Empty, ex.ObjectName);
		}

		[Test]
		public void ObjectNameValue ()
		{
			ObjectDisposedException ex = new ObjectDisposedException (TestObjectName);
			Assert.AreEqual (TestObjectName, ex.ObjectName);
		}
		[Test]
		public void ObjectNameNull ()
		{
			ObjectDisposedException ex = new ObjectDisposedException (null);
			Assert.AreEqual (string.Empty, ex.ObjectName);
		}
		[Test]
		public void ObjectNameEmpty ()
		{
			ObjectDisposedException ex = new ObjectDisposedException (string.Empty);
			Assert.AreEqual (string.Empty, ex.ObjectName);
		}


		public static void SerializeSomeObjectDisposedExceptionsToDisk ()
		{
			String path = "SomeObjectDisposedExceptions.bin";
			using (FileStream dst = File.OpenWrite (path)) {
				Exception ex;
				BinaryFormatter fmtr = new BinaryFormatter ();
				//
				ex = new ObjectDisposedException (null);
				fmtr.Serialize (dst, ex);
				//
				//ex = new ObjectDisposedException (TestObjectName);
				//fmtr.Serialize (dst, ex);
				////
				//ex = new ObjectDisposedException (TestMessage, new RankException (TestExceptionMessage));
				//fmtr.Serialize (dst, ex);
			}//using
			//
			AlsoWriteAsHexText (path);
		}

		//public static void SerializeSomeObjectDisposedExceptions (Stream src)
		//{
		//	BinaryFormatter fmtr = new BinaryFormatter ();
		//	fmtr.
		//}


		private static void AlsoWriteAsHexText (string path)
		{
			using (FileStream src = File.OpenRead (path)) {
				using (TextWriter dst = new StreamWriter (path + ".txt", false, Encoding.ASCII)) {
					long length = src.Length;
					byte[] all = new byte[length];
					int count = src.Read (all, 0, all.Length);
					if (count != length) {
						Console.WriteLine ("Read convert failure...");
						return;
					}
					String asText = BitConverter.ToString (all);
					dst.Write (asText);
				}
			}
		}


		//-----------------------
		// Test some dependencies
		//-----------------------
		[Test]
		public void ExceptionString_MessageNull ()
		{
			String message = null;
			Exception ex = new Exception (message);
			Assert.AreEqual ("Exception of type 'System.Exception' was thrown.", ex.Message);
		}
		[Test]
		public void ExceptionStringException_MessageNull ()
		{
			String message = null;
			Exception ex = new Exception (message, new RankException ("zoo"));
			Assert.AreEqual ("Exception of type 'System.Exception' was thrown.", ex.Message);
		}
		[Test]
		public void RankExceptionString_MessageNull ()
		{
			String message = null;
			Exception ex = new RankException (message);
			Assert.AreEqual ("Exception of type 'System.RankException' was thrown.", ex.Message);
		}

	}//class
}
