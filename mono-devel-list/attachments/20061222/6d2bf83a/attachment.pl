using System;
using System.Configuration;

public class MyElement : ConfigurationElement
{
	static ConfigurationProperty name = new ConfigurationProperty ("name",
		typeof (string), null, ConfigurationPropertyOptions.IsKey);
	static ConfigurationPropertyCollection props;

	static MyElement ()
	{
		props = new ConfigurationPropertyCollection ();
		props.Add (name);
	}
	
	public MyElement ()
	{
	}

	public MyElement (string name)
	{
		Name = name;
	}

	[ConfigurationProperty ("name", Options = ConfigurationPropertyOptions.IsKey)]
	public string Name {
		get { return (string) this [name]; }
		set { this [name] = value; }
	}

	protected override ConfigurationPropertyCollection Properties {
		get { return props; }
	}
}

[ConfigurationCollection (typeof (MyElement), CollectionType = ConfigurationElementCollectionType.AddRemoveClearMap)]
public class MyElementCollection : ConfigurationElementCollection
{
	protected override ConfigurationElement CreateNewElement ()
	{
		return new MyElement ();
	}
	protected override object GetElementKey (ConfigurationElement e)
	{
		return ((MyElement) e).Name;
	}

	public void Add (MyElement e)
	{
		BaseAdd (e);
	}

	protected override void BaseAdd (ConfigurationElement e)
	{
Console.WriteLine ("{0} {1}", BaseIndexOf (e), ThrowOnDuplicate);
		base.BaseAdd (e);
	}
}

public class MySection : ConfigurationSection
{
	MyElementCollection my_elems =
		new MyElementCollection ();

	[ConfigurationProperty ("MyElements")]
	public MyElementCollection MyElements {
		get { return my_elems; }
	}
}

public class Driver
{
	public static void Main ()
	{
		/*
		MyElementCollection c = new MyElementCollection ();
		MyElement e = new MyElement ("Foo");
		c.Add (e);
		c.Add (e);
		c.Add (new MyElement ("Foo"));
		*/
		MySection ms = (MySection) ConfigurationManager.GetSection ("MySection");
		foreach (MyElement e in ms.MyElements)
			Console.WriteLine (e.Name);
	}
}
