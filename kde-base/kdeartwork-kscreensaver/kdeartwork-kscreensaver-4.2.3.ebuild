# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeartwork-kscreensaver/kdeartwork-kscreensaver-4.2.2.ebuild,v 1.2 2009/04/17 07:54:42 alexxy Exp $

EAPI="2"

KMMODULE="kscreensaver"
KMNAME="kdeartwork"
OPENGL_REQUIRED="optional"
inherit kde4-meta

DESCRIPTION="Extra screensavers for kde"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~x86"
IUSE="debug +eigen opengl xscreensaver"

# libkworkspace - only as a stub to provide KDE4Workspace config
RDEPEND="
	>=kde-base/kscreensaver-${PV}:${SLOT}[kdeprefix=,opengl?]
	>=kde-base/libkworkspace-${PV}:${SLOT}[kdeprefix=]
	media-libs/libart_lgpl
	opengl? ( virtual/opengl )
	xscreensaver? ( x11-misc/xscreensaver )
"
DEPEND="${RDEPEND}
	eigen? ( dev-cpp/eigen:2 )
"

PATCHES=( "${FILESDIR}/${PN}-xscreensaver.patch" )

src_prepare() {
	sed -i -e 's/${KDE4WORKSPACE_KSCREENSAVER_LIBRARY}/kscreensaver/g' \
		kscreensaver/{kdesavers{,/asciiquarium},kpartsaver}/CMakeLists.txt \
		|| die "Failed to patch CMake files"

	kde4-meta_src_prepare
}

src_configure() {
	mycmakeargs="${mycmakeargs}
		-DKSCREENSAVER_SOUND_SUPPORT=ON
		$(cmake-utils_use_with eigen Eigen2)
		$(cmake-utils_use_with opengl OpenGL)
		$(cmake-utils_use_with xscreensaver Xscreensaver)"

	kde4-meta_src_configure
}
