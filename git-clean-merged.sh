#!/bin/bash

# shell output
warn() { echo "$@" >&2; }
die() { warn "$@"; exit 1; }

VERSION=0.1.0

MAIN_BRANCH="develop"
MERGED=""
EXCLUDED="master develop"
FORCE=0
LIST_ONLY=0

while getopts ":vflb:" option; do
	case $option in
		"v" )
			echo "Version: ${VERSION}"
			exit 0
			;;
		"f" )
			FORCE=1
			;;
		"l" )
			LIST_ONLY=1
			;;
		"b" )
			MAIN_BRANCH=$OPTARG
			;;
		\? )
			echo "Unknown option: -$OPTARG"
			exit 1
			;;
	esac
done

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

delete_merged() {
	echo -n "Delete this? y/[n]: "
	read confirmed
	if [ "$confirmed" = "y" ]
		then
			echo "Trying to delete branches..."
			for branch in $MERGED
				do 
					branch_is_excluded ${branch}
					excluded=$?
					if [ $excluded -eq 0 ]
						then
						echo "git branch -d ${branch}"
						echo "  branch ${branch} deleted"
					fi
			done
			echo "Finished"
	else
		echo "Ok, exit"
	fi
}

init
