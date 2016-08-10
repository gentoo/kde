# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit kde5

DESCRIPTION="QRCode and data matrix barcode library"
HOMEPAGE="https://quickgit.kde.org/?p=prison.git"

LICENSE="GPL-2"
KEYWORDS=""
IUSE=""

DEPEND="
	$(add_qt_dep qtgui)
	media-gfx/qrencode
	media-libs/libdmtx
"
RDEPEND="${DEPEND}"
