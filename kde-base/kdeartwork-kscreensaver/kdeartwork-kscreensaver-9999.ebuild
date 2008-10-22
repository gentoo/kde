# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

KMMODULE=kscreensaver
KMNAME=kdeartwork
OPENGL_REQUIRED="optional"
inherit kde4svn-meta

DESCRIPTION="Extra screensavers for kde"
KEYWORDS=""
IUSE="debug opengl xscreensaver"

DEPEND="${DEPEND}
	>=kde-base/kscreensaver-${PV}:${SLOT}
	media-libs/libart_lgpl
	opengl? ( virtual/opengl )
	xscreensaver? ( x11-misc/xscreensaver )"
RDEPEND="${DEPEND}"

ESVN_PATCHES=("${FILESDIR}/${PN}-xscreensaver.patch")

pkg_setup() {
	if ! built_with_use kde-base/kscreensaver opengl ; then
		eerror "In order to build "
		eerror "you need kde-base/kscreensaver built with opengl USE flag "
		die "no opengl in kde-base/kscreensaver"
	fi
}

src_compile() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with opengl OpenGL)
		$(cmake-utils_use_with xscreensaver Xscreensaver)"

	kde4overlay-meta_src_compile
}
