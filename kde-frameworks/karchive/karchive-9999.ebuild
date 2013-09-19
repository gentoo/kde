# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

FRAMEWORKS_TYPE="tier1"
inherit kde-frameworks

DESCRIPTION="Easy packing and unpacking of files in various archive formats"
LICENSE="LGPL-2.1"
KEYWORDS=""
IUSE="+bzip2 lzma"

RDEPEND="
	bzip2? ( app-arch/bzip2 )
	lzma? ( app-arch/lzma )
	sys-libs/zlib
"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_find_package bzip2 BZip2)
		$(cmake-utils_use_find_package lzma LibLZMA)
	)

	kde-frameworks_src_configure
}
