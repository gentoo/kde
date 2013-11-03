# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

if [[ $PV == 9999 ]]; then
	KDE_MINIMAL=9999
else
	KDE_MINIMAL=${PV/\.9999/}
	EGIT_BRANCH="KDE/${KDE_MINIMAL}"
fi

inherit kde4-base

DESCRIPTION="Oxygen style and decoration with support for transparency"
HOMEPAGE="https://projects.kde.org/projects/playground/artwork/oxygen-transparent"

LICENSE="LGPL-2+"
KEYWORDS=""
SLOT="0"
IUSE="debug"

RDEPEND="
	x11-libs/libX11
"
DEPEND="${RDEPEND}
	$(add_kdebase_dep kwin)
"
