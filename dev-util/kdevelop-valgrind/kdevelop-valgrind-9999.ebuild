# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

KDE_ORG_CATEGORY="kdevelop"
KDE_ORG_NAME="kdev-valgrind"
KFMIN=6.5.0
QTMIN=6.7.2
inherit ecm kde.org

DESCRIPTION="Plugin offering full integration of the valgrind suite to KDevelop"
HOMEPAGE="https://www.kdevelop.org/"

LICENSE="GPL-2"
SLOT="6"
KEYWORDS=""
IUSE=""

DEPEND="
	>=dev-qt/qtbase-${QTMIN}:6[gui,network,widgets]
	dev-util/kdevelop:6=
	>=kde-frameworks/kconfig-${KFMIN}:6
	>=kde-frameworks/kconfigwidgets-${KFMIN}:6
	>=kde-frameworks/kcoreaddons-${KFMIN}:6
	>=kde-frameworks/ki18n-${KFMIN}:6
	>=kde-frameworks/kio-${KFMIN}:6
	>=kde-frameworks/kjobwidgets-${KFMIN}:6
	>=kde-frameworks/ktexteditor-${KFMIN}:6
	>=kde-frameworks/kwidgetsaddons-${KFMIN}:6
	>=kde-frameworks/kxmlgui-${KFMIN}:6
"
RDEPEND="${DEPEND}
	!${CATEGORY}/${PN}:5
	dev-debug/valgrind
"
