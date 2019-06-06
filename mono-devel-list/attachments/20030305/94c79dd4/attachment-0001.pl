Latin1: GetString (byte[0])
System.IndexOutOfRangeException: Array index is out of range
in <0x0005a> 00 System.Text.Latin1Encoding:GetString (byte[])
in <0x00082> 00 .TestGetString:Test (string,System.Text.Encoding)

Latin1: GetString (byte[0], 0, 0)
System.IndexOutOfRangeException: Array index is out of range
in <0x000f2> 00 System.Text.Latin1Encoding:GetString (byte[],int,int)
in <0x00131> 00 .TestGetString:Test (string,System.Text.Encoding)

ASCII: GetString (byte[0])
System.IndexOutOfRangeException: Array index is out of range
in <0x0005a> 00 System.Text.ASCIIEncoding:GetString (byte[])
in <0x00082> 00 .TestGetString:Test (string,System.Text.Encoding)

ASCII: GetString (byte[0], 0, 0)
System.IndexOutOfRangeException: Array index is out of range
in <0x000f2> 00 System.Text.ASCIIEncoding:GetString (byte[],int,int)
in <0x00131> 00 .TestGetString:Test (string,System.Text.Encoding)

