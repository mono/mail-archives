using System;
using System.Xml;
using System.IO;
using NUnit.Framework;

namespace MonoVsMsNetTests
{
  [TestFixture]
  public class XmlTextWriterTests
  {
    [Test]
    public void AttemptToWriteXmlWithHeaderNoEncoding()
    {
      String xml = @"<?xml version=""1.0"" encoding=""UTF-8""?>
<parent>
<child></child>
</parent>";
      
      XmlReader xmlReader = new XmlValidatingReader(xml, XmlNodeType.Element, null);

      TextWriter baseWriter = new StringWriter();
      XmlTextWriter writer = new XmlTextWriter(baseWriter);

      try
      {
        writer.WriteNode(xmlReader, true);
      }
      catch(Exception ex)
      {
        Assert.Fail(ex.Message);
      }
    }
  }
}
