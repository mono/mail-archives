namespace GtkSamples 
{
	using System;
	using System.Drawing;
	using System.Runtime.InteropServices;
	using System.Reflection;
	using Gtk;
	using GtkSharp;

	public class TreeViewDemo
	{
		private static void CellDataA (Gtk.TreeViewColumn tree_column, Gtk.CellRenderer cell, Gtk.TreeModel tree_model, Gtk.TreeIter iter)
		{
			((CellRendererText) cell).Text = "a";
		}
        
		public static void Main (string[] args)
		{
			Application.Init ();

			TreeStore store = new TreeStore(typeof(string));
			string[] combs = {"foo", "bar", "baz", "quux"};
			foreach (string a in combs) 
				store.AppendValues (a);

			Window win = new Window ("TreeView demo");
			TreeView tv = new TreeView (store);
			tv.HeadersVisible = true;

			CellRendererText txt = new CellRendererText ();
			TreeViewColumn col = tv.AppendColumn ("One", txt, "text", 0);
			col.SetCellDataFunc(txt, new TreeCellDataFunc (CellDataA), new IntPtr(0), 
				new DestroyNotify(My));

			win.Add(tv);
			win.ShowAll ();
			Application.Run ();
		}

		public static void My()
		{
		}//DestroyNotifyNative
	}
}
