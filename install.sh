#!/usr/bin/env bash
#
# mu-vim installer
#
set -uo pipefail
IFS=$'\n\t'

# --- Config -------------------------------------------------------------
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly LOG_FILE="${SCRIPT_DIR}/fails.log"
readonly DEFAULT_INSTALL_DIR="${HOME}/.config/nvim"
readonly PREVIOUS_DIR="${HOME}/.config/previous-mu-vim"
readonly REQUIRED_LIBS=(
  "utilities/installation/installer.sh"
  "utilities/installation/util.sh"
  "utilities/installation/greeter.sh"
  "utilities/installation/done.sh"
)

INSTALL_DIR="${DEFAULT_INSTALL_DIR}"
FAIL_COUNT=0

# --- Helpers --------------------------------------------------------------
log_fail() {
  local msg="$1"
  # Defense in depth: the guard added around replace_old should prevent
  # SCRIPT_DIR from ever disappearing mid-run, but if it somehow still
  # doesn't exist (moved, permissions, anything else), fall back to /tmp
  # instead of the whole script dying on a failed log write.
  if [[ -d "${SCRIPT_DIR}" ]]; then
    printf '[%s] %s\n' "$(date '+%Y-%m-%d %H:%M:%S')" "$msg" >>"${LOG_FILE}"
  else
    printf '[%s] %s\n' "$(date '+%Y-%m-%d %H:%M:%S')" "$msg" >>"/tmp/mu-vim-fails.log"
  fi
  FAIL_COUNT=$((FAIL_COUNT + 1))
}

expand_path() {
  # Expand a leading ~ that `read` doesn't expand for us.
  local path="$1"
  printf '%s' "${path/#\~/$HOME}"
}

ask_yes_no() {
  local prompt="$1" reply
  while true; do
    read -r -p "${prompt} [y/n]: " reply
    case "${reply,,}" in
      y|yes) return 0 ;;
      n|no)  return 1 ;;
      *) echo "Please answer y or n." ;;
    esac
  done
}

require_libs() {
  local lib
  for lib in "${REQUIRED_LIBS[@]}"; do
    local full="${SCRIPT_DIR}/${lib}"
    if [[ ! -f "${full}" ]]; then
      echo "Missing required file: ${full}" >&2
      exit 1
    fi
    # shellcheck disable=SC1090
    source "${full}"
  done
}

# --- Main -------------------------------------------------------------------
require_libs

if ask_yes_no "Are you using a custom configuration directory? (Default is ~/.config)"; then
  read -r -p "Write your custom directory path: " CUSTOM_PATH
  if [[ -z "${CUSTOM_PATH}" ]]; then
    echo "Empty path given, falling back to default: ${DEFAULT_INSTALL_DIR}"
  else
    INSTALL_DIR="$(expand_path "${CUSTOM_PATH}")"
  fi
fi

if [[ "${INSTALL_DIR}" != /* ]]; then
  echo "Resolved install path is not absolute: ${INSTALL_DIR}" >&2
  exit 1
fi

if type greeter >/dev/null 2>&1; then
  if greeter; then
    sleep 5
  else
    log_fail "Something went wrong while greeting"
  fi
else
  log_fail "greeter() function not found"
fi

# SAFETY GUARD: if the resolved install path is the same directory this
# script is running from (the normal case when mu-vim is cloned straight
# into ~/.config/nvim), replace_old must NOT touch it. That directory
# already IS the new config — it's not a "previous" one to move or
# remove. Doing so previously deleted the running installer's own files
# mid-execution (this is what caused fails.log writes to fail afterward:
# the directory containing it had just been rm -rf'd).
RESOLVED_INSTALL_DIR="$(realpath -m -- "${INSTALL_DIR}")"
if [[ "${RESOLVED_INSTALL_DIR}" == "${SCRIPT_DIR}" ]]; then
  echo "Install directory (${INSTALL_DIR}) is the directory mu-vim is running from — nothing to back up, skipping."
elif type replace_old >/dev/null 2>&1; then
  if ! replace_old "${INSTALL_DIR}" "${PREVIOUS_DIR}"; then
    log_fail "Something went wrong replacing old nvim config"
  fi
else
  log_fail "replace_old() function not found"
fi

if type get_package_manager >/dev/null 2>&1 && type installDependencies >/dev/null 2>&1; then
  MANAGER="$(get_package_manager)" || MANAGER=""
  if [[ -z "${MANAGER}" ]]; then
    log_fail "Could not detect a package manager"
  else
    echo "Detected package manager: ${MANAGER}"
    if installDependencies "${MANAGER}"; then
      if type installation_success >/dev/null 2>&1; then
        installation_success
      fi
    else
      log_fail "installDependencies failed for manager: ${MANAGER}"
    fi
  fi
else
  log_fail "get_package_manager()/installDependencies() function not found"
fi

if (( FAIL_COUNT > 0 )); then
  echo "It seems there were some failures (${FAIL_COUNT}), please submit an issue at:"
  echo
  printf '\thttps://github.com/AndresMpa/mu-vim/issues/new\n'
  echo "Details logged in: ${LOG_FILE}"
  exit 1
fi

exit 0
