using System;
using System.Collections;
using System.Data;
using System.Data.Mapping;
using System.IO;
using System.Xml;
using System.Xml.Schema;


namespace System.Data.Mapping.RelationalSchema
{
	public enum ColumnOrder
	{
		Ascending,
		Descending
	}


	public enum DbNullType
	{
		NoNull,
		NotNull,
		Null
	}


	public class ColumnDefinition : IDomainField
	{
		public ColumnDefinition ()
		{
		}

		public object GetDefault()
		{
			throw new NotImplementedException ();
		}

		public bool AllowDbNull {
			get { throw new NotImplementedException (); }
		}

		public bool AutoIncrement {
			get { throw new NotImplementedException (); }
		}

		public long AutoIncrementSeed {
			get { throw new NotImplementedException (); }
		}

		public long AutoIncrementStep {
			get { throw new NotImplementedException (); }
		}
		
		public string Collation {
			get { throw new NotImplementedException (); }
		}
		
		public string DefaultValue {
			get { throw new NotImplementedException (); }
		}
		
		public string Expression {
			get { throw new NotImplementedException (); }
		}

		public bool ForReplication {
			get { throw new NotImplementedException (); }
		}
		
		public bool IsMaxLength {
			get { throw new NotImplementedException (); }
		}
		
		public bool IsRowGuidCol {
			get { throw new NotImplementedException (); }
		}

		public int Length {
			get { throw new NotImplementedException (); }
		}

		public string Name {
			get { throw new NotImplementedException (); }
		}

		public DefaultDefinition NamedDefault {
			get { throw new NotImplementedException (); }
		}

		public ColumnOrder Order {
			get { throw new NotImplementedException (); }
		}

		public int Precision {
			get { throw new NotImplementedException (); }
		}

		public int Scale {
			get { throw new NotImplementedException (); }
		}

		public SqlDbType SqlType {
			get { throw new NotImplementedException (); }
		}

		public TableDefinition Table {
			get { throw new NotImplementedException (); }
		}

		public UserDefinedFunctionDefinition UserDefinedFunction {
			get { throw new NotImplementedException (); }
		}

		public UserDefinedDataTypeDefinition UserType {
			get { throw new NotImplementedException (); }
		}

		public ViewDefinition View {
			get { throw new NotImplementedException (); }
		}

		// IDomainField

		public IDomainStructure DomainStructure {
			get { throw new NotImplementedException (); }
		}
	}


	public class ColumnDefinitionCollection : DictionaryBase
	{
		internal ColumnDefinitionCollection ()
		{
		}

		public ColumnDefinition this [string rnv] {
			get { throw new NotImplementedException (); }
		}

		public bool Contains (string name)
		{
			throw new NotImplementedException ();
		}
	}


	public class ConstraintDefinition
	{
		string name;
		TableDefinition table;

		public string Name {
			get { return name; }
		}

		public TableDefinition Table {
			get { return table; }
		}
	}


	public class ConstraintDefinitionCollection : DictionaryBase
	{
		public ConstraintDefinition this [string rnv] {
			get { throw new NotImplementedException (); }
		}

		public bool Contains (string name)
		{
			throw new NotImplementedException ();
		}

		/*
		public override IEnumerator GetEnumerator ()
		{
			throw new NotImplementedException ();
		}

		public virtual IDictionaryEnumerator GetEnumerator ()
		{
			throw new NotImplementedException ();
		}
		*/
	}


	public class DatabaseDefinition : IDomainSchema
	{
		string collation;
		SchemaDefinition defaultSchema;
		string name;
		string owner;
		bool isReadonly;
		SchemaDefinitionCollection schemas;

		public DatabaseDefinition ()
		{
		}

		public string Collation {
			get { return collation; }
		}

		public SchemaDefinition DefaultSchema {
			get { return defaultSchema; }
		}

		public string Name {
			get { return name; }
			set { name = value; }
		}

		public string Owner {
			get { return owner; }
		}

		public bool ReadOnly {
			get { return isReadonly; }
		}

		public SchemaDefinitionCollection Schemas {
			get { return schemas; }
		}

		// IDomainSchena

		public MappingDataSourceType DomainType {
			get { throw new NotImplementedException (); }
		}

