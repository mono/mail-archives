#!/bin/bash
#
strWRAP="--wrap"
strCOMMAND="Cs-ObexFtp "
strVERSION="1.5"
strWIZARD="--wizard"
strPROG="Xdialog --title "Setup-of-Cs-ObexFtp" --stdout $strWRAP"
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
		msgCheckVers=`$strPROG --backtitle "Checking the mono RT version" --yesno "Detected version : "$MonoVer"\nI'm going to download and instal the latest version\nPlease click on YES to continue" 0 0`
				case $? in
			0)
			rm -f -r ~/tmp/mono-latest/
			mkdir ~/tmp/mono-latest	
		#wget -P ~/tmp/mono-latest http://mono.ximian.com/daily/mono-latest.tar.bz2
		( wget  -q -c -P ~/tmp/mono-latest http://mono.ximian.com/daily/mono-latest.tar.bz2 ; sleep 1 ) | `$strPROG  --progress "Downloading the last Mono RT:\n\n" 0 0`
			   
		cd ~/tmp/mono-latest
		( tar -xf ./mono-latest.tar.bz2 ; sleep 1 ) | `$strPROG  --progress "UnTar the downloaded archive:\n\n" 0 0 1800`
		
		#cd mono-latest
		rm -f ./mono-latest.tar.bz2
		LastMono=`ls`
		cd $LastMono
		DestDir=`$strPROG  --inputbox "Enter the destination directory for Mono RT" 0 0  "/usr"`
				case $? in
			0)
				echo $DestDir;;
			255)
				DestDir="/usr";;
		esac
		`( make clean ; sleep 1 ) | $strPROG  --progress "Cleaning:\n\n" 0 0 1800`
		`( ./configure --prefix=$DestDir ; sleep 1 ) | $strPROG  --progress " configure Mono RT:\n\n" 0 0 1800`
		`(  make ; sleep 1 ) | $strPROG  --progress " make Mono RT:\n\n" 0 0 1800`
		`( su root -c make install ; sleep 1 ) | $strPROG  --progress "make install of Mono RT:\n\n" 0 0 1800`
				
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