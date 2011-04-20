# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

KDE_HANDBOOK="optional"
KDE_SCM="git"
if [[ ${PV} == *9999 ]]; then
	inherit kde4-base
else
	KMNAME="kdegraphics"
	inherit kde4-meta
fi

DESCRIPTION="KDE screen gamma values kcontrol module"
KEYWORDS=""
IUSE="debug"

RDEPEND="
	x11-libs/libXxf86vm
"
DEPEND="${RDEPEND}
	x11-proto/xf86vidmodeproto
"

if [[ ${PV} != *9999 ]]; then
src_unpack() {
	if use handbook; then
		KMEXTRA+=" doc/kcontrol/kgamma"
	fi

	kde4-meta_src_unpack
}
fi
