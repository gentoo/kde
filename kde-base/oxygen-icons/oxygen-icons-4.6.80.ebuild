# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

if [[ ${PV} == *9999 ]]; then
	KMNAME="kdesupport"
else
	KMNAME="oxygen-icons"
fi
KDE_REQUIRED="never"
inherit kde4-base

DESCRIPTION="Oxygen SVG icon theme."
HOMEPAGE="http://www.oxygen-icons.org/"
# Note that the upstream tarball is .bz2, ours is .xz -- if upstream
# changes its compression format to .xz, we will need to change the
# filename of one of the tarballs
[[ ${PV} == *9999 ]] || \
SRC_URI="
	!bindist? ( http://dev.gentoo.org/~jmbsvicetto/distfiles/${P}.tar.xz )
	bindist? ( ${SRC_URI//${PV}/${PV}} )
"

LICENSE="LGPL-3"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="aqua bindist"

DEPEND="
	!bindist? ( app-arch/xz-utils )
"
RDEPEND=""

# Block conflicting packages
add_blocker kdebase-data '<4.2.67'
add_blocker kdepim-icons 4.2.89
add_blocker step 4.2.98
add_blocker kmail '<4.3.2'
