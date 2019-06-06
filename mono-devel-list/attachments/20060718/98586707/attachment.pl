//------------------------------------------------------------------------------
//
// System.IO.UnmanagedMemoryStream.cs
//
// Copyright (C) 2006 Sridhar Kulkarni, All Rights Reserved
//
// Author:         Sridhar Kulkarni (sridharkulkarni@gmail.com)
// Created:        Monday, July 10, 2006
//
//------------------------------------------------------------------------------

//
// Copyright (C) 2005-2006 Novell, Inc (http://www.novell.com)
//
// Permission is hereby granted, free of charge, to any person obtaining
// a copy of this software and associated documentation files (the
// "Software"), to deal in the Software without restriction, including
// without limitation the rights to use, copy, modify, merge, publish,
// distribute, sublicense, and/or sell copies of the Software, and to
// permit persons to whom the Software is furnished to do so, subject to
// the following conditions:
//
// The above copyright notice and this permission notice shall be
// included in all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
// LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
// OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
// WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#if NET_2_0

using System;
using System.IO;
using System.Runtime.InteropServices;


namespace System.IO
{
    [CLSCompliantAttribute(false)]
    public class UnmanagedMemoryStream : Stream{

        private bool canwrite;
        private bool canread;
        private int length;
        private bool closed;
        private bool canseek = false;
        private long capacity;
        private FileAccess fileaccess;
        private byte* initial_pointer;
        private byte* current_pointer;
        private bool initial_position;
        private long current_position;

