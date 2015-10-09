# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

EGIT_BRANCH="frameworks"
inherit kde5

DESCRIPTION="Qt/C++ wrapper around LibFace to perform face recognition and detection"
HOMEPAGE="http://api.kde.org/4.x-api/kdegraphics-apidocs/libs/libkface/libkface/html/index.html"

LICENSE="GPL-2"
IUSE=""

KEYWORDS=""

DEPEND="
	dev-qt/qtgui:5
	dev-qt/qtsql:5
	dev-qt/qtwidgets:5
	dev-qt/qtxml:5
	>=media-libs/opencv-3[contrib]
"
RDEPEND="${DEPEND}
	!media-libs/libkface
"

src_configure() {
	local mycmakeargs=(
		-DENABLE_OPENCV3=ON
	)

	kde5_src_configure
}
