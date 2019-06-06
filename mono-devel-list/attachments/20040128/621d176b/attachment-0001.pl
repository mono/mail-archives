using System;
using System.Xml;

public	class Test
{
	public static int FIRST = 0;
	public static int SECOND = 1;
	public static int THIRD = 2;
	public static int FOURTH = 3;
	public static int FIFTH = 4;
	public static int SIXTH = 5;
	public static int SEVENTH = 6;
	public static int EIGHT = 7;
	public static int NINETH = 8;
	public static int TENTH = 9;
	public static int ELEVENTH = 10;
	public static int TWELVETH = 11;
	public static int THIRDTEENTH = 12;
	static void Main(string[] args)
	{
		XmlDocument doc = new XmlDocument();
		doc.Load("staff.xml");

		XmlNodeList nodeList = doc.DocumentElement.GetElementsByTagName("employee");

		try
		{
			System.Xml.XmlDocumentType doctype = (System.Xml.XmlDocumentType)doc.ChildNodes.Item(SECOND);
			System.Xml.XmlNamedNodeMap notations = doctype.Notations;

			foreach( System.Xml.XmlNotation notation in notations)
			{
				Console.WriteLine(notation.Name);
			}

		}
		catch (Exception e)
		{
			Console.WriteLine(e.StackTrace);
		}

	}
}

