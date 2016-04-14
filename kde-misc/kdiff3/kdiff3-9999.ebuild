# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

EGIT_BRANCH="kf5"
inherit kde5

DESCRIPTION="Frontend to diff3 based on Qt/KF5"
HOMEPAGE="http://kdiff3.sourceforge.net/"
EGIT_REPO_URI="git://anongit.kde.org/scratch/thomasfischer/${PN}"

LICENSE="GPL-2"
KEYWORDS=""
IUSE=""

CDEPEND="
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kiconthemes)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep kparts)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_frameworks_dep kxmlgui)
	$(add_qt_dep qtcore)
	$(add_qt_dep qtgui)
	$(add_qt_dep qtprintsupport)
	$(add_qt_dep qtwidgets)
"
DEPEND="${CDEPEND}
	sys-devel/gettext
"
RDEPEND="${CDEPEND}
	sys-apps/diffutils
	!kde-misc/kdiff3:4
"

src_unpack(){
	if [[ ${KDE_BUILD_TYPE} = live ]]; then
		git-r3_src_unpack
		mv "${S}"/${PN}/* "${S}" || die
	else
		kde5_src_unpack
	fi
}
