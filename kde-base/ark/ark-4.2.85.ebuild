# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdeutils"
inherit kde4-meta

DESCRIPTION="KDE Archiving tool"
KEYWORDS="~amd64 ~x86"
IUSE="+archive debug doc +zip"

DEPEND="
	>=kde-base/libknotificationitem-${PV}:${SLOT}[kdeprefix=]
	archive? ( >=app-arch/libarchive-2.6.1[bzip2,lzma,zlib] )
	zip? ( >=dev-libs/libzip-0.8 )
"
RDEPEND="${DEPEND}"

src_configure() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with archive LibArchive)
		$(cmake-utils_use_with zip LibZip)"

	kde4-meta_src_configure
}
