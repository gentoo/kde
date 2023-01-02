# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

KFMIN=5.82.0
inherit ecm kde.org

DESCRIPTION="Public transport assistant targeted towards mobile Linux and Android"
HOMEPAGE="https://apps.kde.org/ktrip/"

LICENSE="GPL-2+"
SLOT="5"
KEYWORDS=""
IUSE=""

DEPEND="
	dev-libs/kpublictransport:5
	dev-qt/qtdeclarative:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	>=kde-frameworks/kconfig-${KFMIN}:5
	>=kde-frameworks/kcontacts-${KFMIN}:5
	>=kde-frameworks/kcoreaddons-${KFMIN}:5
	>=kde-frameworks/ki18n-${KFMIN}:5
	>=kde-frameworks/kitemmodels-${KFMIN}:5
"
RDEPEND="${DEPEND}
	dev-qt/qtquickcontrols:5
	dev-qt/qtquickcontrols2:5
	>=kde-frameworks/kirigami-${KFMIN}:5
	>=kde-frameworks/plasma-${KFMIN}:5
"
