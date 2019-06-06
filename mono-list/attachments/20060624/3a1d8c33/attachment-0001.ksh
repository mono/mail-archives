//
// System.ComponentModel.DisplayNameAttribute.cs: Provides a display name for a member of a type.
//
// Author:
//   Christopher Head (chead@telus.net)
//
// (C) 2006
//

namespace System.ComponentModel {
	[AttributeUsage (AttributeTargets.Event | AttributeTargets.Property |
			 AttributeTargets.Method | AttributeTargets.Class)]
	public class DisplayNameAttribute : Attribute {
		public static readonly DisplayNameAttribute Default = new
			DisplayNameAttribute();

		private string display_name;

		public DisplayNameAttribute () : this(string.Empty)
		{
		}

		public DisplayNameAttribute(string displayName)
		{
			display_name = displayName;
		}

		public override bool Equals(object obj)
		{
			if (obj == this)
				return true;
			DisplayNameAttribute other = obj as
				DisplayNameAttribute;
			if (other != null)
				return other.DisplayName == DisplayName;
			else
				return false;
		}

		public override int GetHashCode()
		{
			return DisplayName.GetHashCode();
		}

		public override bool IsDefaultAttribute()
		{
			return Equals(Default);
		}

		public virtual string DisplayName {
			get { return DisplayNameValue; }
		}

		protected string DisplayNameValue {
			get { return display_name; }
			set { display_name = value; }
		}
	}
}
