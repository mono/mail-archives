// 
// System.IO.INotifyWatcher.cs: interface with inotify
//
// (c) 2004 Novell, Inc.
//

//
// Permission is hereby granted, free of charge, to any person obtaining
// a copy of this software and associated documentation files (the
// "Software"), to deal in the Software without restriction, including
// without limitation the rights to use, copy, modify, merge, publish,
// distribute, sublicense, and/or sell copies of the Software, and to
// permit persons to whom the Software is furnished to do so, subject to
// the following conditions:
// 
// The above copyright notice and this permission notice shall be
// included in all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
// LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
// OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
// WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

using System;
using System.Collections;
using System.ComponentModel;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading;

namespace System.IO 
{
	class INotifyWatcher : IFileWatcher
	{
		[Flags]
		private enum EventType : uint 
		{
			Access         = 0x00000001, // File was accessed
			Modify         = 0x00000002, // File was modified
			Attrib         = 0x00000004, // File changed attributes
			CloseWrite     = 0x00000008, // Writable file was closed
			CloseNoWrite   = 0x00000010, // Non-writable file was close
			Open           = 0x00000020, // File was opened
			MovedFrom      = 0x00000040, // File was moved from X
			MovedTo        = 0x00000080, // File was moved to Y
			DeleteSubdir   = 0x00000100, // Subdir was deleted
			DeleteFile     = 0x00000200, // Subfile was deleted
			CreateSubdir   = 0x00000400, // Subdir was created
			CreateFile     = 0x00000800, // Subfile was created
			DeleteSelf     = 0x00001000, // Self was deleted
			Unmount        = 0x00002000, // Backing fs was unmounted
			QueueOverflow  = 0x00004000, // Event queue overflowed
			Ignored        = 0x00008000, // File is no longer being watched
			All            = 0xffffffff
		}

		[StructLayout (LayoutKind.Sequential)]
		private struct inotify_event 
		{
			public int       wd;
			public EventType mask;
			public uint      cookie;
			[MarshalAs (UnmanagedType.ByValArray, SizeConst=256)]
			public byte[]    filename;
		}

		private class Watched 
		{
			public int       Wd;
			public string    Path;
			public EventType Mask;
			
			public FileSystemWatcher FSW;
			public bool		 Recursive;
			public bool		 Enabled;

			public Hashtable Children;

			public EventType FilterMask;
			public EventType FilterSeen;
		}
	
		/////////////////////////////////////////////////////////////////////////////////////

		[DllImport ("libinotifyglue")]
		static extern int inotify_glue_open ();

		[DllImport ("libinotifyglue")]
		static extern void inotify_glue_init ();

		[DllImport ("libinotifyglue")]
		static extern int inotify_glue_watch (int fd, string filename, EventType mask);

		[DllImport ("libinotifyglue")]
		static extern int inotify_glue_ignore (int fd, int wd);

		[DllImport ("libinotifyglue")]
		static extern unsafe void inotify_snarf_events (int fd, 
			int timeout_seconds,
			out int num_read,
			out IntPtr buffer);
	
		/////////////////////////////////////////////////////////////////////////////////////
		
		static bool failed;
		static INotifyWatcher instance;
		static bool stop;
		
		static private int dev_inotify = -1;
		static private Queue event_queue = new Queue ();

		static INotifyWatcher ()
		{
			inotify_glue_init ();

			dev_inotify = inotify_glue_open ();
			if (dev_inotify == -1)
				throw new Exception ("Could not open inotify device");

			Start ();
		}	

		private INotifyWatcher ()
		{
		}
		
		public static bool GetInstance (out IFileWatcher watcher)
		{
			lock (typeof (INotifyWatcher)) {
				if (failed == true) {
					watcher = null;
					return false;
				}

				if (instance != null) {
					watcher = instance;
					return true;
				}

				try 
				{
					instance = new INotifyWatcher ();
					watcher = instance;
					return true;
				} 
				catch (Exception e) 
				{
					failed = true;
					watcher = null;
					return false;
				}
			}
		}

		static Hashtable watched_by_fsw = new Hashtable ();
		static Hashtable watched_by_wd = new Hashtable ();
		static Hashtable watched_by_path = new Hashtable ();
		static Watched   last_watched = null;

