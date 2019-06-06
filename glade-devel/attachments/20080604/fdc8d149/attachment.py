import gobject
import gtk

class MyBox(gtk.HBox):
        __gtype_name__ = 'MyBox'
        
        def __init__(self):
                gtk.HBox.__init__(self)
