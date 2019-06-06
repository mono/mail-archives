Index: mono/io-layer/sockets.c
===================================================================
--- mono/io-layer/sockets.c	(revision 76427)
+++ mono/io-layer/sockets.c	(working copy)
@@ -707,6 +707,19 @@
 		
 		return(SOCKET_ERROR);
 	}
+
+#if defined(__FreeBSD__)
+	/* FreeBSD's multicast sockets also need SO_REUSEPORT when SO_REUSEADDR is requested.  */
+	if (level == SOL_SOCKET && optname == SO_REUSEADDR) {
+		int type;
+		int type_len = sizeof (type);
+
+		if (!getsockopt (fd, level, optname, &type, &type_len)) {
+			if (type == SOCK_DGRAM)
+				setsockopt (fd, level, SO_REUSEPORT, tmp_val, optlen);
+		}
+	}
+#endif
 	
 	return(ret);
 }
