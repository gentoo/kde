# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME=kdebase-runtime
KMMODULE=phonon
inherit kde4-base

DESCRIPTION="Phonon KDE integration"

LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86"
IUSE="xcb"

DEPEND="!kde-base/phonon:${SLOT}
        !kde-base/phonon-xine:${SLOT}
        >=media-sound/phonon-4.3"
RDEPEND="${DEPEND}"

src_compile() {
		mycmakeargs="${mycmakeargs} $(cmake-utils_use_with xcb XCB)"
		kde4-meta_src_compile
}

