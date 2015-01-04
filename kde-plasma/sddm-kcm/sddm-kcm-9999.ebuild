# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde5

DESCRIPTION="KDE control module for SDDM"
HOMEPAGE="https://projects.kde.org/projects/kdereview/sddm-kcm"

LICENSE="GPL-2+"
KEYWORDS=""
IUSE=""

DEPEND="
	$(add_frameworks_dep kauth)
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kio)
	dev-qt/qtcore:5
	dev-qt/qtdeclarative:5
	dev-qt/qtwidgets:5
	dev-qt/qtx11extras:5
	x11-libs/libX11
	x11-libs/libXcursor
"
RDEPEND="${DEPEND}
	x11-misc/sddm
	!kde-misc/sddm-kcm:4
"
