#!/usr/bin/env python

import gtk
import gtk.glade

xml=gtk.glade.XML('test.glade','window1')
window=xml.get_widget('window1')
window.show_all()
gtk.main()
