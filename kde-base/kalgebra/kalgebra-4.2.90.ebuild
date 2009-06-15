# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdeedu"
OPENGL_REQUIRED="optional"
inherit kde4-meta

DESCRIPTION="MathML-based graph calculator for KDE."
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~x86"
IUSE="debug +handbook +plasma readline"

# 2 tests fail, last checked for 4.2.89
RESTRICT=test

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
