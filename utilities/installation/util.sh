#!/usr/bin/env bash
#
# utilities/installation/util.sh
#
# Requires: bash 4+ (associative arrays), being sourced (not executed) from
# the installer, since it only defines functions.

# --- get_package_manager -----------------------------------------------
# Prints the detected package manager name on stdout, or nothing + returns 1
# if none of the known release files exist. Order matters (first match wins)
# because some distros (e.g. Manjaro) ship more than one release file.
get_package_manager() {
  local -A package_manager=(
    ["/etc/debian_version"]="apt-get"
    ["/etc/redhat-release"]="dnf"
    ["/etc/arch-release"]="pacman"
    ["/etc/SuSE-release"]="zypp"
    ["/etc/gentoo-release"]="emerge"
    ["/etc/alpine-release"]="apk"
  )
  local release_file

  for release_file in "${!package_manager[@]}"; do
    if [[ -f "${release_file}" ]]; then
      printf '%s\n' "${package_manager[${release_file}]}"
      return 0
    fi
  done

  echo "No supported package manager detected" >&2
  return 1
}

# --- replace_old ---------------------------------------------------------
# Moves an existing config dir out of the way (or removes it), asking the
# user what they want to do.
#   $1 = path to the current config dir (e.g. ~/.config/nvim)
#   $2 = path to back it up to if the user wants to keep it
replace_old() {
  if [[ $# -lt 2 ]]; then
    echo "replace_old: expected 2 arguments (target, backup_dir), got $#" >&2
    return 1
  fi

  local target="$1" backup_dir="$2" yn

  if [[ ! -e "${target}" ]]; then
    return 0
  fi

  while true; do
    read -r -p "Existing config found at ${target}. Keep it as a backup? [y/n]: " yn
    case "${yn}" in
      [Yy]*)
        if ! mkdir -p "$(dirname "${backup_dir}")"; then
          echo "Could not create parent directory for ${backup_dir}" >&2
          return 1
        fi
        if [[ -e "${backup_dir}" ]]; then
          echo "Backup destination already exists: ${backup_dir}" >&2
          return 1
        fi
        echo "Backing up existing configuration to ${backup_dir}"
        mv -- "${target}" "${backup_dir}"
        return $?
        ;;
      [Nn]*)
        echo "Removing previous configuration"
        rm -rf -- "${target}"
        return $?
        ;;
      *)
        echo "Please answer yes or no."
        ;;
    esac
  done
}
