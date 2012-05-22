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

S="${WORKDIR}/${P}/in-progress"

src_install() {
	if use monospace; then
		FONT_S="${S}/Monospace" FONT_SUFFIX="ttf" font_src_install
		FONT_S="${S}/Monospace/src" FONT_SUFFIX="otf sfd" font_src_install
	fi

	if use bold; then
		FONT_S="${S}/Oxygen-Bold" FONT_SUFFIX="ttf" font_src_install
		FONT_S="${S}/Oxygen-Bold/src" FONT_SUFFIX="otf sfd" font_src_install
	fi

	if use italic; then
		FONT_S="${S}/Oxygen-Italic" FONT_SUFFIX="ttf" font_src_install
		FONT_S="${S}/Oxygen-Italic/src" FONT_SUFFIX="otf sfd" font_src_install
	fi

	if use regular; then
		dodir $FONTDIR/Oxygen.ufo $FONTDIR/Oxygen.ufo/glyphs
		FONT_S="${S}/Oxygen-Regular" FONT_SUFFIX="ttf" font_src_install
		FONT_S="${S}/Oxygen-Regular/src" FONT_SUFFIX="otf sfd" font_src_install
		insinto $FONTDIR/
		cd Oxygen-Regular/src && doins -r Oxygen.ufo
	fi
}
