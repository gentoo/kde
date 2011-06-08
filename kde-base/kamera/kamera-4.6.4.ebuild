# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

KDE_HANDBOOK="optional"
KMNAME="kdegraphics"
inherit kde4-meta

DESCRIPTION="KDE digital camera manager"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="
	media-libs/libgphoto2
"
RDEPEND="${DEPEND}"

src_unpack() {
	if use handbook; then
		KMEXTRA="
			doc/kcontrol/${PN}
		"
	fi

	kde4-meta_src_unpack
}

src_install() {
	kde4-meta_src_install

	# why, oh why?!
	rm "${ED}/usr/share/apps/cmake/modules/FindKSane.cmake" || die
}
