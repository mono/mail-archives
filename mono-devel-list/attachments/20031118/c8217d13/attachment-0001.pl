using System;
using System.Data;
using System.Data.Mapping;
using System.Collections;
using System.IO;
using System.Net;
using System.Runtime.Serialization;
using System.Xml;
using System.Xml.Schema;


namespace MS.Internal.Xml
{
	public interface ISourceLineInfo
	{
	}
}



namespace MS.Internal.Xml.Query
{
	public class QueryEventArgs : EventArgs
	{
	}
	
	public class XmlExpression
	{
	}
}



namespace System.Xml
{
	using System.Xml.Query;

	public class XmlAdapter
	{
		public  XmlAdapter ()  
		{
			throw new NotImplementedException ();
		}

		public  XmlAdapter (XmlResolver resolver)  
		{
			throw new NotImplementedException ();
		}

		public bool AcceptChangesDuringFill { 
			get { throw new NotImplementedException (); }
			set { throw new NotImplementedException (); }
		} 

		public bool AcceptChangesDuringUpdate {
			get { throw new NotImplementedException (); }
			set { throw new NotImplementedException (); }
		} 

		public bool ContinueUpdateOnError { 
			get { throw new NotImplementedException (); }
			set { throw new NotImplementedException (); }
		} 

		public XmlResolver DataSources {
			set { throw new NotImplementedException (); }
		} 

		public void Fill (XPathDocument2 doc, XmlCommand query, XmlQueryArgumentList argumentList)
		{
			throw new NotImplementedException ();
		}

		public void Update (XPathDocument2 doc, MappingSchema mappingSchema)  
		{
			throw new NotImplementedException ();
		}

		public void Update (XPathChangeNavigator navigator, MappingSchema mappingSchema)  
		{
			throw new NotImplementedException ();
		}

		public void Update (IEnumerable changes, MappingSchema mappingSchema)  
		{
			throw new NotImplementedException ();
		}

		public event UpdateEventHandler OnUpdateError; 
	}


	public class XmlDataSourceResolver : XmlResolver/*, IDataSources*/, IEnumerable
	{
		public XmlDataSourceResolver ()
			: this (null)
		{
		}

		public XmlDataSourceResolver (XmlNameTable nameTable)
		{
			throw new NotImplementedException ();
		}

		public virtual int Count {
			get { throw new NotImplementedException (); }
		}

		public override ICredentials Credentials {
			set { throw new NotImplementedException (); }
		}

		public virtual object this [string query] {
			get { throw new NotImplementedException (); }
		}

		public virtual XmlNameTable NameTable {
			get { throw new NotImplementedException (); }
		}

		public override object GetEntity (Uri absoluteUri, string role, Type ofObjectToReturn)
		{
			throw new NotImplementedException ();
		}

		public /*virtual IDictionaryEnumerator*/IEnumerator GetEnumerator ()
		{
			throw new NotImplementedException ();
		}
	}


	public abstract class XmlUpdateEventArgs : EventArgs
	{
		protected XmlUpdateEventArgs ()
		{
			throw new NotImplementedException ();
		}

		public abstract IEnumerable ErrorItems { get; }

		public abstract bool Executed { get; }
		
		public abstract Exception InnerException { get; }
	}


}



namespace System.Xml.Query
{
	public interface IXmlCompilerInclude
	{
		MS.Internal.Xml.Query.XmlExpression ResolveContextDocument ();
		MS.Internal.Xml.Query.XmlExpression ResolveFunction (XmlQualifiedName functionName, object[] functionParameters);
		MS.Internal.Xml.Query.XmlExpression ResolveVariable (XmlQualifiedName variableName);
	}


	public delegate void QueryEventHandler (
		object sender,
		MS.Internal.Xml.Query.QueryEventArgs e);


	public enum SqlQueryPlan
	{
		Serialized,
		Mars,
		UnionAll
	}


	public class SqlQueryOptions
	{
		public SqlQueryOptions ()
		{
			throw new NotImplementedException ();
		}

		public SqlQueryPlan SqlQueryPlan {
			get { throw new NotImplementedException (); }
			set { throw new NotImplementedException (); }
		}

	}


