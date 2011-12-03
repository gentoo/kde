# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/marble/marble-4.7.3.ebuild,v 1.2 2011/11/03 10:52:25 tampakrap Exp $

EAPI=4

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
"

REQUIRED_USE="plasma? ( kde )"

PATCHES=(
	"${FILESDIR}/${PN}-4.7-magic-r1.patch"
)

pkg_setup() {
	python_set_active_version 2
	kde4-base_pkg_setup
	python_pkg_setup
}

src_prepare() {
	kde4-base_src_prepare
	python_convert_shebangs -r $(python_get_version) .

	find "${S}/marble/src/bindings/python/sip" -name "*.sip" | xargs -- sed -i 's/#include <marble\//#include </'
}

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_with designer-plugin DESIGNER_PLUGIN)
		$(cmake-utils_use python EXPERIMENTAL_PYTHON_BINDINGS)
		$(cmake-utils_use_with python PyQt4)
		$(cmake-utils_use_with python PythonLibrary)
		$(cmake-utils_use_with python SIP)
		$(cmake-utils_use_with gps libgps)
		$(cmake-utils_use !kde QTONLY)
		$(cmake-utils_use_with plasma)
		-DWITH_liblocation=0
		$(use kde && cmake-utils_use_with python PyKDE4)
	)

	kde4-base_src_configure
}
