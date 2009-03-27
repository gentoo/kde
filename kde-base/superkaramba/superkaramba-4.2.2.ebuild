# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/superkaramba/superkaramba-4.2.1.ebuild,v 1.2 2009/03/08 14:22:09 scarabeus Exp $

EAPI="2"

KMNAME="kdeutils"
inherit kde4-meta

DESCRIPTION="A tool to create interactive applets for the KDE desktop."
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug python"

DEPEND="
	kde-base/qimageblitz
	python? ( dev-lang/python )
"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}/${PN}-as-needed.patch" )

src_configure() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with python PythonLibs)"

	kde4-meta_src_configure
}