		public IDomainConstraint GetDomainConstraint (string name, IXmlNamespaceResolver namespaces)
		{
			throw new NotImplementedException ();
		}

		public IDomainStructure GetDomainStructure (string select, IXmlNamespaceResolver namespaces)
		{
			throw new NotImplementedException ();
		}

		public void Read (string url)
		{
			Read (url, null);
		}

		public void Read (XmlReader reader)
		{
			Read (reader, null);
		}

		public void Read (string url, ValidationEventHandler validationEventHandler)
		{
			XmlTextReader xtr = new XmlTextReader (url);
			Read (xtr, validationEventHandler);
			xtr.Close ();
		}

		[MonoTODO]
		public void Read (XmlReader reader, ValidationEventHandler validationEventHandler)
		{
			throw new NotImplementedException ();
		}

		public void ReadExtensions (XmlReader reader)
		{
			ReadExtensions (reader, null);
		}

		[MonoTODO]
		public void ReadExtensions (XmlReader reader, ValidationEventHandler validationEventHandler)
		{
			throw new NotImplementedException ();
		}

		public void Write (Stream stream)
		{
			Write (stream, null);
		}

		public void Write (string url)
		{
			Write (url, null);
		}

		public void Write (TextWriter writer)
		{
			Write (writer, null);
		}

		public void Write (XmlWriter writer)
		{
			Write (writer, null);
		}

		public void Write (Stream stream, IXmlNamespaceResolver namespaceResolver)
		{
			XmlTextWriter xtw = new XmlTextWriter (stream, null);
			Write (xtw, namespaceResolver);
		}

		public void Write (string url, IXmlNamespaceResolver namespaceResolver)
		{
			XmlTextWriter xtw = new XmlTextWriter (url, null);
			Write (xtw, namespaceResolver);
			xtw.Close ();
		}

		public void Write (TextWriter writer, IXmlNamespaceResolver namespaceResolver)
		{
			XmlTextWriter xtw = new XmlTextWriter (writer);
			Write (xtw, namespaceResolver);
		}

		[MonoTODO]
		public void Write (XmlWriter writer, IXmlNamespaceResolver namespaceResolver)
		{
			throw new NotImplementedException ();
		}

		public void WriteExtensions (XmlWriter writer)
		{
			WriteExtensions (writer, null);
		}

		[MonoTODO]
		public void WriteExtensions (XmlWriter writer, IXmlNamespaceResolver namespaceResolver)
		{
			throw new NotImplementedException ();
		}
	}


	public class DefaultDefinition
	{
		string defaultValue;
		string name;
		SchemaDefinition schema;
		SqlDbType sqlType;

		public DefaultDefinition()
		{
		}

		public string DefaultValue {
			get { return defaultValue; }
		}

		public string Name {
			get { return name; }
		}

		public SchemaDefinition Schema {
			get { return schema; }
		}

		public SqlDbType SqlType {
			get { return sqlType; }
		}
	}


	public class DefaultDefinitionCollection : DictionaryBase
	{
		public DefaultDefinition this [string query] {
			get { throw new NotImplementedException (); }
		}
	
		/*
		public virtual IDictionaryEnumerator GetEnumerator ()
		{
			throw new NotImplementedException ();
		}

		public override IEnumerator GetEnumerator()
		{
			throw new NotImplementedException ();
		}
		*/

		public bool Contains (string name)
		{
			throw new NotImplementedException ();
		}
	}


	public class ForeignKeyConstraintDefinition : ConstraintDefinition, IDomainConstraint
	{
		public ForeignKeyConstraintDefinition()
		{
		}

		public ColumnDefinitionCollection Columns {
			get { throw new NotImplementedException (); }
		}

		public Rule DeleteRule {
			get { throw new NotImplementedException (); }
		}

		public bool Disabled {
			get { throw new NotImplementedException (); }
		}

		public bool ForReplication {
			get { throw new NotImplementedException (); }
		}

		public ColumnDefinitionCollection RelatedColumns {
			get { throw new NotImplementedException (); }
		}

		public TableDefinition RelatedTable {
			get { throw new NotImplementedException (); }
		}

		public Rule UpdateRule {
			get { throw new NotImplementedException (); }
		}

		// IDomainConstraint

