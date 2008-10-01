# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMMODULE=kscreensaver
KMNAME=kdeartwork
OPENGL_REQUIRED="optional"
inherit eutils kde4-meta

DESCRIPTION="Extra screensavers for kde"
KEYWORDS="~amd64 ~x86"
IUSE="debug opengl xscreensaver"

DEPEND="${DEPEND}
	>=kde-base/kscreensaver-${PV}:${SLOT}[opengl?]
	media-libs/libart_lgpl
	opengl? ( virtual/opengl )
	xscreensaver? ( x11-misc/xscreensaver )"
RDEPEND="${DEPEND}"

PATCHES=("${FILESDIR}/${PN}-xscreensaver.patch")

src_configure() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with opengl OpenGL)
		$(cmake-utils_use_with xscreensaver Xscreensaver)"

	kde4-meta_src_configure
}