		public void StartDispatching (FileSystemWatcher fsw)
		{
			Watched data;
			
			lock (watched_by_fsw) 
			{
				data = (Watched) watched_by_fsw [fsw];
			}
			if (data == null) 
			{
				data = new Watched ();
				data.FSW = fsw;
				data.Path = fsw.FullPath;
				// FIXME: Support masks
				data.Mask = EventType.All;
				data.Recursive = fsw.IncludeSubdirectories;
				if (data.Recursive)
					data.Children = new Hashtable ();

				data.Enabled = true;

				lock (this) 
				{
					Watch (data);
					watched_by_fsw [fsw] = data;
					stop = false;
				}
			}
		}

		static private void Watch (Watched root)
		{
			Queue to_watch = new Queue ();
		
			to_watch.Enqueue (root);

			while (to_watch.Count > 0) 
			{
				Watched watched = (Watched) to_watch.Dequeue ();

				int wd = -1;
			
				lock (watched_by_wd) 
				{
					wd = inotify_glue_watch (dev_inotify, watched.Path, EventType.All);
					if (wd < 0) 
					{
						string msg = String.Format ("Attempt to watch {0} failed!", watched.Path);
						throw new Exception (msg);
					}
					
					watched.Wd = wd;
		
					watched_by_wd [watched.Wd] = watched;
					watched_by_path [watched.Path] = watched;
				}

				if (root.Recursive) 
				{
					DirectoryInfo dir = new DirectoryInfo (watched.Path);
					foreach (DirectoryInfo subdir in dir.GetDirectories ()) 
					{
						Watched child = new Watched ();
						child.FSW = watched.FSW;
						child.Path = subdir.FullName;
						child.Enabled = true;
						root.Children [subdir.FullName] = child;

						to_watch.Enqueue (child);
					}
				}
			}
		}

		public void StopDispatching (FileSystemWatcher fsw)
		{
			Watched data;
			lock (this) {
				data = (Watched) watched_by_fsw [fsw];
				if (data == null)
					return;

				Forget (data);
				
				if (watched_by_fsw.Count == 0)
					stop = true;

				if (!data.Recursive)
					return;

				foreach (Watched child in data.Children) {
					Forget (child);
				}
			}
		}

		static private void Forget (Watched watched)
		{
			if (last_watched == watched)
				last_watched = null;

			if ( (Watched)watched_by_wd [watched.FSW] == watched)
				watched_by_fsw.Remove (watched.FSW);

			watched_by_wd.Remove (watched.Wd);
			watched_by_path.Remove (watched.Path);

			if (watched.Children == null || watched.Children.Count == 0)
				return;

			foreach (Watched child in watched.Children)
				Forget (child);
		}
		
		// Filter Watched items when we do the Lookup.
		// We do the filtering here to avoid having to acquire
		// the watched_by_wd lock yet again.
		static private Watched Lookup (int wd, EventType event_type)
		{
			lock (watched_by_wd) 
			{
				Watched watched;
				if (last_watched != null && last_watched.Wd == wd) 
				{
					watched = last_watched;
				} 
				else 
				{
					watched = watched_by_wd [wd] as Watched;
					if (watched != null)
						last_watched = watched;
				}

				if (watched != null && (watched.FilterMask & event_type) != 0) 
				{
					watched.FilterSeen |= event_type;
					watched = null;
				}

				return watched;
			}
		}

		/////////////////////////////////////////////////////////////////////////////////////

		static Thread snarf_thread = null;
		static Thread dispatch_thread = null;
		static bool   running = false;

		static public void Start ()
		{
			lock (event_queue) 
			{
				if (snarf_thread != null)
					return;
				
				running = true;

				snarf_thread = new Thread (new ThreadStart (SnarfWorker));
				snarf_thread.Start ();

				dispatch_thread = new Thread (new ThreadStart (DispatchWorker));
				dispatch_thread.Start ();
			}
		}

		static public void Stop ()
		{
			lock (event_queue) 
			{
				running = false;
				Monitor.Pulse (event_queue);
			}
		}