	public abstract class XmlCommand
	{
		public abstract void Execute (
			string contextDocumentUri,
			XmlResolver datasources,
			XmlQueryArgumentList argList,
			TextWriter results);

		public abstract void Execute (
			string contextDocumentUri,
			XmlResolver dataSources,
			XmlQueryArgumentList argList,
			Stream results);

		public QueryEventHandler OnExcecutionEvent;
	}


	public sealed class XmlQueryArgumentList
	{
		public XmlQueryArgumentList ()
		{
			throw new NotImplementedException ();
		}

		public void AddExtensionobject (
			string namespaceUri,
			object value)
		{
			throw new NotImplementedException ();
		}

		public void AddParam (
			string localName,
			string namespaceUri,
			object value)
		{
			throw new NotImplementedException ();
		}

		public object GetExtensionobject (
			string namespaceUri)
		{
			throw new NotImplementedException ();
		}

		public object GetParam (
			string localName,
			string namespaceUri)
		{
			throw new NotImplementedException ();
		}

		public void RemoveExtensionobject(
			string namespaceUri)
		{
			throw new NotImplementedException ();
		}

		public object RemoveParam (
			string localName,
			string namespaceUri)
		{
			throw new NotImplementedException ();
		}
	}


	public class XmlQueryCompileException : XmlQueryException
	{
		public XmlQueryCompileException ()
		{
			throw new NotImplementedException ();
		}
	}


	public class XmlQueryException : SystemException
	{
		protected  XmlQueryException ()
		{
			throw new NotImplementedException ();
		}

		protected  XmlQueryException (string message)
		{
			throw new NotImplementedException ();
		}

		protected  XmlQueryException (string message, Exception innerException)
		{
			throw new NotImplementedException ();
		}

		protected  XmlQueryException (SerializationInfo info, StreamingContext context)
		{
			throw new NotImplementedException ();
		}

		public int LineNumber {
			get { throw new NotImplementedException (); }
		}

		public int LinePosition {
			get { throw new NotImplementedException (); }
		}

		public override string Message {
			get { throw new NotImplementedException (); }
		}

		public MS.Internal.Xml.ISourceLineInfo SourceLineInfo {
			get { throw new NotImplementedException (); }
			set { throw new NotImplementedException (); }
		}

		public string SourceUri {
			get { throw new NotImplementedException (); }
		}

		public /*override*/ void GetobjectData(
			SerializationInfo info,
			StreamingContext context)
		{
			throw new NotImplementedException ();
		}

		protected void SetMessage(
			string message,
			Boolean addLineInfo)
		{
			throw new NotImplementedException ();
		}
	}


	public abstract class XmlViewSchema
	{
		public MS.Internal.Xml.Query.XmlExpression Expression {
			get { throw new NotImplementedException (); }
		}

		public XmlSchema ResultsSchema {
			get { throw new NotImplementedException (); }
		}

		public IEnumerator SourceDataSourceNames { 
			get { throw new NotImplementedException (); }
		}
	}


	public class XmlViewSchemaDictionary : ICollection, IDictionary, IEnumerable, IXmlCompilerInclude
	{
		public XmlViewSchemaDictionary ()
		{
			throw new NotImplementedException ();
		}

		public int Count {
			get { throw new NotImplementedException (); }
		}
		
		public XmlViewSchema this [string name] { 
			get { throw new NotImplementedException (); }
			set { throw new NotImplementedException (); }
		}

		public void Add (string name, XmlViewSchema mapping)
		{
			throw new NotImplementedException ();
		}

		//TODO: add
//		public XmlViewSchema Add (string name, MappingSchema mapping)
//		{
//			throw new NotImplementedException ();
//		}

		public XmlViewSchema Add (string name, string mappingUrl)
		{
			throw new NotImplementedException ();
		}

		public XmlViewSchema Add (string name, XmlReader mapping)
		{
			throw new NotImplementedException ();
		}

		public void Add (XmlViewSchemaDictionary externalCollection)
		{
			throw new NotImplementedException ();
		}

		public void Clear ()
		{
			throw new NotImplementedException ();
		}

		public bool Contains (string name)
		{
			throw new NotImplementedException ();
		}

		public IDictionaryEnumerator GetEnumerator()
		{
			throw new NotImplementedException ();
		}

