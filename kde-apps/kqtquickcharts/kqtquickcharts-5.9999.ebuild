# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

EGIT_BRANCH="frameworks"
inherit kde5

DESCRIPTION="Qt Quick plugin for beautiful and interactive charts"
KEYWORDS=""
IUSE=""

DEPEND="
	dev-qt/qtdeclarative:5
	dev-qt/qtgui:5
"
RDEPEND="${DEPEND}"
