#!/usr/bin/env zsh

function bg() {
	if [[ $# -eq 0 ]]; then
		pr red "No argument supplied. ${funcstack[1]} needs a command to run"
		return 0
	fi

	eval "nohup $* 1>/dev/null 2>/dev/null &"
}

function bg_oneliner() {
	echo "bg: run something in background"
}

function bg_help() {
	pr blue "usage:"
	pr default "bg <command>"
	pr default ""
	pr default "Runs the given command in background using '1>/dev/null 2>/dev/null &'"
}