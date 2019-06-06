Index: class.c
===================================================================
--- class.c	(revision 64208)
+++ class.c	(working copy)
@@ -190,14 +190,9 @@
 static void
 _mono_type_get_assembly_name (MonoClass *klass, GString *str)
 {
-	MonoAssembly *ta = klass->image->assembly;
-
-	g_string_append_printf (
-		str, ", %s, Version=%d.%d.%d.%d, Culture=%s, PublicKeyToken=%s",
-		ta->aname.name,
-		ta->aname.major, ta->aname.minor, ta->aname.build, ta->aname.revision,
-		ta->aname.culture && *ta->aname.culture? ta->aname.culture: "neutral",
-		ta->aname.public_key_token [0] ? (char *)ta->aname.public_key_token : "null");
+	char *name = mono_stringify_assembly_name (&klass->image->assembly->aname);
+	g_string_append_printf (str, ", %s", name);
+	g_free (name);
 }
 
 static void
Index: assembly.c
===================================================================
--- assembly.c	(revision 64208)
+++ assembly.c	(working copy)
@@ -692,12 +692,11 @@
 mono_stringify_assembly_name (MonoAssemblyName *aname)
 {
 	return g_strdup_printf (
-		"%s, Version=%d.%d.%d.%d, Culture=%s%s%s",
+		"%s, Version=%d.%d.%d.%d, Culture=%s, PublicKeyToken=%s",
 		aname->name,
 		aname->major, aname->minor, aname->build, aname->revision,
 		aname->culture && *aname->culture? aname->culture: "neutral",
-		aname->public_key_token [0] ? ", PublicKeyToken=" : "",
-		aname->public_key_token [0] ? (char *)aname->public_key_token : "");
+		aname->public_key_token [0] ? (char *)aname->public_key_token : "null");
 }
 
 static gchar*