		public bool CascadeDelete {
			get { throw new NotImplementedException (); }
		}

		public IDomainSchema DomainSchema {
			get { throw new NotImplementedException (); }
		}

		public IDomainFieldJoinCollection FieldJoins {
			get { throw new NotImplementedException (); }
		}

		public IDomainStructure FromDomainStructure {
			get { throw new NotImplementedException (); }
		}

		public IDomainStructure ToDomainStructure {
			get { throw new NotImplementedException (); }
		}
	}


	public class ParameterDefinition : IDomainField
	{
		public ParameterDefinition()
		{
		}

		public bool AllowDbNull {
			get { throw new NotImplementedException (); }
		}

		public string Collation {
			get { throw new NotImplementedException (); }
		}
		
		public string DefaultValue {
			get { throw new NotImplementedException (); }
		}

		public bool IsMaxLength {
			get { throw new NotImplementedException (); }
		}

		public int Length {
			get { throw new NotImplementedException (); }
		}

		public string Name {
			get { throw new NotImplementedException (); }
		}

		public bool OutputParameter {
			get { throw new NotImplementedException (); }
		}

		public int Precision {
			get { throw new NotImplementedException (); }
		}

		public int Scale {
			get { throw new NotImplementedException (); }
		}

		public SqlDbType SqlType {
			get { throw new NotImplementedException (); }
		}

		public StoredProcedureDefinition StoredProcedure {
			get { throw new NotImplementedException (); }
		}

		public UserDefinedFunctionDefinition UserDefinedFunction {
			get { throw new NotImplementedException (); }
		}

		public bool Varying {
			get { throw new NotImplementedException (); }
		}

		// IDomainField

		public IDomainStructure DomainStructure {
			get { throw new NotImplementedException (); }
		}
	}

	public class ParameterDefinitionCollection : DictionaryBase
	{
		public ParameterDefinition this [string iter] {
			get { throw new NotImplementedException (); }
		}

		/*
		public virtual IDictionaryEnumerator GetEnumerator ()
		{
			throw new NotImplementedException ();
		}

		public override IEnumerator GetEnumerator()
		{
			throw new NotImplementedException ();
		}
		*/

		public bool Contains (string name)
		{
			throw new NotImplementedException ();
		}
	}


	public class SchemaDefinition
	{
		DatabaseDefinition database;
		bool isDefault;
		DefaultDefinitionCollection defaults;
		string name;
		StoredProcedureDefinitionCollection sps;
		TableDefinitionCollection tables;
		UserDefinedDataTypeDefinitionCollection userDatatypes;
		UserDefinedFunctionDefinitionCollection userFuncs;
		ViewDefinitionCollection views;

		public SchemaDefinition ()
		{
		}

		public DatabaseDefinition Database {
			get { return database; }
		}

		public bool Default {
			get { return isDefault; }
		}

		public DefaultDefinitionCollection Defaults {
			get { return defaults; }
		}

		public string Name {
			get { return name; }
		}

		public StoredProcedureDefinitionCollection StoredProcedures {
			get { return sps; }
		}

		public TableDefinitionCollection Tables {
			get { return tables; }
		}

		public UserDefinedDataTypeDefinitionCollection UserDefinedDataTypes {
			get { return userDatatypes; }
		}

		public UserDefinedFunctionDefinitionCollection UserDefinedFunctions {
			get { return userFuncs; }
		}

		public ViewDefinitionCollection Views {
			get { return views; }
		}
	}


	public class SchemaDefinitionCollection : DictionaryBase
	{
		public SchemaDefinition this [string iter] {
			get { throw new NotImplementedException (); }
		}
	
		/*
		public virtual IDictionaryEnumerator GetEnumerator ()
		{
			throw new NotImplementedException ();
		}

		public override IEnumerator GetEnumerator()
		{
			throw new NotImplementedException ();
		}
		*/

		public bool Contains (string name)
		{
			throw new NotImplementedException ();
		}
	}


	public class StoredProcedureDefinition : IDomainStructure
	{
		public string Body {
			get { throw new NotImplementedException (); }
		}

		public bool Encrypted {
			get { throw new NotImplementedException (); }
		}

		public bool ForReplication {
			get { throw new NotImplementedException (); }
		}

		public string Name {
			get { throw new NotImplementedException (); }
		}

