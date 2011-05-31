# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

KDE_HANDBOOK="optional"
KDE_SCM="git"
inherit kde4-base

DESCRIPTION="KDE digital camera manager"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
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

	kde4-base_src_unpack
}
fi
