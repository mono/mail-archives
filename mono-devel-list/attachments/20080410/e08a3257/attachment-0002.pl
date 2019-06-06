// ServerList.cs created with MonoDevelop
// User: mono at 2:54 AM 10/22/2007
//
// To change standard headers go to Edit->Preferences->Coding->Standard Headers
//

using System;
using System.Runtime.Remoting;
using System.Collections;

namespace remoting
{
        // A list of ServerObject instances

        public class ServerList: MarshalByRefObject
        {
                ArrayList values = new ArrayList();

                public void Add (ServerObject v)
                {
                        values.Add (v);
                        System.Console.WriteLine ("Added " + v.Name);
                }

                public void ProcessItems ()
                {
                        System.Console.WriteLine ("Processing...");

                        int total = 0;
                        foreach (ServerObject ob in values)
                                total += ob.GetValue();

                        System.Console.WriteLine ("Total: " + total);
                }

                public void Clear()
                {
                        values.Clear();
                }

                public ServerObject NewItem(string name)
                {
                        ServerObject obj = new ServerObject(name);
                        Add (obj);
                        return obj;
                }

                public ComplexData SetComplexData (ComplexData data)
                {
                        System.Console.WriteLine ("Showing content of ComplexData");
                        data.Dump ();
                        return data;
                }
        }

        // A remotable object

        public class ServerObject: MarshalByRefObject
        {
                int _value;
                string _name;

                public ServerObject (string name)
                {
                        _name = name;
                }

                public string Name
                {
                        get { return _name; }
                }

                public void SetValue (int v)
                {
                        System.Console.WriteLine ("ServerObject " + _name + ": setting " + v);
                        _value = v;
                }

                public int GetValue ()
                {
                        System.Console.WriteLine ("ServerObject " + _name + ": getting " + _value);
                        return _value;
                }
        }

        // Some complex data for testing serialization

        public enum AnEnum { a,b,c,d,e };

        [Serializable]
        public class ComplexData
        {
                public AnEnum Val = AnEnum.a;
                public object[] Info;

                public ComplexData (AnEnum va, object[] info)
                {
                        Info = info;
                        Val = va;
                }

                public void Dump ()
                {
                        System.Console.WriteLine ("Content:");
                        System.Console.WriteLine ("Val: " + Val);
                        foreach (object ob in Info)
                                System.Console.WriteLine ("Array item: " + ob);
                }
        }
}
