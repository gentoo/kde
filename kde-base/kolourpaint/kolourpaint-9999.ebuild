# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

KDE_HANDBOOK="optional"
if [[ ${PV} == *9999 ]]; then
KDE_SCM="git"
inherit kde4-base
else
KMNAME="kdegraphics"
inherit kde4-meta
fi

DESCRIPTION="Paint Program for KDE"
KEYWORDS=""
LICENSE="BSD LGPL-2"
IUSE="debug"

if [[ ${PV} == *9999 ]]; then
src_prepare() {
	# Upstream forgot to add_subdirectory(doc), so HACK it in
	if ! grep -qi '^[[:space:]]*add_subdirectory[[:space:]]*([[:space:]]*doc[[:space:]]*)' CMakeLists.txt; then
		echo "add_subdirectory(doc)" >> CMakeLists.txt
	fi

	kde4-base_src_prepare
}
fi
