# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

EGIT_REPO_URI="git://git.kde.org/yakuake.git"

inherit git kde4-base

DESCRIPTION="A quake-style terminal emulator based on KDE konsole technology"
HOMEPAGE="http://yakuake.kde.org/"

LICENSE="GPL-2 LGPL-2"
KEYWORDS=""
SLOT="4"
IUSE="debug"

RDEPEND="
	!kde-misc/yakuake:0
	!kde-misc/yakuake:4.1
	$(add_kdebase_dep konsole)
"

src_unpack() {
	git_src_unpack
}
