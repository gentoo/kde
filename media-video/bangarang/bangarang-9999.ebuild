# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

KDE_ORG_CATEGORY="unmaintained"
KFMIN=5.60.0
QTMIN=5.12.3
inherit ecm kde.org

DESCRIPTION="Media player based on KF5"
HOMEPAGE="https://bangarangkde.wordpress.com
https://userbase.kde.org/Bangarang"

LICENSE="GPL-3"
SLOT="5"
KEYWORDS=""
IUSE=""

BDEPEND="sys-devel/gettext"
DEPEND="
	>=dev-qt/qtgui-${QTMIN}:5
	>=dev-qt/qtwidgets-${QTMIN}:5
	>=kde-frameworks/kcodecs-${KFMIN}:5
	>=kde-frameworks/kconfig-${KFMIN}:5
	>=kde-frameworks/kcoreaddons-${KFMIN}:5
	>=kde-frameworks/ki18n-${KFMIN}:5
	>=kde-frameworks/kiconthemes-${KFMIN}:5
	>=kde-frameworks/kio-${KFMIN}:5
	>=kde-frameworks/solid-${KFMIN}:5
	media-libs/phonon[qt5(+)]
	media-libs/taglib
"
RDEPEND="${DEPEND}"