        #region Constructor
        protected UnmanagedMemoryStream() {
                fileaccess = FileAccess.Read;
                initial_position = 0;
                canseek = true;
                closed = false;
                current_position = initial_position;
        }
        public unsafe UnmanagedMemoryStream (byte* pointer, long len){

            if (pointer == null)
                throw new ArgumentNullException("The pointer value is a null 
reference ");
            if (len < 0)
                throw new ArgumentOutOfRangeException("The length value is 
less than zero");
                fileaccess = FileAccess.Read;
                length = len;
                capacity = len;
                initial_position = 0;
                current_position = initial_position;
                canseek = true;
                closed = false;
                initial_pointer = pointer;
                current_pointer = initial_pointer;
        }
        public unsafe UnmanagedMemoryStream (byte* pointer, long len,
                                    long cap,	FileAccess access){
            if (pointer == null)
                throw new ArgumentNullException("The pointer value is a null 
reference");
            if (len < 0)
                throw new ArgumentOutOfRangeException("The length value is 
less than zero");
            if (capacity < 0)
                throw new ArgumentOutOfRangeException("The capacity value is 
less than zero");
            if (len > capacity)
                throw new ArgumentOutOfRangeException("The length value is 
greater than the capacity value");
            fileaccess = access;
            length = len;
            capacity = cap;
            initial_position = 0;
            current_position = initial_position;
            canseek = true;
            initial_pointer = pointer;
            current_pointer = initial_pointer;
            closed = false;
            fileaccess = access;
        }
        #endregion

        #region Properties
        public override bool CanRead {
            get{
                if(closed)
                    return false;
                else
                    return((fileaccess == FileAccess.Read || fileaccess == 
FileAccess.ReadWrite)? true:false);
            }
        }
        public override bool CanSeek {
            get{
                return ((closed) ? false : true);
            }
        }

        public override bool CanWrite {
            get{
                if (closed)
                    return (false);
                else
                    return( (fileaccess == FileAccess.Write || fileaccess == 
FileAccess.ReadWrite)? true:false);
            }
        }
        public long Capacity {
            get{
                if (closed)
                    throw new ObjectDisposedException("The stream is 
closed");
                else
                    return (capacity);
            }
        }
        public override long Length {
            get{
                if (closed)
                    throw new ObjectDisposedException("The stream is 
closed");
                else
                    return (length);
            }
        }
        public override long Position {
            get{
                if (closed)
                    throw new ObjectDisposedException("The stream is 
closed");
                else
                    return (current_position);
            }
            set{
                if (closed)
                    throw new ObjectDisposedException("The stream is 
closed");
                if (value < 0 || value > (long)Int32.MaxValue || value > 
capacity)
                    throw new ArgumentOutOfRangeException("value that is 
less than zero, or the position is larger than Int32.MaxValue or capacity of 
the stream");
                else
                    current_position = value;
            }
        }

        public unsafe byte* PositionPointer {
            get{
                return(current_pointer);
            }
            set{
                if (value > capacity)
                    throw new IndexOutOfRangeException("The current position 
is larger than the capacity of the stream");
                if (value <0 && value > capacity)
                    throw new ArgumentOutOfRangeException("The position is 
being set is not a valid position in the current stream");
                if (value < 0)
                    throw new IOException("The position is being set is not 
a valid position in the current stream");
                current_pointer += value;
            }
        }
        #endregion

        #region Methods
        public override int Read ([InAttribute] [OutAttribute] byte[] 
buffer,
                        int offset,	int count){

            if (closed)
                throw new ObjectDisposedException("The stream is closed");

            if (!canread)
                throw new NotSupportedException("Read property is false");
            if (buffer == null)
                throw new ArgumentNullException("The buffer parameter is set 
to a null reference");
            if (offset < 0 || count < 0)
                throw new ArgumentOutOfRangeException("The offset or count 
parameter is less than zero");
            if ((buffer.Length - offset) < count)
                throw new ArgumentException("The length of the buffer array 
minus the offset parameter is less than the count parameter");
            if (current_position == capacity)
                return (0);
            Marshal.Copy(initial_pointer, buffer, offset, length);
            current_position += length;
            current_pointer += length;
            return (buffer.GetLength(0));
        }
        public override int ReadByte (){
            if (closed)
                throw new ObjectDisposedException("The stream is closed");
            if (current_position == capacity)
                throw new NotSupportedException("The current position is at 
the end of the stream");
            if (!canread)
                throw new NotSupportedException("The underlying memory does 
not support reading");
            int byteread;
            int templength = 0;
            if (templength == length)
                return (-1);
            else{
                byteread = (int)Marshal.ReadByte(bytepointer);
                current_position++;
                current_pointer++;
                templength++;
                return(byteread);
            }
        }
        public override long Seek (long offset,	SeekOrigin loc){
            if (closed)
                throw new ObjectDisposedException("The stream is closed");
            if (offset > capacity)
                throw new ArgumentOutOfRangeException("The offset value is 
larger than the maximum size of the stream");
            int refpoint;
            switch(loc){
                case SeekOrigin.Begin:
                    if (offset < 0)
                        throw new IOException("An attempt was made to seek 
before the beginning of the stream");
                    refpoint = initial_position;
                    break;
                case SeekOrigin.Current:
                    refpoint = current_position;
                    break;
                case SeekOrigin.End:
                    refpoint = length;
                    break;
                default:
                    throw new ArgumentException("Invalid SeekOrigin 
option");
                    break;
            }
            refpoint =+ (int)offset;
            if (refpoint < initial_position)
                throw new IOException("An attempt was made to seek before 
the beginning of the stream");
            current_position = refpoint;
            return(current_position);
        }
        public override void SetLength (long value){
            if (closed)
                throw new ObjectDisposedException("The stream is closed");
            if (value < 0 || value > capacity)
                throw new ArgumentOutOfRangeException("The specified value 
is negetive exceeds the capacity of the stream");
            if (!canwrite)
                throw new NotSupportedException("write property is set to 
false");
            length = value;
        }
        public override void Flush (){
            if (closed)
                throw new ObjectDisposedException("The stream is closed");
            //This method performs no action for this class
            //but is included as part of the Stream base class
        }
        public void Dispose (){
            Dispose(true);
        }
        protected override void Dispose (bool disposing){
            bytepointer = null;
            current_position = null;
            initial_position = null;
            closed = true;
        }
        public override void Write (byte[] buffer, int offset, int count){
            if (closed)
                throw new ObjectDisposedException("The stream is closed");
            if (buffer == null)
                throw new ArgumentNullException("The buffer parameter is a 
null reference");
            if (count > capacity)
                throw new ArgumentOutOfRangeException("The count value is 
greater than the capacity of the stream");
            if (!canwrite)
                throw new NotSupportedException("write property is set to 
false");
            if (offset < 0 || count < 0)
                throw new ArgumentOutOfRangeException("One of the specified 
parameters is less than zero");
            if ((buffer.Length - offset) < count)
                throw new ArgumentException("The length of the buffer array 
minus the offset parameter is less than the count parameter");

            //COPY data from managed buffer to unmanaged mem pointer
            Marshal.Copy(buffer, offset, bytepointer, length);
            current_position += length;
            current_pointer += length;
        }
        public override void WriteByte (byte value){
            if (closed)
                throw new ObjectDisposedException("The stream is closed");
            if (!canwrite)
                throw new NotSupportedException("write property is set to 
false");
            if (current_position == capacity)
                throw new NotSupportedException("The current position is at 
the end of the capacity of the stream");
            Marshal.WriteByte(bytepointer, value);
            current_position++;
            current_pointer++;
        }
        #endregion
    }
}
#endif
