#!/bin/bash

# shell output
warn() { echo "$@" >&2; }
die() { warn "$@"; exit 1; }

MAIN_BRANCH="develop"
MERGED=""

init() {
	require_git_repo
}

require_git_repo() {
	if ! git rev-parse --git-dir >/dev/null 2>&1; then
		die "fatal: Not a git repository"
	fi
}

init
