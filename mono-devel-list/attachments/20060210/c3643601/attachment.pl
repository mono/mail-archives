using System;
using System.Collections.Generic;
using System.Text;
using System.IO;
using System.Data;
using System.Data.OracleClient;
using System.Net.Mail;

namespace MontitorDatabase
{
    class Program
    {
        static void Main(string[] args)
        {
            //Creating connection
            string connectionString =
            "Data Source=EMREP;"
            + "User ID=system;"
            + "Password=c0mm0d0r3;";
            OracleConnection dbconn = null;
            dbconn = new OracleConnection(connectionString);
            try
            {
                dbconn.Open();

                OracleCommand dbcmd = dbconn.CreateCommand();
                string sql = "select sysdate,status from v$instance";
                dbcmd.CommandText = sql;

                OracleDataReader dbreader = dbcmd.ExecuteReader();
                while (dbreader.Read())
                {
                    string sysdate = (string)dbreader["sysdate"];
                    string status = (string)dbreader["status"];
                    System.Console.WriteLine("Date: {0} Status: {1}", sysdate, status);
                }
            }
            catch (NullReferenceException ex)
            {
               // System.Console.WriteLine(ex.Message);
	       // FileStream file = new FileStream("db_montior.txt", FileMode.Create, FileAccess.Write);
               // StreamWriter sw = new StreamWriter(file);
               // sw.Write(ex.Message);
               // sw.Close();
               // System.Net.Mail.MailMessage message = new System.Net.Mail.MailMessage();
               // message.To.Add("javier.ruiz@reedhycalog.com;javierruiz@");
               // message.Subject = "Test C# Mail";
               // message.From = new System.Net.Mail.MailAddress("db_monitor@reedhycalog.com");
               // message.Body = ex.Message;
               // System.Net.Mail.SmtpClient smtp = new System.Net.Mail.SmtpClient("grante2k.grantprideco.cc");
               // smtp.Send(message);


            }
            finally
            {
                dbconn.Close();
            }
        }
    }

}
