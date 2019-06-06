diff -Naur ./System.Xml.XPath/Expression.cs ../monopatched/System.Xml.XPath/Expression.cs
--- ./System.Xml.XPath/Expression.cs	2005-02-06 17:27:16.000000000 +0200
+++ ../monopatched/System.Xml.XPath/Expression.cs	2005-02-08 18:20:53.000000000 +0200
@@ -463,9 +463,7 @@
 				case XPathResultType.NodeSet:
 					return XPathFunctions.ToNumber (EvaluateString (iter));
 				case XPathResultType.String:
-					return XPathFunctions.ToNumber ((string) result);
-				case XPathResultType.Navigator:
-					return XPathFunctions.ToNumber (((XPathNavigator) (result)).Value);
+					return XPathFunctions.ToNumber (result.ToString ());
 				default:
 					throw new XPathException ("invalid node type");
 			}
@@ -484,7 +482,7 @@
 				case XPathResultType.Boolean:
 					return ((bool) result) ? "true" : "false";
 				case XPathResultType.String:
-					return (string) result;
+					return result.ToString ();
 				case XPathResultType.NodeSet:
 				{
 					BaseIterator iterResult = (BaseIterator) result;
@@ -492,8 +490,6 @@
 						return "";
 					return iterResult.Current.Value;
 				}
-				case XPathResultType.Navigator:
-					return ((XPathNavigator) result).Value;
 				default:
 					throw new XPathException ("invalid node type");
 			}
@@ -515,14 +511,12 @@
 				case XPathResultType.Boolean:
 					return (bool) result;
 				case XPathResultType.String:
-					return ((string) result).Length != 0;
+					return (result.ToString ()).Length != 0;
 				case XPathResultType.NodeSet:
 				{
 					BaseIterator iterResult = (BaseIterator) result;
 					return (iterResult != null && iterResult.MoveNext ());
 				}
-				case XPathResultType.Navigator:
-					return ((string) ((XPathNavigator) result).Value).Length != 0;
 				default:
 					throw new XPathException ("invalid node type");
 			}
@@ -640,9 +634,9 @@
 				typeR = GetReturnType (_right.Evaluate (iter));
 
 			// Regard RTF as nodeset
-			if (typeL == XPathResultType.Navigator)
+			if (typeL == XPathResultType.Navigator && _left is XPathNavigator)
 				typeL = XPathResultType.NodeSet;
-			if (typeR == XPathResultType.Navigator)
+			if (typeR == XPathResultType.Navigator && _right is XPathNavigator)
 				typeR = XPathResultType.NodeSet;
 
 			if (typeL == XPathResultType.NodeSet || typeR == XPathResultType.NodeSet)
diff -Naur ./System.Xml.XPath/XPathResultType.cs ../monopatched/System.Xml.XPath/XPathResultType.cs
--- ./System.Xml.XPath/XPathResultType.cs	2004-09-12 11:57:49.000000000 +0300
+++ ../monopatched/System.Xml.XPath/XPathResultType.cs	2005-02-08 18:21:08.000000000 +0200
@@ -39,8 +39,7 @@
 		String = 1,
 		Boolean = 2,
 		NodeSet = 3,
-		[MonoFIX ("MS.NET: 1")]
-		Navigator = 4,
+		Navigator = 1,
 		Any = 5,
 		Error = 6,
 	}
