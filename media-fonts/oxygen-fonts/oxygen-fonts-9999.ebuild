# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit git-2 font
EGIT_REPO_URI="git://anongit.kde.org/oxygen-fonts"

DESCRIPTION="A Font for the KDE Desktop"
HOMEPAGE="https://projects.kde.org/"
IUSE="bold flab-old monospace +regular"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS=""

src_install() {
	if use flab-old; then
		FONT_S="${S}/Fontlab-Old" FONT_SUFFIX="vfb" font_src_install
	fi

	if use monospace; then
		FONT_S="${S}/Monospace" FONT_SUFFIX="otf ttf" font_src_install
	fi

	if use bold; then
		FONT_S="${S}/Oxygen-Bold" FONT_SUFFIX="otf ttf sfd" font_src_install
	fi

	if use regular; then
		dodir $FONTDIR/Brand $FONTDIR/hinting $FONTDIR/Oxygen.ufo $FONTDIR/Oxygen.ufo/glyphs
		FONT_S="${S}/Oxygen-Regular" FONT_SUFFIX="ttf sfd" font_src_install
		insinto $FONTDIR/Brand
		doins Oxygen-Regular/Brand/Oxygen.sfd
		insinto $FONTDIR/hinting
		doins Oxygen-Regular/hinting/OxygenVTT.ttf
		insinto $FONTDIR/
		cd Oxygen-Regular && doins -r Oxygen.ufo
	fi
}
