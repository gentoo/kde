# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdeutils"
inherit kde4-meta

DESCRIPTION="A tool to create interactive applets for the KDE desktop."
KEYWORDS=""
IUSE="debug +handbook python"

DEPEND="
	kde-base/qimageblitz
	python? ( kde-base/pykde4 )
"
RDEPEND="${DEPEND}
	python? ( kde-base/krosspython )
"

PATCHES=( "${FILESDIR}/${PN}-as-needed.patch" )

src_configure() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with python PythonLibs)"

	kde4-meta_src_configure
}
