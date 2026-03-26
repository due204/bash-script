#!/bin/bash
#===============================================================================
#
#          FILE: apagar.sh
# 
#         USAGE: ./apagar.sh 
# 
#   DESCRIPTION: Apagar el monitor despues de un tiempo,
#         en el momento o evita que el monitor se apague.
# 
#       OPTIONS: None
#  REQUIREMENTS: Zenity
#          BUGS: ???
#         NOTES: Ninguna ^^
#        AUTHOR: Due204
#  ORGANIZATION: ---
#       CREATED: 25/03/12 20:57:01 ART
#      REVISION: 0.3
#===============================================================================


function apagar()
{
    xset dpms force off
}

function bloquear()
{
    xset dpms 0 0 0
    xset s reset
    xset s off
}


APA=`zenity --window-icon="/usr/share/icons/Faenza/actions/48/gtk-info.png" \
    --width=240 --height=250 --title="Apagar el Monitor" --list \
       --column=Opciones: --text "Elige una opcion" \
          "Apagar ahora" \
        "Apagar despues de un tiempo" \
        "Evitar el apagado del monitor" | wc -m`

if [ $APA = 13 ]; then
    sleep 2 && apagar

elif [ $APA = 28 ]; then
    TEM=`zenity --entry 
        --window-icon="/usr/share/icons/Faenza/actions/48/gtk-info.png" \
            --title="Apagar el monitor" \
        --text="Introduzca el tiempo:" \
        --entry-text "tiempo en segundos"`
        if [ -z $TEM ]; then 
            exit
        else
            sleep $TEM && apagar
        fi
elif [ $APA = 30 ]; then
    bloquear
    zenity --info --title="Pantalla Bloqueada" \
        --text="Esto evitara que su monitor se apage." &
else
    exit
fi


# Final del camino. 
