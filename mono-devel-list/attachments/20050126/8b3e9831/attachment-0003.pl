Index: System.Runtime.Serialization.Formatters.Binary/CodeGenerator.cs
===================================================================
--- System.Runtime.Serialization.Formatters.Binary/CodeGenerator.cs	(revision 39533)
+++ System.Runtime.Serialization.Formatters.Binary/CodeGenerator.cs	(working copy)
@@ -391,7 +391,7 @@
 			case TypeCode.UInt64:
 				return typeof (ulong);
 			}
-			throw new Exception ("Unhandled typecode in enum " + tc + " from " + t.AssemblyQualifiedName);
+			throw new SystemException ("Unhandled typecode in enum " + tc + " from " + t.AssemblyQualifiedName);
 		}
 	}
  }
Index: Mono.Security.X509/X509Extensions.cs
===================================================================
--- Mono.Security.X509/X509Extensions.cs	(revision 39533)
+++ Mono.Security.X509/X509Extensions.cs	(working copy)
@@ -61,7 +61,7 @@
 			if (asn1 == null)
 				return;
 			if (asn1.Tag != 0x30)
-				throw new Exception ("Invalid extensions format");
+				throw new SystemException ("Invalid extensions format");
 			for (int i=0; i < asn1.Count; i++) {
 				X509Extension extension = new X509Extension (asn1 [i]);
 				InnerList.Add (extension);
Index: System/Double.cs
===================================================================
--- System/Double.cs	(revision 39533)
+++ System/Double.cs	(working copy)
@@ -201,7 +201,7 @@
 				throw new ArgumentException();
 			}
 			NumberFormatInfo format = NumberFormatInfo.GetInstance(provider);
-			if (format == null) throw new Exception("How did this happen?");
+			if (format == null) throw new SystemException("How did this happen?");
 			if (s == format.NaNSymbol) return Double.NaN;
 			if (s == format.PositiveInfinitySymbol) return Double.PositiveInfinity;
 			if (s == format.NegativeInfinitySymbol) return Double.NegativeInfinity;
Index: System/Enum.cs
===================================================================
--- System/Enum.cs	(revision 39533)
+++ System/Enum.cs	(working copy)
@@ -494,7 +494,7 @@
 				case TypeCode.UInt64:
 					return ((ulong)value).ToString (format);
 				default:
-					throw new Exception ("Invalid type code for enumeration.");
+					throw new SystemException ("Invalid type code for enumeration.");
 			}
 		}
 
Index: System/Decimal.cs
===================================================================
--- System/Decimal.cs	(revision 39533)
+++ System/Decimal.cs	(working copy)
@@ -926,7 +926,7 @@
 		s = stripStyles(s, style, nfi, out iDecPos, out isNegative, out expFlag, out exp);
 
 		if (iDecPos < 0)
-			throw new Exception (Locale.GetText ("Error in System.Decimal.Parse"));
+			throw new SystemException (Locale.GetText ("Error in System.Decimal.Parse"));
 
 		// first we remove leading 0
 		int len = s.Length;
Index: System/ModuleHandle.cs
===================================================================
--- System/ModuleHandle.cs	(revision 39533)
+++ System/ModuleHandle.cs	(working copy)
@@ -70,7 +70,7 @@
 				throw new ArgumentNullException (String.Empty, "Invalid handle");
 			IntPtr res = Module.ResolveFieldToken (value, fieldToken, out error);
 			if (res == IntPtr.Zero)
-				throw new Exception (String.Format ("Could not load field '0x{0:x}' from assembly '0x{1:x}'", fieldToken, value.ToInt64 ()));
+				throw new SystemException (String.Format ("Could not load field '0x{0:x}' from assembly '0x{1:x}'", fieldToken, value.ToInt64 ()));
 			else
 				return new RuntimeFieldHandle (res);
 		}
@@ -82,7 +82,7 @@
 				throw new ArgumentNullException (String.Empty, "Invalid handle");
 			IntPtr res = Module.ResolveMethodToken (value, methodToken, out error);
 			if (res == IntPtr.Zero)
