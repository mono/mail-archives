using System.Xml;
// using System.Xml.Serialization;

public class Test {

  public static void Main(string[] args) {

    // Cause a reference to the [XmlElement]ed member from this file.  For some
    // reason, it seems to look up the other file's [XmlElement] against this
    // file's 'using' declarations instead of its own, causing a "'XmlElement':
    // is not an attribute class'" error.
    FooContainer fooContainer = null;
    int foo = fooContainer.fooElements.Count;
  }
}
