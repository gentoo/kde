# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit kde4-base

DESCRIPTION="A DropDrawers clone. Multiple information organizer"
HOMEPAGE="http://basket.kde.org/"
SRC_URI="http://${PN}.kde.org/downloads/${P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~amd64"
SLOT="4"

IUSE="debug crypt"

DEPEND="
	>=kde-base/kdelibs-4.4.0
	>=kde-base/kdepimlibs-4.4.0
	crypt? ( >=app-crypt/gpgme-1.0 )
"
RDEPEND=${DEPEND}

PATCHES=( "${FILESDIR}/${P}-crypt.patch" )

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_enable crypt)
	)
	kde4-base_src_configure
}
