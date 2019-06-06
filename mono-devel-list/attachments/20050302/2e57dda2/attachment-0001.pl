Index: ASCIIEncoding.cs
===================================================================
--- ASCIIEncoding.cs	(revision 41356)
+++ ASCIIEncoding.cs	(working copy)
@@ -35,13 +35,16 @@
 {
 	// Magic number used by Windows for "ASCII".
 	internal const int ASCII_CODE_PAGE = 20127;
+	internal const int ASCII_WINDOWS_CODE_PAGE = 1252;
 
 	// Constructor.
-	public ASCIIEncoding () : base(ASCII_CODE_PAGE) {
+	public ASCIIEncoding () : base(ASCII_CODE_PAGE) 
+	{
 		body_name = header_name = web_name= "us-ascii";
 		encoding_name = "US-ASCII";
 		is_mail_news_display = true;
 		is_mail_news_save = true;
+		windows_code_page = ASCII_WINDOWS_CODE_PAGE;
 	}
 
 	// Get the number of bytes needed to encode a character buffer.
@@ -205,6 +208,7 @@
 		return byteCount;
 	}
 
+#if ! MAINSOFT_JAVA
 	// Decode a buffer of bytes into a string.
 	public override String GetString (byte[] bytes, int index, int count)
 	{
@@ -239,6 +243,7 @@
 			}
 		}
 	}
+#endif
 
 }; // class ASCIIEncoding
 
