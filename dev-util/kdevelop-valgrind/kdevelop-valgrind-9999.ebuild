# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

KDE_ORG_NAME="kdev-valgrind"
KF5MIN=5.60.0
QT5MIN=5.12.3
inherit ecm kde.org

DESCRIPTION="Plugin offering full integration of the valgrind suite to KDevelop"
HOMEPAGE="https://www.kdevelop.org/"

LICENSE="GPL-2"
SLOT="5"
KEYWORDS=""
IUSE=""

COMMON_DEPEND="
	>=kde-frameworks/kconfig-${KF5MIN}:5
	>=kde-frameworks/kcoreaddons-${KF5MIN}:5
	>=kde-frameworks/ki18n-${KF5MIN}:5
	>=kde-frameworks/kio-${KF5MIN}:5
	>=kde-frameworks/kjobwidgets-${KF5MIN}:5
	>=kde-frameworks/ktexteditor-${KF5MIN}:5
	>=kde-frameworks/kwidgetsaddons-${KF5MIN}:5
	>=kde-frameworks/kxmlgui-${KF5MIN}:5
	>=kde-frameworks/threadweaver-${KF5MIN}:5
	>=dev-qt/qtgui-${QT5MIN}:5
	>=dev-qt/qtnetwork-${QT5MIN}:5
	>=dev-qt/qtwidgets-${QT5MIN}:5
	dev-util/kdevelop:5=
"
DEPEND="${COMMON_DEPEND}
	>=kde-frameworks/kiconthemes-${KF5MIN}:5
	>=kde-frameworks/kitemmodels-${KF5MIN}:5
"
RDEPEND="${COMMON_DEPEND}
	dev-util/valgrind
"
