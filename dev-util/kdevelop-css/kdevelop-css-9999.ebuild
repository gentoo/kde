# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

ECM_TEST="true"
KDE_ORG_NAME="kdev-css"
KF5MIN=5.60.0
QT5MIN=5.12.3
inherit ecm kde.org

DESCRIPTION="CSS Language Support plugin for KDevelop"
HOMEPAGE="https://www.kdevelop.org/"

LICENSE="GPL-2"
SLOT="5"
KEYWORDS=""
IUSE=""

BDEPEND="
	sys-devel/flex
	test? ( >=dev-util/kdevelop-5.1.80:5[test] )
"
DEPEND="
	>=kde-frameworks/kcoreaddons-${KF5MIN}:5
	>=kde-frameworks/ki18n-${KF5MIN}:5
	>=kde-frameworks/ktexteditor-${KF5MIN}:5
	>=kde-frameworks/kxmlgui-${KF5MIN}:5
	>=kde-frameworks/threadweaver-${KF5MIN}:5
	>=dev-qt/qtgui-${QT5MIN}:5
	>=dev-qt/qtwidgets-${QT5MIN}:5
	dev-util/kdevelop-pg-qt:5
	>=dev-util/kdevelop-5.1.80:5=
"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}/${PN}-tests.patch" ) # TODO: upstream
