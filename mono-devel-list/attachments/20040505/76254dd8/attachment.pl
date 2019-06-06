// // System.Web.UI.Html32TextWriter.cs//// Author://   Matthijs ter Woord [meddochat] (meddochat@zonnet.nl)//// Copyright (C) Matthijs ter Woord, 2004//
using System;
using System.Collections;
using System.IO;
using System.Web.UI;

namespace System.Web.UI
{
	/// <summary>
	///   <para>
	///     Provides a text writer for ASP.NET pages and server controls that 
	///     render content to HTML 3.2 clients.
	///   </para>
	/// </summary>
	/// <remarks>
	///   <para>
  ///     This class is an alternative to <see cref="HtmlTextWriter"/>. It converts 
  ///     HTML 4.0 style attributes into the equivalent tags and attributes compatible 
  ///     with HTML 3.2. It standardizes the propagation of attributes, like 
  ///     colors and fonts, using HTML tables, which can vary in behavior in 
  ///     earlier browsers. The ASP.NET Web Forms automatically uses this class for HTML 
  ///     3.2 and earlier browsers by checking the TagWriter property of the 
  ///     <see cref="HttpBrowserCapabilities"/> class. Normally, you do not need to 
  ///     instantiate this class explicitly.
	///   </para>
	/// </remarks>
  [MonoTODO]
	public class Html32TextWriter: HtmlTextWriter	{
    /// <summary>
    ///   <para>
    ///     Initializes a new instance of the <see cref="Html32TextWriter"/> class 
    ///     that uses the <see cref="HtmlTextWriter.DefaultTabString"/> constant 
    ///     when indentation of a line is necessary.
    ///   </para>
    /// </summary>
    /// <param name="writer">
    ///   <para>
    ///     The <see cref="TextWriter"/> object to render the HMTL content.
    ///   </para>
    /// </param>
    /// <overloads>
    ///   <para>
    ///     Initializes a new instance of the <see cref="Html32TextWriter"/> class.
    ///   </para>
    /// </overloads>
    public Html32TextWriter(TextWriter writer):base(writer)
    {
    }

    /// <summary>
    ///   <para>
    ///     Initializes a new instance of the <see cref="Html32TextWriter"/> class 
    ///     using the specified tab spacing.
    ///   </para>
    /// </summary>
    /// <param name="writer">
    ///   <para>
    ///     The <see cref="TextWriter"/> object to render the HMTL content.
    ///   </para>
    /// </param>
    /// <param name="tabString">
    ///   <para>
    ///     A String that represents the number of spaces defined in the 
    ///     <see cref="Indent"/> property.
    ///   </para>
    /// </param>
    public Html32TextWriter(TextWriter writer, string tabString):base(writer, tabString)
    {
    }

