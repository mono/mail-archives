Index: PyBinding/PyBinding.csproj
===================================================================
--- PyBinding/PyBinding.csproj	(revision 140015)
+++ PyBinding/PyBinding.csproj	(working copy)
@@ -190,6 +190,9 @@
       <LogicalName>BasicScriptPySourceFile.xft.xml</LogicalName>
     </EmbeddedResource>
     <EmbeddedResource Include="PyBinding.addin.xml" />
+    <EmbeddedResource Include="Resources\EmptyDjangoProject.xpt.xml">
+      <LogicalName>EmptyDjangoProject.xpt.xml</LogicalName>
+    </EmbeddedResource>
   </ItemGroup>
   <Import Project="$(MSBuildBinPath)\Microsoft.CSharp.targets" />
   <ProjectExtensions>
Index: PyBinding/PyBinding.addin.xml
===================================================================
--- PyBinding/PyBinding.addin.xml	(revision 140015)
+++ PyBinding/PyBinding.addin.xml	(working copy)
@@ -47,6 +47,9 @@
     	<ProjectTemplate
     		id = "EmptyPyProject"
     		resource = "EmptyPyProject.xpt.xml"/>
+    	<ProjectTemplate
+    		id = "EmptyDjangoPyProject"
+    		resource = "EmptyDjangoProject.xpt.xml"/>
     </Extension>
     
     <Extension path = "/MonoDevelop/Core/MimeTypes">
Index: PyBinding/gtk-gui/gui.stetic
===================================================================
--- PyBinding/gtk-gui/gui.stetic	(revision 140015)
+++ PyBinding/gtk-gui/gui.stetic	(working copy)
@@ -5,21 +5,24 @@
     <target-gtk-version>2.8</target-gtk-version>
   </configuration>
   <import>
-    <widget-library name="MonoDevelop.Gettext, Version=1.0.0.0, Culture=neutral" />
-    <widget-library name="MonoDevelop.Ide, Version=1.9.1.0, Culture=neutral" />
-    <widget-library name="MonoDevelop.Projects.Gui, Version=1.9.1.0, Culture=neutral" />
-    <widget-library name="MonoDevelop.Components, Version=1.9.1.0, Culture=neutral" />
-    <widget-library name="MonoDevelop.GtkCore, Version=0.0.0.0, Culture=neutral" />
-    <widget-library name="MonoDevelop.Core.Gui, Version=1.9.1.0, Culture=neutral" />
     <widget-library name="Mono.TextEditor, Version=1.0.0.0, Culture=neutral" />
-    <widget-library name="MonoDevelop.VersionControl, Version=0.0.0.0, Culture=neutral" />
-    <widget-library name="MonoDevelop.XmlEditor, Version=0.6.0.0, Culture=neutral" />
-    <widget-library name="MonoDevelop.Deployment, Version=1.0.0.0, Culture=neutral" />
-    <widget-library name="MonoDevelop.Deployment.Linux, Version=1.0.0.0, Culture=neutral" />
-    <widget-library name="MonoDevelop.VBNetBinding, Version=1.0.1.1649, Culture=neutral" />
-    <widget-library name="MonoDevelop.CBinding, Version=0.0.0.0, Culture=neutral" />
-    <widget-library name="MonoDevelop.CSharpBinding, Version=0.0.0.0, Culture=neutral" />
-    <widget-library name="MonoDevelop.Autotools, Version=0.1.0.0, Culture=neutral" />
+    <widget-library name="MonoDevelop.Gettext, Version=2.0.0.0, Culture=neutral" />
+    <widget-library name="MonoDevelop.Ide, Version=2.0.0.0, Culture=neutral" />
+    <widget-library name="MonoDevelop.Projects.Gui, Version=2.0.0.0, Culture=neutral" />
+    <widget-library name="MonoDevelop.Components, Version=2.0.0.0, Culture=neutral" />
+    <widget-library name="MonoDevelop.GtkCore, Version=2.0.0.0, Culture=neutral" />
+    <widget-library name="MonoDevelop.DesignerSupport, Version=2.0.0.0, Culture=neutral" />
+    <widget-library name="MonoDevelop.Core.Gui, Version=2.0.0.0, Culture=neutral" />
+    <widget-library name="MonoDevelop.VersionControl, Version=2.0.0.0, Culture=neutral" />
+    <widget-library name="MonoDevelop.NUnit, Version=2.0.0.0, Culture=neutral" />
+    <widget-library name="MonoDevelop.XmlEditor, Version=2.0.0.0, Culture=neutral" />
+    <widget-library name="MonoDevelop.AspNet, Version=2.0.0.0, Culture=neutral" />
+    <widget-library name="MonoDevelop.Deployment, Version=2.0.0.0, Culture=neutral" />
+    <widget-library name="MonoDevelop.Deployment.Linux, Version=2.0.0.0, Culture=neutral" />
+    <widget-library name="MonoDevelop.VBNetBinding, Version=2.0.0.0, Culture=neutral" />
+    <widget-library name="MonoDevelop.CBinding, Version=2.0.0.0, Culture=neutral" />
+    <widget-library name="MonoDevelop.CSharpBinding, Version=2.0.0.0, Culture=neutral" />
+    <widget-library name="MonoDevelop.Autotools, Version=2.0.0.0, Culture=neutral" />
     <widget-library name="../../build/PyBinding.dll" internal="true" />
   </import>
   <widget class="Gtk.Bin" id="PyBinding.Gui.PythonOptionsWidget" design-size="491 370">
