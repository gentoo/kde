# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

KDE_DOXYGEN="true"
KDE_TEST="false"
inherit kde5

DESCRIPTION="KDGantt library"
LICENSE="LGPL-2+"
KEYWORDS=""
IUSE=""

COMMON_DEPEND="
	dev-qt/qtgui:5
	dev-qt/qtprintsupport:5
	dev-qt/qtwidgets:5
"
DEPEND="${COMMON_DEPEND}
	sys-devel/gettext
"
RDEPEND="${COMMON_DEPEND}
	!<kde-apps/kdepim-15.08.50:5
	!kde-apps/kdepim-common-libs:4
"
