Index: MenuAPI.cs
===================================================================
--- MenuAPI.cs	(revision 109381)
+++ MenuAPI.cs	(working copy)
@@ -795,9 +795,14 @@
 						GrabControl.ActiveTracker = this;
 					}
 					return true;
+				} else if (CurrentMenu.SelectedItem.IsPopup) {
+					item = CurrentMenu.SelectedItem;
+					ShowSubPopup (CurrentMenu, item);
+					SelectItem (item, item.MenuItems [0], false);
+					CurrentMenu = item;
+				} else {
+					ExecFocusedItem (CurrentMenu, CurrentMenu.SelectedItem);
 				}
-			
-				ExecFocusedItem (CurrentMenu, CurrentMenu.SelectedItem);
 				break;
 				
 			case Keys.Escape:
