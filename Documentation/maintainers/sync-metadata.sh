#!/bin/bash

# Contact: devurandom
METADATA_MIRROR=rsync://gentoo.kynes.de:800/gentoo-overlay-kde/metadata/cache/

if [[ "$(basename $(pwd))" != "Documentation" ]] ; then
	echo "ERROR: This script is meant to be run from within Documentation/ !"
	exit 1
fi

echo "Syncing KDE overlay metadata ..."
exec rsync --quiet --recursive --times --compress --delete-delay $METADATA_MIRROR ../metadata/cache/
