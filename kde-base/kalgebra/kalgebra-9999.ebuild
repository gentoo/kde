# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

KMNAME=kdeedu
OPENGL_REQUIRED="optional"
inherit kde4svn-meta

DESCRIPTION="MathML-based graph calculator for KDE."
KEYWORDS=""
IUSE="debug htmlhandbook +plasma readline"

DEPEND="opengl? ( virtual/opengl )
	plasma? ( kde-base/libplasma:${SLOT} )
	readline? ( sys-libs/readline )"
RDEPEND="${DEPEND}"

KMEXTRACTONLY=libkdeedu/kdeeduui

# Needed for USE="-opengl"

src_compile() {
	#epatch "${FILESDIR}"/${PN}-4.0.82-opengl.patch
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with readline Readline)
		$(cmake-utils_use_with plasma Plasma)
		$(cmake-utils_use_with opengl OpenGL)"

	kde4overlay-meta_src_compile
}
