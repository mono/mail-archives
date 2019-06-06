Index: FileDialog.cs
===================================================================
--- FileDialog.cs	(revision 108606)
+++ FileDialog.cs	(working copy)
@@ -940,7 +940,7 @@
 
 				if (checkFileExists) {
 					if (!File.Exists (internalfullfilename)) {
-						string message = "\"" + internalfullfilename + "\" doesn't exist. Please verify that you have entered the correct file name.";
+						string message = "\"" + internalfullfilename + "\" does not exist. Please verify that you have entered the correct file name.";
 						MessageBox.Show (message, openSaveButton.Text, MessageBoxButtons.OK, MessageBoxIcon.Warning);
 						return;
 					}
@@ -949,7 +949,7 @@
 				if (fileDialogType == FileDialogType.SaveFileDialog) {
 					if (overwritePrompt) {
 						if (File.Exists (internalfullfilename)) {
-							string message = "\"" + internalfullfilename + "\" exists. Overwrite ?";
+							string message = "\"" + internalfullfilename + "\" already exists. Do you want to overwrite it?";
 							DialogResult dr = MessageBox.Show (message, openSaveButton.Text, MessageBoxButtons.OKCancel, MessageBoxIcon.Warning);
 							if (dr == DialogResult.Cancel)
 								return;
@@ -958,7 +958,7 @@
 
 					if (createPrompt) {
 						if (!File.Exists (internalfullfilename)) {
-							string message = "\"" + internalfullfilename + "\" doesn't exist. Create ?";
+							string message = "\"" + internalfullfilename + "\" does not exist. Do you want to create it?";
 							DialogResult dr = MessageBox.Show (message, openSaveButton.Text, MessageBoxButtons.OKCancel, MessageBoxIcon.Warning);
 							if (dr == DialogResult.Cancel)
 								return;
@@ -994,7 +994,7 @@
 
 			if (checkPathExists && mwfFileView.CurrentRealFolder != null) {
 				if (!Directory.Exists (mwfFileView.CurrentRealFolder)) {
-					string message = "\"" + mwfFileView.CurrentRealFolder + "\" doesn't exist. Please verify that you have entered the correct directory name.";
+					string message = "\"" + mwfFileView.CurrentRealFolder + "\" does not exist. Please verify that you have entered the correct directory name.";
 					MessageBox.Show (message, openSaveButton.Text, MessageBoxButtons.OK, MessageBoxIcon.Warning);
 
 					if (InitialDirectory.Length == 0 || !Directory.Exists (InitialDirectory))
@@ -3339,7 +3339,7 @@
 				} else
 					File.Move (sourceFileName, destFileName);
 			} catch (Exception e) {
-				MessageBox.Show (e.Message, "Error Renaming Folder",
+				MessageBox.Show (e.Message, "Error Renaming File",
 					MessageBoxButtons.OK, MessageBoxIcon.Error);
 				return false;
 			}
