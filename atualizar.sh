#!/bin/bash

while read -r line; do
  echo -e "$line\n"
done <"logs.txt"
