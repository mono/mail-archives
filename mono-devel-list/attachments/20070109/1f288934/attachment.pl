Index: System.Web/System.Web.UI.WebControls/BaseCompareValidator.cs
===================================================================
--- System.Web/System.Web.UI.WebControls/BaseCompareValidator.cs	(revision 70722)
+++ System.Web/System.Web.UI.WebControls/BaseCompareValidator.cs	(working copy)
@@ -79,33 +79,7 @@
 					       ValidationDataType type,
 					       out object value)
 		{
-			try {
-				switch (type) {
-				case ValidationDataType.String:
-					value = text;
-					return value != null;
-				case ValidationDataType.Integer:
-					value = Int32.Parse (text);
-					return true;
-				case ValidationDataType.Double:
-					value = Double.Parse(text);
-					return true;
-				case ValidationDataType.Date:
-					value = DateTime.Parse(text);
-					return true;
-				case ValidationDataType.Currency:
-					value = Decimal.Parse(text, NumberStyles.Currency);
-					return true;
-				default:
-					value = null;
-					return false;
-				}
-			}
-			catch {
-				value = null;
-				return false;
-			}
-
+            return BaseCompareValidator.Convert(text, type, false, out value);
 		}
 
 		protected static bool Compare (string left,
@@ -113,40 +87,7 @@
 					       ValidationCompareOperator op,
 					       ValidationDataType type)
 		{
-			object lo, ro;
-
-			if (!Convert (left, type, out lo))
-				return false;
-
-			/* DataTypeCheck is a unary operator that only
-			 * depends on the lhs */
-			if (op == ValidationCompareOperator.DataTypeCheck)
-				return true;
-
-			/* pretty crackladen, but if we're unable to
-			 * convert the rhs to @type, the comparison
-			 * succeeds */
-			if (!Convert (right, type, out ro))
-				return true;
-
-			int comp = ((IComparable)lo).CompareTo ((IComparable)ro);
-
-			switch (op) {
-			case ValidationCompareOperator.Equal:
-				return comp == 0;
-			case ValidationCompareOperator.NotEqual:
-				return comp != 0;
-			case ValidationCompareOperator.LessThan:
-				return comp < 0;
-			case ValidationCompareOperator.LessThanEqual:
-				return comp <= 0;
-			case ValidationCompareOperator.GreaterThan:
-				return comp > 0;
-			case ValidationCompareOperator.GreaterThanEqual:
-				return comp >= 0;
-			default:
-				return false;
-			}
+            return BaseCompareValidator.Compare(left, false, right, false, op, type);	
 		}
 
 		protected override bool DetermineRenderUplevel ()
@@ -220,18 +161,24 @@
 #if NET_2_0
 		[DefaultValue (false)]
 		[Themeable (false)]
