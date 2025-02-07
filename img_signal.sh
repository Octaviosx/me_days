#!/bin/bash
#Copyright 2019-2021 Gustavo Santana
#(C) 2017-2019 Mirai Works LLC
#Disable cursor 
setterm -cursor off
sleep 2;

resolution=$(tvservice -s | grep -oP '[[:digit:]]{1,4}x[[:digit:]]{1,4} ')
a="1920x1080 "
b="1280x720 "
c="720x480 "
d="320x240 "

#Clean Screen?
#sudo sh -c “TERM=linux setterm -foreground black -clear >/dev/tty0”
#Well better if no. So keep it comented

TIMER="3";
TXSEC="$(($TIMER * 60))";

IMAGIPATH="/home/uslu/elements/imagenes-flotantes";

Current_day=$(date +%-A);

echo "$Current_day";

if [ $Current_day == Monday ]
then
   IMAGIPATH="/home/uslu/elements/imagenes-flotantes/01_Lunes/"
elif [ $Current_day == Tuesday ]
then
   IMAGIPATH="/home/uslu/elements/imagenes-flotantes/02_Martes/"
elif [ $Current_day == Wednesday ]
then
   IMAGIPATH="/home/uslu/elements/imagenes-flotantes/03_Miercoles/"
elif [ $Current_day == Thursday ]
then
   IMAGIPATH="/home/uslu/elements/imagenes-flotantes/04_Jueves/"
elif [ $Current_day == Friday ]
then
   IMAGIPATH="/home/uslu/elements/imagenes-flotantes/05_Viernes/"
elif [ $Current_day == Saturday ]
then
   IMAGIPATH="/home/uslu/elements/imagenes-flotantes/06_Sabado/"
elif [ $Current_day == Sunday ]
then
   IMAGIPATH="/home/uslu/elements/imagenes-flotantes/07_Domingo/"
fi

# Nombre de instancia para que no choque con la de uxmalstream
SERVICE="imagiplayer";

echo "$resolution"

if [ "$resolution" == "$a" ]
then
        boxed="--win 0,0,1920,1080";
elif [ "$resolution" == "$b" ]; 
then
        boxed="--win 0,0,1280,720";
elif [ "$resolution" == "$c" ]; 
then
        boxed="--win 23,37,695,443";
elif [ "$resolution" == "$d" ]; 
then
        exit;
fi
echo "$boxed"

#chose of folders

target_fix='/home/uslu/uxmalstream/streamer/uploads'
uxmal2_mgrtd='/home/uslu/uxmal_2.0/'

if [ -d "$uxmal2_mgrtd" ]; then
  echo "App migrada :S";
  target_fix='/home/uslu/uxmal_2.0/uploads'
fi


# infinite loop!
while true; do
        if ps ax | grep -v grep | grep $SERVICE > /dev/null
        then
        sleep 1;
else
        for entry in $IMAGIPATH/*
        do
        if [[ $Current_day != $(date +%-A) ]]
        then
        echo "dia incorrecto reiniciando servicio $Current_day no es $(date +%-A)" >> vflog_$(date +%Y_%m_%d).txt;
        sudo service ImgPlayer restart;
        fi
	echo "start $entry" >> log_$(date +%Y_%m_%d).txt;
        if [[ `lsof | grep $target_fix/parallelads/pl1/` ]]
        then
        sleep 40;
        echo "espera por L activa" >> log_$(date +%Y_%m_%d).txt;
        fi
        if [[ `lsof | grep $target_fix/ads/` ]]
        then
        sleep 40;
        echo "espera por anuncio con audio" >> log_$(date +%Y_%m_%d).txt;
        fi
	if [[ `lsof | grep /home/uslu/elements/Spots_sin_audio/` ]]
        then
        sleep 40;
        echo "espera por anuncio sin audio" >> log_$(date +%Y_%m_%d).txt;
        fi
        date >> log_$(date +%Y_%m_%d).txt;
#	clear;
        ( cmdpid="$BASHPID";
        (omxiv $boxed -t 45 -T blend -l 23 -k "$entry" >> log_$(date +%Y_%m_%d).txt) \
        & while ! bash /home/uslu/me_days/next_img.sh;
        do
               echo "Todo listo";
               #exit;
        done
        wait)
        date >> log_$(date +%Y_%m_%d).txt;
	echo "Stop $entry" >> log_$(date +%Y_%m_%d).txt;
        clear;
	/home/uslu/me_days/ssignage_sleep $TXSEC;
        echo "Lapso de tiempo entre anuncios $TXSEC segundos" >> log_$(date +%Y_%m_%d).txt;
        done
fi
done
