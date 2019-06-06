Index: olive/class/System.ServiceModel.Web/Test/System.ServiceModel.Web/System.ServiceModel.Syndication/SyndicationContentTest.cs
===================================================================
--- olive/class/System.ServiceModel.Web/Test/System.ServiceModel.Web/System.ServiceModel.Syndication/SyndicationContentTest.cs	(revision 0)
+++ olive/class/System.ServiceModel.Web/Test/System.ServiceModel.Web/System.ServiceModel.Syndication/SyndicationContentTest.cs	(revision 0)
@@ -0,0 +1,305 @@
+//
+// SyndicationContentTest.cs - NUnit Test Cases for Abstract Class SyncicationContent
+//
+// Author:
+//      Stephen A Jazdzewski (Steve@Jazd.com)
+//
+// Copyright (C) 2007 Stephen A Jazdzewski
+//
+// Permission is hereby granted, free of charge, to any person obtaining
+// a copy of this software and associated documentation files (the
+// "Software"), to deal in the Software without restriction, including
+// without limitation the rights to use, copy, modify, merge, publish,
+// distribute, sublicense, and/or sell copies of the Software, and to
+// permit persons to whom the Software is furnished to do so, subject to
+// the following conditions:
+//
+// The above copyright notice and this permission notice shall be
+// included in all copies or substantial portions of the Software.
+//
+// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
+// LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
+// OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
+// WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+//
+
+
+using System;
+using System.Text;
+using System.Xml;
+using NUnit.Framework;
+using System.ServiceModel.Syndication;
+
+namespace MonoTests.System.ServiceModel.Syndication
+{
+        [TestFixture]
+        public class TextSyndicationContentTest {
+                static string title = "Lorem";
+                static string lorem = "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Integer vitae.";
+                string [] text_types = new string [3];
+
+                [SetUp]
+                public void Setup ()
+                {
+                        // Map Text Content Kind to expected return value from .Type
+                        text_types [(int) TextSyndicationContentKind.Html] = "html";
+                        text_types [(int) TextSyndicationContentKind.Plaintext] = "text";
+                        text_types [(int) TextSyndicationContentKind.XHtml] = "xhtml";
+                }
+
+                [Test]
+                public void TextSimple ()
+                {
+                        TextSyndicationContent stext = new TextSyndicationContent (lorem, TextSyndicationContentKind.Plaintext);
+
+                        Assert.AreEqual (typeof (TextSyndicationContent), stext.GetType (), "#TS1");
+                        Assert.AreEqual (typeof (string), stext.Text.GetType (), "#TS2");
+                        // check for content and type
+                        StringAssert.IsMatch (lorem, stext.Text.ToString (), "#TS3");
+                        Assert.AreEqual (text_types [(int) TextSyndicationContentKind.Plaintext], stext.Type.ToString (), "#TS4");
+
+                        stext = new TextSyndicationContent (null);
+                        Assert.IsInstanceOfType (typeof (TextSyndicationContent), stext, "#TS5");
+                        // Be sure .Text is null
+                        try
+                        {
+                                Assert.AreEqual (typeof (string), stext.Text.GetType (), "#TS6");
+                                Assert.Fail ("#TS7 Expected an NullReferenceException to be thrown.");
+                        }
+                        catch (NullReferenceException) {}
+                }
+
+                static string validhtml = "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01//EN\" " +
+                        "\"http://www.w3.org/TR/html4/strict.dtd\">" +
+                        "<HTML><HEAD><TITLE>" + title + "/TITLE></HEAD>" +
+                        "<BODY><P>" + lorem + "</BODY></HTML>";
+
+                [Test]
+                public void HtmlSimple ()
+                {
+                        TextSyndicationContent shtml = new TextSyndicationContent (validhtml, TextSyndicationContentKind.Html);
+
+                        Assert.AreEqual (typeof (TextSyndicationContent), shtml.GetType (), "#HS1");
+                        Assert.AreEqual (typeof (string), shtml.Text.GetType (), "#HS2");
+                        // check for content and type
+                        StringAssert.IsMatch (validhtml, shtml.Text.ToString (), "#HS3");
+                        Assert.AreEqual (text_types [(int) TextSyndicationContentKind.Html], shtml.Type, "#HS4");
+                }
+
+                static string validxhtml = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>" +
+                        "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Strict//EN\" " +
+                        "\"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\">" +
+                        "<html xmlns=\"http://www.w3.org/1999/xhtml\" xml:lang=\"en\" lang=\"en\">" +
+                        "<head><title>" + title + "</title></head>" +
+                        "<body><p>" + lorem + "</p></body></html>";
+
+
+                [Test]
+                public void XHtmlSimple ()
+                {
+                        TextSyndicationContent sxhtml = new TextSyndicationContent (validhtml, TextSyndicationContentKind.XHtml);
+
+                        Assert.AreEqual (typeof (TextSyndicationContent), sxhtml.GetType (), "#XS1");
+                        Assert.AreEqual (typeof (string), sxhtml.Text.GetType (), "#XS2");
+                        // check for content and type
+                        StringAssert.IsMatch (validhtml, sxhtml.Text.ToString (), "#XS3");
+                        Assert.AreEqual (text_types [(int) TextSyndicationContentKind.XHtml], sxhtml.Type, "#XS4");
+                }
+
+                [Test]
+                public void Advanced ()
+                {
+                        // Defaults to Plaintext
+                        TextSyndicationContent stext = new TextSyndicationContent (lorem);
+
+                        Assert.AreEqual (text_types [(int) TextSyndicationContentKind.Plaintext], stext.Type, "#A1");
+                }
+        }
+
+        [TestFixture]
+        public class UrlSyndicationContentTest {
+                static string media_type = "Text/xml";
+                static string url = "http://www.Jazd.com/rss";
+
+                [Test]
+                public void Simple ()
+                {
+                        Uri suri = new Uri (url);
+                        UrlSyndicationContent surl = new UrlSyndicationContent (suri, media_type);
+
+                        Assert.AreEqual (typeof (UrlSyndicationContent), surl.GetType (), "#S1");
+                        // check for content and type
+                        StringAssert.IsMatch (url.ToLower (), surl.Url.ToString (), "#S2");
+                        StringAssert.IsMatch (media_type, surl.Type.ToString (), "#S3");
+                }
+        }
+
+        [TestFixture]
+        public class XmlSyndicationContentTest {
+                static string type = "text/xml";
+                static string tagname = "stuff";
+                static string content = "Need some";
+                static string documentname = "channel";
+
+                // May end up being setup
+                [Test]
+                public void Simple ()
+                {
+                        XmlDocument sdoc = new XmlDocument ();
+                        XmlElement selem = sdoc.CreateElement (tagname);
+                        selem.InnerText = content;
+
+                        StringBuilder syndication_string = new StringBuilder ();
+                        XmlWriterSettings settings = new XmlWriterSettings ();
+                        XmlWriter syndication = XmlWriter.Create (syndication_string, settings);
+
+                        // Simple tests
+                        XmlSyndicationContent sxml = new XmlSyndicationContent (type, selem);
+
+                        Assert.AreEqual (typeof (XmlSyndicationContent), sxml.GetType (), "#S1");
+                        StringAssert.IsMatch (type, sxml.Type.ToString (), "#S2");
+
+                        // Check correct invalid argument rejection
+                        try
+                        {
+                            sxml.WriteTo (null, "", "");
+                            Assert.Fail ("#S3 Expected an ArgumentNullException to be thrown.");
+                        }
+                        catch (ArgumentNullException) { }
+                        try
+                        {
+                            sxml.WriteTo (syndication, "", "");
+                            Assert.Fail ("#S4 Expected an ArgumentException to be thrown.");
+                        }
+                        catch (ArgumentException) { }
+
+                        syndication.Close ();
+                }
+
+                [Test]
+                public void XmlElementExtension ()
+                {
+                        XmlDocument xdoc = new XmlDocument ();
+                        XmlElement xelem = xdoc.CreateElement (tagname);
+                        xelem.InnerText = content;
+
+                        // Same as Simple tests as setup for XmlElementExtension tests
+                        XmlSyndicationContent xxml = new XmlSyndicationContent (type, xelem);
+
+                        Assert.AreEqual (typeof (XmlSyndicationContent), xxml.GetType (), "#XE1");
+                        StringAssert.IsMatch (type, xxml.Type.ToString (), "#XE2");
+                        Assert.AreSame (xelem, xxml.Extension.Object, "#XE3");
+                        Assert.AreEqual (SyndicationElementExtensionKind.XmlElement, xxml.Extension.ExtensionKind, "#XE4");
+                        Assert.AreEqual (null, xxml.Extension.ObjectSerializer, "#XE5");
+
+                        // Create fake IO using stringbuilders
+                        StringBuilder element_string = new StringBuilder ();
+                        StringBuilder syndication_string = new StringBuilder ();
+
+                        XmlWriterSettings settings = new XmlWriterSettings ();
+
+                        XmlWriter element = XmlWriter.Create (element_string, settings);
+                        XmlWriter syndication = XmlWriter.Create (syndication_string, settings);
+
+                        // Make sure we get the input data back out
+                        xelem.WriteTo (element);
+                        xxml.WriteTo (syndication, documentname, "");
+
+                        element.Close ();
+                        syndication.Close ();
+
+                        // Pickout the 'channel' and 'stuff' tags from original and syndicated document
+                        XmlDocument syndoc = new XmlDocument();
+                        XmlDocument eledoc = new XmlDocument();
+
+                        syndoc.LoadXml (syndication_string.ToString ());
+                        XmlNodeList synresult = syndoc.GetElementsByTagName (tagname);
+                        XmlNodeList syntype = syndoc.GetElementsByTagName (documentname);
+
+                        eledoc.LoadXml (element_string.ToString ());
+                        XmlNodeList eleresult = eledoc.GetElementsByTagName (tagname);
+
+                        // Check document type
+                        StringAssert.IsMatch(type, syntype.Item (0).Attributes.GetNamedItem ("type").Value.ToString (),
+                                             "XE6");
+                        // Check content
+                        StringAssert.IsMatch (eleresult.Item (0).OuterXml.ToString (), synresult.Item (0).OuterXml.ToString (),
+                                              "XE7");
+                }
+
+                static Int32 author = 32765;
+                static string comment = "No comment.";
+
+                [Test]
+                public void XmlSerializerExtension ()
+                {
+                        DateTime date = new DateTime (2007, 5, 22);
+
+                        global::System.Xml.Serialization.XmlSerializer xs =
+                               new global::System.Xml.Serialization.XmlSerializer (typeof (Content));
+                        Content item = new Content ();
+                        string item_object = "Content";  // tag name for serialized object
+
+                        // fill object with some data
+                        item.author = author;
+                        item.comment = comment;
+                        item.date = date;
+
+                        XmlSyndicationContent se = new XmlSyndicationContent (type,item,xs);
+
+                        Assert.AreEqual (typeof (XmlSyndicationContent), se.GetType (), "#SE1");
+                        StringAssert.IsMatch (type, se.Type.ToString (), "#SE2");
+                        Assert.AreSame (item, se.Extension.Object, "#SE3");
+                        Assert.AreEqual (SyndicationElementExtensionKind.XmlSerializer, se.Extension.ExtensionKind, "#SE4");
+                        Assert.AreSame (xs, se.Extension.ObjectSerializer, "#SE5");
+
+                        // Create fake IO using stringbuilders
+                        StringBuilder object_string = new StringBuilder ();
+                        StringBuilder syndication_string = new StringBuilder ();
+
+                        XmlWriterSettings settings = new XmlWriterSettings ();
+
+                        XmlWriter serobj = XmlWriter.Create (object_string, settings);
+                        XmlWriter syndication = XmlWriter.Create (syndication_string, settings);
+
+                        xs.Serialize (serobj, item);
+                        se.WriteTo (syndication, documentname, "");
+
+                        serobj.Close ();
+                        syndication.Close ();
+
+                        // Pickout the 'Content' tag from original serialized object and syndicated document
+                        XmlDocument syndoc = new XmlDocument ();
+                        XmlDocument serdoc = new XmlDocument ();
+
+                        syndoc.LoadXml (syndication_string.ToString ());
+                        XmlNodeList synresult = syndoc.GetElementsByTagName (item_object);
+                        XmlNodeList syntype = syndoc.GetElementsByTagName (documentname);
+
+                        serdoc.LoadXml (object_string.ToString ());
+                        XmlNodeList serresult = serdoc.GetElementsByTagName (item_object);
+
+                        // Check document type
+                        StringAssert.IsMatch(type, syntype.Item (0).Attributes.GetNamedItem ("type").Value.ToString (),
+                                             "SE6");
+                        // Check content
+                        StringAssert.IsMatch (serresult.Item (0).OuterXml.ToString (), synresult.Item (0).OuterXml.ToString (),
+                                              "SE6");
+                }
+
+                [Test]
+                // ToDo
+                public void DataContractExtension ()
+                {
+                }
+        }
+
+        public class Content {
+                public Int32 author;
+                public string comment;
+                public DateTime date;
+        }
+}