-				throw new Exception (String.Format ("Could not load method '0x{0:x}' from assembly '0x{1:x}'", methodToken, value.ToInt64 ()));
+				throw new SystemException (String.Format ("Could not load method '0x{0:x}' from assembly '0x{1:x}'", methodToken, value.ToInt64 ()));
 			else
 				return new RuntimeMethodHandle (res);
 		}
Index: System.Resources/Win32Resources.cs
===================================================================
--- System.Resources/Win32Resources.cs	(revision 39533)
+++ System.Resources/Win32Resources.cs	(working copy)
@@ -685,7 +685,7 @@
 			int idReserved = r.ReadInt16 ();
 			int idType = r.ReadInt16 ();
 			if ((idReserved != 0) || (idType != 1))
-				throw new Exception ("Invalid .ico file format");
+				throw new SystemException ("Invalid .ico file format");
 			long nitems = r.ReadInt16 ();
 
 			icons = new ICONDIRENTRY [nitems];
Index: System.Collections/Hashtable.cs
===================================================================
--- System.Collections/Hashtable.cs	(revision 39533)
+++ System.Collections/Hashtable.cs	(working copy)
@@ -865,7 +865,7 @@
 					case EnumeratorMode.ENTRY_MODE:
 						return new DictionaryEntry (currentKey, currentValue);
 					}
-					throw new Exception ("should never happen");
+					throw new SystemException ("should never happen");
 				}
 			}
 		}
Index: System.Collections/SortedList.cs
===================================================================
--- System.Collections/SortedList.cs	(revision 39533)
+++ System.Collections/SortedList.cs	(working copy)
@@ -528,7 +528,7 @@
 			freeIndx = ~freeIndx;
 
 			if (freeIndx > Capacity + 1)
-				throw new Exception ("SortedList::internal error ("+key+", "+value+") at ["+freeIndx+"]");
+				throw new SystemException ("SortedList::internal error ("+key+", "+value+") at ["+freeIndx+"]");
 
 
 			EnsureCapacity (Count+1, freeIndx);
Index: System.Reflection.Emit/ILGenerator.cs
===================================================================
--- System.Reflection.Emit/ILGenerator.cs	(revision 39533)
+++ System.Reflection.Emit/ILGenerator.cs	(working copy)
@@ -597,7 +597,7 @@
 			make_room (6);
 
 			if (lbuilder.ilgen != this)
-				throw new Exception ("Trying to emit a local from a different ILGenerator.");
+				throw new SystemException ("Trying to emit a local from a different ILGenerator.");
 
 			/* inline the code from ll_emit () to optimize il code size */
 			if (opcode.StackBehaviourPop == StackBehaviour.Pop1) {
Index: System.Reflection.Emit/TypeBuilder.cs
===================================================================
--- System.Reflection.Emit/TypeBuilder.cs	(revision 39533)
+++ System.Reflection.Emit/TypeBuilder.cs	(working copy)
@@ -1137,7 +1137,7 @@
 					break;
 				default:
 					// we should ignore it since it can be any value anyway...
-					throw new Exception ("Error in customattr");
+					throw new SystemException ("Error in customattr");
 				}
 				string first_type_name = customBuilder.Ctor.GetParameters()[0].ParameterType.FullName;
 				int pos = 6;
Index: Mono.Math.Prime/PrimalityTests.cs
===================================================================
--- Mono.Math.Prime/PrimalityTests.cs	(revision 39533)
+++ Mono.Math.Prime/PrimalityTests.cs	(working copy)
@@ -88,7 +88,7 @@
 				case ConfidenceFactor.ExtraHigh:
 					return Rounds << 2;
 				case ConfidenceFactor.Provable:
-					throw new Exception ("The Rabin-Miller test can not be executed in a way such that its results are provable");
+					throw new SystemException ("The Rabin-Miller test can not be executed in a way such that its results are provable");
 				default:
 					throw new ArgumentOutOfRangeException ("confidence");
 			}
