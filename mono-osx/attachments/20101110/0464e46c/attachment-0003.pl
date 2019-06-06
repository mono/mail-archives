using System;
using System.Collections;
using System.Collections.Generic;
using MonoMac.CoreFoundation;
using MonoMac.Foundation;
using MonoMac.ObjCRuntime;

namespace MonoMac.WebKit {
	internal class IndexedContainerEnumerator<T> : IEnumerator<T> {
		public IndexedContainerEnumerator (IIndexedContainer<T> container) {
			_container = container;
			Reset ();
		}

		public void Dispose () {
			_container = null;
		}

		public T Current {
			get {
				return _container [_index];
			}
		}

		object IEnumerator.Current {
			get { return ((IEnumerator<T>) this).Current; }
		}

		public bool MoveNext () {
			return ++_index < _container.Length;
		}

		public void Reset () {
			_index = -1;
		}

		IIndexedContainer<T> _container;
		int _index;
	}
}
