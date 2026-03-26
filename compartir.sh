#!/bin/bash 

NOMBRE=$(hostname -I)

echo "Ip: $NOMBRE"

python3.11 -m http.server 8888
