#! /bin/sh
# Download the tarballs.
wget -c "http://www.cl.cam.ac.uk/Research/TSG/SMLNET/dist/smlnet.tar.gz"
wget -c "http://www.cl.cam.ac.uk/Research/TSG/SMLNET/dist/smlnetsrc.tar.gz"

#rm -rf smlnet/

#tar xzf smlnet.tar.gz
#tar xzf smlnetsrc.tar.gz

cd smlnet

# SML/NJ ml-yacc and ml-lex don't get along with DOS line endings on Unix.
dos2unix src/parse/pre/ml.grm
dos2unix src/parse/pre/ml.lex

# Unportable gunk.
sed -i s/0w1/OS.Process.failure/ bld/build.sml

# Fixup the configuration file.
sed -i s/mscorlib.dll/corlib.dll/             bin/config.smlnet
# Remove the trailing comma
sed -i s/System.ServiceProcess.dll,/System.ServiceProcess.dll/ bin/config.smlnet
sed -i s/System.XML.dll//                     bin/config.smlnet
sed -i s/System.Web.RegularExpressions.dll,// bin/config.smlnet

sml-cm < bld/build.sml > build.log

# Create driver script.
cat > bin/smlnet <<EOF
#! /bin/sh
SMLNETPATH=$PWD
export SMLNETPATH

exec sml @SMLload=\$SMLNETPATH/bin/smlnet.x86-linux
EOF

# Make it executable.
chmod +x bin/smlnet