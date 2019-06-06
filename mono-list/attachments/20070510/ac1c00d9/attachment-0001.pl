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
                int num = 13500;
                for (int j = 0; j < num; ++j)
                {
                    objectArray = new object[100];
                    for (int i = 0; i < objectArray.Length; ++i)
                    {
                        int modulo = i % 4;
                        switch (modulo)
                        {
                            case 0:
                                objectArray[i] = new String(new char[] { 'A', 'B', 'C' });
                                break;
                            case 1:
                                objectArray[i] = new Int32();
                                break;
                            case 2:
                                objectArray[i] = new Boolean();
                                break;
                            case 3:
                                objectArray[i] = Guid.NewGuid();
                                break;
                        }
                    }
                    list.Add(objectArray);
                }
                MemoryStream memoryStream = new MemoryStream(17000000);
                binaryFormatter.Serialize(memoryStream, list);
                Console.WriteLine(memoryStream.Length);
            }
        }
    }
}
