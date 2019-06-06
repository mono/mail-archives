using System;
using System.Collections.Generic;
using System.Text;
using System.Runtime.Serialization;
using System.IO;
using System.Runtime.Serialization.Formatters.Binary;
using NUnit.Framework;

class MonoBugNum02
{
    //--------------------------------------------------------------

    static void Main(string[] args)
    {
        //ShowIsBehaviour();
        //-------------

        MonoBugNum02 instance = new MonoBugNum02();
        //
        if (args.Length == 0) {
            Console.WriteLine("* Round-trip test...");
            instance.SerializeAndDeserializeDummySerializableException();
        } else {
            if (args.Length == 1 && (args[0] == "/write" || args[0] == "-write")) {
                Console.WriteLine("* Writing a copy to disk...");
                instance.SerializeToDiskByPlatformNameDummySerializableException();
            } else {
                Console.WriteLine("* Reading serialized file(s) from disk...");
                foreach (String curPath in args) {
                    Console.WriteLine("** Reading file: {0}", curPath);
                    ReadASerializedFile(curPath);
                }
            }
        }
    }


    //private static void ShowIsBehaviour()
    //{
    //    Int32 i = 2;
    //    FooByteEnum fbe = FooByteEnum.aaaa;
    //    //
    //    Console.WriteLine();
    //    Console.WriteLine("var_Int32 is Int32: " + (i is Int32));
    //    Console.WriteLine("var_FooByteEnum is Int32: " + (fbe is Int32));
    //    Console.WriteLine("var_FooByteEnum is FooByteEnum : " + (fbe is FooByteEnum));
    //    Console.WriteLine("var_Int32 is FooByteEnum : " + (i is FooByteEnum));
    //    //
    //    Console.WriteLine();
    //    Console.WriteLine("var_Int32.GetType().IsSubclassOf(typeof(Int32: " + (i.GetType().IsSubclassOf(typeof(Int32))));
    //    Console.WriteLine("var_FooByteEnum.GetType().IsSubclassOf(typeof(Int32: " + (fbe.GetType().IsSubclassOf(typeof(Int32))));
    //    Console.WriteLine("var_FooByteEnum.GetType().IsSubclassOf(typeof(FooByteEnum : " + (fbe.GetType().IsSubclassOf(typeof(FooByteEnum))));
    //    Console.WriteLine("var_Int32.GetType().IsSubclassOf(typeof(FooByteEnum : " + (i.GetType().IsSubclassOf(typeof(FooByteEnum))));
    //    //
    //    Console.WriteLine();
    //    Console.WriteLine("(typeof(Int32).IsInstanceOfType(i))): " + (typeof(Int32).IsInstanceOfType(i)));
    //    Console.WriteLine("(typeof(Int32).IsInstanceOfType(fbe))): " + (typeof(Int32).IsInstanceOfType(fbe)));
    //    Console.WriteLine("(typeof(FooByteEnum).IsInstanceOfType(fbe))): " + (typeof(FooByteEnum).IsInstanceOfType(fbe)));
    //    Console.WriteLine("(typeof(FooByteEnum).IsInstanceOfType(i))): " + (typeof(FooByteEnum).IsInstanceOfType(i)));
    //    //
    //    Console.WriteLine();
    //    Console.WriteLine("(typeof(Int32).IsInstanceOfType(i))): " + (typeof(Object).IsInstanceOfType(i)));
    //    Console.WriteLine("(typeof(Int32).IsInstanceOfType(fbe))): " + (typeof(Object).IsInstanceOfType(fbe)));
    //}
    //
    //
    //public bool XisY(object value)
    //{
    //    bool x = value is Int32;
    //    bool y = value is String;
    //    return x ^ y;
    //}


    //--------------------------------------------------------------

    enum FooByteEnum : byte
    {
        None = 0,
        aaaa = 1,
        bbbb = 2
    }


    [Serializable]
    class DummySerializableClass : ISerializable
    //class DummySerializableException : Exception
    {
        FooByteEnum m_fooCode;

        public DummySerializableClass(FooByteEnum value)
        {
            m_fooCode = value;
        }

        public FooByteEnum FooCode { get { return m_fooCode; } }

        protected DummySerializableClass(SerializationInfo info, StreamingContext context)
        //: base(info, context)
        {
            this.m_fooCode = (FooByteEnum)info.GetInt32("FooCode");
            //this.m_description = info.GetString("Description");
        }

        public void GetObjectData(SerializationInfo info, StreamingContext context)
        {
            //base.GetObjectData(info, context);
            info.AddValue("FooCode", this.m_fooCode, typeof(Int32));
            //info.AddValue("Description", this.m_description, typeof(String));
        }

    }

