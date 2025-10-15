# wget http://192.168.15.63:9999/lista.txt
PACOTE="$(cat pacote.txt)"

if grep -Fxq "$PACOTE" lista.txt; then
  wget http://192.168.15.63:9999/pacotes/"$PACOTE"
  chmod +x "$PACOTE"
else
  echo "Pacote nao encontrado"
fi
