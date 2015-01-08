# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/oxygen-fonts/oxygen-fonts-5.1.0.1.ebuild,v 1.1 2014/10/15 13:34:23 kensington Exp $

EAPI=5

inherit cmake-utils font

DESCRIPTION="Desktop/GUI font family for integrated use with the KDE desktop"
HOMEPAGE="https://projects.kde.org/projects/kde/workspace/oxygen-fonts"
SRC_URI="mirror://kde/stable/plasma/${PV}/${P}.tar.xz"

LICENSE="OFL-1.1"
SLOT="5"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
	dev-libs/extra-cmake-modules
	media-gfx/fontforge
"
RDEPEND="!media-fonts/oxygen-fonts"

src_configure() {
	local mycmakeargs=(
		-DOXYGEN_FONT_INSTALL_DIR="${FONTDIR}"
	)

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	font_src_install
}
