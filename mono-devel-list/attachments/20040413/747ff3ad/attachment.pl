diff -u System.Web/System.Web/HttpResponse.cs System.Web/System.Web/HttpResponse.cs
--- System.Web/System.Web/HttpResponse.cs
+++ System.Web/System.Web/HttpResponse.cs
@@ -55,6 +55,7 @@
 
 		HttpCookieCollection _Cookies;
 		HttpCachePolicy _CachePolicy;
+		CacheabilityUpdatedCallback _CacheabilityUpdatedCallback;
 
 		Encoding _ContentEncoding;
 			
@@ -377,8 +378,9 @@
 			get {
 				if (null == _CachePolicy) {
 					_CachePolicy = new HttpCachePolicy ();
-					_CachePolicy.CacheabilityUpdated += new CacheabilityUpdatedCallback (
+					_CacheabilityUpdatedCallback = new CacheabilityUpdatedCallback (
 						OnCacheabilityUpdated);
+					_CachePolicy.CacheabilityUpdated += _CacheabilityUpdatedCallback;
 				}
 
 				return _CachePolicy;
@@ -862,8 +875,14 @@
 				}
 				_Writer.Clear ();
 			} finally {
-				if (bFinish)
+				if (bFinish) {
 					closed = true;
+
+					// delete the delegate in order to let "this" garbage collected even
+					// if _CachePolicy is not GC'ed.
+					if (_CachePolicy != null)
+						_CachePolicy.CacheabilityUpdated -= _CacheabilityUpdatedCallback;
+				}
 				_bFlushing = false;
 			}
 		}
diff -u System.Web/System.Web.Caching/Cache.cs System.Web/System.Web.Caching/Cache.cs
--- System.Web/System.Web.Caching/Cache.cs
+++ System.Web/System.Web.Caching/Cache.cs
@@ -222,13 +222,20 @@
 			if (objEntry.HasSlidingExpiration || objEntry.HasAbsoluteExpiration)
 				_objExpires.Add (objEntry);
 
-			// Check and get the new item..
-			objNewEntry = UpdateCache (strKey, objEntry, true, CacheItemRemovedReason.Removed);
-
-			if (objNewEntry == null)
-				return null;
+			bool boolAdded = false;
+			_lockEntries.AcquireWriterLock (-1);
+			try {
+				_arrEntries [strKey] = objEntry;
+				boolAdded = true;
+			} finally {
+				_lockEntries.ReleaseLock ();
+			}
 
+			if (boolAdded) {
 			return objEntry.Item;
+			} else {
+				return null;
+			}
 		}
 		
 		/// <summary>
