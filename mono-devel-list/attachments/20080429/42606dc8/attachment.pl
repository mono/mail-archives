using System;
using System.Text;
using System.Security.Cryptography;

namespace Test
{
    class MainClass
    {
        static byte[] buffer = new byte[1024 * 1024 * 250];
        static void Main(string[] args)
        {
            for (int i = 0; i < 3; i++)
            {
                Hash(new SHA1Svn(), "SVN     ");
                Hash(new Enhanced(), "Enhanced");
            }
        }

        private static void Hash(SHA1 hasher, string s)
        {
            long start = Environment.TickCount;
            byte[] hash = hasher.ComputeHash(buffer, 0, buffer.Length);
            start = Environment.TickCount - start;
            Console.WriteLine("{2}: {1}ms     {0}", BitConverter.ToString(hash), start, s);
        }
    }

    internal class Enhanced : System.Security.Cryptography.SHA1
    {

        private const int BLOCK_SIZE_BYTES = 64;
        private const int HASH_SIZE_BYTES = 20;
        private uint[] _H;  // these are my chaining variables
        private ulong count;
        private byte[] _ProcessingBuffer;   // Used to start data when passed less than a block worth.
        private int _ProcessingBufferCount; // Counts how much data we have stored that still needs processed.
        private uint[] buff;

        public Enhanced()
        {
            _H = new uint[5];
            _ProcessingBuffer = new byte[BLOCK_SIZE_BYTES];
            buff = new uint[80];

            Initialize();
        }

        protected override void HashCore(byte[] rgb, int start, int size)
        {
            int i;

            if (_ProcessingBufferCount != 0)
            {
                if (size < (BLOCK_SIZE_BYTES - _ProcessingBufferCount))
                {
                    System.Buffer.BlockCopy(rgb, start, _ProcessingBuffer, _ProcessingBufferCount, size);
                    _ProcessingBufferCount += size;
                    return;
                }
                else
                {
                    i = (BLOCK_SIZE_BYTES - _ProcessingBufferCount);
                    System.Buffer.BlockCopy(rgb, start, _ProcessingBuffer, _ProcessingBufferCount, i);
                    ProcessBlock(_ProcessingBuffer, 0);
                    _ProcessingBufferCount = 0;
                    start += i;
                    size -= i;
                }
            }

            for (i = 0; i < size - size % BLOCK_SIZE_BYTES; i += BLOCK_SIZE_BYTES)
            {
                ProcessBlock(rgb, (uint)(start + i));
            }

            if (size % BLOCK_SIZE_BYTES != 0)
            {
                System.Buffer.BlockCopy(rgb, size - size % BLOCK_SIZE_BYTES + start, _ProcessingBuffer, 0, size % BLOCK_SIZE_BYTES);
                _ProcessingBufferCount = size % BLOCK_SIZE_BYTES;
            }
        }

        protected override byte[] HashFinal()
        {
            byte[] hash = new byte[20];

            ProcessFinalBlock(_ProcessingBuffer, 0, _ProcessingBufferCount);

            for (int i = 0; i < 5; i++)
            {
                for (int j = 0; j < 4; j++)
                {
                    hash[i * 4 + j] = (byte)(_H[i] >> (8 * (3 - j)));
                }
            }

            return hash;
        }

        public override void Initialize()
        {
            count = 0;
            _ProcessingBufferCount = 0;

            _H[0] = 0x67452301;
            _H[1] = 0xefcdab89;
            _H[2] = 0x98badcfe;
            _H[3] = 0x10325476;
            _H[4] = 0xC3D2E1F0;
        }

