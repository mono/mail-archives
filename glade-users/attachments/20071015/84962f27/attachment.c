/* This program displays a simple window and has a simple callback for
 * when the OK button is clicked.
 */

#include <gtk/gtk.h>
#include <glade/glade.h>
#include <string.h>

char *gFileName;
GladeXML *xml_OAA;
GladeXML *xml_taskchooserdialog;


void initial()
{
  gFileName = 0;
  xml_OAA = 0;
  xml_taskchooserdialog = 0;
}


void xml_OAAmenu_activate_quit(GtkWidget *widget, gpointer user_data)
{
 printf ("Thanks for trying out my program.\n");
gtk_main_quit ();
}

void on_taskfile_cancel_clicked(GtkWidget *widget, gpointer user_data)
{
  GladeXML *xml;
	printf("1 %s\n",glade_get_widget_name(widget));
  /* Find the Glade XML tree containing widget. */
  xml = glade_get_widget_tree (GTK_WIDGET (widget));
  // this shal be   xml_taskchooserdialog ?
	printf("2 %s\n",glade_get_widget_name(glade_xml_get_widget (xml, "taskchooserdialog")));
  gtk_widget_destroy(glade_xml_get_widget (xml, "taskchooserdialog"));
  xml_taskchooserdialog=0;
}

void on_task_select_clicked(GtkWidget *widget, gpointer user_data)
{
GladeXML *task;
GtkWidget *widgetTask;

  xml_taskchooserdialog = glade_xml_new("oaa.glade", "taskchooserdialog", NULL);
  glade_xml_signal_autoconnect(xml_taskchooserdialog);
//  widgetTask = glade_xml_get_widget (task, "cancel_select");
//  g_signal_connect (G_OBJECT (widgetTask), "clicked",
//                    G_CALLBACK (on_taskfile_cancel_clicked), NULL);
printf("on_task_select_clicked\n");
}


void on_taskfile_selected(GtkWidget *widget, gpointer user_data)
{   GladeXML *xml;
    GtkWidget *dialog;

    xml = glade_get_widget_tree (GTK_WIDGET (widget));
	printf("on_taskfile_selected %s\n",glade_get_widget_name(widget));
    dialog = glade_xml_get_widget (xml, "taskchooserdialog");
	printf("on_taskfile_selected %s\n",glade_get_widget_name(dialog));
    gFileName = gtk_file_chooser_get_filename (GTK_FILE_CHOOSER (dialog));
	printf("on_taskfile_selected %s\n",gFileName);
    dialog = glade_xml_get_widget (xml_OAA, "entry1");
    gtk_entry_set_text (GTK_ENTRY(dialog), gFileName);
    on_taskfile_cancel_clicked(widget, user_data);
}




int
main (int argc, char *argv[])
{

  GtkWidget *widget;
  gtk_init (&argc, &argv);
  initial();

  /* load the interface */
  xml_OAA = glade_xml_new ("oaa.glade", "OAA", NULL);


  /* connect the signals in the interface */
  glade_xml_signal_autoconnect(xml_OAA);
//  glade_xml_signal_autoconnect(xml_taskchooserdialog);

  /* Have the  "quit menu call" end the program */
// dit hoeft niet, omdat glade.xml
  widget = glade_xml_get_widget (xml_OAA, "quit1");
  g_signal_connect (G_OBJECT (widget), "activate",
                    G_CALLBACK (xml_OAAmenu_activate_quit),
                    NULL);

  /* Have the delete event (window close) end the program */
  widget = glade_xml_get_widget (xml_OAA, "OAA");
  g_signal_connect (G_OBJECT (widget), "delete_event",
                    G_CALLBACK (gtk_main_quit), NULL);

  /* Have the task_select open a file dialog  */
//  widget = glade_xml_get_widget (xml_OAA, "task_select");
//  g_signal_connect (G_OBJECT (widget), "clicked",
//                    G_CALLBACK (on_task_select_clicked), NULL);


  /* Have the cancel button close the file dialog  */
// kan niet, omdat de window er niet is.
//  widget = glade_xml_get_widget (xml_taskchooserdialog, "cancel_select");
//  g_signal_connect (G_OBJECT (widget), "clicked",
//                    G_CALLBACK (on_taskfile_cancel_clicked), NULL);


  /* start the event loop */
  gtk_main ();

  return 0;
}