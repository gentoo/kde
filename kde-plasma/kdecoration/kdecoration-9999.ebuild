# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_HANDBOOK=true
inherit kde5

DESCRIPTION="Plugin based library to create window decorations"
HOMEPAGE="http://www.kde.org/"
KEYWORDS=""
IUSE=""

DEPEND="
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qttest:5
"