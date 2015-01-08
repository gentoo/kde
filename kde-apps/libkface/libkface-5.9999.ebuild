# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

EGIT_BRANCH="frameworks"
inherit kde5

DESCRIPTION="Qt/C++ wrapper around LibFace to perform face recognition and detection"
HOMEPAGE="http://api.kde.org/4.x-api/kdegraphics-apidocs/libs/libkface/libkface/html/index.html"

LICENSE="GPL-2"
IUSE=""

CDEPEND=">=media-libs/opencv-2.4.9
	dev-qt/qtwidgets:5
	dev-qt/qtsql:5
	dev-qt/qtxml:5
	dev-qt/qtgui:5
	kde-frameworks/ki18n"
DEPEND="${CDEPEND}
	sys-devel/gettext"
RDEPEND="${CDEPEND}
	!media-libs/libkface"
