#!/usr/bin/env zsh

function resh () {
	# echo "Running init script"
	source $HOME/bin/zsh_scripts/init.zsh
}

alias refunc=resh

resh
