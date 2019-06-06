using System;
using System.IO;
using System.Collections;
using System.Xml;

public class MyStringReader : StringReader
{
	public MyStringReader (string s) : base (s) {}

	public override int Read ()
	{
		Console.WriteLine ("****Read called****");
		return base.Read ();
	}
	
	public override int Read (char [] buffer, int index, int count)
	{
		Console.WriteLine ("****Read called: buffer size {0}, index {1} count {2}", buffer.Length, index, count);
		return base.Read (buffer, index, count);
	}
	
	public override int ReadBlock (char [] buffer, int index, int count)
	{
		Console.WriteLine ("****ReadBlock called****");
		return base.ReadBlock (buffer, index, count);
	}
	
	public override string ReadLine ()
	{
		Console.WriteLine ("****ReadLine called****");
		return base.ReadLine ();
	} 

	public override string ReadToEnd ()
	{
		Console.WriteLine ("****ReadToEnd called****");
		return base.ReadToEnd ();
	} 
}

public class MyStreamReader : TextReader
{
	StreamReader r;
	public MyStreamReader (StreamReader r)
	{
		this.r = r;
	}

	public override int Read ()
	{
		Console.WriteLine ("****Read called****");
		return r.Read ();
	}
	
	public override int Read (char [] buffer, int index, int count)
	{
		Console.WriteLine ("****Read called: buffer size {0}, index {1} count {2}", buffer.Length, index, count);
		return r.Read (buffer, index, count);
	}
	
	public override int ReadBlock (char [] buffer, int index, int count)
	{
		Console.WriteLine ("****ReadBlock called****");
		return r.ReadBlock (buffer, index, count);
	}
	
	public override string ReadLine ()
	{
		Console.WriteLine ("****ReadLine called****");
		return r.ReadLine ();
	} 

	public override string ReadToEnd ()
	{
		Console.WriteLine ("****ReadToEnd called****");
		return r.ReadToEnd ();
	} 
}

public class MyClass
{
	public static void Main()
	{
		try {
			Run ();
		} catch (Exception ex) {
			Console.WriteLine (ex);
		}
	}
	
	static void Run ()
	{
//		MyStringReader sr = new MyStringReader ("<root attr='attr1 &ent; value'><testchild>test content string <![CDATA[ cdata included ]]></testchild></root>");
		MyStreamReader sr = new MyStreamReader (
			new StreamReader (new System.Net.WebClient ().OpenRead ("http://www.w3.org/2001/XMLSchema.xsd")));
		XmlTextReader xtr = new XmlTextReader (sr);
		xtr.XmlResolver = null;
		while (!xtr.EOF) {
			xtr.Read ();
			Console.WriteLine (xtr.ReadOuterXml ());
		}
	}
	
	private static void WL(string text, params object[] args)
	{
		Console.WriteLine(text, args);	
	}
	
	private static void RL()
	{
		Console.ReadLine();	
	}
	
	private static void Break() 
	{
		System.Diagnostics.Debugger.Break();
	}
}

