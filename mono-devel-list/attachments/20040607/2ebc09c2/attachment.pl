using System;
using System.Runtime.InteropServices;

public class Test {

  public delegate int GLogFuncDelegate(string log_domain, int log_level, string message, object user_data);

  [DllImport("glib-2.0", CharSet = CharSet.Ansi)]
  public static extern int g_log_set_handler(string log_domain, int log_levels, GLogFuncDelegate log_func, IntPtr user_data);

  [DllImport("gthread-2.0", CharSet = CharSet.Ansi)]
  public static extern void g_thread_init(IntPtr vtable);

  int LogFunc(string log_domain, int log_level, string message, object user_data) {
    return 1;
  }

  public static void Main() {
    new Test();
  }
  public Test() {
    g_thread_init(IntPtr.Zero);
    g_log_set_handler("Hello", -1, new GLogFuncDelegate(LogFunc), IntPtr.Zero);
    System.Console.WriteLine("Foo");
  }
}