        private void ProcessBlock(byte[] inputBuffer, uint inputOffset)
        {
            uint a, b, c, d, e;

            count += BLOCK_SIZE_BYTES;

            // abc removal would not work on the fields
            uint[] _H = this._H;
            uint[] buff = this.buff;
            InitialiseBuff(buff, inputBuffer, inputOffset);
            FillBuff(buff);

            a = _H[0];
            b = _H[1];
            c = _H[2];
            d = _H[3];
            e = _H[4];

            // This function was unrolled because it seems to be doubling our performance with current compiler/VM.
            // Possibly roll up if this changes.

            // ---- Round 1 --------
            int i = 0;
            while (i < 20)
            {
                e += ((a << 5) | (a >> 27)) + (((c ^ d) & b) ^ d) + 0x5A827999 + buff[i];
                b = (b << 30) | (b >> 2);

                d += ((e << 5) | (e >> 27)) + (((b ^ c) & a) ^ c) + 0x5A827999 + buff[i + 1];
                a = (a << 30) | (a >> 2);

                c += ((d << 5) | (d >> 27)) + (((a ^ b) & e) ^ b) + 0x5A827999 + buff[i + 2];
                e = (e << 30) | (e >> 2);

                b += ((c << 5) | (c >> 27)) + (((e ^ a) & d) ^ a) + 0x5A827999 + buff[i + 3];
                d = (d << 30) | (d >> 2);

                a += ((b << 5) | (b >> 27)) + (((d ^ e) & c) ^ e) + 0x5A827999 + buff[i + 4];
                c = (c << 30) | (c >> 2);
                i += 5;
            }

            // ---- Round 2 --------
            while (i < 40)
            {
                e += ((a << 5) | (a >> 27)) + (b ^ c ^ d) + 0x6ED9EBA1 + buff[i];
                b = (b << 30) | (b >> 2);

                d += ((e << 5) | (e >> 27)) + (a ^ b ^ c) + 0x6ED9EBA1 + buff[i + 1];
                a = (a << 30) | (a >> 2);

                c += ((d << 5) | (d >> 27)) + (e ^ a ^ b) + 0x6ED9EBA1 + buff[i + 2];
                e = (e << 30) | (e >> 2);

                b += ((c << 5) | (c >> 27)) + (d ^ e ^ a) + 0x6ED9EBA1 + buff[i + 3];
                d = (d << 30) | (d >> 2);

                a += ((b << 5) | (b >> 27)) + (c ^ d ^ e) + 0x6ED9EBA1 + buff[i + 4];
                c = (c << 30) | (c >> 2);
                i += 5;
            }

            // ---- Round 3 --------
            while (i < 60)
            {
                e += ((a << 5) | (a >> 27)) + ((b & c) | (b & d) | (c & d)) + 0x8F1BBCDC + buff[i];
                b = (b << 30) | (b >> 2);

                d += ((e << 5) | (e >> 27)) + ((a & b) | (a & c) | (b & c)) + 0x8F1BBCDC + buff[i + 1];
                a = (a << 30) | (a >> 2);

                c += ((d << 5) | (d >> 27)) + ((e & a) | (e & b) | (a & b)) + 0x8F1BBCDC + buff[i + 2];
                e = (e << 30) | (e >> 2);

                b += ((c << 5) | (c >> 27)) + ((d & e) | (d & a) | (e & a)) + 0x8F1BBCDC + buff[i + 3];
                d = (d << 30) | (d >> 2);

                a += ((b << 5) | (b >> 27)) + ((c & d) | (c & e) | (d & e)) + 0x8F1BBCDC + buff[i + 4];
                c = (c << 30) | (c >> 2);
                i += 5;
            }

            // ---- Round 4 --------
            while (i < 80)
            {
                e += ((a << 5) | (a >> 27)) + (b ^ c ^ d) + 0xCA62C1D6 + buff[i];
                b = (b << 30) | (b >> 2);

                d += ((e << 5) | (e >> 27)) + (a ^ b ^ c) + 0xCA62C1D6 + buff[i + 1];
                a = (a << 30) | (a >> 2);

                c += ((d << 5) | (d >> 27)) + (e ^ a ^ b) + 0xCA62C1D6 + buff[i + 2];
                e = (e << 30) | (e >> 2);

                b += ((c << 5) | (c >> 27)) + (d ^ e ^ a) + 0xCA62C1D6 + buff[i + 3];
                d = (d << 30) | (d >> 2);

                a += ((b << 5) | (b >> 27)) + (c ^ d ^ e) + 0xCA62C1D6 + buff[i + 4];
                c = (c << 30) | (c >> 2);
                i += 5;
            }

            _H[0] += a;
            _H[1] += b;
            _H[2] += c;
            _H[3] += d;
            _H[4] += e;
        }

