/* This program displays a simple window and has a simple callback for
 * when the OK button is clicked.
 */

#include <gtk/gtk.h>
#include <glade/glade.h>


void main_windowmenu_activate_quit(GtkWidget *widget, gpointer user_data)
{
// printf ("Thanks for trying out my program.\n");
gtk_main_quit ();
}

void on_task_select_clicked(GtkWidget *widget, gpointer user_data)
{
GladeXML *task;

task = glade_xml_new("oaa.glade", "taskchooserdialog", NULL);
}

void on_taskfile_selected(GtkWidget *widget, gpointer user_data)
{
}

void on_taskfile_cancel_clicked(GtkWidget *widget, gpointer user_data)
{
gtk_widget_destroy(widget);
}


int
main (int argc, char *argv[])
{
  GladeXML  *main_window;
  GladeXML  *select_file;
  GtkWidget *widget;

  gtk_init (&argc, &argv);

  /* load the interface */
  main_window = glade_xml_new ("oaa.glade", "OAA", NULL);

  /* connect the signals in the interface */
  glade_xml_signal_autoconnect(main_window);
  glade_xml_signal_autoconnect(select_file);

  /* Have the  "quit menu call" end the program */
  widget = glade_xml_get_widget (main_window, "quit1");
  g_signal_connect (G_OBJECT (widget), "activate",
                    G_CALLBACK (main_windowmenu_activate_quit),
                    NULL);

  /* Have the delete event (window close) end the program */
  widget = glade_xml_get_widget (main_window, "OAA");
  g_signal_connect (G_OBJECT (widget), "delete_event",
                    G_CALLBACK (gtk_main_quit), NULL);

  /* Have the task_select open a file dialog  */
  widget = glade_xml_get_widget (main_window, "task_select");
  g_signal_connect (G_OBJECT (widget), "clicked",
                    G_CALLBACK (on_task_select_clicked), NULL);


  /* Have the cancel button close the file dialog  */
  widget = glade_xml_get_widget (select_file, "cancel_select");
  g_signal_connect (G_OBJECT (widget), "clicked",
                    G_CALLBACK (on_taskfile_cancel_clicked), NULL);


  /* start the event loop */
  gtk_main ();

  return 0;
}