    /// <summary>
    ///   <para>
    ///     Obtains the HTML element associated with the specified 
    ///     <see cref="HtmlTextWriterTag"/> enumeration value.
    ///   </para>
    /// </summary>
    /// <param name="tagKey">
    ///   <para>
    ///     The HtmlTextWriterTag value to obtain the HTML element for.
    ///   </para>
    /// </param>
    /// <returns>
    ///   <para>
    ///     The HTML element.
    ///   </para>
    /// </returns>
    /// <remarks>
    ///   <para>
    ///     If <see cref="HtmlTextWriterTag.Div"/> is passed in the tagKey 
    ///     parameter, this method returns the HTML table element.
    ///   </para>
    /// </remarks>
    protected override string GetTagName(HtmlTextWriterTag tagKey)
    {
      switch(tagKey)
      {
        case HtmlTextWriterTag.Unknown:
        {
          return "";
        }
        case HtmlTextWriterTag.A:
        {
          return "a";
        }
        case HtmlTextWriterTag.Acronym:
        {
          return "acronym";
        }
        case HtmlTextWriterTag.Address:
        {
          return "address";
        }
        case HtmlTextWriterTag.Area:
        {
          return "area";
        }
        case HtmlTextWriterTag.B:
        {
          return "b";
        }
        case HtmlTextWriterTag.Base:
        {
          return "base";
        }
        case HtmlTextWriterTag.Basefont:
        {
          return "basefont";
        }
        case HtmlTextWriterTag.Bdo:
        {
          return "bdo";
        }
        case HtmlTextWriterTag.Bgsound:
        {
          return "bgsound";
        }
        case HtmlTextWriterTag.Big:
        {
          return "big";
        }
        case HtmlTextWriterTag.Blockquote:
        {
          return "blockquote";
        }
        case HtmlTextWriterTag.Body:
        {
          return "body";
        }
        case HtmlTextWriterTag.Br:
        {
          return "br";
        }
        case HtmlTextWriterTag.Button:
        {
          return "button";
        }
        case HtmlTextWriterTag.Caption:
        {
          return "caption";
        }
        case HtmlTextWriterTag.Center:
        {
          return "center";
        }
        case HtmlTextWriterTag.Cite:
        {
          return "cite";
        }
        case HtmlTextWriterTag.Code:
        {
          return "code";
        }
        case HtmlTextWriterTag.Col:
        {
          return "col";
        }
        case HtmlTextWriterTag.Colgroup:
        {
          return "colgroup";
        }
        case HtmlTextWriterTag.Dd:
        {
          return "dd";
        }
        case HtmlTextWriterTag.Del:
        {
          return "del";
        }
        case HtmlTextWriterTag.Dfn:
        {
          return "dfn";
        }
        case HtmlTextWriterTag.Dir:
        {
          return "dir";
        }
        case HtmlTextWriterTag.Div:
        {
          return "table";
        }
        case HtmlTextWriterTag.Dl:
        {
          return "dl";
        }
        case HtmlTextWriterTag.Dt:
        {
          return "dt";
        }
        case HtmlTextWriterTag.Em:
        {
          return "em";
        }
        case HtmlTextWriterTag.Embed:
        {
          return "embed";
        }
        case HtmlTextWriterTag.Fieldset:
        {
          return "fieldset";
        }
        case HtmlTextWriterTag.Font:
        {
          return "font";
        }
        case HtmlTextWriterTag.Form:
        {
          return "form";
        }
        case HtmlTextWriterTag.Frame:
        {
          return "frame";
        }
        case HtmlTextWriterTag.Frameset:
        {
          return "frameset";
        }
        case HtmlTextWriterTag.H1:
        {
          return "h1";
        }
        case HtmlTextWriterTag.H2:
        {
          return "h2";
        }
        case HtmlTextWriterTag.H3:
        {
          return "h3";
        }
        case HtmlTextWriterTag.H4:
        {
          return "h4";
        }
        case HtmlTextWriterTag.H5:
        {
          return "h5";
        }
        case HtmlTextWriterTag.H6:
        {
          return "h6";
        }
        case HtmlTextWriterTag.Head:
        {
          return "head";
        }
        case HtmlTextWriterTag.Hr:
        {
          return "hr";
        }
        case HtmlTextWriterTag.Html:
        {
          return "html";
        }
        case HtmlTextWriterTag.I:
        {
          return "i";
        }
        case HtmlTextWriterTag.Iframe:
        {
          return "iframe";
        }
        case HtmlTextWriterTag.Img:
        {
          return "img";
        }
        case HtmlTextWriterTag.Input:
        {
          return "input";
        }
        case HtmlTextWriterTag.Ins:
        {
          return "ins";
        }
        case HtmlTextWriterTag.Isindex:
        {
          return "isindex";
        }
        case HtmlTextWriterTag.Kbd:
        {
          return "kbd";
        }
        case HtmlTextWriterTag.Label:
        {
          return "label";
        }
        case HtmlTextWriterTag.Legend:
        {
          return "legend";
        }
        case HtmlTextWriterTag.Li:
        {
          return "li";
        }
        case HtmlTextWriterTag.Link:
        {
          return "link";
        }
        case HtmlTextWriterTag.Map:
        {
          return "map";
        }
        case HtmlTextWriterTag.Marquee:
        {
          return "marquee";
        }
        case HtmlTextWriterTag.Menu:
        {
          return "menu";
        }
        case HtmlTextWriterTag.Meta:
        {
          return "meta";
        }
        case HtmlTextWriterTag.Nobr:
        {
          return "nobr";
        }
        case HtmlTextWriterTag.Noframes:
        {
          return "noframes";
        }
        case HtmlTextWriterTag.Noscript:
        {
          return "noscript";
        }
        case HtmlTextWriterTag.Object:
        {
          return "object";
        }
        case HtmlTextWriterTag.Ol:
        {
          return "ol";
        }
        case HtmlTextWriterTag.Option:
        {
          return "option";
        }
        case HtmlTextWriterTag.P:
        {
          return "p";
        }
        case HtmlTextWriterTag.Param:
        {
          return "param";
        }
        case HtmlTextWriterTag.Pre:
        {
          return "pre";
        }
        case HtmlTextWriterTag.Q:
        {
          return "q";
        }
        case HtmlTextWriterTag.Rt:
        {
          return "rt";
        }
        case HtmlTextWriterTag.Ruby:
        {
          return "ruby";
        }
        case HtmlTextWriterTag.S:
        {
          return "s";
        }
        case HtmlTextWriterTag.Samp:
        {
          return "samp";
        }
        case HtmlTextWriterTag.Script:
        {
          return "script";
        }
        case HtmlTextWriterTag.Select:
        {
          return "select";
        }
        case HtmlTextWriterTag.Small:
        {
          return "small";
        }
        case HtmlTextWriterTag.Span:
        {
          return "span";
        }
        case HtmlTextWriterTag.Strike:
        {
          return "strike";
        }
        case HtmlTextWriterTag.Strong:
        {
          return "strong";
        }
        case HtmlTextWriterTag.Style:
        {
          return "style";
        }
        case HtmlTextWriterTag.Sub:
        {
          return "sub";
        }
        case HtmlTextWriterTag.Sup:
        {
          return "sup";
        }
        case HtmlTextWriterTag.Table:
        {
          return "table";
        }
        case HtmlTextWriterTag.Tbody:
        {
          return "tbody";
        }
        case HtmlTextWriterTag.Td:
        {
          return "td";
        }
        case HtmlTextWriterTag.Textarea:
        {
          return "textarea";
        }
        case HtmlTextWriterTag.Tfoot:
        {
          return "tfoot";
        }
        case HtmlTextWriterTag.Th:
        {
          return "th";
        }
        case HtmlTextWriterTag.Thead:
        {
          return "thead";
        }
        case HtmlTextWriterTag.Title:
        {
          return "title";
        }
        case HtmlTextWriterTag.Tr:
        {
          return "tr";
        }
        case HtmlTextWriterTag.Tt:
        {
          return "tt";
        }
        case HtmlTextWriterTag.U:
        {
          return "u";
        }
        case HtmlTextWriterTag.Ul:
        {
          return "ul";
        }
        case HtmlTextWriterTag.Var:
        {
          return "var";
        }
        case HtmlTextWriterTag.Wbr:
        {
          return "wbr";
        }
        case HtmlTextWriterTag.Xml:
        {
          return "xml";
        }
        default:
        {
          return "";
        }
      }
    }

