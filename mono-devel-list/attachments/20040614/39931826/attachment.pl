using System;
using System.Globalization;
using System.IO;
using System.Reflection;
using System.Runtime.Serialization.Formatters.Binary;

namespace SerializeTest
{
	public class AssemblySerializer
	{
		private readonly Assembly _assembly;
		private string _outputDirectory;

		public AssemblySerializer(Assembly assembly)
		{
			_assembly = assembly;
		}

		public Assembly Assembly 
		{
			get { return _assembly; }
		}

		public string OutputDirectory 
		{
			get 
			{
				if (_outputDirectory == null) 
				{
					string assemblyPath = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, Assembly.GetName().Name);
					_outputDirectory = Path.Combine(assemblyPath, Assembly.ImageRuntimeVersion);
				}
				return _outputDirectory;
			}
		}

		public void Serialize ()
		{
			Type[] types = Assembly.GetTypes();
			BinaryFormatter bf = new BinaryFormatter();

			foreach (Type type in types) 
			{
				if (!type.IsPublic && !type.IsNestedPublic)
					continue;

				// skip types that are not serializable
				if (!type.IsSerializable)
					continue;

				ConstructorInfo defaultCtor = type.GetConstructor(BindingFlags.Instance | BindingFlags.Public, null, Type.EmptyTypes, null);

				// skip types that do not have a default public ctor
				if (defaultCtor == null)
					continue;

				object instance = defaultCtor.Invoke(BindingFlags.Default, null, new object[0], CultureInfo.InstalledUICulture);

				Console.WriteLine ("Serializing {0} ...", type.FullName);

				using (FileStream fs = new FileStream(GetFileNameFromType(type), FileMode.Create, FileAccess.Write, FileShare.Read)) 
				{
					bf.Serialize(fs, instance);
				}
			}

		}

		public void Deserialize ()
		{
			BinaryFormatter bf = new BinaryFormatter();

			string[] namespaceDirectories = Directory.GetDirectories(OutputDirectory);
			foreach (string namespaceDirectory in namespaceDirectories) 
			{
				string[] serializedInstances = Directory.GetFiles(namespaceDirectory);
				foreach (string serializedInstance in serializedInstances) 
				{
					using (FileStream fs = new FileStream(serializedInstance, FileMode.Open, FileAccess.Read, FileShare.Read)) 
					{
						try 
						{
							bf.Deserialize(fs);
						} 
						catch (Exception ex)
						{
							Console.WriteLine(serializedInstance + ": " + ex.Message);
						}
					}
				}
			}
		}

		private string GetFileNameFromType (Type type) 
		{
			string namespaceDirectory = Path.Combine(OutputDirectory, type.Namespace);

			// ensure directory exists
			if (!Directory.Exists(namespaceDirectory))
				Directory.CreateDirectory(namespaceDirectory);

			return Path.Combine(namespaceDirectory, type.Name);
		}
	}
}
