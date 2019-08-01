# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit kde5

DESCRIPTION="Public transport assistant targeted towards mobile Linux and Android"
HOMEPAGE="https://cgit.kde.org/kpublictransport.git/tree/
	https://www.volkerkrause.eu/2019/03/02/kpublictransport-introduction.html"

LICENSE="GPL-2+"
KEYWORDS=""
IUSE=""

DEPEND="
	$(add_frameworks_dep ki18n)
	$(add_qt_dep qtdeclarative)
	$(add_qt_dep qtgui)
	$(add_qt_dep qtwidgets)
	kde-misc/kpublictransport:5
"
RDEPEND="${DEPEND}
	$(add_frameworks_dep kirigami)
	$(add_frameworks_dep plasma)
	$(add_qt_dep qtquickcontrols)
	$(add_qt_dep qtquickcontrols2)
"
