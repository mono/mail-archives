////////////////////////////////////////////////////////////////////////////////
// Controller
// 
// Copyright (c) 2007 Alex A. dos Santos
//
// Permission to use, copy, modify, distribute and sell this software for any 
// purpose is hereby granted without fee, provided that the above copyright 
// notice appear in all copies and that both that copyright notice and this 
// permission notice appear in supporting documentation.
//
//////////////////////////////////////////////////////////////////////////////////
using System;
using System.Collections;
using System.Text;
using System.Windows.Forms;
using System.IO;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Net;
using System.Text.RegularExpressions;

namespace AutoLyrix
{

    public class Controller
    {
        private System.Windows.Forms.NotifyIcon trayIcon;
        private System.Windows.Forms.ContextMenuStrip trayMenu;
        
        [STAThread]
        static void Main(string[] args)
        {
            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);
            //
	    new Controller(args);
            Application.Run();
        }
 
        public Controller(string[] args)
        {
            this.InitializeComponents();
        }

        public void InitializeComponents()
        {
       	    System.Reflection.Assembly assem = GetType().Assembly;
            //
            // trayMenu
            // 
            this.trayMenu = new ContextMenuStrip();
            this.trayMenu.Items.Add(new ToolStripSeparator());
            //this.trayMenu.Items.Add(createMenuItem("About", "appAbout"));
            this.trayMenu.RenderMode = System.Windows.Forms.ToolStripRenderMode.Professional;
            this.trayMenu.ShowImageMargin = false;
            //
            // trayIcon
            //
            this.trayIcon = new System.Windows.Forms.NotifyIcon();
            this.trayIcon.Text = "test";
            this.trayIcon.Icon = new Icon(assem.GetManifestResourceStream("test.Resources.test.ico"));
            this.trayIcon.Visible = true;
            this.trayIcon.ContextMenuStrip = this.trayMenu;
            this.trayIcon.Click += new EventHandler(trayIcon_Click);
        }

        private void trayIcon_Click(object sender, EventArgs e)
        {
        
	}
    }
}