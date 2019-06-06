using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.IO;
using System.Security.Cryptography;
using System.Net.Sockets;


namespace Encrypt
{
	/// <summary>
	/// Summary description for Form1.
	/// </summary>
	public class Form1
	{
	
		public Form1()
		{
	
		}

		[STAThread]
		static void Main() 
		{
			Form1 objTest = new Form1();
			objTest.encrypt(@"Falls.jpg");
			//objTest.decrypt("newFile.jpg");			
		}

		public void decrypt(string filename)
		{

			try
			{				
				FileStream NetStream = new FileStream(@"encryptedFile",System.IO.FileMode.Open);

				//Create a new instance of the RijndaelManaged class
				// and encrypt the stream.
				RijndaelManaged RMCrypto = new RijndaelManaged();

				byte[] Key = {0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16};
				byte[] IV = {0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16};

				//Create a CryptoStream, pass it the NetworkStream, and encrypt 
				//it with the Rijndael class.
				CryptoStream CryptStream = new CryptoStream(NetStream, 
					RMCrypto.CreateDecryptor(Key, IV),   
					CryptoStreamMode.Read);

				int len = 0;
				long myLength = 0;
				byte[] Buffer = new Byte[1024];
				FileInfo tempFileInfo = new FileInfo("Falls.jpg");
				FileStream fout = new FileStream(filename, FileMode.Create, FileAccess.Write);

				try
				{

//					while(myLength<tempFileInfo.Length)
//					{	
//						//Console.WriteLine(CryptStream.Length);
//						Console.WriteLine(tempFileInfo.Length);
//						
//						Console.WriteLine("test1");
//						len = CryptStream.Read(Buffer,0,1023);
//						Console.WriteLine("test2");
//						fout.Write(Buffer,0,len);
//						Console.WriteLine("test3");
//						fout.Flush();
//						Console.WriteLine(myLength);
//						Console.WriteLine(len);
//						myLength = myLength + len;
//					}
					
					while((len = CryptStream.Read(Buffer,0,1023)) != 0)
					{						
						
						fout.Write(Buffer,0,len);
						
						fout.Flush();
						myLength = myLength + len;
						
					}
				}
				catch(Exception err)
				{
					Console.WriteLine("Error In");
					Console.WriteLine(err.TargetSite);
					Console.WriteLine(err.Source);
					Console.WriteLine(err.Message);
				}	
		
				CryptStream.Close();
				NetStream.Close();
			
			}
			catch(Exception err2)
			{
				//Inform the user that an exception was raised.
				Console.WriteLine("failed"+err2.Message);
			}
		}

		public void encrypt(string filename)
		{
			try
			{
				
				FileStream NetStream = new FileStream("encryptedFile",System.IO.FileMode.Create);

				//Create a new instance of the RijndaelManaged class
				// and encrypt the stream.
				RijndaelManaged RMCrypto = new RijndaelManaged();

				byte[] Key = {0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16};
				byte[] IV = {0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16};

				//Create a CryptoStream, pass it the NetworkStream, and encrypt 
				//it with the Rijndael class.
				CryptoStream CryptStream = new CryptoStream(NetStream, 
					RMCrypto.CreateEncryptor(Key, IV),   
					CryptoStreamMode.Write);

				int len = 0;
				long myLength = 0;
				byte[] Buffer = new Byte[1024];
				FileInfo tempFileInfo = new FileInfo(filename);
				FileStream fout = new FileStream(filename, FileMode.Open, FileAccess.Read);
				try
				{
					while(myLength<tempFileInfo.Length)
					{
						len =fout.Read(Buffer,0,1023);
						if(len == 0)
							break;
						CryptStream.Write(Buffer,0,len);
						CryptStream.Flush();
						myLength = myLength + len;
					}
				}
				catch(Exception err)
				{
					Console.WriteLine(err.Message);
				}
	
				CryptStream.Close();
				NetStream.Close();
			
			}
			catch
			{
				//Inform the user that an exception was raised.
				Console.WriteLine("failed");
			}

		}

	}
}

