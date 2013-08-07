#!/bin/bash

# shell output
warn() { echo "$@" >&2; }
die() { warn "$@"; exit 1; }

MAIN_BRANCH="develop"
MERGED=""

init() {
	require_git_repo
	get_merged_branches
}

require_git_repo() {
	if ! git rev-parse --git-dir >/dev/null 2>&1; then
		die "fatal: Not a git repository"
	fi
}

get_merged_branches() {
	echo "Branches already merged into branch ${MAIN_BRANCH}:" 
}

init
