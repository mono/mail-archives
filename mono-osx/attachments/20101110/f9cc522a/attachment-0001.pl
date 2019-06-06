>From e6cf014698dd4ce97b039bf8a526f89daa45223f Mon Sep 17 00:00:00 2001
From: Alex Shulgin <alexander.shulgin@yessoftware.com>
Date: Wed, 10 Nov 2010 19:46:47 +0200
Subject: [PATCH] Moved WebKit indexed container enumerators to Enumerators.cs; added DomNamedNodeMap string indexer.

---
 src/Makefile              |    2 +-
 src/WebKit/DomNodeList.cs |   48 ------------------
 src/WebKit/Enumerators.cs |  116 +++++++++++++++++++++++++++++++++++++++++++++
 src/WebKit/Indexers.cs    |    8 +++-
 4 files changed, 124 insertions(+), 50 deletions(-)
 delete mode 100644 src/WebKit/DomNodeList.cs
 create mode 100644 src/WebKit/Enumerators.cs

diff --git a/src/Makefile b/src/Makefile
index dc927b0..69ab657 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -49,7 +49,7 @@ MONOMAC_SOURCES = \
 	./AppKit/NSMatrix.cs				\
 	./AppKit/NSWindow.cs				\
 	./Growl/Constants.cs				\
-	./WebKit/DomNodeList.cs				\
+	./WebKit/Enumerators.cs				\
 	./WebKit/Indexers.cs
 
 GENERATOR_SOURCES = \
