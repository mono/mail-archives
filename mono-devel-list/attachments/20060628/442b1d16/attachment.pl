using System;
namespace System.Net.Sockets
{
    [FlagsAttribute]
    public enum TransmitFileOptions {

        Disconnect = 0x00000000,
        ReuseSocket = 0x00000001,
        UseDefaultWorkerThread = 0x00000002,
        UseKernelApc = 0x00000004,
        UseSystemThread = 0x00000010,
        WriteBehind = 0x00008000,
    }
}

