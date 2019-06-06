TARGET_VERSION=2.10
POLICY_VERSION=2.4 2.6 2.8 2.10
GTK_VERSION=2.10.4

GTK_TARBALL=gtk-sharp-$(GTK_VERSION).tar.bz2
GTK_DIR=gtk-sharp-$(GTK_VERSION)
ADDIN_FILE=md-gtk-sharp.addin.xml

LIBS = \
	atk/atk-sharp \
	gdk/gdk-sharp \
	glade/glade-sharp \
	glib/glib-sharp \
	gtk/gtk-sharp \
	pango/pango-sharp

ASSEMBLIES = $(foreach lib, $(LIBS), $(lib).dll)
POLICY_FILES = $(foreach pv, $(POLICY_VERSION), $(foreach lib, $(LIBS), $(dir $(lib))policy.$(pv).$(notdir $(lib)).dll))
POLICY_CONFIGS = $(foreach pv, $(POLICY_VERSION), $(foreach lib, $(LIBS), $(dir $(lib))policy.$(pv).config))

FILES = $(ASSEMBLIES) $(POLICY_FILES) $(POLICY_CONFIGS)
GAC_FILES = $(ASSEMBLIES) $(POLICY_FILES)

all: $(GAC_FILES) $(ADDIN_FILE)

clean:
	rm -rf $(FILES) $(dir $(LIBS)) $(ADDIN_FILE) $(GTK_TARBALL) $(GTK_DIR) gconf files lib

$(GTK_TARBALL):
	wget http://go-mono.com/sources/gtk-sharp-2.0/$(GTK_TARBALL)
	rm -rf $(GTK_DIR)
	tar xvfj $(GTK_TARBALL)

$(GTK_DIR)/Makefile: $(GTK_TARBALL)
	cd gtk-sharp-$(GTK_VERSION) && \
	sed s/POLICY_VERSIONS="\(.*\)"/\POLICY_VERSIONS=\""$(POLICY_VERSION)"\"/ configure > configure.mod && \
	chmod +x configure.mod && \
	./configure.mod

build: $(GTK_DIR)/Makefile
	cd gtk-sharp-$(GTK_VERSION) && \
	make

$(GAC_FILES): build
	CURD=`pwd` && \
	cd $(dir $(GTK_DIR)/$@) && \
	gacutil -i $(notdir $@) -root $$CURD/lib
	
$(ADDIN_FILE): $(ADDIN_FILE).xsl
	echo "<files>"  > files
	echo "<targetversion>"$(TARGET_VERSION)"</targetversion>"  >> files
	echo "<gtkversion>"$(GTK_VERSION)"</gtkversion>"  >> files
	find lib -name *.dll -type f -printf "<dll>%p</dll>\n" >> files
	find lib -name *.config -type f -printf "<config>%p</config>\n" >> files
	echo "</files>" >> files
	mono-xmltool --transform $(ADDIN_FILE).xsl files $(ADDIN_FILE)

pack:
	mdtool setup p $(ADDIN_FILE)
