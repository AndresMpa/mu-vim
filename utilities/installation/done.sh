#!/bin/bash

installation_success() {
  TITLE="Installation is done"
  INFO="It seems that everything is alright, to complete this process enter nvim then let nvim \
install some extra features.

If you get an issue try checking mu-vim wiki: https://github.com/AndresMpa/mu-vim/wiki"

  COLUMNS=$(tput cols)
  RIGHT_SHIFT=$(((${#TITLE} + $COLUMNS) / 2))

  printf "%*s\n\n\n" $RIGHT_SHIFT "$TITLE"

  printf "%*s\n" $RIGHT_SHIFT "$INFO"
}

installation_wrong() {
  TITLE="Something went wrong"
  INFO="Try again, if you see this error again, please submit an issue on mu-vim project \
https://github.com/AndresMpa/mu-vim/issues"

  COLUMNS=$(tput cols)
  RIGHT_SHIFT=$(((${#TITLE} + $COLUMNS) / 2))

  printf "%*s\n\n\n" $RIGHT_SHIFT "$TITLE"

  printf "%*s\n" $RIGHT_SHIFT "$INFO"
}
