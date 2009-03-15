#!/usr/bin/env bash
PORTDIR="/home/scarab/gentoo/gentoo-x86/kde-base/"
find ./ -name \*-4.2.1\*.ebuild  |sed -e "s:./::" |grep -v printer |grep -v konsole | sort | while read package; do
	dir=${package/\/*}
	ebuild=${package/*\/}
	targetdir="${PORTDIR}${dir}"
	# update before copying
	pushd $targetdir > /dev/null
	cvs up
	popd > /dev/null
	cp ${package} ${targetdir}
	pushd $targetdir > /dev/null
	# todo check for patches
	cvs add ${ebuild}
	echangelog "Automatic-merge: merge updates for 4.2.1 from kde-testing."
	repoman commit -m "Automatic-merge: merge updates for 4.2.1 from kde-testing."
	popd > /dev/null
done
