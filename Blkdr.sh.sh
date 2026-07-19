#!/bin/bash


# Ver el desktop

function DESKU(){
    echo `env | grep "DESKTOP_SESSION=" | cut -d "=" -f2`
}

# La funcion cat_wm es un listado de los Windown Manager 
# con los que trabaja es script

function cat_wm(){
	echo "fluxbox
	openbox
	blackbox
	xfwm4
	metacity
	kwin
	fvwm
	enlightenment
	icewm
	wmaker
	compiz
	pekwm
	awesome
	dwm
    marco"
}

# La funcion WMSU busca entre los procesos que Windown Manager tenemos
# corriendo.

function WMSU(){
	for WMS in `cat_wm`; do
		GV=`ps -A | grep -i $WMS | wc -l`
		if [ $GV = 1 ]; then
			echo $WMS
		fi
	
	done
}

# Una vez que la funcion WMSU encontro nuestro Window Manager, la
# funcion WMST busca que tema tenemos aplicado a nuestro Window Manager.

function WMST()
{ 
	if [ `WMSU` = fluxbox ]; then
		THEME=`grep -i session.styleFile ~/.fluxbox/init | cut -d '/' -f7`
		echo $THEME
	
    elif [ `WMSU` = openbox ]; then
		THEME2=`grep -i "<name>" ~/.config/openbox/rc.xml | head -n1 | cut -d '>' -f2 | cut -d '<' -f1`
		echo $THEME2
	
    elif [ `WMSU` = blackbox ]; then
		THEME3=`grep -i session.styleFile ~/.blackboxrc | cut -d '/' -f6`
		echo $THEME3
	
    elif [ `WMSU` = xfwm4 ]; then
		THEME4=`grep -i theme ~/.config/xfce4/mcs_setting/xfwm4.xml | cut -d '=' -f4 | cut -d '"' -f2`
		echo $THEME4
	
    elif [ `WMSU` = metacity ]; then
		THEME5=`gconftool-2 -g /apps/metacity/general/theme`
		echo $THEME5
	
    elif [ `WMSU` = kwin ]; then
		THEME6=`grep -i PluginLib ~/.kde4/share/config/kwinrc | cut -d '_' -f2`
		echo $THEME6
	
    elif [ `WMSU` = fvwm ]; then
		echo "No disponible"
	
    elif [ `WMSU` = enlightenment ]; then
		THEME8=``
		echo $THEME8
	
    elif [ `WMSU` = icewm ]; then
		THEME9=`grep -i Theme ~/.icewm/theme | cut -d '=' -f2 | cut -d '.' -f1`
		echo $THEME9
	
    elif [ `WMSU` = wmaker ]; then
		echo "No disponible"

    elif [ `WMSU` = marco ]; then
		echo "No disponible por el momento"

    else
        echo "Tema no encontrado"
	fi
	
}

echo ""
echo -e "\e[1;42m << "`uname -n`" >> \e[0m"
echo "Usuario: " `whoami`
echo "Distro: " `cat /etc/issue.net`
echo "Desktop: " `DESKU`
echo "Window Manager: " `WMSU`
echo "Window Manager Tema: " `WMST`
