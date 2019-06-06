Index: RegionInfoEntry.cs
===================================================================
--- RegionInfoEntry.cs	(revision 0)
+++ RegionInfoEntry.cs	(revision 0)
@@ -0,0 +1,64 @@
+//
+// Mono.Tools.LocaleBuilder.RegionInfoEntry
+//
+// Author(s):
+//   Atsushi Enomoto  <atsushi@ximian.com>
+//
+// (C) 2005, Novell, Inc (http://www.novell.com)
+//
+
+
+using System;
+using System.Text;
+using System.Collections;
+
+namespace Mono.Tools.LocaleBuilder
+{
+	public class RegionInfoEntry : Entry
+	{
+		public int RegionId; // numbered by alphabetical order of ISO2Name.
+		// public byte MeasurementSystem;
+		// public int GeoId;
+		public string ISO2Name = String.Empty; // supplementalData.xml
+		public string ISO3Name = String.Empty;
+		public string Win3Name = String.Empty;
+		public string EnglishName = String.Empty; // langs/en.xml
+		public string CurrencySymbol = String.Empty;
+		public string ISOCurrencySymbol = String.Empty; // supplementalData.xml
+		public string CurrencyEnglishName = String.Empty; // langs/en.xml
+
+		// NativeName and CurrencyNativeName are language dependent.
+
+		public void AppendTableRow (StringBuilder builder)
+		{
+			builder.Append ("\t{");
+			builder.Append (RegionId);
+			builder.Append (',');
+			// builder.Append (MeasurementSystem);
+			// builder.Append (',');
+			builder.Append (EncodeStringIdx (ISO2Name));
+			builder.Append (',');
+			builder.Append (EncodeStringIdx (ISO3Name));
+			builder.Append (',');
+			builder.Append (EncodeStringIdx (Win3Name));
+			builder.Append (',');
+			builder.Append (EncodeStringIdx (EnglishName));
+			builder.Append (',');
+			builder.Append (EncodeStringIdx (CurrencySymbol));
+			builder.Append (',');
+			builder.Append (EncodeStringIdx (ISOCurrencySymbol));
+			builder.Append (',');
+			builder.Append (EncodeStringIdx (CurrencyEnglishName));
+			builder.Append ('}');
+		}
+
+		public override string ToString ()
+		{
+			StringBuilder builder = new StringBuilder ();
+			AppendTableRow (builder);
+			return builder.ToString ();
+		}
+	}
+}
+
+
Index: Driver.cs
===================================================================
--- Driver.cs	(revision 48341)
+++ Driver.cs	(working copy)
@@ -3,8 +3,9 @@
 //
 // Author(s):
 //  Jackson Harper (jackson@ximian.com)
+//  Atsushi Enomoto (atsushi@ximian.com)
 //
-// (C) 2004 Novell, Inc (http://www.novell.com)
+// (C) 2004-2005 Novell, Inc (http://www.novell.com)
 //
 
 
@@ -46,7 +47,8 @@
                 private ArrayList cultures;
                 private Hashtable langs;
                 private Hashtable currency_types;
