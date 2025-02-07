#!/bin/bash
#Copyright 2021 Gustavo Santana && Octavio Solis
#(C) Mirai Works LLC
#tput setab [1-7] Set the background colour using ANSI escape
#tput setaf [1-7] Set the foreground colour using ANSI escape
black=`tput setaf 0`
red=`tput setaf 1`
green=`tput setaf 2`
white=`tput setaf 7`
bg_black=`tput setab 0`
bg_red=`tput setab 1`
bg_green=`tput setab 2`
bg_white=`tput setab 7`
ng=`tput bold`
reset=`tput sgr0`
#echo "${red}red text ${green}green text${reset}"

sleep 1;
SERVICE="melibs_installer_V3.1";
echo "${red}${bg_white}${ng}Comenzando instalacion...${reset}";
cd /home/uslu/;

echo "Parchando Modulos...";
  sudo cp /home/uslu/AdsSync/sync.cfg /home/uslu/backup_down/sync.cfg
  sudo service AdsPlayer stop;
  sudo service ImgPlayer stop;
  echo "Parchando Flotantes (Videos)...";
  sudo service AdsPlayer stop;
  sudo rm -rf /home/uslu/adsplayer;
  sudo rm /etc/init.d/AdsPlayer;
  sudo cp /home/uslu/me_days/AdsPlayer /etc/init.d/AdsPlayer;
  sudo chmod +x /etc/init.d/AdsPlayer;
  sudo update-rc.d AdsPlayer defaults;
  sudo systemctl enable AdsPlayer;
  sudo service AdsPlayer start;
  cd /home/uslu/;
  sleep 1;
  echo "Instalando Flotantes (Imagenes)...";
  sudo apt-get install libjpeg-dev
  cd /home/uslu/me_days/sauce/omxiv/
  make ilclient
  make
  sudo make install
  sleep 2;
  cd
  sudo cp /home/uslu/me_days/ImgPlayer /etc/init.d/ImgPlayer;
  sudo chmod +x /etc/init.d/ImgPlayer;
  sudo update-rc.d ImgPlayer defaults;
  sudo systemctl enable ImgPlayer;
  sudo service ImgPlayer start;
  cd /home/uslu/;
  sleep 1;
  echo "Actualizando sincronizador de anuncios...";
  mkdir /home/uslu/me_days/backups
#  sudo cp /home/uslu/AdsSync/sync.cfg /home/uslu/melibs/backups/sync.cfg;
#  cd /home/uslu/AdsSync/;
#  git checkout .;
#  git pull;
#  sudo cp /home/uslu/melibs/backups/sync.cfg /home/uslu/AdsSync/sync.cfg;
  cd /home/uslu/
  sudo rm -rf AdsSync
  git clone https://github.com/GustavYoung/AdsSync.git
  sudo cp /home/uslu/backup_down/sync.cfg /home/uslu/AdsSync/sync.cfg
  sleep 1;
  chmod +x /home/uslu/me_days/ssignage_sleep;
  chmod +x /home/uslu/me_days/ssimg_sleep;
# rm -rf /home/uslu/melibs/backups
  sudo rm /home/uslu/AdsSync/updatelogs/*
# Crear carpetas de los dias 
  cd /home/uslu/elements/imagenes-flotantes
  sudo mkdir 01_Lunes
  sudo mkdir 02_Martes
  sudo mkdir 03_Miercoles
  sudo mkdir 04_Jueves
  sudo mkdir 05_Viernes
  sudo mkdir 06_Sabado
  sudo mkdir 07_Domingo
