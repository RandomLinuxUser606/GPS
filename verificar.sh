#!/bin/bash
#wget http://192.168.15.63:9999/lista.txt

# Declarando variaveis:
PACOTE="$(cat pacote.txt)"

if grep -Fx "$PACOTE" lista.txt; then
  wget http://192.168.15.63:9999/pacotes/"$PACOTE"
  sudo chmod +x "$PACOTE"
  sudo mv "$PACOTE" /bin/
#  ./libs.sh
else
  echo "Pacote nao encontrado"
fi
sed -i "$ a $PACOTE" logs.txt
exit