-                
+                private Hashtable regions;
+
 		// The lang is the language that display names will be displayed in
 		public string Lang {
 			get {
@@ -79,7 +81,10 @@
 
                         langs = new Hashtable ();
                         cultures = new ArrayList ();
+                        regions = new Hashtable ();
 
+			LookupRegions ();
+
                         LookupCurrencyTypes ();
 
 			foreach (string file in Directory.GetFiles ("locales", "*.xml")) {
@@ -109,7 +114,42 @@
 				}
 			 }
 
+			ArrayList regionList = new ArrayList (regions.Values);
+			regionList.Sort (RegionComparer.Instance);
+			int number = 0;
+			foreach (RegionInfoEntry r in regionList)
+				r.RegionId = number++;
 
+			ArrayList regionMap = new ArrayList ();
+
+			foreach (CultureInfoEntry e in cultures) {
+				int lcid = int.Parse (e.Lcid.Substring (2),
+					NumberStyles.HexNumber);
+				int idx;
+				int start = e.Name.IndexOf ('-') + 1;
+				if (start == 0)
+					continue;
+				for (idx = start; idx < e.Name.Length; idx++)
+					if (!Char.IsLetter (e.Name [idx]))
+						break;
+				if (start == idx) {
+					Console.Error.WriteLine ("Culture {0} {1} is not mappable to Region.", e.Lcid, e.Name);
+					continue;
+				}
+				string name = e.Name.Substring (start, idx - start);
+				RegionInfoEntry rm = null;
+				foreach (RegionInfoEntry r in regions.Values)
+					if (r.ISO2Name == name) {
+						rm = r;
+						break;
+					}
+				if (rm == null) {
+					Console.Error.WriteLine ("No definition for region {0}", name);
+					continue;
+				}
+				regionMap.Add (new RegionLCIDMap (lcid, rm.RegionId));
+			}
+
                         /**
                          * Dump each table individually. Using StringBuilders
                          * because it is easier to debug, should switch to just
@@ -124,6 +164,8 @@
                                 writer.WriteLine ("\n");
 
                                 writer.WriteLine ("#define NUM_CULTURE_ENTRIES " + cultures.Count);
+                                writer.WriteLine ("#define NUM_REGION_ENTRIES " + regionList.Count);
+                                writer.WriteLine ("#define NUM_REGION_LCID_MAP " + regionMap.Count);
                                 writer.WriteLine ("\n");
 
                                 // Sort the cultures by lcid
@@ -194,6 +236,47 @@
                                 writer.Write (builder);
                                 writer.WriteLine ("};\n\n");
 
+				builder = new StringBuilder ();
+				int rcount = 0;
+				foreach (RegionInfoEntry r in regionList) {
+					r.AppendTableRow (builder);
+					if (++rcount != regionList.Count)
+						builder.Append (',');
+					builder.Append ('\n');
+				}
+				writer.WriteLine ("static const RegionInfoEntry region_entries [] = {");
+				writer.Write (builder);
+				writer.WriteLine ("};\n\n");
+
+                                builder = new StringBuilder ();
+				rcount = 0;
+				foreach (RegionInfoEntry ri in regionList) {
+                                        builder.Append ("\t{" + Entry.EncodeStringIdx (ri.ISO2Name) + ", ");
+                                        builder.Append (ri.RegionId + "}");
+                                        if (++rcount < regionList.Count)
+                                                builder.Append (',');
+                                        builder.Append ('\n');
+                                }
+
+                                writer.WriteLine ("static const RegionInfoNameEntry region_name_entries [] = {");
+                                writer.Write (builder);
+                                writer.WriteLine ("};\n\n");
+
+                                builder = new StringBuilder ();
+                                for (int i = 0; i < regionMap.Count; i++) {
+                                        RegionLCIDMap map = (RegionLCIDMap) regionMap [i];
+                                        builder.Append ("\t{" + map.LCID + ", ");
+                                        builder.Append (map.RegionId + "}");
+                                        if (i + 1 < regionMap.Count)
+                                                builder.Append (',');
+                                        builder.Append ('\n');
+                                }
+
+                                writer.WriteLine ("static const RegionLCIDMap region_lcid_map [] = {");
+                                writer.Write (builder);
+                                writer.WriteLine ("};\n\n");
+
+
                                 writer.WriteLine ("static const char locale_strings [] = {");
                                 writer.Write (Entry.GetStrings ());
                                 writer.WriteLine ("};\n\n");
@@ -915,6 +998,42 @@
 			return ret;
 		}
 
+		private void LookupRegions ()
+		{
+                        XPathDocument doc = GetXPathDocument ("supplementalData.xml");
+			XPathNavigator nav = doc.CreateNavigator ();
+			XPathNodeIterator ni = nav.Select ("supplementalData/currencyData/region");
+			while (ni.MoveNext ()) {
+				string territory = (string) ni.Current.GetAttribute ("iso3166", String.Empty);
+                                string currency = (string) ni.Current.Evaluate ("string(currency/@iso4217)");
+				RegionInfoEntry region = new RegionInfoEntry ();
+				region.ISO2Name = territory.ToUpper ();
+				region.ISOCurrencySymbol = currency;
+				regions [territory] = region;
+			}
+
+                        doc = GetXPathDocument ("langs/en.xml");
+			nav = doc.CreateNavigator ();
+			ni = nav.Select ("/ldml/localeDisplayNames/territories/territory");
+			while (ni.MoveNext ()) {
+				RegionInfoEntry r = (RegionInfoEntry)
+					regions [ni.Current.GetAttribute ("type", "")];
+				if (r == null)
+					continue;
+				r.EnglishName = ni.Current.Value;
+			}
+
+			Hashtable curNames = new Hashtable ();
+			ni = nav.Select ("/ldml/numbers/currencies/currency");
+			while (ni.MoveNext ())
+				curNames [ni.Current.GetAttribute ("type", "")] =
+					ni.Current.Evaluate ("string (displayName)");
+
+			foreach (RegionInfoEntry r in regions.Values)
+				r.CurrencyEnglishName =
+					(string) curNames [r.ISOCurrencySymbol];
+		}
+
                 private void LookupCurrencyTypes ()
                 {
                         XPathDocument doc = GetXPathDocument ("supplementalData.xml");
@@ -1009,6 +1128,31 @@
                                 return aa.Name.ToLower ().CompareTo (bb.Name.ToLower ());
                         }
                 }
+
+		class RegionComparer : IComparer
+		{
+			public static RegionComparer Instance = new RegionComparer ();
+			
+			public int Compare (object o1, object o2)
+			{
+				RegionInfoEntry r1 = (RegionInfoEntry) o1;
+				RegionInfoEntry r2 = (RegionInfoEntry) o2;
+				return String.CompareOrdinal (
+					r1.ISO2Name, r2.ISO2Name);
+			}
+		}
+
+		class RegionLCIDMap
+		{
+			public RegionLCIDMap (int lcid, int regionId)
+			{
+				LCID = lcid;
+				RegionId = regionId;
+			}
+
+			public int LCID;
+			public int RegionId;
+		}
         }
 }
 
Index: Makefile.am
===================================================================
--- Makefile.am	(revision 48341)
+++ Makefile.am	(working copy)
@@ -1,6 +1,6 @@
 
 MCS = mcs
-RUNTIME = mono
+RUNTIME = mono --debug
 MCSFLAGS = -debug+
 # To build a reduced mono runtime with support only for some locales, # run:
 # 	make minimal
@@ -22,6 +22,7 @@
 			 CultureInfoEntry.cs	\
 			 DateTimeFormatEntry.cs	\
 			 NumberFormatEntry.cs	\
+			 RegionInfoEntry.cs     \
 			 TextInfoEntry.cs	\
 			 Entry.cs
 