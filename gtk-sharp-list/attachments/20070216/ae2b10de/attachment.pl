using Gtk;
using System;

namespace TreeViewTest
{
	public class MainWindow : Window
	{
		TreeView tv = new TreeView();
		TreeStore store = new TreeStore(typeof(string), typeof(bool));
		CellRendererToggle toggle_c = new CellRendererToggle();
		
		public MainWindow() : base("MainWindow")
		{
			DeleteEvent += new DeleteEventHandler(MainWindowDeleteEvent);
			
			TreeIter iter2;
			iter2 = store.AppendValues("Pete J", true);
				iter2 = store.AppendValues(iter2, "Petteri K", true);
				iter2 = store.AppendValues(iter2, "Clint Eastwood", false);
			store.AppendValues("Bruce Lee", false);
			store.AppendValues("John Wayne", false);
			
			tv.Model = store;

			tv.AppendColumn("Property", new CellRendererText(), "text", 0);
			toggle_c.Toggled += delegate(object o, ToggledArgs args) {
				TreeIter iter;
				if (store.GetIter(out iter, new TreePath(args.Path))) {
					store.SetValue(iter, 1, !toggle_c.Active);
				}
			};
			
			tv.AppendColumn("Enabled", toggle_c, "active", 1);
			
			ScrolledWindow Sw = new ScrolledWindow();
			Sw.Add(tv);
			Add(Sw);
			
			ShowAll();
		}
	
		[STAThread]
		public static void Main(string[] arg)
		{
			Application.Init();
			new MainWindow();
			Application.Run();
		}
	
		void MainWindowDeleteEvent(object o, DeleteEventArgs args)
		{
			Application.Quit();
			args.RetVal = true;
		}	
	}
}