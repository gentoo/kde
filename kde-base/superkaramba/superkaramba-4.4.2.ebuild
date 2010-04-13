# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/superkaramba/superkaramba-4.4.2.ebuild,v 1.1 2010/03/30 22:06:39 spatz Exp $

EAPI="3"

KMNAME="kdeutils"
PYTHON_DEPEND="python? 2"
inherit python kde4-meta

DESCRIPTION="A tool to create interactive applets for the KDE desktop."
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux"
IUSE="debug +handbook python"

DEPEND="
	kde-base/qimageblitz
	python? ( $(add_kdebase_dep pykde4) )
"
RDEPEND="${DEPEND}
	python? ( $(add_kdebase_dep krosspython) )
"

PATCHES=( "${FILESDIR}/${PN}-as-needed.patch" )

pkg_setup() {
    python_set_active_version 2
}

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with python PythonLibs)
	)

	kde4-meta_src_configure
}
