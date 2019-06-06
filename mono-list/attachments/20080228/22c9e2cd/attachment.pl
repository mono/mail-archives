using System;
using System.IO;
using System.Drawing.Printing;
using System.Drawing;

namespace DefaultNamespace
{
     
enum PageOrient
{
		landscape,
		portrait
}
	
class MyPrinter  
{

	 PrintDocument pv_PrintDocument;
	 Font pv_PrintFont;
	 StringReader pv_PrintDataReader;
	 	 
	 public MyPrinter( string in_PrintData, PageOrient in_PageOrient )
	 {
	    pv_PrintDocument = new PrintDocument();
        pv_PrintDocument.PrintPage += OnPrintPageEvent;
          
        pv_PrintDataReader = new StringReader( in_PrintData );
          
        pv_PrintFont = new System.Drawing.Font("Arial", 10);
        
        if ( in_PageOrient.Equals( PageOrient.landscape ) )
        {
        	pv_PrintDocument.DefaultPageSettings.Landscape = true;
        }
        
        this.Start();
	 }
	 
	 public int Start()
	 {
	 	pv_PrintDocument.Print();
	 	
	 	return ( 0 );
	 }
	                   	  
     public void OnPrintPageEvent(object sender, PrintPageEventArgs e)
	 {
   	 	float yPos = 0f;
     	int count = 0;
     	float leftMargin = e.MarginBounds.Left;
     	float topMargin = e.MarginBounds.Top;
     	string line = null;
   		float linesPerPage = e.MarginBounds.Height/pv_PrintFont.GetHeight(e.Graphics);
   		
   		while (count < linesPerPage)
   		{
      		line = pv_PrintDataReader.ReadLine();
      		if (line == null)
      		{
         		break;
      		}
      		yPos = topMargin + count * pv_PrintFont.GetHeight(e.Graphics);
      		e.Graphics.DrawString(line, pv_PrintFont, Brushes.Black, leftMargin, yPos, new StringFormat());
      		count++;
   		}
   		if (line != null)
   		{
      		e.HasMorePages = true;
   		}
	 }
     
     static void Main( string[] args )
     {
     	new MyPrinter( "Lorem Ipsum is simply dummy text of the printing\n and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.", PageOrient.landscape );
     }

}

}