    /// <summary>
    ///   <para>
    ///     Determines whether the specified HTML style attribute and its value have been 
    ///     rendered on the requesting page.
    ///   </para>
    /// </summary>
    /// <param name="name">
    ///   <para>
    ///     The HTML style attribute to render to the client.
    ///   </para>
    /// </param>
    /// <param name="value">
    ///   <para>
    ///     The value associated with the HTML style attribute.
    ///   </para>
    /// </param>
    /// <param name="key">
    ///   <para>
    ///     The <see cref="HtmlTextWriterStyle"/> enumeration value associated with the 
    ///     HTML style attribute.
    ///   </para>
    /// </param>
    /// <returns>
    ///   <para>
    ///     true if the HTML style attribute and its value have been rendered on the 
    ///     requesting page; otherwise, false.
    ///   </para>
    /// </returns>
    /// <remarks>
    ///   <para>
    ///     This method supports a smaller number of HTML style attributes than the 
    ///     <see cref="HtmlTextWriter.OnStyleAttributeRender"/> method that it overrides.
    ///   </para>
    /// </remarks>
    protected override bool OnStyleAttributeRender(string name, string value, HtmlTextWriterStyle key)
    {
      return base.OnStyleAttributeRender(name, value, key);
    }

    /// <summary>
    ///   <para>
    ///     Determines whether the specified HTML element has been rendered to the 
    ///     requesting page.
    ///   </para>
    /// </summary>
    /// <param name="name">
    ///   <para>
    ///     The HTML element to render.
    ///   </para>
    /// </param>
    /// <param name="key">
    ///   <para>
    ///     The <see cref="HtmlTextWriterTag"/> 
    ///     enumeration value associated with the HTML element.
    ///   </para>
    /// </param>
    /// <returns>
    ///   <para>
    ///     true if the HTML element has been rendered to the requesting page; otherwise, false.
    ///   </para>
    /// </returns>
    /// <remarks>
    ///   <para>
    ///     This method associates the div element with an HTML table to simplify page 
    ///     layout for browsers that do not support this element.
    ///   </para>
    /// </remarks>
    protected override bool OnTagRender(string name, HtmlTextWriterTag key)
    {
      return base.OnTagRender(name, key);
    }

