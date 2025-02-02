# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

KFMIN=6.3.0
inherit ecm kde.org

DESCRIPTION="Public transport assistant targeted towards mobile Linux and Android"
HOMEPAGE="https://apps.kde.org/ktrip/"

LICENSE="GPL-2+"
SLOT="6"
KEYWORDS=""
IUSE=""

DEPEND="
	dev-libs/kirigami-addons:6
	dev-libs/kpublictransport:6
	dev-qt/qtbase:6[gui,widgets]
	dev-qt/qtdeclarative:6
	>=kde-frameworks/kconfig-${KFMIN}:6
	>=kde-frameworks/kcontacts-${KFMIN}:6
	>=kde-frameworks/kcoreaddons-${KFMIN}:6
	>=kde-frameworks/kcrash-${KFMIN}:6
	>=kde-frameworks/ki18n-${KFMIN}:6
"
RDEPEND="${DEPEND}
	!${CATEGORY}/${PN}:5
	>=kde-frameworks/kirigami-${KFMIN}:6
	>=kde-plasma/libplasma-${KFMIN}:6
"