		static unsafe void SnarfWorker ()
		{
			while (running) 
			{
				// We get much better performance if we wait a tiny bit
				// between reads in order to let events build up.
				// FIXME: We need to be smarter here to avoid queue overflows.
				Thread.Sleep (15);

				IntPtr buffer;
				int num_events;

				// Will block while waiting for events, but with a 1s timeout.
				inotify_snarf_events (dev_inotify, 
					1, 
					out num_events,
					out buffer);

				if (!running)
					break;

				if (num_events == 0)
					continue;

				DateTime now = DateTime.Now;
				lock (event_queue) 
				{
					bool saw_overflow = false;
					for (int i = 0; i < num_events; ++i) 
					{
						inotify_event iev;
						iev = (inotify_event)Marshal.PtrToStructure (buffer, typeof (inotify_event));
						buffer = (IntPtr) ((long)buffer + Marshal.SizeOf (typeof (inotify_event)));
						if (iev.mask == EventType.QueueOverflow)
							saw_overflow = true;
						event_queue.Enqueue (iev);
					}

					if (saw_overflow)
						Console.WriteLine ("Inotify queue overflow!");

					Monitor.Pulse (event_queue);
				}
			}
		}

		// FIXME: If we move a directory that is being watched, the
		// watch is preserved, as are the watches on any
		// subdirectories.  This means that our cached value from
		// WatchedInfo.Path will no longer be accurate.  We need to
		// trap MovedFrom and MovedTo, check if the thing being moved
		// is a directory, and then and update our internal data
		// structures accordingly.

		static public bool Verbose = false;

		static void DispatchWorker ()
		{
			Encoding filename_encoding = new ASCIIEncoding ();

			while (running) 
			{
				inotify_event iev;

				lock (event_queue) 
				{
					while (event_queue.Count == 0 && running)
						Monitor.Wait (event_queue);
					if (! running)
						break;
					iev = (inotify_event) event_queue.Dequeue ();
				}

				Watched watched;
				watched = Lookup (iev.wd, iev.mask);
				if (watched == null)
					continue;
				
				// FIXME: Support mask
				//if ((watched.Mask & iev.mask) != 0) 
				if (true)
				{	
					int n_chars = 0;
					while (n_chars < iev.filename.Length && iev.filename [n_chars] != 0)
						++n_chars;

					string filename = "";
					if (n_chars > 0)
						filename = filename_encoding.GetString (iev.filename, 0, n_chars);

					if (Verbose) 
					{
						Console.WriteLine ("*** inotify: {0} {1} {2} {3} {4}",
							iev.mask, watched.Wd, watched.Path,
							filename != "" ? filename : "\"\"",
							iev.cookie);
					}

					// FIXME: Apply filename filter from FSW

					string path = Path.Combine (watched.Path, filename);

					try 
					{
						FileAction fa = 0;
						RenamedEventArgs renamed = null;

						switch (iev.mask)
						{
							// FIXME: We need the destinction between Modify and 
							// CloseWrite, but how do we provider this with FSW?
							case EventType.Modify: 
							case EventType.CloseNoWrite:
								break;
							
							case EventType.CloseWrite:
								fa = FileAction.Modified;
								break;
							
							case EventType.MovedFrom:
								fa = FileAction.RenamedOldName;
								break;
							
							case EventType.MovedTo:
								fa = FileAction.RenamedNewName;
								break;
							
							// FIXME: Remove internal data structures for watched directories being removed
							case EventType.DeleteSubdir: 
							case EventType.DeleteFile:
							case EventType.DeleteSelf:
								fa = FileAction.Removed;
								break;

							case EventType.CreateSubdir:
								fa = FileAction.Added;
								
								// Check if the parent FSW is recursive
								if (! ((Watched)watched_by_fsw [watched.FSW]).Recursive)
									break;

								Watched child = new Watched ();
								child.Path = path;
								child.Enabled = true;
								child.FSW = watched.FSW;
								watched.Children [path] = child;
								Watch (child);

								break;

							case EventType.CreateFile:
								fa = FileAction.Added;
								break;
							
							default:
								break;
						}
						watched.FSW.DispatchEvents (fa, path, ref renamed);
					} 
					catch (Exception e) 
					{
						Console.WriteLine ("Caught exception inside INotifyWatcher");
						Console.WriteLine (e); 
					}
				}

				// If a directory we are watching gets ignored, we need
				// to remove it from the watchedByFoo hashes.
				if (iev.mask == EventType.Ignored) 
				{
					lock (watched_by_wd)
						Forget (watched);
				}
			}
		}
	}
}

