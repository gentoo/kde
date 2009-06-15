# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kalgebra/kalgebra-4.2.2.ebuild,v 1.2 2009/04/17 06:16:51 alexxy Exp $

EAPI="2"

KMNAME="kdeedu"
OPENGL_REQUIRED="optional"
inherit kde4-meta

DESCRIPTION="MathML-based graph calculator for KDE."
KEYWORDS=""
IUSE="debug +handbook +plasma readline"

DEPEND="
	readline? ( sys-libs/readline )
"
RDEPEND="${DEPEND}"

KMEXTRACTONLY="libkdeedu/kdeeduui"

src_configure() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with readline)
		$(cmake-utils_use_with plasma)
		$(cmake-utils_use_with opengl OpenGL)"

	kde4-meta_src_configure
}
