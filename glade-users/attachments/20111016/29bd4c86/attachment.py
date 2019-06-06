import sys
act= [('jaos', 'mva'), ('sig', 'new')]
try:  
    import pygtk  
    pygtk.require("2.0") 
    import gobject 
except:  
    pass  
try:  
    import gtk  
except:  
    print("GTK Not Availible")
    sys.exit(1)

class euca:
    def __init__(self):
        self.glade = "gtkbuilder.glade"
        self.builder = gtk.Builder()
        self.builder.add_from_file(self.glade)
        self.window = self.builder.get_object("window1")
        dic = {"on_button1_clicked":self.displaymsg,
               "on_treeview_row_activated":self.displaytree
               }
        
        #adding values to combo box
        cbox = self.builder.get_object("combobox1")
        store = gtk.ListStore(gobject.TYPE_STRING)
        store.append(["vishal"])
        store.append(["arun"])
        store.append(["sabin"])
        cbox.set_model(store)
        cbox.append_text("hai")
        cell = gtk.CellRendererText()
        cbox.pack_start(cell, True)
        cbox.add_attribute(cell, 'text', 0)
        
        cbox.set_active(0)
        
        #adding more values to tree view
        st = self.builder.get_object("datastore")
        
        st.append([act[0],act[1]])
        #self.builder.get_object("treeview")
        
        store = gtk.ListStore(str,str)
        store.append([act[0],act[1]])
        treeview = gtk.TreeView(store)    
        #self.create_columns(treeview)
        
        
        self.builder.connect_signals(dic)
        
    def displaymsg(self,widget):
        
        #getting value from the text box
        print "Text box value ",self.builder.get_object("name").get_text()
        
        #getting selected value from combobox       
        cbox = self.builder.get_object("combobox1")
        model = cbox.get_model()
        active = cbox.get_active()
        print "value selected",model[active][0]  
        
        
        cbox = self.builder.get_object("treeview")
        model = cbox.get_model()
        
        print "value selected",model[0][0]  
        
    def displaytree(self,widget,row,col):
        model = widget.get_model()
        text = model[row][0] + ", " + model[row][1]
        print text
        
if __name__ == "__main__":
    app = euca()
    gtk.main()

