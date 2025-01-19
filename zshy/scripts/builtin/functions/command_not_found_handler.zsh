#!/usr/bin/env zsh

function command_not_found_handler() {
  if zx c $1; then
    debugmsg "$1 is installed as a zx extension"
    zx r $*
  else
    echo "command not found: $1"
    return 127
  fi
}
