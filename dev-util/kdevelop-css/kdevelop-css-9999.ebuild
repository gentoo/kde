# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

ECM_TEST="true"
KDE_ORG_CATEGORY="kdevelop"
KDE_ORG_NAME="kdev-css"
KFMIN=5.77.0
QTMIN=5.15.2
inherit ecm kde.org

DESCRIPTION="CSS Language Support plugin for KDevelop"
HOMEPAGE="https://kdevelop.org/"

LICENSE="GPL-2"
SLOT="5"
KEYWORDS=""
IUSE=""

BDEPEND="
	sys-devel/flex
	test? ( >=dev-util/kdevelop-5.1.80:5[test] )
"
DEPEND="
	>=dev-qt/qtgui-${QTMIN}:5
	>=dev-qt/qtwidgets-${QTMIN}:5
	dev-util/kdevelop-pg-qt:5
	>=dev-util/kdevelop-5.1.80:5=
	>=kde-frameworks/kcoreaddons-${KFMIN}:5
	>=kde-frameworks/ki18n-${KFMIN}:5
	>=kde-frameworks/ktexteditor-${KFMIN}:5
	>=kde-frameworks/kxmlgui-${KFMIN}:5
	>=kde-frameworks/threadweaver-${KFMIN}:5
"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}/${PN}-tests.patch" ) # TODO: upstream
