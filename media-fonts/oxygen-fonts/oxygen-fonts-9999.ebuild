# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit git-2 font
EGIT_REPO_URI="git://anongit.kde.org/oxygen-fonts"

DESCRIPTION="A Font for the KDE Desktop"
HOMEPAGE="https://projects.kde.org/"
IUSE="bold italic monospace +regular"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS=""

src_install() {
	if use monospace; then
		FONT_S="${S}/in-progress/Monospace" FONT_SUFFIX="ttf" font_src_install
		FONT_S="${S}/in-progress/Monospace/src" FONT_SUFFIX="otf sfd" font_src_install
	fi

	if use bold; then
		FONT_S="${S}/in-progress/Oxygen-Bold" FONT_SUFFIX="ttf" font_src_install
		FONT_S="${S}/in-progress/Oxygen-Bold/src" FONT_SUFFIX="otf sfd" font_src_install
	fi

	if use italic; then
		FONT_S="${S}/in-progress/Oxygen-Italic" FONT_SUFFIX="ttf" font_src_install
		FONT_S="${S}/in-progress/Oxygen-Italic/src" FONT_SUFFIX="otf sfd" font_src_install
	fi

	if use regular; then
		dodir $FONTDIR/Oxygen.ufo $FONTDIR/Oxygen.ufo/glyphs
		FONT_S="${S}/in-progress/Oxygen-Regular" FONT_SUFFIX="ttf" font_src_install
		FONT_S="${S}/in-progress/Oxygen-Regular/src" FONT_SUFFIX="otf sfd" font_src_install
		insinto $FONTDIR/
		cd in-progress/Oxygen-Regular/src && doins -r Oxygen.ufo
	fi
}
