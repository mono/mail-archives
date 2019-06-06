#define LoadFromResource
// possible defines are: LoadFromFileUncached, LoadFromFileCached, LoadFromResource
#define CheckIntegrity

using System;
using System.Resources;
using System.IO;
using System.Collections;

public sealed class MS
{
	public enum String
	{
		GenericParameterNullNotAllowed,
		GenericParameterSmallerThan0NotAllowed,
		GenericParameterLargerThan0NotAllowed,
		GenericParameterSmallerThan1NotAllowed,
		GenericParameterLargerThan1NotAllowed,
		UriFormatException,
		Uri_HexEscape,
		Uri_NotDetermined,
		Uri_InvalidPort,
		Uri_NoHostParse,
		CodeGenerator_InvalidIdentifier,
		BitVector32_IsNegative,
		BitVector32_TooLarge,
		BitVector32_Exceed32BitSection
	}

	private static string ResourceName = "StringData.bin";
	private static BinaryReader reader;

	private MS()
	{
	}

	public static string GetString (MS.String stringResource)
	{
		if (reader == null)
			lock (typeof (MS))
			{
				if (reader == null)
					CreateReader ();
			}

		int ResourceIndex = (int)stringResource;
		lock (reader) 
		{
			reader.BaseStream.Seek (4 + ResourceIndex * 4, SeekOrigin.Begin);
			ResourceIndex = reader.ReadInt32 ();
			if (ResourceIndex == -1)
				return string.Empty;
			else
			{
				reader.BaseStream.Seek (ResourceIndex, SeekOrigin.Begin);
				return reader.ReadString ();
			}
		}
	}

	private static void CreateReader ()
	{
		Stream DataStream;
		#if LoadFromFileUncached
			DataStream = new FileStream (ResourceName, FileMode.Open);
		#endif
		#if LoadFromFileCached
			FileStream FileS = new FileStream (ResourceName, FileMode.Open);
			byte[] DataStore = new byte[FileS.Length];
			FileS.Read (DataStore, 0, (int)FileS.Length);
			FileS.Close ();
			DataStream = new MemoryStream (DataStore);
		#endif
		#if LoadFromResource
			DataStream = System.Reflection.Assembly.GetExecutingAssembly ().GetManifestResourceStream ("MonoString." + ResourceName);
		#endif

		if (DataStream == null)
			throw new Exception ("Invalid string resource file");

		BinaryReader prepareReader = new BinaryReader (DataStream);

		#if CheckIntegrity
			// Simple integrity check
			int Entries = prepareReader.ReadInt32 ();
			if (Entries != Enum.GetValues (typeof (MS.String)).Length)
				throw new Exception ("Invalid string resource file");
		#endif

		reader = prepareReader;
	}
}
