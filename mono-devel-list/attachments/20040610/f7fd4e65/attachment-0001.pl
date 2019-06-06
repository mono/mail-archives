using System.Runtime.InteropServices;

public class Test {

  [DllImport("foo.so", CharSet = CharSet.Ansi)]
  public static extern string foo();

  public static void Main() {
    System.Console.WriteLine(foo());
  }
}
