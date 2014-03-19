# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils font git-r3

DESCRIPTION="Desktop/GUI font family for integrated use with the KDE desktop"
HOMEPAGE="https://projects.kde.org/projects/playground/artwork/oxygen-fonts"
EGIT_REPO_URI="git://anongit.kde.org/oxygen-fonts"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="dev-libs/extra-cmake-modules"

src_install() {
	cmake-utils_src_install

	# move cmake-installed fonts to the font.eclass location
	mv "${D}"/usr/share/fonts/{oxygen,${PN}} || die

	font_src_install
}
