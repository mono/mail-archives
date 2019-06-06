--- mono-1.2.3.20070215_ORIGINAL/mcs/class/corlib/System/DateTime.cs	2007-01-26 07:00:52.000000000 +0100
+++ DateTime.cs	2007-03-18 10:39:49.000000000 +0100
@@ -1,3 +1,5 @@
+#define HACK_FOR_SOAP_FORMATTER_BUG
+
 //
 // System.DateTime.cs
 //
@@ -33,6 +35,7 @@
 using System.Globalization;
 using System.Runtime.CompilerServices;
 using System.Runtime.InteropServices;
+using System.Runtime.Serialization;
 using System.Text;
 
 namespace System
@@ -46,7 +49,7 @@
 	[StructLayout (LayoutKind.Auto)]
 	public struct DateTime : IFormattable, IConvertible, IComparable
 #if NET_2_0
-		, IComparable<DateTime>, IEquatable <DateTime>
+	, IComparable<DateTime>, IEquatable<DateTime>, ISerializable
 #endif
 	{
 		private TimeSpan ticks;
@@ -2149,5 +2152,166 @@
 		{
 			throw new InvalidCastException();
 		}
+
+#if NET_2_0	// ISerializable Members
+
+		private DateTime(SerializationInfo info, StreamingContext context)
+		{
+			this.kind = DateTimeKind.Unspecified;
+			this.ticks = TimeSpan.MinValue;
+
+			  if (info == null)
+					throw new ArgumentNullException("info");
+			
+			/* 
+			 * Mono and .Net have different 'signatures' for their SerializationInfo's content:
+			 * 
+			 * Mono uses:
+			 * - ticks, a TimeSpan
+			 * - kind, a DateTimeKind (only on .NET 2.0)
+			 * 
+			 * And .Net uses:
+			 * - in v1.0: ????
+			 * - in v1.1: ticks, a long
+			 * - in v2.0: ticks (a long) and dateData (a ulong) with the first end being the kind and the right end the ticks
+			 * 
+			 * So we first enumerate the available field names & types, and then decide what to do on that basis.
+			 * If the kind is not present, it shoud be considered as equal to 0 (Unspecified).
+			 */
+
+			SerializationInfoEnumerator serializedFieldEnum = info.GetEnumerator();
+			int fieldCount = info.MemberCount;
+			string serializedFieldName;
+			Type serializedFieldType;
+
+			if (fieldCount == 1)
+			{
+				#region This DateTime should have been serialized under the .NET framework 1.x or with Mono for framework v1.x
+				serializedFieldName = serializedFieldEnum.Name;
+				serializedFieldType = serializedFieldEnum.ObjectType;
+				if (serializedFieldName != "ticks")
+					throw new SerializationException("Invalid serialized data for this DataTime - 1 single unknown member.");
+
+				if (serializedFieldType == typeof(TimeSpan))
+				{
+					// This is a DateTime serialized under Mono for framework 1.x
+					this.ticks = (TimeSpan)serializedFieldEnum.Value;
+				}
+				else if(serializedFieldType == typeof(long))
+				{
+					// This is a DateTime serialized under .NET 1.x
+					this.ticks = new TimeSpan((long)serializedFieldEnum.Value);
+				}
+				else
+					throw new SerializationException("Invalid serialized data for this DataTime - member 'ticks' not of the expected types.");
+				#endregion This DateTime should have been serialized under the .NET framework 1.x or with Mono for framework v1.x
+			}
+			else if (fieldCount == 2)
+			{
+				#region This DateTime should have been serialized under .Net 2.x or under Mono for the framework v2.x.
+				bool isMono = false;
+
+				serializedFieldEnum.MoveNext();
+				serializedFieldName = serializedFieldEnum.Name;
+				serializedFieldType = serializedFieldEnum.ObjectType;
+
+				if (serializedFieldName != "ticks")
+					throw new SerializationException("Missing ticks field in a DateTime serialized with .NET or Mono for the version 2.x but it isn't");
+
+				if (serializedFieldType == typeof(long))
+				{
+					isMono = false;
+					this.ticks = new TimeSpan((long)serializedFieldEnum.Value);
+				}
+				else if (serializedFieldType == typeof(TimeSpan))
+				{
+					isMono = true;
+					this.ticks = (TimeSpan)serializedFieldEnum.Value;
+				}
+#if HACK_FOR_SOAP_FORMATTER_BUG
+				else
+				{
+					// With soap formatter, the long has been changed into an object...
+					try
+					{
+						this.ticks = new TimeSpan(Convert.ToInt64(serializedFieldEnum.Value));
+						isMono = false;
+					}
+					catch
+					{
+						throw new SerializationException(serializedFieldType.ToString() + " is not expected for the ticks field in a DateTime serialized with .NET or Mono for the version 2.x. Value is " + serializedFieldEnum.Value.ToString());
+					}
+				}
+#else
+				else
+					throw new SerializationException(serializedFieldType.ToString() + " is not expected for the ticks field in a DateTime serialized with .NET or Mono for the version 2.x.");
+#endif					
+
+
+				serializedFieldEnum.MoveNext();
+				serializedFieldName = serializedFieldEnum.Name;
+				serializedFieldType = serializedFieldEnum.ObjectType;
+#if HACK_FOR_SOAP_FORMATTER_BUG
+				if (!isMono && serializedFieldName == "dateData")
+				{
+					try
+					{
+						ulong dateData = Convert.ToUInt64(serializedFieldEnum.Value);
+						ulong leftpart = dateData & 0xc000000000000000;
+						// If we do nothing, we let kind = 0 (ie Unspecified)
+						if (leftpart == 0)
+							this.kind = DateTimeKind.Unspecified;
+						else if (leftpart == 0x4000000000000000)
+							this.kind = DateTimeKind.Utc;
+						else
+							this.kind = DateTimeKind.Local;
+					}
+					catch
+					{
+						throw new SerializationException("This should be a DateTime serialized with .NET or Mono for the version 2.x but it isn't. Internal dateData is not of type ulong but of type " + serializedFieldType.ToString());
+					}
+				}
+#else
+				if (!isMono && serializedFieldName == "dateData" && serializedFieldType == typeof(ulong))
+				{
+					ulong dateData = (ulong)serializedFieldEnum.Value;
+					ulong leftpart = dateData & 0xc000000000000000;
+					// If we do nothing, we let kind = 0 (ie Unspecified)
+					if (leftpart == 0)
+						this.kind = DateTimeKind.Unspecified;
+					else if (leftpart == 0x4000000000000000)
+						this.kind = DateTimeKind.Utc;
+					else
+						this.kind = DateTimeKind.Local;
+				}
+#endif
+			else if(isMono && serializedFieldName == "kind" && serializedFieldType == typeof(DateTimeKind))
+				{
+					this.kind = (DateTimeKind)serializedFieldEnum.Value;
+				}
+			else
+				throw new SerializationException("This should be a DateTime serialized with .NET or Mono for the version 2.x but it isn't.");
+ 
+				#endregion This DateTime should have been serialized under .Net 2.x or under Mono for the framework v2.x.
+        	}
+			else
+				throw new SerializationException("Invalid serialized data for this DataTime - (3 members or more).");
+		}
+
+		void  ISerializable.GetObjectData(SerializationInfo info, StreamingContext context)
+		{
+			if (info == null)
+				throw new System.ArgumentNullException("info");
+
+			info.AddValue("ticks", this.ticks.Ticks);
+
+			// We serialize the DateTime the .Net 2.x way.
+			// Let's store the kind into the left part of dateData, and the ticks into the right part.
+			ulong dateData = (ulong) ((((long) kind) << 0x3e) | ticks.Ticks);
+
+			info.AddValue("dateData", dateData);
+		}
+
+#endif
 	}
 }
