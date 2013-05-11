# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
KDE_DOC_DIRS="docbook"
KDE_HANDBOOK="optional"

inherit kde4-base

MY_P=${P/_p/-pl}

DESCRIPTION="KDE front end for Linux LVM2 and Gnu parted."
HOMEPAGE="http://kvpm.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86"
SLOT="4"
IUSE="debug"

RDEPEND="
	sys-apps/util-linux
	>=sys-block/parted-2.3
	>=sys-fs/lvm2-2.02.88
"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${MY_P}
