# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils git-r3

DESCRIPTION="KDE libraries, adapted to compile on modern systems (circa. 2016)"
HOMEPAGE="https://quickgit.kde.org/?p=kde1-kdelibs.git"
EGIT_REPO_URI="git://anongit.kde.org/${PN}.git"

LICENSE="GPL-2+ LGPL-2+"
SLOT="0"
KEYWORDS=""
IUSE="+debug"

DEPEND="
	dev-qt/qt1
	media-libs/libpng:0=
	media-libs/tiff:0
	virtual/jpeg:0
	x11-libs/libX11
	x11-libs/libXext
"
RDEPEND="${DEPEND}"
