#define CALL_BEEP_TO_GET_A_KNOWN_WIN32_ERROR_CODE

using System;
using System.Collections.Generic;
using System.Text;
using System.Reflection;

class MonoBug05bExceptionHresultConsistency
{
    static void Main(string[] args)
    {
        MonoBug05bExceptionHresultConsistency inst = new MonoBug05bExceptionHresultConsistency();
        Console.WriteLine("---- CORLIB ----");
        inst.CheckHresultConsistencyOnAllExceptionsInSameAssemblyAs(typeof(Exception));
        Console.WriteLine("---- System ----");
        inst.CheckHresultConsistencyOnAllExceptionsInSameAssemblyAs(typeof(System.Net.Sockets.Socket));
    }


    //----------------------------------------------------------------------
    void CheckHresultConsistencyOnAllExceptionsInSameAssemblyAs(Type aTypeInTheTargetAssembly)
    {
        Assembly assm = aTypeInTheTargetAssembly.Assembly;
        CheckHresultConsistencyOnAllExceptionsAssembly(assm);
    }

    void CheckHresultConsistencyOnAllExceptionsAssembly(Assembly assm)
    {
        Type[] allTypes = assm.GetTypes();
        foreach (Type curType in allTypes) {
            if (!curType.IsSubclassOf(typeof(Exception))) { continue; }
            Console.WriteLine("* {0}", curType.FullName);
            ConstructorInfo[] ctors = curType.GetConstructors(BindingFlags.Instance | BindingFlags.Public);
            int hresult = 99;
            bool firstUsedCtor = true;
            for (int i = 0; i < ctors.Length; ++i) {
                ConstructorInfo curCtor = ctors[i];
                ParameterInfo[] paras = curCtor.GetParameters();
                Object[] args = CreateArgumentArray(paras);
                if (args == null) {
                    Console.Error.Write("!");
                    continue;
                }
                if (curType == typeof(System.ComponentModel.Win32Exception)) {
                    //TODO Do some P/Invoke call to force GetLastError to a known value.
                    CallAKnownFailingPInvokeFunction();
                }
                Exception curTestEx;
                try {
                    curTestEx = (Exception)curCtor.Invoke(args);
                } catch (Exception ex) {
                    Console.WriteLine("Construction failed with: {0}: {1}.", ex.GetType().Name, ex.Message);
                    continue;
                }
                if (firstUsedCtor) {
                    hresult = GetHResultValue(curTestEx);
                    firstUsedCtor = false;
                } else {
                    Int32 newHresult = GetHResultValue(curTestEx);
                    if (newHresult != hresult) {
                        Console.WriteLine("Inconsistent HResult, was 0x{0:X}, now 0x{1:X}.", hresult, newHresult);
                        PrintParameterInfoArray(paras);
                    }
                }
            }//for
        }//for
    }


    [System.Runtime.InteropServices.DllImport("kernel32.dll", SetLastError = true)]
    [return: System.Runtime.InteropServices.MarshalAs(System.Runtime.InteropServices.UnmanagedType.Bool)]
    static extern bool Beep(uint dwFreq, uint dwDuration);


    void CallAKnownFailingPInvokeFunction()
    {
#if CALL_BEEP_TO_GET_A_KNOWN_WIN32_ERROR_CODE
        // Fails with Marshal.GetLastWin32Error() = 87
        bool success = Beep(UInt32.MaxValue, 0);
#endif
    }

    private static void PrintParameterInfoArray(ParameterInfo[] paras)
    {
        Console.Write("    (Params: {");
        String sep = String.Empty;
        foreach (ParameterInfo curParam in paras) {
            Console.Write(sep + curParam);
            sep = ", ";
        }
        Console.WriteLine("})");
    }

    Object[] CreateArgumentArray(ParameterInfo[] paras)
    {
        Object[] args = new Object[paras.Length];
        for (int i = 0; i < paras.Length; ++i) {
            ParameterInfo curParam = paras[i];
            Type curParamType = curParam.ParameterType;
            if (curParamType == typeof(String)) {
                args[i] = "my text.";
            } else if (curParamType == typeof(Exception) || curParamType.IsSubclassOf(typeof(Exception))) {
                args[i] = new RankException("my exception");
            } else if (curParamType.IsPrimitive) {
                if ("errorCode".Equals(curParam.Name, StringComparison.Ordinal)
                    || "error".Equals(curParam.Name, StringComparison.Ordinal)
                    || "hresult".Equals(curParam.Name, StringComparison.Ordinal)
                    || "hr".Equals(curParam.Name, StringComparison.Ordinal)
                    ) {
                    Console.WriteLine("Skipping a constructor with errorCode/hresult argument.");
                    return null;
                }
                args[i] = 999;
            } else {
                Console.WriteLine("Skipping a constructor with an argument of type: {0}.", curParamType.Name);
                return null;
            }
            //args[i] = default(curType);
        }//for
        return args;
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
