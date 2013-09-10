# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

FRAMEWORKS_TYPE="tier1"
VIRTUALX_REQUIRED="test"
inherit kde-frameworks

DESCRIPTION="An assortment of extra KDE widgets"
LICENSE="LGPL-2.1+"
KEYWORDS=""
IUSE=""

RDEPEND="
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
"
DEPEND="${RDEPEND}"
