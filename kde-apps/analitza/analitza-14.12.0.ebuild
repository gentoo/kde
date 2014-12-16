# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde5

DESCRIPTION="KDE library for mathematical features"
KEYWORDS=" ~amd64 ~x86"
IUSE="eigen opengl"

DEPEND="
	dev-qt/qtdeclarative:5
	dev-qt/qtgui:5
	dev-qt/qtopengl:5
	dev-qt/qtsvg:5
	dev-qt/qtwidgets:5
	dev-qt/qtxml:5
	eigen? ( dev-cpp/eigen:3 )
	opengl? ( virtual/opengl )
"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_find_package eigen Eigen3)
		$(cmake-utils_use_find_package opengl OpenGL)
	)

	kde5_src_configure
}