Property changes on: olive/class/System.ServiceModel.Web/Test/System.ServiceModel.Web/System.ServiceModel.Syndication/SyndicationContentTest.cs
___________________________________________________________________
Name: svn:eol-style
   + native

Index: olive/class/System.ServiceModel.Web/Test/System.ServiceModel.Web/System.ServiceModel.Syndication/ChangeLog
===================================================================
--- olive/class/System.ServiceModel.Web/Test/System.ServiceModel.Web/System.ServiceModel.Syndication/ChangeLog	(revision 0)
+++ olive/class/System.ServiceModel.Web/Test/System.ServiceModel.Web/System.ServiceModel.Syndication/ChangeLog	(revision 0)
@@ -0,0 +1,3 @@
+2007-05-26  Stephen Jazdzewski <Steve@Jazd.com>
+
+        * File created

Property changes on: olive/class/System.ServiceModel.Web/Test/System.ServiceModel.Web/System.ServiceModel.Syndication/ChangeLog
___________________________________________________________________
Name: svn:eol-style
   + native

Index: olive/class/System.ServiceModel.Web/Assembly/AssemblyInfo.cs
===================================================================
--- olive/class/System.ServiceModel.Web/Assembly/AssemblyInfo.cs	(revision 0)
+++ olive/class/System.ServiceModel.Web/Assembly/AssemblyInfo.cs	(revision 0)
@@ -0,0 +1,57 @@
+//
+// SyndicationFeed.cs
+//
+// Author:
+//      Stephen A Jazdzewski (Steve@Jazd.com)
+//
+// Copyright (C) 2007 Stephen A Jazdzewski
+//
+// Permission is hereby granted, free of charge, to any person obtaining
+// a copy of this software and associated documentation files (the
+// "Software"), to deal in the Software without restriction, including
+// without limitation the rights to use, copy, modify, merge, publish,
+// distribute, sublicense, and/or sell copies of the Software, and to
+// permit persons to whom the Software is furnished to do so, subject to
+// the following conditions:
+//
+// The above copyright notice and this permission notice shall be
+// included in all copies or substantial portions of the Software.
+//
+// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
+// LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
+// OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
+// WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+//
+
+using System;
+using System.Reflection;
+using System.Resources;
+using System.Security;
+using System.Runtime.CompilerServices;
+using System.Runtime.InteropServices;
+
+// General Information about the System.ServiceModel assembly
+
+[assembly: AssemblyVersion (Consts.FxVersion)]
+[assembly: SatelliteContractVersion (Consts.FxVersion)]
+
+[assembly: AssemblyTitle ("System.ServiceModel.Web.dll")]
+[assembly: AssemblyDescription ("System.ServiceModel.Web.dll")]
+[assembly: AssemblyConfiguration ("Development version")]
+[assembly: AssemblyCompany ("MONO development team")]
+[assembly: AssemblyProduct ("MONO CLI")]
+[assembly: AssemblyCopyright ("(C) 2007 Various Authors")]
+[assembly: AssemblyTrademark ("")]
+
+[assembly: CLSCompliant (true)]
+[assembly: AssemblyDefaultAlias ("System.ServiceModel.Web.dll")]
+[assembly: AssemblyInformationalVersion ("0.0.0.1")]
+[assembly: NeutralResourcesLanguage ("en-US")]
+
+[assembly: ComVisible (false)]
+
+[assembly: AssemblyDelaySign (true)]
+[assembly: AssemblyKeyFile("../winfx.pub")]

Property changes on: olive/class/System.ServiceModel.Web/Assembly/AssemblyInfo.cs
___________________________________________________________________
Name: svn:eol-style
   + native

Index: olive/class/System.ServiceModel.Web/Assembly/ChangeLog
===================================================================
--- olive/class/System.ServiceModel.Web/Assembly/ChangeLog	(revision 0)
+++ olive/class/System.ServiceModel.Web/Assembly/ChangeLog	(revision 0)
@@ -0,0 +1,3 @@
+2007-05-27  Stephen Jazdzewski <Steve@Jazd.com>
+
+        * File created

Property changes on: olive/class/System.ServiceModel.Web/Assembly/ChangeLog
___________________________________________________________________
Name: svn:eol-style
   + native

Index: olive/class/System.ServiceModel.Web/ChangeLog
===================================================================
--- olive/class/System.ServiceModel.Web/ChangeLog	(revision 0)
+++ olive/class/System.ServiceModel.Web/ChangeLog	(revision 0)
@@ -0,0 +1,3 @@
+2007-05-26  Stephen Jazdzewski <Steve@Jazd.com>
+
+        * File created

Property changes on: olive/class/System.ServiceModel.Web/ChangeLog
___________________________________________________________________
Name: svn:eol-style
   + native