        private static void InitialiseBuff(uint[] buff, byte[] input, uint inputOffset)
        {
            buff[0] = (uint)((input[inputOffset + 0] << 24) | (input[inputOffset + 1] << 16) | (input[inputOffset + 2] << 8) | (input[inputOffset + 3]));
            buff[1] = (uint)((input[inputOffset + 4] << 24) | (input[inputOffset + 5] << 16) | (input[inputOffset + 6] << 8) | (input[inputOffset + 7]));
            buff[2] = (uint)((input[inputOffset + 8] << 24) | (input[inputOffset + 9] << 16) | (input[inputOffset + 10] << 8) | (input[inputOffset + 11]));
            buff[3] = (uint)((input[inputOffset + 12] << 24) | (input[inputOffset + 13] << 16) | (input[inputOffset + 14] << 8) | (input[inputOffset + 15]));
            buff[4] = (uint)((input[inputOffset + 16] << 24) | (input[inputOffset + 17] << 16) | (input[inputOffset + 18] << 8) | (input[inputOffset + 19]));
            buff[5] = (uint)((input[inputOffset + 20] << 24) | (input[inputOffset + 21] << 16) | (input[inputOffset + 22] << 8) | (input[inputOffset + 23]));
            buff[6] = (uint)((input[inputOffset + 24] << 24) | (input[inputOffset + 25] << 16) | (input[inputOffset + 26] << 8) | (input[inputOffset + 27]));
            buff[7] = (uint)((input[inputOffset + 28] << 24) | (input[inputOffset + 29] << 16) | (input[inputOffset + 30] << 8) | (input[inputOffset + 31]));
            buff[8] = (uint)((input[inputOffset + 32] << 24) | (input[inputOffset + 33] << 16) | (input[inputOffset + 34] << 8) | (input[inputOffset + 35]));
            buff[9] = (uint)((input[inputOffset + 36] << 24) | (input[inputOffset + 37] << 16) | (input[inputOffset + 38] << 8) | (input[inputOffset + 39]));
            buff[10] = (uint)((input[inputOffset + 40] << 24) | (input[inputOffset + 41] << 16) | (input[inputOffset + 42] << 8) | (input[inputOffset + 43]));
            buff[11] = (uint)((input[inputOffset + 44] << 24) | (input[inputOffset + 45] << 16) | (input[inputOffset + 46] << 8) | (input[inputOffset + 47]));
            buff[12] = (uint)((input[inputOffset + 48] << 24) | (input[inputOffset + 49] << 16) | (input[inputOffset + 50] << 8) | (input[inputOffset + 51]));
            buff[13] = (uint)((input[inputOffset + 52] << 24) | (input[inputOffset + 53] << 16) | (input[inputOffset + 54] << 8) | (input[inputOffset + 55]));
            buff[14] = (uint)((input[inputOffset + 56] << 24) | (input[inputOffset + 57] << 16) | (input[inputOffset + 58] << 8) | (input[inputOffset + 59]));
            buff[15] = (uint)((input[inputOffset + 60] << 24) | (input[inputOffset + 61] << 16) | (input[inputOffset + 62] << 8) | (input[inputOffset + 63]));
        }

        private static void FillBuff(uint[] buff)
        {
            uint val;
            for (int i = 16; i < 80; i += 8)
            {
                val = buff[i - 3] ^ buff[i - 8] ^ buff[i - 14] ^ buff[i - 16];
                buff[i] = (val << 1) | (val >> 31);

                val = buff[i - 2] ^ buff[i - 7] ^ buff[i - 13] ^ buff[i - 15];
                buff[i + 1] = (val << 1) | (val >> 31);

                val = buff[i - 1] ^ buff[i - 6] ^ buff[i - 12] ^ buff[i - 14];
                buff[i + 2] = (val << 1) | (val >> 31);

                val = buff[i + 0] ^ buff[i - 5] ^ buff[i - 11] ^ buff[i - 13];
                buff[i + 3] = (val << 1) | (val >> 31);

                val = buff[i + 1] ^ buff[i - 4] ^ buff[i - 10] ^ buff[i - 12];
                buff[i + 4] = (val << 1) | (val >> 31);

                val = buff[i + 2] ^ buff[i - 3] ^ buff[i - 9] ^ buff[i - 11];
                buff[i + 5] = (val << 1) | (val >> 31);

                val = buff[i + 3] ^ buff[i - 2] ^ buff[i - 8] ^ buff[i - 10];
                buff[i + 6] = (val << 1) | (val >> 31);

                val = buff[i + 4] ^ buff[i - 1] ^ buff[i - 7] ^ buff[i - 9];
                buff[i + 7] = (val << 1) | (val >> 31);
            }
        }

