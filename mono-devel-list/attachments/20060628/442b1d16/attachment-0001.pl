using System;
namespace System.Net.Sockets
{
    [FlagsAttribute]
    public enum SocketInformationOptions {

        Connected = 0x00000000,
        Listening = 0x00000001,
        NonBlocking = 0x00000002,
        UseOnlyOverlappedIO = 0x00000004,
    }


}
