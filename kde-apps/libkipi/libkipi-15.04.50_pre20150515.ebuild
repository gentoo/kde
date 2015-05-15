# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

EGIT_BRANCH="frameworks"
KDE_TEST="true"
inherit kde5 git-r3

DESCRIPTION="A library for image plugins accross KDE applications"
KEYWORDS=" ~amd64 ~x86"
IUSE=""

EGIT_REPO_URI="git://anongit.kde.org/${PN}"
EGIT_COMMIT="1a656885dd94a1d2db4e99efe066f5296f8c114c"
SRC_URI=""

DEPEND="
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kxmlgui)
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
"

RDEPEND="${DEPEND}"

src_unpack() {
	git-r3_src_unpack
}
