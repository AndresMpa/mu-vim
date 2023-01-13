#!/bin/bash

while read -r line; do
  echo "snippet ${line%%:*} \"${line##*:}\""
  echo "  ${line%%:*}"
  echo
  echo
done < rawData.txt > data.txt
