# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdegraphics"
inherit kde4-meta

DESCRIPTION="KDE digital camera manager"
KEYWORDS="~amd64 ~x86"
IUSE="debug doc"

DEPEND="
	media-libs/libgphoto2
"
RDEPEND="${DEPEND}"

src_unpack() {
	if use doc; then
		KMEXTRA="
			doc/kcontrol/${PN}
		"
	fi

	kde4-meta_src_unpack
}
