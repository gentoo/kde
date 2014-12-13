# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

EGIT_BRANCH="frameworks"
inherit kde5

DESCRIPTION="KDE screen management"
HOMEPAGE="https://projects.kde.org/projects/extragear/base/kscreen"
COMMIT_ID="d6380ef623501a4a97aaeac8798e424c22716988"
SRC_URI="http://quickgit.kde.org/?p=kscreen.git&a=snapshot&h=${COMMIT_ID}&fmt=tgz -> ${P}.tar.gz"
KEYWORDS="~amd64"
IUSE=""

S=${WORKDIR}/${PN}

DEPEND="
	$(add_kdeplasma_dep libkscreen)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kdbusaddons)
	$(add_frameworks_dep kglobalaccel)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_frameworks_dep kxmlgui)
	dev-qt/qtdbus:5
	dev-qt/qtdeclarative:5[widgets]
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
"
RDEPEND="
	${DEPEND}
	!kde-misc/kscreen:4
"