@@ -401,13 +408,35 @@
 		/// </returns>
 		internal object Remove (string strKey, CacheItemRemovedReason enumReason)
 		{
-			CacheEntry objEntry = UpdateCache (strKey, null, true, enumReason);
+
+			CacheEntry objEntry;
+			bool boolRemoved = false;
+
+			_lockEntries.AcquireReaderLock (-1);
+			try {
+				objEntry = (CacheEntry) _arrEntries [strKey];
 			if (objEntry == null)
 				return null;
 
+				Threading.LockCookie objCookie = _lockEntries.UpgradeToWriterLock (-1);
+				try {
+					_arrEntries.Remove (strKey);
+					boolRemoved = true;
+				} finally {
+					_lockEntries.DowngradeFromWriterLock (ref objCookie);
+				}
+			} finally {
+				_lockEntries.ReleaseLock ();
+			}
+		
+			if (!boolRemoved)
+				return null;
+				
+			if (objEntry.HasAbsoluteExpiration || objEntry.HasSlidingExpiration)
+				_objExpires.Remove (objEntry);
+
 			Interlocked.Decrement (ref _nItems);
 
-			// Close the cache entry (calls the remove delegate)
 			objEntry.Close (enumReason);
 
 			return objEntry.Item;
@@ -420,7 +450,8 @@
 		/// <returns>The retrieved cache item, or a null reference.</returns>
 		public object Get (string strKey)
 		{
-			CacheEntry objEntry = UpdateCache (strKey, null, false, CacheItemRemovedReason.Expired);
+
+			CacheEntry objEntry = GetEntry (strKey);
 
 			if (objEntry == null)
 				return null;
@@ -430,97 +462,36 @@
 
 		internal CacheEntry GetEntry (string strKey)
 		{
-			CacheEntry objEntry = UpdateCache (strKey, null, false, CacheItemRemovedReason.Expired);
-
-			if (objEntry == null)
-				return null;
 
-			return objEntry;
-		}
-
-		/// <summary>
-		/// Internal method used for removing, updating and adding CacheEntries into the cache.
-		/// </summary>
-		/// <param name="strKey">The identifier for the cache item to modify</param>
-		/// <param name="objEntry">
-		/// CacheEntry to use for overwrite operation, if this
-		/// parameter is null and overwrite true the item is going to be
-		/// removed
-		/// </param>
-		/// <param name="boolOverwrite">
-		/// If true the objEntry parameter is used to overwrite the
-		/// strKey entry
-		/// </param>
-		/// <param name="enumReason">Reason why an item was removed</param>
-		/// <returns></returns>
-		private CacheEntry UpdateCache (string strKey,
-						CacheEntry objEntry,
-						bool boolOverwrite,
-						CacheItemRemovedReason enumReason)
-		{
 			if (strKey == null)
 				throw new ArgumentNullException ("strKey");
 
+			CacheEntry objEntry;
+			bool boolExpired = false;
+			bool boolRemoved = false;
 			long ticksNow = DateTime.Now.Ticks;
 			long ticksExpires = long.MaxValue;
 
-			bool boolGetItem = false;
-			bool boolExpiried = false;
-			bool boolWrite = false;
-			bool boolRemoved = false;
-
-			// Are we getting the item from the hashtable
-			if (boolOverwrite == false && strKey.Length > 0 && objEntry == null)
-				boolGetItem = true;
-
-			// TODO: Optimize this method, move out functionality outside the lock
-			_lockEntries.AcquireReaderLock (-1);
+			_lockEntries.AcquireReaderLock (-1);
 			try {
-				if (boolGetItem) {
 					objEntry = (CacheEntry) _arrEntries [strKey];
 					if (objEntry == null)
 						return null;
-				}
 
-				if (objEntry != null) {
-					// Check if we have expired
 					if (objEntry.HasSlidingExpiration || objEntry.HasAbsoluteExpiration) {
 						if (objEntry.Expires < ticksNow) {
 							// We have expired, remove the item from the cache
-							boolWrite = true;
-							boolExpiried = true;
-						} 
-					} 
-				}
-
-				// Check if we going to modify the hashtable
-				if (boolWrite || (boolOverwrite && !boolExpiried)) {
-					// Upgrade our lock to write
-					Threading.LockCookie objCookie = _lockEntries.UpgradeToWriterLock (-1);
+						boolExpired = true;
+						Threading.LockCookie objCookie = _lockEntries.UpgradeToWriterLock (-1);
 					try {
-						// Check if we going to just modify an existing entry (or add)
-						if (boolOverwrite && objEntry != null) {
-							_arrEntries [strKey] = objEntry;
-						} else {
-							// We need to remove the item, fetch the item first
-							objEntry = (CacheEntry) _arrEntries [strKey];
-							if (objEntry != null)
 								_arrEntries.Remove (strKey);
-
 							boolRemoved = true;
-						}
 					} finally {
 						_lockEntries.DowngradeFromWriterLock (ref objCookie);
 					}
 				}
-
-				// If the entry haven't expired or been removed update the info
-				if (!boolExpiried && !boolRemoved) {
-					// Update that we got a hit
-					objEntry.Hits++;
-					if (objEntry.HasSlidingExpiration)
-						ticksExpires = ticksNow + objEntry.SlidingExpiration;
 				}
+
 			} finally {
 				_lockEntries.ReleaseLock ();
 			}
@@ -525,26 +496,27 @@
 				_lockEntries.ReleaseLock ();
 			}
 
-			// If the item was removed we need to remove it from the CacheExpired class also
 			if (boolRemoved) {
-				if (objEntry != null) {
 					if (objEntry.HasAbsoluteExpiration || objEntry.HasSlidingExpiration)
 						_objExpires.Remove (objEntry);
-				}
-				objEntry.Close (enumReason);
+				Interlocked.Decrement (ref _nItems);
+				objEntry.Close (CacheItemRemovedReason.Expired);
 				return null;
 			}
 
-			// If we have sliding expiration and we have a correct hit, update the expiration manager
+			if (!boolExpired) {
+				objEntry.Hits++;
 			if (objEntry.HasSlidingExpiration) {
+					ticksExpires = ticksNow + objEntry.SlidingExpiration;
 				_objExpires.Update (objEntry, ticksExpires);
 				objEntry.Expires = ticksExpires;
 			}
-
-			// Return the cache entry
 			return objEntry;
 		}
 
+			return null;
+		}
+
 		/// <summary>
 		/// Gets the number of items stored in the cache.
 		/// </summary>