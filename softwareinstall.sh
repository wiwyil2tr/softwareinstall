#!/bin/bash
# Prep 1 - Are we  "root" ?
 if [ $UID -eq 0 ] ; then
      echo "Please DO NOT run as root!"
      exit 0
      else
      echo "OK"
  fi
# Get installation permission
  zenity --width=600 --no-wrap --question --title="softwareinstall" --text="This program will add archlinuxcn repository to /etc/pacman.conf and install yay at first.\n Are you sure you want to install?\n\n***Click No to cancel or Yes to continue***."
  if [ $? == 0 ] ; then
      echo "installation accepted by $USER: `date`." >> $LOG
      else
      echo "installation refused by $USER: `date`." >> $LOG
      clear
      exit 1
  fi  

# Prep 2 - prepare pacman and update system
    sudo pacman -Syy
echo "Do you want to update your system (y/n)"
read respuesta
respuesta=$respuesta"_"
# Idiomas y localizaciones
if [ "$respuesta" == "y_" ]
    then
    sudo pacman -Syu
	fi
#prep 3 - install yay
 if [ $OFF_CAMPUS = "N" ] ; then
      echo "Checking network connection to github"
      sleep 1                                                                                                          ping -c 2 github.com
      if [ $? == 0 ] ; then 
          echo "OK: `date`." >> $LOG
          else
          echo "failed: `date`." >> $LOG
          zenity --error --title="softwareinstall" --text="Network error.\n\nPlease check network connection and proxy settings.\n\nAborting installation."
      exit 1
      fi
      else
      echo "OK" >> $LOG
  fi

 git clone https://github.com/wiwyil2tr/pacmanconf
 sudo cp pacmanconf/pacman.conf /etc
 sudo pacman -Sy archlinuxcn-keyring
 sudo pacman -S yay
#Start installation
clear
 # Get installation permission
zenity --width=600 --no-wrap --question --title="softwareinstall" --text="The following softwares will be installed:\n libreoffice, chrome, thunderbird, vim, mplayer, vlc, mpv, gimp, kdeconnect, virtualbox, qq, weixin(wine), tldr, ffmpeg, unoconv\nAre you sure you want to install?\n\n***Click No to cancel or Yes to continue***."
    if [ $? == 0 ] ; then
        echo "installation accepted by $USER: `date`." >> $LOG
		sudo pacman -S libreoffice-fresh thunderbird vim mplayer vlc mpv gimp kdeconnect virtualbox ffmpeg unoconv
		yay -S deepin-wine-wechat linuxqq google-chrome
        else
        echo "installation refused by $USER: `date`." >> $LOG
        clear
        exit 1
    fi 
zenity --info \
 --width=450 \
 --no-wrap \
 --title="softwareinstall" \
 --text="Installation Completed!\n\n"
 
 exit 0                 
