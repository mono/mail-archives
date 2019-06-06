namespace DictSerializer
{
    using System;
    using System.Collections.Generic;
    using System.Diagnostics;
    using System.IO;
    using System.Runtime.Serialization;
    using System.Xml;

    /// <summary>
    /// A class that contains stuff.
    /// </summary>
    [DataContract]
    public class Bit
    {
        public Bit(string which)
        {
            this.Which = which;
        }

        [DataMember]
        public string Which { get; set; }
    }

    /// <summary>
    /// A class that contains a dictionary.
    /// </summary>
    [DataContract]
    public class Stuff
    {
        public Stuff(string destination)
        {
            this.Bits = new Dictionary<Guid, Bit>();
            this.Bits[Guid.NewGuid()] = new Bit(destination);
            this.Bits[Guid.NewGuid()] = new Bit(destination);
        }

        [DataMember]
        public Dictionary<Guid, Bit> Bits { get; set; }
    }

    class Program
    {
        static void Main(string[] args)
        {
            try
            {
                // Setup
                Stuff a = new Stuff("a");
                string path = "stuff.xml";

                // Serialize to file
                {
                    DataContractSerializer ds = new DataContractSerializer(a.GetType());
                    XmlWriterSettings settings = new XmlWriterSettings() { Indent = true };
                    using (XmlWriter s = XmlWriter.Create(path, settings))
                    {
                        ds.WriteObject(s, a);
                    }
                }

                // De-serialize from file
                {
                    DataContractSerializer ds = new DataContractSerializer(typeof(Stuff));
                    using (Stream s = File.OpenRead(path))
                    {
                        Stuff b = (Stuff)ds.ReadObject(s);
                    }
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex);
            }
        }
    }
}