		/*private*/ void ICollection.CopyTo (Array array, int index)
		{
			throw new NotImplementedException ();
		}

		/*private*/ void IDictionary.Add (object key, object value)
		{
			throw new NotImplementedException ();
		}

		/*private*/ Boolean IDictionary.Contains(object key)
		{
			throw new NotImplementedException ();
		}

		// This is extra to longhorn.msdn.microsoft.com
		object IDictionary.this [object name] { 
			get { throw new NotImplementedException (); }
			set { throw new NotImplementedException (); }
		}

		/*private*/ void IDictionary.Remove (object key)
		{
			throw new NotImplementedException ();
		}

		/*private*/ IEnumerator IEnumerable.GetEnumerator ()
		{
			throw new NotImplementedException ();
		}

		/*private*/ MS.Internal.Xml.Query.XmlExpression IXmlCompilerInclude.ResolveContextDocument ()
		{
			throw new NotImplementedException ();
		}

		/*private*/ MS.Internal.Xml.Query.XmlExpression IXmlCompilerInclude.ResolveFunction (
			XmlQualifiedName functionName,
			object [] functionParameters)
		{
			throw new NotImplementedException ();
		}

		/*private*/ MS.Internal.Xml.Query.XmlExpression IXmlCompilerInclude.ResolveVariable (
			XmlQualifiedName variableName)
		{
			throw new NotImplementedException ();
		}

		public void Remove (string name)
		{
			throw new NotImplementedException ();
		}

		// extra to msdn
		ICollection IDictionary.Keys {
			get { throw new NotImplementedException (); }
		}

		ICollection IDictionary.Values {
			get { throw new NotImplementedException (); }
		}

		bool IDictionary.IsReadOnly {
			get { throw new NotImplementedException (); }
		}

		bool IDictionary.IsFixedSize {
			get { throw new NotImplementedException (); }
		}

		object ICollection.SyncRoot {
			get { throw new NotImplementedException (); }
		}

		bool ICollection.IsSynchronized {
			get { throw new NotImplementedException (); }
		}
	}


	public class XQueryProcessor
	{
		public XQueryProcessor ()
		{
			throw new NotImplementedException ();
		}

		public SqlQueryOptions SqlQueryOptions { 
			get { throw new NotImplementedException (); }
			set { throw new NotImplementedException (); }
		}

		public XmlCommand XmlCommand { 
			get { throw new NotImplementedException (); }
		}

		public XmlViewSchemaDictionary XmlViewSchemaDictionary { 
			get { throw new NotImplementedException (); }
			set { throw new NotImplementedException (); }
		}

		public void Compile (string query)
		{
			throw new NotImplementedException ();
		}

		public void Compile (TextReader query)
		{
			throw new NotImplementedException ();
		}

		public void CompileView (string query, string mappingLocation)
		{
			throw new NotImplementedException ();
		}

		public void CompileView (TextReader query, string mappingLocation)
		{
			throw new NotImplementedException ();
		}

		public void Execute (string contextDocumentUri,
			XmlResolver dataSources,
			TextWriter results)
		{
			throw new NotImplementedException ();
		}

		public void Execute (XmlResolver dataSources,
			TextWriter results)
		{
			throw new NotImplementedException ();
		}

		public void ExecuteView (IDbConnection connection, TextWriter results)
		{
			throw new NotImplementedException ();
		}
	}


	public class XsltProcessor
	{
		public XsltProcessor ()
		{
			throw new NotImplementedException ();
		}

		public XmlCommand XmlCommand { 
			get { throw new NotImplementedException (); }
		}

		public void Compile (string stylesheetUri,
			XmlResolver resolver)
		{
			throw new NotImplementedException ();
		}

		public void Compile (string stylesheetUrl)
		{
			throw new NotImplementedException ();
		}

		public void Execute (string contextDocumentUri, XmlResolver dataSources, XmlQueryArgumentList argList, TextWriter results)
		{
			throw new NotImplementedException ();
		}

		public void Execute (string contextDocumentUri, XmlResolver dataSources, XmlQueryArgumentList argList, Stream results)
		{
			throw new NotImplementedException ();
		}

		public void Execute (string contextDocumentUri, string resultDocumentUrl)
		{
			throw new NotImplementedException ();
		}
	}
}
