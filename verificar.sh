#!/bin/bash

# Declarando variaveis:
PACOTE="$(cat pacote.txt)"

if grep -Fx "$PACOTE" lista.txt; then
  wget http://192.168.15.63:9999/pacotes/"$PACOTE".tar.xz
  tar xfv "$PACOTE".tar.xz "$PACOTE"
  rm "$PACOTE".tar.xz
  sudo chmod +x "$PACOTE"
  sudo mv "$PACOTE" /usr/bin/
  sed -i "$ a $PACOTE" logs.txt
  ./libs.sh
else
  echo "Pacote nao encontrado"
fi
exit
