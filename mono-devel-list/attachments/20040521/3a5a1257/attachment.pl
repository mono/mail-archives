using System;

class T {

	static unsafe int Hash (string s) {
		//if (s.Length >= 1000)
		//	return s.GetHashCode ();
		fixed (char * c = s) {
			char * cc = c;
			char * end = cc + s.Length - 1;
			int h = 0;
			for (;cc < end; cc += 2) {
				h = (h << 5) - h + *cc;
				h = (h << 5) - h + cc [1];
			}
			++end;
			if (cc < end)
				h = (h << 5) - h + *cc;
			return h;
		}
	}

	static unsafe int Hash3 (string s) {
		//if (s.Length >= 1000)
		//	return s.GetHashCode ();
		fixed (char * c = s) {
			char * cc = c;
			int count = s.Length;

			int h = 0;
			while (count >= 4) {
				h = (h << 5) - h + cc [0];
				h = (h << 5) - h + cc [1];
				h = (h << 5) - h + cc [2];
				h = (h << 5) - h + cc [3];
				cc +=4;
				count -= 4;
			}

			if (count >= 2) {
				h = (h << 5) - h + cc [0];
				h = (h << 5) - h + cc [1];
				cc += 2;
				count -= 2;
			}

			if (count == 1)
				h = (h << 5) - h + cc [0];

			return h;
		}
	}

	static unsafe int Hash2 (string s) {
		//if (s.Length >= 1000)
		//	return s.GetHashCode ();
		fixed (char * c = s) {
			char * cc = c;
			char * end = cc + s.Length - 4;
			int h = 0;
			for (;cc < end; cc += 4) {
				h = (h << 5) - h + *cc;
				h = (h << 5) - h + cc [1];
				h = (h << 5) - h + cc [2];
				h = (h << 5) - h + cc [3];
			}
			end += 4;
			while (cc < end)
				h = (h << 5) - h + *cc++;

			return h;
		}
	}

	const int count = 1000000;
	static int test_new (int size, bool print) {
		string s = new String ('a', size);
		int start, end, i, v = 0;
		start = Environment.TickCount;
		for (i = 0; i < count; ++i) {
			v = Hash2 (s);
		}
		end = Environment.TickCount;
		if (print)
			Console.Write ("{0}\t{1}\t", size, end-start);
		return v;
	}

	static int test_old (int size, bool print) {
		string s = new String ('a', size);
		int start, end, i, v = 0;
		start = Environment.TickCount;
		for (i = 0; i < count; ++i) {
			//v = s.GetHashCode ();
			v = Hash3 (s);
		}
		end = Environment.TickCount;
		if (print)
			Console.WriteLine (end-start);
		return v;
	}

	static void test (int size) {
		int v1 = test_new (size, true);
		int v2 = test_old (size, true);
		if (v1 != v2)
			Console.WriteLine ("failed compare");
	}
	static void Main () {
		int size;
		for (size = 0; size < 500; ) {
			test (size);
			if (size < 5)
				size += 1;
			else if (size < 50)
				size += 5;
			else if (size < 150)
				size += 11;
			else
				size += 21;
		}
		// degenerate cases: we should always cache the hash in these cases
		test (1000);
		test (10000);
	}
}

