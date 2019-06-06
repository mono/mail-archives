using System.Collections;
using System.Xml.Serialization;

public class FooElement {
}

public class FooContainer {

  [XmlElement("FooElement", typeof(FooElement))]
  public ArrayList fooElements = new ArrayList();
}
