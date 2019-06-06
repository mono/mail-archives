Index: BinaryReader.cs
===================================================================
--- BinaryReader.cs	(revision 38220)
+++ BinaryReader.cs	(working copy)
@@ -4,6 +4,7 @@
 // Author:
 //   Matt Kimball (matt@kimball.net)
 //   Dick Porter (dick@ximian.com)
+//   Kazuki Oikawa (kazuki@panicode.com)
 //
 
 //
@@ -35,316 +36,250 @@
 
 namespace System.IO {
 	public class BinaryReader : IDisposable {
-		Stream m_stream;
-		Encoding m_encoding;
-		int m_encoding_max_byte;
+		#region Local Variables
+		private Stream		_stream;
+		private Encoding	_encoding;
+		private bool		_disposed = false;
+		private byte[]		_buffer;
 
-		byte[] m_buffer;
-		
-		private bool m_disposed = false;
+		private byte[]		_rsbuffer = null;
+		#endregion
 
-		public BinaryReader(Stream input) : this(input, Encoding.UTF8Unmarked) {
+		#region Constructor/IDisposable
+		// FIXME: UTF8Unmarked -> UTF8
+		public BinaryReader (Stream input) : this (input, Encoding.UTF8Unmarked)
+		{
 		}
 
-		public BinaryReader(Stream input, Encoding encoding) {
-			if (input == null || encoding == null) 
-				throw new ArgumentNullException(Locale.GetText ("Input or Encoding is a null reference."));
+		public BinaryReader (Stream input, Encoding encoding)
+		{
+			if (input == null)
+				throw new ArgumentNullException ("input");
+			if (encoding == null)
+				throw new ArgumentNullException ("encoding");
 			if (!input.CanRead)
-				throw new ArgumentException(Locale.GetText ("The stream doesn't support reading."));
+				throw new ArgumentException ("The stream doesn't support reading.");
+ 
+			_stream = input;
+			_encoding = encoding;
 
-			m_stream = input;
-			m_encoding = encoding;
-			m_encoding_max_byte = m_encoding.GetMaxByteCount(1);
-			m_buffer = new byte [32];
+			int size = encoding.GetMaxByteCount (1);
+			if (size < 16) size = 16;
+			_buffer = new byte [size];
 		}
-
-		public virtual Stream BaseStream {
-			get {
-				return m_stream;
-			}
-		}
-
-		public virtual void Close() {
-			Dispose (true);
-			m_disposed = true;
-		}
-		
 		protected virtual void Dispose (bool disposing)
 		{
-			if (disposing && m_stream != null)
-				m_stream.Close ();
+			if (disposing && _stream != null)
+				_stream.Close ();
 
-			m_disposed = true;
-			m_buffer = null;
-			m_encoding = null;
-			m_stream = null;
+			_disposed = true;
+			_encoding = null;
+			_stream = null;
 		}
-
-		void IDisposable.Dispose() 
+		void IDisposable.Dispose()
 		{
 			Dispose (true);
 		}
+		#endregion
 
+		#region PublicInstanceProperty
+		public virtual Stream BaseStream {
+			get { return _stream; }
+		}
+		#endregion
+
+		#region Protected Instance Method
 		protected virtual void FillBuffer (int bytes)
 		{
-			if (m_disposed)
+			if (_disposed)
 				throw new ObjectDisposedException ("BinaryReader", "Cannot read from a closed BinaryReader.");
-			if (m_stream==null)
-				throw new IOException("Stream is invalid");
-			
-			CheckBuffer(bytes);
+			if (_stream == null)
+				throw new IOException ("Stream is invalid");
+			if (_buffer.Length < bytes)
+				throw new ArgumentException ("Value is too big.", "bytes");
 
-			/* Cope with partial reads */
-			int pos=0;
-
-			while(pos<bytes) {
-				int n=m_stream.Read(m_buffer, pos, bytes-pos);
-				if(n==0) {
-					throw new EndOfStreamException();
-				}
-
-				pos+=n;
+			int pos = 0;
+			while (pos < bytes) {
+				int ret = _stream.Read (_buffer, pos, bytes - pos);
+				if (ret == 0)
+					throw new EndOfStreamException ();
+				pos += ret;
 			}
 		}
 
-		public virtual int PeekChar() {
-			if(m_stream==null) {
-				
-				if (m_disposed)
-					throw new ObjectDisposedException ("BinaryReader", "Cannot read from a closed BinaryReader.");
+		protected int Read7BitEncodedInt ()
+		{
+			int ret = 0;
+			int shift = 0;
+			byte b;
 
-				throw new IOException("Stream is invalid");
-			}
+			do {
+				b = ReadByte();
+				ret = ret | ((b & 0x7f) << shift);
+				shift += 7;
+			} while ((b & 0x80) == 0x80);
 
-			if ( !m_stream.CanSeek )
-			{
-				return -1;
-			}
+			return ret;
+		}
+		#endregion // Protected Instance Method
 
-			char[] result = new char[1];
-			byte[] bytes;
-			int bcount;
+		#region Public Instance Method
+		public void Close ()
+		{
+			Dispose (true);
+		}
 
-			int ccount = ReadCharBytes (result, 0, 1, out bytes, out bcount);
+		public virtual int PeekChar ()
+		{
+			if (_disposed)
+				throw new ObjectDisposedException ("BinaryReader", "Cannot read from a closed BinaryReader.");
+			if (_stream == null)
+				throw new IOException ("Stream is invalid");
+			if (!_stream.CanSeek)
+				return -1;
 
-			// Reposition the stream
-			m_stream.Position -= bcount;
+			long pos = _stream.Position;
+			int c = InternalReadChar ();
+			_stream.Position = pos;
 
-			// If we read 0 characters then return -1
-			if (ccount == 0) 
-			{
-				return -1;
-			}
-			
-			// Return the single character we read
-			return result[0];
+			return c;
 		}
 
-		public virtual int Read() {
-			char[] decode = new char[1];
+		public virtual int Read ()
+		{
+			if (_disposed)
+				throw new ObjectDisposedException ("BinaryReader", "Cannot read from a closed BinaryReader.");
+			if (_stream == null)
+				throw new IOException ("Stream is invalid");
 
-			int count=Read(decode, 0, 1);
-			if(count==0) {
-				/* No chars available */
-				return(-1);
-			}
-			
-			return decode[0];
+			return InternalReadChar ();
 		}
 
-		public virtual int Read(byte[] buffer, int index, int count) {
-			if(m_stream==null) {
+		public virtual int Read (byte[] buffer, int index, int count)
+		{
+			if (_disposed)
+				throw new ObjectDisposedException ("BinaryReader", "Cannot read from a closed BinaryReader.");
+			if (_stream==null)
+				throw new IOException ("Stream is invalid");
 
-				if (m_disposed)
-					throw new ObjectDisposedException ("BinaryReader", "Cannot read from a closed BinaryReader.");
-
-				throw new IOException("Stream is invalid");
-			}
-			
-			if (buffer == null) {
-				throw new ArgumentNullException("buffer is null");
-			}
-			if (index < 0) {
-				throw new ArgumentOutOfRangeException("index is less than 0");
-			}
-			if (count < 0) {
-				throw new ArgumentOutOfRangeException("count is less than 0");
-			}
-			if (buffer.Length - index < count) {
+			if (buffer == null)
+				throw new ArgumentNullException ("buffer");
+			if (index < 0)
+				throw new ArgumentOutOfRangeException ("index");
+			if (count < 0)
+				throw new ArgumentOutOfRangeException ("count");
+			if (buffer.Length - index < count)
 				throw new ArgumentException("buffer is too small");
-			}
 
-			int bytes_read=m_stream.Read(buffer, index, count);
-
-			return(bytes_read);
+			return _stream.Read (buffer, index, count);
 		}
 
-		public virtual int Read(char[] buffer, int index, int count) {
+		public virtual int Read (char[] buffer, int index, int count)
+		{
+			if (_disposed)
+				throw new ObjectDisposedException ("BinaryReader", "Cannot read from a closed BinaryReader.");
+			if (_stream==null)
+				throw new IOException ("Stream is invalid");
 
-			if(m_stream==null) {
+			if (buffer == null)
+				throw new ArgumentNullException ("buffer");
+			if (index < 0)
+				throw new ArgumentOutOfRangeException ("index");
+			if (count < 0)
+				throw new ArgumentOutOfRangeException ("count");
+			if (buffer.Length - index < count)
+				throw new ArgumentException("buffer is too small");
 
-				if (m_disposed)
-					throw new ObjectDisposedException ("BinaryReader", "Cannot read from a closed BinaryReader.");
-
-				throw new IOException("Stream is invalid");
+			int length = 0;
+			bool eos = false;
+			for (int i = index; i < index + count; i++) {
+				int c = InternalReadChar (ref eos);
+				if (eos)
+					break;
+				buffer [i] = (char)c;
+				length++;
 			}
-			
-			if (buffer == null) {
-				throw new ArgumentNullException("buffer is null");
-			}
-			if (index < 0) {
-				throw new ArgumentOutOfRangeException("index is less than 0");
-			}
-			if (count < 0) {
-				throw new ArgumentOutOfRangeException("count is less than 0");
-			}
-			if (buffer.Length - index < count) {
-				throw new ArgumentException("buffer is too small");
-			}
 
-			int bytes_read;
-			byte[] bytes;
-			return ReadCharBytes (buffer, index, count, out bytes, out bytes_read);
+			return length;
 		}
 
-		private int ReadCharBytes(char[] buffer, int index, int count, out byte[] bytes, out int bytes_read) 
+		public virtual bool ReadBoolean ()
 		{
-			int chars_read=0;
-			bytes_read=0;
-			
-			while(chars_read < count) 
-			{
-				CheckBuffer(bytes_read + 1);
-
-				int read_byte = m_stream.ReadByte();
-
-				if(read_byte==-1) 
-				{
-					/* EOF */
-					bytes = m_buffer;
-					return(chars_read);
-				}
-
-				m_buffer[bytes_read]=(byte)read_byte;
-				bytes_read++;
-
-				chars_read=m_encoding.GetChars(m_buffer, 0,
-										 bytes_read,
-										 buffer, index);
-				
-			}
-
-			bytes = m_buffer;
-			return(chars_read);
+			return ReadByte () != 0;
 		}
 
-		protected int Read7BitEncodedInt() {
-			int ret = 0;
-			int shift = 0;
-			byte b;
+		public virtual byte ReadByte ()
+		{
+			if (_disposed)
+				throw new ObjectDisposedException ("BinaryReader", "Cannot read from a closed BinaryReader.");
+			if (_stream == null)
+				throw new IOException ("Stream is invalid");
 
-			do {
-				b = ReadByte();
-				
-				ret = ret | ((b & 0x7f) << shift);
-				shift += 7;
-			} while ((b & 0x80) == 0x80);
+			int ret = _stream.ReadByte();
+			if (ret != -1)
+				return (byte)ret;
 
-			return ret;
+			throw new EndOfStreamException();
 		}
 
-		public virtual bool ReadBoolean() {
-			// Return value:
-			//  true if the byte is non-zero; otherwise false.
-			return ReadByte() != 0;
-		}
-
-		public virtual byte ReadByte() {
-			if (m_stream == null) {
-				if (m_disposed)
-					throw new ObjectDisposedException ("BinaryReader", "Cannot read from a closed BinaryReader.");
-
+		public virtual byte[] ReadBytes (int count)
+		{
+			if (_disposed)
+				throw new ObjectDisposedException ("BinaryReader", "Cannot read from a closed BinaryReader.");
+			if (_stream == null)
 				throw new IOException ("Stream is invalid");
-			}
-			
-			int val = m_stream.ReadByte ();
-			if (val != -1)
-				return (byte) val;
-			
-			throw new EndOfStreamException ();
-		}
+			if (count < 0)
+				throw new ArgumentOutOfRangeException ("count");
 
-		public virtual byte[] ReadBytes(int count) {
-			if(m_stream==null) {
+			byte[] buffer = new byte[count];
+			int size = _stream.Read (buffer, 0, count);
 
-				if (m_disposed)
-					throw new ObjectDisposedException ("BinaryReader", "Cannot read from a closed BinaryReader.");
+			if (size == count)
+				return buffer;
 
-				throw new IOException("Stream is invalid");
-			}
-			
-			if (count < 0) {
-				throw new ArgumentOutOfRangeException("count is less than 0");
-			}
-
-			/* Can't use FillBuffer() here, because it's OK to
-			 * return fewer bytes than were requested
-			 */
-
-			byte[] buf = new byte[count];
-			int pos=0;
-			
-			while(pos < count) 
-			{
-				int n=m_stream.Read(buf, pos, count-pos);
-				if(n==0) {
-					/* EOF */
-					break;
-				}
-
-				pos+=n;
-			}
-				
-			if (pos!=count) {
-				byte[] new_buffer=new byte[pos];
-				Array.Copy(buf, new_buffer, pos);
-				return(new_buffer);
-			}
-			
-			return(buf);
+			byte[] buffer2 = new byte[size];
+			Array.Copy (buffer, 0, buffer2, 0, size);
+			return buffer2;
 		}
 
-		public virtual char ReadChar() {
-			int ch=Read();
+		public virtual char ReadChar ()
+		{
+			if (_disposed)
+				throw new ObjectDisposedException ("BinaryReader", "Cannot read from a closed BinaryReader.");
+			if (_stream == null)
+				throw new IOException ("Stream is invalid");
 
-			if(ch==-1) {
+			bool eos = false;
+			char ret = (char)InternalReadChar (ref eos);
+			if(eos)
 				throw new EndOfStreamException();
-			}
 
-			return((char)ch);
+			return ret;
 		}
 
-		public virtual char[] ReadChars(int count) {
-			if (count < 0) {
-				throw new ArgumentOutOfRangeException("count is less than 0");
-			}
+		public virtual char[] ReadChars (int count)
+		{
+			if (count < 0)
+				throw new ArgumentOutOfRangeException ("count");
 
-			char[] full = new char[count];
-			int chars = Read(full, 0, count);
-			
+			char[] buffer = new char[count];
+			int chars = Read (buffer, 0, count);
+
 			if (chars == 0) {
 				throw new EndOfStreamException();
-			} else if (chars != full.Length) {
-				char[] ret = new char[chars];
-				Array.Copy(full, 0, ret, 0, chars);
-				return ret;
-			} else {
-				return full;
+			} else if (chars == count) {
+				return buffer;
 			}
+
+			char[] buffer2 = new char[chars];
+			Array.Copy (buffer, 0, buffer2, 0, chars);
+
+			return buffer2;
 		}
 
-		unsafe public virtual decimal ReadDecimal() {
-			FillBuffer(16);
+		unsafe public virtual decimal ReadDecimal()
+		{
+			FillBuffer (16);
 
 			decimal ret;
 			byte* ret_ptr = (byte *)&ret;
@@ -358,130 +293,155 @@
 				 * So we have to rerange this int32 values
 				 */			  
 			  
-			        if (i < 4) {
-				        // lo 8 - 12			  
-				        ret_ptr [i + 8] = m_buffer [i];
+				if (i < 4) {
+					// lo 8 - 12			  
+					ret_ptr [i + 8] = _buffer [i];
 				} else if (i < 8) {
-				        // mid 12 - 16
-				        ret_ptr [i + 8] = m_buffer [i];
+					// mid 12 - 16
+					ret_ptr [i + 8] = _buffer [i];
 				} else if (i < 12) {
-				        // hi 4 - 8
-				        ret_ptr [i - 4] = m_buffer [i];
+					// hi 4 - 8
+					ret_ptr [i - 4] = _buffer [i];
 				} else if (i < 16) {
-				        // ss 0 - 4
-				        ret_ptr [i - 12] = m_buffer [i];
-				}				
+					// ss 0 - 4
+					ret_ptr [i - 12] = _buffer [i];
+				}
 			}
 
 			return ret;
 		}
 
-		public virtual double ReadDouble() {
-			FillBuffer(8);
-
-			return(BitConverter.ToDouble(m_buffer, 0));
+		public virtual double ReadDouble()
+		{
+			FillBuffer (8);
+			return BitConverter.ToDouble (_buffer, 0);
 		}
 
-		public virtual short ReadInt16() {
-			FillBuffer(2);
-
-			return((short) (m_buffer[0] | (m_buffer[1] << 8)));
+		public virtual short ReadInt16()
+		{
+			FillBuffer (2);
+			return (short)(_buffer[0] | (_buffer[1] << 8));
 		}
 
-		public virtual int ReadInt32() {
-			FillBuffer(4);
-
-			return(m_buffer[0] | (m_buffer[1] << 8) |
-			       (m_buffer[2] << 16) | (m_buffer[3] << 24));
+		public virtual int ReadInt32()
+		{
+			FillBuffer (4);
+			return _buffer[0] | (_buffer[1] << 8) | (_buffer[2] << 16) | (_buffer[3] << 24);
 		}
 
-		public virtual long ReadInt64() {
-			FillBuffer(8);
-
-			uint ret_low  = (uint) (m_buffer[0]            |
-			                       (m_buffer[1] << 8)  |
-			                       (m_buffer[2] << 16) |
-			                       (m_buffer[3] << 24)
-			                       );
-			uint ret_high = (uint) (m_buffer[4]        |
-			                       (m_buffer[5] << 8)  |
-			                       (m_buffer[6] << 16) |
-			                       (m_buffer[7] << 24)
-			                       );
-			return (long) ((((ulong) ret_high) << 32) | ret_low);
+		public virtual long ReadInt64()
+		{
+			FillBuffer (8);
+			uint ret_low  = (uint) (_buffer[0]        |
+			                       (_buffer[1] << 8)  |
+			                       (_buffer[2] << 16) |
+			                       (_buffer[3] << 24));
+			uint ret_high = (uint) (_buffer[4]        |
+			                       (_buffer[5] << 8)  |
+			                       (_buffer[6] << 16) |
+			                       (_buffer[7] << 24));
+			return (long)((((ulong) ret_high) << 32) | ret_low);
 		}
 
 		[CLSCompliant(false)]
-		public virtual sbyte ReadSByte() {
+		public virtual sbyte ReadSByte()
+		{
 			return (sbyte) ReadByte ();
 		}
 
-		public virtual string ReadString() {
+		public virtual string ReadString()
+		{
 			/* Inspection of BinaryWriter-written files
 			 * shows that the length is given in bytes,
 			 * not chars
 			 */
-			int len = Read7BitEncodedInt();
+			int len = Read7BitEncodedInt ();
 
-			FillBuffer(len);
-			
-			char[] str = m_encoding.GetChars(m_buffer, 0, len);
+			Decoder decoder = _encoding.GetDecoder ();
+			char[] chars = new char [len];
+			int length = 0;
+			int pos = 0;
+			if (_rsbuffer == null)
+				_rsbuffer = new byte [1024];
 
-			return(new String(str));
-		}
+			while (pos < len) {
+				int ret = _stream.Read (_rsbuffer, 0, (1024 <= len - pos ? 1024 : len - pos));
+				if (ret <= 0)
+					break;
+				pos += ret;
 
-		public virtual float ReadSingle() {
-			FillBuffer(4);
+				length += decoder.GetChars (_rsbuffer, 0, ret, chars, length);
+			}
 
-			return(BitConverter.ToSingle(m_buffer, 0));
+			return new string(chars, 0, length);
 		}
 
-		[CLSCompliant(false)]
-		public virtual ushort ReadUInt16() {
-			FillBuffer(2);
-
-			return((ushort) (m_buffer[0] | (m_buffer[1] << 8)));
+		public virtual float ReadSingle()
+		{
+			FillBuffer (4);
+			return BitConverter.ToSingle (_buffer, 0);
 		}
 
 		[CLSCompliant(false)]
-		public virtual uint ReadUInt32() {
-			FillBuffer(4);
-				
-
-			return((uint) (m_buffer[0] |
-				       (m_buffer[1] << 8) |
-				       (m_buffer[2] << 16) |
-				       (m_buffer[3] << 24)));
+		public virtual ushort ReadUInt16()
+		{
+			FillBuffer (2);
+			return (ushort)(_buffer[0] | (_buffer[1] << 8));
 		}
 
 		[CLSCompliant(false)]
-		public virtual ulong ReadUInt64() {
-			FillBuffer(8);
+		public virtual uint ReadUInt32()
+		{
+			FillBuffer (4);
+			return (uint)(_buffer[0] | (_buffer[1] << 8) | (_buffer[2] << 16) | (_buffer[3] << 24));
+		}
 
-			uint ret_low  = (uint) (m_buffer[0]            |
-			                       (m_buffer[1] << 8)  |
-			                       (m_buffer[2] << 16) |
-			                       (m_buffer[3] << 24)
-			                       );
-			uint ret_high = (uint) (m_buffer[4]        |
-			                       (m_buffer[5] << 8)  |
-			                       (m_buffer[6] << 16) |
-			                       (m_buffer[7] << 24)
-			                       );
+		[CLSCompliant(false)]
+		public virtual ulong ReadUInt64()
+		{
+			FillBuffer (8);
+			uint ret_low  = (uint) (_buffer[0]        |
+			                       (_buffer[1] << 8)  |
+			                       (_buffer[2] << 16) |
+			                       (_buffer[3] << 24));
+			uint ret_high = (uint) (_buffer[4]        |
+			                       (_buffer[5] << 8)  |
+			                       (_buffer[6] << 16) |
+			                       (_buffer[7] << 24));
 			return (((ulong) ret_high) << 32) | ret_low;
 		}
+		#endregion // Public Instance Method
 
-		/* Ensures that m_buffer is at least length bytes
-		 * long, growing it if necessary
-		 */
-		private void CheckBuffer(int length)
+		#region Private Instance Method
+		private int InternalReadChar()
 		{
-			if(m_buffer.Length <= length) {
-				byte[] new_buffer=new byte[length];
-				Array.Copy(m_buffer, new_buffer,
-					   m_buffer.Length);
-				m_buffer=new_buffer;
+			bool eos = false;
+			return InternalReadChar (ref eos);
+		}
+		private int InternalReadChar(ref bool eos)
+		{
+			if (_disposed)
+				throw new ObjectDisposedException ("BinaryReader", "Cannot read from a closed BinaryReader.");
+			if (_stream==null)
+				throw new IOException ("Stream is invalid");
+
+			eos = false;
+			int pos = 0;
+			int count = 0;
+			char[] temp = new char[1];
+			while (count == 0) {
+				int val = _stream.ReadByte ();
+				if (val < 0) {
+					eos = true;
+					return -1;
+				}
+				_buffer[pos++] = (byte)val;
+				count = _encoding.GetChars (_buffer, 0, pos, temp, 0);
 			}
+
+			return temp[0];
 		}
+		#endregion
 	}
 }
+
Index: ChangeLog
===================================================================
--- ChangeLog	(revision 38220)
+++ ChangeLog	(working copy)
@@ -1,3 +1,8 @@
+2005-01-02  Kazuki Oikawa
+
+	* BinaryReader.cs : Improved reading performance. More precise
+	  error check. Code reformatting.
+
 2004-12-21 Gonzalo Paniagua Javier <gonzalo@ximian.com>
 
 	* BufferedStream.cs: use Buffer.BlockCopyInternal instead of Array.Copy.