		public int Number {
			get { throw new NotImplementedException (); }
		}

		public string Owner {
			get { throw new NotImplementedException (); }
		}

		public ParameterDefinitionCollection Parameters {
			get { throw new NotImplementedException (); }
		}

		public bool Recompile {
			get { throw new NotImplementedException (); }
		}

		public SchemaDefinition Schema {
			get { throw new NotImplementedException (); }
		}

		public ViewDefinitionCollection Views {
			get { throw new NotImplementedException (); }
		}

		public virtual IDomainField GetDomainField (string name, 
			IXmlNamespaceResolver namespaces)
		{
			throw new NotImplementedException ();
		}

		// IDomainStructure

		public string Select {
			get { throw new NotImplementedException (); }
		}

		public IDomainSchema DomainSchema {
			get { throw new NotImplementedException (); }
		}
	}


	public class StoredProcedureDefinitionCollection : DictionaryBase
	{
		public StoredProcedureDefinition this [string resultNode] {
			get { throw new NotImplementedException (); }
		}

		public StoredProcedureDefinition this [string resultNode, int mergeDataNode] {
			get { throw new NotImplementedException (); }
		}

		/*
		public virtual IDictionaryEnumerator GetEnumerator ()
		{
			throw new NotImplementedException ();
		}

		public override IEnumerator GetEnumerator()
		{
			throw new NotImplementedException ();
		}
		*/

		public bool Contains (string name)
		{
			throw new NotImplementedException ();
		}
	}

	public class TableDefinition : IDomainStructure
	{
		public TableDefinition()
		{
		}

		public ColumnDefinitionCollection Columns {
			get { throw new NotImplementedException (); }
		}

		public ConstraintDefinitionCollection Constraints {
			get { throw new NotImplementedException (); }
		}

		public string Name {
			get { throw new NotImplementedException (); }
		}

		public string Owner {
			get { throw new NotImplementedException (); }
		}

		public ColumnDefinitionCollection PrimaryKey {
			get { throw new NotImplementedException (); }
		}

		public SchemaDefinition Schema {
			get { throw new NotImplementedException (); }
		}

		public bool SystemTable {
			get { throw new NotImplementedException (); }
		}

		public UniqueConstraintDefinition GetPrimaryKeyConstraint ()
		{
			throw new NotImplementedException ();
		}

		// IDomainStructure

		public string Select {
			get { throw new NotImplementedException (); }
		}

		public IDomainSchema DomainSchema {
			get { throw new NotImplementedException (); }
		}

		public IDomainField GetDomainField (string fieldName, IXmlNamespaceResolver namespaceResolver)
		{
			throw new NotImplementedException ();
		}
	}


	public class TableDefinitionCollection : DictionaryBase
	{
		public TableDefinition this [string rNode] {
			get { throw new NotImplementedException (); }
		}

		/*
		public virtual IDictionaryEnumerator GetEnumerator ()
		{
			throw new NotImplementedException ();
		}

		public override IEnumerator GetEnumerator()
		{
			throw new NotImplementedException ();
		}
		*/

		public bool Contains (string name)
		{
			throw new NotImplementedException ();
		}
	}


	public class UniqueConstraintDefinition : ConstraintDefinition
	{
		public UniqueConstraintDefinition()
		{
			throw new NotImplementedException ();
		}

		public bool Clustered {
			get { throw new NotImplementedException (); }
		}

		public ColumnDefinitionCollection Columns {
			get { throw new NotImplementedException (); }
		}

		public int FillFactor {
			get { throw new NotImplementedException (); }
		}

		public bool IsPrimaryKey {
			get { throw new NotImplementedException (); }
		}
	}


	public class UserDefinedDataTypeDefinition
	{
		public UserDefinedDataTypeDefinition()
		{
		}

		public bool IsMaxLength {
			get { throw new NotImplementedException (); }
		}
		
		public int Length {
			get { throw new NotImplementedException (); }
		}

		public string Name {
			get { throw new NotImplementedException (); }
		}

		public DefaultDefinition NamedDefault {
			get { throw new NotImplementedException (); }
		}

		public DbNullType NullType {
			get { throw new NotImplementedException (); }
		}

		public string Owner {
			get { throw new NotImplementedException (); }
		}

