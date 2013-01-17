# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_DEPEND="python? 2"
inherit python kde4-base

DESCRIPTION="A tool to create interactive applets for the KDE desktop."
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug python"

DEPEND="
	media-libs/qimageblitz
	python? ( $(add_kdebase_dep pykde4) )
"
RDEPEND="${DEPEND}
	python? ( $(add_kdebase_dep krosspython) )
"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
	kde4-base_pkg_setup
}

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with python PythonLibs)
	)

	kde4-base_src_configure
}
