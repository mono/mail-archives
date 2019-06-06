using System;
using Gtk;

public class TreeViewExample
{
    
	public static void Main ()
	{
		Gtk.Application.Init ();
		new TreeViewExample ();
		Gtk.Application.Run ();
		Console.WriteLine( "la lang" );
	}
	
	public TreeViewExample ()
	{
		// Create a Window
		Gtk.Window window = new Gtk.Window ("TreeView Example");
		window.SetSizeRequest (500,200);
 
		// Create our TreeView
		Gtk.TreeView tree = new Gtk.TreeView ();
 
		// Add our tree to the window
		window.Add (tree);
 
		// Create a column for the artist name
		Gtk.TreeViewColumn artistColumn = new Gtk.TreeViewColumn ();
		artistColumn.Title = "Artist";
 
		// Create the text cell that will display the artist name
		Gtk.CellRendererText artistNameCell = new Gtk.CellRendererText ();
		
		// Add the cell to the column
		artistColumn.PackStart (artistNameCell, true);
 
		// Create a column for the song title
		Gtk.TreeViewColumn songColumn = new Gtk.TreeViewColumn ();
		songColumn.Title = "Song Title";
 
		// Do the same for the song title column
		Gtk.CellRendererText songTitleCell = new Gtk.CellRendererText ();
		songColumn.PackStart (songTitleCell, true);
 
		// Add the columns to the TreeView
		tree.AppendColumn (artistColumn);
		tree.AppendColumn (songColumn);
 
		// Tell the Cell Renderers which items in the model to display
		artistColumn.AddAttribute (artistNameCell, "text", 0);
		songColumn.AddAttribute (songTitleCell, "text", 1);
 
		// Create a model that will hold two strings - Artist Name and Song Title
		Gtk.ListStore musicListStore = new Gtk.ListStore (typeof (string), typeof (string));
 
		// Add some data to the store
		musicListStore.AppendValues ("Garbage", "Dog New Tricks");
		TreeIter yourIter = musicListStore.AppendValues ("SampleData", "SampleData2");
 
		// Assign the model to the TreeView
		tree.Model = musicListStore;
 
    tree.SetCursor( musicListStore.GetPath( yourIter ), tree.GetColumn(1), false );
 
		// Show the window and everything on it
		window.ShowAll ();
	}
}
