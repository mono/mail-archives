using System;
using System.Xml;
using System.Xml.Schema;

public class Test

{
	public static void Main ()
	{
		string xsd = "<xs:schema xmlns:xs='" + XmlSchema.Namespace + "'><xs:element name='root' type='xs:base64Binary' /></xs:schema>";
		XmlSchema schema = XmlSchema.Read (new XmlTextReader (xsd, XmlNodeType.Document, null), null);
		schema.Compile (null);
		XmlSchemaElement el = schema.Items [0] as XmlSchemaElement;
		// Japanese a-i-u-e-o
		Console.WriteLine (((XmlSchemaDatatype) el.ElementType).ParseValue ("\u3042\u3044\u3046\u3048\u304a", null, null));
	}
}

