# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

VIRTUALX_REQUIRED="test"
inherit kde4-base

DESCRIPTION="A DropDrawers clone. Multiple information organizer"
HOMEPAGE="http://basket.kde.org/"
EGIT_REPO_URI="git://github.com/kelvie/basket.git"

LICENSE="GPL-2"
KEYWORDS=""
SLOT="4"
IUSE="debug crypt"

DEPEND="
	$(add_kdeapps_dep kdepimlibs)
	media-libs/qimageblitz
	x11-libs/libX11
	crypt? ( >=app-crypt/gpgme-1.0 )
"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_find_package crypt Gpgme)
	)
	kde4-base_src_configure
}
