# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

EGIT_BRANCH="frameworks"
inherit kde5 git-r3

DESCRIPTION="KDE digital camera raw image library wrapper"
KEYWORDS=" ~amd64 ~x86"
IUSE=""

EGIT_REPO_URI="git://anongit.kde.org/${PN}"
EGIT_COMMIT="9850efbb21df2f10e66267876574ff8918a642b3"
SRC_URI=""

DEPEND="
	$(add_frameworks_dep kcompletion)
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kdelibs4support)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kiconthemes)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep kservice)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_frameworks_dep threadweaver)
	>=media-libs/libraw-0.16:=
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
"
RDEPEND="${DEPEND}"

src_unpack() {
	git-r3_src_unpack
}