Index: olive/class/System.ServiceModel.Web/System.ServiceModel.Syndication/SyndicationPerson.cs
===================================================================
--- olive/class/System.ServiceModel.Web/System.ServiceModel.Syndication/SyndicationPerson.cs	(revision 0)
+++ olive/class/System.ServiceModel.Web/System.ServiceModel.Syndication/SyndicationPerson.cs	(revision 0)
@@ -0,0 +1,134 @@
+//
+// SyndicationPerson.cs
+//
+// Author:
+//      Stephen A Jazdzewski (Steve@Jazd.com)
+//
+// Copyright (C) 2007 Stephen A Jazdzewski
+//
+// Permission is hereby granted, free of charge, to any person obtaining
+// a copy of this software and associated documentation files (the
+// "Software"), to deal in the Software without restriction, including
+// without limitation the rights to use, copy, modify, merge, publish,
+// distribute, sublicense, and/or sell copies of the Software, and to
+// permit persons to whom the Software is furnished to do so, subject to
+// the following conditions:
+//
+// The above copyright notice and this permission notice shall be
+// included in all copies or substantial portions of the Software.
+//
+// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
+// LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
+// OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
+// WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+//
+
+
+using System;
+using System.Xml;
+using System.Xml.Serialization;
+using System.Runtime.Serialization;
+using System.Collections.Generic;
+using System.Collections.ObjectModel;
+using System.ServiceModel.Syndication;
+
+namespace System.ServiceModel.Syndication
+{
+        [MonoTODO]
+        public class SyndicationPerson {
+                [MonoTODO]
+                public SyndicationPerson ()
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                public SyndicationPerson (string email)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                public SyndicationPerson (string email, string name, string uri)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                public Collection <TExtension> ReadElementExtensions <TExtension> (string extensionName, string extensionNamespace)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                public Collection <TExtension> ReadElementExtensions <TExtension> (string extensionName, string extensionNamespace,
+                                                                                   XmlSerializer serializer)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                public Collection <TExtension> ReadElementExtensions <TExtension> (string extensionName, string extensionNamespace,
+                                                                                   XmlObjectSerializer serializer)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                protected internal virtual bool TryParseElement (XmlReader reader, SyndicationSerializer serializer)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                protected internal virtual bool TryParseAttribute (string name, string ns, string value,
+                                                                   SyndicationSerializer serializer)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                public XmlReader GetReaderAtElementExtensions ()
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                protected internal virtual void WriteAttributeExtensions (XmlWriter writer, SyndicationSerializer serializer)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                protected internal virtual void WriteElementExtensions (XmlWriter writer, SyndicationSerializer serializer)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                public Dictionary <XmlQualifiedName, string> AttributeExtensions {
+                        get {throw new NotImplementedException ();}
+                }
+
+                public SyndicationElementExtensionCollection ElementExtensions {
+                        get {throw new NotImplementedException ();}
+                }
+
+                public string Email {
+                        get {throw new NotImplementedException ();}
+                        set {throw new NotImplementedException ();}
+                }
+
+                public string Name {
+                        get {throw new NotImplementedException ();}
+                        set {throw new NotImplementedException ();}
+                }
+
+                public string Uri {
+                        get {throw new NotImplementedException ();}
+                        set {throw new NotImplementedException ();}
+                }
+        }
+}

Property changes on: olive/class/System.ServiceModel.Web/System.ServiceModel.Syndication/SyndicationPerson.cs
___________________________________________________________________
Name: svn:eol-style
   + native

Index: olive/class/System.ServiceModel.Web/System.ServiceModel.Syndication/SyndicationSerializer.cs
===================================================================
--- olive/class/System.ServiceModel.Web/System.ServiceModel.Syndication/SyndicationSerializer.cs	(revision 0)
+++ olive/class/System.ServiceModel.Web/System.ServiceModel.Syndication/SyndicationSerializer.cs	(revision 0)
@@ -0,0 +1,270 @@
+//
+// SyndicationSerializer.cs
+//
+// Author:
+//      Stephen A Jazdzewski (Steve@Jazd.com)
+//
+// Copyright (C) 2007 Stephen A Jazdzewski
+//
+// Permission is hereby granted, free of charge, to any person obtaining
+// a copy of this software and associated documentation files (the
+// "Software"), to deal in the Software without restriction, including
+// without limitation the rights to use, copy, modify, merge, publish,
+// distribute, sublicense, and/or sell copies of the Software, and to
+// permit persons to whom the Software is furnished to do so, subject to
+// the following conditions:
+//
+// The above copyright notice and this permission notice shall be
+// included in all copies or substantial portions of the Software.
+//
+// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
+// LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
+// OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
+// WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+//
+
+
+using System;
+using System.Xml;
+using System.Collections.Generic;
+using System.ServiceModel.Syndication;
+
+namespace System.ServiceModel.Syndication
+{
+        [MonoTODO]
+        public abstract class SyndicationSerializer {
+                [MonoTODO]
+                protected SyndicationSerializer ()
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                protected SyndicationPerson CreatePerson (SyndicationFeed feed)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                protected SyndicationPerson CreatePerson (SyndicationItem item)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                protected SyndicationCategory CreateCategory (SyndicationFeed feed)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                protected SyndicationCategory CreateCategory (SyndicationItem item)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                protected SyndicationItem CreateItem (SyndicationFeed feed)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                protected void LoadElementExtensions (XmlReader reader, SyndicationPerson person, int maxExtensionSize)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                protected void LoadElementExtensions (XmlReader reader, SyndicationCategory category, int maxExtensionSize)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                protected void LoadElementExtensions (XmlReader reader, SyndicationFeed feed, int maxExtensionSize)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                protected void LoadElementExtensions (XmlReader reader, SyndicationItem item, int maxExtensionSize)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                public void ReadFrom (XmlReader reader, SyndicationFeed feed)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                public void ReadFrom (XmlReader reader, SyndicationItem item)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                protected abstract void ReadXml (XmlReader reader, SyndicationFeed feed);
+
+                [MonoTODO]
+                protected abstract void ReadXml (XmlReader reader, SyndicationItem item);
+
+                [MonoTODO]
+                protected bool TryParseContent (XmlReader reader, SyndicationItem item, string contentType,
+                                                out SyndicationContent content)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                protected bool TryParseAttribute (string name, string ns, string value, SyndicationPerson person)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                protected bool TryParseAttribute (string name, string ns, string value, SyndicationCategory category)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                protected bool TryParseAttribute (string name, string ns, string value, SyndicationFeed feed)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                protected bool TryParseAttribute (string name, string ns, string value, SyndicationItem item)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                protected bool TryParseElement (XmlReader reader, SyndicationPerson person)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                protected bool TryParseElement (XmlReader reader, SyndicationCategory category)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                protected bool TryParseElement (XmlReader reader, SyndicationFeed feed)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                protected bool TryParseElement (XmlReader reder, SyndicationItem item)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                protected void WriteAttributeExtensions(XmlWriter writer, SyndicationPerson person)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                protected void WriteAttributeExtensions (XmlWriter writer, SyndicationCategory category)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                protected void WriteAttributeExtensions (XmlWriter writer, SyndicationFeed feed)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                protected void WriteAttributeExtensions (XmlWriter writer, SyndicationItem item)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                protected void WriteElementExtensions (XmlWriter writer, SyndicationPerson person)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                protected void WriteElementExtensions (XmlWriter writer, SyndicationCategory category)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                protected void WriteElementExtensions (XmlWriter writer, SyndicationFeed feed)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                protected void WriteElementExtensions (XmlWriter writer, SyndicationItem item)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                protected void WriteItems (XmlWriter writer, IEnumerable <SyndicationItem> items)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                protected internal abstract void WriteXml (XmlWriter writer, SyndicationFeed feed);
+
+                [MonoTODO]
+                protected internal abstract void WriteXml (XmlWriter writer, SyndicationItem item);
+
+                [MonoTODO]
+                public void WriteTo (XmlWriter writer, SyndicationItem item)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                public void WriteTo (XmlWriter writer, SyndicationFeed feed)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                public override string ToString ()
+                {
+                        throw new NotImplementedException ();
+                }
+
+                protected abstract string FeedName {
+                        get;
+                }
+
+                protected abstract string FeedNamespace {
+                        get;
+                }
+
+                protected abstract string ItemName {
+                        get;
+                }
+
+                protected virtual string ItemNamespace {
+                        get {throw new NotImplementedException ();}
+                }
+
+                public abstract SyndicationVersion Version {
+                        get;
+                }
+        }
+}

Property changes on: olive/class/System.ServiceModel.Web/System.ServiceModel.Syndication/SyndicationSerializer.cs
___________________________________________________________________
Name: svn:eol-style
   + native

