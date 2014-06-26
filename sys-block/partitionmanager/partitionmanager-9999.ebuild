# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde4-base

DESCRIPTION="KDE utility for management of partitions and file systems"
HOMEPAGE="http://partitionman.sourceforge.net/"

LICENSE="GPL-2"
KEYWORDS=""
SLOT="0"
IUSE="debug"

RDEPEND="
	dev-libs/libatasmart
	>=sys-block/parted-3
	sys-apps/util-linux
"
DEPEND="${RDEPEND}
	sys-devel/gettext
"

src_configure() {
	local mycmakeargs=(
		-DENABLE_UDISKS2=ON
	)

	kde4-base_src_configure
}
