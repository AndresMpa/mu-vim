#!/bin/bash

while read -r line; do
  echo "snippet ${line%%:*} \"${line##*:}\""
  echo -e "\t${line%%:*}"
  echo
done < rawData.txt > data.txt
