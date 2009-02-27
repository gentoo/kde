# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kalgebra/kalgebra-4.2.0.ebuild,v 1.2 2009/02/01 06:28:44 jmbsvicetto Exp $

EAPI="2"

KMNAME="kdeedu"
OPENGL_REQUIRED="optional"
inherit kde4-meta

DESCRIPTION="MathML-based graph calculator for KDE."
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug htmlhandbook +plasma readline"

DEPEND="opengl? ( virtual/opengl )
	readline? ( sys-libs/readline )"
RDEPEND="${DEPEND}"

KMEXTRACTONLY="libkdeedu/kdeeduui"

src_configure() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with readline Readline)
		$(cmake-utils_use_with plasma Plasma)
		$(cmake-utils_use_with opengl OpenGL)"

	kde4-meta_src_configure
}
