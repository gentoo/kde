# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

KDE_PUNT_BOGUS_DEPS="true"
inherit kde5

DESCRIPTION="KDE library for mathematical features"
KEYWORDS=" ~amd64 ~x86"
IUSE="eigen opengl"

DEPEND="
	dev-qt/qtdeclarative:5
	dev-qt/qtgui:5
	dev-qt/qtsvg:5
	dev-qt/qtwidgets:5
	dev-qt/qtxml:5
	eigen? ( dev-cpp/eigen:3 )
	opengl? (
		dev-qt/qtopengl:5
		virtual/opengl
	)
"
RDEPEND="${DEPEND}"

src_prepare() {
	sed -e "/add_subdirectory(examples)/d" -i analitzaplot/CMakeLists.txt || die

	kde5_src_prepare
}

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_find_package eigen Eigen3)
		$(cmake-utils_use_find_package opengl OpenGL)
	)

	kde5_src_configure
}