		public int Precision {
			get { throw new NotImplementedException (); }
		}

		public int Scale {
			get { throw new NotImplementedException (); }
		}

		public SchemaDefinition Schema {
			get { throw new NotImplementedException (); }
		}

		public SqlDbType SqlType {
			get { throw new NotImplementedException (); }
		}
	}


	public class UserDefinedDataTypeDefinitionCollection : DictionaryBase
	{
		public UserDefinedDataTypeDefinition this [string attribute] {
			get { throw new NotImplementedException (); }
		}

		/*
		public virtual IDictionaryEnumerator GetEnumerator ()
		{
			throw new NotImplementedException ();
		}

		public override IEnumerator GetEnumerator()
		{
			throw new NotImplementedException ();
		}
		*/

		public bool Contains (string name)
		{
			throw new NotImplementedException ();
		}
	}


	public class UserDefinedFunctionDefinition : IDomainStructure
	{
		public UserDefinedFunctionDefinition ()
		{
		}

		public string Body {
			get { throw new NotImplementedException (); }
		}

		public bool Encrypted {
			get { throw new NotImplementedException (); }
		}

		public bool IsScalar {
			get { throw new NotImplementedException (); }
		}

		public string Name {
			get { throw new NotImplementedException (); }
		}

		public string Owner {
			get { throw new NotImplementedException (); }
		}

		public ParameterDefinitionCollection Parameters {
			get { throw new NotImplementedException (); }
		}

		public ColumnDefinition ReturnColumn {
			get { throw new NotImplementedException (); }
		}

		public ViewDefinition ReturnView {
			get { throw new NotImplementedException (); }
		}

		public SchemaDefinition Schema {
			get { throw new NotImplementedException (); }
		}

		public bool SchemaBinding {
			get { throw new NotImplementedException (); }
		}

		// IDomainStructure

		public string Select {
			get { throw new NotImplementedException (); }
		}

		public IDomainSchema DomainSchema {
			get { throw new NotImplementedException (); }
		}

		public IDomainField GetDomainField (string fieldName, IXmlNamespaceResolver namespaceResolver)
		{
			throw new NotImplementedException ();
		}
	}


	public class UserDefinedFunctionDefinitionCollection : DictionaryBase
	{
		public UserDefinedFunctionDefinition this [string name] {
			get { throw new NotImplementedException (); }
		}

		/*
		public virtual IDictionaryEnumerator GetEnumerator ()
		{
			throw new NotImplementedException ();
		}

		public override IEnumerator GetEnumerator()
		{
			throw new NotImplementedException ();
		}
		*/

		public bool Contains (string name)
		{
			throw new NotImplementedException ();
		}
	}


	public class ViewDefinition : IDomainStructure
	{
		public ViewDefinition ()
		{
		}

		public string Body {
			get { throw new NotImplementedException (); }
		}

		public ColumnDefinitionCollection Columns {
			get { throw new NotImplementedException (); }
		}

		public string Name {
			get { throw new NotImplementedException (); }
		}

		public string Owner {
			get { throw new NotImplementedException (); }
		}

		public SchemaDefinition Schema {
			get { throw new NotImplementedException (); }
		}

		public StoredProcedureDefinition StoredProcedure {
			get { throw new NotImplementedException (); }
		}

		public UserDefinedFunctionDefinition UserDefinedFunction {
			get { throw new NotImplementedException (); }
		}

		// IDomainStructure

		public string Select {
			get { throw new NotImplementedException (); }
		}

		public IDomainSchema DomainSchema {
			get { throw new NotImplementedException (); }
		}

		public IDomainField GetDomainField (string fieldName, IXmlNamespaceResolver namespaceResolver)
		{
			throw new NotImplementedException ();
		}
	}


	public class ViewDefinitionCollection : DictionaryBase
	{
		public ViewDefinition this [string tupleDesc] {
			get { throw new NotImplementedException (); }
		}

		/*
		public virtual IDictionaryEnumerator GetEnumerator ()
		{
			throw new NotImplementedException ();
		}

		public override IEnumerator GetEnumerator()
		{
			throw new NotImplementedException ();
		}
		*/

		public bool Contains (string name)
		{
			throw new NotImplementedException ();
		}
	}


}