        private void ProcessFinalBlock(byte[] inputBuffer, int inputOffset, int inputCount)
        {
            ulong total = count + (ulong)inputCount;
            int paddingSize = (56 - (int)(total % BLOCK_SIZE_BYTES));

            if (paddingSize < 1)
                paddingSize += BLOCK_SIZE_BYTES;

            int length = inputCount + paddingSize + 8;
            byte[] fooBuffer = (length == 64) ? _ProcessingBuffer : new byte[length];

            for (int i = 0; i < inputCount; i++)
            {
                fooBuffer[i] = inputBuffer[i + inputOffset];
            }

            fooBuffer[inputCount] = 0x80;
            for (int i = inputCount + 1; i < inputCount + paddingSize; i++)
            {
                fooBuffer[i] = 0x00;
            }

            // I deal in bytes. The algorithm deals in bits.
            ulong size = total << 3;
            AddLength(size, fooBuffer, inputCount + paddingSize);
            ProcessBlock(fooBuffer, 0);

            if (length == 128)
                ProcessBlock(fooBuffer, 64);
        }

        internal void AddLength(ulong length, byte[] buffer, int position)
        {
            buffer[position++] = (byte)(length >> 56);
            buffer[position++] = (byte)(length >> 48);
            buffer[position++] = (byte)(length >> 40);
            buffer[position++] = (byte)(length >> 32);
            buffer[position++] = (byte)(length >> 24);
            buffer[position++] = (byte)(length >> 16);
            buffer[position++] = (byte)(length >> 8);
            buffer[position] = (byte)(length);
        }
    }

    internal class SHA1Svn : System.Security.Cryptography.SHA1
    {
        private const int BLOCK_SIZE_BYTES = 64;
        private const int HASH_SIZE_BYTES = 20;
        private uint[] _H;  // these are my chaining variables
        private ulong count;
        private byte[] _ProcessingBuffer;   // Used to start data when passed less than a block worth.
        private int _ProcessingBufferCount; // Counts how much data we have stored that still needs processed.
        private uint[] buff;

        public SHA1Svn()
        {
            _H = new uint[5];
            _ProcessingBuffer = new byte[BLOCK_SIZE_BYTES];
            buff = new uint[80];

            Initialize();
        }

        protected override void HashCore(byte[] rgb, int start, int size)
        {
            int i;

            if (_ProcessingBufferCount != 0)
            {
                if (size < (BLOCK_SIZE_BYTES - _ProcessingBufferCount))
                {
                    System.Buffer.BlockCopy(rgb, start, _ProcessingBuffer, _ProcessingBufferCount, size);
                    _ProcessingBufferCount += size;
                    return;
                }
                else
                {
                    i = (BLOCK_SIZE_BYTES - _ProcessingBufferCount);
                    System.Buffer.BlockCopy(rgb, start, _ProcessingBuffer, _ProcessingBufferCount, i);
                    ProcessBlock(_ProcessingBuffer, 0);
                    _ProcessingBufferCount = 0;
                    start += i;
                    size -= i;
                }
            }

            for (i = 0; i < size - size % BLOCK_SIZE_BYTES; i += BLOCK_SIZE_BYTES)
            {
                ProcessBlock(rgb, start + i);
            }

            if (size % BLOCK_SIZE_BYTES != 0)
            {
                System.Buffer.BlockCopy(rgb, size - size % BLOCK_SIZE_BYTES + start, _ProcessingBuffer, 0, size % BLOCK_SIZE_BYTES);
                _ProcessingBufferCount = size % BLOCK_SIZE_BYTES;
            }
        }

        protected override byte[] HashFinal()
        {
            byte[] hash = new byte[20];

            ProcessFinalBlock(_ProcessingBuffer, 0, _ProcessingBufferCount);

            for (int i = 0; i < 5; i++)
            {
                for (int j = 0; j < 4; j++)
                {
                    hash[i * 4 + j] = (byte)(_H[i] >> (8 * (3 - j)));
                }
            }

            return hash;
        }

        public override void Initialize()
        {
            count = 0;
            _ProcessingBufferCount = 0;

            _H[0] = 0x67452301;
            _H[1] = 0xefcdab89;
            _H[2] = 0x98badcfe;
            _H[3] = 0x10325476;
            _H[4] = 0xC3D2E1F0;
        }

