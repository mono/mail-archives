Index: RegionInfo.cs
===================================================================
--- RegionInfo.cs	(revision 48291)
+++ RegionInfo.cs	(working copy)
@@ -22,10 +22,170 @@
 // WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 //
 using System.Globalization;
+using System.Runtime.CompilerServices;
 
 namespace System.Globalization {
 
+#if true
 	[Serializable]
+	public class RegionInfo
+	{
+		static object forLock = new object ();
+		static RegionInfo currentRegion;
+
+		// This property is not synchronized with CurrentCulture, so
+		// we need to use bootstrap CurrentCulture LCID.
+		public static RegionInfo CurrentRegion {
+			get {
+				if (currentRegion == null) {
+					CultureInfo ci = CultureInfo.CurrentCulture;
+					// If current culture is invariant then region is not available.
+					if (ci == null || CultureInfo.BootstrapCultureID == 0x7F)
+						return null;
+					lock (forLock) {
+						// make sure to fill BootstrapCultureID.
+						currentRegion = new RegionInfo (CultureInfo.BootstrapCultureID);
+					}
+				}
+				return currentRegion;
+			}
+		}
+
+		int regionId;
+		string iso2Name;
+		string iso3Name;
+		string win3Name;
+		string englishName;
+		string currencySymbol;
+		string isoCurrencySymbol;
+		string currencyEnglishName;
+
+		public RegionInfo (int lcid)
+		{
+			if (!ConstructInternalRegionFromLcid (lcid))
+				throw new ArgumentException (
+					String.Format ("Region ID {0} (0x{0:X4}) is not a " +
+							"supported region.", lcid), "lcid");
+		}
+
+		public RegionInfo (string name)
+		{
+			if (name == null)
+				throw new ArgumentNullException ();
+
+			if (!ConstructInternalRegionFromName (name.ToUpperInvariant ()))
+				throw new ArgumentException ("Region name " + name +
+						" is not supported.", "name");
+		}
+
+		bool ConstructInternalRegionFromName (string locale)
+		{
+			if (!construct_internal_region_from_name (locale))
+				return false;
+			return true;
+		}
+
+		bool ConstructInternalRegionFromLcid (int lcid)
+		{
+			if (!construct_internal_region_from_lcid (lcid))
+				return false;
+			return true;
+		}
+
+		[MethodImplAttribute (MethodImplOptions.InternalCall)]
+		private extern bool construct_internal_region_from_lcid (int lcid);
+
+		[MethodImplAttribute (MethodImplOptions.InternalCall)]
+		private extern bool construct_internal_region_from_name (string name);
+
+#if NET_2_0
+		public virtual string CurrencyEnglishName {
+			get { return currencyEnglishName; }
+		}
+#endif
+
+		public virtual string CurrencySymbol {
+			get { return currencySymbol; }
+		}
+
+		[MonoTODO]
+		public virtual string DisplayName {
+			get { return englishName; }
+		}
+
+		public virtual string EnglishName {
+			get { return englishName; }
+		}
+
+		public virtual bool IsMetric {
+			get {
+				switch (iso2Name) {
+				case "US":
+				case "UK":
+					return false;
+				default:
+					return true;
+				}
+			}
+		}
+
+		public virtual string ISOCurrencySymbol {
+			get { return isoCurrencySymbol; }
+		}
+
+#if NET_2_0
+		[MonoTODO]
+		public virtual string NativeName {
+			get { return DisplayName; }
+		}
+
+		[MonoTODO]
+		public virtual string CurrencyNativeName {
+			get { throw new NotImplementedException (); }
+		}
+#endif
+
+		public virtual string Name {
+			get { return iso2Name; }
+		}
+
+		public virtual string ThreeLetterISORegionName {
+			get { return iso3Name; }
+		}
+
+		public virtual string ThreeLetterWindowsRegionName {
+			get { return win3Name; }
+		}
+		
+		public virtual string TwoLetterISORegionName {
+			get { return iso2Name; }
+		}
+
+		//
+		// methods
+
+#if NET_2_0
+#else
+		public override bool Equals (object value)
+		{
+			RegionInfo other = value as RegionInfo;
+			return other != null && regionId == other.regionId;
+		}
+
+		public override int GetHashCode () {
+			return regionId;
+		}
+#endif
+
+		public override string ToString ()
+		{
+			return Name;
+		}
+	}
+
+#else
+
+	[Serializable]
 	[MonoTODO ("This class should be implemented from scratch.")]
 	public class RegionInfo {
 		int NLS_id;
@@ -1767,5 +1927,5 @@
 		}
 		
 	}
-
+#endif
 }