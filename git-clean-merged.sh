#!/bin/bash

# shell output
warn() { echo "$@" >&2; }
die() { warn "$@"; exit 1; }

MAIN_BRANCH="develop"
MERGED=""
EXCLUDED="master develop"

init() {
	require_git_repo
	get_merged_branches
	delete_merged
}

require_git_repo() {
	if ! git rev-parse --git-dir >/dev/null 2>&1; then
		die "fatal: Not a git repository"
	fi
}

get_merged_branches() {
	echo "Branches already merged into branch ${MAIN_BRANCH}:" 
	MERGED=$( git branch --merged ${MAIN_BRANCH}  | cut -c 3-)
	# TODO: добавить проверку на отсутсвие ключа -f
	for branch in $MERGED
		do echo "  $branch"
	done
}

branch_is_excluded() {
	current_brahch=$1
	for excluded_branch in $EXCLUDED
		do
			if [ "${excluded_branch}" = "${current_brahch}" ]
				then 
				return 1
			fi
	done
	return 0
}

}

init