    //--------------------------------------------------------------

    //[Test]
    public void SerializeAndDeserializeDummySerializableException()
    {
        DummySerializableClass exIn = new DummySerializableClass(FooByteEnum.bbbb);
        MemoryStream strm = new MemoryStream();
        BinaryFormatter fmtr = new BinaryFormatter();
        fmtr.Serialize(strm, exIn);
        strm.Position = 0;
        DummySerializableClass exOut = (DummySerializableClass)fmtr.Deserialize(strm);
        // It doesn't override Equals so only compare some of its properties.
        //Assert.AreEqual(exIn.Message, exOut.Message);
        //Assert.AreEqual(exIn.ResponseCode, exOut.ResponseCode);
        //Assert.AreEqual(exIn.Description, exOut.Description);
        if (exIn.FooCode != exOut.FooCode) {
            throw new Exception("Deserialized version has different value to original.");
        } else {
            Console.WriteLine("Round-trip serialization successful.");
        }
    }

    //public void SerializeAndDeserializeDummySerializableException_Soap()
    //{
    //    DummySerializableClass exIn = new DummySerializableClass(FooByteEnum.bbbb);
    //    MemoryStream strm = new MemoryStream();
    //    System.Runtime.Serialization.Formatters.Soap.SoapFormatter fmtr
    //        = new System.Runtime.Serialization.Formatters.Soap.SoapFormatter();
    //    fmtr.Serialize(strm, exIn);
    //    //
    //    strm.Position = 0;
    //    StreamReader rdr = new StreamReader(strm);
    //    String line;
    //    while ((line = rdr.ReadLine()) != null) {
    //        Console.WriteLine(line);
    //    }
    //    //
    //    strm.Position = 0;
    //    DummySerializableClass exOut = (DummySerializableClass)fmtr.Deserialize(strm);
    //    // It doesn't override Equals so only compare some of its properties.
    //    //Assert.AreEqual(exIn.Message, exOut.Message);
    //    //Assert.AreEqual(exIn.ResponseCode, exOut.ResponseCode);
    //    //Assert.AreEqual(exIn.Description, exOut.Description);
    //    if (exIn.FooCode != exOut.FooCode) {
    //        throw new Exception("Deserialized version has different value to original.");
    //    } else {
    //        Console.WriteLine("Round-trip serialization successful.");
    //    }
    //}


    private static void ReadASerializedFile(string path)
    {
        using (Stream src = File.OpenRead(path)) {
            BinaryFormatter fmtr = new BinaryFormatter();
            DummySerializableClass exOut = (DummySerializableClass)fmtr.Deserialize(src);
            Console.WriteLine("Read serialized file successful. (FooCode={0})", exOut.FooCode);
        }
    }


    public void SerializeToDiskByPlatformNameDummySerializableException()
    {
        DummySerializableClass exIn = new DummySerializableClass(FooByteEnum.bbbb);
        //
        String path = GetPathNameBasedOnClrPlatformAndVersion();
        Console.WriteLine("Writing serialized to: " + path);
        using (FileStream strm = File.OpenWrite(path)) {
            //
            BinaryFormatter fmtr = new BinaryFormatter();
            fmtr.Serialize(strm, exIn);
        }
        //
        AlsoWriteAsHexText(path);
    }

    public static String GetPathNameBasedOnClrPlatformAndVersion()
    {
        Version platform = Environment.Version;
        String path = platform.ToString();
        path += ".bin";
        //
        if (Type.GetType("Mono.Runtime", false) == null) {
            path = "MSFT " + path;
        } else {
            path = "Mono " + path;
        }
        //
        return path;
    }

    private void AlsoWriteAsHexText(string path)
    {
        using (FileStream src = File.OpenRead(path)) {
            using (TextWriter dst = new StreamWriter(path + ".txt", false, Encoding.ASCII)) {
                long length = src.Length;
                byte[] all = new byte[length];
                int count = src.Read(all, 0, all.Length);
                if (count != length) {
                    Console.WriteLine("Read convert failure...");
                    return;
                }
                String asText = BitConverter.ToString(all);
                dst.Write(asText);
            }
        }
    }

}


