using System;
using System.Collections;
using System.Collections.Generic;
using MonoMac.CoreFoundation;
using MonoMac.Foundation;
using MonoMac.ObjCRuntime;

namespace MonoMac.WebKit {
	public partial class DomNodeList : IIndexedContainer<DomNode>, IEnumerable<DomNode> {
		public DomNode this [int index] {
			get { return GetItem (index); }
		}

		public IEnumerator<DomNode> GetEnumerator () {
			return new IndexedContainerEnumerator<DomNode> (this);
		}

		IEnumerator IEnumerable.GetEnumerator () {
			return ((IEnumerable<DomNode>) this).GetEnumerator ();
		}
	}
}
