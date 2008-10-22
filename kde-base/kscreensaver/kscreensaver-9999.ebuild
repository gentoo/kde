# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

KMNAME=kdebase-workspace
OPENGL_REQUIRED="optional"
inherit kde4svn-meta

DESCRIPTION="KDE screensaver framework"
KEYWORDS=""
IUSE="debug pam"

RDEPEND="dev-libs/glib
	>=x11-libs/libxklavier-3.2
	>=x11-libs/libXrandr-1.2.1
	x11-libs/libXtst
	opengl? ( virtual/opengl )
	pam? ( >=kde-base/kdebase-pam-7
		sys-libs/pam )"
DEPEND="${RDEPEND}
	x11-proto/randrproto"

# PATCHES="${FILESDIR}/kdebase-${PV}-pam-optional.patch"

src_compile() {
	epatch "${FILESDIR}"/kdebase-4.0.82-pam-optional.patch
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with opengl OpenGL)
		$(cmake-utils_use_with pam PAM)"

	kde4overlay-meta_src_compile
}
