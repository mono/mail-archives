Index: Encoding.cs
===================================================================
--- Encoding.cs	(revision 41356)
+++ Encoding.cs	(working copy)
@@ -157,6 +157,10 @@
 	}
 	public virtual byte[] GetBytes (char[] chars, int index, int count)
 	{
+		if (chars == null) 
+		{
+			throw new ArgumentNullException ("chars");
+		}
 		int numBytes = GetByteCount (chars, index, count);
 		byte[] bytes = new byte [numBytes];
 		GetBytes (chars, index, count, bytes, 0);
@@ -164,6 +168,10 @@
 	}
 	public virtual byte[] GetBytes (char[] chars)
 	{
+		if (chars == null) 
+		{
+			throw new ArgumentNullException ("chars");
+		}
 		int numBytes = GetByteCount (chars, 0, chars.Length);
 		byte[] bytes = new byte [numBytes];
 		GetBytes (chars, 0, chars.Length, bytes, 0);
@@ -217,6 +225,7 @@
 		return new ForwardingEncoder (this);
 	}
 
+#if ! MAINSOFT_JAVA
 	// Loaded copy of the "I18N" assembly.  We need to move
 	// this into a class in "System.Private" eventually.
 	private static Assembly i18nAssembly;
@@ -301,6 +310,7 @@
 			}
 		}
 	}
+#endif
 
 	// Get an encoder for a specific code page.
 #if ECMA_COMPAT
@@ -329,12 +339,14 @@
 			case UnicodeEncoding.BIG_UNICODE_CODE_PAGE:
 				return BigEndianUnicode;
 
+#if ! MAINSOFT_JAVA
 			case Latin1Encoding.ISOLATIN_CODE_PAGE:
 				return ISOLatin1;
-
+#endif
 			default: break;
 		}
 
+#if ! MAINSOFT_JAVA
 		// Try to obtain a code page handler from the I18N handler.
 		Encoding enc = (Encoding)(InvokeI18N ("GetEncoding", codePage));
 		if (enc != null) {
@@ -357,10 +369,12 @@
 		if (type != null) {
 			return (Encoding)(Activator.CreateInstance (type));
 		}
-
 		// We have no idea how to handle this code page.
 		throw new NotSupportedException
 			(String.Format ("CodePage {0} not supported", codePage.ToString ()));
+#else
+       return new OtherEncoding(codePage);
+#endif
 	}
 
 #if !ECMA_COMPAT
@@ -389,8 +403,10 @@
 			UnicodeEncoding.BIG_UNICODE_CODE_PAGE,
 			"unicodefffe", "utf_16be",
 
+#if ! MAINSOFT_JAVA
 			Latin1Encoding.ISOLATIN_CODE_PAGE,
 			"iso_8859_1", "latin1"
+#endif
 		};
 
 	// Get an encoding object for a specific web encoding name.
@@ -401,8 +417,8 @@
 			throw new ArgumentNullException ("name");
 		}
 
+#if ! MAINSOFT_JAVA
 		string converted = name.ToLowerInvariant ().Replace ('-', '_');
-		
 		// Search the table for a name match.
 		int code = 0;
 		for (int i = 0; i < encodings.Length; ++i) {
@@ -440,9 +456,14 @@
 		if (type != null) {
 			return (Encoding)(Activator.CreateInstance (type));
 		}
-
 		// We have no idea how to handle this encoding name.
 		throw new NotSupportedException (String.Format ("Encoding name `{0}' not supported", name));
+#else
+		int cp = EncodingsInfo.getCodePageByName(name);
+		if (cp < 0)
+			throw new ArgumentException (String.Format ("Encoding name `{0}' not supported", name));
+		return GetEncoding (cp);
+#endif
 	}
 
 #endif // !ECMA_COMPAT
@@ -477,6 +498,19 @@
 		return new String (GetChars(bytes));
 	}
 
+#if MAINSOFT_JAVA
+	public virtual string getJavaEncodingName()
+	{
+		EncodingsInfo.CodePageProperties cpProps = EncodingsInfo.getCodePageProperties(CodePage);
+		if (cpProps != null)
+			return cpProps.javaEncodingName;
+
+		return web_name;
+	}
+
+#endif
+
+
 #if !ECMA_COMPAT
 
 	internal string body_name;
@@ -615,6 +649,7 @@
 		}
 	}
 
+#if ! MAINSOFT_JAVA
 	[MethodImpl (MethodImplOptions.InternalCall)]
 	extern internal static string InternalCodePage (ref int code_page);
 	
@@ -656,14 +691,49 @@
 			return defaultEncoding;
 		}
 	}
+#else
+	// Get the default encoding object.
+	public static Encoding Default
+	{
+		get 
+		{
+			if (defaultEncoding == null) 
+			{
+				lock (typeof(Encoding)) 
+				{
+					if (defaultEncoding == null) 
+					{
+						defaultEncoding = UTF8;
+//						try
+//						{
+//							defaultEncoding = GetEncoding(vmw.common.StringUtils.GetDefaultEncodingName());
+//						}
+//						catch (NotSupportedException e)
+//						{
+//							vmw.common.StringUtils.ResetDefaultEncodingName();
+//							defaultEncoding = GetEncoding(vmw.common.StringUtils.GetDefaultEncodingName());
+//						}
+					}
+				}
+			}
+			return defaultEncoding;
+		}
+	}
 
-	// Get the ISO Latin1 encoding object.
-	private static Encoding ISOLatin1
+#endif
+
+#if ! MAINSOFT_JAVA
+		// Get the ISO Latin1 encoding object.
+		private static Encoding ISOLatin1
 	{
-		get {
-			if (isoLatin1Encoding == null) {
-				lock (typeof(Encoding)) {
-					if (isoLatin1Encoding == null) {
+		get 
+		{
+			if (isoLatin1Encoding == null) 
+			{
+				lock (typeof(Encoding)) 
+				{
+					if (isoLatin1Encoding == null) 
+					{
 						isoLatin1Encoding = new Latin1Encoding ();
 					}
 				}
@@ -672,7 +742,7 @@
 			return isoLatin1Encoding;
 		}
 	}
-
+#endif
 	// Get the standard UTF-7 encoding object.
 #if ECMA_COMPAT
 	private
