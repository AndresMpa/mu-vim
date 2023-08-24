#!/bin/bash

get_package_manager() {
  declare -A packageManager

  packageManager["/etc/redhat-release"]=dnf
  packageManager["/etc/arch-release"]=pacman
  packageManager["/etc/gentoo-release"]=emerge
  packageManager["/etc/SuSE-release"]=zypp
  packageManager["/etc/debian_version"]=apt-get
  packageManager["/etc/alpine-release"]=apk

  for option in ${!packageManager[@]}; do
    if [[ -f $option ]]; then
      echo ${packageManager[$option]}
    fi
  done
}

replace_old() {
  if [ -d $1 ]; then
    while true; do
      read -p "Do you want to keep your Vim/NeoVim configuration? " yn
      case $yn in
      [Yy]*)
        echo "Replacing configuration"
        mv $1 $2
        break
        ;;
      [Nn]*)
        echo "Removing previous configuration"
        rm $1
        break
        ;;
      *) echo "Please answer yes or no." ;;
      esac
    done
  fi
}

# Saving old configurations
old_version() {
  if [ -e ~/.config/nvim ]; then
    mv ~/.config/nvim old-nvim
    mv $(pwd) $instalation_dir
  else
    if [ -e ~/.config ]; then
      mv nvim $instalation_dir
    else
      mkdir ~/.config
      mv nvim $instalation_dir
    fi
  fi
}
