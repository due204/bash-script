#!/bin/bash
#===============================================================================
#
#          FILE: set_volumen2.sh
# 
#         USAGE: ./set_volumen2.sh 
# 
#   DESCRIPTION: Este script actúa como un limitador de volumen.
#                Monitorea eventos de audio del sistema en tiempo real usando pactl
#                   y evita que el volumen supere un valor máximo definido (SET).
#                Si el volumen excede ese límite, lo ajusta automáticamente.
#                Funciona de forma eficiente (sin bucles activos) reaccionando solo a cambios.
# 
#       OPTIONS: None
#  REQUIREMENTS: amixer, pactl
#          BUGS: ???
#         NOTES: Ninguna ^^
#        AUTHOR: Due204
#  ORGANIZATION: ---
#       CREATED: 26/03/22 15:06:01 ART
#      REVISION: 0.2
#===============================================================================

# Nivel de volumn maximo
SET=30

# Obtengo el nivel de volumn actual
get_volume() {

    amixer sget Master | grep -o '[0-9]\+%' | head -n1 | tr -d '%'
}

# Chequeo el nivel
check_volume() {

    # Obtengo el nivel actual y lo guardo en $NIVEL
    NIVEL=$(get_volume)

    # Valido que sea número
    if ! [[ "$NIVEL" =~ ^[0-9]+$ ]]; then
        return
    fi
    
    # Seteo el nivel
    if [ "$NIVEL" -gt "$SET" ]; then
        amixer sset Master "$SET%" > /dev/null
        echo "Nivel de volumen limitado a $SET%"
    fi
}

# Chequeo inicial
check_volume

# Escucho eventos y disparo el loop
pactl subscribe | while read -r _; do
    check_volume
done
