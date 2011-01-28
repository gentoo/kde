# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

CMAKE_REQUIRED="never"
KDE_REQUIRED="never"
inherit kde4-base

DESCRIPTION="Miscellaneous KDE4 servicemenus used for Gentoo KDE overlay development"
HOMEPAGE="http://dev.gentoo.org/~reavertm/"
SRC_URI="http://dev.gentoo.org/~reavertm/${P}.tar.xz"

LICENSE="GPL-2"
KEYWORDS="amd64 ppc x86"
SLOT="0"
IUSE=""

RDEPEND="
	>=kde-base/kdialog-${KDE_MINIMAL}
	>=kde-base/kompare-${KDE_MINIMAL}
	|| (
		>=kde-base/dolphin-${KDE_MINIMAL}
		>=kde-base/konqueror-${KDE_MINIMAL}
	)
"

src_install() {
	insinto "${PREFIX}/share/kde4/services/ServiceMenus/"

	# Compare/merge
	doins "${S}"/compareMerge.desktop
	dobin "${S}"/compare-merge
}
