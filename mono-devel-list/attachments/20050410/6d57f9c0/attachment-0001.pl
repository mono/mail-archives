using System;
using System.Xml;
using System.IO;
using System.Diagnostics;
using System.Xml.Serialization;
using System.Data;

public class TestSpace {
	[XmlElement( ElementName = "Name with space", Namespace = "http://www.deriv.com")]
	public int test {
		get { return 4; }
		set {}
	}
}


public class Test {

	static void Test6() {
		TestSpace ts = new TestSpace();

		XmlSerializer ser = new XmlSerializer(typeof(TestSpace));

		ser.Serialize(Console.Out, ts);
	}

	public static void Main () {
		Test6();

	}
} 
