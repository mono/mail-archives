Index: Application.cs
===================================================================
--- Application.cs	(revision 62701)
+++ Application.cs	(working copy)
@@ -38,6 +38,9 @@
 using System.Reflection;
 using System.Runtime.InteropServices;
 using System.Threading;
+#if NET_2_0
+using System.Windows.Forms.VisualStyles;
+#endif
 
 namespace System.Windows.Forms {
 	public sealed class Application {
@@ -141,6 +144,9 @@
 		private static InputLanguage		input_language		= InputLanguage.CurrentInputLanguage;
 		private static string			safe_caption_format	= "{1} - {0} - {2}";
 		private static ArrayList		message_filters		= new ArrayList();
+#if NET_2_0
+		private static VisualStyleState visual_style_state = VisualStyleState.ClientAndNonClientAreasEnabled;
+#endif
 
 		private Application () {
 		}
@@ -309,6 +315,35 @@
 				return key;
 			}
 		}
+
+#if NET_2_0
+		public static bool RenderWithVisualStyles {
+		      get {
+				if (VisualStyleInformation.IsSupportedByOS)
+				{
+					if (!VisualStyleInformation.IsEnabledByUser)
+						return false;
+				  
+					if (!XplatUI.ThemesEnabled)
+						return false;
+				  
+					if (Application.VisualStyleState == VisualStyleState.ClientAndNonClientAreasEnabled)
+						return true;
+				  
+					if (Application.VisualStyleState == VisualStyleState.ClientAreaEnabled)
+				  		return true;
+				}
+				
+				return false;
+		      }
+		}
+
+		public static VisualStyleState VisualStyleState {
+			get { return Application.visual_style_state; }
+			set { Application.visual_style_state = value; }
+		}
+#endif
+
 		#endregion
 
 		#region Public Static Methods
Index: XplatUI.cs
===================================================================
--- XplatUI.cs	(revision 62701)
+++ XplatUI.cs	(working copy)
@@ -260,6 +260,14 @@
 				return driver.WorkingArea;
 			}
 		}
+
+		public static bool ThemesEnabled {
+			get {
+				return XplatUI.driver.ThemesEnabled;
+			}
+		}
+ 
+
 		#endregion	// Public Static Properties
 
 		#region Events
Index: XplatUIDriver.cs
===================================================================
--- XplatUIDriver.cs	(revision 62701)
+++ XplatUIDriver.cs	(working copy)
@@ -136,6 +136,8 @@
 		internal abstract bool MouseWheelPresent { get; }
 		internal abstract Rectangle VirtualScreen { get; }
 		internal abstract Rectangle WorkingArea { get; }
+		internal abstract bool ThemesEnabled { get; }
+
 		#endregion	// XplatUI Driver Properties
 
                 internal abstract event EventHandler Idle;
Index: XplatUIOSX.cs
===================================================================
--- XplatUIOSX.cs	(revision 62701)
+++ XplatUIOSX.cs	(working copy)
@@ -51,7 +51,7 @@
 		// General driver variables
 		private static XplatUIOSX Instance;
 		private static int RefCount;
-		private static bool ThemesEnabled;
+		private static bool themes_enabled;
 		private static IntPtr FocusWindow;
 
 		// Mouse 
@@ -759,7 +759,7 @@
 		}
 
 		internal override void EnableThemes() {
-			ThemesEnabled = true;
+			themes_enabled = true;
 		}
 
 		internal override void Activate(IntPtr handle) {
@@ -1847,6 +1847,13 @@
 				return new Rectangle ((int)bounds.origin.x, (int)bounds.origin.y, (int)bounds.size.width, (int)bounds.size.height);
 			}
 		}
+		internal override bool ThemesEnabled {
+			get {
+				return XplatUIOSX.themes_enabled;
+			}
+		}
+ 
+
 		#endregion
 		
 		[DllImport("/System/Library/Frameworks/Carbon.framework/Versions/Current/Carbon")]
Index: XplatUIWin32.cs
===================================================================
--- XplatUIWin32.cs	(revision 62701)
+++ XplatUIWin32.cs	(working copy)
@@ -1042,6 +1042,14 @@
 				//return new Rectangle(0, 0, Win32GetSystemMetrics(SystemMetrics.SM.SM_CXSCREEN), Win32GetSystemMetrics(SystemMetrics.SM_CYSCREEN));
 			}
 		}
+
+		internal override bool ThemesEnabled {
+			get {
+				return XplatUIWin32.themes_enabled;
+			}
+		}
+ 
+
 		#endregion	// Static Properties
 
 		#region Singleton Specific Code
Index: XplatUIX11.cs
===================================================================
--- XplatUIX11.cs	(revision 62701)
+++ XplatUIX11.cs	(working copy)
@@ -73,7 +73,7 @@
 		static volatile XplatUIX11	Instance;
 		private static int		RefCount;
 		private static object		XlibLock;		// Our locking object
-		private static bool		ThemesEnabled;
+		private static bool		themes_enabled;
 
 		// General X11
 		private static IntPtr		DisplayHandle;		// X11 handle to display
@@ -1885,7 +1885,15 @@
 
 				return new Rectangle(0, 0, attributes.width, attributes.height);
 			}
-		} 
+		}
+
+		internal override bool ThemesEnabled {
+			get {
+				return XplatUIX11.themes_enabled;
+			}
+		}
+ 
+
 		#endregion	// Public properties
 
 		#region Public Static Methods
@@ -1908,7 +1916,7 @@
 		}
 
 		internal override void EnableThemes() {
-			ThemesEnabled = true;
+			themes_enabled = true;
 		}
 
 
