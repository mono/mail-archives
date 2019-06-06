#! /bin/sh
# Download the tarballs.
wget -c "http://www.cl.cam.ac.uk/Research/TSG/SMLNET/dist/smlnet.tar.gz"
wget -c "http://www.cl.cam.ac.uk/Research/TSG/SMLNET/dist/smlnetsrc.tar.gz"

rm -rf smlnet/

tar xzf smlnet.tar.gz
tar xzf smlnetsrc.tar.gz

cd smlnet

# SML/NJ ml-yacc and ml-lex don't get along with DOS line endings on Unix.
dos2unix src/parse/pre/ml.grm
dos2unix src/parse/pre/ml.lex

# Unportable gunk.
#sed -i s/0w1/OS.Process.failure/ bld/build.sml
perl -pi -e 's/0w1/OS.Process.failure/' bld/build.sml

# Fixup the configuration file.
#sed -i s/System.XML.dll/System.Xml.dll/        bin/config.smlnet
perl -pi -e 's/System.XML.dll/System.Xml.dll/' bin/config.smlnet

# XXX Mono doesn't seem to have this assembly yet
#sed -i s/System.Web.RegularExpressions.dll,// bin/config.smlnet

sml-cm < bld/build.sml > build.log

# Create driver script.
cat > bin/smlnet <<EOF
#! /bin/sh
SMLNETPATH=$PWD
export SMLNETPATH

exec sml @SMLload=\$SMLNETPATH/bin/smlnet.x86-linux "\$@"
EOF

# Make it executable.
chmod +x bin/smlnet

# Patch and recompile getsysdir.cs.
dos2unix src/clr/getsysdir.cs

patch src/clr/getsysdir.cs <<EOF
--- getsysdir.cs.orig	2003-11-16 13:29:59.000000000 +0100
+++ getsysdir.cs	2003-11-12 08:59:04.000000000 +0100
@@ -31,11 +31,10 @@
 //              }
 
                 // First method didn't work, so try System.Object instead
-                string path = typeof(object).Assembly.CodeBase;
-                if (!path.StartsWith("file://"))
-                   return 1;
-                path = path.Remove(0,8);
-                path = Directory.GetParent(path).ToString();
+                Uri uri = new Uri (typeof(object).Assembly.CodeBase);
+		if (!uri.IsFile)
+		   return 1;
+		String path = Directory.GetParent (uri.LocalPath).ToString ();
                 Console.Out.WriteLine(path);
                 return 0;
 	}
EOF

mcs src/clr/getsysdir.cs -out:bin/getsysdir.exe
