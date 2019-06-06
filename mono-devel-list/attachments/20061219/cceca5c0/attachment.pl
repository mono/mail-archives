using System;
using System.Collections.Generic;
using System.Text;
using System.Reflection;

namespace MonoBug05ExceptionCtorStringAndException
{
    class MonoBug05ExceptionCtorStringAndException
    {
        static void Main(string[] args)
        {
            new MonoBug05ExceptionCtorStringAndException().DoSome();
        }

        bool m_curPrinted;
        Random m_rnd;

        MonoBug05ExceptionCtorStringAndException()
        {
            m_rnd = new Random();
        }
        
        void DoSome()
        {
            Console.WriteLine("---- CorLib ----");
            DisplayMissingExceptionConstructorsInTheSameAssemblyAs(typeof(Exception));
            Console.WriteLine("---- System ----");
            DisplayMissingExceptionConstructorsInTheSameAssemblyAs(typeof(System.Net.Sockets.Socket));
        }

        private void DisplayMissingExceptionConstructorsInTheSameAssemblyAs(Type aTypeInTheTargetAssembly)
        {
            Assembly assm = aTypeInTheTargetAssembly.Assembly;
            DisplayMissingExceptionConstructorsInAssembly(assm);
        }

        private static int CompareTypesByNaming(Type x, Type y)
        {
            int resultNs = String.Compare(x.Namespace, y.Namespace);
            if (resultNs != 0) {
                return resultNs;
            }
            int resultName = String.Compare(x.Name, y.Name);
            return resultName;
        }
    

        private void DisplayMissingExceptionConstructorsInAssembly(Assembly assm)
        {
            Type[] allTypes = assm.GetTypes();
            //
            Array.Sort(allTypes, CompareTypesByNaming);
            //
            foreach (Type curType in allTypes) {
                m_curPrinted = false;
                //Console.Error.WriteLine(curType.FullName);
                if (!(typeof(Exception).Equals(curType) || curType.IsSubclassOf(typeof(Exception)))) {
                    continue;
                }
                //Console.Error.WriteLine(" Is an Exception");
                //Console.Error.WriteLine(curType.FullName);
                //----
                CheckRecommendedExceptionCtors(curType);
                // Check behaviour of (String, Exception) ctor.
                ConstructorInfo ctor = curType.GetConstructor(new Type[] { typeof(String), typeof(Exception) });
                if (ctor == null) {
                    // Handled by CheckRecommendedExceptionCtors now.
                    //PrintClassNameOnce(curType);
                    //Console.WriteLine("{0} - Has NO (String, Exception) constructor.", curType.Name);
                }else{
                    //Console.Error.WriteLine("DOES have (String, Exception) constructor.");
                    String message = "Some message " + m_rnd.Next().ToString() + ".";
                    Exception innerException = new RankException("Some innerException.");
                    //Console.Error.WriteLine("[Gonna construct {0}...]", curType);
                    Exception instStringExceptionCtor = (Exception)Activator.CreateInstance(curType,
                        message, innerException);
                    //
                    if (instStringExceptionCtor.Message != message) {
                        PrintClassNameOnce(curType);
                        Console.WriteLine("Message different from that set.");
                        Console.WriteLine("  expected >{0}<", message);
                        Console.WriteLine("  was      >{0}<", instStringExceptionCtor.Message);
                    }
                    if (instStringExceptionCtor.InnerException != innerException) {
                        PrintClassNameOnce(curType);
                        Console.WriteLine("InnerException different from that set.");
                    }
                    //
                }
            }//for

        }

        private void CheckRecommendedExceptionCtors(Type curType)
        {
            ConstructorInfo ctor;
            //
            ctor = curType.GetConstructor(new Type[] { });
            if (ctor == null) {
                PrintClassNameOnce(curType);
                Console.WriteLine("{0} - Has NO public default constructor.", curType.Name);
            }
            //
            ctor = curType.GetConstructor(new Type[] { typeof(String)});
            if (ctor == null) {
                PrintClassNameOnce(curType);
                Console.WriteLine("{0} - Has NO public (String) constructor.", curType.Name);
            }
            //
            ctor = curType.GetConstructor(new Type[] { typeof(String), typeof(Exception) });
            if (ctor == null) {
                PrintClassNameOnce(curType);
                Console.WriteLine("{0} - Has NO public (String, Exception) constructor.", curType.Name);
            }
            //
            ctor = curType.GetConstructor(BindingFlags.NonPublic | BindingFlags.Instance, null, new Type[] { 
                typeof(System.Runtime.Serialization.SerializationInfo), 
                typeof(System.Runtime.Serialization.StreamingContext ) }, null);
            if (ctor == null) {
                PrintClassNameOnce(curType);
                Console.WriteLine("{0} - Has NO (SerializationInfo, StreamingContext) constructor.", curType.Name);
            } else if (!(ctor.IsPublic || ctor.IsFamily || ctor.IsFamilyOrAssembly)) {
                PrintClassNameOnce(curType);
                Console.WriteLine("{0} - Has NO public/protected (SerializationInfo, StreamingContext) constructor.", curType.Name);
            }
        }


        //private void __CheckOtherExceptionCtors(Type curType)
        //{
        //    String message = "Some message " + m_rnd.Next().ToString() + ".";
        //    Exception innerException = new RankException("Some innerException.");
        //    //
        //    Exception instDefaultCtor;
        //    try {
        //        instDefaultCtor = (Exception)Activator.CreateInstance(curType);
        //    } catch (MissingMethodException) {
        //        instDefaultCtor = null;
        //        PrintClassNameOnce(curType);
        //        Console.WriteLine("{0} - Has NO default constructor.", curType.Name);
        //    }
        //    //
        //    Exception instStringCtor;
        //    try {
        //        instStringCtor = (Exception)Activator.CreateInstance(curType, message);
        //    } catch (MissingMethodException) {
        //        instStringCtor = null;
        //        PrintClassNameOnce(curType);
        //        Console.WriteLine("{0} - Has NO (String) constructor.", curType.Name);
        //    }
        //    //
        //    Exception instSerializationCtor;
        //    try {
        //        instStringCtor = (Exception)Activator.CreateInstance(curType, );
        //    } catch (MissingMethodException) {
        //        instStringCtor = null;
        //        PrintClassNameOnce(curType);
        //        Console.WriteLine("{0} - Has NO (String) constructor.", curType.Name);
        //    }
        //}

        private void PrintClassNameOnce(Type curType)
        {
            if (!m_curPrinted) {
                m_curPrinted = true;
                Console.WriteLine("* {0}", curType.FullName);
            }
        }

        private Int32 GetHResultValue(Exception exception)
        {
            if (exception == null) {
                return -1;
            }
            PropertyInfo prop = typeof(Exception).GetProperty("HResult", BindingFlags.Instance | BindingFlags.NonPublic);
            Int32 hresult = (Int32)prop.GetValue(exception, null);
            return hresult;
        }


    }//class
}
