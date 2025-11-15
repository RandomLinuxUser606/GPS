#!/bin/bash

PACOTE="$(cat pacote.txt)"

wget http://192.168.15.63:9999/metadados/"$PACOTE"/libs.txt

while IFS= read -r line; do
  sudo wget http://192.168.15.63:9999/libs/$line.tar.xz
  tar xfv "$line".tar.xz "$line"
  sudo mv "$line" /usr/lib/
  sed -i "$ a $line" logs.txt
  echo "Instalado: $line"
done <libs.txt
rm libs.txt