        private void ProcessBlock(byte[] inputBuffer, int inputOffset)
        {
            uint a, b, c, d, e;
            int i;

            count += BLOCK_SIZE_BYTES;

            // abc removal would not work on the fields
            uint[] _H = this._H;
            uint[] buff = this.buff;
            for (i = 0; i < 16; i++)
            {
                buff[i] = ((uint)(inputBuffer[inputOffset + 4 * i]) << 24)
                    | ((uint)(inputBuffer[inputOffset + 4 * i + 1]) << 16)
                    | ((uint)(inputBuffer[inputOffset + 4 * i + 2]) << 8)
                    | ((uint)(inputBuffer[inputOffset + 4 * i + 3]));
            }

            uint zt;
            for (i = 16; i < 80; i++)
            {
                zt = buff[i - 3] ^ buff[i - 8] ^ buff[i - 14] ^ buff[i - 16];
                buff[i] = ((zt << 1) | (zt >> 31));
            }

            a = _H[0];
            b = _H[1];
            c = _H[2];
            d = _H[3];
            e = _H[4];

            // This function was unrolled because it seems to be doubling our performance with current compiler/VM.
            // Possibly roll up if this changes.

            // ---- Round 1 --------

            e += ((a << 5) | (a >> 27)) + (((c ^ d) & b) ^ d) + 0x5A827999 + buff[0];
            b = (b << 30) | (b >> 2);

            d += ((e << 5) | (e >> 27)) + (((b ^ c) & a) ^ c) + 0x5A827999 + buff[1];
            a = (a << 30) | (a >> 2);

            c += ((d << 5) | (d >> 27)) + (((a ^ b) & e) ^ b) + 0x5A827999 + buff[2];
            e = (e << 30) | (e >> 2);

            b += ((c << 5) | (c >> 27)) + (((e ^ a) & d) ^ a) + 0x5A827999 + buff[3];
            d = (d << 30) | (d >> 2);

            a += ((b << 5) | (b >> 27)) + (((d ^ e) & c) ^ e) + 0x5A827999 + buff[4];
            c = (c << 30) | (c >> 2);

            e += ((a << 5) | (a >> 27)) + (((c ^ d) & b) ^ d) + 0x5A827999 + buff[5];
            b = (b << 30) | (b >> 2);

            d += ((e << 5) | (e >> 27)) + (((b ^ c) & a) ^ c) + 0x5A827999 + buff[6];
            a = (a << 30) | (a >> 2);

            c += ((d << 5) | (d >> 27)) + (((a ^ b) & e) ^ b) + 0x5A827999 + buff[7];
            e = (e << 30) | (e >> 2);

            b += ((c << 5) | (c >> 27)) + (((e ^ a) & d) ^ a) + 0x5A827999 + buff[8];
            d = (d << 30) | (d >> 2);

            a += ((b << 5) | (b >> 27)) + (((d ^ e) & c) ^ e) + 0x5A827999 + buff[9];
            c = (c << 30) | (c >> 2);

            e += ((a << 5) | (a >> 27)) + (((c ^ d) & b) ^ d) + 0x5A827999 + buff[10];
            b = (b << 30) | (b >> 2);

            d += ((e << 5) | (e >> 27)) + (((b ^ c) & a) ^ c) + 0x5A827999 + buff[11];
            a = (a << 30) | (a >> 2);

            c += ((d << 5) | (d >> 27)) + (((a ^ b) & e) ^ b) + 0x5A827999 + buff[12];
            e = (e << 30) | (e >> 2);

            b += ((c << 5) | (c >> 27)) + (((e ^ a) & d) ^ a) + 0x5A827999 + buff[13];
            d = (d << 30) | (d >> 2);

            a += ((b << 5) | (b >> 27)) + (((d ^ e) & c) ^ e) + 0x5A827999 + buff[14];
            c = (c << 30) | (c >> 2);

            e += ((a << 5) | (a >> 27)) + (((c ^ d) & b) ^ d) + 0x5A827999 + buff[15];
            b = (b << 30) | (b >> 2);

            d += ((e << 5) | (e >> 27)) + (((b ^ c) & a) ^ c) + 0x5A827999 + buff[16];
            a = (a << 30) | (a >> 2);

            c += ((d << 5) | (d >> 27)) + (((a ^ b) & e) ^ b) + 0x5A827999 + buff[17];
            e = (e << 30) | (e >> 2);

            b += ((c << 5) | (c >> 27)) + (((e ^ a) & d) ^ a) + 0x5A827999 + buff[18];
            d = (d << 30) | (d >> 2);

            a += ((b << 5) | (b >> 27)) + (((d ^ e) & c) ^ e) + 0x5A827999 + buff[19];
            c = (c << 30) | (c >> 2);

            // ---- Round 2 --------

            e += ((a << 5) | (a >> 27)) + (b ^ c ^ d) + 0x6ED9EBA1 + buff[20];
            b = (b << 30) | (b >> 2);

            d += ((e << 5) | (e >> 27)) + (a ^ b ^ c) + 0x6ED9EBA1 + buff[21];
            a = (a << 30) | (a >> 2);

            c += ((d << 5) | (d >> 27)) + (e ^ a ^ b) + 0x6ED9EBA1 + buff[22];
            e = (e << 30) | (e >> 2);

            b += ((c << 5) | (c >> 27)) + (d ^ e ^ a) + 0x6ED9EBA1 + buff[23];
            d = (d << 30) | (d >> 2);

            a += ((b << 5) | (b >> 27)) + (c ^ d ^ e) + 0x6ED9EBA1 + buff[24];
            c = (c << 30) | (c >> 2);

            e += ((a << 5) | (a >> 27)) + (b ^ c ^ d) + 0x6ED9EBA1 + buff[25];
            b = (b << 30) | (b >> 2);

            d += ((e << 5) | (e >> 27)) + (a ^ b ^ c) + 0x6ED9EBA1 + buff[26];
            a = (a << 30) | (a >> 2);

            c += ((d << 5) | (d >> 27)) + (e ^ a ^ b) + 0x6ED9EBA1 + buff[27];
            e = (e << 30) | (e >> 2);

            b += ((c << 5) | (c >> 27)) + (d ^ e ^ a) + 0x6ED9EBA1 + buff[28];
            d = (d << 30) | (d >> 2);

            a += ((b << 5) | (b >> 27)) + (c ^ d ^ e) + 0x6ED9EBA1 + buff[29];
            c = (c << 30) | (c >> 2);

            e += ((a << 5) | (a >> 27)) + (b ^ c ^ d) + 0x6ED9EBA1 + buff[30];
            b = (b << 30) | (b >> 2);

            d += ((e << 5) | (e >> 27)) + (a ^ b ^ c) + 0x6ED9EBA1 + buff[31];
            a = (a << 30) | (a >> 2);

            c += ((d << 5) | (d >> 27)) + (e ^ a ^ b) + 0x6ED9EBA1 + buff[32];
            e = (e << 30) | (e >> 2);

            b += ((c << 5) | (c >> 27)) + (d ^ e ^ a) + 0x6ED9EBA1 + buff[33];
            d = (d << 30) | (d >> 2);

            a += ((b << 5) | (b >> 27)) + (c ^ d ^ e) + 0x6ED9EBA1 + buff[34];
            c = (c << 30) | (c >> 2);

            e += ((a << 5) | (a >> 27)) + (b ^ c ^ d) + 0x6ED9EBA1 + buff[35];
            b = (b << 30) | (b >> 2);

            d += ((e << 5) | (e >> 27)) + (a ^ b ^ c) + 0x6ED9EBA1 + buff[36];
            a = (a << 30) | (a >> 2);

            c += ((d << 5) | (d >> 27)) + (e ^ a ^ b) + 0x6ED9EBA1 + buff[37];
            e = (e << 30) | (e >> 2);

            b += ((c << 5) | (c >> 27)) + (d ^ e ^ a) + 0x6ED9EBA1 + buff[38];
            d = (d << 30) | (d >> 2);

            a += ((b << 5) | (b >> 27)) + (c ^ d ^ e) + 0x6ED9EBA1 + buff[39];
            c = (c << 30) | (c >> 2);

            // ---- Round 3 --------

            e += ((a << 5) | (a >> 27)) + ((b & c) | (b & d) | (c & d)) + 0x8F1BBCDC + buff[40];
            b = (b << 30) | (b >> 2);

            d += ((e << 5) | (e >> 27)) + ((a & b) | (a & c) | (b & c)) + 0x8F1BBCDC + buff[41];
            a = (a << 30) | (a >> 2);

            c += ((d << 5) | (d >> 27)) + ((e & a) | (e & b) | (a & b)) + 0x8F1BBCDC + buff[42];
            e = (e << 30) | (e >> 2);

            b += ((c << 5) | (c >> 27)) + ((d & e) | (d & a) | (e & a)) + 0x8F1BBCDC + buff[43];
            d = (d << 30) | (d >> 2);

            a += ((b << 5) | (b >> 27)) + ((c & d) | (c & e) | (d & e)) + 0x8F1BBCDC + buff[44];
            c = (c << 30) | (c >> 2);

            e += ((a << 5) | (a >> 27)) + ((b & c) | (b & d) | (c & d)) + 0x8F1BBCDC + buff[45];
            b = (b << 30) | (b >> 2);

            d += ((e << 5) | (e >> 27)) + ((a & b) | (a & c) | (b & c)) + 0x8F1BBCDC + buff[46];
            a = (a << 30) | (a >> 2);

            c += ((d << 5) | (d >> 27)) + ((e & a) | (e & b) | (a & b)) + 0x8F1BBCDC + buff[47];
            e = (e << 30) | (e >> 2);

            b += ((c << 5) | (c >> 27)) + ((d & e) | (d & a) | (e & a)) + 0x8F1BBCDC + buff[48];
            d = (d << 30) | (d >> 2);

            a += ((b << 5) | (b >> 27)) + ((c & d) | (c & e) | (d & e)) + 0x8F1BBCDC + buff[49];
            c = (c << 30) | (c >> 2);

            e += ((a << 5) | (a >> 27)) + ((b & c) | (b & d) | (c & d)) + 0x8F1BBCDC + buff[50];
            b = (b << 30) | (b >> 2);

            d += ((e << 5) | (e >> 27)) + ((a & b) | (a & c) | (b & c)) + 0x8F1BBCDC + buff[51];
            a = (a << 30) | (a >> 2);

            c += ((d << 5) | (d >> 27)) + ((e & a) | (e & b) | (a & b)) + 0x8F1BBCDC + buff[52];
            e = (e << 30) | (e >> 2);

            b += ((c << 5) | (c >> 27)) + ((d & e) | (d & a) | (e & a)) + 0x8F1BBCDC + buff[53];
            d = (d << 30) | (d >> 2);

            a += ((b << 5) | (b >> 27)) + ((c & d) | (c & e) | (d & e)) + 0x8F1BBCDC + buff[54];
            c = (c << 30) | (c >> 2);

            e += ((a << 5) | (a >> 27)) + ((b & c) | (b & d) | (c & d)) + 0x8F1BBCDC + buff[55];
            b = (b << 30) | (b >> 2);

            d += ((e << 5) | (e >> 27)) + ((a & b) | (a & c) | (b & c)) + 0x8F1BBCDC + buff[56];
            a = (a << 30) | (a >> 2);

            c += ((d << 5) | (d >> 27)) + ((e & a) | (e & b) | (a & b)) + 0x8F1BBCDC + buff[57];
            e = (e << 30) | (e >> 2);

            b += ((c << 5) | (c >> 27)) + ((d & e) | (d & a) | (e & a)) + 0x8F1BBCDC + buff[58];
            d = (d << 30) | (d >> 2);

            a += ((b << 5) | (b >> 27)) + ((c & d) | (c & e) | (d & e)) + 0x8F1BBCDC + buff[59];
            c = (c << 30) | (c >> 2);

            // ---- Round 4 --------

            e += ((a << 5) | (a >> 27)) + (b ^ c ^ d) + 0xCA62C1D6 + buff[60];
            b = (b << 30) | (b >> 2);

            d += ((e << 5) | (e >> 27)) + (a ^ b ^ c) + 0xCA62C1D6 + buff[61];
            a = (a << 30) | (a >> 2);

            c += ((d << 5) | (d >> 27)) + (e ^ a ^ b) + 0xCA62C1D6 + buff[62];
            e = (e << 30) | (e >> 2);

            b += ((c << 5) | (c >> 27)) + (d ^ e ^ a) + 0xCA62C1D6 + buff[63];
            d = (d << 30) | (d >> 2);

            a += ((b << 5) | (b >> 27)) + (c ^ d ^ e) + 0xCA62C1D6 + buff[64];
            c = (c << 30) | (c >> 2);

            e += ((a << 5) | (a >> 27)) + (b ^ c ^ d) + 0xCA62C1D6 + buff[65];
            b = (b << 30) | (b >> 2);

            d += ((e << 5) | (e >> 27)) + (a ^ b ^ c) + 0xCA62C1D6 + buff[66];
            a = (a << 30) | (a >> 2);

            c += ((d << 5) | (d >> 27)) + (e ^ a ^ b) + 0xCA62C1D6 + buff[67];
            e = (e << 30) | (e >> 2);

            b += ((c << 5) | (c >> 27)) + (d ^ e ^ a) + 0xCA62C1D6 + buff[68];
            d = (d << 30) | (d >> 2);

            a += ((b << 5) | (b >> 27)) + (c ^ d ^ e) + 0xCA62C1D6 + buff[69];
            c = (c << 30) | (c >> 2);

            e += ((a << 5) | (a >> 27)) + (b ^ c ^ d) + 0xCA62C1D6 + buff[70];
            b = (b << 30) | (b >> 2);

            d += ((e << 5) | (e >> 27)) + (a ^ b ^ c) + 0xCA62C1D6 + buff[71];
            a = (a << 30) | (a >> 2);

            c += ((d << 5) | (d >> 27)) + (e ^ a ^ b) + 0xCA62C1D6 + buff[72];
            e = (e << 30) | (e >> 2);

            b += ((c << 5) | (c >> 27)) + (d ^ e ^ a) + 0xCA62C1D6 + buff[73];
            d = (d << 30) | (d >> 2);

            a += ((b << 5) | (b >> 27)) + (c ^ d ^ e) + 0xCA62C1D6 + buff[74];
            c = (c << 30) | (c >> 2);

            e += ((a << 5) | (a >> 27)) + (b ^ c ^ d) + 0xCA62C1D6 + buff[75];
            b = (b << 30) | (b >> 2);

            d += ((e << 5) | (e >> 27)) + (a ^ b ^ c) + 0xCA62C1D6 + buff[76];
            a = (a << 30) | (a >> 2);

            c += ((d << 5) | (d >> 27)) + (e ^ a ^ b) + 0xCA62C1D6 + buff[77];
            e = (e << 30) | (e >> 2);

            b += ((c << 5) | (c >> 27)) + (d ^ e ^ a) + 0xCA62C1D6 + buff[78];
            d = (d << 30) | (d >> 2);

            a += ((b << 5) | (b >> 27)) + (c ^ d ^ e) + 0xCA62C1D6 + buff[79];
            c = (c << 30) | (c >> 2);


            _H[0] += a;
            _H[1] += b;
            _H[2] += c;
            _H[3] += d;
            _H[4] += e;
        }

