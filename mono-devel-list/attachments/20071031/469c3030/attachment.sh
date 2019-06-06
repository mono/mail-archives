#!/bin/bash
#Author Surfzoid
#Contact : surfzoid@gmail.com
strWRAP="--wrap"
strCOMMAND="Cs-ObexFtp"
strVERSION="1.5"
strWIZARD="--wizard"
strPROG="Xdialog --title 'Setup-of-Cs-ObexFtp'"
# --stdout $strWRAP"
TmpDir=~/tmp/mono-latest

#
#

function msgSTART()
	{
		msgHELLO=`$strPROG --backtitle "Welcome to Cs-ObexFtp setup v $strVERSION" --msgbox "Click Ok to start the installation" 0 0`
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
			(rm -f -r $TmpDir)|
		$strPROG  --gauge "Deleting previous tempory directory:\n\n" 0 0
			mkdir $TmpDir	
		#wget -P ~/tmp/mono-latest http://mono.ximian.com/daily/mono-latest.tar.bz2
		(
		echo `wget -c -P $TmpDir/ http://mono.ximian.com/daily/mono-latest.tar.bz2 ; sleep 1`
		)|
		$strPROG  --gauge "Downloading the last Mono RT:\n\n" 0 0
			   
		cd $TmpDir/
		LOGFILE=/tmp/logbox.tmp.$$
		#( tar -xf $TmpDir/mono-latest.tar.bz2 ; sleep 1 ) | `$strPROG  --gauge "UnTar the downloaded archive:\n\n" 0 0`
		touch $LOGFILE
		Xdialog --title "Debug output of all commands" --logbox $LOGFILE 0 0 &
		echo "Untar everythings, wait............"  >>$LOGFILE
		tar -xf $TmpDir/mono-latest.tar.bz2
		echo "Finish to untar everythings, choice a installation dir of Mono RT"  >>$LOGFILE
		
		#cd mono-latest
		rm -f $TmpDir/mono-latest.tar.bz2
		LastMono=`ls`
		cd $LastMono
		DestDir="/usr"
		`$strPROG  --wizard --inputbox  'Enter the destination directory for Mono RT when untar has finish,\nyou can also add optional configure arguments, exemple /usr --enable-exemple=yes' 0 0  "/usr" 2> /tmp/inputbox.tmp.$$`
				case $? in
			0)
				$DestDir=`cat /tmp/inputbox.tmp.$$`
				echo $DestDir;;
			255)
				msgBYE;;
		esac
		
		echo "Cleaning old compile"  >>$LOGFILE
		make clean |grep error>>$LOGFILE
		echo "Finish to clean"  >>$LOGFILE
		echo "Start to configure with :"  >>$LOGFILE
		echo "./configure --prefix=$DestDir"  >>$LOGFILE
		echo "wait...."  >>$LOGFILE
		#`(./configure --prefix=$DestDir ; sleep 1)|$strPROG --gauge 'configure Mono RT:' 0 0`
		#`(  make ; sleep 1 ) | $strPROG  --gauge 'make Mono RT:\n\n' 0 0`
		#`( make install ; sleep 1 ) | $strPROG  --gauge 'make install of Mono RT:\n\n' 0 0`
		#touch $LOGFILE
		#Xdialog --title "LOGBOX" --time-stamp "" --logbox $LOGFILE 0 0 &
		echo "The destination dir is : "$DestDir>>$LOGFILE
		./configure --prefix=$DestDir |grep error>>$LOGFILE
		echo "Finish to configure"  >>$LOGFILE
		echo "Starting to make all, wait........."  >>$LOGFILE
		make |grep error>>$LOGFILE
		echo "Finish to Make"  >>$LOGFILE
		echo "Starting to make install, wait........."  >>$LOGFILE
		 `make install `|grep error>>$LOGFILE
		echo "Installed, you can close me, bye bye"  >>$LOGFILE
		
		rm -f $LOGFILE		
		exit 0;;
			255)
				msgBYE;;
		esac
	}
#
#	
function msgBYE()
	# Displays a "farewell" screen.  If you don't want it, comment out below.
	{
		`$strPROG --backtitle "Thank s @++" --msgbox "\nPlease click on OK to leave" 0 0`
		exit 0;
	}

strWIZARD="--wizard"
echo "No parameter passed... starting in Wizard mode by default..."
msgSTART