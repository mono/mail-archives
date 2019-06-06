using System.Diagnostics;
using System.Xml.Serialization;
using System;
using System.Web.Services.Protocols;
using System.ComponentModel;
using System.Web.Services;


[System.Web.Services.WebServiceBindingAttribute(Name="AbbreviationsSoap1", Namespace="http://trwest.com/webservices/")]
public class Abbreviations : System.Web.Services.WebService 
{
    
	/// <remarks/>
	[System.Web.Services.WebMethodAttribute()]
	public StateProvince[] FindAbbreviations()
	{
		return null;
	}
    
}

/// <remarks/>
[System.Xml.Serialization.XmlTypeAttribute(Namespace="http://trwest.com/webservices/")]
public class StateProvince 
{
    
	/// <remarks/>
	public string Name;
    
	/// <remarks/>
	public string Abbrev;
}