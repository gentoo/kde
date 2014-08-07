# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

EGIT_BRANCH="qt5"
inherit kde5

DESCRIPTION="KDE control module for SDDM"
HOMEPAGE="https://github.com/sddm/sddm-kcm"
EGIT_REPO_URI="git://github.com/sddm/${PN}"

LICENSE="GPL-2+"
KEYWORDS=""
IUSE=""

DEPEND="
	$(add_frameworks_dep kauth)
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kdelibs4support)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kio)
	dev-qt/qtgui:5
	dev-qt/qtquick1:5
	dev-qt/qtwidgets:5
	dev-qt/qtx11extras:5
	x11-libs/libX11
	x11-libs/libXcursor
"
RDEPEND="${DEPEND}
	x11-misc/sddm
	!kde-misc/sddm-kcm:4
"
