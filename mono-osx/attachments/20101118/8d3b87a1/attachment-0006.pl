>From 7d8b57e0259be33e064cba6511c1238c71a5d1ab Mon Sep 17 00:00:00 2001
From: Alex Shulgin <alexander.shulgin@yessoftware.com>
Date: Thu, 18 Nov 2010 15:59:59 +0200
Subject: [PATCH 06/12] Fixed some methods naming: HTML => Html, CSS => Css.

---
 src/webkit.cs |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/webkit.cs b/src/webkit.cs
index bfec558..bc6d1cd 100644
--- a/src/webkit.cs
+++ b/src/webkit.cs
@@ -710,10 +710,10 @@ namespace MonoMac.WebKit {
 		DomCssStyleDeclaration GetComputedStyle (DomElement element, string pseudoElement);
 
 		[Export ("getMatchedCSSRules:pseudoElement:")]
-		DomCssRuleList GetMatchedCSSRules (DomElement element, string pseudoElement);
+		DomCssRuleList GetMatchedCssRules (DomElement element, string pseudoElement);
 
 		[Export ("getMatchedCSSRules:pseudoElement:authorOnly:")]
-		DomCssRuleList GetMatchedCSSRules (DomElement element, string pseudoElement, bool authorOnly);
+		DomCssRuleList GetMatchedCssRules (DomElement element, string pseudoElement, bool authorOnly);
 
 		[Export ("getElementsByClassName:")]
 		DomNodeList GetElementsByClassName (string tagname);
@@ -1074,13 +1074,13 @@ namespace MonoMac.WebKit {
 		int TabIndex { get; set;  }
 
 		[Export ("innerHTML")]
-		string InnerHTML { get; set;  }
+		string InnerHtml { get; set;  }
 
 		[Export ("innerText")]
 		string InnerText { get; set;  }
 
 		[Export ("outerHTML")]
-		string OuterHTML { get; set;  }
+		string OuterHtml { get; set;  }
 
 		[Export ("outerText")]
 		string OuterText { get; set;  }
-- 
1.7.2

