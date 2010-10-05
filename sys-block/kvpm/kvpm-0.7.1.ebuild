# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit kde4-base

DESCRIPTION="KDE front end for Linux LVM2 and Gnu parted."
HOMEPAGE="http://kvpm.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86"
SLOT="4"
IUSE="debug"

RDEPEND="
	>=sys-block/parted-1.8
	>=sys-fs/lvm2-2.02.73
	sys-libs/e2fsprogs-libs
"
DEPEND="${RDEPEND}"

CMAKE_USE_DIR=${S}/${PN}

src_configure() {
	mycmakeargs=(
		-DPARTMAN_KPART=ON
		-DPARTMAN_KCM=ON
	)

	kde4-base_src_configure
}
