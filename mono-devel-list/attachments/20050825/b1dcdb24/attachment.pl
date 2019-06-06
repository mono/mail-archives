Index: class.cs
===================================================================
--- class.cs	(revision 48814)
+++ class.cs	(working copy)
@@ -5704,7 +5704,7 @@
 		ReturnParameter return_attributes;
 
 		public AbstractPropertyEventMethod (MemberBase member, string prefix)
-			: base (null, SetupName (prefix, member), null)
+			: base (null, SetupName (prefix, member, member.Location), null)
 		{
 			this.prefix = prefix;
 			IsDummy = true;
@@ -5712,21 +5712,21 @@
 
 		public AbstractPropertyEventMethod (MemberBase member, Accessor accessor,
 						    string prefix)
-			: base (null, SetupName (prefix, member),
+			: base (null, SetupName (prefix, member, accessor.Location),
 				accessor.Attributes)
 		{
 			this.prefix = prefix;
 			this.block = accessor.Block;
 		}
 
-		static MemberName SetupName (string prefix, MemberBase member)
+		static MemberName SetupName (string prefix, MemberBase member, Location loc)
 		{
-			return new MemberName (member.MemberName.Left, prefix + member.ShortName);
+			return new MemberName (member.MemberName.Left, prefix + member.ShortName, loc);
 		}
 
 		public void UpdateName (MemberBase member)
 		{
-			SetMemberName (SetupName (prefix, member));
+			SetMemberName (SetupName (prefix, member, Location));
 		}
 
 		#region IMethodData Members