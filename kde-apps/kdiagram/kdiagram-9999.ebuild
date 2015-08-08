# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit kde5

DESCRIPTION="Powerful libraries (KChart, KGantt) for creating business diagrams"
HOMEPAGE="https://www.kde.org/"
KEYWORDS=""
IUSE=""

DEPEND="
	dev-qt/qtgui:5
	dev-qt/qtprintsupport:5
	dev-qt/qtsvg:5
	dev-qt/qtwidgets:5
"
RDEPEND="${DEPEND}"
