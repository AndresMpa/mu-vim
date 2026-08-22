#!/usr/bin/env bash
#
# utilities/installation/installer.sh
#

# NOTE: this was previously `PACKAGES="nodejs" "pnpm" "ripgrep" ...` which is
# NOT an array in bash — `VAR=value word2 word3...` is parsed as "run the
# command `word2` with args `word3...` and env var VAR=value set just for
# that one command". So the real bug was that PACKAGES ended up as the single
# string "nodejs", and the rest of the line silently attempted to *execute*
# "pnpm" as a command with a pile of arguments. Must be declared as an array.
PACKAGES=(
  nodejs
  pnpm
  ripgrep
  zenity
  fd
  shfmt
  stylua
  luarocks
  python-neovim
)

# Caveat worth knowing before you rely on this: package *names* aren't
# uniform across distros. "fd" is packaged as "fd-find" on Debian/Ubuntu
# (binary is `fdfind`), and "python-neovim" is "python3-neovim" on
# Debian/Fedora rather than the Arch-style name used here. This script
# does not remap those per-distro — if a package name doesn't exist on
# your distro, that one install will fail. Worth a per-distro map if you
# want this fully unattended; happy to add one if useful.

install_packer() {
  local packer_dir="${HOME}/.local/share/nvim/site/pack/packer/start/packer.nvim"

  if [[ -d "${packer_dir}" ]]; then
    echo "packer.nvim already present, skipping clone"
    return 0
  fi

  if ! git clone --depth 1 https://github.com/wbthomason/packer.nvim "${packer_dir}"; then
    echo "Failed to clone packer.nvim" >&2
    return 1
  fi
}

installDependencies() {
  if [[ $# -lt 1 || -z "$1" ]]; then
    echo "installDependencies: expected a package manager name as \$1" >&2
    return 1
  fi

  local manager="$1"
  local status=0

  if [[ "${manager}" == "pacman" ]] && command -v yay >/dev/null 2>&1; then
    if ! yay -S --noconfirm nvim-packer-git; then
      echo "yay failed to install nvim-packer-git" >&2
      status=1
    fi
  else
    if [[ "${manager}" == "pacman" ]]; then
      echo "yay not found, falling back to a manual packer.nvim clone" >&2
    fi
    install_packer || status=1
  fi

  case "${manager}" in
  apt-get)
    sudo apt-get update && sudo apt-get install -y "${PACKAGES[@]}" || status=1
    ;;
  pacman)
    sudo pacman -Sy --noconfirm "${PACKAGES[@]}" || status=1
    ;;
  dnf)
    sudo dnf install -y "${PACKAGES[@]}" || status=1
    ;;
  zypp | zypper)
    sudo zypper --non-interactive install "${PACKAGES[@]}" || status=1
    ;;
  emerge)
    sudo emerge --ask "${PACKAGES[@]}" || status=1
    ;;
  apk)
    sudo apk add "${PACKAGES[@]}" || status=1
    ;;
  *)
    echo "It seems that I do not know how to handle package manager '${manager}'."
    echo "You need to install these packages manually: ${PACKAGES[*]}"
    status=1
    ;;
  esac

  return "${status}"
}
