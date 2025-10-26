#!/bin/bash

PACOTE="$(cat pacote.txt)"

wget http://192.168.15.63:9999/metadados/"$PACOTE"/libs.txt

while IFS= read -r line; do

  echo "Instalado: $line"
  wget -P /usr/lib/ http://192.168.15.63:9999/libs/$line
  sed -i "$ a $line" logs.txt
done <libs.txt
rm libs.txt