Index: olive/class/System.ServiceModel.Web/System.ServiceModel.Syndication/SyndicationContent.cs
===================================================================
--- olive/class/System.ServiceModel.Web/System.ServiceModel.Syndication/SyndicationContent.cs	(revision 0)
+++ olive/class/System.ServiceModel.Web/System.ServiceModel.Syndication/SyndicationContent.cs	(revision 0)
@@ -0,0 +1,109 @@
+//
+// SyndicationContent.cs
+//
+// Author:
+//      Stephen A Jazdzewski (Steve@Jazd.com)
+//
+// Copyright (C) 2007 Stephen A Jazdzewski
+//
+// Permission is hereby granted, free of charge, to any person obtaining
+// a copy of this software and associated documentation files (the
+// "Software"), to deal in the Software without restriction, including
+// without limitation the rights to use, copy, modify, merge, publish,
+// distribute, sublicense, and/or sell copies of the Software, and to
+// permit persons to whom the Software is furnished to do so, subject to
+// the following conditions:
+//
+// The above copyright notice and this permission notice shall be
+// included in all copies or substantial portions of the Software.
+//
+// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
+// LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
+// OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
+// WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+//
+
+
+using System;
+using System.Xml;
+using System.Xml.Serialization;
+using System.Collections.Generic;
+using System.Runtime.Serialization;
+using System.ServiceModel.Syndication;
+
+namespace System.ServiceModel.Syndication
+{
+        [MonoTODO]
+        public abstract class SyndicationContent {
+                [MonoTODO]
+                protected SyndicationContent ()
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                public static TextSyndicationContent CreatePlaintextTextSyndicationContent (string content)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                public static TextSyndicationContent CreateHtmlTextSyndicationContent (string content)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                public static TextSyndicationContent CreateXhtmlTextSyndicationContent (string content)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                public static XmlSyndicationContent CreateXmlSyndicationContent (object dataContractObject)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                public static XmlSyndicationContent CreateXmlSyndicationContent (object dataContractObject,
+                                                                                 XmlObjectSerializer dataContractSerializer)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                public static XmlSyndicationContent CreateXmlSyndicationContent (object xmlSerializerObject,
+                                                                                 XmlSerializer serializer)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                public static XmlSyndicationContent CreateXmlSyndicationContent (XmlElement xmlElement)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                protected abstract void WriteContentsTo (XmlWriter writer);
+
+
+                [MonoTODO]
+                public void WriteTo (XmlWriter writer, string outerElementName, string outerElementNamespace)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                public Dictionary <XmlQualifiedName, string> AttributeExtensions {
+                        get {throw new NotImplementedException ();}
+                }
+
+                public abstract string Type {
+                        get;
+                }
+        }
+}

Property changes on: olive/class/System.ServiceModel.Web/System.ServiceModel.Syndication/SyndicationContent.cs
___________________________________________________________________
Name: svn:eol-style
   + native

Index: olive/class/System.ServiceModel.Web/System.ServiceModel.Syndication/SyndicationCategory.cs
===================================================================
--- olive/class/System.ServiceModel.Web/System.ServiceModel.Syndication/SyndicationCategory.cs	(revision 0)
+++ olive/class/System.ServiceModel.Web/System.ServiceModel.Syndication/SyndicationCategory.cs	(revision 0)
@@ -0,0 +1,137 @@
+//
+// SyndicationCategory.cs
+//
+// Author:
+//      Stephen A Jazdzewski (Steve@Jazd.com)
+//
+// Copyright (C) 2007 Stephen A Jazdzewski
+//
+// Permission is hereby granted, free of charge, to any person obtaining
+// a copy of this software and associated documentation files (the
+// "Software"), to deal in the Software without restriction, including
+// without limitation the rights to use, copy, modify, merge, publish,
+// distribute, sublicense, and/or sell copies of the Software, and to
+// permit persons to whom the Software is furnished to do so, subject to
+// the following conditions:
+//
+// The above copyright notice and this permission notice shall be
+// included in all copies or substantial portions of the Software.
+//
+// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
+// LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
+// OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
+// WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+//
+
+
+using System;
+using System.Xml;
+using System.Xml.Serialization;
+using System.Collections.Generic;
+using System.Collections.ObjectModel;
+using System.Runtime.Serialization;
+using System.ServiceModel.Syndication;
+
+namespace System.ServiceModel.Syndication
+{
+        [MonoTODO]
+        public class SyndicationCategory {
+                [MonoTODO]
+                public SyndicationCategory ()
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                public SyndicationCategory (string name)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                public SyndicationCategory (string name, string scheme, string label)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                public Collection <TExtension> ReadElementExtensions <TExtension> (string extensionName,
+                                                                                   string extensionNamespace)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                public Collection <TExtension> ReadElementExtensions <TExtension> (string extensionName,
+                                                                                   string extensionNamespace,
+                                                                                   XmlSerializer serializer)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                public Collection <TExtension> ReadElementExtensions <TExtension> (string extensionName,
+                                                                                   string extensionNamespace,
+                                                                                   XmlObjectSerializer serializer)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                public XmlSerializer GetReaderAtElementExtensions ()
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                protected internal virtual bool TryParseElement (XmlReader reader, SyndicationSerializer serializer)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                protected internal virtual bool TryParseAttribute (string name, string ns, string value, 
+                                                                  SyndicationSerializer serializer)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                protected internal virtual void WriteElementExtensions (XmlWriter writer, SyndicationSerializer serializer)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                protected internal virtual void WriteAttributeExtensions (XmlWriter writer, SyndicationSerializer serializer)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                public Dictionary <XmlQualifiedName, string> AttributeExtensions {
+                        get {throw new NotImplementedException ();}
+                }
+
+                public SyndicationElementExtensionCollection ElementExtensions {
+                        get {throw new NotImplementedException ();}
+                }
+
+                public string Label {
+                        get {throw new NotImplementedException ();}
+                        set {throw new NotImplementedException ();}
+                }
+
+                public string Name {
+                        get {throw new NotImplementedException ();}
+                        set {throw new NotImplementedException ();}
+                }
+
+                public string Scheme {
+                        get {throw new NotImplementedException ();}
+                        set {throw new NotImplementedException ();}
+                }
+        }
+}

Property changes on: olive/class/System.ServiceModel.Web/System.ServiceModel.Syndication/SyndicationCategory.cs
___________________________________________________________________
Name: svn:eol-style
   + native

Index: olive/class/System.ServiceModel.Web/System.ServiceModel.Syndication/ChangeLog
===================================================================
--- olive/class/System.ServiceModel.Web/System.ServiceModel.Syndication/ChangeLog	(revision 0)
+++ olive/class/System.ServiceModel.Web/System.ServiceModel.Syndication/ChangeLog	(revision 0)
@@ -0,0 +1,3 @@
+2007-05-26  Stephen Jazdzewski <Steve@Jazd.com>
+
+        * File created

Property changes on: olive/class/System.ServiceModel.Web/System.ServiceModel.Syndication/ChangeLog
___________________________________________________________________
Name: svn:eol-style
   + native

Index: olive/class/System.ServiceModel.Web/System.ServiceModel.Syndication/TextSyndicationContent.cs
===================================================================
--- olive/class/System.ServiceModel.Web/System.ServiceModel.Syndication/TextSyndicationContent.cs	(revision 0)
+++ olive/class/System.ServiceModel.Web/System.ServiceModel.Syndication/TextSyndicationContent.cs	(revision 0)
@@ -0,0 +1,65 @@
+//
+// TextSyndicationContent.cs
+//
+// Author:
+//      Stephen A Jazdzewski (Steve@Jazd.com)
+//
+// Copyright (C) 2007 Stephen A Jazdzewski
+//
+// Permission is hereby granted, free of charge, to any person obtaining
+// a copy of this software and associated documentation files (the
+// "Software"), to deal in the Software without restriction, including
+// without limitation the rights to use, copy, modify, merge, publish,
+// distribute, sublicense, and/or sell copies of the Software, and to
+// permit persons to whom the Software is furnished to do so, subject to
+// the following conditions:
+//
+// The above copyright notice and this permission notice shall be
+// included in all copies or substantial portions of the Software.
+//
+// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
+// LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
+// OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
+// WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+//
+
+
+using System;
+using System.Xml;
+using System.ServiceModel.Syndication;
+
+namespace System.ServiceModel.Syndication
+{
+        [MonoTODO]
+        public class TextSyndicationContent : SyndicationContent {
+                [MonoTODO]
+                public TextSyndicationContent(string text)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                public TextSyndicationContent (string text, TextSyndicationContentKind textKind)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                protected override void WriteContentsTo (XmlWriter writer)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                public string Text {
+                        get {throw new NotImplementedException ();}
+                }
+
+                public override string Type {
+                        get {throw new NotImplementedException ();}
+                }
+
+        }
+}

Property changes on: olive/class/System.ServiceModel.Web/System.ServiceModel.Syndication/TextSyndicationContent.cs
___________________________________________________________________
Name: svn:eol-style
   + native

Index: olive/class/System.ServiceModel.Web/System.ServiceModel.Syndication/TextSyndicationContentKind.cs
===================================================================
--- olive/class/System.ServiceModel.Web/System.ServiceModel.Syndication/TextSyndicationContentKind.cs	(revision 0)
+++ olive/class/System.ServiceModel.Web/System.ServiceModel.Syndication/TextSyndicationContentKind.cs	(revision 0)
@@ -0,0 +1,39 @@
+//
+// TextSyndicationContentKind.cs
+//
+// Author:
+//      Stephen A Jazdzewski (Steve@Jazd.com)
+//
+// Copyright (C) 2007 Stephen A Jazdzewski
+//
+// Permission is hereby granted, free of charge, to any person obtaining
+// a copy of this software and associated documentation files (the
+// "Software"), to deal in the Software without restriction, including
+// without limitation the rights to use, copy, modify, merge, publish,
+// distribute, sublicense, and/or sell copies of the Software, and to
+// permit persons to whom the Software is furnished to do so, subject to
+// the following conditions:
+//
+// The above copyright notice and this permission notice shall be
+// included in all copies or substantial portions of the Software.
+//
+// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
+// LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
+// OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
+// WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+//
+
+
+using System;
+
+namespace System.ServiceModel.Syndication
+{
+        public enum TextSyndicationContentKind {
+                Html,
+                Plaintext,
+                XHtml,
+        }
+}

