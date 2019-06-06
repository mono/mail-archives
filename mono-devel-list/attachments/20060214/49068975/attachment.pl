using System;
using System.Collections.Generic;
using System.Text;
using System.Xml;

namespace TestXmlWriter
{
	class Program
	{
		static void Main(string[] args)
		{
			StringBuilder header = new StringBuilder();

			using(System.Xml.XmlWriter writer = System.Xml.XmlWriter.Create(header, new System.Xml.XmlWriterSettings()))
			{
				writer.WriteStartElement("stream", "stream", "http://etherx.jabber.org/streams");
				writer.WriteAttributeString("version", "1.0");
				writer.WriteAttributeString("from", "me@test.com");
				writer.WriteAttributeString("to", "server");
				writer.WriteAttributeString("xmlns", "jabber:client");

				writer.WriteRaw("");
				//writer.WriteString("");

				writer.Flush();
				
				Console.WriteLine(header.ToString());
			}

			Console.ReadLine();
		}
	}
}
