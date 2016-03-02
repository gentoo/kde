# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

CMAKE_MIN_VERSION="3.1.0"
EGIT_BRANCH="frameworks"
KDE_HANDBOOK="forceoptional"
inherit kde5

DESCRIPTION="A frontend to the subversion vcs"
HOMEPAGE="http://kdesvn.alwins-world.de/ https://projects.kde.org/projects/extragear/sdk/kdesvn"
if [[ ${PV} != 9999* ]]; then
	SRC_URI="mirror://kde/stable/${PN}/${PV}/${P}.tar.xz"
fi

LICENSE="GPL-2"
KEYWORDS=""
IUSE="+man"

DEPEND="
	$(add_frameworks_dep kbookmarks)
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kdbusaddons)
	$(add_frameworks_dep kdelibs4support)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kitemviews)
	$(add_frameworks_dep kjobwidgets)
	$(add_frameworks_dep kparts)
	$(add_frameworks_dep kservice)
	$(add_frameworks_dep ktexteditor)
	$(add_frameworks_dep kwallet)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_qt_dep qtdbus)
	$(add_qt_dep qtgui)
	$(add_qt_dep qtsql 'sqlite')
	$(add_qt_dep qtwidgets)
	dev-libs/apr:1
	dev-libs/apr-util:1
	>=dev-vcs/subversion-1.7
"
RDEPEND="${DEPEND}
	!dev-vcs/kdesvn:4
	!kde-apps/kdesdk-kioslaves:4[subversion(+)]
"

src_prepare(){
	kde5_src_prepare

	if ! use man ; then
		sed -i -e "/kdoctools_create_manpage/ s/^/#/" doc/CMakeLists.txt || die
	fi
}
