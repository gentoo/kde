# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

EGIT_BRANCH="5.0"
KDEBASE="kdevelop"
KMNAME="kdev-python"
PYTHON_COMPAT=( python3_5 )
inherit kde5 python-any-r1

DESCRIPTION="Python plugin for KDevelop 5"
IUSE=""

DEPEND="
	$(add_frameworks_dep kcompletion)
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep kitemmodels)
	$(add_frameworks_dep knewstuff)
	$(add_frameworks_dep kparts)
	$(add_frameworks_dep ktexteditor)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_frameworks_dep kxmlgui)
	$(add_frameworks_dep threadweaver)
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	dev-util/kdevplatform:5
	${PYTHON_DEPS}
"
RDEPEND="${DEPEND}
	dev-util/kdevelop:5
"

RESTRICT="test"

pkg_setup() {
	python-any-r1_pkg_setup
	kde5_pkg_setup
}

src_compile() {
	pushd "${WORKDIR}"/${P}_build > /dev/null || die
	emake parser
	popd > /dev/null || die

	kde5_src_compile
}