Property changes on: olive/class/System.ServiceModel.Web/System.ServiceModel.Syndication/TextSyndicationContentKind.cs
___________________________________________________________________
Name: svn:eol-style
   + native

Index: olive/class/System.ServiceModel.Web/System.ServiceModel.Syndication/SyndicationVersion.cs
===================================================================
--- olive/class/System.ServiceModel.Web/System.ServiceModel.Syndication/SyndicationVersion.cs	(revision 0)
+++ olive/class/System.ServiceModel.Web/System.ServiceModel.Syndication/SyndicationVersion.cs	(revision 0)
@@ -0,0 +1,39 @@
+//
+// SyndicationVersion.cs
+//
+// Author:
+//      Stephen A Jazdzewski (Steve@Jazd.com)
+//
+// Copyright (C) 2007 Stephen A Jazdzewski
+//
+// Permission is hereby granted, free of charge, to any person obtaining
+// a copy of this software and associated documentation files (the
+// "Software"), to deal in the Software without restriction, including
+// without limitation the rights to use, copy, modify, merge, publish,
+// distribute, sublicense, and/or sell copies of the Software, and to
+// permit persons to whom the Software is furnished to do so, subject to
+// the following conditions:
+//
+// The above copyright notice and this permission notice shall be
+// included in all copies or substantial portions of the Software.
+//
+// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
+// LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
+// OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
+// WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+//
+
+
+using System;
+
+namespace System.ServiceModel.Syndication
+{
+        public enum SyndicationVersion {
+                Atom10,
+                Rss20,
+        }
+}
+                

Property changes on: olive/class/System.ServiceModel.Web/System.ServiceModel.Syndication/SyndicationVersion.cs
___________________________________________________________________
Name: svn:eol-style
   + native

Index: olive/class/System.ServiceModel.Web/System.ServiceModel.Syndication/SyndicationElementExtension.cs
===================================================================
--- olive/class/System.ServiceModel.Web/System.ServiceModel.Syndication/SyndicationElementExtension.cs	(revision 0)
+++ olive/class/System.ServiceModel.Web/System.ServiceModel.Syndication/SyndicationElementExtension.cs	(revision 0)
@@ -0,0 +1,95 @@
+//
+// SyndicationElementExtension.cs
+//
+// Author:
+//      Stephen A Jazdzewski (Steve@Jazd.com)
+//
+// Copyright (C) 2007 Stephen A Jazdzewski
+//
+// Permission is hereby granted, free of charge, to any person obtaining
+// a copy of this software and associated documentation files (the
+// "Software"), to deal in the Software without restriction, including
+// without limitation the rights to use, copy, modify, merge, publish,
+// distribute, sublicense, and/or sell copies of the Software, and to
+// permit persons to whom the Software is furnished to do so, subject to
+// the following conditions:
+//
+// The above copyright notice and this permission notice shall be
+// included in all copies or substantial portions of the Software.
+//
+// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
+// LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
+// OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
+// WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+//
+
+
+using System;
+using System.Xml;
+using System.Xml.Serialization;
+using System.Runtime.Serialization;
+using System.ServiceModel.Syndication;
+
+namespace System.ServiceModel.Syndication
+{
+        [MonoTODO]
+        public class SyndicationElementExtension {
+                [MonoTODO]
+                public SyndicationElementExtension (XmlElement element)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                public SyndicationElementExtension (object dataContractExtension)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                public SyndicationElementExtension (string outerName, string outerNamespace, object dataContractExtension)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                public SyndicationElementExtension (string outerName, string outerNamespace, object dataContractExtension,
+                                                    XmlObjectSerializer dataContractSerializer)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                public SyndicationElementExtension (object xmlSerializerExtension, XmlSerializer serializer)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                public SyndicationElementExtension (object dataContractExtension, XmlObjectSerializer dataContractSerializer)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                public void WriteTo (XmlWriter writer)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                public SyndicationElementExtensionKind ExtensionKind {
+                        get {throw new NotImplementedException ();}
+                }
+
+                public object Object {
+                        get {throw new NotImplementedException ();}
+                }
+
+                public object ObjectSerializer {
+                        get {throw new NotImplementedException ();}
+                }
+        }
+}

Property changes on: olive/class/System.ServiceModel.Web/System.ServiceModel.Syndication/SyndicationElementExtension.cs
___________________________________________________________________
Name: svn:eol-style
   + native

Index: olive/class/System.ServiceModel.Web/System.ServiceModel.Syndication/Atom10Serializer.cs
===================================================================
--- olive/class/System.ServiceModel.Web/System.ServiceModel.Syndication/Atom10Serializer.cs	(revision 0)
+++ olive/class/System.ServiceModel.Web/System.ServiceModel.Syndication/Atom10Serializer.cs	(revision 0)
@@ -0,0 +1,91 @@
+//
+// Atom10Serializer.cs
+//
+// Author:
+//      Stephen A Jazdzewski (Steve@Jazd.com)
+//
+// Copyright (C) 2007 Stephen A Jazdzewski
+//
+// Permission is hereby granted, free of charge, to any person obtaining
+// a copy of this software and associated documentation files (the
+// "Software"), to deal in the Software without restriction, including
+// without limitation the rights to use, copy, modify, merge, publish,
+// distribute, sublicense, and/or sell copies of the Software, and to
+// permit persons to whom the Software is furnished to do so, subject to
+// the following conditions:
+//
+// The above copyright notice and this permission notice shall be
+// included in all copies or substantial portions of the Software.
+//
+// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
+// LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
+// OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
+// WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+//
+
+
+using System;
+using System.Xml;
+using System.ServiceModel.Syndication;
+
+namespace System.ServiceModel.Syndication
+{
+        [MonoTODO]
+        public class Atom10Serializer : SyndicationSerializer {
+                [MonoTODO]
+                public Atom10Serializer ()
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                public Atom10Serializer (int maxExtensionSize, bool preserveElementExtensions, bool preserveAttributeExtensons)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                protected override void ReadXml(XmlReader reader, SyndicationItem item)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                protected override void ReadXml(XmlReader reader, SyndicationFeed feed)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                protected internal override void WriteXml(XmlWriter writer, SyndicationItem item)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                protected internal override void WriteXml(XmlWriter writer, SyndicationFeed feed)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                protected override string FeedName {
+                        get {throw new NotImplementedException ();}
+                }
+
+                protected override string FeedNamespace {
+                        get {throw new NotImplementedException ();}
+                }
+
+                protected override string ItemName {
+                        get {throw new NotImplementedException ();}
+                }
+
+                public override SyndicationVersion Version {
+                        get {throw new NotImplementedException ();}
+                }
+
+        }
+}

Property changes on: olive/class/System.ServiceModel.Web/System.ServiceModel.Syndication/Atom10Serializer.cs
___________________________________________________________________
Name: svn:eol-style
   + native

Index: olive/class/System.ServiceModel.Web/System.ServiceModel.Syndication/XmlSyndicationContent.cs
===================================================================
--- olive/class/System.ServiceModel.Web/System.ServiceModel.Syndication/XmlSyndicationContent.cs	(revision 0)
+++ olive/class/System.ServiceModel.Web/System.ServiceModel.Syndication/XmlSyndicationContent.cs	(revision 0)
@@ -0,0 +1,111 @@
+//
+// XmlSyndicationContent.cs
+//
+// Author:
+//      Stephen A Jazdzewski (Steve@Jazd.com)
+//
+// Copyright (C) 2007 Stephen A Jazdzewski
+//
+// Permission is hereby granted, free of charge, to any person obtaining
+// a copy of this software and associated documentation files (the
+// "Software"), to deal in the Software without restriction, including
+// without limitation the rights to use, copy, modify, merge, publish,
+// distribute, sublicense, and/or sell copies of the Software, and to
+// permit persons to whom the Software is furnished to do so, subject to
+// the following conditions:
+//
+// The above copyright notice and this permission notice shall be
+// included in all copies or substantial portions of the Software.
+//
+// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
+// LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
+// OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
+// WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+//
+
+
+
+
+using System;
+using System.Xml;
+using System.Xml.Serialization;
+using System.Runtime.Serialization;
+using System.ServiceModel.Syndication;
+
+namespace System.ServiceModel.Syndication
+{
+        [MonoTODO]
+        public class XmlSyndicationContent : SyndicationContent {
+                [MonoTODO]
+                public XmlSyndicationContent (string type, XmlElement element)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                public XmlSyndicationContent (string type, SyndicationElementExtension extension)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                public XmlSyndicationContent (string type, object xmlSerializerExtension, XmlSerializer serializer)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                public XmlSyndicationContent (string type, object dataContractExtension, XmlObjectSerializer dateContractSerializer)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                public XmlSyndicationContent (XmlReader reader, int maxContentSize)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                public XmlDictionaryReader GetReaderAtContent()
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                public TContent ReadContent <TContent> ()
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                public TContent ReadContent <TContent> (XmlSerializer serializer)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                public TContent ReadContent <TContent> (XmlObjectSerializer dataContractSerializer)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                protected override void WriteContentsTo (XmlWriter writer)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                public SyndicationElementExtension Extension {
+                        get {throw new NotImplementedException ();}
+                }
+
+                public override string Type {
+                        get {throw new NotImplementedException ();}
+                }
+        }
+}

