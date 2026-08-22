#!/usr/bin/env bash
#
# utilities/installation/done.sh
#

# Shared helper so success/failure messages can't drift out of sync with
# each other (previously ~90% duplicated code) and so the terminal-width
# detection only has to be fixed in one place.
_print_centered_message() {
  local title="$1" info="$2"
  local term_width right_shift line

  if command -v tput >/dev/null 2>&1 && [[ -t 1 ]]; then
    term_width=$(tput cols 2>/dev/null) || term_width=80
  else
    term_width=80
  fi
  [[ "${term_width}" =~ ^[0-9]+$ ]] || term_width=80

  right_shift=$(( (${#title} + term_width) / 8 ))

  printf '%*s\n\n\n' "${right_shift}" "${title}"

  # `info` may contain embedded newlines. printf "%*s" on a multi-line
  # string only pads before the FIRST line and leaves every following
  # line flush against column 0, which is what the original code did.
  # Splitting on newlines and padding each line individually fixes that.
  while IFS= read -r line; do
    printf '%*s\n' "${right_shift}" "${line}"
  done <<<"${info}"
}

installation_success() {
  local title="Installation is done"
  local info="It seems that everything is alright, to complete this process enter nvim then let nvim install some extra features.
If you get an issue try checking mu-vim wiki: https://github.com/AndresMpa/mu-vim/wiki"

  _print_centered_message "${title}" "${info}"
}

installation_wrong() {
  local title="Something went wrong"
  local info="Try again, if you see this error again, please submit an issue on mu-vim project
https://github.com/AndresMpa/mu-vim/issues"

  _print_centered_message "${title}" "${info}"
}
