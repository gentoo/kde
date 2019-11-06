# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

ECM_TEST="forceoptional"
KDE_ORG_NAME="kdev-krazy2"
KF5MIN=5.60.0
QT5MIN=5.12.3
VIRTUALX_REQUIRED="test"
inherit ecm kde.org

DESCRIPTION="Plugin for KDevelop to perform Krazy2 analysis"
HOMEPAGE="https://www.kdevelop.org/"

LICENSE="GPL-2+"
SLOT="5"
KEYWORDS=""
IUSE=""

RDEPEND="
	>=kde-frameworks/kconfig-${KF5MIN}:5
	>=kde-frameworks/kcoreaddons-${KF5MIN}:5
	>=kde-frameworks/ki18n-${KF5MIN}:5
	>=kde-frameworks/kio-${KF5MIN}:5
	>=kde-frameworks/ktexteditor-${KF5MIN}:5
	>=kde-frameworks/kxmlgui-${KF5MIN}:5
	>=dev-qt/qtgui-${QT5MIN}:5
	>=dev-qt/qtwidgets-${QT5MIN}:5
	dev-util/kdevelop:5=
"
DEPEND="${RDEPEND}
	>=kde-frameworks/kdelibs4support-${KF5MIN}:5
	>=kde-frameworks/threadweaver-${KF5MIN}:5
"
