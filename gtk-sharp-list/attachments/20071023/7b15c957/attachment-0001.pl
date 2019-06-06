/*
 * Created by SharpDevelop.
 * User: Hybrid
 * Date: 10/17/2007
 * Time: 5:16 PM
 * 
 * To change this template use Tools | Options | Coding | Edit Standard Headers.
 */

using System;
using Gtk;

public class DeletableTester
{
	public static void Main (string[] args)
	{
		new DeletableTester (args);
	}
 
	public DeletableTester (string[] args) 
	{
		
		Application.Init();
		
	
		MessageDialog md1 = new MessageDialog (null, 
                                      DialogFlags.Modal,
                                   MessageType.Question, 
                                      ButtonsType.YesNo, "");
		
		md1.UseMarkup = true;
        md1.SecondaryUseMarkup = true;
        md1.Text = "<b>Window cannot be deleted</b>";
        
        md1.Deletable = false;
                	
        md1.Title = "Undeletable Window";
        	
        md1.Run();
        	
        md1.Destroy();
        
        Application.Run();
        
	}
}

