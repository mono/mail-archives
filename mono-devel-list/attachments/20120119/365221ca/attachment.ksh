>From af1bd5d9e122c6512ae919b13539064e28436f63 Mon Sep 17 00:00:00 2001
From: Alistair Leslie-Hughes <leslie_alistair@hotmail.com>
Date: Mon, 16 Jan 2012 20:37:12 +1100
Subject: [PATCH] ComVisible should be true by default

Based off the information at
http://msdn.microsoft.com/en-us/library/ms182157%28v=vs.80%29.aspx
the ComVisible flag should be true unless explicitly set to false.
---
 mono/metadata/cominterop.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/mono/metadata/cominterop.c b/mono/metadata/cominterop.c
index a87d995..888e068 100644
--- a/mono/metadata/cominterop.c
+++ b/mono/metadata/cominterop.c
@@ -392,7 +392,7 @@ cominterop_com_visible (MonoClass* klass)
 	MonoError error;
 	MonoCustomAttrInfo *cinfo;
 	GPtrArray *ifaces;
-	MonoBoolean visible = 0;
+	MonoBoolean visible = 1;

 	/* Handle the ComVisibleAttribute */
 	if (!ComVisibleAttribute)
--
1.7.5.4

