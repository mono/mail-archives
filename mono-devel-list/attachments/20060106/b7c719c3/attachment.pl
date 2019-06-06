using System;
using Gtk;
using Glade;
using Gecko;
using System.Reflection;

namespace WinFormTest
{
	class GeckoSharpWin
	{
		[Glade.Widget] Gtk.Button btnBack = null;
		[Glade.Widget] Gtk.Button btnFwd = null;
		[Glade.Widget] Gtk.Button btnRefresh = null;
		[Glade.Widget] Gtk.Label lblLocation = null;
		[Glade.Widget] Gtk.VBox vbox1 = null;
		[Glade.Widget] Gtk.Window GeckoSharp = null;
		Gecko.WebControl web = null;

		public GeckoSharpWin()
		{
			try
			{
				// Get the GRE for Gecko# Path in Windows systems
				String mozillaEnvPath = System.Environment.GetEnvironmentVariable("GECKOSHILLA_BASEPATH");

				if (mozillaEnvPath != null &&
					mozillaEnvPath != string.Empty)
					Gecko.WebControl.CompPath = mozillaEnvPath;
			}
			catch (Exception e)
			{
				Console.WriteLine(e.ToString());
			}
		}

		~GeckoSharpWin()
		{
			this.Dispose();
		}

		public void Show(string url)
		{
			Glade.XML xml = null;
			System.IO.Stream s = null;

			try
			{
				Application.Init();

				try
				{
					Assembly a = Assembly.GetExecutingAssembly();
					s = a.GetManifestResourceStream("WinFormTest.GeckoSharp.glade");

					xml = new Glade.XML(s, "GeckoSharp", null);
					xml.Autoconnect(this);
				}
				finally
				{
					if (s != null)
						s.Close();
					if (xml != null)
						xml.Dispose();
				}

				//GeckoSharp = new Window ("Gecko#");

				//glade.Dispose();
				this.GeckoSharp.WidthRequest = 1280;
				this.GeckoSharp.HeightRequest = 1024;
				this.GeckoSharp.Resizable = false;
				this.GeckoSharp.DeleteEvent += new DeleteEventHandler(this.OnWindowDelete);

				this.btnBack.Clicked += new EventHandler(this.OnButton);
				this.btnFwd.Clicked += new EventHandler(this.OnButton);
				this.btnRefresh.Clicked += new EventHandler(this.OnButton);

				if (web == null)
				{
					web = new WebControl();
					web.LocChange += new EventHandler(this.OnLocationChange);
					web.NewWindow += new NewWindowHandler(this.OnNewWindow);
					//web.ChromeMask = (uint)(ChromeFlags.Toolbaron | ChromeFlags.Statusbaron);
					web.Show();
				}
				web.LoadUrl(url);

				this.vbox1.Add(web);
				this.GeckoSharp.ShowAll();
				Gtk.Application.Run();
			}
			catch (Exception e)
			{
				Console.WriteLine(e.ToString());
			}
		}

		private void OnNewWindow(object o, NewWindowArgs nwa)
		{
			int i = 1;
//			nwa.NewEmbed.Show();
		}

		private void OnButton(object o, EventArgs ea)
		{
			if (o == this.btnBack)
				this.web.GoBack();
			else if (o == this.btnFwd)
				this.web.GoForward();
			else if (o == this.btnRefresh)
				this.web.Reload(Convert.ToInt32(ReloadFlags.Reloadnormal));
		}

		private void OnLocationChange(object o, EventArgs ea)
		{
			this.lblLocation.Text = this.web.Location;
		}

		private void OnWindowDelete(object o, DeleteEventArgs dea)
		{
			try
			{
				this.GeckoSharp.Remove(web);
				this.web.Hide();
				//this.web.Destroy();
				//this.web.Dispose();
				this.GeckoSharp.Destroy();
				this.GeckoSharp.Dispose();
				//this.glade.Dispose();
				Application.Quit();
				//this.GeckoSharp.Hide();
			}
			catch (Exception e)
			{
				Console.WriteLine(e.ToString());
			}
		}

		public void Dispose()
		{
			if (this.web != null)
			{
				this.web.Destroy();
				this.web.Dispose();
			}
		}
	}
}

