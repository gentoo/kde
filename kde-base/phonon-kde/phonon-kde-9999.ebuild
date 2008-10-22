# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

KMNAME=kdebase-runtime
KMMODULE=phonon
inherit kde4svn-meta

DESCRIPTION="phonon KDE integration"
KEYWORDS=""
IUSE="debug"

# There's currently only a xine backend for phonon available,
# a gstreamer backend from TrollTech is in the works.
DEPEND="!kde-base/phonon:${SLOT}
	!kde-base/phonon-xine:${SLOT}
	>=media-sound/phonon-4.3"
RDEPEND="${DEPEND}"

src_compile() {
	mycmakeargs="${mycmakeargs} $(cmake-utils_use_with xcb XCB)"
	kde4overlay-meta_src_compile
}