Property changes on: olive/class/System.ServiceModel.Web/System.ServiceModel.Syndication/XmlSyndicationContent.cs
___________________________________________________________________
Name: svn:eol-style
   + native

Index: olive/class/System.ServiceModel.Web/System.ServiceModel.Syndication/SyndicationElementExtensionKind.cs
===================================================================
--- olive/class/System.ServiceModel.Web/System.ServiceModel.Syndication/SyndicationElementExtensionKind.cs	(revision 0)
+++ olive/class/System.ServiceModel.Web/System.ServiceModel.Syndication/SyndicationElementExtensionKind.cs	(revision 0)
@@ -0,0 +1,41 @@
+//
+// SyndicationElementExtensionKind.cs
+//
+// Author:
+//      Stephen A Jazdzewski (Steve@Jazd.com)
+//
+// Copyright (C) 2007 Stephen A Jazdzewski
+//
+// Permission is hereby granted, free of charge, to any person obtaining
+// a copy of this software and associated documentation files (the
+// "Software"), to deal in the Software without restriction, including
+// without limitation the rights to use, copy, modify, merge, publish,
+// distribute, sublicense, and/or sell copies of the Software, and to
+// permit persons to whom the Software is furnished to do so, subject to
+// the following conditions:
+//
+// The above copyright notice and this permission notice shall be
+// included in all copies or substantial portions of the Software.
+//
+// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
+// LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
+// OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
+// WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+//
+
+
+
+
+using System;
+
+namespace System.ServiceModel.Syndication
+{
+        public enum SyndicationElementExtensionKind {
+                DataContract,
+                XmlElement,
+                XmlSerializer,
+        }
+}

Property changes on: olive/class/System.ServiceModel.Web/System.ServiceModel.Syndication/SyndicationElementExtensionKind.cs
___________________________________________________________________
Name: svn:eol-style
   + native

Index: olive/class/System.ServiceModel.Web/System.ServiceModel.Syndication/SyndicationLink.cs
===================================================================
--- olive/class/System.ServiceModel.Web/System.ServiceModel.Syndication/SyndicationLink.cs	(revision 0)
+++ olive/class/System.ServiceModel.Web/System.ServiceModel.Syndication/SyndicationLink.cs	(revision 0)
@@ -0,0 +1,110 @@
+//
+// SyndicationLink.cs
+//
+// Author:
+//      Stephen A Jazdzewski (Steve@Jazd.com)
+//
+// Copyright (C) 2007 Stephen A Jazdzewski
+//
+// Permission is hereby granted, free of charge, to any person obtaining
+// a copy of this software and associated documentation files (the
+// "Software"), to deal in the Software without restriction, including
+// without limitation the rights to use, copy, modify, merge, publish,
+// distribute, sublicense, and/or sell copies of the Software, and to
+// permit persons to whom the Software is furnished to do so, subject to
+// the following conditions:
+//
+// The above copyright notice and this permission notice shall be
+// included in all copies or substantial portions of the Software.
+//
+// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
+// LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
+// OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
+// WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+//
+
+
+using System;
+using System.Xml;
+using System.Collections.Generic;
+using System.ServiceModel.Syndication;
+
+namespace System.ServiceModel.Syndication
+{
+        [MonoTODO]
+        public class SyndicationLink {
+                [MonoTODO]
+                public SyndicationLink (Uri uri)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                public SyndicationLink (Uri uri, string relationshipType, string title, string mediaType, long length)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                public static SyndicationLink CreateAlternateLink (Uri uri)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                public static SyndicationLink CreateAlternateLink (Uri uri, string mediaType)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                public static SyndicationLink CreateMediaEnclosureLink (Uri uri, string mediaType, long length)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                public static SyndicationLink CreateSelfLink (Uri uri)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                public static SyndicationLink CreateSelfLink (Uri urk, string mediaType)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                public Dictionary <XmlQualifiedName, string> AttributeExtensions {
+                        get {throw new NotImplementedException ();}
+                }
+
+                public long Length {
+                        get {throw new NotImplementedException ();}
+                        set {throw new NotImplementedException ();}
+                }
+
+                public string MediaType {
+                        get {throw new NotImplementedException ();}
+                        set {throw new NotImplementedException ();}
+                }
+
+                public string RelationshipType {
+                        get {throw new NotImplementedException ();}
+                        set {throw new NotImplementedException ();}
+                }
+
+                public string Title {
+                        get {throw new NotImplementedException ();}
+                        set {throw new NotImplementedException ();}
+                }
+
+                public Uri Uri {
+                        get {throw new NotImplementedException ();}
+                        set {throw new NotImplementedException ();}
+                }
+        }
+}

Property changes on: olive/class/System.ServiceModel.Web/System.ServiceModel.Syndication/SyndicationLink.cs
___________________________________________________________________
Name: svn:eol-style
   + native

Index: olive/class/System.ServiceModel.Web/System.ServiceModel.Syndication/UrlSyndicationContent.cs
===================================================================
--- olive/class/System.ServiceModel.Web/System.ServiceModel.Syndication/UrlSyndicationContent.cs	(revision 0)
+++ olive/class/System.ServiceModel.Web/System.ServiceModel.Syndication/UrlSyndicationContent.cs	(revision 0)
@@ -0,0 +1,58 @@
+//
+// UrlSyndicationContent.cs
+//
+// Author:
+//      Stephen A Jazdzewski (Steve@Jazd.com)
+//
+// Copyright (C) 2007 Stephen A Jazdzewski
+//
+// Permission is hereby granted, free of charge, to any person obtaining
+// a copy of this software and associated documentation files (the
+// "Software"), to deal in the Software without restriction, including
+// without limitation the rights to use, copy, modify, merge, publish,
+// distribute, sublicense, and/or sell copies of the Software, and to
+// permit persons to whom the Software is furnished to do so, subject to
+// the following conditions:
+//
+// The above copyright notice and this permission notice shall be
+// included in all copies or substantial portions of the Software.
+//
+// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
+// LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
+// OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
+// WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+//
+
+
+using System;
+using System.Xml;
+using System.ServiceModel.Syndication;
+
+namespace System.ServiceModel.Syndication
+{
+        [MonoTODO]
+        public class UrlSyndicationContent : SyndicationContent {
+                [MonoTODO]
+                public UrlSyndicationContent (Uri uri, string mediaType)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                protected override void WriteContentsTo (XmlWriter writer)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                public override string Type {
+                        get {throw new NotImplementedException ();}
+                }
+
+                public Uri Url {
+                        get {throw new NotImplementedException ();}
+                }
+        }
+}

Property changes on: olive/class/System.ServiceModel.Web/System.ServiceModel.Syndication/UrlSyndicationContent.cs
___________________________________________________________________
Name: svn:eol-style
   + native

