using System;

namespace FloatDraggingTest
{
	/// <summary>
	/// Main window.
	/// </summary>
	class MainWindow : Gtk.Window
	{
		/// <summary>
		/// Application entry point.
		/// </summary>
		public static void Main(string[] args)
		{
			Gtk.Application.Init();
			MainWindow win = new MainWindow();
			win.ShowAll();
			Gtk.Application.Run();
		}


		/// <summary>
		/// Main window default constructor.
		/// </summary>
		public MainWindow()
			: base(Gtk.WindowType.Toplevel)
		{
			floatWidget = new FloatWidget("Click Me");
			Add(floatWidget);

			DeleteEvent += OnDeleteEvent;
		}

		/// <summary>
		/// Called when the window is deleted, stops the application.
		/// </summary>
		/// <param name="o"></param>
		/// <param name="args"></param>
		void OnDeleteEvent(object o, Gtk.DeleteEventArgs args)
		{
			Gtk.Application.Quit();
		}


		private FloatWidget floatWidget;

	}


	/// <summary>
	/// A widget that you can grab and drag around.
	/// </summary>
	class FloatWidget : Gtk.Button
	{

		/// <summary>
		/// Default constructor.
		/// </summary>
		/// <param name="text"> Text to display on the widget.</param>
		public FloatWidget(string text)
			: base(new Gtk.Label(text))
		{
			// create the float window
			floatWindow = new Gtk.Window(Gtk.WindowType.Toplevel);
			floatWindow.Decorated = false;

			AddEvents((int)Gdk.EventMask.AllEventsMask); // add all events
		}

		private Gtk.Window floatWindow;

		private bool grabbed = false;

		private Gdk.Point grabPoint;

		protected override bool OnButtonPressEvent(Gdk.EventButton evnt)
		{
			grabbed = true;
			int grabX, grabY;
			GetPointer(out grabX, out grabY);
			grabPoint = new Gdk.Point(grabX, grabY);
			return true;
		}

		protected override bool OnButtonReleaseEvent(Gdk.EventButton evnt)
		{
			grabbed = false;
			return true;
		}

		protected override bool OnMotionNotifyEvent(Gdk.EventMotion evnt)
		{
			if (grabbed) // the window has been grabbed
			{
				if (Parent != floatWindow) // it isn't floating yet, float it
				{
					Reparent(floatWindow);
					floatWindow.ShowAll();
				}
				MoveToCursor();
			}

			return true;
		}

		protected override bool OnLeaveNotifyEvent(Gdk.EventCrossing evnt)
		{
			if (grabbed)
				MoveToCursor();
			return true;
		}

		/// <summary>
		/// Moves the floating window to the cursor.
		/// </summary>
		protected void MoveToCursor()
		{
			int cursorX, cursorY, windowX, windowY;
			GetPointer(out cursorX, out cursorY);
			GdkWindow.GetPosition(out windowX, out windowY);
			floatWindow.GdkWindow.Move(windowX + cursorX - grabPoint.X, windowY + cursorY - grabPoint.Y);
			Display.Sync();
		}

	}


}