Index: System.Globalization/NumberFormatInfo.cs
===================================================================
--- System.Globalization/NumberFormatInfo.cs	(revision 39533)
+++ System.Globalization/NumberFormatInfo.cs	(working copy)
@@ -722,7 +722,7 @@
 					("The current instance is read-only and a set operation was attempted");
 				
 if (this == CultureInfo.CurrentCulture.NumberFormat)
-throw new Exception ("HERE the value was modified");
+throw new SystemException ("HERE the value was modified");
 				// All elements except last need to be in range 1 - 9, last can be 0.
 				int last = value.Length - 1;
 
Index: System.Globalization/DateTimeFormatInfo.cs
===================================================================
--- System.Globalization/DateTimeFormatInfo.cs	(revision 39533)
+++ System.Globalization/DateTimeFormatInfo.cs	(working copy)
@@ -167,7 +167,7 @@
 		{
 			if (era < _Calendar.Eras.Length || era >= _Calendar.Eras.Length)
 				throw new ArgumentOutOfRangeException();
-			notImplemented();
+			throw new NotImplementedException ();
 			//FIXME: implement me
 			return null;
 		}
@@ -183,7 +183,7 @@
 		{
 			if (eraName == null) throw new ArgumentNullException();
 			eraName = eraName.ToUpper();
-			notImplemented();
+			throw new NotImplementedException ();
 			//FIXME: implement me
 			return -1;
 		}
@@ -198,7 +198,7 @@
 			}
 			catch {
 				//FIXME: implement me
-				notImplemented();
+				throw new NotImplementedException ();
 				return null;
 			}
 		}
@@ -683,10 +683,5 @@
 			}
 			return null;
 		}
-
-		private static void notImplemented()
-		{
-			throw new Exception("Not implemented");
-		}
 	}
 }
Index: System.Globalization/RegionInfo.cs
===================================================================
--- System.Globalization/RegionInfo.cs	(revision 39533)
+++ System.Globalization/RegionInfo.cs	(working copy)
@@ -1163,7 +1163,7 @@
 			get {
 				switch (NLS_id) {
 				default:
-					throw new Exception ("Dunno what is currency symbol for " + NLS_id + " Region. FIXME.");
+					throw new SystemException ("Dunno what is currency symbol for " + NLS_id + " Region. FIXME.");
 				}
 			}
 		}
@@ -1183,7 +1183,7 @@
 				case 840: // United States
 					return "United States";
 				default:
-					throw new Exception ("FIXME. Please add your region name in language used in this region.");
+					throw new SystemException ("FIXME. Please add your region name in language used in this region.");
 				}
 			}
 		}
@@ -1670,7 +1670,7 @@
 				case 716:
 					return "Zimbabwe";
 				default:
-					throw new Exception ("This code should not be reached.");
+					throw new SystemException ("This code should not be reached.");
 				}
 			}
 		}
@@ -1683,7 +1683,7 @@
 				case 840: // United States
 					return false;
 				default:
-					throw new Exception ("FIXME. Please define.");
+					throw new SystemException ("FIXME. Please define.");
 				}
 			}
 		}
@@ -1692,7 +1692,7 @@
 			get {
 				switch (NLS_id) {
 				default:
-					throw new Exception ("This code should not be reached.");
+					throw new SystemException ("This code should not be reached.");
 				}
 			}
 		}
Index: System.Globalization/CultureInfo.cs
===================================================================
--- System.Globalization/CultureInfo.cs	(revision 39533)
+++ System.Globalization/CultureInfo.cs	(working copy)
@@ -625,7 +625,7 @@
 					cal = new ThaiBuddhistCalendar ();
 					break;
 				default:
-					throw new Exception ("invalid calendar type:  " + *(calendar_data + i));
+					throw new SystemException ("invalid calendar type:  " + *(calendar_data + i));
 				}
 				optional_calendars [i] = cal;
 			}