Index: olive/class/System.ServiceModel.Web/System.ServiceModel.Syndication/SyndicationItem.cs
===================================================================
--- olive/class/System.ServiceModel.Web/System.ServiceModel.Syndication/SyndicationItem.cs	(revision 0)
+++ olive/class/System.ServiceModel.Web/System.ServiceModel.Syndication/SyndicationItem.cs	(revision 0)
@@ -0,0 +1,254 @@
+//
+// SyndicationItem.cs
+//
+// Author:
+//      Stephen A Jazdzewski (Steve@Jazd.com)
+//
+// Copyright (C) 2007 Stephen A Jazdzewski
+//
+// Permission is hereby granted, free of charge, to any person obtaining
+// a copy of this software and associated documentation files (the
+// "Software"), to deal in the Software without restriction, including
+// without limitation the rights to use, copy, modify, merge, publish,
+// distribute, sublicense, and/or sell copies of the Software, and to
+// permit persons to whom the Software is furnished to do so, subject to
+// the following conditions:
+//
+// The above copyright notice and this permission notice shall be
+// included in all copies or substantial portions of the Software.
+//
+// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
+// LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
+// OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
+// WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+//
+
+using System;
+using System.Xml;
+using System.Xml.Serialization;
+using System.Collections.Generic;
+using System.Collections.ObjectModel;
+using System.Runtime.Serialization;
+using System.ServiceModel.Syndication;
+
+namespace System.ServiceModel.Syndication
+{
+        [MonoTODO]
+        public class SyndicationItem {
+                [MonoTODO]
+                public SyndicationItem ()
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                public SyndicationItem (IEnumerable <SyndicationItem> items)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                public SyndicationItem (string title, string description, Uri feedAlternateLink)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                public SyndicationItem (string title, string description, Uri feedAlternateLink, string id, DateTime lastUpdateTime)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                public SyndicationItem (string title, string description, Uri feedAlternateLink, IEnumerable<SyndicationItem> items)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                public SyndicationItem (string title, string description, Uri feedAlternateLink, string id, DateTime lastUpdateTime,
+                                        IEnumerable<SyndicationItem> items)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                protected internal virtual SyndicationPerson CreatePerson ()
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                protected internal virtual SyndicationCategory CreateCategory ()
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                public XmlReader GetReaderAtElementExtensions ()
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                public void Load (XmlReader xmlreader, params SyndicationSerializer[] serializers)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                public void Load (Uri uri, params SyndicationSerializer[] serializers)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                public void Load (Uri uri, XmlReaderSettings readerSettings, params SyndicationSerializer[] serializers)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                public Collection <TExtension> ReadElementExtensions <TExtension> (string extensionName, string extensionNamespace)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                public Collection <TExtension> ReadElementExtensions <TExtension> (string extensionName, string extensionNamespace,
+                                                                                   XmlSerializer serializer)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                public Collection <TExtension> ReadElementExtensions <TExtension> (string extensionName, string extensionNamespace,
+                                                                                   XmlObjectSerializer serializer)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                protected internal virtual bool TryParseContent (XmlReader reader, string contentType,
+                                                                 SyndicationSerializer serializer,
+                                                                 out SyndicationContent content
+                                                                 )
+                {
+                        throw new NotImplementedException ();
+                }
+
+
+                [MonoTODO]
+                protected internal virtual bool TryParseAttribute (string name, string ns, string value,
+                                                                   SyndicationSerializer serializer)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                protected internal virtual bool TryParseElement (XmlReader reader, SyndicationSerializer serializer)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                protected internal virtual void WriteElementExtensions (XmlWriter writer, SyndicationSerializer serializer)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                protected internal virtual void WriteAttributeExtensions (XmlWriter writer, SyndicationSerializer serializer)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                protected void WriteContentsTo (XmlWriter writer, SyndicationSerializer serializer)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                public void WriteTo (XmlWriter writer, SyndicationSerializer serializer)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                public string Id {
+                        get {throw new NotImplementedException ();}
+                        set {throw new NotImplementedException ();}
+                }
+
+                public Dictionary <XmlQualifiedName, string> AttributeExtensions {
+                        get {throw new NotImplementedException ();}
+                }
+
+                public SyndicationElementExtensionCollection ElementExtensions {
+                        get {throw new NotImplementedException ();}
+                }
+
+                public TextSyndicationContent Title {
+                        get {throw new NotImplementedException ();}
+                        set {throw new NotImplementedException ();}
+                }
+
+                public Uri ImageUrl {
+                        get {throw new NotImplementedException ();}
+                        set {throw new NotImplementedException ();}
+                }
+
+                public Collection <SyndicationLink> Links {
+                        get {throw new NotImplementedException ();}
+                }
+
+                public Collection <SyndicationPerson> Authors {
+                        get {throw new NotImplementedException ();}
+                }
+
+                public TextSyndicationContent Description {
+                        get {throw new NotImplementedException ();}
+                        set {throw new NotImplementedException ();}
+                }
+
+                public string Language {
+                        get {throw new NotImplementedException ();}
+                        set {throw new NotImplementedException ();}
+                }
+
+                public TextSyndicationContent Copyright {
+                        get {throw new NotImplementedException ();}
+                        set {throw new NotImplementedException ();}
+                }
+
+                public DateTime PublishDate {
+                        get {throw new NotImplementedException ();}
+                        set {throw new NotImplementedException ();}
+                }
+
+                public Collection <SyndicationPerson> Contributors {
+                        get {throw new NotImplementedException ();}
+                }
+
+                public Collection <SyndicationCategory> Categories {
+                        get {throw new NotImplementedException ();}
+                }
+
+                public string Generator {
+                        get {throw new NotImplementedException ();}
+                        set {throw new NotImplementedException ();}
+                }
+
+                public Collection <SyndicationItem> Items {
+                        get {throw new NotImplementedException ();}
+                }
+
+                public DateTime LastUpdatedTime {
+                        get {throw new NotImplementedException ();}
+                        set {throw new NotImplementedException ();}
+                }
+        }
+}

Property changes on: olive/class/System.ServiceModel.Web/System.ServiceModel.Syndication/SyndicationItem.cs
___________________________________________________________________
Name: svn:eol-style
   + native

Index: olive/class/System.ServiceModel.Web/System.ServiceModel.Syndication/Rss20Serializer.cs
===================================================================
--- olive/class/System.ServiceModel.Web/System.ServiceModel.Syndication/Rss20Serializer.cs	(revision 0)
+++ olive/class/System.ServiceModel.Web/System.ServiceModel.Syndication/Rss20Serializer.cs	(revision 0)
@@ -0,0 +1,94 @@
+//
+// Rss20Serializer.cs
+//
+// Author:
+//      Stephen A Jazdzewski (Steve@Jazd.com)
+//
+// Copyright (C) 2007 Stephen A Jazdzewski
+//
+// Permission is hereby granted, free of charge, to any person obtaining
+// a copy of this software and associated documentation files (the
+// "Software"), to deal in the Software without restriction, including
+// without limitation the rights to use, copy, modify, merge, publish,
+// distribute, sublicense, and/or sell copies of the Software, and to
+// permit persons to whom the Software is furnished to do so, subject to
+// the following conditions:
+//
+// The above copyright notice and this permission notice shall be
+// included in all copies or substantial portions of the Software.
+//
+// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
+// LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
+// OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
+// WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+//
+
+
+using System;
+using System.Xml;
+using System.ServiceModel.Syndication;
+
+namespace System.ServiceModel.Syndication
+{
+        [MonoTODO]
+        public class Rss20Serializer : SyndicationSerializer {
+                [MonoTODO]
+                public Rss20Serializer ()
+                {
+                        throw new NotImplementedException ();
+                }
+                
+                [MonoTODO]
+                public Rss20Serializer (bool serializeExtensionsAsAtom,
+                                       bool preserveAttributeExtensons,
+                                       bool preserveElementExtensions,
+                                       int maxExtensionSize)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                protected override void ReadXml(XmlReader reader, SyndicationItem item)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                protected override void ReadXml(XmlReader reader, SyndicationFeed feed)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                protected internal override void WriteXml(XmlWriter writer, SyndicationItem item)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                protected internal override void WriteXml(XmlWriter writer, SyndicationFeed feed)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                protected override string FeedName {
+                        get {throw new NotImplementedException ();}
+                }
+
+                protected override string FeedNamespace {
+                        get {throw new NotImplementedException ();}
+                }
+
+                protected override string ItemName {
+                        get {throw new NotImplementedException ();}
+                }
+
+                public override SyndicationVersion Version {
+                        get {throw new NotImplementedException ();}
+                }
+
+        }
+}

Property changes on: olive/class/System.ServiceModel.Web/System.ServiceModel.Syndication/Rss20Serializer.cs
___________________________________________________________________
Name: svn:eol-style
   + native

Index: olive/class/System.ServiceModel.Web/System.ServiceModel.Syndication/SyndicationElementExtensionCollection.cs
===================================================================
--- olive/class/System.ServiceModel.Web/System.ServiceModel.Syndication/SyndicationElementExtensionCollection.cs	(revision 0)
+++ olive/class/System.ServiceModel.Web/System.ServiceModel.Syndication/SyndicationElementExtensionCollection.cs	(revision 0)
@@ -0,0 +1,90 @@
+//
+// SyndicationElementExtensionCollection.cs
+//
+// Author:
+//      Stephen A Jazdzewski (Steve@Jazd.com)
+//
+// Copyright (C) 2007 Stephen A Jazdzewski
+//
+// Permission is hereby granted, free of charge, to any person obtaining
+// a copy of this software and associated documentation files (the
+// "Software"), to deal in the Software without restriction, including
+// without limitation the rights to use, copy, modify, merge, publish,
+// distribute, sublicense, and/or sell copies of the Software, and to
+// permit persons to whom the Software is furnished to do so, subject to
+// the following conditions:
+//
+// The above copyright notice and this permission notice shall be
+// included in all copies or substantial portions of the Software.
+//
+// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
+// LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
+// OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
+// WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+//
+
+
+using System;
+using System.Xml;
+using System.Xml.Serialization;
+using System.Runtime.Serialization;
+using System.Collections.ObjectModel;
+using System.ServiceModel.Syndication;
+
+namespace System.ServiceModel.Syndication
+{
+        [MonoTODO]
+        public class SyndicationElementExtensionCollection : Collection <SyndicationElementExtension> {
+                [MonoTODO]
+                public void Add (XmlElement xmlElemnt)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                public void Add (object extension)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                public void Add (object xmlSerializerExtention, XmlSerializer serializer)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                public void Add (string outerName, string outerNamespace, object dataContractExtension)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                public void Add (string outerName, string outerNamespace, object dataContractExtension,
+                                 XmlObjectSerializer dataContractSerializer)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                public void Add (object dataContractExtension, DataContractSerializer serializer)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                protected override void InsertItem (int index, SyndicationElementExtension item)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                protected override void SetItem (int index, SyndicationElementExtension item)
+                {
+                        throw new NotImplementedException ();
+                }
+        }
+}

Property changes on: olive/class/System.ServiceModel.Web/System.ServiceModel.Syndication/SyndicationElementExtensionCollection.cs
___________________________________________________________________
Name: svn:eol-style
   + native

