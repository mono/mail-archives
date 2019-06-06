using System;
using System.Windows.Forms;
using System.Text;
using System.Drawing;

namespace vs8
{
	class Program
	{
		static void Main0 (string[] args)
		{
			Application.Run (new MF ());
		}
	}

	class MF : Form
	{
		public MF ()
		{
			MainMenu mm = new MainMenu ();
			MenuItem mi = new MenuItem ("New");
			mm.MenuItems.Add (mi);
			this.Menu = mm;
		}
	}
}
