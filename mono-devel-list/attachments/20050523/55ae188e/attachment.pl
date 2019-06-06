BVTs_bvt083	Exception: 'sort' element is not allowed here as a templete content. file:///Z:/svn-writtable/mcs/class/System.XML/Test/System.Xml.Xsl/standalone_tests/testsuite/TESTS/MSFT_Conformance_Tests/BVTs/sort.xsl line 16, position 5 file:///Z:/svn-writtable/mcs/class/System.XML/Test/System.Xml.Xsl/standalone_tests/testsuite/TESTS/MSFT_Conformance_Tests/BVTs/sort.xsl line 16, position 5
FormatNumber_FormatNumberWithPattern.00	Different.
 Actual*****
<format>.00</format>
-------------------
Reference*****
<format>.12</format>

FormatNumber_FormatNumberWithPattern.000	Different.
 Actual*****
<format>.000</format>
-------------------
Reference*****
<format>.120</format>

Output_HtmlOutputWithAmpersandCurlyBracket	Different.
 Actual*****
<html><body><area checked>foo</body></html>
-------------------
Reference*****
<html><body><area checked="&{foo}">foo</body></html>

Output_HtmlWithTwoAdjacentEscapedAmpersands	Different.
 Actual*****
<html><body><div checked>text</div></body></html>
-------------------
Reference*****
<html><body><div checked="&amp;&amp;">text</div></body></html>

Sorting_Sort_MixedCaseWithUpperSet	Different.
 Actual*****
<root><text>Bar</text><text>bar</text><text>Car</text><text>car</text><text>car</text><text>Car</text><text>bar</text><text>Bar</text></root>
-------------------
Reference*****
<root><text>bar</text><text>Bar</text><text>car</text><text>Car</text><text>Car</text><text>car</text><text>Bar</text><text>bar</text></root>

Sorting_Sort_SortWithUpperCharactersInMiddleOfTextLowerCaseFirst	Different.
 Actual*****
<root><text>bAr far</text><text>bar fAr</text><text>bar far</text><text>cAr far</text><text>car fAr</text><text>car far</text><text>car far</text><text>car fAr</text><text>cAr far</text><text>bar far</text><text>bar fAr</text><text>bAr far</text></root>
-------------------
Reference*****
<root><text>bar far</text><text>bar fAr</text><text>bAr far</text><text>car far</text><text>car fAr</text><text>cAr far</text><text>cAr far</text><text>car fAr</text><text>car far</text><text>bAr far</text><text>bar fAr</text><text>bar far</text></root>

Sorting_Sort_SortWithUpperCharactersInMiddleOfTextUpperCaseFirst	Different.
 Actual*****
<root><text>bar far</text><text>bar fAr</text><text>bAr far</text><text>car far</text><text>car fAr</text><text>cAr far</text><text>cAr far</text><text>car fAr</text><text>car far</text><text>bAr far</text><text>bar fAr</text><text>bar far</text></root>
-------------------
Reference*****
<root><text>bAr far</text><text>bar fAr</text><text>bar far</text><text>cAr far</text><text>car fAr</text><text>car far</text><text>car far</text><text>car fAr</text><text>cAr far</text><text>bar far</text><text>bar fAr</text><text>bAr far</text></root>

Sorting_Sort_UpperFirstOnTextWithUpper	Different.
 Actual*****
<root><text>bar</text><text>Bar</text><text>car</text><text>Car</text><text>Car</text><text>car</text><text>Bar</text><text>bar</text></root>
-------------------
Reference*****
<root><text>Bar</text><text>bar</text><text>Car</text><text>car</text><text>car</text><text>Car</text><text>bar</text><text>Bar</text></root>

XSLTFunctions__emptyParameters	Exception: Invalid number format pattern string. file:///Z:/svn-writtable/mcs/class/System.XML/Test/System.Xml.Xsl/standalone_tests/testsuite/TESTS/MSFT_Conformance_Tests/XSLTFunctions/fmt-no.xml file:///Z:/svn-writtable/mcs/class/System.XML/Test/System.Xml.Xsl/standalone_tests/testsuite/TESTS/MSFT_Conformance_Tests/XSLTFunctions/fmt-no.xml
XSLTFunctions__minimumValue	Different.
 Actual*****
<test>2.22E-308***#0.####################################################################################################################################################################################################################################################################################################################################***0222</test>
-------------------
Reference*****
<test>2.22E-308***#0.####################################################################################################################################################################################################################################################################################################################################***0.0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000222</test>

XSLTFunctions_RoundTripNumber_UsingStringFn	Different.
 Actual*****
<?xml version="1.0" encoding="utf-16"?><ERROR>The processor has a roundtripping bug!!</ERROR><root><left>0.04702523</left><right>0.04702523</right></root>
-------------------
Reference*****
<?xml version="1.0" encoding="utf-16"?><root><left>0.047025229999999994</left><right>0.04702523</right></root>

