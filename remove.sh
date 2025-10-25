#!/bin/bash
#wget http://192.168.15.63:9999/lista.txt

# Declarando variaveis:
PACOTE="$(cat pacote.txt)"
sed -i '/'$PACOTE'/d' ./logs.txt

exit
