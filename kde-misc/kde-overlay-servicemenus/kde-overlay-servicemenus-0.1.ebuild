# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

CMAKE_REQUIRED="never"
KDE_REQUIRED="never"
inherit kde4-base

DESCRIPTION="Miscellaneous KDE4 servicemenus used for Gentoo KDE overlay development"
HOMEPAGE="http://dev.gentoo.org/~reavertm/"
SRC_URI="http://dev.gentoo.org/~reavertm/${P}.tar.xz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"
SLOT="4"
IUSE="debug"

RDEPEND="
	$(add_kdebase_dep kdialog)
	$(add_kdebase_dep kompare)
	|| (
		( $(add_kdebase_dep dolphin) )
		( $(add_kdebase_dep konqueror) )
	)
"

src_install() {
	insinto "${PREFIX}/share/kde4/services/ServiceMenus/"

	# Compare/merge
	doins "${S}"/compareMerge.desktop
	dobin "${S}"/compare-merge
}