Index: PyBinding/Resources/EmptyDjangoProject.xpt.xml
===================================================================
--- PyBinding/Resources/EmptyDjangoProject.xpt.xml	(revision 0)
+++ PyBinding/Resources/EmptyDjangoProject.xpt.xml	(revision 0)
@@ -0,0 +1,140 @@
+<?xml version="1.0"?>
+<Template
+    originator   = "John Tindell" 
+    created      = "2009/08/16"
+    lastModified = "2009/08/16">
+
+    <!-- Template Header -->
+    <TemplateConfiguration>
+        <_Name>Empty Django Project</_Name>
+        <_Category>Python</_Category>
+        <Icon>md-project|res:py-icon-32.png</Icon>
+        <LanguageName>Python</LanguageName>
+        <_Description>Creates an empty django solution.</_Description>
+    </TemplateConfiguration>
+
+    <!-- Template Content -->
+    <Combine name = "${ProjectName}" directory = ".">
+        <Project name = "${ProjectName}" directory = "." type = "Python">
+        	<Files>
+        		<File name="__init__.py" AddStandardHeader="False"></File>
+        		<File name="manage.py" AddStandardHeader="True">
+        			<![CDATA[
+#!/usr/bin/env python
+from django.core.management import execute_manager
+try:
+    import settings # Assumed to be in the same directory.
+except ImportError:
+    import sys
+    sys.stderr.write("Error: Can't find the file 'settings.py' in the directory containing %r. It appears you've customized things.\nYou'll have to run django-admin.py, passing it your settings module.\n(If the file settings.py does indeed exist, it's causing an ImportError somehow.)\n" % __file__)
+    sys.exit(1)
+
+if __name__ == "__main__":
+    execute_manager(settings)]]>
+        		</File>
+        			
+        		<File name="settings.py" AddStandardHeader="True">
+        			<![CDATA[
+# Django settings for ${ProjectName} project.
+
+DEBUG = True
+TEMPLATE_DEBUG = DEBUG
+
+ADMINS = (
+    # ('Your Name', 'your_email@domain.com'),
+)
+
+MANAGERS = ADMINS
+
+DATABASE_ENGINE = ''           # 'postgresql_psycopg2', 'postgresql', 'mysql', 'sqlite3' or 'oracle'.
+DATABASE_NAME = ''             # Or path to database file if using sqlite3.
+DATABASE_USER = ''             # Not used with sqlite3.
+DATABASE_PASSWORD = ''         # Not used with sqlite3.
+DATABASE_HOST = ''             # Set to empty string for localhost. Not used with sqlite3.
+DATABASE_PORT = ''             # Set to empty string for default. Not used with sqlite3.
+
+# Local time zone for this installation. Choices can be found here:
+# http://en.wikipedia.org/wiki/List_of_tz_zones_by_name
+# although not all choices may be available on all operating systems.
+# If running in a Windows environment this must be set to the same as your
+# system time zone.
+TIME_ZONE = 'America/Chicago'
+
+# Language code for this installation. All choices can be found here:
+# http://www.i18nguy.com/unicode/language-identifiers.html
+LANGUAGE_CODE = 'en-us'
+
+SITE_ID = 1
+
+# If you set this to False, Django will make some optimizations so as not
+# to load the internationalization machinery.
+USE_I18N = True
+
+# Absolute path to the directory that holds media.
+# Example: "/home/media/media.lawrence.com/"
+MEDIA_ROOT = ''
+
+# URL that handles the media served from MEDIA_ROOT. Make sure to use a
+# trailing slash if there is a path component (optional in other cases).
+# Examples: "http://media.lawrence.com", "http://example.com/media/"
+MEDIA_URL = ''
+
+# URL prefix for admin media -- CSS, JavaScript and images. Make sure to use a
+# trailing slash.
+# Examples: "http://foo.com/media/", "/media/".
+ADMIN_MEDIA_PREFIX = '/media/'
+
+# Make this unique, and don't share it with anybody.
+SECRET_KEY = 'iqd&3-gfyu6^dodgo7q&^&%-ba9^h3xge^r5ewn#)$igm=bzr5'
+
+# List of callables that know how to import templates from various sources.
+TEMPLATE_LOADERS = (
+    'django.template.loaders.filesystem.load_template_source',
+    'django.template.loaders.app_directories.load_template_source',
+#     'django.template.loaders.eggs.load_template_source',
+)
+
+MIDDLEWARE_CLASSES = (
+    'django.middleware.common.CommonMiddleware',
+    'django.contrib.sessions.middleware.SessionMiddleware',
+    'django.contrib.auth.middleware.AuthenticationMiddleware',
+)
+
+ROOT_URLCONF = '${ProjectName}.urls'
+
+TEMPLATE_DIRS = (
+    # Put strings here, like "/home/html/django_templates" or "C:/www/django/templates".
+    # Always use forward slashes, even on Windows.
+    # Don't forget to use absolute paths, not relative paths.
+)
+
+INSTALLED_APPS = (
+    'django.contrib.auth',
+    'django.contrib.contenttypes',
+    'django.contrib.sessions',
+    'django.contrib.sites',
+)]]>
+        		</File>
+        		<File name="urls.py" AddStandardHeader="True">
+        			<![CDATA[from django.conf.urls.defaults import *
+
+# Uncomment the next two lines to enable the admin:
+# from django.contrib import admin
+# admin.autodiscover()
+
+urlpatterns = patterns('',
+    # Example:
+    # (r'^${ProjectName}/', include('${ProjectName}.foo.urls')),
+
+    # Uncomment the admin/doc line below and add 'django.contrib.admindocs' 
+    # to INSTALLED_APPS to enable admin documentation:
+    # (r'^admin/doc/', include('django.contrib.admindocs.urls')),
+
+    # Uncomment the next line to enable the admin:
+    # (r'^admin/(.*)', admin.site.root),
+)]]>
+        		</File>
+        	</Files>
+        </Project>
+    </Combine>
+</Template>
Index: PyBinding/Makefile
===================================================================
--- PyBinding/Makefile	(revision 140015)
+++ PyBinding/Makefile	(working copy)
@@ -99,6 +99,7 @@
 	PyBinding.addin.xml \
 	Resources/BasicScriptPySourceFile.xft.xml \
 	Resources/completion.py \
+	Resources/EmptyDjangoProject.xpt.xml \
 	Resources/EmptyPyProject.xpt.xml \
 	Resources/EmptyPySourceFile.xft.xml \
 	Resources/py-icon-32.png \
Index: ChangeLog
===================================================================
--- ChangeLog	(revision 140015)
+++ ChangeLog	(working copy)
@@ -1,3 +1,7 @@
+2009-08-17 John Tindell <john@yeticode.co.uk>
+
+	* Resources/DjangoProject.xpt.xml: template that creates same files as "django-admin startproject ${projectname}"
+
 2009-06-17  Lluis Sanchez Gual  <lluis@novell.com>
 
 	* PyBinding.sln: Remove obsolete extension.
