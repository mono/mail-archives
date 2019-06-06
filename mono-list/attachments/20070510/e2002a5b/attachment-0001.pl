using System;
using System.Collections.Generic;
using System.Text;
using System.IO;
using System.Runtime.Serialization.Formatters.Binary;

namespace TestApp
{
    class Program
    {
        static void Main(string[] args)
        {
            BinaryFormatter binaryFormatter = new BinaryFormatter();
            List<object[]> list;
            object[] objectArray = null;
            while (true)
            {
                list = new List<object[]>();
                int num = 15000;
                for (int j = 0; j < num; ++j)
                {
                    objectArray = new object[100];
                    for (int i = 0; i < objectArray.Length; ++i)
                    {
                        string s = "fsda";
                        objectArray[i] = s.ToUpper();
                    }
                    list.Add(objectArray);
                }
                //MemoryStream stream = new MemoryStream(16000000);
                MemoryStream stream = new MemoryStream();
                //FileStream stream = new FileStream("test.bin", FileMode.Create);
                binaryFormatter.Serialize(stream, list);
                Console.WriteLine(stream.Length);
                stream.Close();
            }
        }
    }
}
