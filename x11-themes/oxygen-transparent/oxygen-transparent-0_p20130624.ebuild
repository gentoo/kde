# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_MINIMAL="4.10"
REV="f2f067d5542d3c7ea6d09bc8f63d5853b57db4a7"
SRC_URI="http://quickgit.kde.org/?p=${PN}.git&a=snapshot&h=${REV}&fmt=tbz2 -> ${P}.tar.bz2"

inherit kde4-base

DESCRIPTION="Oxygen style and decoration with support for transparency"
HOMEPAGE="https://projects.kde.org/projects/playground/artwork/oxygen-transparent"

LICENSE="LGPL-2+"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="debug"

S="${WORKDIR}/${PN}"

RDEPEND="
	x11-libs/libX11
"
DEPEND="${RDEPEND}
	$(add_kdebase_dep kwin)
"
