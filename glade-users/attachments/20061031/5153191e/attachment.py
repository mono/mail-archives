#!/usr/bin/env python

import sys
try:
	import pygtk
	pygtk.require("2.0")
except:
	pass
try:
	import gtk
	import gtk.glade
except:
	sys.exit(1)
	
class HellowWorldGTK:

	def __init__(self):
		#Set the Glade file
		self.gladefile = 'pyHelloWorld.glade3'
#		self.gladefile = 'pyhelloworld.glade2'
		self.wTree = gtk.glade.XML(self.gladefile) 

		#Get the Main Window, and connect the "destroy" event
		dic = { "on_btnHelloWorld_clicked" : self.on_btnHelloWorld_clicked,
					"destroy" : gtk.main_quit }
		
		self.wTree.signal_autoconnect(dic)
	
	def on_btnHelloWorld_clicked(self, widget):
		print "Hello world"
		
if __name__ == "__main__":
	hwg = HellowWorldGTK()
	gtk.main()
