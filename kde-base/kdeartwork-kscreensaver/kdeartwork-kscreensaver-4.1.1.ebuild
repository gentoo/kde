# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

KMMODULE=kscreensaver
KMNAME=kdeartwork
OPENGL_REQUIRED="optional"
inherit eutils kde4-meta

DESCRIPTION="Extra screensavers for kde"
KEYWORDS="~amd64 ~x86"
IUSE="debug xscreensaver"

DEPEND="${DEPEND}
	>=kde-base/kscreensaver-${PV}:${SLOT}
	media-libs/libart_lgpl
	opengl? ( virtual/opengl )
	xscreensaver? ( x11-misc/xscreensaver )"
RDEPEND="${DEPEND}"

PATCHES=("${FILESDIR}/${PN}-xscreensaver.patch")

pkg_setup() {
	if use xscreensaver &&! built_with_use kde-base/kscreensaver opengl ; then
		eerror "you have to built kde-base/kscreensaver with opengl support"
		die "kscreensaver not built with opengl"
	fi
}

src_compile() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with opengl OpenGL)
		$(cmake-utils_use_with xscreensaver Xscreensaver)"

	kde4-meta_src_compile
}
