#!/bin/bash

# requires app-portage/portage-utils and app-portage/gentoolkit-dev

: ${SOURCE_REPO:="$(realpath $(dirname $0)/../../../)"}
: ${TARGET_REPO:="$(pwd)"}

get_package_list_from_set() {
	local set="${1}"

	for entry in $(grep -v ^[#@] "${SOURCE_REPO}/sets/${set}") ; do
		echo $(qatom ${entry} | cut -d " " -f 1-2 | tr " " "/")
	done
}

get_main_tree_keyword() {
	local portdir="$(portageq get_repo_path / gentoo)"
	local cp="${1}"

	echo $(sed -ne 's/^KEYWORDS="\(.*\)"/\1/p' "$(ls ${portdir}/${cp}/*.ebuild | sort | tail -n 1)")
}
