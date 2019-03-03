# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

KDE_TEST="forceoptional"
inherit kde5

DESCRIPTION="Library for accessing public transport timetables and other information"
HOMEPAGE="https://cgit.kde.org/kpublictransport.git/tree/
	https://www.volkerkrause.eu/2019/03/02/kpublictransport-introduction.html"

LICENSE="LGPL-2+"
KEYWORDS=""
IUSE=""

DEPEND="
	$(add_qt_dep qtdeclarative)
	$(add_qt_dep qtgui)
	$(add_qt_dep qtnetwork)
"
RDEPEND="${DEPEND}"
