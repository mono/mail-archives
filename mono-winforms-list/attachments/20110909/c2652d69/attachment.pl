using System;
using System.Windows.Forms;
using System.Drawing;


public class Test: Form
{
	public Test (string tb_text)
	{
		Button button1 = new Button ();
		Button button2 = new Button ();
		TextBox textbox = new TextBox();
		
		SuspendLayout ();
		
		button1.Location = new Point (3, 3);
		button1.Size = new Size (75, 23);
		button1.Text = "\x61\x301 \x65\x301 \x69\x301 \x6f\x301 \x75\x301 !";

		button2.Location = new Point (82, 3);
		button2.Size = new Size (75, 23);
		button2.Text = "\xe1 \xe9 \xed \xf3 \xfa !";

		textbox.Location = new Point (3, 30);
		textbox.Size = new Size (150, 20);
		textbox.Text = tb_text;
		
		ClientSize = new Size (200, 60);
		Controls.Add (button1);
		Controls.Add (button2);
		Controls.Add (textbox);
		
		Text = "Test";
		
		ResumeLayout (false);
	}
}

public class RunIt
{
	public static void Main (string[] args)
	{		
		string text = "hello world";

		if (args.Length > 0) {
			text = args[0];
		}

		Application.Run (new Test (text));
	}
}
