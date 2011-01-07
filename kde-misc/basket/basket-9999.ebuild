# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit git kde4-base

DESCRIPTION="A DropDrawers clone. Multiple information organizer"
HOMEPAGE="http://basket.kde.org/"
EGIT_REPO_URI="git://gitorious.org/basket/basket.git"

LICENSE="GPL-2"
KEYWORDS=""
SLOT="4"

IUSE="debug crypt"

PATCHES=( "${FILESDIR}/${P}-crypt.patch" )

src_unpack() {
	git_src_unpack
}

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_enable crypt)
	)
	kde4-base_src_configure
}
