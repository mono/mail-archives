using System;
using System.Runtime.InteropServices;

class Programm
{
	static void Main ()
	{
		Console.WriteLine (get_process_command_line ());
		set_process_command_line ("rootkit");
		Console.WriteLine (get_process_command_line ());

		set_process_command_line ("rootkit rootkit");
		Console.WriteLine (get_process_command_line ());
	}

	[DllImport("__Internal")]
	static extern void set_process_command_line (string line);

	[DllImport("__Internal")]
	static extern string get_process_command_line ();
}
