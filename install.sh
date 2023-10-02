#!/bin/bash

source ./utilities/installation/installer.sh
source ./utilities/installation/greeter.sh
source ./utilities/installation/done.sh
source ./utilities/installation/util.sh

PREVIOUS=~/.config/previous-mu-vim/
INSTALATION_DIR=~/.config/nvim
FAIL=0

# Custom dirs functionality
echo "Are you using a custom configuration directory? (Default is ~/.config)[y/n]: "
read CUSTOM_DIR

if [ $CUSTOM_DIR == "y" ]; then
  echo "Write your custom directory path: "
  read INSTALATION_DIR
fi

{
  greeter
  sleep 5s
} || {
  echo "Something when wrong while greeting" >>fails.log
  let FAIL++
}

{
  replace_old $INSTALATION_DIR $PREVIOUS
} || {
  echo "Something when wrong replacing old nvim config" >>fails.log
  let FAIL++
}

{
  MANAGER=$(get_package_manager)
  echo $MANAGER
  installDependencies $MANAGER
} && {
  installation_success
} || {
  echo "Something while ending" >>fails.log
  let FAIL++
}

if [[ $FAIL -gt 0 ]]; then
  echo "It seems to be some failures, pleace submit an issue in the following repository"
  echo
  echo "\thttps://github.com/AndresMpa/mu-vim/issues/new"
fi