        private void ProcessFinalBlock(byte[] inputBuffer, int inputOffset, int inputCount)
        {
            ulong total = count + (ulong)inputCount;
            int paddingSize = (56 - (int)(total % BLOCK_SIZE_BYTES));

            if (paddingSize < 1)
                paddingSize += BLOCK_SIZE_BYTES;

            int length = inputCount + paddingSize + 8;
            byte[] fooBuffer = (length == 64) ? _ProcessingBuffer : new byte[length];

            for (int i = 0; i < inputCount; i++)
            {
                fooBuffer[i] = inputBuffer[i + inputOffset];
            }

            fooBuffer[inputCount] = 0x80;
            for (int i = inputCount + 1; i < inputCount + paddingSize; i++)
            {
                fooBuffer[i] = 0x00;
            }

            // I deal in bytes. The algorithm deals in bits.
            ulong size = total << 3;
            AddLength(size, fooBuffer, inputCount + paddingSize);
            ProcessBlock(fooBuffer, 0);

            if (length == 128)
                ProcessBlock(fooBuffer, 64);
        }

        internal void AddLength(ulong length, byte[] buffer, int position)
        {
            buffer[position++] = (byte)(length >> 56);
            buffer[position++] = (byte)(length >> 48);
            buffer[position++] = (byte)(length >> 40);
            buffer[position++] = (byte)(length >> 32);
            buffer[position++] = (byte)(length >> 24);
            buffer[position++] = (byte)(length >> 16);
            buffer[position++] = (byte)(length >> 8);
            buffer[position] = (byte)(length);
        }
    }
}