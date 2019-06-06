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
		System.Xml.XmlElement testNode = (System.Xml.XmlElement)nodeList.Item(FIRST).ChildNodes.Item(FIRST);

		System.Xml.XmlElement newChild = doc.DocumentElement;
		try 
		{
			testNode.InsertBefore(newChild, null);
			Console.WriteLine("InsertChild - Expected exception not catched");
		}
		catch(System.Exception ex) 
		{
			Console.WriteLine("InsertChild - Exception catched : " + ex.GetType().ToString() + " " + ex.Message);
		}

		try 
		{
			testNode.ReplaceChild(newChild, testNode.ChildNodes.Item(FIRST));
			Console.WriteLine("ReplaceChild - Expected exception not catched");
		}
		catch(System.Exception ex) 
		{
			Console.WriteLine("ReplaceChild - Exception catched : " + ex.GetType().ToString() + " " + ex.Message);
		}

		try 
		{
			testNode.AppendChild(newChild);
			Console.WriteLine("AppendChild - Expected exception not catched");
		}
		catch(System.Exception ex) 
		{
			Console.WriteLine("AppendChild - Exception catched : " + ex.GetType().ToString() + " " + ex.Message);
		}
	}
}

