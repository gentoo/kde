# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_TEST="forceoptional"
KDE_ORG_CATEGORY="kdevelop"
KDE_ORG_NAME="kdev-krazy2"
KFMIN=5.82.0
QTMIN=5.15.5
VIRTUALX_REQUIRED="test"
inherit ecm kde.org

DESCRIPTION="Plugin for KDevelop to perform Krazy2 analysis"
HOMEPAGE="https://kdevelop.org/"

LICENSE="GPL-2+"
SLOT="5"
KEYWORDS=""
IUSE=""

RDEPEND="
	>=dev-qt/qtgui-${QTMIN}:5
	>=dev-qt/qtwidgets-${QTMIN}:5
	dev-util/kdevelop:5=
	>=kde-frameworks/kconfig-${KFMIN}:5
	>=kde-frameworks/kcoreaddons-${KFMIN}:5
	>=kde-frameworks/ki18n-${KFMIN}:5
	>=kde-frameworks/kio-${KFMIN}:5
	>=kde-frameworks/kitemmodels-${KFMIN}:5
	>=kde-frameworks/ktexteditor-${KFMIN}:5
	>=kde-frameworks/kxmlgui-${KFMIN}:5
"
DEPEND="${RDEPEND}
	>=kde-frameworks/threadweaver-${KFMIN}:5
"
