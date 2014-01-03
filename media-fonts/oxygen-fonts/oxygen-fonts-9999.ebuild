# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit font git-r3

DESCRIPTION="Desktop/GUI font family for integrated use with the KDE desktop"
HOMEPAGE="https://projects.kde.org/projects/playground/artwork/oxygen-fonts"
EGIT_REPO_URI=( "git://anongit.kde.org/oxygen-fonts" )
EGIT_BRANCH="in-progress"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS=""
IUSE=""

src_install() {
	FONTS="Bold Mono Regular"
	FONT_SUFFIX="ttf"

	for f in ${FONTS} ; do
		FONT_S="${S}/${f}" font_src_install
	done
}
