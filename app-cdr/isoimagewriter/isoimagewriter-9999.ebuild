# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

KMNAME="imagewriter"
inherit kde5

DESCRIPTION="Write hybrid ISO files onto a USB disk"
HOMEPAGE="https://cgit.kde.org/imagewriter.git/"

LICENSE="GPL-3"
KEYWORDS=""
IUSE=""

DEPEND="
	$(add_frameworks_dep kauth)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep ki18n)
	$(add_qt_dep qtgui)
	$(add_qt_dep qtwidgets)
"
RDEPEND="${DEPEND}"
