Index: ChangeLog
===================================================================
RCS file: /cvs/public/mono/mono/metadata/ChangeLog,v
retrieving revision 1.829
diff -u -r1.829 ChangeLog
--- ChangeLog	1 Mar 2003 14:38:59 -0000	1.829
+++ ChangeLog	5 Mar 2003 10:11:23 -0000
@@ -1,3 +1,7 @@
+2003-03-05  Aleksey Demakov <avd@openlinksw.com>
+
+	* icall.c (ves_icall_type_GetTypeCode): fixed check for
+	System.DBNull (it's class not valuetype).
 
 Sat Mar 1 15:32:56 CET 2003 Paolo Molaro <lupus@ximian.com>
 
Index: icall.c
===================================================================
RCS file: /cvs/public/mono/mono/metadata/icall.c,v
retrieving revision 1.271
diff -u -r1.271 icall.c
--- icall.c	21 Feb 2003 22:42:15 -0000	1.271
+++ icall.c	5 Mar 2003 10:12:03 -0000
@@ -924,8 +924,6 @@
 					return TYPECODE_DECIMAL;
 				else if (strcmp (k->name, "DateTime") == 0)
 					return TYPECODE_DATETIME;
-				else if (strcmp (k->name, "DBNull") == 0)
-					return TYPECODE_DBNULL;
 			}
 		}
 		/* handle datetime, dbnull.. */
@@ -937,6 +935,13 @@
 	case MONO_TYPE_OBJECT:
 		return TYPECODE_OBJECT;
 	case MONO_TYPE_CLASS:
+		{
+			MonoClass *k =  type->type->data.klass;
+			if (strcmp (k->name_space, "System") == 0) {
+				if (strcmp (k->name, "DBNull") == 0)
+					return TYPECODE_DBNULL;
+			}
+		}
 		return TYPECODE_OBJECT;
 	default:
 		g_error ("type 0x%02x not handled in GetTypeCode()", t);

