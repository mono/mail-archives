Index: ASCIIEncoding.cs
===================================================================
RCS file: /cvs/public/mcs/class/corlib/System.Text/ASCIIEncoding.cs,v
retrieving revision 1.13
diff -u -r1.13 ASCIIEncoding.cs
--- ASCIIEncoding.cs	26 Aug 2002 14:46:37 -0000	1.13
+++ ASCIIEncoding.cs	5 Mar 2003 09:05:14 -0000
@@ -206,6 +206,8 @@
 		if (count < 0 || count > (bytes.Length - index)) {
 			throw new ArgumentOutOfRangeException ("count", _("ArgRange_Array"));
 		}
+		if (count == 0)
+		    return String.Empty;
 		unsafe {
 			fixed (byte *ss = &bytes [0]) {
 				return new String ((sbyte*)ss, index, count);
@@ -218,6 +220,8 @@
 			throw new ArgumentNullException ("bytes");
 		}
 		int count = bytes.Length;
+		if (count == 0)
+		    return String.Empty;
 		unsafe {
 			fixed (byte *ss = &bytes [0]) {
 				return new String ((sbyte*)ss, 0, count);
Index: ChangeLog
===================================================================
RCS file: /cvs/public/mcs/class/corlib/System.Text/ChangeLog,v
retrieving revision 1.40
diff -u -r1.40 ChangeLog
--- ChangeLog	19 Feb 2003 16:47:51 -0000	1.40
+++ ChangeLog	5 Mar 2003 09:05:16 -0000
@@ -1,3 +1,9 @@
+2003-03-05  Aleksey Demakov <avd@openlinksw.com>
+
+	* ASCIIEncoding.cs:
+	* Latin1Encoding.cs: fix GetString (byte[]) and
+	GetString (byte[], int, int) for zero-length case.
+
 2003-02-19  Gonzalo Paniagua Javier <gonzalo@ximian.com>
 
 	* Latin1Encoding.cs: added Serializable attribute.
Index: Latin1Encoding.cs
===================================================================
RCS file: /cvs/public/mcs/class/corlib/System.Text/Latin1Encoding.cs,v
retrieving revision 1.5
diff -u -r1.5 Latin1Encoding.cs
--- Latin1Encoding.cs	19 Feb 2003 16:47:51 -0000	1.5
+++ Latin1Encoding.cs	5 Mar 2003 09:05:19 -0000
@@ -214,6 +214,8 @@
 		if (count < 0 || count > (bytes.Length - index)) {
 			throw new ArgumentOutOfRangeException ("count", _("ArgRange_Array"));
 		}
+		if (count == 0)
+		    return String.Empty;
 		unsafe {
 			fixed (byte *ss = &bytes [0]) {
 				return new String ((sbyte*)ss, index, count);
@@ -226,6 +228,8 @@
 			throw new ArgumentNullException ("bytes");
 		}
 		int count = bytes.Length;
+		if (count == 0)
+		    return String.Empty;
 		unsafe {
 			fixed (byte *ss = &bytes [0]) {
 				return new String ((sbyte*)ss, 0, count);
