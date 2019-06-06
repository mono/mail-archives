using System;
using System.Xml;
using System.Xml.Xsl;

namespace test
{
	public class Test
	{
		public static void Main ()
		{
			// bug #76115
			XmlDocument doc = new XmlDocument ();
			doc.LoadXml ("<xsl:transform xmlns:xsl='http://www.w3.org/1999/XSL/Transform' version='1.0' />");
			XslTransform xslt = new XslTransform ();
			xslt.Load (doc, null, null);
			XmlReader reader = xslt.Transform(doc, null, new XmlUrlResolver ());
			reader.Read ();

			// another case - with xsl:output standalone='yes'
			doc.LoadXml ("<xsl:transform xmlns:xsl='http://www.w3.org/1999/XSL/Transform' version='1.0' ><xsl:output standalone='yes' indent='no'/><xsl:template match='/'><foo/></xsl:template></xsl:transform>");
			xslt = new XslTransform ();
			xslt.Load (doc, null, null);
			reader = xslt.Transform (doc, null, new XmlUrlResolver ());
			while (!reader.EOF)
				reader.Read (); // btw no XMLdecl output.
		}
	}
}
