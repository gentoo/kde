# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

ECM_TEST="forceoptional"
KDE_APPS_MINIMAL=19.04.3
KFMIN=5.60.0
QTMIN=5.12.3
inherit ecm kde.org

DESCRIPTION="Data Model and Extraction System for Travel Reservation information"
HOMEPAGE+=" https://www.volkerkrause.eu/2018/08/19/kde-itinerary-introduction.html"

LICENSE="LGPL-2+"
SLOT="5"
KEYWORDS=""
IUSE=""

DEPEND="
	>=dev-qt/qtdeclarative-${QTMIN}:5
	>=dev-qt/qtgui-${QTMIN}:5
	>=dev-qt/qtnetwork-${QTMIN}:5
	>=dev-qt/qtpositioning-${QTMIN}:5
	>=dev-qt/qtwidgets-${QTMIN}:5
	>=kde-apps/kitinerary-${KDE_APPS_MINIMAL}:5
	>=kde-apps/kpkpass-${KDE_APPS_MINIMAL}:5
	>=kde-frameworks/kcontacts-${KFMIN}:5
	>=kde-frameworks/kdbusaddons-${KFMIN}:5
	>=kde-frameworks/kholidays-${KFMIN}:5
	>=kde-frameworks/ki18n-${KFMIN}:5
	kde-misc/kpublictransport:5
	sys-libs/zlib
"
RDEPEND="${DEPEND}
	>=dev-qt/qtquickcontrols2-${QTMIN}:5
	>=kde-frameworks/kirigami-${KFMIN}:5
	>=kde-frameworks/prison-${KFMIN}:5
	!kde-apps/itinerary
"
