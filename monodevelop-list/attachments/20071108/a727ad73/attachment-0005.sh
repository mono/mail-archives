#!/bin/bash
#Author Surfzoid
#Contact : surfzoid@gmail.com
strWRAP="--wrap"
strCOMMAND="Cs-ObexFtp"
strVERSION="1.5"
strWIZARD="--wizard"
strPROG="Xdialog --title Setup-of-Cs-ObexFtp"
# --stdout $strWRAP"
TmpDir=~/tmp/mono-latest

#
#

function msgSTART()
	{
		msgHELLO=`$strPROG --backtitle "Welcome to Cs-ObexFtp setup v $strVERSION" --msgbox "Click Ok to start the installation" 10 50`
		case $? in
			0)
				getFILECONFIG;;
			255)
				msgBYE;;
		esac
	}

function getFILECONFIG()
	{
	  
		MonoVer=`( mono -V|grep vers|cut -d " " -f 5)`
		
		#msgCheckVers=`$strPROG --okcancel --backtitle "Checking the mono RT version" --msgbox "Detected version : "$MonoVer"\nI'm going to download and instal the latest version\nPlease click on OK to continue" 0 0`
		msgCheckVers=`$strPROG --backtitle "Checking the mono RT version" --wizard --yesno "Detected version : "$MonoVer"\nI'm going to download and instal the latest version\nYou need to have the root privileges to do it\nPlease click on NEXT to continue" --wizard 0 0`
		
		case $? in
			0)
			(rm -f -r $TmpDir ) | $strPROG  --infobox "Deleting previous tempory directory:\n\n" 8 70
				;;

			1|3)
				msgBYE;;
		esac
		
		mkdir $TmpDir	
		cd $TmpDir
		
		logfile=/tmp/logfile.$$
		wget -c -v -b http://mono.ximian.com/daily/mono-latest.tar.bz2 -o "$logfile"
		while [ ! "$(tail -2 $logfile|awk '{print $7}'|grep -o "^[0-9]\{1,2\}")" ];do
		sleep 1
		done
		(while [ "$(tail -2 $logfile|awk '{print $7}'|grep -o "^[0-9]\{1,2\}")" ];do
		tail -2 $logfile|awk '{print $7}'|grep -o "^[0-9]\{1,2\}"
		done) | $strPROG --gauge "Download of `basename http://mono.ximian.com/daily/mono-latest.tar.bz2` in progress..." 10 70;  
		rm -f $logfile
		
		cd $TmpDir/
		LOGFILE=/tmp/logbox.tmp.$$
		touch $LOGFILE
		Xdialog --title "Debug output of all commands" --logbox $LOGFILE 150 200 &
		echo "Untar everythings, wait............"  >>$LOGFILE
		tar -xf $TmpDir/mono-latest.tar.bz2
		echo "Finish to untar everythings, choice a installation dir of Mono RT"  >>$LOGFILE
		
		rm -f $TmpDir/mono-latest.tar.bz2
		LastMono=`ls`
		cd $LastMono
		DestDir="/usr"
		`$strPROG  --wizard --inputbox  "Enter the destination directory for Mono RT,\nyou can also add optional configure arguments, exemple /usr --enable-exemple=yes" 0 0  "./configure --prefix=/usr --enable-dependency-tracking --enable-nunit-tests --with-sigaltstack=yes --with-static_mono=yes --with-large-heap=yes --with-ikvm-native=yes --with-jit=yes --with-x --with-preview=yes --with-moonlight=yes" 2> /tmp/inputbox.tmp.$$`
				case $? in
			0)
				DestDir=`cat /tmp/inputbox.tmp.$$`
				`rm -f /tmp/inputbox.tmp.$$`;;
			1|3)
				msgBYE;;
		esac
		
		echo "Cleaning old compile"  >>$LOGFILE
		make clean |grep error>>$LOGFILE
		echo "Finish to clean"  >>$LOGFILE
		echo "Start to configure with :"  >>$LOGFILE
		echo "./configure --prefix=$DestDir"  >>$LOGFILE
		echo "wait...."  >>$LOGFILE
		echo "The destination dir is : "$DestDir>>$LOGFILE
		#./configure --prefix=$DestDir>>$LOGFILE
		`./configure --prefix=$DestDir --enable-dependency-tracking --enable-nunit-tests --with-sigaltstack=yes --with-static_mono=yes --with-large-heap=yes --with-ikvm-native=yes --with-jit=yes --with-x --with-preview=yes --with-moonlight=yes`>>$LOGFILE
		#|grep error>>$LOGFILE
		echo "Finish to configure"  >>$LOGFILE
		echo "Starting to make all,seems to be the coffee time, lol, wait........."  >>$LOGFILE
		make
		#|grep error>>$LOGFILE
		echo "Finish to Make"  >>$LOGFILE
		echo "Starting to make install, wait........."  >>$LOGFILE
		 su - root -c "make install"
		 #|grep error>>$LOGFILE
		echo "Installed, you can close me, bye bye"  >>$LOGFILE
		
		rm -f $LOGFILE
		rm -f $logfile
		rm -f /tmp/inputbox.tmp.$$
		exit 0;
	}
#
#	
function msgBYE()
	# Displays a "farewell" screen.  If you don't want it, comment out below.
	{
		echo "Canceled! Close me please">>$LOGFILE
		rm -f $LOGFILE
		rm -f $logfile
		rm -f /tmp/inputbox.tmp.$$
		`$strPROG --backtitle "Thank s @++" --msgbox "\nPlease click on OK to leave" 0 0`
		exit 0;
	}

strWIZARD="--wizard"
echo "No parameter passed... starting in Wizard mode by default..."
msgSTART