Index: System.Web.UI/ObjectTagBuilder.cs
===================================================================
--- System.Web.UI/ObjectTagBuilder.cs	(revision 50711)
+++ System.Web.UI/ObjectTagBuilder.cs	(working copy)
@@ -63,8 +63,6 @@
 					   string id,
 					   IDictionary attribs) 
 		{
-			if (id == null)
-				throw new HttpException ("Missing 'id'.");
 			if (attribs == null)
 				throw new ParseException (parser.Location, "Error in ObjectTag.");
 