diff --git a/src/WebKit/DomNodeList.cs b/src/WebKit/DomNodeList.cs
deleted file mode 100644
index 00ba7c8..0000000
--- a/src/WebKit/DomNodeList.cs
+++ /dev/null
@@ -1,48 +0,0 @@
-using System;
-using System.Collections;
-using System.Collections.Generic;
-using MonoMac.CoreFoundation;
-using MonoMac.Foundation;
-using MonoMac.ObjCRuntime;
-
-namespace MonoMac.WebKit {
-	public partial class DomNodeList : IEnumerable<DomNode> {
-		public IEnumerator<DomNode> GetEnumerator () {
-			return new DomNodeListEnumerator (this);
-		}
-
-		IEnumerator IEnumerable.GetEnumerator () {
-			return new DomNodeListEnumerator (this);
-		}
-
-		class DomNodeListEnumerator : IEnumerator<DomNode> {
-			public DomNodeListEnumerator (DomNodeList list) {
-				_list = list;
-				Reset ();
-			}
-
-			public void Dispose () {
-				_list = null;
-			}
-
-			public DomNode Current {
-				get { return _list [_current]; }
-			}
-
-			object IEnumerator.Current {
-				get { return _list [_current]; }
-			}
-
-			public bool MoveNext () {
-				return ++_current < _list.Count;
-			}
-
-			public void Reset () {
-				_current = -1;
-			}
-
-			DomNodeList _list;
-			int _current;
-		}
-	}
-}
diff --git a/src/WebKit/Enumerators.cs b/src/WebKit/Enumerators.cs
new file mode 100644
index 0000000..bd35a38
--- /dev/null
+++ b/src/WebKit/Enumerators.cs
@@ -0,0 +1,116 @@
+using System;
+using System.Collections;
+using System.Collections.Generic;
+using MonoMac.CoreFoundation;
+using MonoMac.Foundation;
+using MonoMac.ObjCRuntime;
+
+namespace MonoMac.WebKit {
+
+	public interface IIndexedContainer<T> {
+		int Count { get; }
+		T this [int index] { get; }
+	}
+
+	internal class IndexedContainerEnumerator<T> : IEnumerator<T> {
+		public IndexedContainerEnumerator (IIndexedContainer<T> container) {
+			_container = container;
+			Reset ();
+		}
+
+		public void Dispose () {
+			_container = null;
+		}
+
+		public T Current {
+			get {
+				return _container [_index];
+			}
+		}
+
+		object IEnumerator.Current {
+			get { return ((IEnumerator<T>) this).Current; }
+		}
+
+		public bool MoveNext () {
+			return ++_index < _container.Count;
+		}
+
+		public void Reset () {
+			_index = -1;
+		}
+
+		IIndexedContainer<T> _container;
+		int _index;
+	}
+
+	public partial class DomCssRuleList : IIndexedContainer<DomCssRule>, IEnumerable<DomCssRule> {
+		public IEnumerator<DomCssRule> GetEnumerator () {
+			return new IndexedContainerEnumerator<DomCssRule> (this);
+		}
+
+		IEnumerator IEnumerable.GetEnumerator () {
+			return ((IEnumerable<DomCssRule>) this).GetEnumerator ();
+		}
+	}
+
+	public partial class DomCssStyleDeclaration : IIndexedContainer<string>, IEnumerable<string> {
+		public IEnumerator<string> GetEnumerator () {
+			return new IndexedContainerEnumerator<string> (this);
+		}
+
+		IEnumerator IEnumerable.GetEnumerator () {
+			return ((IEnumerable<string>) this).GetEnumerator ();
+		}
+	}
+
+	public partial class DomHtmlCollection : IIndexedContainer<DomNode>, IEnumerable<DomNode> {
+		public IEnumerator<DomNode> GetEnumerator () {
+			return new IndexedContainerEnumerator<DomNode> (this);
+		}
+
+		IEnumerator IEnumerable.GetEnumerator () {
+			return ((IEnumerable<DomNode>) this).GetEnumerator ();
+		}
+	}
+
+	public partial class DomMediaList : IIndexedContainer<string>, IEnumerable<string> {
+		public IEnumerator<string> GetEnumerator () {
+			return new IndexedContainerEnumerator<string> (this);
+		}
+
+		IEnumerator IEnumerable.GetEnumerator () {
+			return ((IEnumerable<string>) this).GetEnumerator ();
+		}
+	}
+
+	public partial class DomNamedNodeMap : IIndexedContainer<DomNode>, IEnumerable<DomNode> {
+		public IEnumerator<DomNode> GetEnumerator () {
+			return new IndexedContainerEnumerator<DomNode> (this);
+		}
+
+		IEnumerator IEnumerable.GetEnumerator () {
+			return ((IEnumerable<DomNode>) this).GetEnumerator ();
+		}
+	}
+
+	public partial class DomNodeList : IIndexedContainer<DomNode>, IEnumerable<DomNode> {
+		public IEnumerator<DomNode> GetEnumerator () {
+			return new IndexedContainerEnumerator<DomNode> (this);
+		}
+
+		IEnumerator IEnumerable.GetEnumerator () {
+			return ((IEnumerable<DomNode>) this).GetEnumerator ();
+		}
+	}
+
+	public partial class DomStyleSheetList : IIndexedContainer<DomStyleSheet>, IEnumerable<DomStyleSheet> {
+		public IEnumerator<DomStyleSheet> GetEnumerator () {
+			return new IndexedContainerEnumerator<DomStyleSheet> (this);
+		}
+
+		IEnumerator IEnumerable.GetEnumerator () {
+			return ((IEnumerable<DomStyleSheet>) this).GetEnumerator ();
+		}
+	}
+}
diff --git a/src/WebKit/Indexers.cs b/src/WebKit/Indexers.cs
index ec002f9..7778654 100644
--- a/src/WebKit/Indexers.cs
+++ b/src/WebKit/Indexers.cs
@@ -38,6 +38,12 @@ namespace MonoMac.WebKit {
 				return GetItem (index);
 			}
 		}
+
+		public DomNode this [string name] {
+			get {
+				return GetNamedItem (name);
+			}
+		}
 	}
 	
 	public partial class DomNodeList {
@@ -55,4 +61,4 @@ namespace MonoMac.WebKit {
 			}
 		}
 	}
-}
\ No newline at end of file
+}
-- 
1.7.2

