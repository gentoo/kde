# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

KDE_ORG_NAME="kdev-upload"
KF5MIN=5.60.0
QT5MIN=5.12.3
inherit ecm kde.org

DESCRIPTION="Plugin for uploading files to a remote server"
HOMEPAGE="https://www.kdevelop.org/"

LICENSE="GPL-2"
SLOT="5"
KEYWORDS=""
IUSE=""

DEPEND="
	>=kde-frameworks/kcmutils-${KF5MIN}:5
	>=kde-frameworks/kcompletion-${KF5MIN}:5
	>=kde-frameworks/kconfig-${KF5MIN}:5
	>=kde-frameworks/kconfigwidgets-${KF5MIN}:5
	>=kde-frameworks/kcoreaddons-${KF5MIN}:5
	>=kde-frameworks/ki18n-${KF5MIN}:5
	>=kde-frameworks/kio-${KF5MIN}:5
	>=kde-frameworks/kjobwidgets-${KF5MIN}:5
	>=kde-frameworks/kwidgetsaddons-${KF5MIN}:5
	>=kde-frameworks/kxmlgui-${KF5MIN}:5
	>=dev-qt/qtgui-${QT5MIN}:5
	>=dev-qt/qtwidgets-${QT5MIN}:5
	dev-util/kdevelop:5=
"
RDEPEND="${DEPEND}"
