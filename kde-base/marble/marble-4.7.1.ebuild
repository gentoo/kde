# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/marble/marble-4.7.0-r1.ebuild,v 1.1 2011/07/31 18:24:35 dilfridge Exp $

EAPI=3

KDE_HANDBOOK="optional"
KDE_REQUIRED="optional"
CPPUNIT_REQUIRED="optional"
PYTHON_DEPEND="python? 2"
KDE_SCM="git"
inherit kde4-base python

DESCRIPTION="Generic geographical map widget"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug designer-plugin gps +kde plasma python"

# tests fail / segfault. Last checked for 4.2.88
RESTRICT=test

DEPEND="
	gps? ( >=sci-geosciences/gpsd-2.95[qt4] )
	python? (
		>=dev-python/PyQt4-4.4.4-r1
		kde? ( $(add_kdebase_dep pykde4) )
	)
"
RDEPEND="${DEPEND}
	!sci-geosciences/marble
"

PATCHES=(
			"${FILESDIR}/${PN}-4.7-magic-r1.patch"
			"${FILESDIR}/${PN}-4.5.5-gpsd.patch"
)

pkg_setup() {
	python_set_active_version 2
	kde4-base_pkg_setup
}

src_prepare() {
	kde4-base_src_prepare
	python_convert_shebangs -r $(python_get_version) .
}

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with designer-plugin DESIGNER_PLUGIN)
		$(cmake-utils_use python EXPERIMENTAL_PYTHON_BINDINGS)
		$(cmake-utils_use_with python PyQt4)
		$(cmake-utils_use_with python PythonLibrary)
		$(cmake-utils_use_with python SIP)
		$(cmake-utils_use_with gps libgps)
		-DWITH_liblocation=0
	)
	use kde || mycmakeargs=(
		-DQTONLY=ON
		${mycmakeargs[@]}
	)
	use kde && mycmakeargs=(
		$(cmake-utils_use_with plasma)
		$(cmake-utils_use_with python PyKDE4)
		${mycmakeargs[@]}
	)

	find "${S}/marble/src/bindings/python/sip" -name "*.sip" | xargs -- sed -i 's/#include <marble\//#include </'

	kde4-base_src_configure
}

src_install() {
	if use plasma; then
		insinto /usr/share/apps/cmake/modules
		doins "${S}"/cmake/modules/FindMarbleWidget.cmake
	fi
	kde4-base_src_install
}
