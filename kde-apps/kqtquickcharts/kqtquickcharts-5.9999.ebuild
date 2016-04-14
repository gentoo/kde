# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

EGIT_BRANCH="frameworks"
inherit kde5

DESCRIPTION="Qt Quick plugin for beautiful and interactive charts"
KEYWORDS=""
IUSE=""

DEPEND="
	$(add_qt_dep qtdeclarative)
	$(add_qt_dep qtgui)
"
RDEPEND="${DEPEND}"
