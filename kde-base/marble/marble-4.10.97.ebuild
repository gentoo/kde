# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_HANDBOOK="optional"
KDE_REQUIRED="optional"
CPPUNIT_REQUIRED="optional"
PYTHON_DEPEND="python? 2"
inherit kde4-base python

DESCRIPTION="Generic geographical map widget"
HOMEPAGE="http://marble.kde.org/"
KEYWORDS=" ~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug designer-plugin gps +kde plasma python shapefile test"

# tests fail / segfault. Last checked for 4.9.0
RESTRICT="test"

RDEPEND="
	dev-qt/qtcore:4
	dev-qt/qtdeclarative:4
	dev-qt/qtgui:4[dbus(+)]
	dev-qt/qtscript:4
	dev-qt/qtsql:4
	dev-qt/qtsvg:4
	dev-qt/qtwebkit:4
	gps? ( >=sci-geosciences/gpsd-2.95[qt4] )
	python? (
		>=dev-python/PyQt4-4.4.4-r1
		kde? ( $(add_kdebase_dep pykde4) )
	)
	shapefile? ( sci-libs/shapelib )
"
DEPEND="
	${RDEPEND}
	test? ( dev-qt/qttest:4 )
"
# the qt dependencies are needed because with USE=-kde nothing is pulled in
# by default... bugs 414165 & 429346

REQUIRED_USE="
	plasma? ( kde )
	python? ( kde )
"

pkg_setup() {
	python_set_active_version 2
	kde4-base_pkg_setup
	python_pkg_setup
}

src_prepare() {
	kde4-base_src_prepare
	python_convert_shebangs -r $(python_get_version) .
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
		$(cmake-utils_use_with shapefile libshp)
		-DBUILD_MARBLE_TESTS=OFF
		-DWITH_liblocation=0
		-DWITH_QextSerialPort=OFF
		$(use kde && cmake-utils_use_with python PyKDE4)
	)

	kde4-base_src_configure
}

src_test() {
	if use kde; then
		elog "Marble tests can only be run in the qt-only version"
	else
		local mycmakeargs=(
			-DBUILD_MARBLE_TESTS=ON
		)
		kde4-base_src_test
	fi
}
