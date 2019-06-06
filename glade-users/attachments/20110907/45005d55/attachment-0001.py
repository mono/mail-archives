#!/usr/bin/env python

import sys
from gi.repository import Gtk

class App:
	def __init__(self, ui_file):
		self._builder = Gtk.Builder()
		self._builder.add_from_file(sys.argv[1])

		window = self._builder.get_object('main-window')
		window.show_all()
		window.connect('delete-event', self.window_delete_ev_cb)

		self._ok_action = self._builder.get_object('ok-action')
		self._ok_action.connect('activate', self.action_activate_cb)

		Gtk.main()

	def window_delete_ev_cb(self, window, ev):
		self._ok_action.activate()

	def action_activate_cb(self, action):
		name = action.get_name()
		if name == 'ok-action':
			Gtk.main_quit()
		else:
			print "Unknow action: ", name

App(sys.argv[1])
