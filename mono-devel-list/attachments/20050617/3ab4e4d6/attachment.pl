using System;
using System.Xml;

public class Test
{
	public static void Main ()
	{
		string xml = "<!DOCTYPE root [<!ELEMENT root (#PCDATA)*><!ENTITY ent 'val'>]><root attr='a &ent; string'>&ent;</root>";
		XmlTextReader xtr = new XmlTextReader (xml, XmlNodeType.Document, null);
		XmlDocument doc = new XmlDocument ();
		doc.AppendChild (doc.ReadNode (xtr)); // DTD
		xtr.Read ();
		XmlEntityReference e = (XmlEntityReference) doc.ReadNode (xtr);
		Console.WriteLine (e.ChildNodes.Count);
		doc.AppendChild (doc.CreateElement ("foo"));
		doc.DocumentElement.AppendChild (e);
		Console.WriteLine (e.ChildNodes.Count);
	}
}
