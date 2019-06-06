using System;
using System.Drawing.Printing;

class PrintSample
{
    static void Main(string[] args)
    {
        foreach (string printerName in PrinterSettings.InstalledPrinters)
        {
            Console.WriteLine("Printer: {0}", printerName);
        }
    }
}
