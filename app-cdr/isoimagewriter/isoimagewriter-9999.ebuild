# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit kde5

DESCRIPTION="Write hybrid ISO files onto a USB disk"
HOMEPAGE="http://wiki.rosalab.com/en/index.php/Blog:ROSA_Planet/ROSA_Image_Writer"

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
