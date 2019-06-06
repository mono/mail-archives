// System.Drawing.ComIStreamWrapper
// Copyright © 2005 Kornél Pál
// http://www.kornelpal.hu/

using System;
using System.IO;
using System.Reflection;
using System.Runtime.InteropServices;

namespace System.Drawing
{
	// Stream to IStream wrapper for COM interop
	internal sealed class ComIStreamWrapper : UCOMIStream
	{
		private const int STG_E_INVALIDFUNCTION = unchecked((int)0x80030001);

		private readonly Stream baseStream;
		private long position = -1;

		internal ComIStreamWrapper(Stream stream)
		{
			baseStream = stream;
		}

		private void SetSizeToPosition()
		{
			if (position != -1)
			{
				if (position > baseStream.Length)
					baseStream.SetLength(position);
				baseStream.Position = position;
				position = -1;
			}
		}

		public void Read(byte[] pv, int cb, IntPtr pcbRead)
		{
			int read = 0;

			if (cb != 0)
			{
				SetSizeToPosition();

				read = baseStream.Read(pv, 0, cb);
			}

			if (pcbRead != IntPtr.Zero)
				Marshal.WriteInt32(pcbRead, read);
		}
		
		public void Write(byte[] pv, int cb, IntPtr pcbWritten)
		{
			if (cb != 0)
			{
				SetSizeToPosition();

				baseStream.Write(pv, 0, cb);
			}

			if (pcbWritten != IntPtr.Zero)
				Marshal.WriteInt32(pcbWritten, cb);
		}
		
		public void Seek(long dlibMove, int dwOrigin, IntPtr plibNewPosition)
		{
			long newPosition = -1;

			if (baseStream.CanWrite)
			{
				long length = baseStream.Length;
				long curPos;

				if ((curPos = position) == -1)
					curPos = baseStream.Position;

				switch ((SeekOrigin)dwOrigin)
				{
					case SeekOrigin.Begin:
						if (dlibMove > length)
							newPosition = dlibMove;
						break;
					case SeekOrigin.Current:
						if (curPos + dlibMove > length)
							newPosition = curPos + dlibMove;
						break;
					case SeekOrigin.End:
						if (dlibMove > 0)
							newPosition = length + dlibMove;
						break;
				}
			}

			if (newPosition == -1)
			{
				newPosition = baseStream.Seek(dlibMove, (SeekOrigin)dwOrigin);
				position = -1;
			}
			else
				position = newPosition;

			if (plibNewPosition != IntPtr.Zero)
				Marshal.WriteInt64(plibNewPosition, newPosition);
		}
		
		public void SetSize(long libNewSize)
		{
			baseStream.SetLength(libNewSize);
		}
		
		public void CopyTo(UCOMIStream pstm, long cb, IntPtr pcbRead, IntPtr pcbWritten)
		{
			byte[] buffer = new byte[4096];
			long written = 0;
			int read;

			if (cb != 0)
			{
				SetSizeToPosition();
				do
				{
					int count = 4096;

					if (written + 4096 > cb)
						count = (int)(cb - written);

					if ((read = baseStream.Read(buffer, 0, count)) == 0)
						break;
					pstm.Write(buffer, read, IntPtr.Zero);
					written += read;
				} while (written < cb);
			}

			if (pcbRead != IntPtr.Zero)
				Marshal.WriteInt64(pcbRead, written);
			if (pcbWritten != IntPtr.Zero)
				Marshal.WriteInt64(pcbWritten, written);
		}
		
		public void Commit(int grfCommitFlags)
		{
			baseStream.Flush();
		}
		
		public void Revert()
		{
			throw new ExternalException(null, STG_E_INVALIDFUNCTION);
		}
		
		public void LockRegion(long libOffset, long cb, int dwLockType)
		{
			throw new ExternalException(null, STG_E_INVALIDFUNCTION);
		}
		
		public void UnlockRegion(long libOffset, long cb, int dwLockType)
		{
			throw new ExternalException(null, STG_E_INVALIDFUNCTION);
		}
		
		public void Stat(out STATSTG pstatstg, int grfStatFlag)
		{
			pstatstg = new STATSTG();
			pstatstg.cbSize = baseStream.Length;
		}
		
		public void Clone(out UCOMIStream ppstm)
		{
			ppstm = null;
			throw new ExternalException(null, STG_E_INVALIDFUNCTION);
		}

	}
}