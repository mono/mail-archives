Index: System.Web/ChangeLog
===================================================================
--- System.Web/ChangeLog	(revision 60681)
+++ System.Web/ChangeLog	(working copy)
@@ -1,3 +1,7 @@
+2006-05-14  Kazuki Oikawa  <kazuki@panicode.com>
+
+	* HttpUtility.cs: implemented ParseQueryString
+
 2006-05-10 Gonzalo Paniagua Javier <gonzalo@ximian.com>
 
 	* HttpUtility.cs: get rid of TryParseHexa.
Index: System.Web/HttpUtility.cs
===================================================================
--- System.Web/HttpUtility.cs	(revision 60681)
+++ System.Web/HttpUtility.cs	(working copy)
@@ -963,17 +963,54 @@
 #endif
 
 #if NET_2_0
-		[MonoTODO]
 		public static NameValueCollection ParseQueryString (string query)
 		{
-			// LAMESPEC: default encoding not specified
-			throw new NotImplementedException ();
+			return ParseQueryString (query, Encoding.UTF8);
 		}
 
-		[MonoTODO]
 		public static NameValueCollection ParseQueryString (string query, Encoding encoding)
 		{
-			throw new NotImplementedException ();
+			if (query == null)
+				throw new ArgumentNullException ("query");
+			if (encoding == null)
+				throw new ArgumentNullException ("encoding");
+			if (query.Length == 0)
+				return new NameValueCollection ();
+			if (query[0] == '?')
+				query = query.Substring (1);
+
+			int namePos = 0;
+			NameValueCollection collection = new NameValueCollection ();
+			while (namePos <= query.Length) {
+				int valuePos = -1, valueEnd = -1;
+				for (int q = namePos; q < query.Length; q++) {
+					if (valuePos == -1 && query[q] == '=') {
+						valuePos = q + 1;
+					} else if (query[q] == '&') {
+						valueEnd = q;
+						break;
+					}
+				}
+
+				string name, value;
+				if (valuePos == -1) {
+					name = null;
+					valuePos = namePos;
+				} else {
+					name = System.Web.HttpUtility.UrlDecode (query.Substring (namePos, valuePos - namePos - 1), encoding);
+				}
+				if (valueEnd < 0) {
+					namePos = -1;
+					valueEnd = query.Length;
+				} else {
+					namePos = valueEnd + 1;
+				}
+				value = System.Web.HttpUtility.UrlDecode (query.Substring (valuePos, valueEnd - valuePos), encoding);
+
+				collection.Add (name, value);
+				if (namePos == -1) break;
+			}
+			return collection;
 		}
 #endif
 		#endregion // Methods
Index: Test/System.Web/ChangeLog
===================================================================
--- Test/System.Web/ChangeLog	(revision 60681)
+++ Test/System.Web/ChangeLog	(working copy)
@@ -1,3 +1,7 @@
+2006-05-14 Kazuki Oikawa <kazuki@panicode.com>
+
+	* HttpUtilityTest.cs: added tests for HttpUtility.ParseQueryString.
+
 2006-04-20 Andrew Skiba <andrews@mainsoft.com>
 
 	* SiteMapNodeTest.cs: new tests for null reference exceptions in SiteMapNode
Index: Test/System.Web/HttpUtilityTest.cs
===================================================================
--- Test/System.Web/HttpUtilityTest.cs	(revision 60681)
+++ Test/System.Web/HttpUtilityTest.cs	(working copy)
@@ -26,9 +26,11 @@
 // WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 //
 
+using System;
 using System.Text;
 using System.Web;
 using System.IO;
+using System.Collections.Specialized;
 
 using NUnit.Framework;
 
@@ -363,6 +365,76 @@
 					"UrlEncodeUnicode "+c.ToString());
 			}
 		}
+
+#if NET_2_0
+		[Test]
+		public void ParseQueryString ()
+		{
+			ParseQueryString_Helper (HttpUtility.ParseQueryString ("name=value"), "#1",
+				new string[]{"name"}, new string[][]{new string[]{"value"}});
+
+			ParseQueryString_Helper (HttpUtility.ParseQueryString ("name=value&foo=bar"), "#2",
+				new string[]{"name", "foo"}, new string[][]{new string[]{"value"}, new string[]{"bar"}});
+
+			ParseQueryString_Helper (HttpUtility.ParseQueryString ("name=value&name=bar"), "#3",
+				new string[]{"name"}, new string[][]{new string[]{"value", "bar"}});
+
+			ParseQueryString_Helper (HttpUtility.ParseQueryString ("value"), "#4",
+				new string[] {null}, new string[][]{new string[]{"value"}});
+
+			ParseQueryString_Helper (HttpUtility.ParseQueryString ("name=value&bar"), "#5",
+				new string[]{"name", null}, new string[][]{new string[]{"value"}, new string[]{"bar"}});
+
+			ParseQueryString_Helper (HttpUtility.ParseQueryString ("bar&name=value"), "#6",
+				new string[]{null, "name"}, new string[][]{new string[]{"bar"}, new string[]{"value"}});
+
+			ParseQueryString_Helper (HttpUtility.ParseQueryString ("value&bar"), "#7",
+				new string[]{null}, new string[][]{new string[]{"value", "bar"}});
+
+			ParseQueryString_Helper (HttpUtility.ParseQueryString (""), "#8",
+				new string[0], new string[0][]);
+
+			ParseQueryString_Helper (HttpUtility.ParseQueryString ("="), "#9",
+				new string[]{""}, new string[][]{new string[]{""}});
+
+			ParseQueryString_Helper (HttpUtility.ParseQueryString ("&"), "#10",
+				new string[]{null}, new string[][]{new string[]{"", ""}});
+
+			ParseQueryString_Helper (HttpUtility.ParseQueryString ("?value"), "#11",
+				new string[]{null}, new string[][]{new string[]{"value"}});
+
+			try {
+				HttpUtility.ParseQueryString (null);
+			} catch (Exception e) {
+				Assert.AreEqual (typeof (ArgumentNullException), e.GetType (), "#12");
+			}
+
+			try {
+				HttpUtility.ParseQueryString ("", null);
+			} catch (Exception e) {
+				Assert.AreEqual (typeof (ArgumentNullException), e.GetType (), "#13");
+			}
+
+			string str = new string (new char[] {'\u304a', '\u75b2', '\u308c', '\u69d8', '\u3067', '\u3059'});
+			string utf8url = HttpUtility.UrlEncode (str, Encoding.UTF8);
+			ParseQueryString_Helper (HttpUtility.ParseQueryString (utf8url + "=" + utf8url), "#14",
+				new string[]{str}, new string[][]{new string[] {str}});
+
+			ParseQueryString_Helper (HttpUtility.ParseQueryString ("name=value=test"), "#15",
+				new string[]{"name"}, new string[][]{new string[]{"value=test"}});
+		}
+		static void ParseQueryString_Helper (NameValueCollection nvc, string msg, string[] keys, string[][] values)
+		{
+			Assert.AreEqual (keys.Length, nvc.Count, msg + "[Count]");
+			for (int i = 0; i < keys.Length; i ++) {
+				Assert.AreEqual (keys[i], nvc.GetKey (i), msg + "[Key]");
+				string[] tmp = nvc.GetValues (i);
+				Assert.AreEqual (values[i].Length, tmp.Length, msg + "[ValueCount]");
+				for (int q = 0; q < values[i].Length; q++)
+					Assert.AreEqual (values[i][q], tmp[q], msg + "[Value]");
+			}
+		}
+#endif
 	}
 }
 