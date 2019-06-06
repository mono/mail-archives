using System;
using System.Windows.Forms;
using System.Text;
using System.Drawing;

namespace vs8
{
	class Program
	{
		static void Main (string[] args)
		{
			Application.Run (new MF ());
		}
	}

	class MF : Form
	{
		public MF ()
		{
			ComboBox cb = new ComboBox ();
			cb.Items.AddRange (new string [] {"Apple", "Banana", "Cherry", "Date", "Elephant", "Fig", "Grape", "Helicopter", "Igloo" });
			this.Controls.Add (cb);
		}
	}
}
