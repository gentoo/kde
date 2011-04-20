# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

KDE_HANDBOOK="optional"
if [[ ${PV} == *9999 ]]; then
KDE_SCM="git"
inherit kde4-base
else
KMNAME="kdegraphics"
inherit kde4-meta
fi

DESCRIPTION="KDE digital camera manager"
KEYWORDS=""
IUSE="debug"

DEPEND="
	media-libs/libgphoto2
"
RDEPEND="${DEPEND}"

if [[ ${PV} != *9999 ]]; then
src_unpack() {
	if use handbook; then
		KMEXTRA="
			doc/kcontrol/${PN}
		"
	fi

	kde4-meta_src_unpack
}
fi