Index: System.Globalization/Calendar.cs
===================================================================
--- System.Globalization/Calendar.cs	(revision 39533)
+++ System.Globalization/Calendar.cs	(working copy)
@@ -894,7 +894,7 @@
 		get {
 			if (M_AbbrEraNames == null ||
 			    M_AbbrEraNames.Length != Eras.Length)
-				throw new Exception(
+				throw new SystemException(
 					"Internal: M_AbbrEraNames " +
 					"wrong initialized!");
 			return (string[])M_AbbrEraNames.Clone();
@@ -919,7 +919,7 @@
 		get {
 			if (M_EraNames == null ||
 			    M_EraNames.Length != Eras.Length)
-				throw new Exception(
+				throw new SystemException(
 					"Internal: M_EraNames " +
 					"not initialized!");
 			return (string[])M_EraNames.Clone();
Index: Mono.Security/Uri.cs
===================================================================
--- Mono.Security/Uri.cs	(revision 39533)
+++ Mono.Security/Uri.cs	(working copy)
@@ -1114,7 +1114,7 @@
 					if (result.Count == 0) {
 						if (i == 1) // see bug 52599
 							continue;
-						throw new Exception ("Invalid path.");
+						throw new SystemException ("Invalid path.");
 					}
 
 					result.RemoveAt (result.Count - 1);
Index: System.Security.Cryptography/DSA.cs
===================================================================
--- System.Security.Cryptography/DSA.cs	(revision 39533)
+++ System.Security.Cryptography/DSA.cs	(working copy)
@@ -94,7 +94,7 @@
 				sp.LoadXml (xmlString);
 				SecurityElement se = sp.ToXml ();
 				if (se.Tag != "DSAKeyValue")
-					throw new Exception ();
+					throw new SystemException ();
 				dsaParams.P = GetNamedParam (se, "P");
 				dsaParams.Q = GetNamedParam (se, "Q");
 				dsaParams.G = GetNamedParam (se, "G");
Index: System.IO/StreamReader.cs
===================================================================
--- System.IO/StreamReader.cs	(revision 39533)
+++ System.IO/StreamReader.cs	(working copy)
@@ -210,7 +210,7 @@
 		{
 			get {
 				if (encoding == null)
-					throw new Exception ();
+					throw new SystemException ();
 				return encoding;
 			}
 		}
Index: Mono.Math/BigInteger.cs
===================================================================
--- Mono.Math/BigInteger.cs	(revision 39533)
+++ Mono.Math/BigInteger.cs	(working copy)
@@ -368,7 +368,7 @@
 				case Sign.Negative:
 					throw new ArithmeticException (WouldReturnNegVal);
 				default:
-					throw new Exception ();
+					throw new SystemException ();
 			}
 		}
 
@@ -1069,7 +1069,7 @@
 					case Sign.Negative:
 						diff = b - a; break;
 					default:
-						throw new Exception ();
+						throw new SystemException ();
 				}
 
 				if (diff >= mod) {
Index: System.Reflection/EventInfo.cs
===================================================================
--- System.Reflection/EventInfo.cs	(revision 39533)
+++ System.Reflection/EventInfo.cs	(working copy)
@@ -72,7 +72,7 @@
 		{
 			MethodInfo add = GetAddMethod ();
 			if (add == null)
-				throw new Exception ("No add method!?");
+				throw new SystemException ("No add method!?");
 
 			add.Invoke (target, new object [] {handler});
 		}
@@ -107,7 +107,7 @@
 		{
 			MethodInfo remove = GetRemoveMethod ();
 			if (remove == null)
-				throw new Exception ("No remove method!?");
+				throw new SystemException ("No remove method!?");
 
 			remove.Invoke (target, new object [] {handler});
 		}
Index: System.Reflection/MethodBase.cs
===================================================================
--- System.Reflection/MethodBase.cs	(revision 39533)
+++ System.Reflection/MethodBase.cs	(working copy)
@@ -166,7 +166,7 @@
 				ConstructorBuilder mb = (ConstructorBuilder)this;
 				return mb.get_next_table_index (obj, table, inc);
 			}
-			throw new Exception ("Method is not a builder method");
+			throw new SystemException ("Method is not a builder method");
 		}
 
 #if NET_2_0 || BOOTSTRAP_NET_2_0