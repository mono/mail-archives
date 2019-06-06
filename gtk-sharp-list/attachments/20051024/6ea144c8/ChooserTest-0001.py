#!/usr/bin/env python
"""Test case to test FileChooserWidget from glade"""

import pygtk; pygtk.require('2.0')
import gtk, gtk.glade

class FileChooserTest:

	def __init__(self):
		widgets = gtk.glade.XML("ChooserTest.glade", "window")
		widgets.signal_autoconnect(self)
		gtk.main()

if __name__ == "__main__":
	FileChooserTest()
