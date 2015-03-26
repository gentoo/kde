# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

EGIT_BRANCH="frameworks"
inherit kde5

DESCRIPTION="QRCode and data matrix barcode library"
HOMEPAGE="https://projects.kde.org/projects/kdesupport/prison"

LICENSE="GPL-2"
KEYWORDS=""
IUSE=""

DEPEND="
	dev-qt/qtgui:5
	media-gfx/qrencode
	media-libs/libdmtx
"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}/${PN}-disable-testapp.patch" )

src_configure() {
	local mycmakeargs=(-DQT5_BUILD=TRUE)

	kde5_src_configure
}
