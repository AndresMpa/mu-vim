#!/bin/bash

PACKAGES="nodejs" "npm" "ripgrep" "zenity" "fd" "shfmt" "stylua" "luarocks" "python-neovim"

installDependencies() {
  if [[ $1 != "pacman" ]]; then
    git clone --depth 1 https://github.com/wbthomason/packer.nvim \
      ~/.local/share/nvim/site/pack/packer/start/packer.nvim
  else
    yay -S nvim-packer-git
  fi

  case $1 in
  # debian_version
  [apt-get]*)
    sudo apt-get install $PACKAGES
    break
    ;;
  # arch-release
  [pacman]*)
    sudo pacman install $PACKAGES
    break
    ;;
  # redhat-release
  [dnf]*)
    sudo dnf install $PACKAGES
    break
    ;;
    # SuSE-release
  [zypp]*)
    sudo zypp install $PACKAGES
    break
    ;;
  # gentoo-release
  [emerge]*)
    sudo emerge --ask $PACKAGES
    break
    ;;
  # alpine-release
  [apk]*)
    sudo apk add $PACKAGES
    break
    ;;
  # Anything else
  *)
    echo "It seems that I do not know how to track your OS, you need these packages $PACKAGES"
    ;;
  esac
}
