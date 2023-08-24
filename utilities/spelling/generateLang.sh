#!/bin/bash

TARGET=~/.config/nvim/dicts/new.dict
LANG=$1

aspell -d $LANG dump master | aspell -l $LANG expand >$TARGET >>/dev/null

if [ $(wc -l <"${TARGET}") -eq 0 ]; then
  echo "${LANG} is not avalible, try installing using packages:"
  echo
  echo "aspell aspell-${LANG}"
else
  echo "Check ${TARGET}"
fi
