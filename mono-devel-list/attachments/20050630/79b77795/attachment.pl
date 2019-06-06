--- MsPrjHelper.cs.old	2005-06-30 17:31:04.000000000 +0530
+++ MsPrjHelper.cs	2005-06-30 17:21:33.000000000 +0530
@@ -85,23 +85,34 @@
			string strVersion = null;
			string strInput = null;
			Match match;
-			FileStream fis = new FileStream(strInSlnFile, FileMode.Open, 
FileAccess.Read, FileShare.Read);
-			StreamReader reader = new StreamReader(fis);
-			Regex regex = new Regex(@"Microsoft Visual Studio Solution File, Format 
Version (\d.\d\d)");
+
+			try {
+
+				FileStream fis = new FileStream(strInSlnFile, FileMode.Open, 
FileAccess.Read, FileShare.Read);
+				StreamReader reader = new StreamReader(fis);
+				Regex regex = new Regex(@"Microsoft Visual Studio Solution File, Format 
Version (\d.\d\d)");
+				strInput = reader.ReadLine();
+
+				match = regex.Match(strInput);
+				if (match.Success)
+				{
+					strVersion = match.Groups[1].Value;
+				}

-			strInput = reader.ReadLine();
+				// Close the stream
+				reader.Close();

-			match = regex.Match(strInput);
-			if (match.Success)
-			{
-				strVersion = match.Groups[1].Value;
-			}
+				// Close the File Stream
+				fis.Close();
+			} catch (FileNotFoundException ex) {

-			// Close the stream
-			reader.Close();
+				Console.WriteLine(ex.Message);
+				Environment.Exit(1);
+			} catch (Exception ex) {
+				Console.WriteLine(ex.Message);
+				Environment.Exit(1);

-			// Close the File Stream
-			fis.Close();
+			}

			return strVersion;
		}