-		public bool CultureInvariantValues {
+		public
+#else 
+        	internal
+#endif
+            bool CultureInvariantValues {
 			get { return ViewState.GetBool ("CultureInvariantValues", false); }
 			set { ViewState ["CultureInvariantValues"] = value; }
 		}
-#endif
 
-		protected static int CutoffYear {
+
+		
+        	protected static int CutoffYear {
 			get {
 				return CultureInfo.CurrentCulture.Calendar.TwoDigitYearMax;
 			}
 		}
 
+
 		[DefaultValue(ValidationDataType.String)]
 #if NET_2_0
 		[Themeable (false)]
@@ -244,36 +191,131 @@
 		}
 
 #if NET_2_0
-		[MonoTODO ("Not implemented")]
-		public static bool CanConvert (string text, 
+		
+		public
+#else 
+        internal
+#endif 
+        static bool CanConvert (string text, 
 					       ValidationDataType type, 
 					       bool cultureInvariant)
 		{
-			throw new NotImplementedException ();
+            object value;
+            return Convert(text, type, cultureInvariant, out value);
 		}
 
-		[MonoTODO ("Not implemented")]
-		protected static bool Compare (string leftText, 
+#if NET_2_0
+		protected
+#else 
+        internal
+#endif 
+        static bool Compare (string left, 
 					       bool cultureInvariantLeftText, 
-					       string rightText, 
+					       string right, 
 					       bool cultureInvariantRightText, 
 					       ValidationCompareOperator op, 
 					       ValidationDataType type)
 		{
-			throw new NotImplementedException ();
+            object lo, ro;
+
+            if (!Convert(left, type, cultureInvariantLeftText, out lo))
+                return false;
+
+            /* DataTypeCheck is a unary operator that only
+             * depends on the lhs */
+            if (op == ValidationCompareOperator.DataTypeCheck)
+                return true;
+
+            /* pretty crackladen, but if we're unable to
+             * convert the rhs to @type, the comparison
+             * succeeds */
+            if (!Convert(right, type, cultureInvariantRightText, out ro))
+                return true;
+
+            int comp = ((IComparable)lo).CompareTo((IComparable)ro);
+
+            switch (op)
+            {
+                case ValidationCompareOperator.Equal:
+                    return comp == 0;
+                case ValidationCompareOperator.NotEqual:
+                    return comp != 0;
+                case ValidationCompareOperator.LessThan:
+                    return comp < 0;
+                case ValidationCompareOperator.LessThanEqual:
+                    return comp <= 0;
+                case ValidationCompareOperator.GreaterThan:
+                    return comp > 0;
+                case ValidationCompareOperator.GreaterThanEqual:
+                    return comp >= 0;
+                default:
+                    return false;
+            }
 		}
 
-		[MonoTODO ("Not implemented")]
-		protected static bool Convert (string text,
+#if NET_2_0
+	protected
+#else
+	internal
+#endif
+		static bool Convert (string text,
 					       ValidationDataType type,
 					       bool cultureInvariant,
 					       out object value)
 		{
-			throw new NotImplementedException ();
+            try
+            {
+                switch (type)
+                {
+                    case ValidationDataType.String:
+                        value = text;
+                        return value != null;
+
+                    case ValidationDataType.Integer:
+                        IFormatProvider intFormatProvider = (cultureInvariant) ? 
+                            NumberFormatInfo.InvariantInfo :
+                            NumberFormatInfo.CurrentInfo;
+                        value = Int32.Parse(text, intFormatProvider);
+                        return true;
+
+                    case ValidationDataType.Double:
+                        IFormatProvider doubleFormatProvider = (cultureInvariant) ?
+                            NumberFormatInfo.InvariantInfo :
+                            NumberFormatInfo.CurrentInfo;
+                        value = Double.Parse(text, doubleFormatProvider);
+                        return true;
+
+                    case ValidationDataType.Date:
+                        
+                        IFormatProvider dateFormatProvider = (cultureInvariant) ? 
+                            DateTimeFormatInfo.InvariantInfo :
+                            DateTimeFormatInfo.CurrentInfo;
+
+                        value = DateTime.Parse(text, dateFormatProvider);
+                        return true;
+
+                    case ValidationDataType.Currency:
+                        IFormatProvider currencyFormatProvider = (cultureInvariant) ?
+                            NumberFormatInfo.InvariantInfo :
+                            NumberFormatInfo.CurrentInfo;
+                        value = Decimal.Parse(text, NumberStyles.Currency, currencyFormatProvider);
+                        return true;
+
+                    default:
+                        value = null;
+                        return false;
+                }
+            }
+            catch
+            {
+                value = null;
+                return false;
+            }
 		}
-#endif
 	}
 
 }
 
 
+
+
Index: System.Web/System.Web.UI.WebControls/ChangeLog
===================================================================
--- System.Web/System.Web.UI.WebControls/ChangeLog	(revision 70722)
+++ System.Web/System.Web.UI.WebControls/ChangeLog	(working copy)
@@ -1,3 +1,8 @@
+2007-01-09  Ilya Kharmatsky <ilyak-at-mainsoft.com>
+	* BaseCompareValidator
+	* CompareValidator
+	Fixed the Invariant Calture issues.
+
 2007-01-08  Vladimir Krasnov  <vladimirk@mainsoft.com>
 
 	* SqlDataSourceView.cs: fixed parameters init for ExecuteUpdate
Index: System.Web/System.Web.UI.WebControls/CompareValidator.cs
===================================================================
--- System.Web/System.Web.UI.WebControls/CompareValidator.cs	(revision 70722)
+++ System.Web/System.Web.UI.WebControls/CompareValidator.cs	(working copy)
@@ -62,11 +62,16 @@
 
 		protected override bool ControlPropertiesValid ()
 		{
-			/* if the control id is the default "", or if we're
+            if ((this.Operator != ValidationCompareOperator.DataTypeCheck) && !BaseCompareValidator.CanConvert(this.ValueToCompare, this.Type, this.CultureInvariantValues))
+            {
+                throw new HttpException(
+                    String.Format("Unable to convert the value: {0} as a {1}", ValueToCompare, Enum.GetName(typeof(ValidationDataType), this.Type)));
+            }
+            /* if the control id is the default "", or if we're
 			 * using the one Operator that ignores the control
 			 * id.. */
-			if (ControlToCompare == "" || Operator == ValidationCompareOperator.DataTypeCheck)
-				return base.ControlPropertiesValid();
+            if (ControlToCompare == "" || Operator == ValidationCompareOperator.DataTypeCheck)
+                return base.ControlPropertiesValid();
 
 			/* attempt to locate the ControlToCompare somewhere on the page */
 			Control control = NamingContainer.FindControl (ControlToCompare);
@@ -86,9 +91,9 @@
 			/* ControlToCompare takes precendence, if it's set. */
 			compare = (ControlToCompare != "" ? GetControlValidationValue (ControlToCompare) : ValueToCompare);
 
-			return BaseCompareValidator.Compare (GetControlValidationValue (ControlToValidate), compare,
-							     Operator,
-							     this.Type);
+            return BaseCompareValidator.Compare (GetControlValidationValue (ControlToValidate), false, 
+                                compare, this.CultureInvariantValues,
+							    Operator, this.Type);
 		}
 
 		[DefaultValue("")]
