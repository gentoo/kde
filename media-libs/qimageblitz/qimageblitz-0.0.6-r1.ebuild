# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/qimageblitz/qimageblitz-0.0.6.ebuild,v 1.9 2012/05/17 13:03:37 aballier Exp $

EAPI=5

inherit cmake-utils

DESCRIPTION="A graphical effect and filter library for KDE4"
HOMEPAGE="http://websvn.kde.org/trunk/kdesupport/qimageblitz/"
SRC_URI="mirror://kde/stable/${PN}/${P}.tar.bz2"

LICENSE="GPL-2 LGPL-2"
KEYWORDS="~amd64 ~arm ~hppa ~ppc ~ppc64 ~x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~x86-macos ~x86-solaris"
SLOT="0"
IUSE="3dnow altivec debug mmx sse sse2"

DEPEND="
	x11-libs/qt-core:4
	x11-libs/qt-gui:4
"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}/${PN}-9999-exec-stack.patch"
	"${FILESDIR}/${P}-gcc.patch"
)

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_has 3dnow)
		$(cmake-utils_use_has altivec)
		$(cmake-utils_use_has mmx)
		$(cmake-utils_use_has sse)
		$(cmake-utils_use_has sse2)
	)
	cmake-utils_src_configure
}
