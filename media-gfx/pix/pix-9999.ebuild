# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_QTHELP="true"
KDE_ORG_CATEGORY="maui"
KFMIN=5.82.0
QTMIN=5.15.5
inherit ecm kde.org

DESCRIPTION="Image gallery application"

LICENSE="LGPL-3"
SLOT="5"
KEYWORDS=""
IUSE=""

DEPEND="
	>=dev-libs/mauikit-${KFMIN}:5
	>=dev-libs/mauikit-filebrowsing-${KFMIN}:5
	>=dev-libs/mauikit-imagetools-${KFMIN}:5
	>=dev-qt/qtdeclarative-${QTMIN}:5[widgets]
	>=dev-qt/qtgui-${QTMIN}:5
	>=dev-qt/qtsql-${QTMIN}:5
	>=dev-qt/qtwidgets-${QTMIN}:5
	>=kde-frameworks/ki18n-${KFMIN}:5
	>=kde-frameworks/kio-${KFMIN}:5
	>=kde-frameworks/knotifications-${KFMIN}:5
	>=kde-frameworks/kservice-${KFMIN}:5
"
RDEPEND="${DEPEND}"
