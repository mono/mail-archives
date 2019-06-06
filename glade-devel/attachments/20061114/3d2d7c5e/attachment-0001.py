import gtk
import gobject
import glade

class GladeTextViewAdaptor(glade.get_adaptor_for_type ('GtkHBox')):
	__gtype_name__ = 'GladeTextViewAdaptor'
	def __init__(self):
        	glade.GladeGtkHBoxAdaptor.__init__(self)
	def do_post_create(self, obj, reason):
		print "hola\n";
	def do_child_set_property(self, container, child, property_name, value):
		glade.GladeGtkHBoxAdaptor.do_child_set_property(self,container, child, property_name, value);
		print "hola do_child_set_property\n";
	def do_child_get_property(self, container, child, property_name):
		a = glade.GladeGtkHBoxAdaptor.do_child_get_property(self,container, child, property_name);
		print "hola do_child_get_property\n";
		return a;
	def do_get_children(self, container):
		a = glade.GladeGtkHBoxAdaptor.do_get_children(self, container);
		print "hola do_get_children\n";
		return a;

class TextView(gtk.HBox):
	__gtype_name__ = 'TextView'
	def __init__(self):
        	gtk.HBox.__init__(self)
