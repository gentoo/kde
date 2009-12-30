# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

if [[ ${PV} = *9999* ]]; then
	KMNAME="extragear/utils"
	eclass="kde4-meta"
else
	eclass="kde4-base"
	SRC_URI="mirror://sourceforge/kdiff3/${P}.tar.gz"
fi
inherit ${eclass}

DESCRIPTION="KDE-based frontend to diff3"
HOMEPAGE="http://kdiff3.sourceforge.net/"

LICENSE="GPL-2"
KEYWORDS=""
SLOT="4"
IUSE="debug +handbook konqueror"

DEPEND="
	konqueror? ( >=kde-base/libkonq-${KDE_MINIMAL} )
"
RDEPEND="${DEPEND}
	sys-apps/diffutils
	konqueror? ( >=kde-base/konqueror-${KDE_MINIMAL} )
"

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with konqueror LibKonq)
	)

	${eclass}_src_configure
}
