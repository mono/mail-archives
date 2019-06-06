using System;
using System.Web.Services;
using System.Web.Services.Protocols;

[WebService]
public class TestService
{
	[WebMethod]
	//[SoapRpcMethod]
	public void Register (TestObject data)
	{
	}
}

/// <remarks/>
[System.Xml.Serialization.SoapType(Namespace="urn:packetfront_becs")]
public class TestObject {

   /// <remarks/>
   public System.UInt64 oid;
      
   /// <remarks/>
   [System.Xml.Serialization.SoapIgnore()]
   public bool oidSpecified;
      
   /// <remarks/>
   public System.UInt64 parentoid;
      
   /// <remarks/>
   [System.Xml.Serialization.SoapIgnore()]
   public bool parentoidSpecified;
      
   /// <remarks/>
   public string creator;
}
