# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_BRANCH="frameworks"
ECM_HANDBOOK="forceoptional"
KDE_ORG_CATEGORY="unmaintained"
KFMIN=5.82.0
QTMIN=5.15.5
inherit ecm kde.org

DESCRIPTION="Application to generate publication-ready figures"
HOMEPAGE="https://wwwu.uni-klu.ac.at/magostin/cirkuit.html"
[[ ${KDE_BUILD_TYPE} = live ]] || SRC_URI="https://wwwu.uni-klu.ac.at/magostin/src/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="5"
KEYWORDS=""
IUSE=""

DEPEND="
	app-text/poppler[qt5]
	>=dev-qt/qtdeclarative-${QTMIN}:5
	>=dev-qt/qtgui-${QTMIN}:5
	>=dev-qt/qtwidgets-${QTMIN}:5
	>=kde-frameworks/karchive-${KFMIN}:5
	>=kde-frameworks/kcompletion-${KFMIN}:5
	>=kde-frameworks/kconfig-${KFMIN}:5
	>=kde-frameworks/kconfigwidgets-${KFMIN}:5
	>=kde-frameworks/kcoreaddons-${KFMIN}:5
	>=kde-frameworks/kdbusaddons-${KFMIN}:5
	>=kde-frameworks/kdelibs4support-${KFMIN}:5
	>=kde-frameworks/kguiaddons-${KFMIN}:5
	>=kde-frameworks/ki18n-${KFMIN}:5
	>=kde-frameworks/kio-${KFMIN}:5
	>=kde-frameworks/knewstuff-${KFMIN}:5
	>=kde-frameworks/kparts-${KFMIN}:5
	>=kde-frameworks/kservice-${KFMIN}:5
	>=kde-frameworks/ktexteditor-${KFMIN}:5
	>=kde-frameworks/ktextwidgets-${KFMIN}:5
	>=kde-frameworks/kwidgetsaddons-${KFMIN}:5
	>=kde-frameworks/kxmlgui-${KFMIN}:5
"
RDEPEND="${DEPEND}
	app-text/ghostscript-gpl
	app-text/ps2eps
	dev-texlive/texlive-pstricks
	media-gfx/dpic
	media-gfx/pdf2svg
	media-libs/netpbm
	virtual/latex-base
"

DOCS=( Changelog README )
