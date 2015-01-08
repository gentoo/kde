# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
KDE_REQUIRED=optional

inherit kde4-base

DESCRIPTION="DBus analyzer with optional KDE client"
EGIT_REPO_URI="git://anongit.kde.org/scratch/ahartmetz/d-sel.git"
HOMEPAGE="http://www.kde.org/"
# found nothing better

LICENSE="LGPL-2.1 MPL-1.1"
SLOT="4"
KEYWORDS=""
IUSE="debug kde"

DEPEND="
	kde? ( dev-libs/tinyxml2 )
"
RDEPEND="
	${DEPEND}
"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_build kde DSEL_BUILD_DSELRIG)
	)
	kde4-base_src_configure
}