[TestFixture]
public class AddValue3Params_WithOddPairs
{
    private void DoTest(ISerializable obj)
    {
        MemoryStream ms = new MemoryStream();
        BinaryFormatter bf = new BinaryFormatter();
        bf.Serialize(ms, obj);
        //
        //ms.Position = 0;
        //Object readBack = bf.Deserialize(ms);
    }

    //--------------------
    [Serializable]
    class _IsByteSaysInt32 : ISerializable
    {
        public _IsByteSaysInt32() { }

        protected _IsByteSaysInt32(SerializationInfo info, StreamingContext context)
            /* : base(info, context) */ { }

        #region ISerializable Members

        public void GetObjectData(SerializationInfo info, StreamingContext context)
        {
            Byte value = 9;
            info.AddValue("Name", value, typeof(Int32));
        }

        #endregion
    }

    [Test]
    public void IsByteSaysInt32(){
        DoTest(new _IsByteSaysInt32());
    }

    //--------------------
    [Serializable]
    class _IsInt32SaysByte : ISerializable
    {
        public _IsInt32SaysByte() { }

        protected _IsInt32SaysByte(SerializationInfo info, StreamingContext context)
            /* : base(info, context) */ { }

        #region ISerializable Members

        public void GetObjectData(SerializationInfo info, StreamingContext context)
        {
            Int32 value = 9;
            info.AddValue("Name", value, typeof(Byte));
        }

        #endregion
    }

    [Test]
    public void IsInt32SaysByte()
    {
        DoTest(new _IsInt32SaysByte());
    }

    //--------------------
    [Serializable]
    class _IsStringSaysObject : ISerializable
    {
        public _IsStringSaysObject() { }

        protected _IsStringSaysObject(SerializationInfo info, StreamingContext context)
            /* : base(info, context) */ { }

        #region ISerializable Members

        public void GetObjectData(SerializationInfo info, StreamingContext context)
        {
            String value = "foo";
            info.AddValue("Name", value, typeof(Object));
        }

        #endregion
    }

    [Test]
    public void IsStringSaysObject()
    {
        DoTest(new _IsStringSaysObject());
    }

    //--------------------
    [Serializable]
    class _IsObjectSaysString : ISerializable
    {
        public _IsObjectSaysString() { }

        protected _IsObjectSaysString(SerializationInfo info, StreamingContext context)
            /* : base(info, context) */ { }

        #region ISerializable Members

        public void GetObjectData(SerializationInfo info, StreamingContext context)
        {
            Object value = new Object();
            info.AddValue("Name", value, typeof(Object));
        }

        #endregion
    }

    [Test]
    public void IsObjectSaysString()
    {
        DoTest(new _IsObjectSaysString());
    }

    //--------------------
    [Serializable]
    class Foo { public Foo() { } }
    [Serializable]
    class Bar { public Bar() { } }

    [Serializable]
    class _IsFooSaysBar : ISerializable
    {
        public _IsFooSaysBar() { }

        protected _IsFooSaysBar(SerializationInfo info, StreamingContext context)
            /* : base(info, context) */ { }

        #region ISerializable Members

        public void GetObjectData(SerializationInfo info, StreamingContext context)
        {
            Foo value = new Foo();
            info.AddValue("Name", value, typeof(Bar));
        }

        #endregion
    }

    [Test]
    public void IsFooSaysBar()
    {
        DoTest(new _IsFooSaysBar());
    }

    //--------------------
    enum FooIds { a = 1, b, c, d = 10 }

    [Serializable]
    class _IsFooEnumSaysBar : ISerializable
    {
        public _IsFooEnumSaysBar() { }

        protected _IsFooEnumSaysBar(SerializationInfo info, StreamingContext context)
            /* : base(info, context) */ { }

        #region ISerializable Members

        public void GetObjectData(SerializationInfo info, StreamingContext context)
        {
            FooIds value = FooIds.b;
            info.AddValue("Name", value, typeof(Bar));
        }

        #endregion
    }

    [Test]
    public void IsFooEnumSaysBar()
    {
        DoTest(new _IsFooEnumSaysBar());
    }

}