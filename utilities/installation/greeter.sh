#!/usr/bin/env bash
#
# utilities/installation/greeter.sh
#

readonly TITLE="Hey there, thanks for giving the project a try and welcome to"

# Static ASCII/braille-art banner. Declared explicitly (with -g) before
# appending so this doesn't rely on bash's array auto-vivification for `+=`.
#
# The -g is load-bearing, not decoration: this file gets `source`d from
# inside installer.sh's require_libs() function. `declare` (unlike
# `readonly`) auto-scopes a variable local to whatever function it runs
# inside of — so without -g, BANNER would become local to require_libs()
# and vanish the moment that function returns, leaving greeter() to loop
# over an empty array (title prints, banner silently doesn't).
declare -ag BANNER=()
BANNER+=('⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀')
BANNER+=('⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠀⠀⠀⠀⠀⠀⠀⠀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀')
BANNER+=('⠀⠀⠀⠀⠀⠀⠀⠀⠀⡆⡆⠀⠀⠀⠀⠀⠀⠜⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀')
BANNER+=('⠀⠀⠀⠀⠀⠀⠀⠀⢠⠁⢰⠀⠀⠀⠀⢀⠊⢠⠀⠀⢠⠀⠀⠀⠀⢠⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀')
BANNER+=('⠀⠀⠀⠀⠀⠀⠀⠀⠘⠀⠀⡆⠀⠀⠠⠃⠀⡘⠀⠀⡘⠀⠀⠀⠀⡘⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀')
BANNER+=('⠀⠀⠀⠀⠀⠀⠀⠀⡇⠀⠀⢰⠀⡰⠁⠀⠀⠇⠀⠀⡇⠀⠀⠀⢀⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀')
BANNER+=('⠀⠀⠀⠀⠀⠀⠀⠰⠀⠀⠀⠀⠞⠀⠀⠀⠰⠀⠀⢰⠑⠤⠤⠔⠱⠀⣿⡆⠀⠀⠀⣾⡗⠀⠀⠰⣿⠆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀')
BANNER+=('⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡌⠀⠀⠀⠀⠀⠀⠸⣿⡄⠀⣸⣿⠁⠀⣴⣶⣶⡄⠀⠀⢰⣦⣶⣤⣴⣶⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀')
BANNER+=('⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢻⣷⢠⣿⠇⠀⠀⠀⠀⣿⡇⠀⠀⢸⣿⠀⣿⡏⠈⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀')
BANNER+=('⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⣿⣿⡟⠀⠀⠀⠀⠀⣿⡇⠀⠀⢸⣿⠀⣿⡇⠀⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀')
BANNER+=('⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⠿⠁⠀⠀⠀⠀⠀⠿⠿⠿⠀⠸⠟⠀⠻⠇⠀⠿⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀')
BANNER+=('⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀')
BANNER+=('⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀')
BANNER+=('⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀')

greeter() {
  # Computed lazily inside the function (not at source time) so a resize
  # between sourcing and calling is picked up, and so a failure here can't
  # break the installer just for having sourced this file. Named TERM_WIDTH
  # rather than COLUMNS to avoid clobbering bash's own special COLUMNS
  # variable, which it keeps in sync with the terminal on SIGWINCH.
  local term_width title_shift banner_shift label

  if command -v tput >/dev/null 2>&1 && [[ -t 1 ]]; then
    term_width=$(tput cols 2>/dev/null) || term_width=80
  else
    term_width=80
  fi
  [[ "${term_width}" =~ ^[0-9]+$ ]] || term_width=80

  # printf "%*s" centers by right-justifying the string in a field of the
  # given width: (len(str) + term_width) / 2 makes that field wide enough
  # that half the remaining terminal width ends up as left padding.
  # Title and banner lines aren't the same length, so each needs its own
  # field width computed from ITS OWN length — reusing one shared value
  # for both (as before) only centers whichever one it was computed from.
  title_shift=$(( (${#TITLE} + term_width) / 8 ))
  banner_shift=$(( (${#BANNER[0]} + term_width) / 2 ))

  printf '%*s\n' "${title_shift}" "${TITLE}"

  # No extra tab-based branch here: the previous ">73 columns → prepend 7
  # tabs" logic added a second, independent indent ON TOP OF the printf
  # field-width padding above, instead of instead of it. On any terminal
  # wide enough to trip that branch, the two paddings stacked and pushed
  # the art far past a sane column (well past the terminal's actual width
  # in some cases), which is what made the banner look broken/cut off.
  # printf's field-width padding alone already centers it correctly.
  for label in "${BANNER[@]}"; do
    printf '%*s\n' "${banner_shift}" "${label}"
  done
}
