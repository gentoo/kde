# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

KDE_ORG_NAME="kdev-embedded"
KF5MIN=5.60.0
QT5MIN=5.12.3
inherit ecm kde.org

DESCRIPTION="Plugin for KDevelop to support the development of embedded systems"
HOMEPAGE="https://www.kdevelop.org/"

LICENSE="GPL-2" # TODO: CHECK
SLOT="5"
IUSE=""

DEPEND="
	>=kde-frameworks/karchive-${KF5MIN}:5
	>=kde-frameworks/kcompletion-${KF5MIN}:5
	>=kde-frameworks/kconfig-${KF5MIN}:5
	>=kde-frameworks/kcoreaddons-${KF5MIN}:5
	>=kde-frameworks/ki18n-${KF5MIN}:5
	>=kde-frameworks/kitemmodels-${KF5MIN}:5
	>=kde-frameworks/knewstuff-${KF5MIN}:5
	>=kde-frameworks/kparts-${KF5MIN}:5
	>=kde-frameworks/ktexteditor-${KF5MIN}:5
	>=kde-frameworks/kwidgetsaddons-${KF5MIN}:5
	>=kde-frameworks/kxmlgui-${KF5MIN}:5
	>=kde-frameworks/solid-${KF5MIN}:5
	>=kde-frameworks/threadweaver-${KF5MIN}:5
	>=dev-qt/qtgui-${QT5MIN}:5
	>=dev-qt/qtnetwork-${QT5MIN}:5
	>=dev-qt/qtwidgets-${QT5MIN}:5
	dev-util/kdevelop-pg-qt:5
	dev-util/kdevelop:5=
"
RDEPEND="${DEPEND}"
