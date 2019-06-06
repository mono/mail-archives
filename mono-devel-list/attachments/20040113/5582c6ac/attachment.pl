using System;
using System.Xml;

public	class Test
{
	static void Main(string[] args)
	{
		XmlDocument doc = new XmlDocument();
		doc.Load("staff.xml");

		XmlNodeList nodeList = doc.DocumentElement.GetElementsByTagName("employee");
		System.Xml.XmlElement testNode = (System.Xml.XmlElement)nodeList.Item(0).ChildNodes.Item(0);
			
		testNode.RemoveAttribute("street");

		XmlAttribute streetAttr = (System.Xml.XmlAttribute)testNode.Attributes.GetNamedItem("street");
		Console.WriteLine(streetAttr.Specified.ToString());
		Console.WriteLine(streetAttr.Value);
	}
}