Index: olive/class/System.ServiceModel.Web/System.ServiceModel.Syndication/SyndicationFeed.cs
===================================================================
--- olive/class/System.ServiceModel.Web/System.ServiceModel.Syndication/SyndicationFeed.cs	(revision 0)
+++ olive/class/System.ServiceModel.Web/System.ServiceModel.Syndication/SyndicationFeed.cs	(revision 0)
@@ -0,0 +1,246 @@
+//
+// SyndicationFeed.cs
+//
+// Author:
+//      Stephen A Jazdzewski (Steve@Jazd.com)
+//
+// Copyright (C) 2007 Stephen A Jazdzewski
+//
+// Permission is hereby granted, free of charge, to any person obtaining
+// a copy of this software and associated documentation files (the
+// "Software"), to deal in the Software without restriction, including
+// without limitation the rights to use, copy, modify, merge, publish,
+// distribute, sublicense, and/or sell copies of the Software, and to
+// permit persons to whom the Software is furnished to do so, subject to
+// the following conditions:
+//
+// The above copyright notice and this permission notice shall be
+// included in all copies or substantial portions of the Software.
+//
+// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
+// LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
+// OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
+// WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+//
+
+
+using System;
+using System.Xml;
+using System.Xml.Serialization;
+using System.Collections.Generic;
+using System.Collections.ObjectModel;
+using System.Runtime.Serialization;
+using System.ServiceModel.Syndication;
+
+namespace System.ServiceModel.Syndication
+{
+        [MonoTODO]
+        public class SyndicationFeed {
+                [MonoTODO]
+                public SyndicationFeed ()
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                public SyndicationFeed (IEnumerable <SyndicationItem> items)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                public SyndicationFeed (string title, string description, Uri feedAlternateLink)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                public SyndicationFeed (string title, string description, Uri feedAlternateLink, string id, DateTime lastUpdateTime)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                public SyndicationFeed (string title, string description, Uri feedAlternateLink, IEnumerable<SyndicationItem> items)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                public SyndicationFeed (string title, string description, Uri feedAlternateLink, string id, DateTime lastUpdateTime,
+                                        IEnumerable<SyndicationItem> items)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                protected internal virtual SyndicationPerson CreatePerson ()
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                protected internal virtual SyndicationCategory CreateCategory ()
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                protected internal virtual SyndicationItem CreateItem ()
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                public XmlReader GetReaderAtElementExtensions ()
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                public void Load (XmlReader xmlreader, params SyndicationSerializer[] serializers)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                public void Load (Uri uri, params SyndicationSerializer[] serializers)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                public void Load (Uri uri, XmlReaderSettings readerSettings, params SyndicationSerializer[] serializers)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                public Collection <TExtension> ReadElementExtensions <TExtension> (string extensionName, string extensionNamespace)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                public Collection <TExtension> ReadElementExtensions <TExtension> (string extensionName, string extensionNamespace,
+                                                                                   XmlSerializer serializer)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                public Collection <TExtension> ReadElementExtensions <TExtension> (string extensionName, string extensionNamespace,
+                                                                                   XmlObjectSerializer serializer)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                protected internal virtual bool TryParseAttribute (string name, string ns, string value,
+                                                                   SyndicationSerializer serializer)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                protected internal virtual bool TryParseElement (XmlReader reader, SyndicationSerializer serializer)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                protected internal virtual void WriteElementExtensions (XmlWriter writer, SyndicationSerializer serializer)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                protected internal virtual void WriteAttributeExtensions (XmlWriter writer, SyndicationSerializer serializer)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                protected void WriteContentsTo (XmlWriter writer, SyndicationSerializer serializer)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                [MonoTODO]
+                public void WriteTo (XmlWriter writer, SyndicationSerializer serializer)
+                {
+                        throw new NotImplementedException ();
+                }
+
+                public string Id {
+                        get {throw new NotImplementedException ();}
+                        set {throw new NotImplementedException ();}
+                }
+
+                public Dictionary <XmlQualifiedName, string> AttributeExtensions {
+                        get {throw new NotImplementedException ();}
+                }
+
+                public SyndicationElementExtensionCollection ElementExtensions {
+                        get {throw new NotImplementedException ();}
+                }
+
+                public TextSyndicationContent Title {
+                        get {throw new NotImplementedException ();}
+                        set {throw new NotImplementedException ();}
+                }
+
+                public Uri ImageUrl {
+                        get {throw new NotImplementedException ();}
+                        set {throw new NotImplementedException ();}
+                }
+
+                public Collection <SyndicationLink> Links {
+                        get {throw new NotImplementedException ();}
+                }
+
+                public Collection <SyndicationPerson> Authors {
+                        get {throw new NotImplementedException ();}
+                }
+
+                public TextSyndicationContent Description {
+                        get {throw new NotImplementedException ();}
+                        set {throw new NotImplementedException ();}
+                }
+
+                public string Language {
+                        get {throw new NotImplementedException ();}
+                        set {throw new NotImplementedException ();}
+                }
+
+                public TextSyndicationContent Copyright {
+                        get {throw new NotImplementedException ();}
+                        set {throw new NotImplementedException ();}
+                }
+
+                public Collection <SyndicationPerson> Contributors {
+                        get {throw new NotImplementedException ();}
+                }
+
+                public Collection <SyndicationCategory> Categories {
+                        get {throw new NotImplementedException ();}
+                }
+
+                public string Generator {
+                        get {throw new NotImplementedException ();}
+                        set {throw new NotImplementedException ();}
+                }
+
+                public Collection <SyndicationItem> Items {
+                        get {throw new NotImplementedException ();}
+                }
+
+                public DateTime LastUpdatedTime {
+                        get {throw new NotImplementedException ();}
+                        set {throw new NotImplementedException ();}
+                }
+        }
+}

Property changes on: olive/class/System.ServiceModel.Web/System.ServiceModel.Syndication/SyndicationFeed.cs
___________________________________________________________________
Name: svn:eol-style
   + native

Index: olive/class/System.ServiceModel.Web/System.ServiceModel.Web.dll.sources
===================================================================
--- olive/class/System.ServiceModel.Web/System.ServiceModel.Web.dll.sources	(revision 0)
+++ olive/class/System.ServiceModel.Web/System.ServiceModel.Web.dll.sources	(revision 0)
@@ -0,0 +1,21 @@
+../../build/common/Consts.cs
+../../build/common/Locale.cs
+../../build/common/MonoTODOAttribute.cs
+Assembly/AssemblyInfo.cs
+System.ServiceModel.Syndication/SyndicationElementExtensionCollection.cs
+System.ServiceModel.Syndication/SyndicationContent.cs
+System.ServiceModel.Syndication/Atom10Serializer.cs
+System.ServiceModel.Syndication/SyndicationCategory.cs
+System.ServiceModel.Syndication/XmlSyndicationContent.cs
+System.ServiceModel.Syndication/SyndicationItem.cs
+System.ServiceModel.Syndication/TextSyndicationContent.cs
+System.ServiceModel.Syndication/SyndicationSerializer.cs
+System.ServiceModel.Syndication/SyndicationPerson.cs
+System.ServiceModel.Syndication/SyndicationElementExtensionKind.cs
+System.ServiceModel.Syndication/SyndicationElementExtension.cs
+System.ServiceModel.Syndication/SyndicationFeed.cs
+System.ServiceModel.Syndication/TextSyndicationContentKind.cs
+System.ServiceModel.Syndication/Rss20Serializer.cs
+System.ServiceModel.Syndication/UrlSyndicationContent.cs
+System.ServiceModel.Syndication/SyndicationVersion.cs
+System.ServiceModel.Syndication/SyndicationLink.cs

Property changes on: olive/class/System.ServiceModel.Web/System.ServiceModel.Web.dll.sources
___________________________________________________________________
Name: svn:executable
   + *
Name: svn:eol-style
   + native

Index: olive/class/System.ServiceModel.Web/Makefile
===================================================================
--- olive/class/System.ServiceModel.Web/Makefile	(revision 0)
+++ olive/class/System.ServiceModel.Web/Makefile	(revision 0)
@@ -0,0 +1,29 @@
+thisdir = class/System.ServiceModel.Web
+SUBDIRS = 
+include ../../build/rules.make
+
+RESOURCE_FILES = 
+
+LIBRARY = System.ServiceModel.Web.dll
+LIB_MCS_FLAGS = \
+		/unsafe \
+	        /r:System.dll \
+	        /r:System.Xml.dll \
+		/r:../lib/net_3_0/System.Runtime.Serialization.dll \
+		$(RESOURCE_FILES:%=/resource:%)
+
+TEST_MCS_FLAGS = $(LIB_MCS_FLAGS)
+
+EXTRA_DISTFILES = $(RESOURCE_FILES)
+
+# This is a WinFX only assembly
+VALID_PROFILE := $(filter net_3_0, $(PROFILE))
+ifndef VALID_PROFILE
+LIBRARY_NAME = dummy-System.ServiceModel.Web.dll
+NO_INSTALL = yes
+NO_SIGN_ASSEMBLY = yes
+NO_TEST = yes
+endif
+
+
+include ../../build/library.make

Property changes on: olive/class/System.ServiceModel.Web/Makefile
___________________________________________________________________
Name: svn:executable
   + *
Name: svn:eol-style
   + native

