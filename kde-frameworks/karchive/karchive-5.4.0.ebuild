# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-frameworks/karchive/karchive-5.3.0.ebuild,v 1.1 2014/10/15 13:29:47 kensington Exp $

EAPI=5

inherit kde5

DESCRIPTION="Framework for easy reading, creation, and manipulation of various archive formats"
LICENSE="GPL-2 LGPL-2.1"
KEYWORDS=" ~amd64"
IUSE="+bzip2 +lzma"

RDEPEND="
	bzip2? ( app-arch/bzip2 )
	lzma? ( app-arch/xz-utils )
	sys-libs/zlib
"
DEPEND="${RDEPEND}"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_find_package bzip2 BZip2)
		$(cmake-utils_use_find_package lzma LibLZMA)
	)

	kde5_src_configure
}
