# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

KFMIN=5.60.0
inherit ecm kde.org

DESCRIPTION="Public transport assistant targeted towards mobile Linux and Android"
HOMEPAGE="https://cgit.kde.org/kpublictransport.git/tree/
	https://www.volkerkrause.eu/2019/03/02/kpublictransport-introduction.html"

LICENSE="GPL-2+"
SLOT="5"
KEYWORDS=""
IUSE=""

DEPEND="
	dev-qt/qtdeclarative:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	>=kde-frameworks/ki18n-${KFMIN}:5
	kde-misc/kpublictransport:5
"
RDEPEND="${DEPEND}
	dev-qt/qtquickcontrols:5
	dev-qt/qtquickcontrols2:5
	>=kde-frameworks/kirigami-${KFMIN}:5
	>=kde-frameworks/plasma-${KFMIN}:5
"