    /// <summary>
    ///   <para>
    ///     Writes any text or spacing that occurs after the content of the HTML element 
    ///     to the <see cref="HtmlTextWriter"/> output stream.
    ///   </para>
    /// </summary>
    /// <returns>
    ///   <para>
    ///     The spacing or text to write after to the content of the HTML element. If 
    ///     there is no such information to render, this method returns a 
    ///     null reference (Nothing in Visual Basic).
    ///   </para>
    /// </returns>
    protected override string RenderAfterContent()
    {
      return "";
    }

    /// <summary>
    ///   <para>
    ///     Writes any spacing or text that occurs after an HTML element's closing tag.
    ///   </para>
    /// </summary>
    /// <returns>
    ///   <para>
    ///     The spacing or text to write after the closing tag of the HTML element. If there is no such information to render, this method returns a null reference (Nothing in Visual Basic).
    ///   </para>
    /// </returns>
    protected override string RenderAfterTag()
    {
      return "";
    }

    /// <summary>
    ///   <para>
    ///     Writes any tab spacing or font information that appears before 
    ///     the content contained in an HTML element.
    ///   </para>
    /// </summary>
    /// <returns>
    ///   <para>
    ///     The font information or spacing to write prior to the content of the 
    ///     HTML element. If there is no such information to render, this method 
    ///     returns a null reference (Nothing in Visual Basic).
    ///   </para>
    /// </returns>
    protected override string RenderBeforeContent()
    {
      return "";
    }

    /// <summary>
    ///   <para>
    ///     Writes any text or tab spacing that occurs before the opening tag of 
    ///     an HTML element to the <see cref="HtmlTextWriter"/> output stream.
    ///   </para>
    /// </summary>
    /// <returns>
    ///   <para>
    ///     Any HTML font and spacing information to render before the tag; if 
    ///     there is no such information to render, this method returns a null 
    ///     reference (Nothing in Visual Basic).
    ///   </para>
    /// </returns>
    protected override string RenderBeforeTag()
    {
      return "";
    }

    /// <summary>
    ///   <para>
    ///     Writes the opening tag of an HTML element to an HtmlTextWriter output stream.
    ///   </para>
    /// </summary>
    /// <param name="tagKey">
    ///   <para>
    ///     The <see cref="HtmlTextWriterTag"/> enumeration value that indicates the 
    ///     HTML element to write.
    ///   </para>
    /// </param>
    public override void RenderBeginTag(HtmlTextWriterTag tagKey)
    {
    }

    /// <summary>
    ///   <para>
    ///     Writes the end tag of an HTML element to the <see cref="HtmlTextWriter"/> 
    ///     output stream, along with any font information that is associated with 
    ///     the element.
    ///   </para>
    /// </summary>
    public override void RenderEndTag()
    {
    }
	}
}
